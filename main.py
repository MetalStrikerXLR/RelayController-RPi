import sys
import os
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType
from Modules.BackendController import BackendController
import Assets.QRC.Resources

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    backendController = BackendController()
    engine.rootContext().setContextProperty("backend", backendController)

    engine.quit.connect(app.quit)
    engine.load(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), "main.qml"))

    sys.exit(app.exec())
