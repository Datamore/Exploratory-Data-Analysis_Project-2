setwd("E:/OneDrive/Coursera/Exploratory Data Analysis with R/data")

# (1) Reading all data (I put all data in the same map).

NEI <- readRDS("summarySCC_PM25.rds") 

SCC <- readRDS("Source_Classification_Code.rds")


baltimoreNEI <- NEI[NEI$fips=="24510",]

# (3) Aggregate using sum the Baltimore emissions data by year.

aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

# (4) Making png and creating plot2.

png("plot2.png",width=480,height=480,units="px",res=72)

barplot(
  aggTotalsBaltimore$Emissions,
  names.arg=aggTotalsBaltimore$year,
  xlab="Year",
  ylab="Total PM2.5 emissions (tons)",
  main="Total PM2.5 Emissions (1999-2008) at Baltimore City, Maryland",
  col = "red"
)

dev.off()


