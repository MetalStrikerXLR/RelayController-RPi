import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Button {
    id: pushButton

    property string srcPressed: "./ComponentAssets/push_button_pressed.png"
    property string srcUnpressed: "./ComponentAssets/push_button_unpressed.png"
    property int  radius: 0
    property bool isDefault: false

    width: 50
    height: 40

    background: Rectangle{
        id: mainbackground
        color: "transparent"
        anchors.fill: parent
        radius: pushButton.radius

        Image {
            id: icon
            width: pushButton.width
            height: pushButton.height
            visible: true
            layer.enabled: true
            layer.effect: OpacityMask
            {
                maskSource: Rectangle { width: mainbackground.width; height: mainbackground.height ; radius: pushButton.radius}
            }
        }

        Component.onCompleted:
        {
            pushButton.isDefault = true
        }
    }


    states: [
        State {
            name: "pressedState"
            when: isDefault && pushButton.pressed
            PropertyChanges { target: icon; source: srcPressed}
        },
        State {
            name: "unpressedState"
            when: isDefault && !pushButton.pressed
            PropertyChanges { target: icon; source: srcUnpressed}
        }
    ]
}
