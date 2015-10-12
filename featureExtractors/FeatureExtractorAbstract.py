class FeatureExtractorAbstract:
    """ Template class for feature extractors
    """

    def getCSVheader(self):
        """ get CSV column headers for this FE

        :return: List of column headers (strings) for the CSV file for this FE
        """
        raise NotImplementedError("FeatureExtractor %s doesn't implement getCSVheader()" % (self.__class__.__name__))

    def extract(self, experiment, type, indiv):
        """ Does the actual extraction of one or multiple features

        :param experiment: triple with experiment number, name of the folder and relative path to the experiment folder
        :param type: sting, ["with disease"|"no disease"]
        :param indiv: tuple with individual ID and path to the population vxa file
        :return: list of feature values
        """
        raise NotImplementedError("FeatureExtractor %s doesn't implement extract()" % (self.__class__.__name__))
