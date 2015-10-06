import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.distanceCalc import DistanceCalc


class Monotony(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['monotonyX', 'monotonyY']

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.traceFolderNormal + os.path.sep + indiv[0] + ".trace"
        dc = DistanceCalc()
        if not os.path.isfile(filepath):
            filepath = experiment[2] + os.path.sep + PathConfig.traceFoldersAlt[type] + os.path.sep + indiv[
                0] + ".trace"
            if not os.path.isfile(filepath):
                return ['NA']
        with open(filepath, 'r') as inputFile:
            monotonyUp = 0
            monotonyDown = 0
            monotonyLeft = 0
            monotonyRight = 0

            firstLine = True
            xy = (0.0, 0.0)
            for line in inputFile:
                lineSplit = line.split("\t")
                if not dc.isValidLine(lineSplit):
                    lineSplit = line.split(" ")
                    if not dc.isValidLine(lineSplit):
                        continue
                if firstLine:
                    firstLine = False
                    xy = (lineSplit[2], lineSplit[3])
                else:
                    xyNew = (lineSplit[2], lineSplit[3])
                    if xyNew[1] > xy[1]:
                        monotonyUp += 1
                    if xyNew[1] < xy[1]:
                        monotonyDown += 1
                    if xyNew[0] > xy[0]:
                        monotonyRight += 1
                    if xyNew[0] < xy[0]:
                        monotonyLeft += 1
                    xy = xyNew

        return [monotonyRight - monotonyLeft, monotonyUp - monotonyDown]
