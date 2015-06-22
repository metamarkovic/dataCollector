__author__ = 'meta'

import os
from getDistanceForTraceFile import TraceDistance
import csv
import glob
import xml.etree.cElementTree as ET


listing = glob.glob('../EC14-Exp-10*')
td = TraceDistance()
with open('diseaseData.csv', 'a') as csvfile:
    fieldnames = ['Ind_ID', 'Exp_Num', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime_size', 'totalMuscles','totalFat','totalBone']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

print listing
for nestFile in listing:
    print nestFile
    expFolder = nestFile[-2:]
    experimentNumber = str(expFolder)
    popListing = glob.glob(nestFile + "/population/*.vxa")


    for filename in popListing:
        indNumber = filename[27:-8]
        print filename

        print indNumber # Testing

        tree = ET.ElementTree(file=filename)
        root = tree.getroot()
        lifetime = root.find('Simulator').find('StopCondition').find('StopConditionValue').text
        layers = root.find('VXC').find('Structure').find('Data').findall('Layer')

        dna = ""
        for layer in layers:
            dna += str(layer.text).strip()

        dna_length = len(dna)

        count_empty = dna.count('0')
        count_soft = dna.count('1')
        count_hard = dna.count('2')
        count_active = dna.count('3') + dna.count('4')
        count_length = count_empty + count_soft + count_hard + count_active
        if dna_length != count_length:
            print "DNA length count error!"

        probability = (count_soft / 1000.0) * 0.5

        traceFilename = os.path.abspath(nestFile + "/traces_afterPP/" + indNumber + ".trace")
        # print indFilename
        try:
            distances = td.calcDistance(traceFilename)
            print distances

            with open('diseaseData.csv', 'a') as csvfile:
                fieldnames = ['Ind_ID', 'Exp_Num', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime_size', 'totalMuscles','totalFat','totalBone']
                writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                writer.writerow({'Ind_ID': indNumber, 'Exp_Num': experimentNumber, 'probability': probability,'euclideanStep': distances[0], 'manhattanStep': distances[1], 'euclideanTotal': distances[2], 'manhattanTotal': distances[3], 'lifetime_size': lifetime, 'totalMuscles': count_active, 'totalFat': count_soft, 'totalBone': count_hard})
        # except KeyboardInterrupt:
        #     quit()
        except IOError:
           continue