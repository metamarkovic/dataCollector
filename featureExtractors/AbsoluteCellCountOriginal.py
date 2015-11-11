import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class AbsoluteCellCountOriginal(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ["absCellCountFat", "absCellCountMuscle", "absCellCountBone", "absCellCount"]

    def extract(self, experiment, type, indiv):
        noResultVal = ['NA'] * 4
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"
        if os.path.isfile(filepath):
            vd = VoxelData(filepath)
            absCounts = vd.getAbsCounts()
            if not absCounts:
                return noResultVal

            return [absCounts["fat"], absCounts["muscle"], absCounts["bone"], sum(absCounts.values())]

        else:
            return noResultVal
