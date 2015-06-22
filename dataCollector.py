__author__ = 'meta'

import os
from getDistanceForTraceFile import TraceDistance
import csv
import glob
import xml.etree.cElementTree as ET


listing = glob.glob('../EC14-Exp-10*')
td = TraceDistance()
with open('diseaseData.csv', 'a') as csvfile:
    fieldnames = ['Ind_ID', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime_size', 'totalMuscles','totalFat','totalBone']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()

for nestFile in listing:
    print nestFile
    expFolder = nestFile[-2:]
    experimentNumber = str(expFolder)
    popListing = glob.glob(nestFile + "/population/*.vxa")


    for filename in popListing:
        indNumber = filename[:-8]
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
                fieldnames = ['Ind_ID', 'probability','euclideanStep', 'manhattanStep', 'euclideanTotal','manhattanTotal', 'lifetime_size', 'totalMuscles','totalFat','totalBone']
                writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                writer.writerow({'Ind_ID': indNumber, 'probability': probability,'euclideanStep': distances[0], 'manhattanStep': distances[1], 'euclideanTotal': distances[2], 'manhattanTotal': distances[3], 'lifetime_size': lifetime, 'totalMuscles': count_active, 'totalFat': count_soft, 'totalBone': count_hard})
        # except KeyboardInterrupt:
        #     quit()
        except IOError:
           continue

# def calculateLifetime(self,indiv):
#         """Calculates and edits an individual's lifetime based on its genome
#         """
#         tree = ET.ElementTree(file=self.pop_path + str(indiv) + self.suffix_vox)
#         root = tree.getroot()
#         layers = root.find('VXC').find('Structure').find('Data').findall('Layer')
#
#         dna = ""
#         for layer in layers:
#             dna += str(layer.text).strip()
#
#         dna_length = len(dna)
#
#         count_empty = dna.count('0')
#         count_soft = dna.count('1')
#         count_hard = dna.count('2')
#         count_active = dna.count('3') + dna.count('4')
#         count_length = count_empty + count_soft + count_hard + count_active
#
#         if dna_length != count_length:
#             print "DNA length count error!"
#
#         lifetime = self.energy_unit * (self.starting_energy - ((count_soft * self.cost_soft) + (count_active * self.cost_muscle)))
#
#
#     def atrophyMuscles(self,indiv):
#         """Mutates muscle tissue voxels according to some probability in each layer
#         """
#         tree = ET.ElementTree(file=self.pop_path + str(indiv) + self.suffix_vox) #file="./population/" + dna_file
#         root = tree.getroot()
#         layers = root.find('VXC').find('Structure').find('Data').findall('Layer')
#
#         """Calculates probability based on amount of fat tissue
#         """
#         dna = ""
#         for layer in layers:
#             dna += str(layer.text).strip()
#         count_soft = dna.count('1')
#         probability = (count_soft / 1000) * 0.5 # or 0.0005 * count_soft
#
#
#         dna_list = ""
#         for layer in layers:
#             dna_list = list(layer.text.strip())
#             position_to_check = 0
#             for index in range(len(dna_list)):
#                 tissue = dna_list[index]
#                 if tissue == '3' or tissue == '4':
#                     if random.random() <= probability:
#                         dna_list[index] = '2'
#                         print "Atrophied a muscle at index " + str(index) + " to " + str(dna_list[index]) + "."
#                     else:
#                         print "Muscle at index " + str(index) + " unchanged."
#                         pass
#
#                 else:
#                     continue
#)