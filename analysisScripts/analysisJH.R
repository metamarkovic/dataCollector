########################## IMPORT DATA ##########################

# Set working directory
setwd("F:/corvax/masterProject/masterData/masterData/dataCollector")

# Extract data from .csv file
# pd = read.csv("~/Documents/dev/thePlague/plagueDistances.csv", sep=",", dec=".")
raw_data <- read.csv("F:/corvax/masterProject/masterData/diseaseData.csv", sep=",", dec=".", stringsAsFactors=FALSE)
ddata = raw_data[complete.cases(raw_data),]
ddata = na.omit(ddata)

ddata2 = raw_data2[complete.cases(raw_data2),]
ddata2 = na.omit(ddata2)


mutatedNormalsData <- read.csv("F:/corvax/masterProject/masterData/masterData/dataCollector/mutatedNormalsData.csv")
mndata = mutatedNormalsData[,-13]
mndata = mndata[,-13]
mndata = mndata[complete.cases(mndata),]
mndata = na.omit(mndata)

robotData <- read.csv("F:/corvax/masterProject/masterData/masterData/dataCollector/robotData.csv")
rdata = raw_data[complete.cases(robotData),]
rdata = na.omit(rdata)



# Extract vectors

birth = as.numeric(ddata$birthtime)
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

expNum = ddata$Exp_Num

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
plot(birth, fat, main="Number of fat voxels over time", 
     xlab="birth ", ylab="fat ", pch=1)
abline(lm(fat~birth), col="red")
lm(fat~birth)

plot(birth, muscles, type="p", main="Number of muscles after mutation", 
     xlab="birth ", ylab="muscles ", pch=1)
abline(lm(muscles~birth), col="green")
abline(lm(muscles_orig~birth), col="blue")
lm(muscles~birth)
lm(muscles_orig~birth)


plot(birth, muscles_orig, type="p", main="Number of muscles before mutation", 
     xlab="birth ", ylab="muscles ", pch=1)
abline(lm(muscles_orig~birth), col="blue")

plot(birth, bone, main="Number of bones after mutation", 
     xlab="birth ", ylab="bone ", pch=1)
abline(lm(bone~birth), col="green")
abline(lm(bone_orig~birth), col="red")

plot(birth, bone_orig, type="p", main="Number of bones before mutation", 
     xlab="birth ", ylab="muscles ", pch=1)
abline(lm(bone_orig~birth), col="red")

plot(fat,muscles, main="Number of fat to muscle voxels before mutation",
     xlab = "muscle", ylab = "fat", pch=1)
abline(lm(muscles~fat),col="red")

plot(fat_orig,muscles_orig, main="Number of fat to muscle voxels after mutation",
     xlab = "muscles", ylab = "fat", pch=1)
abline(lm(muscles_orig~fat_orig),col="red")

plot(birth,probability, main="Probability of mutation over time",
     xlab = "probability", ylab = "birth", pch=1)
abline(lm(probability~birth),col="red")

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

plot(exp_2$birth, exp_2$ES_distance, type="p", main="Total distance travelled over time", 
     xlab="probability ", ylab="distance", pch=1)
points(exp_3$birth, exp_3$ES_distance, type="p", col=2)
points(exp_4$birth, exp_4$ES_distance, type="p", col=3)
points(exp_5$birth, exp_5$ES_distance, type="p", col=4)
points(exp_6$birth, exp_6$ES_distance, type="p", col=5)


abline(lm(ET_distance~probability), col="blue")
abline(lm(MT_distance~probability),col="green")

########################## LOWESS MODELS ############################


# ################# Convert variables to factor ################
# ddata <- within(ddata, {
#   expNum <- factor(Exp_Num)
#   prob <- factor(probability)
#   step <- factor(euclideanStep)
#   ID <- factor(Ind_ID)
# })
# 
# ################# Interaction Plot #################
# with(ddata, interaction.plot(birth, expNum, step,
#                              ylim = c(0, 1), #lty= c(1, 12), lwd = 3,
#                              ylab = "distance", xlab = "time", trace.label = "experiment"))
# 
# ddata.aov <- aov(step ~ expNum * prob + Error(ID), data = ddata)
# summary(demo1.aov)


########################## QUANTILES ############################


quantile(ES_distance)

ES_low = ddata[ES_distance < 0.03208281,]
ES_high = ddata[ES_distance > 0.09741675,]

quantile(MS_distance)

MS_low = ddata[MS_distance < 0.04106062,]
MS_high = ddata[MS_distance > 0.12354272,]

quantile(ET_distance)

ET_low = ddata[ET_distance < 0.007052207,]
ET_high = ddata[ET_distance > 0.040361796,]

quantile(MT_distance)

MT_low = ddata[MT_distance < 0.00884018,]
MT_high = ddata[MT_distance > 0.05105609,]

quantile(birth, na.rm = TRUE)

first = ddata[birth < 4.188630,]
last = ddata[birth > 4.188630,]

mean(first$euclideanStep, na.rm = TRUE)
mean(last$euclideanStep, na.rm = TRUE)

mean(first$originalEuclideanStep, na.rm = TRUE)
mean(last$originalEuclideanStep, na.rm = TRUE)

mean(first$manhattanStep, na.rm = TRUE)
mean(last$manhattanStep, na.rm = TRUE)

mean(first$euclideanTotal, na.rm = TRUE)
mean(last$euclideanTotal, na.rm = TRUE)

mean(first$manhattanTotal, na.rm = TRUE)
mean(last$manhattanTotal, na.rm = TRUE)

plot(first$birthtime,first$euclideanStep)
plot(last$birthtime,last$euclideanStep)

mean(first$manhattanStep, na.rm = TRUE)
mean(last$manhattanStep, na.rm = TRUE)

mean(first$euclideanTotal, na.rm = TRUE)
mean(last$euclideanTotal, na.rm = TRUE)

mean(first$manhattanTotal, na.rm = TRUE)
mean(last$manhattanTotal, na.rm = TRUE)

####################### QUANTILE MEANS PER EXPERIMENT ##################

exp_2$birthtime = as.numeric(exp_2$birthtime)

quantile(exp_2$birthtime)

Exp2_ES_low = exp_2[exp_2$birthtime < 4.823227,]
Exp2_ES_high = exp_2[exp_2$birthtime > 18.429829,]

exp_3$birthtime = as.numeric(exp_3$birthtime)

quantile(exp_3$birthtime)

Exp3_ES_low = exp_3[exp_3$birthtime < 5.279479,]
Exp3_ES_high = exp_3[exp_3$birthtime > 22.051905,]

exp_4$birthtime = as.numeric(exp_4$birthtime)

quantile(exp_4$birthtime)

Exp4_ES_low = exp_4[exp_4$birthtime < 3.639266,]
Exp4_ES_high = exp_4[exp_4$birthtime > 10.522429,]

exp_5$birthtime = as.numeric(exp_5$birthtime)

quantile(na.omit(exp_5$birthtime))

Exp5_ES_low = exp_5[exp_5$birthtime < 3.44946,]
Exp5_ES_high = exp_5[exp_5$birthtime > 16.01392,]

exp_6$birthtime = as.numeric(exp_6$birthtime)

quantile(na.omit(exp_6$birthtime))

Exp6_ES_low = exp_6[exp_6$birthtime < 3.406485,]
Exp6_ES_high = exp_6[exp_6$birthtime > 9.073455,]

mean(Exp2_ES_low$euclideanStep)
mean(Exp2_ES_high$euclideanStep)

mean(Exp3_ES_low$euclideanStep)
mean(Exp3_ES_high$euclideanStep)

mean(Exp4_ES_low$euclideanStep)
mean(Exp4_ES_high$euclideanStep)

mean(Exp5_ES_low$euclideanStep, na.rm = TRUE)
mean(Exp5_ES_high$euclideanStep, na.rm = TRUE)

mean(Exp6_ES_low$euclideanStep, na.rm = TRUE)
mean(Exp6_ES_high$euclideanStep, na.rm = TRUE)

mean(Exp2_ES_low$originalEuclideanStep, na.rm = TRUE)
mean(Exp2_ES_high$originalEuclideanStep, na.rm = TRUE)

mean(Exp3_ES_low$originalEuclideanStep, na.rm = TRUE)
mean(Exp3_ES_high$originalEuclideanStep, na.rm = TRUE)

mean(Exp4_ES_low$originalEuclideanStep, na.rm = TRUE)
mean(Exp4_ES_high$originalEuclideanStep, na.rm = TRUE)

mean(Exp5_ES_low$originalEuclideanStep, na.rm = TRUE)
mean(Exp5_ES_high$originalEuclideanStep, na.rm = TRUE)

mean(Exp6_ES_low$originalEuclideanStep, na.rm = TRUE)
mean(Exp6_ES_high$originalEuclideanStep, na.rm = TRUE)

##################### JOHANN QUANTILES #####################
JHexp_7 = rdata[rdata$probability == '0.07',]
JHexp_8 = rdata[rdata$probability == '0.08',]

JHexp_7$Ind_ID = as.integer(JHexp_7$Ind_ID)
JHexp_8$Ind_ID = as.integer(JHexp_8$Ind_ID)

quantile(na.omit(JHexp_7$Ind_ID))

JHExp7_ES_low = subset(JHexp_7, Ind_ID < 538.75 & Ind_ID > 69.00)
JHExp7_ES_high = subset(JHexp_7, Ind_ID < 1699.00 & Ind_ID > 978.00)

quantile(na.omit(JHexp_8$Ind_ID))

JHExp8_ES_low = subset(JHexp_8, Ind_ID < 304.25 & Ind_ID > 94.00)
JHExp8_ES_high = subset(JHexp_8, Ind_ID < 1520.00 & Ind_ID > 930.75)

mean(JHExp7_ES_low$euclideanStep, na.rm = TRUE)
mean(JHExp7_ES_high$euclideanStep, na.rm = TRUE)

mean(JHExp8_ES_low$euclideanStep, na.rm = TRUE)
mean(JHExp8_ES_high$euclideanStep, na.rm = TRUE)

mnexp_7 = mndata[mndata$Exp_Num == '7',]
mnexp_8 = mndata[mndata$Exp_Num == '8',]

quantile(na.omit(mnexp_7$Ind_ID))
quantile(na.omit(mnexp_8$Ind_ID))

mnExp7_ES_low = subset(JHexp_7, Ind_ID < 538.75 & Ind_ID > 69.00)
mnExp7_ES_high = subset(JHexp_7, Ind_ID < 1699.00 & Ind_ID > 978.00)

mnExp8_ES_low = subset(JHexp_8, Ind_ID < 304.25 & Ind_ID > 94.00)
mnExp8_ES_high = subset(JHexp_8, Ind_ID < 1520.00 & Ind_ID > 930.75)

mean(mnExp7_ES_low$euclideanStep, na.rm = TRUE)
mean(mnExp7_ES_high$euclideanStep, na.rm = TRUE)

mean(mnExp8_ES_low$euclideanStep, na.rm = TRUE)
mean(mnExp8_ES_high$euclideanStep, na.rm = TRUE)

# exp_3[exp_3$Ind_ID == '1984',]#
# exp_3[exp_3$Ind_ID == '1904',]# and 1919 as the second parent
# exp_3[exp_3$Ind_ID == '1713',] #
# exp_3[exp_3$Ind_ID == '1518',]
# exp_3[exp_3$Ind_ID == '1423',]#
# exp_3[exp_3$Ind_ID == '1354',]
# exp_3[exp_3$Ind_ID == '1284',]#
# exp_3[exp_3$Ind_ID == '1152',]
# exp_3[exp_3$Ind_ID == '1081',] #
# exp_3[exp_3$Ind_ID == '985',]
# exp_3[exp_3$Ind_ID == '705',]#
# exp_3[exp_3$Ind_ID == '591',]
# exp_3[exp_3$Ind_ID == '175',] #
# exp_3[exp_3$Ind_ID == '75',] #
#        
# # max: 1984
# # parents: [1919, 1904]   picked: 1904
# # parents: [1837, 1713]   picked: 1713
# # parents: [1645, 1518]   picked: 1518
# # parents: [1448, 1423]   picked: 1423
# # parents: [1354, 1243]   picked: 1354
# # parents: [1285, 1284]   picked: 1284
# # parents: [1215, 1152]   picked: 1152
# # parents: [1081, 1069]   picked: 1081
# # parents: [995, 985]   picked: 985
# # parents: [884, 705]   picked: 705
# # parents: [607, 591]   picked: 591
# # parents: [493, 274]   picked: 274
# # parents: [175, 103]   picked: 175
# # parents: [75, 65]   picked: 75




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

