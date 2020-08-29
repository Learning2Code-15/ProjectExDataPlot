library(ggplot2)
#download zip file and unzip contents

dir.create("./air_pollution")
urlfile<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlfile, destfile = "./air_pollution.zip" )
unzip("./air_pollution.zip", exdir = "./air_pollution" )

#Load the data
NEI <- readRDS("./air_pollution/summarySCC_PM25.rds")
SCC <- readRDS("./air_pollution/Source_Classification_Code.rds")

# Subset Motor veichle emissions data for City LA and Baltimore using fips code and Aggregate data for plot
baseplotdata=subset(NEI, fips=="24510",select=c(Emissions,year,fips,type))
baseplotdata=rbind(baseplotdata,subset(NEI, fips=="06037",select=c(Emissions,year,fips,type)))
baseplotdata=subset(baseplotdata, type=="ON-ROAD",select=c(Emissions,year,fips,type))
baseplotdata=aggregate(baseplotdata$Emissions,by=list(baseplotdata$year,baseplotdata$fips),FUN=sum)
names(baseplotdata)=c("Year","City","Emissions")

#Plot PM2.5 Motor Veichle emissions information for year 1999 -2008 for Baltimore and LA.
png(file="./Plot6.png")
ggplot(baseplotdata, aes(x=Year, y=Emissions, group=City)) +
    geom_line(aes(color=City))+
    geom_point(aes(color=City))+theme_bw()+xlab("Year")+ylab("Total PM2.5 Emissions")+ggtitle("Total PM2.5 Motor Veichle Emissions in Baltimore\n and L.A between 1999-2008")+
    scale_colour_discrete(name = "City",labels=c("Los Angeles","Baltimore")) +theme(legend.title = element_text(face = "bold"))
dev.off()
