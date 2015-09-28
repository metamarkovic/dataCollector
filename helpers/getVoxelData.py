import xml.etree.cElementTree as ET


class VoxelData:
    filename = ""
    root = None
    dna = ""
    types = {
        "fat": [1],
        "bone": [2],
        "muscle": [3, 4]
    }
    nullType = 0
    absCounts = {}
    relCounts = {}

    def __init__(self, filename):
        self.filename = filename
        tree = ET.ElementTree(file=filename)
        self.root = tree.getroot()

    def getLifeTime(self):
        try:
            return self.root.find('Simulator').find('StopCondition').find('StopConditionValue').text
        except ET.ParseError:
            return False

    def getDNA(self):
        try:
            layers = self.root.find('VXC').find('Structure').find('Data').findall('Layer')
            self.dna = ""
            for layer in layers:
                self.dna += str(layer.text).strip()
            return self.dna
        except ET.ParseError:
            return False

    def getAbsCounts(self):
        if self.dna == "":
            res = self.getDNA()
            if not res:
                return False
        out = {}
        for typeName, typeNumbers in self.types.iteritems():
            out[typeName] = 0
            for tn in typeNumbers:
                out[typeName] += self.dna.count(str(tn))
        self.absCounts = out
        return out

    def getRelCounts(self):
        if self.absCounts == {}:
            res = self.getAbsCounts()
            if not res:
                return False
        out = {}
        totalCount = sum(self.absCounts.values())
        for typeName, typeNumbers in self.types.iteritems():
            out[typeName] = round(float(self.absCounts[typeName])/totalCount,3)
        self.relCounts = out
        return out


if __name__ == "__main__":
    vd = VoxelData("../vxa/404_vox.vxa")
    print vd.getLifeTime()
    dna = vd.getDNA()
    print dna
    print len(dna)
    print vd.getAbsCounts()
    print vd.getRelCounts()

