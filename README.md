# dataCollector

Use `python dataCollector.py` for the old data collection script.

Use `python dataCollector2.py` for the new script.
The new script has the following command line parameters **(all of them are optional)**:

* **[output file name]** - (string, default: 'data.csv'), this defines the filename of the CSV output that this script generates

* **[search pattern]** - (string, default: '../EC14-Exp-*'), this defines what folders are searched. Can also be set to "null" to use the default

* **[limit]** - (integer, default: no limit) max number of individuals to get for each experiment

* **[continue]** - (string, default: false) if this is "continue" or "true", then the data collection will not repeat completed experiments


### Example
If you want to name the output file "`abcdef.csv`", you only want experiments that start with a "2", 
you want a maximum of 200 individuals per experiment and you want to continue the previous datacollection (i.e. not collect 
data experiments you already have finished collecting data for), then you would use:

`python dataCollector2.py abcdef.csv ../EC14-Exp-2* 200 continue`
