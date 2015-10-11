import numpy as np
import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig

class Gait(FeatureExtractorAbstract):

    def getCSVheader(self):
        return ["gaitPeriod"]


    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.traceFolderNormal + os.path.sep + indiv[0] + ".trace"

        if not os.path.isfile(filepath):
            filepath = experiment[2] + os.path.sep + PathConfig.traceFoldersAlt[type] + os.path.sep + indiv[0] + ".trace"
            if not os.path.isfile(filepath):
                return ['NA']

        with open(filepath) as fh:
            zs = []
            for line in fh:
                line = line.strip().split()

                zs.append(line[-1])
            
        z_fft = np.fft.rfft(zs).real
        z_fft = z_fft[range(len(z_fft)/2+1)]
        period = np.argmax(z_fft[1:]) + 1

        return [period]
