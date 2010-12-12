//Our includes
#include "cwRegionTreeModel.h"
#include "cwCavingRegion.h"
#include "cwCave.h"
#include "cwSurveyTrip.h"

//Qt include
#include <QDebug>

cwRegionTreeModel::cwRegionTreeModel(QObject *parent) :
    QAbstractItemModel(parent),
    Region(NULL)
{
}

void cwRegionTreeModel::setCavingRegion(cwCavingRegion* region) {
    beginResetModel();
    Region = region;
    endResetModel();
}

QModelIndex cwRegionTreeModel::index ( int row, int column, const QModelIndex & parent) const {
    if(column != 0) { return QModelIndex(); }
    if(Region == NULL) { return QModelIndex(); }
    if(row < 0) { return QModelIndex(); }

    if(!parent.isValid()) {
        //Try to get a cave
        if(row >= Region->caveCount()) {
            return QModelIndex();
        }
        return createIndex(row, column, Region->cave(row));
    }

    cwCave* parentCave = qobject_cast<cwCave*>((QObject*)parent.internalPointer());
    if(parentCave != NULL) {
        if(row >= parentCave->tripCount()) {
            return QModelIndex();
        }

        return createIndex(row, column, parentCave->trip(row));
    }

    return QModelIndex();
}

QModelIndex cwRegionTreeModel::parent ( const QModelIndex & index ) const {
    cwCave* cave = qobject_cast<cwCave*>((QObject*)index.internalPointer());
    if(cave != NULL) {
        return QModelIndex(); //Caves don't have parents
    }

    cwSurveyTrip* trip = qobject_cast<cwSurveyTrip*>((QObject*)index.internalPointer());
    if(trip != NULL) {
        cwCave* parentCave = qobject_cast<cwCave*>(((QObject*)trip)->parent());
        int row = Region->indexOf(parentCave);
        Q_ASSERT(row >= 0); //This should always return with a valid index

        return createIndex(row, 0, parentCave);
    }

    return QModelIndex();
}

int cwRegionTreeModel::rowCount ( const QModelIndex & parent ) const {
    if(Region == NULL) { return 0; }

    if(!parent.isValid()) {
        return Region->caveCount();
    }

    cwCave* parentCave = qobject_cast<cwCave*>((QObject*)parent.internalPointer());
    if(parentCave != NULL) {
        return parentCave->tripCount();
    }

    return 0;
}

int cwRegionTreeModel::columnCount ( const QModelIndex & /*parent*/) const {
    if(Region == NULL) { return 0; }

    return 1; //Always one column
}

QVariant cwRegionTreeModel::data ( const QModelIndex & index, int role ) const {
    if(!index.isValid()) { return QVariant(); }

    cwCave* cave = qobject_cast<cwCave*>((QObject*)index.internalPointer());
    if(cave != NULL) {
        switch(role) {
        case Qt::DisplayRole:
            return QVariant(cave->name());
        default:
            return QVariant();
        }
    }

    cwSurveyTrip* trip = qobject_cast<cwSurveyTrip*>((QObject*)index.internalPointer());
    if(trip != NULL) {
        switch(role) {
        case Qt::DisplayRole:
            return QVariant(trip->name());
        default:
            return QVariant();
        }
    }

    return QVariant();
}
