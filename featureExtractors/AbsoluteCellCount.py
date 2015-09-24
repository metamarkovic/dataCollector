import random
from FeatureExtractorAbstract import FeatureExtractorAbstract


class AbsoluteCellCount(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ["absCellCountFat", "absCellCountMuscle", "absCellCountBone"]

    def extract(self, experiment, type, indiv):
        return [random.randint(0,1000), random.randint(0,1000), random.randint(0,1000)]
