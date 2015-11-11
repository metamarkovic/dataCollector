import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.distanceCalc import DistanceCalc


class RelHeight(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['relHeight']

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.traceFolderNormal + os.path.sep + indiv[0] + ".trace"
        dc = DistanceCalc()
        if not os.path.isfile(filepath):
            filepath = experiment[2] + os.path.sep + PathConfig.traceFoldersAlt[type] + os.path.sep + indiv[
                0] + ".trace"
            if not os.path.isfile(filepath):
                return ['NA']
        with open(filepath, 'r') as inputFile:
            relHeight = []
            lines = []
            for line in inputFile:
                lines.append(line)
                if len(lines) > 100:
                    lines.pop(0)

            for line in lines:
                lineSplit = line.split("\t")
                if not dc.isValidLine(lineSplit):
                    lineSplit = line.split(" ")
                    if not dc.isValidLine(lineSplit):
                        continue
                relHeight.append(float(lineSplit[4]))

        if len(relHeight) > 0:
            result = float(sum(relHeight)) / len(relHeight)
        else:
            result = 0
        return [result]
