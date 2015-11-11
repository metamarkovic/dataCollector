import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getDistanceForTraceFile import TraceDistance
from helpers.getAltFile import GetAltFile

class DistanceAlt(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['euclideanStepAlt', 'manhattanStepAlt', 'euclideanTotalAlt', 'manhattanTotalAlt']

    def extract(self, experiment, type, indiv):
        filepath = GetAltFile.getAltTraceFile(experiment, type, indiv)
        if filepath != False:
            return TraceDistance.calcDistance(filepath)
        else:
            print "WARN: couldn't find alt trace file for experiment {}, indiv {}".format(experiment[0], indiv[0])
            return ["NA"] * 4
