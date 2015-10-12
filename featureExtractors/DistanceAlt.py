import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getDistanceForTraceFile import TraceDistance


class DistanceAlt(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['euclideanStepAlt', 'manhattanStepAlt', 'euclideanTotalAlt', 'manhattanTotalAlt']

    def extract(self, experiment, type, indiv):
        conf = PathConfig()
        tPath = conf.traceFoldersAlt[type]
        filepath = experiment[2] + os.path.sep + "{}" + os.path.sep + indiv[0] + ".trace"
        if os.path.isfile(filepath.format(tPath)):
            return TraceDistance.calcDistance(filepath.format(tPath))
        else:
            tPath = conf.traceFoldersAlt[conf.getOtherType(type)]
            if os.path.isfile(filepath.format(tPath)):
                return TraceDistance.calcDistance(filepath.format(tPath))
            else:
                print "WARN: couldn't find alt trace file for experiment {}, indiv {}".format(experiment[0], indiv[0])
                return ["NA"] * 4
