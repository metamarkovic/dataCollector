import os
import types
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.getVoxelData import VoxelData


class SizeOnAxis(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['sizeXmax', 'sizeYmax', 'sizeZmax', 'sizeXmin', 'sizeYmin', 'sizeZmin']

    def extract(self, experiment, variant, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"

        if os.path.isfile(filepath):
            vd = VoxelData(filepath)
            dnaMatrix = vd.getDNAmatrix()
            if type(dnaMatrix) == types.BooleanType and not dnaMatrix:
                return ['NA'] * 6

            zMin = 9999
            zMax = 0
            for x in range(10):
                for y in range(10):
                    zColumn = [cell for cell in dnaMatrix[:, y, x] if cell != "0"]
                    zMax = max(len(zColumn), zMax)
                    zMin = min(len(zColumn), zMin)

            yMin = 9999
            yMax = 0
            for x in range(10):
                for z in range(10):
                    yColumn = [cell for cell in dnaMatrix[z, :, x] if cell != "0"]
                    yMax = max(len(yColumn), yMax)
                    yMin = min(len(yColumn), yMin)

            xMin = 9999
            xMax = 0
            for z in range(10):
                for y in range(10):
                    xColumn = [cell for cell in dnaMatrix[z, y, :] if cell != "0"]
                    xMax = max(len(xColumn), xMax)
                    xMin = min(len(xColumn), xMin)

            return [xMax, yMax, zMax, xMin, yMin, zMin]

        else:
            return ['NA'] * 6
