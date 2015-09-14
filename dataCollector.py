__author__ = 'meta'

import os
from getDistanceForTraceFile import TraceDistance
from distanceCalc import DistanceCalc
import csv
import glob
import xml.etree.cElementTree as ET


class DataCollector:
    fieldnames = ['Ind_ID', 'birthtime', 'Exp_Num', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime','size', 'totalMuscles','totalFat','totalBone','originalMuscle','originalFat','originalBone','originalEuclideanStep', 'originalManhattanStep', 'originalEuclideanTotal','originalManhattanTotal']

    def dataCollector(self):
        listing = glob.glob('../EC14-Exp-1*')
        td = TraceDistance()
        dc = DistanceCalc()
        with open('diseaseData.csv', 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=self.fieldnames)
            writer.writeheader()
            print  listing # Testing
            for nestFile in listing:
                print "Experiment folder: " + nestFile # Testing
                expFolder = nestFile[-2:]
                experimentNumber = str(expFolder)
                popListing = glob.glob(nestFile + "/population/*.vxa")
                for path in popListing:
                    indNumber = path[27:-8]
                    print "Population path: " + path # Testing
                    print "Ind. ID: " + indNumber # Testing
                    backup_path = os.path.abspath(nestFile + "/population_beforePL/" + indNumber + "_vox.vxa")
                    print "Backups path: " + backup_path # Testing
                    voxProbability, voxLifetime, voxCounts = self.voxCounter(experimentNumber,path, indNumber)
                    voxProb_orig, voxProbLife_orig, voxCounts_orig = self.voxCounter(experimentNumber,backup_path, indNumber)

                    traceFilename = os.path.abspath(nestFile + "/traces_afterPP/" + indNumber + ".trace")
                    NOMUT_traceFilename = os.path.abspath(nestFile + "/traces_NOVIRUS/" + indNumber + ".trace")
                    try:
                        distances = td.calcDistance(traceFilename)
                        birthtime = dc.getBirthTime(traceFilename)
                        print distances # Testing
                        print 'Born at: ' + str(birthtime)
                    except IOError:
                        distances = ['NA', 'NA', 'NA', 'NA', 'NA']
                        birthtime = ['NA']
                        print indNumber +  " trace file missing in /traces_afterPP/ of experiment " + experimentNumber

                    try:
                        NOMUT_distacnes = td.calcDistance(NOMUT_traceFilename)
                        print NOMUT_distacnes
                    except IOError:
                        NOMUT_distacnes = ['NA', 'NA', 'NA', 'NA', 'NA']
                        print indNumber +  " trace file missing in /traces_NOMUT/ of experiment " + experimentNumber

                    writer.writerow({'Ind_ID': indNumber,'birthtime': birthtime, 'Exp_Num': experimentNumber, 'probability': voxProbability, 'euclideanStep': distances[0], 'manhattanStep': distances[1], 'euclideanTotal': distances[2], 'manhattanTotal': distances[3], 'lifetime': voxLifetime, 'size': voxCounts[4], 'totalMuscles': voxCounts[3], 'totalFat': voxCounts[1], 'totalBone': voxCounts[2],'originalMuscle': voxCounts_orig[3],'originalFat': voxCounts_orig[1],'originalBone': voxCounts_orig[2],'originalEuclideanStep':NOMUT_distacnes[0], 'originalManhattanStep':NOMUT_distacnes[1], 'originalEuclideanTotal':NOMUT_distacnes[2],'originalManhattanTotal':NOMUT_distacnes[3]})
                    # except KeyboardInterrupt:
                    #     quit()


    def voxCounter(self, expNum, filepath, ID):
        try:
            tree = ET.ElementTree(file=filepath)
            root = tree.getroot()
            lifetime = root.find('Simulator').find('StopCondition').find('StopConditionValue').text
            layers = root.find('VXC').find('Structure').find('Data').findall('Layer')
            dna = ""
            for layer in layers:
                dna += str(layer.text).strip()
            dna_length = len(dna)
            count = [dna.count('0'),dna.count('1'),dna.count('2'),(dna.count('3') + dna.count('4')),(dna.count('1') + dna.count('2') + dna.count('3') + dna.count('4'))]
            print count # Testing
            print "SUM: " + str(sum(count)-count[4]) # Testing
            probability = (count[1] / 1000.0) * 0.5
            print "Probability: " + str(probability) # Testing
            if dna_length != (sum(count)-count[4]):
                count = ["NA","NA","NA","NA","NA"]
                print "DNA length count error for " + ID + " in /population/ of experiment " + expNum
        except ET.ParseError:
            count = ["NA","NA","NA","NA","NA"]
            probability = "NA"
            lifetime = "NA"
            print ID + "_vox.vxa file missing in " + filepath + " of experiment " + expNum
        return (probability, lifetime, count)

dataCol = DataCollector()
dataCol.dataCollector()
