import math
from scipy.optimize import fsolve
import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.distanceCalc import DistanceCalc


class Arc(FeatureExtractorAbstract):
    a = ()
    b = ()
    c = ()
    center = ()
    radius = 0
    circumference = 0

    def getCSVheader(self):
        return ['traceArcRadius', 'traceArcPercent']

    def extract(self, experiment, type, indiv):
        errorReturnVal = ['NA'] * 2
        filepath = experiment[2] + os.path.sep + PathConfig.traceFolderNormal + os.path.sep + indiv[0] + ".trace"
        dc = DistanceCalc()
        if not os.path.isfile(filepath):
            filepath = experiment[2] + os.path.sep + PathConfig.traceFoldersAlt[type] + os.path.sep + indiv[
                0] + ".trace"
            if not os.path.isfile(filepath):
                return errorReturnVal
        with open(filepath, 'r') as inputFile:
            traceLines = []
            lines = []
            for line in inputFile:
                lines.append(line)
                if len(lines) == 110:
                    break

            if len(lines) < 20:
                return errorReturnVal

            for line in lines[-10:]:
                lineSplit = line.split("\t")
                if not dc.isValidLine(lineSplit):
                    lineSplit = line.split(" ")
                    if not dc.isValidLine(lineSplit):
                        continue
                traceLines.append(
                    (float(lineSplit[2]), float(lineSplit[2]))
                )
        if len(traceLines) < 6:
            return errorReturnVal

        self._setPoints(traceLines[0], traceLines[3], traceLines[5])
        self._getCenter()
        self._getRadius()
        self._getCircumference()
        dist = dc.distanceStep(filepath, "euclidean")
        percentCircle = dist / self.circumference

        return [self.radius, percentCircle]

    def _setPoints(self, a, b, c):
        self.a = a
        self.b = b
        self.c = c

    def _funcs(self, x):
        out = [
            self.a[0] ** 2 - self.b[0] ** 2 - 2 * self.a[0] * x[0] + 2 * self.b[0] * x[0] +
            self.a[1] ** 2 - self.b[1] ** 2 - 2 * self.a[1] * x[1] + 2 * self.b[1] * x[1],
            self.a[0] ** 2 - self.c[0] ** 2 - 2 * self.a[0] * x[0] + 2 * self.c[0] * x[0] +
            self.a[1] ** 2 - self.c[1] ** 2 - 2 * self.a[1] * x[1] + 2 * self.c[1] * x[1]
            # self.c[0] ** 2 - self.b[0] ** 2 - 2 * self.c[0] * x[0] + 2 * self.b[0] * x[0] +
            # self.c[1] ** 2 - self.b[1] ** 2 - 2 * self.c[1] * x[1] + 2 * self.b[1] * x[1]
        ]
        return out

    def _getCenter(self):
        center = fsolve(self._funcs, [0.25, 0.25])
        self.center = [round(center[0], 6) + 0.0, round(center[1], 6) + 0.0]
        return self.center

    def _getRadius(self):
        self.radius = round(math.sqrt(
            (self.center[0] - self.a[0]) ** 2 +
            (self.center[1] - self.a[1]) ** 2
        ), 6)
        return self.radius

    def _getCircumference(self):
        self.circumference = 2 * math.pi * self.radius
        return self.circumference


if __name__ == "__main__":
    arc = Arc()
    arc._setPoints(
        (2, 2),
        (0, 0),
        (4, 0)
    )
    print arc._getCenter()
    print arc._getRadius()
