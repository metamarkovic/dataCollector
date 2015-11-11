import os
from helpers.config import PathConfig


class GetAltFile():

    @staticmethod
    def getAltTraceFile(experiment, type, indiv):
        conf = PathConfig()
        tPath = conf.traceFoldersAlt[type]
        filepath = experiment[2] + os.path.sep + "{}" + os.path.sep + indiv[0] + ".trace"
        if os.path.isfile(filepath.format(tPath)):
            return filepath.format(tPath)
        else:
            tPath = conf.traceFoldersAlt[conf.getOtherType(type)]
            if os.path.isfile(filepath.format(tPath)):
                return filepath.format(tPath)
            else:
                return False

    @staticmethod
    def getAltPopFile(experiment, type, indiv):
        conf = PathConfig()
        tPath = conf.populationFoldersAlt[type]
        filepath = experiment[2] + os.path.sep + "{}" + os.path.sep + indiv[0] + "_vox.vxa"
        if os.path.isfile(filepath.format(tPath)):
            return filepath.format(tPath)
        else:
            tPath = conf.populationFoldersAlt[conf.getOtherType(type)]
            if os.path.isfile(filepath.format(tPath)):
                return filepath.format(tPath)
            else:
                return False
