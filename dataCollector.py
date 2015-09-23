import os
from getDistanceForTraceFile import TraceDistance
from distanceCalc import DistanceCalc
import csv
import glob
import xml.etree.cElementTree as ET

__author__ = 'meta'

""" DataCollector main script

This script can be run standalone with 2 optional command line parameters:
[search pattern] - (default: '../EC14-Exp-1*'), this defines what folders are searched. Can also be set to "null" to use the default
[output file name] - (default: 'data.csv'), this defines the filename of the CSV output that this script generates
"""


class DataCollector:
    # fieldnames = ['Ind_ID', 'birthtime', 'Exp_Num', 'probability', 'euclideanStep', 'manhattanStep', 'euclideanTotal',
    #               'manhattanTotal', 'lifetime', 'size', 'totalMuscles', 'totalFat', 'totalBone', 'originalMuscle',
    #               'originalFat', 'originalBone', 'originalEuclideanStep', 'originalManhattanStep',
    #               'originalEuclideanTotal', 'originalManhattanTotal']
    fieldnames = ['Ind_ID', 'birthtime', 'Exp_Num', 'probability', 'euclideanStep', 'manhattanStep', 'euclideanTotal',
                  'manhattanTotal', 'lifetime', 'size', 'totalMuscles', 'totalFat', 'totalBone', 'diseasedMuscle',
                  'diseasedFat', 'diseasedBone', 'diseasedEuclideanStep', 'diseasedManhattanStep',
                  'diseasedEuclideanTotal', 'diseasedManhattanTotal']

    def __init__(self, pattern, outputFile):
        if not pattern:
            # self.pattern = '../EC14-Exp-1*'
            self.pattern = '../EC14-Exp-2*'
        else:
            self.pattern = pattern
        if not outputFile:
            self.outputFile = 'data.csv'
        else:
            self.outputFile = outputFile

    def dataCollector(self):
        listing = glob.glob(self.pattern)
        td = TraceDistance()
        dc = DistanceCalc()
        with open(self.outputFile, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=self.fieldnames)
            writer.writeheader()
            print  listing  # Testing
            for nestFile in listing:
                print "Experiment folder: " + nestFile  # Testing
                expFolder = nestFile[-2:]
                experimentNumber = str(expFolder)
                popListing = glob.glob(nestFile + "/population/*.vxa")
                for path in popListing:
                    indNumber = path[27:-8]
                    print "Population path: " + path  # Testing
                    print "Ind. ID: " + indNumber  # Testing
                    backupBasePath = nestFile + "/population_{condition}/" + indNumber + "_vox.vxa"
                    backup_path = os.path.abspath(backupBasePath.format(condition="beforePL"))
                    if not os.path.isfile(backup_path):
                        backup_path = os.path.abspath(backupBasePath.format(condition="MUT"))
                        if not os.path.isfile(backup_path):
                            backup_path = False
                    print "Backups path: " + backup_path  # Testing
                    voxProbability, voxLifetime, voxCounts = self.voxCounter(experimentNumber, path, indNumber)
                    voxProb_orig, voxProbLife_orig, voxCounts_orig = self.voxCounter(experimentNumber, backup_path,
                                                                                     indNumber)

                    traceFilename = os.path.abspath(nestFile + "/traces_afterPP/" + indNumber + ".trace")
                    mutatedBasePath = nestFile + "/traces_{condition}/" + indNumber + ".trace"
                    NOMUT_traceFilename = os.path.abspath(mutatedBasePath.format(condition="NOMUT"))
                    if not os.path.isfile(NOMUT_traceFilename):
                        NOMUT_traceFilename = os.path.abspath(mutatedBasePath.format(condition="MUT"))
                        if not os.path.isfile(NOMUT_traceFilename):
                            NOMUT_traceFilename = False

                    if os.path.isfile(traceFilename):
                        distances = td.calcDistance(traceFilename)
                        birthtime = dc.getBirthTime(traceFilename)
                        if not birthtime:
                            birthtime = 'NA'
                        print distances  # Testing
                        print 'Born at: ' + str(birthtime)
                    else:
                        distances = ['NA', 'NA', 'NA', 'NA', 'NA']  # Batman
                        birthtime = ['NA']
                        print indNumber + " trace file missing in /traces_afterPP/ of experiment " + experimentNumber

                    if NOMUT_traceFilename:
                        NOMUT_distances = td.calcDistance(NOMUT_traceFilename)
                        print NOMUT_distances
                    else:
                        NOMUT_distances = ['NA', 'NA', 'NA', 'NA', 'NA']  # Batman
                        print indNumber + " trace file missing in /traces_NOMUT/ of experiment " + experimentNumber


                    # writer.writerow({'Ind_ID': indNumber, 'birthtime': birthtime, 'Exp_Num': experimentNumber,
                    #                  'probability': voxProbability, 'euclideanStep': distances[0],
                    #                  'manhattanStep': distances[1], 'euclideanTotal': distances[2],
                    #                  'manhattanTotal': distances[3], 'lifetime': voxLifetime, 'size': voxCounts[4],
                    #                  'totalMuscles': voxCounts[3], 'totalFat': voxCounts[1], 'totalBone': voxCounts[2],
                    #                  'originalMuscle': voxCounts_orig[3], 'originalFat': voxCounts_orig[1],
                    #                  'originalBone': voxCounts_orig[2], 'originalEuclideanStep': NOMUT_distances[0],
                    #                  'originalManhattanStep': NOMUT_distances[1],
                    #                  'originalEuclideanTotal': NOMUT_distances[2],
                    #                  'originalManhattanTotal': NOMUT_distances[3]})
                    writer.writerow({'Ind_ID': indNumber, 'birthtime': birthtime, 'Exp_Num': experimentNumber,
                                     'probability': voxProbability, 'euclideanStep': distances[0],
                                     'manhattanStep': distances[1], 'euclideanTotal': distances[2],
                                     'manhattanTotal': distances[3], 'lifetime': voxLifetime, 'size': voxCounts[4],
                                     'totalMuscles': voxCounts[3], 'totalFat': voxCounts[1], 'totalBone': voxCounts[2],
                                     'diseasedMuscle': voxCounts_orig[3], 'diseasedFat': voxCounts_orig[1],
                                     'diseasedBone': voxCounts_orig[2], 'diseasedEuclideanStep': NOMUT_distances[0],
                                     'diseasedManhattanStep': NOMUT_distances[1],
                                     'diseasedEuclideanTotal': NOMUT_distances[2],
                                     'diseasedManhattanTotal': NOMUT_distances[3]})
                    # except KeyboardInterrupt:
                    #     quit()

    def voxCounter(self, expNum, filepath, ID):
        if not os.path.isfile(filepath):
            return self.voxCounterError(expNum, filepath, ID)
        try:
            tree = ET.ElementTree(file=filepath)
            root = tree.getroot()
            lifetime = root.find('Simulator').find('StopCondition').find('StopConditionValue').text
            layers = root.find('VXC').find('Structure').find('Data').findall('Layer')
            dna = ""
            for layer in layers:
                dna += str(layer.text).strip()
            dna_length = len(dna)
            count = [dna.count('0'), dna.count('1'), dna.count('2'), (dna.count('3') + dna.count('4')),
                     (dna.count('1') + dna.count('2') + dna.count('3') + dna.count('4'))]
            print count  # Testing
            print "SUM: " + str(sum(count) - count[4])  # Testing
            probability = (count[1] / 1000.0) * 0.5
            print "Probability: " + str(probability)  # Testing
            if dna_length != (sum(count) - count[4]):
                count = ["NA", "NA", "NA", "NA", "NA"]  # Batman
                print "DNA length count error for " + ID + " in /population/ of experiment " + expNum
            return probability, lifetime, count
        except ET.ParseError:
            return self.voxCounterError(expNum, filepath, ID)

    def voxCounterError(self, expNum, filepath, ID):
        count = ["NA", "NA", "NA", "NA", "NA"]  # Batman
        probability = "NA"
        lifetime = "NA"
        print ID + "_vox.vxa file missing in " + filepath + " of experiment " + expNum
        return probability, lifetime, count


if __name__ == "__main__":
    import sys

    if len(sys.argv) >= 2:
        pattern = sys.argv[1]
        if pattern == "null" or pattern == "False":
            pattern = False
    else:
        pattern = False
    if len(sys.argv) == 3:
        outputFile = sys.argv[2]
    else:
        outputFile = False
    dataCol = DataCollector(pattern, outputFile)
    dataCol.dataCollector()
