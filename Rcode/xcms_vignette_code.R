### R code from vignette source 'vignettes/xcms/inst/doc/xcmsPreprocess.Rnw'

###################################################
### code chunk number 1: LibraryPreload
###################################################
library(multtest)
library(xcms)
library(faahKO)


###################################################
### code chunk number 2: RawFiles
###################################################
#cdfpath <- system.file("cdf", package = "faahKO")
#list.files(cdfpath, recursive = TRUE)
cdf.path<-("~/Dropbox/amphib_dermalexposure/Biomarkers/Metabolomics/R_code/cdf")
list.files(cdf.path)
###################################################
### code chunk number 3: PeakIdentification
###################################################
library(xcms)
#cdffiles <- list.files(cdfpath, recursive = TRUE, full.names = TRUE)
cdffiles <- list.files(cdf.path, recursive = TRUE, full.names = TRUE)

xset <- xcmsSet(cdffiles)
#xset <- faahko
xset


###################################################
### code chunk number 4: PeakMatching1
###################################################
#match peaks across samples
#changes peak groups object attribute
xset <- group(xset) 


###################################################
### code chunk number 5: RTCorrection
###################################################
#retention time correction
xset2 <- retcor(xset, family = "symmetric", plottype = "mdevden")


###################################################
### code chunk number 6: PeakMatching2
###################################################
#after correcting for retention time need to group peaks again
xset2 <- group(xset2, bw = 10) 


###################################################
### code chunk number 7: PeakFillIn
###################################################
xset3 <- fillPeaks(xset2)
xset3


###################################################
### code chunk number 8: AnalysisVisualize
###################################################
reporttab <- diffreport(xset3, "WT", "KO", "example", 10, metlin = 0.15, h=480, w=640)
reporttab[1:4,]


###################################################
### code chunk number 9: URL1
###################################################
cat("\\url{", as.character(reporttab[1,"metlin"]), "}", sep = "")


###################################################
### code chunk number 10: URL2
###################################################
cat("\\url{", as.character(reporttab[3,"metlin"]), "}", sep = "")


###################################################
### code chunk number 11: PeakSelect
###################################################
gt <- groups(xset3)
colnames(gt)
groupidx1 <- which(gt[,"rtmed"] > 2600 & gt[,"rtmed"] < 2700 & gt[,"npeaks"] == 12)[1]
groupidx2 <- which(gt[,"rtmed"] > 3600 & gt[,"rtmed"] < 3700 & gt[,"npeaks"] == 12)[1]
eiccor <- getEIC(xset3, groupidx = c(groupidx1, groupidx2))
eicraw <- getEIC(xset3, groupidx = c(groupidx1, groupidx2), rt = "raw")


###################################################
### code chunk number 12: EICRaw1
###################################################
plot(eicraw, xset3, groupidx = 1)


###################################################
### code chunk number 13: EICRaw2
###################################################
plot(eicraw, xset3, groupidx = 2)


###################################################
### code chunk number 14: EICCor1
###################################################
plot(eiccor, xset3, groupidx = 1)


###################################################
### code chunk number 15: EICCor2
###################################################
plot(eiccor, xset3, groupidx = 2)


###################################################
### code chunk number 16: warnings
###################################################
cat("These are the warning")
warnings()

