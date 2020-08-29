library(ggplot2)
#download zip file and unzip contents

dir.create("./air_pollution")
urlfile<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlfile, destfile = "./air_pollution.zip" )
unzip("./air_pollution.zip", exdir = "./air_pollution" )

#Load the data
NEI <- readRDS("./air_pollution/summarySCC_PM25.rds")
SCC <- readRDS("./air_pollution/Source_Classification_Code.rds")

# Subset Coal SCC data and Aggregate data for plot
coalsources=SCC[grepl("Coal",SCC$Short.Name),]
NEI_coalsources= NEI[NEI$SCC %in% coalsources$SCC,]
baseplotdata=aggregate(NEI_coalsources$Emissions,by=list(NEI_coalsources$year,NEI_coalsources$type),FUN=sum)
names(baseplotdata)=c("Year","Type","Emissions")

#Plot PM2.5 Coal emissions information for year 1999 -2008 in United States classified by type

png(file="./Plot4.png")
ggplot(baseplotdata, aes(x=Year, y=Emissions, group=Type)) +
    geom_line(aes(color=Type))+
    geom_point(aes(color=Type))+theme_bw()+xlab("Year")+ylab("Total PM2.5 Emissions")+ggtitle("Total PM2.5 Coal Emissions in United States by Type \n between 1999-2008")+
    scale_colour_discrete(name = "Type of sources") +theme(legend.title = element_text(face = "bold"))
dev.off()


