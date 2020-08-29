#download zip file and unzip contents

dir.create("./air_pollution")
urlfile<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlfile, destfile = "./air_pollution.zip" )
unzip("./air_pollution.zip", exdir = "./air_pollution" )

#Load the data
NEI <- readRDS("./air_pollution/summarySCC_PM25.rds")
SCC <- readRDS("./air_pollution/Source_Classification_Code.rds")

# Subset and Aggregate data for plot
baseplotdata=subset(NEI, fips=="24510",select=c(Emissions,year))
baseplotdata=aggregate(baseplotdata$Emissions,by=list(baseplotdata$year),FUN=sum)
names(baseplotdata)=c("Year","Emissions")

#Plot PM2.5 emissions information for year 1999 -2008 in Baltimore

png(file="./Plot2.png")
plot(baseplotdata$Year,baseplotdata$Emissions,type="o",xlab = "Year",ylab="Total PM2.5 Emissions ",main="Total PM2.5 Emissions in Baltimore 1999-2008",col="red")
dev.off()

