import QtQuick 1.1

Item {
   id: labelValueUnit

   property alias label: labelId.text
   property alias value: clickInput.text
   property alias unit: unit.text

   signal finishedEditting(string newText)

   height: childrenRect.height


}
