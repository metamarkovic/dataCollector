import os
import types
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class MuscleLocation(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['muscleBottom', 'muscleTop', 'muscleCenter', 'muscleOuter', 'muscleCenterRel', 'muscleOuterRel']

    def extract(self, experiment, variant, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"

        if not os.path.isfile(filepath):
            return ['NA'] * 6
        vd = VoxelData(filepath)
        dnaMatrix = vd.getDNAmatrix()
        if type(dnaMatrix) == types.BooleanType and not dnaMatrix:
            return ['NA'] * 6

        muscleBottom = 0
        for x in range(10):
            for y in range(10):
                for z in range(3):
                    if int(dnaMatrix[z, y, x]) in [3, 4]:
                        muscleBottom += 1

        muscleTop = 0
        for x in range(10):
            for y in range(10):
                for z in range(3):
                    if int(dnaMatrix[z + 7, y, x]) in [3, 4]:
                        muscleTop += 1

        muscleCenter = 0
        for x in range(4):
            for y in range(4):
                for z in range(4):
                    if int(dnaMatrix[z + 3, y + 3, x + 3]) in [3, 4]:
                        muscleCenter += 1

        muscleOuter = 0
        for x in [0, 1, 8, 9]:
            for y in [0, 1, 8, 9]:
                for z in [0, 1, 8, 9]:
                    if int(dnaMatrix[z, y, x]) in [3, 4]:
                        muscleOuter += 1

        muscleTotal = vd.dna.count("3") + vd.dna.count("4")

        if muscleTotal > 0:
            muscleCenterRel = float(muscleCenter) / muscleTotal
            muscleOuterRel = float(muscleOuter) / muscleTotal
        else:
            muscleCenterRel = 0.0
            muscleOuterRel = 0.0

        return [muscleBottom, muscleTop, muscleCenter, muscleOuter, muscleCenterRel, muscleOuterRel]
