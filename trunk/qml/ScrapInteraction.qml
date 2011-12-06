import QtQuick 1.1
import Cavewhere 1.0

BaseScrapInteraction {
    id: interaction

    property BasePanZoomInteraction basePanZoomInteraction
    property ImageItem imageItem

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: {
            if(pressedButtons == Qt.RightButton) {
                basePanZoomInteraction.panFirstPoint(Qt.point(mouse.x, mouse.y))
            }
        }

        onReleased: {
            if(mouse.button === Qt.LeftButton) {
                var notePoint = imageItem.mapQtViewportToNote(Qt.point(mouse.x, mouse.y))
                interaction.addPoint(notePoint)
            }
        }

        onMousePositionChanged: {
            if(pressedButtons == Qt.RightButton) {
                basePanZoomInteraction.panMove(Qt.point(mouse.x, mouse.y))
            }
        }

        onEntered: {
            interaction.forceActiveFocus()
        }
    }

    HelpBox {
        id: scrapHelpBox
        text: "Trace a scrap by <b>clicking</b> points around it <br>
        Press <b>spacebar</b> to add a new scrap"
    }

    Keys.onSpacePressed: {
        interaction.startNewScrap()
    }
}
