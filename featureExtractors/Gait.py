import numpy as np
import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.distanceCalc import DistanceCalc


class Gait(FeatureExtractorAbstract):
    def __init__(self):
        self.dc = DistanceCalc()

    def getCSVheader(self):
        return ["gaitPeriodX", "gaitPeriodY", "gaitPeriodZ"]

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.traceFolderNormal + os.path.sep + indiv[0] + ".trace"

        if not os.path.isfile(filepath):
            filepath = experiment[2] + os.path.sep + PathConfig.traceFoldersAlt[type] + os.path.sep + indiv[
                0] + ".trace"
            if not os.path.isfile(filepath):
                return ['NA'] * 3

        with open(filepath) as fh:
            xs = []
            ys = []
            zs = []
            for line in fh:
                linesplit = line.split("\t")
                if not self.dc.isValidLine(linesplit):
                    linesplit = line.split(" ")
                    if not self.dc.isValidLine(linesplit):
                        continue

                xs.append(linesplit[-3])
                ys.append(linesplit[-2])
                zs.append(linesplit[-1])

        return [self._getPeriod(xs), self._getPeriod(ys), self._getPeriod(zs)]

    @staticmethod
    def _getPeriod(signal):
        if len(signal) == 0:
            return 'NA'
        z_fft = np.fft.rfft(signal).real
        z_fft = z_fft[range(len(z_fft) / 2 + 1)]
        period = np.argmax(z_fft[1:]) + 1
        return period
