########################## IMPORT DATA ##########################

# Set working directory
setwd("/Users/meta/Documents/dev/thePlague")

# Extract data from .csv file
# ddata = read.csv("~/Documents/dev/thePlague/plagueDistances.csv", sep=",", dec=".")
ddata = read.csv("F:/corvax/Meta/Dropbox/diabeetusDistances.csv", sep=",", dec=".")

# Extract vectors
probability = ddata$probability
size = ddata$lifetime_size
trace = ddata$euclideanStep
muscle = ddata$totalMuscles
fat = ddata$totalFat
bone = ddata$totalBone

# Set probability as factor
ddata$probability = as.factor(ddata$probability)

ddata$totalSize = ddata$totalMuscles + ddata$totalFat + ddata$totalBone

ddata[1:10,]
hist(ddata$totalSize)
boxplot(ddata$totalSize)
summary(ddata$totalSize)


# Check vectors
probability
size
trace
fat
bone

########################## DESCRIPTIVE GRAPHS ##########################

# Make descriptive graphs and save them to folder
png(file = "~/Documents/dev/thePlague/lifetimes_hist.png")
hist(size,xlab="Lifetime Length")
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


########################## MANAGE DATASETS ##########################

# Split dataset according to probability
# ddata_s = split(ddata,probability)
plague000 = ddata[ddata$probability==0.00,]
plague005 = ddata[ddata$probability==0.05,]
plague010 = ddata[ddata$probability==0.10,]
plague015 = ddata[ddata$probability==0.15,]
plague020 = ddata[ddata$probability==0.20,]
plague025 = ddata[ddata$probability==0.25,]
plague030 = ddata[ddata$probability==0.30,]
plague035 = ddata[ddata$probability==0.35,]
plague040 = ddata[ddata$probability==0.40,]



plot(ddata$Ind_ID,ddata$totalFat, xlab="Individual ID", ylab="Number of fat cells",main="Fat over time.")
fatLM = lm(ddata$totalFat~ddata$Ind_ID)
abline(fatLM, col="red")

plot(ddata$probability,ddata$totalFat, xlab="Individual ID", ylab="Number of fat cells",main="Fat over probability.")
fatLM = lm(ddata$totalFat~ddata$probability)
abline(fatLM, col="red")

plot(ddata$Ind_ID,ddata$totalMuscle, xlab="Individual ID", ylab="Number of muscle cells",main="Muscle over time.")
muscleLM = lm(ddata$totalMuscles~ddata$Ind_ID)
abline(muscleLM, col="red")

plot(ddata$totalMuscle,ddata$totalFat, xlab="Number of muscle cells", ylab="Number of fat cells",main="Fat to Muscle ratio.")
plot(ddata$totalMuscles,ddata$lifetime_size, xlab="Number of muscle cells", ylab="Length of lifetime", main="Muscle to lifetime ratio.")

boxplot(plague000$totalMuscle,plague005$totalMuscle,plague010$totalMuscle,plague015$totalMuscle,plague020$totalMuscle,plague025$totalMuscle,plague030$totalMuscle,plague035$totalMuscle,plague040$totalMuscle,xlab="Probability of atrophy", ylab="Number of muscles left.")
title("Muscle number after atrophy.")

median(ddata$totalMuscles)

median(plague000$totalMuscle)
median(plague005$totalMuscle)
median(plague010$totalMuscle)
median(plague015$totalMuscle)
median(plague020$totalMuscle)
median(plague025$totalMuscle)
median(plague030$totalMuscle)
median(plague035$totalMuscle)
median(plague040$totalMuscle)

mean(ddata$totalMuscles)

mean(plague000$totalMuscle)
mean(plague005$totalMuscle)
mean(plague010$totalMuscle)
mean(plague015$totalMuscle)
mean(plague020$totalMuscle)
mean(plague025$totalMuscle)
mean(plague030$totalMuscle)
mean(plague035$totalMuscle)
mean(plague040$totalMuscle)


# # Test merge method
# t1=plague000[1:10, ]
# t2=plague025[2:11, ]
# merge(x=t1,y=t2,by="Ind_ID")

# Merge baseline and test tables
ddata[ddata$probability=="0.2",]
ddataMerged20 = merge(x=ddata[ddata$probability=="0",],y=ddata[ddata$probability=="0.2",],by="Ind_ID",suffixes = c("00","20"))
ddataMerged20$distDiff = ddataMerged20$euclideanStep00 - ddataMerged20$euclideanStep20

# ddataMerged[1:10,]
ddataMerged40 = merge(x=ddata[ddata$probability=="0",],y=ddata[ddata$probability=="0.4",],by="Ind_ID",suffixes = c("00","40"))
ddataMerged40$distDiff = ddataMerged40$euclideanStep00 - ddataMerged40$euclideanStep40

summary(ddataMerged20$totalSize00)

boxplot(ddataMerged20$distDiff[ddataMerged20$totalSize00 < 597.0], ddataMerged20$distDiff[ddataMerged20$totalSize00 > 980.0],xlab="Size",ylab="Distance difference")
title("Difference in distance travelled for lower and higher total size quantiles")
median(ddataMerged20$distDiff[ddataMerged20$totalSize00 < 597.0])
median(ddataMerged20$distDiff[ddataMerged20$totalSize00 > 980.0])

wilcox.test(ddataMerged20$distDiff[ddataMerged20$totalSize00 < 597.0], ddataMerged20$distDiff[ddataMerged20$totalSize00 > 980.0])



########################## DIFFERENCE IN DISTANCES TRAVELLED ##########################

# Calculate difference in distances traveled
ddataMerged$distDiff = ddataMerged$euclideanStep00 - ddataMerged$euclideanStep25

ddataMerged2$distDiff = ddataMerged2$euclideanStep00 - ddataMerged2$euclideanStep40

# Check for errors
ddataMerged$distDiff
ddataMerged2$distDiff

# Scaling function
range01 <- function(x){(x-min(x))/(max(x)-min(x))}

# # Scale differences
# ddataMerged$distDiffScaled = range01(ddataMerged$distDiff)

# # Check for erros
# max(ddataMerged$distDiffScaled)

# Plot difference in distances traveled 

png(file = "~/Documents/dev/thePlague/distDiff_boxplot.png")
boxplot(ddataMerged$distDiff)
title("")
# dev.off()

png(file = "~/Documents/dev/thePlague/distDiff2_boxplot.png")
boxplot(ddataMerged2$distDiff)
# dev.off()

png(file = "~/Documents/dev/thePlague/distDiff_QQplot.png")
qqnorm(ddataMerged$distDiff)
qqline(ddataMerged$distDiff)
# dev.off()
# dev.set(which = 2)
png(file = "~/Documents/dev/thePlague/distDiff2_QQplot.png")
qqnorm(ddataMerged2$distDiff)
qqline(ddataMerged2$distDiff)
# dev.off()

png(file = "~/Documents/dev/thePlague/distDiff_hist.png")
hist(ddataMerged$distDiff, xlab="Difference in Distance Traveled", ylab="Frequency", breaks = 50)
# dev.off()

png(file = "~/Documents/dev/thePlague/distDiff2_hist.png")
hist(ddataMerged2$distDiff, xlab="Difference in Distance Traveled", ylab="Frequency", breaks = 50)
# dev.off()

########################## NORMALITY CHECK ##########################

# Check normality
shapiro.test(ddata$distDiff)

# Shapiro-Wilk normality test
# 
# data:  ddataMerged$distDiff
# W = 0.87058, p-value < 2.2e-16

shapiro.test(ddataMerged2$distDiff)

# Shapiro-Wilk normality test
# 
# data:  ddataMerged2$distDiff
# W = 0.89401, p-value < 2.2e-16


########################## MUSCLE QUANTILES ##########################

# Get muscle number quantiles

quantile(ddataMerged$totalMuscles00)
ddataLowMuscles = ddataMerged[ddataMerged$totalMuscles00>0 & ddataMerged$totalMuscles00 < 59, ]
ddataHighMuscles = ddataMerged[ddataMerged$totalMuscles00>444, ]

quantile(ddataMerged2$totalMuscles00)
ddataLowMuscles2 = ddataMerged2[ddataMerged2$totalMuscles00>0 & ddataMerged2$totalMuscles00 < 59.75, ]
ddataHighMuscles2 = ddataMerged2[ddataMerged2$totalMuscles00>444.25, ]

ddataLowMuscles2
# Plot distance differences against number of muscles

png(file = "~/Documents/dev/thePlague/muscleCountQuantiles2_boxplot.png")
boxplot(ddataLowMuscles$distDiff, ddataHighMuscles$distDiff, xlab="Low or High Muscle Count", ylab="Difference in Distance Traveled")
title("Low vs. High muscle count, 20% mutation rate.")
# dev.off()

png(file = "~/Documents/dev/thePlague/muscleCountQuantiles2_boxplot.png")
boxplot(ddataLowMuscles2$distDiff, ddataHighMuscles2$distDiff, xlab=c("Low Muscle Count","High Muscle Count"), ylab="Difference in Distance Traveled")
title("Low vs. High muscle count, 40% mutation rate.")
# dev.off()

png(file = "~/Documents/dev/thePlague/muscleCount_scatterplot.png")
plot(ddataMerged$totalMuscles00, ddataMerged$distDiff, xlab="Number of Muscles", ylab="Difference in Distance Travelled")
pgMuscleDistLM=lm(ddataMerged$distDiff ~ ddataMerged$totalMuscles00)
abline(pgMuscleDistLM, col="red")
# dev.off()

png(file = "~/Documents/dev/thePlague/muscleCount2_scatterplot.png")
plot(ddataMerged2$totalMuscles00, ddataMerged2$distDiff, xlab="Number of Muscles", ylab="Difference in Distance Travelled")
pgMuscle2DistLM=lm(ddataMerged2$distDiff ~ ddataMerged2$totalMuscles00)
abline(pgMuscle2DistLM, col="red")
# dev.off()

# Check linear model
pgMuscle2DistLM

png(file = "~/Documents/dev/thePlague/muscleCountQuantiles_scatterplot.png")
plot(ddataMerged$lifetime_size00, ddataMerged$distDiff, xlab="Lifetime Length", ylab="Distance Change")
pgMuscleDistLM=lm(ddataMerged$distDiff ~ ddataMerged$totalMuscles00)
abline(pgMuscleDistLM, col="red")
# dev.off()

png(file = "~/Documents/dev/thePlague/muscleCount2Quantiles_scatterplot.png")
plot(ddataMerged2$lifetime_size00, ddataMerged2$distDiff, xlab="Lifetime Length", ylab="Distance Change")
pgMuscle2DistLM=lm(ddataMerged2$distDiff ~ ddataMerged2$totalMuscles00)
abline(pgMuscle2DistLM, col="red")
# dev.off()

# Check linear model
pgMuscleDistLM

# Check normality
shapiro.test(ddataMerged$distDiff)

# Shapiro-Wilk normality test
# 
# data:  ddataMerged$distDiff
# W = 0.87058, p-value < 2.2e-16

shapiro.test(ddataMerged2$distDiff)

# Shapiro-Wilk normality test
# 
# data:  ddataMerged2$distDiff
# W = 0.89401, p-value < 2.2e-16



########################## TOTAL DISTANCE TRAVELLED ##########################

pglifesize = ddata[,c(3,7)]
pglifesize2 = ddata[,c(4,7)]
pglifesize3 = ddata[ddata$probability==0.40,c(3,7)]

# # Plot lifetime length against total distance travelled
# 
# plot(pglifesize$lifetime_size, pglifesize$euclideanStep)
# pglifesizeLR = lm(pglifesize$euclideanStep ~ pglifesize$lifetime_size)
# abline(pglifesizeLR, col="red")
# 
# plot(pglifesize2$lifetime_size, pglifesize2$manhattanStep)
# pglifesize2LR = lm(pglifesize2$manhattanStep ~ pglifesize2$lifetime_size)
# abline(pglifesize2LR, col="red")
# 
# plot(pglifesize3$lifetime_size, pglifesize3$euclideanStep)
# pglifesize3LR = lm(pglifesize3$euclideanStep ~ pglifesize3$lifetime_size)
# abline(pglifesize3LR, col="red")

# # Check models
# pglifesizeLR
# pglifesize3LR

# # Plot muscle count against total distance travelled
# pgstepmuscle = ddata[,c(3,8)]
# plot(pgstepmuscle$totalMuscles, pgstepmuscle$euclideanStep)
# pgstepmuscleLR = lm(pgstepmuscle$euclideanStep ~ pgstepmuscle$totalMuscles)
# abline(pgstepmuscleLR, col="red")
# pgstepmuscleLR
# 
# # Plot lifetime length against total muscle count
# pglifemuscle = ddata[,c(7,8)]
# plot(pglifemuscle$lifetime_size, pglifemuscle$totalMuscles)
# pglifemuscleLR = lm(pglifemuscle$totalMuscles ~ pglifemuscle$lifetime_size)
# abline(pglifemuscleLR, col="red")
# pglifemuscleLR


########################## EUCLIDEAN DISTRIBUTIONS ##########################


plagueTest = ddata[,2:3]
plagueTest$probability = as.factor(plagueTest$probability)

ddata[1:10,2:3]

png(file = "~/Documents/dev/thePlague/allDistances_boxplot.png")
boxplot(plague000$euclideanStep, plague005$euclideanStep, plague010$euclideanStep, plague015$euclideanStep, plague020$euclideanStep, plague025$euclideanStep, plague030$euclideanStep, plague035$euclideanStep, plague040$euclideanStep, xlab="Probability of Atrophy (0-0.25)", ylab="Distances travelled")
# dev.off()

median(plague005$euclideanStep)
median(plague010$euclideanStep)
median(plague015$euclideanStep)
median(plague020$euclideanStep)
median(plague025$euclideanStep)
median(plague030$euclideanStep)
median(plague035$euclideanStep)
median(plague040$euclideanStep)

shapiro.test(plague005$euclideanStep)
shapiro.test(plague010$euclideanStep)
shapiro.test(plague015$euclideanStep)
shapiro.test(plague020$euclideanStep)
shapiro.test(plague025$euclideanStep)
shapiro.test(plague030$euclideanStep)
shapiro.test(plague035$euclideanStep)
shapiro.test(plague040$euclideanStep)

kruskal.test(ddata$euclideanStep, ddata$probability)

# Kruskal-Wallis rank sum test
# 
# data:  plagueTest$euclideanStep and plagueTest$probability
# Kruskal-Wallis chi-squared = 110.22, df = 8, p-value < 2.2e-16

# par(mfcol = c(1,1))

########################## OBSOLETE ##########################

# Perform t-test on the data in plagueDistances.csv
t.test(ddataMerged2$euclideanStep60,ddataMerged2$euclideanStep00)

t.test(ddata$euclideanStep,ddata$probability)

# Welch Two Sample t-test
# 
# data:  ddataMerged2$euclideanStep60 and trace
# t = -1.4773, df = 3357.4, p-value = 0.1397
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.0034017626  0.0004782854
# sample estimates:
#   mean of x  mean of y 
# 0.05996267 0.06142441 

# Make QQ-Plots and save them to folder
png(file = "~/Documents/dev/thePlague/size_QQplot.png")
qqnorm(ddataMerged2$euclideanStep00)
qqline(ddataMerged2$euclideanStep00)
# dev.off()
png(file = "~/Documents/dev/thePlague/trace_QQplot.png")
qqnorm(ddataMerged2$euclideanStep40)
qqline(ddataMerged2$euclideanStep40)
# dev.off()

# The QQ-Plots show that these are not normally distributed!

# Perform Mann-Whitney test to see if the populations are the same
wilcox.test(ddata$euclideanStep,ddata$probability)

plot(ddata$probability)

# Wilcoxon rank sum test with continuity correction
# 
# data:  ddataMerged2$euclideanStep00 and ddataMerged2$euclideanStep60
# W = 3457000, p-value = 0.005866
# alternative hypothesis: true location shift is not equal to 0

# Perform Kolmogorov-Smirnov test
ks.test(ddataMerged2$euclideanStep00,ddataMerged2$euclideanStep40)

# Two-sample Kolmogorov-Smirnov test
# 
# data:  ddataMerged2$euclideanStep00 and ddataMerged2$euclideanStep60
# D = 0.04314, p-value = 0.01665
# alternative hypothesis: two-sided
# 
# Warning message:
#   In ks.test(ddataMerged2$euclideanStep00, ddataMerged2$euclideanStep60) :
#   p-value will be approximate in the presence of ties

# RESULT:
# Two-sample Kolmogorov-Smirnov test
# 
# data:  ddatan$distDiff and unddatan$distDiff
# D = 0.4231, p-value = 0.01905
# alternative hypothesis: two-sided
# H0 of equal means is rejected. The mean of ddatan$distDiff is larger

########################## SQUARE ROOTS ########################## 

# Create two new vectors from the square roots of the previous vectors
diffScaled = range01(ddataMerged$distDiff)
diffScaled

musclesScaled = range01(ddataMerged$totalMuscles00)
musclesScaled

distDiff_sqrt = sqrt(diffScaled)
totalMuscles_sqrt = sqrt(musclesScaled)

# Check the vectors
distDiff_sqrt
totalMuscles_sqrt

# Make descriptive graphs and save them to folder
png(file = "~/Documents/dev/thePlague/distDiff_sqrt_hist.png")
hist(distDiff_sqrt, xlab="Square root of Difference in Distance Travelled")
# dev.off()
png(file = "~/Documents/dev/thePlague/totalMuscles_sqrt_hist.png")
hist(totalMuscles_sqrt, xlab="Square root of Number of Muscles")
# dev.off()

# Perform t-test on the data in plagueDistances.csv
t.test(distDiff_sqrt, )

# Make QQ-Plots and save them to folder
png(file = "~/Documents/dev/thePlague/distDiff_sqrt_qqplot.png")
qqnorm(distDiff_sqrt)
qqline(distDiff_sqrt)
# dev.off()

png(file = "~/Documents/dev/thePlague/totalMuscles_sqrt_QQplot.png")
qqnorm(totalMuscles_sqrt)
qqline(totalMuscles_sqrt)
# dev.off()

# The QQ-Plots show that these are not normally distributed!

# Perform Mann-Whitney test to see if the populations are the same
wilcox.test(distDiff_sqrt,totalMuscles_sqrt)

# Perform Kolmogorov-Smirnov test
ks.test(distDiff_sqrt,totalMuscles_sqrt)

########################## TWO PAIRED SAMPLES ############################
# boxplot(ashina[,1],ashina[,2],names=c("active","placebo"))
# plot(ashina[,1],ashina[,2])
# abline(0,1)
# mystat=function(x,y) {mean(x-y)}
# B=1000> tstar=numeric(B)
# for (i in 1:B){
#   ashinastar=t(apply(cbind(ashina[,1],ashina[,2]),1,sample))
#   tstar[i]=mystat(ashinastar[,1],ashinastar[,2])
#   }
# myt=mystat(ashina[,1],ashina[,2])
# 
# myt
# 
# hist(tstar)
# pl=sum(tstar<myt)/B
# pr=sum(tstar>myt)/B
# p=2*min(pl,pr)
# p

########################## 2-WAY ANOVA ##########################
# attach(ddataMerged)
# interaction.plot(ddataMerged$lifetime_size00,ddataMerged$probability00,ddataMerged$distDiff)
# 
# ddataMerged$totalMuscles00
# 
# ddataMerged$probability00=as.factor(ddataMerged$probability00)
# ddataMerged$totalMuscles00=as.factor(ddataMerged$totalMuscles00)
# ddataMergedaov=lm(ddataMerged$distDiff~totalMuscles00*distDiff,data=ddataMerged)
# anova(ddataMergedaov)
# 
# ddataMergedaov


# contrasts(ddataMerged$totalMuscles00)=contr.sum
# contrasts(ddataMerged$probability00)=contr.sum
# ddataMergedaov2=lm(distDiff~totalMuscles00*probability00,data=ddataMerged)
# 
# ddataMerged$totalMuscles00=as.numeric(ddataMerged$totalMuscles00)

########################## CLEAR CONSOLE ########################## 

# # Clear all
# rm(list = ls())
# # Clear console
# cat("\014")  

