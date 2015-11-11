import os
import types
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class Symmetry(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['symmetricMuscleSame', 'symmetricMuscleOpposite', 'symmetricMuscleMissing']

    def extract(self, experiment, variant, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"

        if not os.path.isfile(filepath):
            return ['NA'] * 3
        vd = VoxelData(filepath)
        dnaMatrix = vd.getDNAmatrix()
        if type(dnaMatrix) == types.BooleanType and not dnaMatrix:
            return ['NA'] * 3

        toCheck = []
        for x in range(10):
            for y in range(10):
                for z in range(10):
                    if int(dnaMatrix[z, y, x]) in [3, 4]:
                        val = int(dnaMatrix[z, y, x])
                        mirrors = [
                            (x, y, z),
                            (9 - x, y, z),
                            (x, 9 - y, z),
                            (x, y, 9 - z),
                            (y, x, z),
                            (x, z, y),
                            (z, y, x),
                            (9 - y, 9 - x, z),
                            (x, 9 - z, 9 - y),
                            (9 - z, y, 9 - x)
                        ]
                        mirrors = list(set(mirrors))
                        cellHash = str(x) + '-' + str(y) + '-' + str(z)
                        toCheck += zip(mirrors, [val] * len(mirrors), [cellHash] * len(mirrors))

        sameExisting = 0
        missing = 0
        counterExisting = 0
        musclesChecked = []
        for toCheckLocation in toCheck:
            val = toCheckLocation[1]
            knownMuscle = False
            if toCheckLocation[2] in musclesChecked:
                knownMuscle = True
            opposite = 4
            if val == 4:
                opposite = 3
            x, y, z = toCheckLocation[0]
            if int(dnaMatrix[x, y, z]) == val:
                sameExisting += 1
            elif int(dnaMatrix[x, y, z]) == opposite:
                counterExisting += 1
            else:
                if not knownMuscle:
                    missing += 1

            if not knownMuscle:
                musclesChecked.append(toCheckLocation[2])

        return [sameExisting, counterExisting, missing]
