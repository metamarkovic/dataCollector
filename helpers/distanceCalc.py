import math


class DistanceCalc:
    def isValidLine(self, lineSplit):
        return len(lineSplit) == 5 and self.sameAsFloat(lineSplit[2]) and self.sameAsFloat(lineSplit[3])

    def distanceStep(self, filename, type):
        with open(filename, 'r') as inputFile:
            firstRun = True
            dist = 0
            for line in inputFile:
                lineSplit = line.split("\t")
                if not self.isValidLine(lineSplit):
                    lineSplit = line.split(" ")
                    if not self.isValidLine(lineSplit):
                        continue
                if not firstRun:
                    x_diff = x - float(lineSplit[2])
                    y_diff = y - float(lineSplit[3])
                    if type == "euclidean":
                        dist += math.sqrt((x_diff ** 2) + (y_diff ** 2))
                    if type == "manhattan":
                        dist += math.fabs(x_diff) + math.fabs(y_diff)

                x = float(lineSplit[2])
                y = float(lineSplit[3])
                firstRun = False
            return dist

    def distanceTotal(self, filename, type):
        with open(filename, 'r') as inputFile:
            firstRun = True
            firstLine = []
            lastLine = []
            lineSplit = []
            goodline = None
            for line in inputFile:
                lineSplit = line.split("\t")
                if not self.isValidLine(lineSplit):
                    lineSplit = line.split(" ")
                    if not self.isValidLine(lineSplit):
                        continue
                goodline = lineSplit
                if firstRun:
                    firstLine = lineSplit
                else:
                    pass
                firstRun = False

            if goodline is None:
                return 0
            lastLine = goodline
            x_diff = float(firstLine[2]) - float(lastLine[2])
            y_diff = float(firstLine[3]) - float(lastLine[3])
            if type == "euclidean":
                return math.sqrt((x_diff ** 2) + (y_diff ** 2))
            if type == "manhattan":
                return math.fabs(x_diff) + math.fabs(y_diff)

    @staticmethod
    def getBirthTime(filename):
        with open(filename, 'r') as inputFile:
            for line in inputFile:
                lineSplit = line.split("\t")
                if len(lineSplit) != 5:
                    return False
                else:
                    return float(lineSplit[1])

    @staticmethod
    def sameAsFloat(input):
        try:
            floatInput = float(input)
            return str(floatInput) == str(input)
        except ValueError:
            return False


if __name__ == "__main__":  # this is for testing only
    inFile = "data/1987.pp.trace"
    dc = DistanceCalc()
    print dc.distanceStep(inFile, "euclidean")
    print dc.distanceTotal(inFile, "euclidean")
