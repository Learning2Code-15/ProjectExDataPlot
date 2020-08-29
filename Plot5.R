library(ggplot2)
#download zip file and unzip contents

dir.create("./air_pollution")
urlfile<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlfile, destfile = "./air_pollution.zip" )
unzip("./air_pollution.zip", exdir = "./air_pollution" )

#Load the data
NEI <- readRDS("./air_pollution/summarySCC_PM25.rds")
SCC <- readRDS("./air_pollution/Source_Classification_Code.rds")

# Subset Motor Veichles Emission data for Baltimore and Aggregate data for plot

baseplotdata=subset(NEI, fips=="24510"&type="ON-ROAD",select=c(Emissions,year,type))
baseplotdata=aggregate(baseplotdata$Emissions,by=list(baseplotdata$year),FUN=sum)
names(baseplotdata)=c("Year","Emissions")

#Plot PM2.5 Motor Veichles Emissions information for year 1999 -2008 in Baltimore

png(file="./Plot5.png")
ggplot(baseplotdata, aes(x=Year, y=Emissions,)) +
    geom_line(col="red")+
    geom_point(col="red")+theme_bw()+xlab("Year")+ylab("Total PM2.5 Emissions")+ggtitle("Total PM2.5 Motor Veichle Emissions in Baltimore \n between 1999-2008")

dev.off()


