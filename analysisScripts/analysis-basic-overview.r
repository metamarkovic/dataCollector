cat("\014") # clear the screen

#################### BASIC OVERVIEW #################### 

# load data files
Ddata_ALL <- read.csv("data/data_DISEASE.csv")
Ddata <- read.csv("data/data_DISEASE.cut.csv")
Ldata_ALL <- read.csv("data/Ddata.csv")
Ldata <- read.csv("data/Ddata.cut.csv")

# get the column names in each file
colnames(Ddata)
colnames(Ldata)

# get the experiment numbers in each data file
exp_dis = sort(unique(Ddata_ALL$Exp_Num))
exp_lif = sort(unique(Ldata_ALL$Exp_Num))

# get the number of individuals per experiment in each file
table(Ddata_ALL$Exp_Num)
table(Ddata$Exp_Num)
table(Ldata_ALL$Exp_Num)
table(Ldata$Exp_Num)

head(Ddata)

# extract vectors
D_ID = Ddata$Ind_ID
D_expNum = Ddata$Exp_Num

D_life = Ddata$lifetime
D_prob = Ddata$probability
D_birth = as.numeric(Ddata$birthtime)

D_fat = Ddata$totalFat
D_fat_orig = Ddata$originalFat
D_muscles = Ddata$totalMuscles
D_muscles_orig = Ddata$originalMuscle
D_bone = Ddata$totalBone
D_bone_orig = Ddata$originalBone
D_size = Ddata$size

D_ES = Ddata$euclideanStep
D_ET = Ddata$euclideanTotal
D_MS = Ddata$manhattanStep
D_MT = Ddata$manhattanTotal

L_ID = Ldata$Ind_ID
L_expNum = Ldata$Exp_Num

L_life = Ldata$lifetime
L_prob = Ldata$probability
L_birth = as.numeric(Ldata$birthtime)

L_fat = Ldata$totalFat
L_fat_orig = Ldata$originalFat
L_muscles = Ldata$totalMuscles
L_muscles_orig = Ldata$originalMuscle
L_bone = Ldata$totalBone
L_bone_orig = Ldata$originalBone
L_size = Ldata$size

L_ES = Ldata$euclideanStep
L_ET = Ldata$euclideanTotal
L_MS = Ldata$manhattanStep
L_MT = Ldata$manhattanTotal

