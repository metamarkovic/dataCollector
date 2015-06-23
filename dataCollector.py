__author__ = 'meta'

import os
from getDistanceForTraceFile import TraceDistance
import csv
import glob
import xml.etree.cElementTree as ET


listing = glob.glob('../EC14-Exp-10*')
td = TraceDistance()
with open('diseaseData.csv', 'a') as csvfile:
    fieldnames = ['Ind_ID', 'Exp_Num', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime_size', 'totalMuscles','totalFat','totalBone','originalFat','originalBone']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
print listing # Testing
for nestFile in listing:
    # print nestFile # Testing
    expFolder = nestFile[-2:]
    experimentNumber = str(expFolder)
    popListing = glob.glob(nestFile + "/population/*.vxa")


    for filename in popListing:
        indNumber = filename[27:-8]
        # print filename # Testing
        print indNumber # Testing

        try:
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

            probability = (count_soft / 1000.0) * 0.5

            if dna_length != count_length:
                count_empty = 'NA'
                count_soft = 'NA'
                count_hard = 'NA'
                count_active = 'NA'

                print "DNA length count error for " + indNumber + " in /population/ of experiment " + experimentNumber


        except ET.ParseError:
            count_empty = 'NA'
            count_soft = 'NA'
            count_hard = 'NA'
            count_active = 'NA'

            probability = 'NA'

            print indNumber + "_vox.vxa file missing in /population/ of experiment " + experimentNumber
            pass

        filename2 = filename[:26] + '_beforePL/' + indNumber + filename[-8:]
        try:
            tree2 = ET.ElementTree(file=filename2)
            root2 = tree2.getroot()
            lifetime2 = root2.find('Simulator').find('StopCondition').find('StopConditionValue').text
            layers2 = root2.find('VXC').find('Structure').find('Data').findall('Layer')

            dna2 = ""
            for layer2 in layers2:
                dna2 += str(layer2.text).strip()

            dna_length2 = len(dna2)

            count_empty2 = dna2.count('0')
            count_soft2 = dna2.count('1')
            count_hard2 = dna2.count('2')
            count_active2 = dna2.count('3') + dna2.count('4')
            count_length2 = count_empty2 + count_soft2 + count_hard2 + count_active2


            print probability
            print "after: " + str(count_soft2)
            print "before: " + str(count_soft)

            if dna_length2 != count_length2:
                count_empty2 = 'NA'
                count_soft2 = 'NA'
                count_hard2 = 'NA'
                count_active2 = 'NA'
                print "DNA length count error for " + indNumber + " in /population_beforePL/ of experiment " + experimentNumber


        except ET.ParseError:
            count_empty2 = 'NA'
            count_soft2 = 'NA'
            print indNumber + "_vox.vxa file missing in /population_beforePL/ of experiment " + experimentNumber
            pass


        traceFilename = os.path.abspath(nestFile + "/traces_afterPP/" + indNumber + ".trace")
        # print indFilename
        try:
            distances = td.calcDistance(traceFilename)
            # print distances
        except IOError:
            distances = ['NA', 'NA', 'NA', 'NA']
            print indNumber +  " trace file missing in /traces_afterPP/ of experiment " + experimentNumber
            continue

        with open('diseaseData.csv', 'a') as csvfile:
            fieldnames = ['Ind_ID', 'Exp_Num', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime_size', 'totalMuscles','totalFat','totalBone','originalFat','originalBone']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writerow({'Ind_ID': indNumber, 'Exp_Num': experimentNumber, 'probability': probability,'euclideanStep': distances[0], 'manhattanStep': distances[1], 'euclideanTotal': distances[2], 'manhattanTotal': distances[3], 'lifetime_size': lifetime, 'totalMuscles': count_active, 'totalFat': count_soft, 'totalBone': count_hard,'originalFat': count_soft2,'originalBone': count_hard2})
        # except KeyboardInterrupt:
        #     quit()
