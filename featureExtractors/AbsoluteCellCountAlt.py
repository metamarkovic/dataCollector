import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData
from helpers.getAltFile import GetAltFile


class AbsoluteCellCountAlt(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ["absCellCountFatAlt", "absCellCountMuscleAlt", "absCellCountBoneAlt", "absCellCountAlt"]

    def extract(self, experiment, type, indiv):
        noResultVal = ['NA'] * 4
        filepath = GetAltFile.getAltPopFile(experiment, type, indiv)
        if filepath != False:
            vd = VoxelData(filepath)
            absCounts = vd.getAbsCounts()
            if not absCounts:
                return noResultVal

            return [absCounts["fat"], absCounts["muscle"], absCounts["bone"], sum(absCounts.values())]

        else:
            return noResultVal
