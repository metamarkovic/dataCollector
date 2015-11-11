import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class MutProbability(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['probability']

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"
        if os.path.isfile(filepath):
            vd = VoxelData(filepath)
            absCounts = vd.getAbsCounts()
            if not absCounts:
                return ['NA']
            probability = (absCounts["fat"] / 1000.0) * 0.5
            return [probability]

        else:
            return ['NA']
