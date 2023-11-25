import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Button {
    id: toggleButton

    property string srcOffState: "./ComponnentAssets/toggle_button_off_state.png"
    property string srcOnState: "./ComponnentAssets/toggle_button_on_state.png"
    property string srcOnPressedState: "./ComponnentAssets/toggle_button_on_pressed_state.png"
    property string srcOffPressedState: "./ComponnentAssets/toggle_button_off_pressed_state.png"
    property int  radius: 0
    property int  dropShadowBlur: 0
    property bool isDefault: false

    width: 50
    height: 40
    checkable: true

    background: Rectangle{
        id: mainbackground
        color: "transparent"
        anchors.fill: parent
        radius: toggleButton.radius

        Image {
            id: icon
            visible: true
            width: toggleButton.width + respWidth(2 * dropShadowBlur)
            height: toggleButton.height + respHeight(2 * dropShadowBlur)
            x: -respWidth(dropShadowBlur)
            y: -respHeight(dropShadowBlur)
            layer.enabled: true
            layer.effect: OpacityMask
            {
                maskSource: Rectangle { width: mainbackground.width; height: mainbackground.height ; radius: toggleButton.radius}
            }
        }

        Component.onCompleted:
        {
            toggleButton.isDefault = true
        }
    }

    states: [
        State {
            name: "offState"
            when: !toggleButton.pressed && !toggleButton.checked && isDefault
            PropertyChanges { target: icon; source: srcOffState}
        },
        State {
            name: "offPressedState"
            when: toggleButton.pressed && !toggleButton.checked && isDefault
            PropertyChanges { target: icon; source: srcOffPressedState}
        },
        State {
            name: "onState"
            when: !toggleButton.pressed && toggleButton.checked && isDefault
            PropertyChanges { target: icon; source: srcOnState}
        },
        State {
            name: "onPressedState"
            when: toggleButton.pressed && toggleButton.checked && isDefault
            PropertyChanges { target: icon; source: srcOnPressedState }
        }
    ]
}
