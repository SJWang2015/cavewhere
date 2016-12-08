import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0


SplitView {
    property var scene: null; //llrenderId.scene
    property alias turnTableInteraction: renderId.turnTableInteraction
    property alias leadView: renderId.leadView

    anchors.fill: parent


    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.preferredWidth: parent.width * .75

        Item {
            anchors.fill: renderId

            RadialGradient {
                anchors.fill: parent
                verticalOffset: parent.height * .6
                verticalRadius: parent.height * 2
                horizontalRadius: parent.width * 2.5
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#F3F8FB" } //"#3986C1" }
                    GradientStop { position: 0.5; color: "#92D7F8" }
                }
            }
        }

//        GLTerrainRenderer {
//            id: rendererId
////            anchors.fill: parent
//        }

        Renderer3D {
            id: renderId
            anchors.fill: parent
        }
    }

    RenderingSideBar {
        viewer: renderId
    }
}
