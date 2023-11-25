import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    Rectangle {
        id: cardBackground
        width: parent.width
        height: parent.height
        color: "#FFFFFF"
        radius: respAvg(24)
        clip: true
    }

    DropShadow {
        id: cardShadow
        anchors.fill: cardBackground
        horizontalOffset: 6
        verticalOffset: 6
        radius: 20.0
        samples: 20
        color: "#26000000"
        source: cardBackground
        smooth: true
    }
}
