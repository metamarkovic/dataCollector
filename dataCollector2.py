import csv
import glob
import re
import os
from featureExtractors.AbsoluteCellCount import AbsoluteCellCount
from featureExtractors.RelativeCellCount import RelativeCellCount
from featureExtractors.BasicInfo import BasicInfo
from featureExtractors.DistanceAlt import DistanceAlt
from featureExtractors.DistanceOriginal import DistanceOriginal
from featureExtractors.MutProbability import MutProbability
from helpers.config import PathConfig

__author__ = 'meta'

""" DataCollector 2 main script (rewrite of the original)

This script can be run standalone with 2 optional command line parameters:
[output file name] - (default: 'data.csv'), this defines the filename of the CSV output that this script generates
[search pattern] - (default: '../EC14-Exp-1*'), this defines what folders are searched. Can also be set to "null" to use the default
"""


class DataCollector2:
    def __init__(self, pattern, outputFile, limit):
        if not pattern:
            self.pattern = '../EC14-Exp-*'
        else:
            self.pattern = pattern
        if not outputFile:
            self.outputFile = 'data.csv'
        else:
            self.outputFile = outputFile
        if not limit:
            self.limit = 10
        else:
            self.limit = limit


        self.rowCount = 0
        self.headers = []
        self.headersWritten = False
        self.writer = False
        self.outputFileHandle = False
        self.previousPercentDone = 0
        self.expNumberRegex = re.compile('([0-9]+)$')

        self.featureExtractors = [
            BasicInfo(),
            MutProbability(),
            DistanceOriginal(),
            DistanceAlt(),
            AbsoluteCellCount(),
            RelativeCellCount()
        ]

    def getExperiments(self):
        expFolders = glob.glob(self.pattern)
        output = [(self.getExpNumber(os.path.basename(expFolder)),
                   os.path.basename(expFolder),
                   expFolder) for expFolder in expFolders if os.path.isdir(expFolder)]
        return output

    def getExpNumber(self, haystack):
        m = self.expNumberRegex.search(haystack)
        if m is not None:
            return m.group(1)
        else:
            return haystack

    def collectData(self):
        experiments = self.getExperiments()
        for exp in experiments:
            type = self.getType(exp)
            # print exp[0],type
            individuals = self.getIndividuals(exp)
            print "parsing experiment {exp} (type: {type}) with {indivs} individuals".format(
                exp=exp[0],
                type=type,
                indivs=len(individuals)
            )
            count = 0
            for indiv in individuals[:self.limit]:
                features = self.getFeatures(exp, type, indiv)
                self.writeFeatures(features)
                count += 1
                self.printExperimentProgress(len(individuals), count)

        self.closeFile()
        print "wrote {} lines to {}".format(self.rowCount, self.outputFile)

    def getIndividuals(self, experiment):
        indivs = glob.glob(experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + "*.vxa")
        output = [(os.path.basename(indiv).split("_")[0], indiv) for indiv in indivs]
        return output

    def getType(self, experiment):
        # if the alternative population DOES have a disease then the main experiment DIDN'T have a disease
        if self.hasAltPopWithDisease(experiment):
            if not self.hasAltPopWithoutDisease(experiment):
                return "with disease"
            else:
                self.errorHasBothPopFiles(experiment)
        # if the alternative population DOESN'T have a disease then the main experiment DID have a disease
        if self.hasAltPopWithoutDisease(experiment):
            if not self.hasAltPopWithDisease(experiment):
                return "no disease"
            else:
                self.errorHasBothPopFiles(experiment)
        # if neither is the case, then there are no population files for this experiment... abort
        self.errorHasNoPop()

    def hasAltPopWithoutDisease(self, experiment):
        return self.hasAltPop(experiment, "no disease")

    def hasAltPopWithDisease(self, experiment):
        return self.hasAltPop(experiment, "with disease")

    def hasAltPop(self, experiment, condition):
        altPopPath = experiment[2] + os.path.sep + PathConfig.populationFoldersAlt[condition]
        if not os.path.isdir(altPopPath):
            return False
        if len(os.listdir(altPopPath)) > 0:
            return True
        return False

    def getFeatures(self, experiment, type, indiv):
        output = []
        for feature in self.featureExtractors:
            output += feature.extract(experiment, type, indiv)
        return output

    def printExperimentProgress(self, total, current):
        percentDone = round(100 * current * 1.0 / total)
        if percentDone != self.previousPercentDone:
            sys.stdout.write('{}% done\r'.format(int(percentDone)))
            sys.stdout.flush()
            self.previousPercentDone = percentDone

    def writeFeatures(self, features):
        if not self.headersWritten:
            self.headers = self.getFeatureHeader()
            self.outputFileHandle = open(self.outputFile, "wb")
            self.writer = csv.DictWriter(self.outputFileHandle, fieldnames=self.headers)
            self.writer.writeheader()
            self.headersWritten = True
        self.rowCount += 1
        rowDict = dict(zip(self.headers, features))
        self.writer.writerow(rowDict)

    def closeFile(self):
        self.outputFileHandle.close()

    def getFeatureHeader(self):
        output = []
        for feature in self.featureExtractors:
            output += feature.getCSVheader()
        return output

    @staticmethod
    def errorHasBothPopFiles(experiment):
        print "ERROR: this shouldn't happen - an experiment has alternative population files " \
              "both WITH and WITHOUT disease in addition to the normal experiment traces:"
        print experiment
        print "...Please fix this before continuing. Exiting."
        quit()

    @staticmethod
    def errorHasNoPop(experiment):
        print "ERROR: the following experiment has no alternative population files (neither with disease nor without):"
        print experiment
        print "...Please fix this before continuing. Exiting."
        quit()


if __name__ == "__main__":
    import sys

    pattern = False
    outputFile = False
    limit = False
    if len(sys.argv) >= 2:
        outputFile = sys.argv[1]
    if len(sys.argv) >= 3:
        pattern = sys.argv[2]
        if pattern.lower() == "null" or pattern.lower() == "false":
            pattern = False
    if len(sys.argv) == 4:
        limit = sys.argv[3]

    dataCol = DataCollector2(pattern, outputFile, limit)
    dataCol.collectData()
