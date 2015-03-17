#Read the data in
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Subset just the data for Baltimore
NEIBaltimore<-NEI[NEI$fips== "24510",]

#Aggregate all the emissions by year and sum them for Baltimore
NEITotalsByYearBaltimore <- aggregate(Emissions ~ year,NEIBaltimore,sum)

#Using the base plotting system, make a plot showing the total PM2.5 emissions
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#Save the plot to a png file

png("./GitHub/ExData_Plotting2/plot2.png",width=480,height=480,units="px",bg="white")

plot(NEITotalsByYearBaltimore,pch = 17,col = "red", type="b", 
     xlab="Year", ylab="Total PM2.5 Emissions(tons)", 
     main="Total PM2.5 Emissions In Baltimore By Year"
)


dev.off()
