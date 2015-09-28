import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class AbsoluteCellCount(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ["absCellCountFat", "absCellCountMuscle", "absCellCountBone"]

    def extract(self, experiment, type, indiv):
        noResultVal = ['NA', 'NA', 'NA']
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"
        if os.path.isfile(filepath):
            vd = VoxelData(filepath)
            absCounts = vd.getAbsCounts()
            if not absCounts:
                return noResultVal

            return [absCounts["fat"], absCounts["muscle"], absCounts["bone"]]

        else:
            return noResultVal
