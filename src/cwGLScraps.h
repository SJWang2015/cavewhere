#ifndef CWGLSCRAPS_H
#define CWGLSCRAPS_H

//Our includes
#include "cwGLObject.h"
#include "cwTriangulatedData.h"
#include "cwImageTexture.h"
#include "cwGeometryItersecter.h"
class cwCavingRegion;
class cwProject;

//Qt includes
#include <QOpenGLShaderProgram>
#include <QOpenGLBuffer>
#include <QSharedPointer>

class cwGLScraps : public cwGLObject
{
    Q_OBJECT


public:
    explicit cwGLScraps(QObject *parent = 0);

    Q_PROPERTY(cwProject* project READ project WRITE setProject NOTIFY projectChanged)

    cwProject* project() const;
    void setProject(cwProject* project);

    cwGeometryItersecter intersecter() const;

    void updateGeometry();
    void setCavingRegion(cwCavingRegion* region);

    void initialize();
    void draw();
    void updateData();

    
signals:
    void projectChanged();

public slots:

private:
    class GLScrap {

    public:
        GLScrap();
        GLScrap(const cwTriangulatedData& data, cwProject* project);

        QOpenGLBuffer PointBuffer;
        QOpenGLBuffer IndexBuffer;
        QOpenGLBuffer TexCoords;

        int NumberOfIndices;

        QSharedPointer<cwImageTexture> Texture;

    };

    cwProject* Project; //!< The project file for loading textures
    cwCavingRegion* Region;

    QOpenGLShaderProgram* Program;
    int UniformModelViewProjectionMatrix;
    int vVertex;
    int vScrapTexCoords;

    QList<GLScrap> Scraps;

    //This is a temporary test
    cwGeometryItersecter Intersecter;

    void initializeShaders();

};

inline void cwGLScraps::setCavingRegion(cwCavingRegion *region) {
    Region = region;
}

/**
Gets project
*/
inline cwProject* cwGLScraps::project() const {
    return Project;
}

inline cwGeometryItersecter cwGLScraps::intersecter() const
{
    return Intersecter;
}

#endif // CWGLSCRAPS_H
