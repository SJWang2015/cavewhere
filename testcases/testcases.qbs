import qbs 1.0
import qbs.TextFile
import qbs.Process
import qbs.FileInfo
import qbs.File

import "../qbsModules/CavewhereApp.qbs" as CavewhereApp

CavewhereApp {
    name: "cavewhere-test"
    consoleApplication: true

    Depends { name: "Qt"; submodules: ["test"] }
    Depends { name: "dewalls" }

    Group {
        name: "testcases"
        files: [
            "*.cpp",
            "*.h"
        ]
    }

    Group {
        name: "dewalls testcases"
        files: [
            "../dewalls/test/*.cpp",
            "../dewalls/test/*.h"
        ]
        excludeFiles: "../dewalls/test/dewallstests.cpp"
    }

    Group {
        name: "CatchTestLibrary"
        files: [
            "catch.hpp"
        ]
    }
}
