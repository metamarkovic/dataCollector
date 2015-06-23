########################## IMPORT DATA ##########################

# Set working directory
setwd("/Users/meta/Documents/dev/masterProject/masterdata/")

# Extract data from .csv file
# pd = read.csv("~/Documents/dev/thePlague/plagueDistances.csv", sep=",", dec=".")
ddata <- read.csv("F:/corvax/masterProject/masterData/diseaseData.csv")

# Extract vectors
fat = ddata$totalFat
muscles = ddata$totalMuscles
bone = ddata$totalBone
ID = ddata$Ind_ID
distance = ddata$euclideanTotal
lifetime = ddata$lifetime_size
probability = ddata$probability

# Descriptives
mean(fat)
mean(muscles)
mean(bone)

median(fat)
median(muscles)
median(bone)

########################## DESCRIPTIVE GRAPHS ##########################

# Scatter plots
plot(ID, fat, main=" ", 
     xlab="ID ", ylab="fat ", pch=1)
abline(lm(fat~ID), col="red")

plot(ID, muscles, type="p", main="", 
     xlab="ID ", ylab="muscles ", pch=1)
abline(lm(muscles~ID), col="red")

plot(ID, bone, main=" ", 
     xlab="ID ", ylab="bone ", pch=1)
abline(lm(bone~ID), col="red")

plot(ID,probability, main=" ",
     xlab = "bone", ylab = "fat", pch=1)
abline(lm(probability~ID),col="red")

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



A = fat[1:100]
B = fat[901:1000]
mean(A)
mean(B)
mean(B)/mean(A)
C = bone[1:100]
D = bone[901:1000]
mean(C)
mean(D)
mean(D)/mean(C)
E = muscles[1:100]
G = muscles[901:1000]
mean(E)
mean(G)
mean(G)/mean(E)
A = distance[1:100]
B = distance[901:1000]
mean(A)
mean(B)
DistEnd = mean(B)
mean(B)/mean(A)
A = Lifetime[1:100]
B = Lifetime[901:1000]
mean(A)
mean(B)
LifetimeEnd = mean(B)
mean(B)/mean(A)
Speed = DistEnd/LifetimeEnd * 100
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
Stuff = rbind(boneAvg, muscleAvg, fatAvg )

barplot(Stuff,legend = rownames(Stuff), las=2, names.arg = c("1-100","101-200","201-300","301-400", "401-500", "501-600", "601-700", "701-800", "801-900", "901-1000"), col=c("blue","red","green"), ylim = c(0,1000),  args.legend = list(x = "topright", bty = "n"))
Meanfat
H = Meanfat/(Meanfat+mean(D)+mean(G))*100
H
A = Lifetime[1:100]
B = Lifetime[901:1000]
mean(A)
LifetimeEnd = mean(A)
A = distance[1:100]
B = distance[901:1000]
mean(A)
Speed = mean(A)/LifetimeEnd * 100
Speed
E = muscles[1:100]
G = muscles[901:1000]
mean(E)
mean(G)