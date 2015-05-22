# Coursera - Exploring Data Analysis - Assigment 2 - plot3

# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Libraries
library(ggplot2)

# Preparation
path.dir <- getwd();
data.dir <- paste0(path.dir,"/exdata-data-NEI_data/")

# Loads RDS

dataPM25 <- readRDS(paste0(data.dir,"summarySCC_PM25.rds"))
dataCLSS <- readRDS(paste0(data.dir,"Source_Classification_Code.rds"))

# Subsetting data
# Balitmore City, Maryland
dataPM25Sub<-subset(dataPM25, fips == "24510")

# Aggregate data
totalEmissionYear <- aggregate(Emissions ~ year, dataPM25Sub, sum)

# Create and write png bar plot
png(filename = "plot3.png")

ggp <- ggplot(dataPM25Sub,aes(factor(year),Emissions/10^3,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^3 Tons)")) + 
    labs(title=expression("Baltimore City PM"[2.5]*" Emissions per Year and Source Type"))
print(ggp)
dev.off()

