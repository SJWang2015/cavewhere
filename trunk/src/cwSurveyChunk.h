#ifndef CWSurveyChunk_H
#define CWSurveyChunk_H

//Our includes
class cwStation;
class cwShot;

//Qt
#include <QObject>
#include <QList>
#include <QDeclarativeListProperty>

class cwSurveyChunk : public QObject {
    Q_OBJECT

public:
    enum Direction {
        Above,
        Below
    };

    cwSurveyChunk(QObject *parent = 0);

    bool IsValid() const;
    bool CanAddShot(cwStation* fromStation, cwStation* toStation, cwShot* shot);

signals:
    void StationsAdded(int beginIndex, int endIndex);
    void ShotsAdded(int beginIndex, int endIndex);

    void StationsRemoved(int beginIndex, int endIndex);
    void ShotsRemoved(int beginIndex, int endIndex);

public slots:
    int StationCount() const;
    cwStation* Station(int index) const;

    int ShotCount() const;
    cwShot* Shot(int index) const;

    QPair<cwStation*, cwStation*> ToFromStations(const cwShot* shot) const;

    void AppendNewShot();
    void AppendShot(cwStation* fromStation, cwStation* toStation, cwShot* shot);


    cwSurveyChunk* SplitAtStation(int stationIndex);

    void InsertStation(int stationIndex, Direction direction);
    void InsertShot(int stationIndex, Direction direction);

    void RemoveStation(int stationIndex, Direction shot);
    bool CanRemoveStation(int stationIndex, Direction shot);

    void RemoveShot(int shotIndex, Direction station);
    bool CanRemoveShot(int shotIndex, Direction station);

private:
    QList<cwStation*> Stations;
    QList<cwShot*> Shots;

    bool ShotIndexCheck(int index) const { return index >= 0 && index < Shots.count();  }
    bool StationIndexCheck(int index) const { return index >= 0 && index < Stations.count(); }

    void Remove(int stationIndex, int shotIndex);
    int Index(int index, Direction direction);


};

#endif // CWSurveyChunk_H
