require(rgrass7)
library(RCurl)
library(repmis)
require(xtable)
geolegendeng <- read.table(text=getURL("https://raw.githubusercontent.com/fernstgruber/p2/master/data2017/geolegendeng.txt"),sep="\t",header=T)
myfunctions <- getURL("https://raw.githubusercontent.com/fernstgruber/Rstuff/master/fabiansandrossitersfunctions.R", ssl.verifypeer = FALSE)
eval(parse(text = myfunctions))
geolegend <- read.table(text=getURL("https://raw.githubusercontent.com/fernstgruber/ERODYNSCRIPTS/master/geocodes_legend.csv"),sep="\t",header=T)
geolegend <- geolegend[1:74,]
gisBase="/usr/local/src/grass70_release/dist.x86_64-unknown-linux-gnu"
gisDbase =  "/media/fabs/Volume/Data/GRASSDATA/"
location="epsg25832"
mapset="res25"
initGRASS(gisBase = gisBase,gisDbase = gisDbase,location=location,mapset=mapset,override = TRUE)
geo_df<- readRAST("geo50_25m")@data
geo_df$UID <- 1:nrow(geo_df)
geo_df <- merge(geo_df,geolegend,by.x="geo50_25m",by.y="code",all.x=T)
geo_df<- geo_df[order(geo_df$UID,decreasing = F),]