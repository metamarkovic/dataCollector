########################## IMPORT DATA ##########################

# Set working directory
setwd("/Users/meta/Documents/dev/masterProject/masterdata/")

# Extract data from .csv file
# pd = read.csv("~/Documents/dev/thePlague/plagueDistances.csv", sep=",", dec=".")
raw_data <- read.csv("F:/corvax/masterProject/masterData/diseaseData.csv", sep=",", dec=".", stringsAsFactors=FALSE)

ddata = na.omit(raw_data)

# Extract vectors
fat = ddata$totalFat
fat_orig = ddata$originalFat
muscles = ddata$totalMuscles
muscles_orig = ddata$originalMuscle
bone = ddata$totalBone
bone_orig = ddata$originalBone
size = ddata$size
ID = ddata$Ind_ID
ES_distance = ddata$euclideanStep
ET_distance = ddata$euclideanTotal
MS_distance = ddata$manhattanStep
MT_distance = ddata$manhattanTotal

lifetime = ddata$lifetime
probability = ddata$probability


bone_diff = bone_orig - bone
muscle_diff = muscles_orig - muscles

# Descriptives
mean(fat, na.rm = TRUE)
mean(muscles, na.rm = TRUE)
mean(bone, na.rm = TRUE)
mean(size, na.rm = TRUE)

mean(bone_orig, na.rm = TRUE)
mean(muscles_orig, na.rm = TRUE)

median(fat, na.rm = TRUE)
median(muscles, na.rm = TRUE)
median(bone, na.rm = TRUE)
median(size, na.rm = TRUE)

median(bone_orig, na.rm = TRUE)
median(muscles_orig, na.rm = TRUE)
median(fat_orig, na.rm = TRUE)


########################## DESCRIPTIVE GRAPHS ##########################

# Scatter plots
plot(ID, fat, main="Number of fat voxels over time", 
     xlab="ID ", ylab="fat ", pch=1)
abline(lm(fat~ID), col="red")

plot(ID, muscles, type="p", main="Number of muscles after mutation", 
     xlab="ID ", ylab="muscles ", pch=1)
abline(lm(muscles~ID), col="green")

plot(ID, muscles_orig, type="p", main="Number of muscles before mutation", 
     xlab="ID ", ylab="muscles ", pch=1)
abline(lm(muscles_orig~ID), col="blue")

plot(ID, bone, main="Number of bones after mutation", 
     xlab="ID ", ylab="bone ", pch=1)
abline(lm(bone~ID), col="red")

plot(ID, bone_orig, type="p", main="Number of bones before mutation", 
     xlab="ID ", ylab="muscles ", pch=1)
abline(lm(bone_orig~ID), col="red")

plot(ID,muscles, main="Number of fat to muscle voxels before mutation",
     xlab = "muscle", ylab = "fat", pch=1)
abline(lm(muscles~ID),col="red")

plot(fat_orig,muscles_orig, main="Number of fat to muscle voxels after mutation",
     xlab = "muscles", ylab = "fat", pch=1)
abline(lm(muscles_orig~ID),col="red")

plot(ID,probability, main="Probability of mutation over time",
     xlab = "probability", ylab = "ID", pch=1)
abline(lm(probability~ID),col="red")

plot(probability, bone_diff, type="p", main="Difference in number of bones against probability of mutation", 
     xlab="probability", ylab="difference in number of bones ", pch=1)
abline(lm(bone_diff~probability), col="red")

plot(probability, muscle_diff, type="p", main="Difference in number of muscles against probability of mutation", 
     xlab="probability ", ylab="difference in number of muscles ", pch=1)
abline(lm(muscle_diff~probability), col="red")

plot(probability, ET_distance, type="p", main="Total distance travelled against probability of mutation", 
     xlab="probability ", ylab="distance", pch=1)
points(probability, MT_distance, type="p", col=2)
abline(lm(ET_distance~probability), col="blue")
abline(lm(MT_distance~probability),col="green")

plot(probability, ES_distance, type="p", main="Step distance travelled against probability of mutation", 
     xlab="probability ", ylab="distance", pch=1)
points(probability, MS_distance, type="p", col=2)
abline(lm(ES_distance~probability), col="blue")
abline(lm(MS_distance~probability),col="green")

plot(probability,bone)
plot(probability,fat)

########################## VALIDITY CHECKS ############################

exp_2 = ddata[ddata$Exp_Num == '2',]
exp_3 = ddata[ddata$Exp_Num == '3',]
exp_4 = ddata[ddata$Exp_Num == '4',]
exp_5 = ddata[ddata$Exp_Num == '5',]
exp_6 = ddata[ddata$Exp_Num == '6',]


diaEff = ddata[]


################# Convert variables to factor ################
ddata <- within(ddata, {
  expNum <- factor(Exp_Num)
  prob <- factor(probability)
  step <- factor(euclideanStep)
  ID <- factor(Ind_ID)
})

################# Interaction Plot #################
with(ddata, interaction.plot(ID, expNum, step,
                             ylim = c(0, 1), #lty= c(1, 12), lwd = 3,
                             ylab = "distance", xlab = "time", trace.label = "experiment"))

ddata.aov <- aov(step ~ expNum * prob + Error(ID), data = ddata)
summary(demo1.aov)



lowFat = fat[1:100]
highFat = fat[901:1000]
mean(lowFat)
mean(highFat)
mean(highFat)/mean(lowFat)
lowBone = bone[1:100]
highBone = bone[901:1000]
mean(lowBone)
mean(highBone)
mean(highBone)/mean(lowBone)
lowMuscle = muscles[1:100]
highMuscle = muscles[901:1000]
mean(lowMuscle)
mean(highMuscle)
mean(highMuscle)/mean(lowMuscle)

lowDist = distance[1:100]
highDist = distance[901:1000]
mean(lowDist)
mean(highDist)
mean(highDist)/mean(lowDist)
distEnd = mean(highDist)

lowLife = lifetime[1:100]
highLife = lifetime[901:1000]
mean(lowLife)
mean(highLife)
lifetimeEnd = mean(highLife)
mean(highLife)/mean(lowLife)


Speed = distEnd/lifetimeEnd * 100
Speed
s = sd(fat)
m = mean(fat)
error <- qnorm(0.975)*s/sqrt(1000)
m-error
m+error
hist(bone[901:1000])
hist(bone[1:100])
boneAvg <- NULL
muscleAvg <- NULL
fatAvg <- NULL

for (i in 1:10) {
  boneAvg[i] = mean(bone[(1+((i*100))-100):(i*100)])   
  muscleAvg[i] = mean(muscles[(1+((i*100))-100):(i*100)])   
  fatAvg[i] = mean(fat[(1+((i*100))-100):(i*100)])   
  
}

stuff = rbind(boneAvg, muscleAvg, fatAvg )

barplot(stuff,legend = rownames(stuff), las=2, names.arg = c("1-100","101-200","201-300","301-400", "401-500", "501-600", "601-700", "701-800", "801-900", "901-1000"), col=c("blue","red","green"), ylim = c(0,1000),  args.legend = list(x = "topright", bty = "n"))



################# Convert variables to factor ################
# meanFat
# H = mean/(meanFat+mean(D)+mean(G))*100
# H
# A = lifetime[1:100]
# B = lifetime[901:1000]
# mean(A)
# lifetimeEnd = mean(A)
# A = distance[1:100]
# B = distance[901:1000]
# mean(A)
# speed = mean(A)/lifetimeEnd * 100
# speed
# E = muscles[1:100]
# G = muscles[901:1000]
# mean(E)
# mean(G)

