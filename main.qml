import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "Assets/Components/CardItem"
import "Assets/Components/BaseComponents"

Window {
    id: appRoot
    width: 1920
    height: 1080
    visible: true
    visibility: Window.FullScreen
    flags: Qt.FramelessWindowHint
    title: qsTr("Relay Board Controler")

    //-------------- Custom Responsiveness Controll Functions --------------//

    property int baseWidth: 1440
    property int baseHeight: 900
    property real baseAvg: Math.hypot(baseWidth, baseHeight)

    function respWidth(w) {
        return appRoot.width * (w/baseWidth);
    }

    function respHeight(h) {
        return appRoot.height * (h/baseHeight);
    }

    function respAvg(a) {
        var assetAvg = (respWidth(a) + respHeight(a)) / 2;
        return Math.round(assetAvg);
    }

    //----------------------------------------------------------------------//

    Rectangle {
        id: windowBackground
        width: 200
        height: 500
        anchors.fill: parent
        color: "#F4F4F4"
    }

    Label {
        id: pageTitle
        text: "Relay Board Controller"
        color: "#1B1B1B"
        font.family: "Poppins"
        font.pixelSize: respAvg(36)
        font.weight: Font.ExtraBold

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: respAvg(47)
        anchors.leftMargin: respAvg(66)
    }

    CardItem {
        id: programSelect
        width: respWidth(1307)
        height: respHeight(187)

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: respHeight(114)

        Label {
            id: operationalModesTitle
            text: "Operational Modes"
            color: "#1B1B1B"
            font.family: "Poppins"
            font.pixelSize: respAvg(18)
            font.weight: Font.DemiBold

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: respHeight(30)
            anchors.leftMargin: respWidth(30)
        }

        Row {
            id: programBtnRow
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.left: parent.left
            anchors.topMargin: respHeight(75)
//            anchors.leftMargin: respWidth(30)
            spacing: 20

            property bool programSelected: false

            ToggleButton {
                id: programA
                width: respWidth(403)
                height: respHeight(63)
                enabled: !programBtnRow.programSelected || checked

                srcOffState: programBtnRow.programSelected ? "qrc:/Assets/Images/program_disabled_a.png" : "qrc:/Assets/Images/program_unpressed_a.png"
                srcOffPressedState: "qrc:/Assets/Images/program_unpressed_a.png"
                srcOnState: "qrc:/Assets/Images/program_pressed_a.png"
                srcOnPressedState: "qrc:/Assets/Images/program_pressed_a.png"

                onCheckedChanged: {
                    if(checked) {
                        programBtnRow.programSelected = true
                        backend.start_relay_program(0)
                    }
                    else {
                        programBtnRow.programSelected = false
                        backend.rest_gpio()
                    }
                }
            }

            ToggleButton {
                id: programB
                width: respWidth(403)
                height: respHeight(63)
                enabled: !programBtnRow.programSelected || checked

                srcOffState: programBtnRow.programSelected ? "qrc:/Assets/Images/program_disabled_b.png" : "qrc:/Assets/Images/program_unpressed_b.png"
                srcOffPressedState: "qrc:/Assets/Images/program_unpressed_b.png"
                srcOnState: "qrc:/Assets/Images/program_pressed_b.png"
                srcOnPressedState: "qrc:/Assets/Images/program_pressed_b.png"

                onCheckedChanged: {
                    if(checked) {
                        programBtnRow.programSelected = true
                        backend.start_relay_program(1)
                    }
                    else {
                        programBtnRow.programSelected = false
                        backend.rest_gpio()
                    }
                }
            }

            ToggleButton {
                id: programC
                width: respWidth(403)
                height: respHeight(63)
                enabled: !programBtnRow.programSelected || checked

                srcOffState: programBtnRow.programSelected ? "qrc:/Assets/Images/program_disabled_c.png" : "qrc:/Assets/Images/program_unpressed_c.png"
                srcOffPressedState: "qrc:/Assets/Images/program_unpressed_c.png"
                srcOnState: "qrc:/Assets/Images/program_pressed_c.png"
                srcOnPressedState: "qrc:/Assets/Images/program_pressed_c.png"

                onCheckedChanged: {
                    if(checked) {
                        programBtnRow.programSelected = true
                        backend.start_relay_program(2)
                    }
                    else {
                        programBtnRow.programSelected = false
                        backend.rest_gpio()
                    }
                }
            }
        }
    }

    CardItem {
        id: relayStateView
        width: respWidth(1307)
        height: respHeight(490)

        anchors.top: programSelect.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: respHeight(51)

        Label {
            id: dashboardTitle
            text: "Relay State View"
            color: "#1B1B1B"
            font.family: "Poppins"
            font.pixelSize: respAvg(18)
            font.weight: Font.DemiBold

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: respHeight(30)
            anchors.leftMargin: respWidth(30)
        }

        Grid {
            rows: 2
            columns: 8
            rowSpacing: respWidth(37)
            columnSpacing: respHeight(37)

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: respHeight(150)

            Image {
                id: relay1
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R1"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay2
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R2"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay3
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R3"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay4
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R4"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay5
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R5"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay6
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R6"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay7
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R7"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay8
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R8"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: respHeight(13)
                }
            }

            Image {
                id: relay9
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R9"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay10
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R10"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay11
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R11"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay12
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R12"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay13
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R13"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay14
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R14"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay15
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R15"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }

            Image {
                id: relay16
                width: respWidth(62)
                height: respHeight(62)
                source: "qrc:/Assets/Images/relay_disabled.png"

                Label {
                    text: "R16"
                    color: "#1B1B1B"
                    font.family: "Poppins"
                    font.pixelSize: respAvg(24)
                    font.weight: Font.DemiBold

                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: respHeight(13)
                }
            }
        }

        PushButton {
            id: resetButton
            width: respWidth(213)
            height: respHeight(50)
            visible: false
            srcPressed: "qrc:/Assets/Images/reset_pressed.png"
            srcUnpressed: "qrc:/Assets/Images/reset_unpressed.png"

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: respHeight(387)

            onPressed: {
                console.log("Reset")

                programBtnRow.programSelected = false
                programA.checked = false
                programB.checked = false
                programC.checked = false
            }
        }
    }

    onClosing: {
        backend.close_app()
    }

    Connections {
        target: backend

        function onProgramFinished() {
            programA.checked = false
            programB.checked = false
            programC.checked = false
        }

        function onRelayStateChanged(relayID, relayState) {
            if(relayID == "R1") {
                relay1.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R2") {
                relay2.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R3") {
                relay3.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R4") {
                relay4.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R5") {
                relay5.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R6") {
                relay6.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R7") {
                relay7.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R8") {
                relay8.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R9") {
                relay9.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R10") {
                relay10.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R11") {
                relay11.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R12") {
                relay12.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R13") {
                relay13.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R14") {
                relay14.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R15") {
                relay15.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
            if(relayID == "R16") {
                relay16.source = relayState ? "qrc:/Assets/Images/relay_enabled.png" : "qrc:/Assets/Images/relay_disabled.png"
            }
        }
    }
}
