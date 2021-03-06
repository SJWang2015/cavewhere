/**************************************************************************
**
**    Copyright (C) 2013 by Philip Schuchardt
**    www.cavewhere.com
**
**************************************************************************/

// import QtQuick 2.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import Cavewhere 1.0
import "Utils.js" as Utils

GroupBox {

    property Calibration calibration

    contentHeight: column.height
    text: "Declination"

    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right

        Row {
            spacing: 3

            LabelWithHelp {
                id: declination
                text: "Declination"
                helpArea: declinationHelp
            }

            ClickTextInput {
                id: tapeCalInput
                text: Utils.fixed(calibration.declination, 2)

                onFinishedEditting: {
                    calibration.declination = newText
                }
            }
        }

        HelpArea {
            id: declinationHelp
            text: "<p>Magnetic declination is the <b>angle between magnetic north and true north</b></p>
            Cavewhere calculates the true bearing (<b>TB</b>) by adding declination (<b>D</b>) to magnetic bearing (<b>MB</b>).
            <center><b>MB + D = TB</b></center>"
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}

