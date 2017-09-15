require(rgrass7)
library(RCurl)
library(repmis)
require(xtable)
geolegendeng <- read.table(text=getURL("https://raw.githubusercontent.com/fernstgruber/p2/master/data2017/geolegendeng.txt"),sep="\t",header=T)
myfunctions <- getURL("https://raw.githubusercontent.com/fernstgruber/Rstuff/master/fabiansandrossitersfunctions.R", ssl.verifypeer = FALSE)
eval(parse(text = myfunctions))
geolegend <- read.table(text=getURL("https://raw.githubusercontent.com/fernstgruber/ERODYNSCRIPTS/master/geocodes_legend.csv"),sep="\t",header=T)
geolegend <- geolegend[1:74,]
geolegend <- droplevels(geolegend)
gisBase="/usr/local/src/grass70_release/dist.x86_64-unknown-linux-gnu"
gisDbase =  "/media/fabs/Volume/Data/GRASSDATA/"
location="epsg25832"
mapset="res25"
initGRASS(gisBase = gisBase,gisDbase = gisDbase,location=location,mapset=mapset,override = TRUE)

load(file="/media/fabs/Volume/ERODYN/ERODYNSCRIPTS/temporlarge/geo_df.RData")
bodenbedeckung <- c("Boeschung","Brachland","Fels","Felsgebiet","SchneefeldGletscher","SchotterfeldGeroellhalde","WeideWieseAlm")
terrain <- c("aspect_25m","dtm_25m_avg","pcurvature_25m","slope_25m","tcurvature_25m")
slopethreshold=15
gefaehrdetebodenbedeckung <- c("Brachland","Felsgebiet","WeideWieseAlm")
bb = gefaehrdetebodenbedeckung[1]
for (bb in gefaehrdetebodenbedeckung){
  geo_df[!is.na(geo_df[[bb]]),"bbdisp"] <-1
  print(summary(geo_df$bbdisp))
}
disposition <- geo_df[!is.na(geo_df[["bbdisp"]]),]
summary(disposition)

