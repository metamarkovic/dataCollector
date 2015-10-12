import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class Lifetime(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['lifetime']

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"
        if os.path.isfile(filepath):
            vd = VoxelData(filepath)
            lifetime = vd.getLifeTime()
            if not lifetime:
                return ['NA']
            return [lifetime]

        else:
            return ['NA']
