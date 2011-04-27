import QtQuick 1.0

Rectangle {
    id: button
    property alias text:  buttonText.text
    property alias iconSource: icon.source
    property bool checkable:     false
    property bool troggled: false
    property bool iconOnTheLeft:  true
    property real iconSize: 16

    signal clicked();

    width: buttonText.width + icon.width + (2 * container.anchors.margins) + icon.anchors.rightMargin + buttonText.anchors.rightMargin
    height: buttonText.height + (2 * container.anchors.margins)

    radius: 3

    border.width: 1
    border.color: "black"

    gradient: Gradient {
        GradientStop {id: stop1; position:0.0; color:"#B7BDC5" }
        GradientStop {id: stop2; position:1.0; color:"#7F838C" }
    }

    Item {
        id: container

        anchors.fill: parent
        anchors.margins: 4

        Image {
            id: icon

            height: status == Image.Ready > 0 ? iconSize : 0
            width: status == Image.Ready > 0 ? iconSize : 0

            //anchors.left: iconOnTheLeft ? parent.left : buttonText.right
            anchors.right: iconOnTheLeft ? buttonText.left : parent.right
            anchors.rightMargin: status == Image.Ready && iconOnTheLeft > 0 ? 3 : 0
                        //anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            visible: status == Image.Ready
        }

        Text {
            id: buttonText
            //anchors.left: iconOnTheLeft ? buttonText.right : parent.left
            anchors.right: iconOnTheLeft ? parent.right : icon.left
            anchors.verticalCenter: icon.verticalCenter
            anchors.rightMargin: icon.status == Image.Ready && !iconOnTheLeft > 0 ? 3 : 0

        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        hoverEnabled: true

        onClicked: {
            if(checkable) { troggled = !troggled }
            button.clicked();
        }
    }

    states: [
        State {
            name: "hover"; when: mouseArea.containsMouse
            PropertyChanges { target: stop1; color: "#B7BDC5" }
            PropertyChanges { target: stop2; color: "#29335B" }
            //            PropertyChanges { target: buttonText; font.bold: true }
        }

    ]

}
