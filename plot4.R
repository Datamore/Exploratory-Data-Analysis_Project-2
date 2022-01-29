setwd("E:/OneDrive/Coursera/Exploratory Data Analysis with R/data")
library(ggplot2)
library(dplyr)
# (1) Reading all data (I put all data in the same map).

NEI <- readRDS("summarySCC_PM25.rds") 

SCC <- readRDS("Source_Classification_Code.rds")


# (2) Subset NEI data by Baltimore's fip.

# (2) Finding the SCC related with Coal (run library dplyr).

coal_SCC <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]

# 2.1 Doing the same for NEI.

coal_NEI <- NEI %>% filter(SCC %in% coal_SCC)

# 2.2 Getting the viz data.

coal_summary <- coal_NEI %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))


#Making png and plotting with ggplot2.

png(filename="plot4.png", 
    units="px", 
    width=640, 
    height=480, 
    pointsize=12, 
    res=72)

plot4 <- ggplot(coal_summary, aes(x=year, y=round(Emissions/1000,2), 
                                  label=round(Emissions/1000,2), fill=year)) +
  geom_bar(stat="identity") + 
  ylab("Total PM2.5 emissions (millions of tons") + 
  xlab("Year") +
  geom_label(aes(fill = year), colour = "white", fontface = "bold") +
  ggtitle("United States Total Coal Combustion-Related PM2.5 Emissions (1999-2008)")

print(plot4)
dev.off() 
