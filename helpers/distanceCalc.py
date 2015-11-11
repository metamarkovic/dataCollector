import math


class DistanceCalc:
    def __init__(self, **kwargs):
        if "arenaSize" not in kwargs.keys():
            self.arenaSize = (0.25, 0.25)
        else:
            self.arenaSize = kwargs["arenaSize"]

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
                    x_new = float(lineSplit[2])
                    y_new = float(lineSplit[3])
                    x_diff = x - x_new
                    y_diff = y - y_new
                    if abs(x_diff) >= self.arenaSize[0] * 0.8:
                        if x_new > x:
                            x_diff += self.arenaSize[0]
                        else:
                            x_diff -= self.arenaSize[0]
                    if abs(y_diff) >= self.arenaSize[1] * 0.8:
                        if y_new > y:
                            y_diff += self.arenaSize[1]
                        else:
                            y_diff -= self.arenaSize[1]
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
            x_diffs_to_add = []
            y_diffs_to_add = []
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
                    x_new = float(lineSplit[2])
                    y_new = float(lineSplit[3])
                    x_diff = x - x_new
                    y_diff = y - y_new
                    if abs(x_diff) >= self.arenaSize[0] * 0.8:
                        diff_to_add = self.arenaSize[0]
                        if x_new > x:
                            diff_to_add = -diff_to_add
                        x_diffs_to_add.append(diff_to_add)
                    if abs(y_diff) >= self.arenaSize[1] * 0.8:
                        diff_to_add = self.arenaSize[1]
                        if y_new > y:
                            diff_to_add = -diff_to_add
                        y_diffs_to_add.append(diff_to_add)

                x = float(lineSplit[2])
                y = float(lineSplit[3])
                firstRun = False

            if goodline is None:
                return 0
            lastLine = goodline
            x_final = float(lastLine[2]) + sum(x_diffs_to_add)
            y_final = float(lastLine[3]) + sum(y_diffs_to_add)

            x_diff = float(firstLine[2]) - x_final
            y_diff = float(firstLine[3]) - y_final

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
