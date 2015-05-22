# Coursera - Exploring Data Analysis - Assigment 2 - plot1

# Preparation
path.dir <- getwd();
data.dir <- paste0(path.dir,"/exdata-data-NEI_data/")

# Loads RDS

dataPM25 <- readRDS(paste0(data.dir,"summarySCC_PM25.rds"))
dataCLSS <- readRDS(paste0(data.dir,"Source_Classification_Code.rds"))

# Aggregate data
totalEmissionYear <- aggregate(Emissions ~ year, dataPM25, sum)

# Create and write png bar plot
png(filename = "plot1.png")
barplot(
    (totalEmissionYear$Emissions)/10^6,
    names.arg=totalEmissionYear$year,
    xlab="Year",
    ylab="Total"~ PM[2.5] ~ "Emissions (10^6 Tons)",
    main="Total US " ~ PM[2.5] ~ "Emissions per Year"
)
dev.off()
