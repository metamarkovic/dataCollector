import numpy as np
import os
from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.config import PathConfig
from helpers.distanceCalc import DistanceCalc


class Gait(FeatureExtractorAbstract):
    def __init__(self):
        self.dc = DistanceCalc()

    def getCSVheader(self):
        return ["gaitPeriodX", "gaitErrorX", "gaitPeriodY", "gaitErrorY", "gaitPeriodZ", "gaitErrorZ"]

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
	
	xs = map(float,xs)
	ys = map(float,ys)
	zs = map(float,zs)
	xPeriod, xError = self._getPeriod(xs)
        yPeriod, yError = self._getPeriod(ys)
	zPeriod, zError = self._getPeriod(zs)
	return xPeriod, xError, yPeriod, yError, zPeriod, zError

    @staticmethod
    def _getPeriod(signal):
        if len(signal) == 0:
            return 'NA'
        signal = np.array(signal)
        fft = np.fft.rfft(signal).real
        fft = fft[:len(fft) / 2 + 1]
        fft[1:] = fft[1:] / (len(signal)/2)
        fft[0] = fft[0]/len(signal)

        period = np.argmax(fft[1:]) + 1
        period_value = fft[1:].max()
      
        linspace = np.linspace(0,len(signal), len(signal))
        mse = np.average(signal - (period_value * np.sin(period*linspace+np.average(signal)))**2)
        return period, mse
