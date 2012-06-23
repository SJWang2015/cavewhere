#ifndef CWSCRAPCONTROLPOINTVIEW_H
#define CWSCRAPCONTROLPOINTVIEW_H

//Our includes
#include "cwScrapPointView.h"
#include "cwGlobalDirectory.h"
class cwScrap;

class cwScrapControlPointView : public cwScrapPointView
{
    Q_OBJECT

public:
    explicit cwScrapControlPointView(QQuickItem *parent = 0);
    
    void setScrap(cwScrap* scrap);

protected:
    virtual QUrl qmlSource() const;
    virtual void updateItemPosition(QQuickItem* item, int pointIndex);
    
public slots:

private slots:
    void reset();

    
};

/**
 * @brief cwScrapControlPointView::qmlSource
 * @return Returns the point's qml definition
 */
inline QUrl cwScrapControlPointView::qmlSource() const
{
    return cwGlobalDirectory::baseDirectory() + "qml/ScrapOutlinePoint.qml";
}


#endif // CWSCRAPCONTROLPOINTVIEW_H
