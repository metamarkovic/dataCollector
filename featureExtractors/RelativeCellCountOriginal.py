import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class RelativeCellCountOriginal(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ["relCellCountFat", "relCellCountMuscle", "relCellCountBone"]

    def extract(self, experiment, type, indiv):
        noResultVal = ['NA', 'NA', 'NA']
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"
        if os.path.isfile(filepath):
            vd = VoxelData(filepath)
            relCounts = vd.getRelCounts()
            if not relCounts:
                return noResultVal

            return [relCounts["fat"], relCounts["muscle"], relCounts["bone"]]
        else:
            return noResultVal
