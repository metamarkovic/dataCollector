class PathConfig:
    types = ["no disease", "with disease"] # index 0 = no dis, index 1 = with dis
    traceFolderNormal = "traces_afterPP"
    traceFoldersAlt = {
        "with disease": "traces_NOMUT",
        "no disease": "traces_MUT"
    }
    populationFolderNormal = "population"
    populationFoldersAlt = {
        "with disease": "population_beforePL",
        "no disease": "population_MUT"
    }

    def getOtherType(self, type):
        if type == self.types[0]:
            return self.types[1]
        else:
            return self.types[0]