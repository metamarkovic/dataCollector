import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData
from helpers.getAltFile import GetAltFile


class RelativeCellCountAlt(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ["relCellCountFatAlt", "relCellCountMuscleAlt", "relCellCountBoneAlt"]

    def extract(self, experiment, type, indiv):
        noResultVal = ['NA', 'NA', 'NA']
        filepath = GetAltFile.getAltPopFile(experiment, type, indiv)
        if filepath != False:
            vd = VoxelData(filepath)
            relCounts = vd.getRelCounts()
            if not relCounts:
                return noResultVal

            return [relCounts["fat"], relCounts["muscle"], relCounts["bone"]]
        else:
            return noResultVal
