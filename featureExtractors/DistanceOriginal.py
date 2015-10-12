import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.getDistanceForTraceFile import TraceDistance


class DistanceOriginal(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['euclideanStep', 'manhattanStep', 'euclideanTotal', 'manhattanTotal']

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + "traces_afterPP" + os.path.sep + indiv[0] + ".trace"
        if os.path.isfile(filepath):
            return TraceDistance.calcDistance(filepath)
        else:
            return ["NA"] * 4
