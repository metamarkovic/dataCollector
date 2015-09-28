class PathConfig:
    types = ["no disease", "with disease"]  # index 0 = no dis, index 1 = with dis
    traceFolderNormal = "traces_afterPP"
    traceFoldersAlt = {
        "with disease": "traces_NOMUT",
        "no disease": "traces_MUT"
    }
    populationFolderNormal = "population"
    populationFoldersAlt = {
        # if the original population has the disease ("with disease"), then there is a pop folder without disease ("..._beforePL")
        "with disease": "population_beforePL",
        # if the original population has no disease then there is a folder with additional mutation
        "no disease": "population_MUT"
    }

    def getOtherType(self, type):
        if type == self.types[0]:
            return self.types[1]
        else:
            return self.types[0]
