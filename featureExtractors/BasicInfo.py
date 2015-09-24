from FeatureExtractorAbstract import FeatureExtractorAbstract


class BasicInfo(FeatureExtractorAbstract):
    def getCSVheader(self):
        return ['Ind_ID', 'Exp_Num', 'Exp_type']

    def extract(self, experiment, type, indiv):
        if type == "no disease":
            t = "wd"
        else:
            t = "nd"

        return [indiv[0], experiment[0], t]
