library(ggplot2)
#download zip file and unzip contents

dir.create("./air_pollution")
urlfile<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlfile, destfile = "./air_pollution.zip" )
unzip("./air_pollution.zip", exdir = "./air_pollution" )

#Load the data
NEI <- readRDS("./air_pollution/summarySCC_PM25.rds")
SCC <- readRDS("./air_pollution/Source_Classification_Code.rds")

# Subset and Aggregate data for plot
baseplotdata=subset(NEI, fips=="24510",select=c(Emissions,year,type))
baseplotdata=aggregate(baseplotdata$Emissions,by=list(baseplotdata$year,baseplotdata$type),FUN=sum)
names(baseplotdata)=c("Year","Type","Emissions")

#Plot PM2.5 emissions information for year 1999 -2008 in Baltimore classified by type

png(file="./Plot3.png")
ggplot(baseplotdata, aes(x=Year, y=Emissions, group=Type)) +
    geom_line(aes(color=Type))+
    geom_point(aes(color=Type))+theme_bw()+xlab("Year")+ylab("Total PM2.5 Emissions")+ggtitle("Total PM2.5 Emissions in Baltimore by Type between 1999-2008")+
        scale_colour_discrete(name = "Type of sources") +theme(legend.title = element_text(face = "bold"))
dev.off()


