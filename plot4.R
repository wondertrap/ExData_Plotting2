# Coursera - Exploring Data Analysis - Assigment 2 - plot2

# Question 4: Across the United States, 
# how have emissions from coal combustion-related sources changed from 1999-2008?

# Libraries
library(ggplot2)

# Preparation
path.dir <- getwd();
data.dir <- paste0(path.dir,"/exdata-data-NEI_data/")

# Loads RDS

#dataPM25 <- readRDS(paste0(data.dir,"summarySCC_PM25.rds"))
#dataCLSS <- readRDS(paste0(data.dir,"Source_Classification_Code.rds"))

## removing \\. in all the names in classificition codes source
names(dataCLSS)<-gsub("\\.","", names(dataCLSS))

# Subsetting data: coal combustion related
combustionRelated <- grepl("comb", dataCLSS$SCCLevelOne, ignore.case=TRUE)
coalRelated <- grepl("coal", dataCLSS$SCCLevelFour, ignore.case=TRUE) 

coalCombustion <- (combustionRelated & coalRelated)
combustionCLSS <- dataCLSS[coalCombustion,]$SCC
combustionPM25 <- dataPM25[dataPM25$SCC %in% combustionCLSS,]

# Create and write png bar plot

png(filename = "plot4.png")
ggp <- ggplot(combustionPM25,aes(factor(year),Emissions/10^3)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^3 Tons)")) + 
    labs(title=expression("Total US PM"[2.5]*" Emissions per year from Coal Combustion Source"))
dev.off()
print(ggp)

