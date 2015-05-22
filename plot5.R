# Coursera - Exploring Data Analysis - Assigment 2 - plot5

# Question 5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Libraries
library(ggplot2)

# Preparation
path.dir <- getwd();
data.dir <- paste0(path.dir,"/exdata-data-NEI_data/")

# Loads RDS

dataPM25 <- readRDS(paste0(data.dir,"summarySCC_PM25.rds"))
dataCLSS <- readRDS(paste0(data.dir,"Source_Classification_Code.rds"))

## removing \\. in all the names in classificition codes source
names(dataCLSS)<-gsub("\\.","", names(dataCLSS))

# Subsetting data: vehicles in SCCLEVELTWO
vehicles <- grepl("vehicle", dataCLSS$SCCLevelTwo, ignore.case=TRUE)
vehiclesCLSS <- dataCLSS[vehicles,]$SCC
vehiclesPM25 <- dataPM25[dataPM25$SCC %in% vehiclesCLSS,]

# and subset only data from Baltimore City
vehiclesPM25Sub <- vehiclesPM25[vehiclesPM25$fips==24510,]



# Create and write png bar plot

png(filename = "plot5.png")

ggp <- ggplot(vehiclesPM25Sub,aes(factor(year),Emissions/10^3)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^3 Tons)")) + 
    labs(title=expression("Baltimore City PM"[2.5]*" Emissions per year from Motor Vehicle Source"))
print(ggp)
dev.off()
