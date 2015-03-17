#Read the data in
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Aggregate all the emissions by year and sum them
NEITotalsByYear <- aggregate(Emissions ~ year,NEI,sum)

#Using the base plotting system, make a plot showing the total PM2.5 emissions
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#Save the plot to a png file

png("./GitHub/ExData_Plotting2/plot1.png",width=480,height=480,units="px",bg="white")

plot(NEITotalsByYear,pch = 17,col = "blue", type="b", 
     xlab="Year", ylab="Total PM2.5 Emissions(tons)", 
     main="Total PM2.5 Emissions In U.S.A By Year"
)


dev.off()
