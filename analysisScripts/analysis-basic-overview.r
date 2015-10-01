cat("\014") # clear the screen

#################### BASIC OVERVIEW #################### 

# load data files
Ddata_ALL <- read.csv("data/data_DISEASE.csv")
Ddata <- read.csv("data/data_DISEASE2.cut.csv")
Ldata_ALL <- read.csv("data/data_LIFE.csv")
Ldata <- read.csv("data/data_LIFE3.cut.csv")

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
D_ID = as.numeric(Ddata$Ind_ID)
D_expNum = as.numeric(Ddata$Exp_Num)

D_life = as.numeric(Ddata$lifetime)
D_prob = as.numeric(Ddata$probability)
D_birth = as.numeric(Ddata$birthtime)

D_fat = as.numeric(Ddata$totalFat)
D_fat_orig = as.numeric(Ddata$originalFat)
D_muscles = as.numeric(Ddata$totalMuscles)
D_muscles_orig = as.numeric(Ddata$originalMuscle)
D_bone = as.numeric(Ddata$totalBone)
D_bone_orig = as.numeric(Ddata$originalBone)
D_size = as.numeric(Ddata$size)

D_ES = as.numeric(Ddata$euclideanStep)
D_ET = as.numeric(Ddata$euclideanTotal)
D_MS = as.numeric(Ddata$manhattanStep)
D_MT = as.numeric(Ddata$manhattanTotal)

L_ID = as.numeric(Ldata$Ind_ID)
L_expNum = as.numeric(Ldata$Exp_Num)

L_life = as.numeric(Ldata$lifetime)
L_prob = as.numeric(Ldata$probability)
L_birth = as.numeric(Ldata$birthtime)

L_fat = as.numeric(Ldata$totalFat)
L_fat_orig = as.numeric(Ldata$diseasedFat)
L_muscles = as.numeric(Ldata$totalMuscles)
L_muscles_orig = as.numeric(Ldata$diseasedMuscle)
L_bone = as.numeric(Ldata$totalBone)
L_bone_orig = as.numeric(Ldata$diseasedBone)
L_size = as.numeric(Ldata$size)

L_ES = as.numeric(Ldata$euclideanStep)
L_ET = as.numeric(Ldata$euclideanTotal)
L_MS = as.numeric(Ldata$manhattanStep)
L_MT = as.numeric(Ldata$manhattanTotal)

################# Descriptives ################

mean(D_fat, na.rm = TRUE)
mean(D_muscles, na.rm = TRUE)
mean(D_bone, na.rm = TRUE)
mean(D_size, na.rm = TRUE)

mean(D_bone_orig, na.rm = TRUE)
mean(D_muscles_orig, na.rm = TRUE)

median(D_fat, na.rm = TRUE)
median(D_muscles, na.rm = TRUE)
median(D_bone, na.rm = TRUE)
median(D_size, na.rm = TRUE)

median(D_bone_orig, na.rm = TRUE)
median(D_muscles_orig, na.rm = TRUE)
median(D_fat_orig, na.rm = TRUE)


mean(L_fat, na.rm = TRUE)
mean(L_muscles, na.rm = TRUE)
mean(L_bone, na.rm = TRUE)
mean(L_size, na.rm = TRUE)

mean(L_bone_orig, na.rm = TRUE)
mean(L_muscles_orig, na.rm = TRUE)

median(L_fat, na.rm = TRUE)
median(L_muscles, na.rm = TRUE)
median(L_bone, na.rm = TRUE)
median(L_size, na.rm = TRUE)

median(L_bone_orig, na.rm = TRUE)
median(L_muscles_orig, na.rm = TRUE)
median(L_fat_orig, na.rm = TRUE)

########################## DESCRIPTIVE GRAPHS ##########################

# Make descriptive graphs and save them to folder
png(file = "../graphs/lifetimes_hist.png")
hist(L_size,xlab="Lifetime Length")
# dev.off()

png(file = "~/Documents/dev/thePlague/euclidStep_hist.png")
hist(trace, xlab="Distance Traveled")
# dev.off()

png(file = "~/Documents/dev/thePlague/totalMuscles_hist.png")
hist(muscle, xlab="Number of Muscles")
# dev.off()

png(file = "~/Documents/dev/thePlague/totalFat_hist.png")
hist(fat, xlab="Number of fat cells")
# dev.off()

png(file = "~/Documents/dev/thePlague/totalBone_hist.png")
hist(bone, xlab="Number of bone cells")
# dev.off()