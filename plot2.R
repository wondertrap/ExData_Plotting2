# Coursera - Exploring Data Analysis - Assigment 2 - plot2

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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
png(filename = "plot2.png")
barplot(
    (totalEmissionYear$Emissions)/10^3,
    names.arg=totalEmissionYear$year,
    xlab="Year",
    ylab="Total"~ PM[2.5] ~ "Emissions (10^3 Tons)",
    main="Total Balitmore City " ~ PM[2.5] ~ "Emissions per Year"
)
dev.off()
