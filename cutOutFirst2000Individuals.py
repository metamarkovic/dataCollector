import sys

""" write new dataset with only 2000 indiv per experiment

    This script cuts out the first N (default: 2000) individuals
    of each experiment for a given dataset and writes them to a new
    dataset.

    parameters:
        [dataset location] file path to dataset (CSV file)
        [number of individuals to keep] copy only so many individuals to the new dataset
"""

inFile = "data/data_DISEASE.csv"
cutNumber = 2000
if len(sys.argv) >= 2:
    inFile = sys.argv[1]
else:
    print "Trying to use default data file. If this fails, please provide a file " \
          "location as parameter when calling the script like: " \
          "'python cutOutFirst2000Individuals.py data/new_data.csv'\n"
    print "As a second parameter you can provide the number of individuals to keep per experiment. " \
          "The default (if omitted) is 2000 (duh).\n"

if len(sys.argv) == 3:
    cutNumber = int(sys.argv[2])

filenameSplit = inFile.split(".")
outFile = ".".join(filenameSplit[:-1])+".cut.csv"

print "writing output file: "+outFile
firstLine = True
exp = ""
expColumnIndex = 2
with open(outFile, 'w') as ouf:
    with open(inFile, 'r') as inf:
        for line in inf:
            lineContent = line.split(",")
            if firstLine:
                ouf.write(line)
                expColumnIndex = lineContent.index("Exp_Num")
                firstLine = False
                continue

            lineExp = int(lineContent[expColumnIndex])
            if exp == "" or lineExp != exp:
                exp = lineExp
                expCounter = 0
            if expCounter < cutNumber:
                ouf.write(line)
            expCounter += 1

print "done"
