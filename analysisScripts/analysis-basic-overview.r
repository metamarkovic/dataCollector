cat("\014") # clear the screen

#################### BASIC OVERVIEW #################### 

# load data files
# Ddata_ALL <- read.csv("data/data_DISEASE.csv")
Ddata <- read.csv("data/data_DISEASE2.cut.csv")
# Ldata_ALL <- read.csv("data/data_LIFE.csv")
Ldata <- read.csv("data/data_LIFE3.cut.csv")

# get the column names in each file
colnames(Ddata)
colnames(Ldata)

# get the experiment numbers in each data file
exp_dis = sort(unique(DdataL$Exp_Num))
exp_lif = sort(unique(Ldata$Exp_Num))

# get the number of individuals per experiment in each file
# table(Ddata_ALL$Exp_Num)
table(Ddata$Exp_Num)
# table(Ldata_ALL$Exp_Num)
table(Ldata$Exp_Num)

head(Ddata)

# extract vectors
D_ID = Ddata$Ind_ID
D_expNum = Ddata$Exp_Num
D_expTy = Ddata$Exp_type

D_life = Ddata$lifetime
D_prob = Ddata$probability
D_ESspeed = D_ES/D_life
D_ETspeed = D_ET/D_life
D_aESspeed = D_aES/D_life
D_aETspeed = D_aET/D_life

D_rBone = Ddata$relCellCountBone
D_rMuscle = Ddata$relCellCountMuscle
D_rFat = Ddata$relCellCountFat

D_aBone = Ddata$absCellCountBone
D_aMuscle = Ddata$absCellCountMuscle
D_aFat = Ddata$absCellCountFat

D_ES = Ddata$euclideanStep
D_ET = Ddata$euclideanTotal
D_MS = Ddata$manhattanStep
D_MT = Ddata$manhattanTotal

D_aES = Ddata$euclideanStepAlt
D_aET = Ddata$euclideanTotalAlt
D_aMS = Ddata$manhattanStepAlt
D_aMT = Ddata$manhattanTotalAlt

L_ID = Ldata$Ind_ID
L_expNum = Ldata$Exp_Num
L_expTy = Ldata$Exp_type

L_life = Ldata$lifetime
L_prob = Ldata$probability
L_ESspeed = L_ES/L_life
L_ETspeed = L_ET/L_life
L_aESspeed = L_aES/L_life
L_aETspeed = L_aET/L_life

L_rBone = Ldata$relCellCountBone
L_rMuscle = Ldata$relCellCountMuscle
L_rFat = Ldata$relCellCountFat

L_aBone = Ldata$absCellCountBone
L_aMuscle = Ldata$absCellCountMuscle
L_aFat = Ldata$absCellCountFat

L_ES = Ldata$euclideanStep
L_ET = Ldata$euclideanTotal
L_MS = Ldata$manhattanStep
L_MT = Ldata$manhattanTotal

L_aES = Ldata$euclideanStepAlt
L_aET = Ldata$euclideanTotalAlt
L_aMS = Ldata$manhattanStepAlt
L_aMT = Ldata$manhattanTotalAlt

################# DESCRIPTIVES ################

# mean compositions

mean(D_rFat, na.rm = TRUE)
mean(D_rMuscle, na.rm = TRUE)
mean(D_rBone, na.rm = TRUE)
mean(D_aFat, na.rm = TRUE)
mean(D_aMuscle, na.rm = TRUE)
mean(D_aBone, na.rm = TRUE)
# mean(D_size, na.rm = TRUE)

mean(L_rFat, na.rm = TRUE)
mean(L_rMuscle, na.rm = TRUE)
mean(L_rBone, na.rm = TRUE)
mean(L_aFat, na.rm = TRUE)
mean(L_aMuscle, na.rm = TRUE)
mean(L_aBone, na.rm = TRUE)

# median distances

mean(L_ES, na.rm = TRUE)
mean(L_ET, na.rm = TRUE)
mean(L_MS, na.rm = TRUE)
mean(L_MT, na.rm = TRUE)

mean(L_aES, na.rm = TRUE)
mean(L_aET, na.rm = TRUE)
mean(L_aMS, na.rm = TRUE)
mean(L_aMT, na.rm = TRUE)

mean(D_ES, na.rm = TRUE)
mean(D_ET, na.rm = TRUE)
mean(D_MS, na.rm = TRUE)
mean(D_MT, na.rm = TRUE)

mean(D_aES, na.rm = TRUE)
mean(D_aET, na.rm = TRUE)
mean(D_aMS, na.rm = TRUE)
mean(D_aMT, na.rm = TRUE)




# median compositions
median(D_rFat, na.rm = TRUE)
median(D_rMuscle, na.rm = TRUE)
median(D_rBone, na.rm = TRUE)
median(D_aFat, na.rm = TRUE)
median(D_aMuscle, na.rm = TRUE)
median(D_aBone, na.rm = TRUE)
# median(D_size, na.rm = TRUE)

median(L_rFat, na.rm = TRUE)
median(L_rMuscle, na.rm = TRUE)
median(L_rBone, na.rm = TRUE)
median(L_aFat, na.rm = TRUE)
median(L_aMuscle, na.rm = TRUE)
median(L_aBone, na.rm = TRUE)

# median distances

median(L_ES, na.rm = TRUE)
median(L_ET, na.rm = TRUE)
median(L_MS, na.rm = TRUE)
median(L_MT, na.rm = TRUE)

median(L_aES, na.rm = TRUE)
median(L_aET, na.rm = TRUE)
median(L_aMS, na.rm = TRUE)
median(L_aMT, na.rm = TRUE)

median(D_ES, na.rm = TRUE)
median(D_ET, na.rm = TRUE)
median(D_MS, na.rm = TRUE)
median(D_MT, na.rm = TRUE)

median(D_aES, na.rm = TRUE)
median(D_aET, na.rm = TRUE)
median(D_aMS, na.rm = TRUE)
median(D_aMT, na.rm = TRUE)

########################## PLOTS ########################## 

# Scatter plots

# 4 figures arranged in 2 rows and 2 columns


# relative voxels
png(file = "graphs/relativeVoxels_scatter.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,3))

plot(L_ID, L_rFat, main="(Relative) number of fat voxels over time in Life condition", 
     xlab="Individual ID", ylab="Number of fat voxels ", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_rFat~L_ID), lwd=2, col="red")
plot(L_ID, L_rMuscle, main="(Relative) number of Muscle voxels over time in Life conditon", 
     xlab="Individual ID", ylab="Number of Muscle voxels ", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_rMuscle~L_ID), lwd=2, col="blue")
plot(L_ID, L_rBone, main="(Relative) number of bone voxels over time in Life conditon", 
     xlab="Individual ID", ylab="Number of bone voxels ", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_rBone~L_ID), lwd=2, col="green")

plot(D_ID, D_rFat, main="(Relative) number of fat voxels over time in Disease condition", 
     xlab="Individual ID", ylab="Number of fat voxels ", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_rFat~D_ID), lwd=2, col="red")
plot(D_ID, D_rMuscle, main="(Relative) number of Muscle voxels over time in Disease conditon", 
     xlab="Individual ID", ylab="Number of Muscle voxels ", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_rMuscle~D_ID), lwd=2, col="blue")
plot(D_ID, D_rBone, main="(Relative) number of bone voxels over time in Disease conditon", 
     xlab="Individual ID", ylab="Number of bone voxels ", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_rBone~D_ID), lwd=2, col="green")
dev.off()

# absolute voxels
png(file = "graphs/absoluteVoxels_scatter.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,3))

plot(L_ID, L_aFat, main="(Absolute) number of fat voxels over time in Life condition", 
     xlab="Individual ID", ylab="Number of fat voxels ", xlim=c(0, 2100), ylim=c(0, 500), pch=1)
abline(lm(L_aFat~L_ID), lwd=2, col="red")
plot(L_ID, L_aMuscle, main="(Absolute) number of muscle voxels over time in Life condition", 
     xlab="Individual ID", ylab="Number of muscle voxels ", xlim=c(0, 2100), ylim=c(0, 500), pch=1)
abline(lm(L_aMuscle~L_ID), lwd=2, col="blue")
plot(L_ID, L_aBone, main="(Absolute) number of bone voxels over time in Life condition", 
     xlab="Individual ID", ylab="Number of bone voxels ", xlim=c(0, 2100), ylim=c(0, 500), pch=1)
abline(lm(L_aBone~L_ID), lwd=2, col="green")

plot(D_ID, D_aFat, main="(Absolute) number of fat voxels over time in Disease condition", 
     xlab="Individual ID", ylab="Number of fat voxels ", xlim=c(0, 2100), ylim=c(0, 500), pch=1)
abline(lm(D_aFat~D_ID), lwd=2, col="red")
plot(D_ID, D_aMuscle, main="(Absolute) number of muscle voxels over time in Disease condition", 
     xlab="Individual ID", ylab="Number of muscle voxels ", xlim=c(0, 2100), ylim=c(0, 500), pch=1)
abline(lm(D_aMuscle~D_ID), lwd=2, col="blue")
plot(D_ID, D_aBone, main="(Absolute) number of bone voxels over time in Disease condition", 
     xlab="Individual ID", ylab="Number of bone voxels ", xlim=c(0, 2100), ylim=c(0, 500), pch=1)
abline(lm(D_aBone~D_ID), lwd=2, col="green")
dev.off()

# linear models - voxels

# relative
lm(L_rFat~L_ID)
lm(L_rMuscle~L_ID)
lm(L_rBone~L_ID)

lm(D_rFat~D_ID)
lm(D_rMuscle~D_ID)
lm(D_rBone~D_ID)

# absolute
lm(L_aFat~L_ID)
lm(L_aMuscle~L_ID)
lm(L_aBone~L_ID)

lm(D_aFat~D_ID)
lm(D_aMuscle~D_ID)
lm(D_aBone~D_ID)

################ DISTANCE TO TIME ################
png(file = "graphs/stepDistance_ID.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,2))

plot(L_ID, L_ES, main="Step distance traveled over time in Life condition", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_ES~L_ID), lwd=2, col="red")
plot(L_ID, L_aES, main="Step distance traveled over time in alternative Life conditon", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_aES~L_ID), lwd=2, col="red")


plot(D_ID, D_ES, main="Step distance traveled over time in Disease condition", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_ES~D_ID), lwd=2, col="green")
plot(D_ID, D_aES, main="Step distance traveled over time in alternative in Disease conditon", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_aES~D_ID), lwd=2, col="green")
dev.off()

lm(L_aES~L_ID)
lm(D_aES~D_ID)

png(file = "graphs/totalDistance_ID.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,2))

plot(L_ID, L_ET, main="Step distance traveled over time in Life condition", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_ET~L_ID), lwd=2, col="red")
plot(L_ID, L_aET, main="Step distance traveled over time in alternative Life conditon", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(L_aET~L_ID), lwd=2, col="red")


plot(D_ID, D_ET, main="Step distance traveled over time in Disease condition", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_ET~D_ID), lwd=2, col="green")
plot(D_ID, D_aET, main="Step distance traveled over time in alternative in Disease conditon", 
     xlab="Individual ID", ylab="Step distance traveled", xlim=c(0, 2100), ylim=c(0, 0.5), pch=1)
abline(lm(D_aET~D_ID), lwd=2, col="green")
dev.off()

lm(L_aET~L_ID)
lm(D_aET~D_ID)

################ STEP DISTANCE COMPOSITION ################ 

png(file = "graphs/stepDistLife_comp.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,3))

plot(L_aFat, L_ES, main="(Absolute) number of fat voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0, 5), pch=1)
abline(lm(L_ES~L_aFat), lwd=2, col="red")
plot(L_aMuscle, L_ES, main="(Absolute) number of muscle voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0, 5), pch=1)
abline(lm(L_ES~L_aMuscle), lwd=2, col="blue")
plot(L_aBone, L_ES, main="(Absolute) number of bone voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0, 5), pch=1)
abline(lm(L_ES~L_aBone), lwd=2, col="green")

plot(L_aFat, L_aES, main="(Absolute) number of fat voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0, 5), pch=1)
abline(lm(L_aES~L_aFat), lwd=2, col="red")
plot(L_aMuscle, L_aES, main="(Absolute) number of muscle voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0, 5), pch=1)
abline(lm(L_aES~L_aMuscle), lwd=2, col="blue")
plot(L_aBone, L_aES, main="(Absolute) number of bone voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0, 5), pch=1)
abline(lm(L_aES~L_aBone), lwd=2, col="green")
dev.off()

png(file = "graphs/stepDistLife_relComp_closeup.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,3))

plot(L_rFat, L_ES, main="(Absolute) number of fat voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0,1), pch=1)
abline(lm(L_ES~L_rFat), lwd=2, col="red")
plot(L_rMuscle, L_ES, main="(Absolute) number of muscle voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0,1), pch=1)
abline(lm(L_ES~L_rMuscle), lwd=2, col="blue")
plot(L_rBone, L_ES, main="(Absolute) number of bone voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0,1), pch=1)
abline(lm(L_ES~L_rBone), lwd=2, col="green")

plot(L_rFat, L_aES, main="(Absolute) number of fat voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0,1), pch=1)
abline(lm(L_aES~L_rFat), lwd=2, col="red")
plot(L_rMuscle, L_aES, main="(Absolute) number of muscle voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0,1), pch=1)
abline(lm(L_aES~L_rMuscle), lwd=2, col="blue")
plot(L_rBone, L_aES, main="(Absolute) number of bone voxels over time in Life condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0,1), pch=1)
abline(lm(L_aES~L_rBone), lwd=2, col="green")
dev.off()

png(file = "graphs/stepDistDisease_comp.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,3))

plot(D_aFat, D_ES, main="(Absolute) number of fat voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0, 5), pch=1)
abline(lm(D_ES~D_aFat), lwd=2, col="red")
plot(D_aMuscle, D_ES, main="(Absolute) number of muscle voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0, 5), pch=1)
abline(lm(D_ES~D_aMuscle), lwd=2, col="blue")
plot(D_aBone, D_ES, main="(Absolute) number of bone voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0, 5), pch=1)
abline(lm(D_ES~D_aBone), lwd=2, col="green")

plot(D_aFat, D_aES, main="(Absolute) number of fat voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0, 5), pch=1)
abline(lm(D_aES~D_aFat), lwd=2, col="red")
plot(D_aMuscle, D_aES, main="(Absolute) number of muscle voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0, 5), pch=1)
abline(lm(D_aES~D_aMuscle), lwd=2, col="blue")
plot(D_aBone, D_aES, main="(Absolute) number of bone voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0, 5), pch=1)
abline(lm(D_aES~D_aBone), lwd=2, col="green")
dev.off()

png(file = "graphs/stepDistDisease_relComp_closeup.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(2,3))

plot(D_rFat, D_ES, main="(Absolute) number of fat voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0,1), pch=1)
abline(lm(D_ES~D_rFat), lwd=2, col="red")
plot(D_rMuscle, D_ES, main="(Absolute) number of muscle voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0,1), pch=1)
abline(lm(D_ES~D_rMuscle), lwd=2, col="blue")
plot(D_rBone, D_ES, main="(Absolute) number of bone voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0,1), pch=1)
abline(lm(D_ES~D_rBone), lwd=2, col="green")

plot(D_rFat, D_aES, main="(Absolute) number of fat voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of fat voxels ", ylim=c(0,1), pch=1)
abline(lm(D_aES~D_rFat), lwd=2, col="red")
plot(D_rMuscle, D_aES, main="(Absolute) number of muscle voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of muscle voxels ", ylim=c(0,1), pch=1)
abline(lm(D_aES~D_rMuscle), lwd=2, col="blue")
plot(D_rBone, D_aES, main="(Absolute) number of bone voxels over time in Disease condition", 
     xlab="Step distance traveled", ylab="Number of bone voxels ", ylim=c(0,1), pch=1)
abline(lm(D_aES~D_rBone), lwd=2, col="green")
dev.off()

################ STEP DISTANCE TO PROBABILITY ################ 

# all together now
png(file = "graphs/stepDistProb.png", width=1500, height=1500)
attach(mtcars)
par(mfrow=c(2,2))

plot(L_prob, L_ES, type="p", main="Distance to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 6))
abline(lm(L_ES~L_prob), lwd=2, col="blue")

plot(D_prob, D_ES, type="p", main="Distance to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 0.5))
abline(lm(D_ES~D_prob), lwd=2, col="green")

plot(L_prob, L_aES, type="p", main="Distance to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 6))
abline(lm(L_aES~L_prob), lwd=2, col="blue")

plot(D_prob, D_aES, type="p", main="Distance to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 0.5))
abline(lm(D_aES~D_prob), lwd=2, col="green")
dev.off()

# only life
png(file = "graphs/stepDistProbb_Life.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(L_prob, L_ES, type="p", main="Distance to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 2))
abline(lm(L_ES~L_prob), lwd=2, col="blue")

plot(L_prob, L_aES, type="p", main="Distance to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 2))
abline(lm(L_aES~L_prob), lwd=2, col="blue")
dev.off()

# only disease
png(file = "graphs/stepDistProb_Disease.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(D_prob, D_ES, type="p", main="Distance to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 0.5))
abline(lm(D_ES~D_prob), lwd=2, col="green")

plot(D_prob, D_aES, type="p", main="Distance to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step distance", pch=1, ylim=c(0, 0.5))
abline(lm(D_aES~D_prob), lwd=2, col="green")
dev.off()

################ TOTAL DISTANCE TO PROBABILITY ################ 

# all together now
png(file = "graphs/totalDistProb.png", width=1500, height=1500)
attach(mtcars)
par(mfrow=c(2,2))

plot(L_prob, L_ET, type="p", main="Total distance to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(L_ET~L_prob), lwd=2, col="blue")

plot(D_prob, D_ET, type="p", main="Total distance to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(D_ET~D_prob), lwd=2, col="green")

plot(L_prob, L_aET, type="p", main="Total distance to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(L_aET~L_prob), lwd=2, col="blue")

plot(D_prob, D_aET, type="p", main="Total distance to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(D_aET~D_prob), lwd=2, col="green")
dev.off()

# only life
png(file = "graphs/totalDistProb_Life.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(L_prob, L_ET, type="p", main="Total distance to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(L_ET~L_prob), lwd=2, col="blue")

plot(L_prob, L_aET, type="p", main="Total distance to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(L_aET~L_prob), lwd=2, col="blue")
dev.off()

# only disease
png(file = "graphs/totalDistProb_Disease.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(D_prob, D_ET, type="p", main="Total distance to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(D_ET~D_prob), lwd=2, col="green")

plot(D_prob, D_aET, type="p", main="Total distance to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total distance", pch=1, ylim=c(0, 0.4))
abline(lm(D_aET~D_prob), lwd=2, col="green")
dev.off()

################ STEP SPEED TO PROBABILITY ################ 

# all together
png(file = "graphs/stepSpeedProb.png", width=1500, height=1500)
attach(mtcars)
par(mfrow=c(2,2))

plot(L_prob, L_ESspeed, type="p", main="Step speed to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 6))
abline(lm(L_ESspeed~L_prob), lwd=2, col="blue")

plot(D_prob, D_ESspeed, type="p", main="Step speed to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 6))
abline(lm(D_ESspeed~D_prob), lwd=2, col="green")

plot(L_prob, L_aESspeed, type="p", main="Step speed to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 6))
abline(lm(L_aESspeed~L_prob), lwd=2, col="blue")

plot(D_prob, D_aESspeed, type="p", main="Step speed to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 6))
abline(lm(D_aESspeed~D_prob), lwd=2, col="green")
dev.off()

# only life
png(file = "graphs/stepSpeedProb_Life.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(L_prob, L_ESspeed, type="p", main="Step speed to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 2))
abline(lm(L_ESspeed~L_prob), lwd=2, col="blue")

plot(L_prob, L_aESspeed, type="p", main="Step speed to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 2))
abline(lm(L_aESspeed~L_prob), lwd=2, col="blue")
dev.off()

# only disease
png(file = "graphs/stepSpeedProb_Disease.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(D_prob, D_ESspeed, type="p", main="Step speed to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 2))
abline(lm(D_ESspeed~D_prob), lwd=2, col="green")

plot(D_prob, D_aESspeed, type="p", main="Step speed to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean step speed", pch=1, ylim=c(0, 2))
abline(lm(D_aESspeed~D_prob), lwd=2, col="green")
dev.off()

################ TOTAL TO PROBABILITY ################ 

# all together
png(file = "graphs/totalSpeedProb.png", width=1500, height=1500)
attach(mtcars)
par(mfrow=c(2,2))

plot(L_prob, L_ETspeed, type="p", main="Total speed to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(L_ETspeed~L_prob), lwd=2, col="blue")

plot(D_prob, D_ETspeed, type="p", main="Total speed to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(D_ETspeed~D_prob), lwd=2, col="green")

plot(L_prob, L_aETspeed, type="p", main="Total speed to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(L_aETspeed~L_prob), lwd=2, col="blue")

plot(D_prob, D_aETspeed, type="p", main="Total speed to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(D_aETspeed~D_prob), lwd=2, col="green")
dev.off()

# only life
png(file = "graphs/totalSpeedProb_Life.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(L_prob, L_ETspeed, type="p", main="Total speed to probability for Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(L_ETspeed~L_prob), lwd=2, col="blue")

plot(L_prob, L_aETspeed, type="p", main="Total speed to probability for alternative Life condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(L_aETspeed~L_prob), lwd=2, col="blue")
dev.off()

# only disease
png(file = "graphs/totalSpeedProb_Disease.png", width=1500, height=800)
attach(mtcars)
par(mfrow=c(1,2))

plot(D_prob, D_ETspeed, type="p", main="Total speed to probability for Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(D_ETspeed~D_prob), lwd=2, col="green")

plot(D_prob, D_aETspeed, type="p", main="Total speed to probability for alternative Disease condition", 
     xlab="Probability of mutation ", ylab="Euclidean total speed", pch=1, ylim=c(0, 0.2))
abline(lm(D_aETspeed~D_prob), lwd=2, col="green")
dev.off()

################ QUANTILES ################ 
lifFirst = Ldata[D_ID>250,]
lifLast = Ldata[D_ID<750,]
disFirst = Ddata[D_ID>250,]
disLast = Ddata[D_ID<750,]

# speed
disFirst_speed = disFirst$euclideanTotal/disFirst$lifetime
disLast_speed = disLast$euclideanTotal/disLast$lifetime
lifFirst_speed = lifFirst$euclideanTotal/lifFirst$lifetime
lifLast_speed = lifLast$euclideanTotal/lifLast$lifetime



mean(disFirst_speed, na.rm = TRUE)
mean(disLast_speed, na.rm = TRUE)
mean(lifFirst_speed, na.rm = TRUE)
mean(lifLast_speed, na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 102], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 102], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 103], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 103], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 104], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 104], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 105], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 105], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 106], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 106], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 107], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 107], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 108], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 108], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 109], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 109], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 110], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 110], na.rm = TRUE)

mean(disFirst_speed[disFirst$Exp_Num == 111], na.rm = TRUE)
mean(disLast_speed[disLast$Exp_Num == 111], na.rm = TRUE)



mean(lifFirst_speed[lifFirst$Exp_Num == 207], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 207], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 208], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 208], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 209], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 209], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 210], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 210], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 211], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 211], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 212], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 212], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 213], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 213], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 214], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 214], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 215], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 215], na.rm = TRUE)

mean(lifFirst_speed[lifFirst$Exp_Num == 216], na.rm = TRUE)
mean(lifLast_speed[lifLast$Exp_Num == 216], na.rm = TRUE)

# speed alt
disFirst_aspeed = disFirst$euclideanTotalAlt/disFirst$lifetime
disLast_aspeed = disLast$euclideanTotalAlt/disLast$lifetime
lifFirst_aspeed = lifFirst$euclideanTotalAlt/lifFirst$lifetime
lifLast_aspeed = lifLast$euclideanTotalAlt/lifLast$lifetime



mean(disFirst_aspeed, na.rm = TRUE)
mean(disLast_aspeed, na.rm = TRUE)
mean(lifFirst_aspeed, na.rm = TRUE)
mean(lifLast_aspeed, na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 102], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 102], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 103], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 103], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 104], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 104], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 105], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 105], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 106], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 106], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 107], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 107], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 108], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 108], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 109], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 109], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 110], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 110], na.rm = TRUE)

mean(disFirst_aspeed[disFirst$Exp_Num == 111], na.rm = TRUE)
mean(disLast_aspeed[disLast$Exp_Num == 111], na.rm = TRUE)



mean(lifFirst_aspeed[lifFirst$Exp_Num == 207], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 207], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 208], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 208], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 209], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 209], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 210], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 210], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 211], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 211], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 212], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 212], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 213], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 213], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 214], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 214], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 215], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 215], na.rm = TRUE)

mean(lifFirst_aspeed[lifFirst$Exp_Num == 216], na.rm = TRUE)
mean(lifLast_aspeed[lifLast$Exp_Num == 216], na.rm = TRUE)

# distance

disFirst_ET = disFirst$euclideanTotal
disLast_ET = disLast$euclideanTotal
lifFirst_ET = lifFirst$euclideanTotal
lifLast_ET = lifLast$euclideanTotal



mean(disFirst_ET, na.rm = TRUE)
mean(disLast_ET, na.rm = TRUE)
mean(lifFirst_ET, na.rm = TRUE)
mean(lifLast_ET, na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 102], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 102], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 103], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 103], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 104], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 104], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 105], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 105], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 106], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 106], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 107], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 107], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 108], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 108], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 109], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 109], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 110], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 110], na.rm = TRUE)

mean(disFirst_ET[disFirst$Exp_Num == 111], na.rm = TRUE)
mean(disLast_ET[disLast$Exp_Num == 111], na.rm = TRUE)



mean(lifFirst_ET[lifFirst$Exp_Num == 207], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 207], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 208], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 208], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 209], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 209], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 210], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 210], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 211], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 211], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 212], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 212], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 213], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 213], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 214], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 214], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 215], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 215], na.rm = TRUE)

mean(lifFirst_ET[lifFirst$Exp_Num == 216], na.rm = TRUE)
mean(lifLast_ET[lifLast$Exp_Num == 216], na.rm = TRUE)

# distance alt

disFirst_aET = disFirst$euclideanTotalAlt
disLast_aET = disLast$euclideanTotalAlt
lifFirst_aET = lifFirst$euclideanTotalAlt
lifLast_aET = lifLast$euclideanTotalAlt



mean(disFirst_aET, na.rm = TRUE)
mean(disLast_aET, na.rm = TRUE)
mean(lifFirst_aET, na.rm = TRUE)
mean(lifLast_aET, na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 102], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 102], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 103], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 103], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 104], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 104], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 105], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 105], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 106], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 106], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 107], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 107], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 108], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 108], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 109], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 109], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 110], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 110], na.rm = TRUE)

mean(disFirst_aET[disFirst$Exp_Num == 111], na.rm = TRUE)
mean(disLast_aET[disLast$Exp_Num == 111], na.rm = TRUE)



mean(lifFirst_aET[lifFirst$Exp_Num == 207], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 207], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 208], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 208], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 209], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 209], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 210], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 210], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 211], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 211], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 212], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 212], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 213], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 213], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 214], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 214], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 215], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 215], na.rm = TRUE)

mean(lifFirst_aET[lifFirst$Exp_Num == 216], na.rm = TRUE)
mean(lifLast_aET[lifLast$Exp_Num == 216], na.rm = TRUE)

################# R HELP #################

# title(main="main title", sub="sub-title", 
#       xlab="x-axis label", ylab="y-axis label")

# # Specify axis options within plot() 
# plot(x, y, main="title", sub="subtitle",
#      xlab="X-axis label", ylab="y-axix label",
#      xlim=c(xmin, xmax), ylim=c(ymin, ymax))

# # 4 figures arranged in 2 rows and 2 columns
# attach(mtcars)
# par(mfrow=c(2,2))
# plot(wt,mpg, main="Scatterplot of wt vs. mpg")
# plot(wt,disp, main="Scatterplot of wt vs disp")
# hist(wt, main="Histogram of wt")
# boxplot(wt, main="Boxplot of wt")

# png(file = "graphs/.png", width=1500, height=800)
# dev.off()
