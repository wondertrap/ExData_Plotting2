# Coursera - Exploring Data Analysis - Assigment 2 - plot6

# Question 6: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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
vehiclesPM25Sub1 <- vehiclesPM25[vehiclesPM25$fips==24510,]
vehiclesPM25Sub1$city <-"Baltimore City"

# and subset data from LA County
vehiclesPM25Sub2 <- vehiclesPM25[vehiclesPM25$fips=="06037",]
vehiclesPM25Sub2$city <-"Los Angeles County"

# last not least merge both
vehiclesPM25Sub = rbind(vehiclesPM25Sub1,vehiclesPM25Sub2)



# Create and write png bar plot

png(filename = "plot6.png")

ggp <- ggplot(vehiclesPM25Sub, aes(x=factor(year), y=Emissions/10^3, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^3 Tons)")) + 
    labs(title=expression("Baltimore and LA PM"[2.5]*" Emissions per year from Motor Vehicle Source"))
print(ggp)
dev.off()