import pandas as pd
import RPi.GPIO as GPIO
from datetime import datetime
from time import sleep
from threading import Thread
from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot

# GPIO pins for relays (defined in sequence 1-16)
relay_pins = {2: "R1", 3: "R2", 4: "R3", 5: "R4", 6: "R5", 7: "R6", 8: "R7", 9: "R8",
              10: "R9", 11: "R10", 12: "R11", 13: "R12", 14: "R13", 15: "R14", 16: "R15", 17: "R16"}

input_pins = {18: "BtnA",
              19: "BtnB",
              20: "BtnC"}

program_list = ['./ProgramA.csv',
                './ProgramB.csv',
                './ProgramC.csv']


class BackendController(QObject):

    programFinished = pyqtSignal()
    gpioInputStateChanged = pyqtSignal(str)
    relayStateChanged = pyqtSignal(str, bool)

    def __init__(self, parent=None):
        super().__init__(parent)

        # Initialize GPIO pins (Set mode to BCM and define direction)
        self.initialize_gpio()
        self.m_current_program = ""
        self.m_stop_thread = True

        self.m_stop_gpio_monitoring = False
        self.gpio_monitor_thread = Thread(target=self.monitor_gpio_inputs, args=())
        self.gpio_monitor_thread.start()

        print("Backend init complete")

    def monitor_gpio_inputs(self):

        prev_state_btn_a = GPIO.HIGH
        prev_state_btn_b = GPIO.HIGH
        prev_state_btn_c = GPIO.HIGH
        toggle_on_state = GPIO.LOW
        toggle_off_state = GPIO.HIGH

        while not self.m_stop_gpio_monitoring:
            if GPIO.input(list(input_pins)[0]) is toggle_on_state and prev_state_btn_a is toggle_off_state:
                self.gpioInputStateChanged.emit(list(input_pins.values())[0])

            if GPIO.input(list(input_pins)[1]) is toggle_on_state and prev_state_btn_b is toggle_off_state:
                self.gpioInputStateChanged.emit(list(input_pins.values())[1])

            if GPIO.input(list(input_pins)[2]) is toggle_on_state and prev_state_btn_c is toggle_off_state:
                self.gpioInputStateChanged.emit(list(input_pins.values())[2])

            prev_state_btn_a = GPIO.input(list(input_pins)[0])
            prev_state_btn_b = GPIO.input(list(input_pins)[1])
            prev_state_btn_c = GPIO.input(list(input_pins)[2])
            sleep(0.1)

    def threaded_relay_control(self, program_id):
        # Read Relay Timing Info CSV file
        self.m_current_program = program_list[program_id]
        df = pd.read_csv(self.m_current_program)

        # Iterate through rows and control relays
        for index, row in df.iterrows():

            if self.m_stop_thread:
                break

            time = row['Time']
            for i, relay_state in enumerate(row[1:]):  # Start from the second column

                if self.m_stop_thread:
                    break

                relay_pin = list(relay_pins)[i]
                relay_id = list(relay_pins.values())[i]

                if relay_state == 'On':
                    GPIO.output(relay_pin, GPIO.HIGH)
                    self.relayStateChanged.emit(relay_id, True)
                else:
                    GPIO.output(relay_pin, GPIO.LOW)
                    self.relayStateChanged.emit(relay_id, False)

            # Check if it's not the last row and the next time is not empty
            if index < len(df) - 1:
                next_time = df.loc[index + 1, 'Time']
                if not pd.isna(next_time):
                    try:
                        current_time = datetime.strptime(time, '%M:%S')
                        next_time = datetime.strptime(next_time, '%M:%S')
                        time_difference = (next_time - current_time).total_seconds()

                        # Sleep for the calculated time difference
                        sleep(time_difference)
                    except:
                        print("Wrong Time Format in CSV, Skipping to next...")
                else:
                    # Exit the loop if the next time is empty
                    break

        print("Program Complete!")
        self.programFinished.emit()

    @pyqtSlot(int)
    def start_relay_program(self, program_id):
        self.m_stop_thread = False
        relay_control_thread = Thread(target=self.threaded_relay_control, args=(program_id,))
        relay_control_thread.start()

    @pyqtSlot()
    def initialize_gpio(self):
        GPIO.setmode(GPIO.BCM)
        GPIO.VERBOSE = False
        for pin in relay_pins:
            GPIO.setup(pin, GPIO.OUT)

        for pin in input_pins:
            GPIO.setup(pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

    @pyqtSlot()
    def rest_gpio(self):
        self.m_stop_thread = True
        for pin in relay_pins.keys():
            relay_id = relay_pins[pin]
            GPIO.output(pin, False)
            self.relayStateChanged.emit(relay_id, False)

    @pyqtSlot()
    def close_app(self):
        self.m_stop_thread = True
        self.m_stop_gpio_monitoring = True
        GPIO.cleanup()
