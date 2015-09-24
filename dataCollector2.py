import glob
import re
import os

__author__ = 'meta'

""" DataCollector 2 main script (rewrite of the original)

This script can be run standalone with 2 optional command line parameters:
[output file name] - (default: 'data.csv'), this defines the filename of the CSV output that this script generates
[search pattern] - (default: '../EC14-Exp-1*'), this defines what folders are searched. Can also be set to "null" to use the default
"""


class DataCollector2:
    def __init__(self, pattern, outputFile):
        if not pattern:
            self.pattern = '../EC14-Exp-*'
        else:
            self.pattern = pattern
        if not outputFile:
            self.outputFile = 'data.csv'
        else:
            self.outputFile = outputFile
        self.expNumberRegex = re.compile('([0-9]+)$')

    def getExperiments(self):
        expFolders = glob.glob(self.pattern)
        output = [(self.getExpNumber(os.path.basename(expFolder)),
                   os.path.basename(expFolder),
                   expFolder) for expFolder in expFolders if os.path.isdir(expFolder)]
        return output

    def getExpNumber(self, haystack):
        print haystack
        m = self.expNumberRegex.search(haystack)
        print m
        if m is not None:
            return m.group(1)
        else:
            return haystack

    def collectData(self):
        experiments = self.getExperiments()
        print experiments
        quit()
        for exp in experiments:
            type = self.getType(exp)
            individuals = self.getIndividuals(exp)
            for indiv in individuals:
                features = self.getFeatures(exp, type, indiv)
                self.writeFeatures(exp, type, indiv, features)

    def writeOutput(self):
        pass


if __name__ == "__main__":
    import sys

    pattern = False
    outputFile = False
    if len(sys.argv) >= 2:
        outputFile = sys.argv[1]
    if len(sys.argv) == 3:
        pattern = sys.argv[1]
        if pattern.lower() == "null" or pattern.lower() == "false":
            pattern = False
    dataCol = DataCollector2(pattern, outputFile)
    dataCol.collectData()
