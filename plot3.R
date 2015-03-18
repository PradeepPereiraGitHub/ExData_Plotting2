#Read the data in
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Subset just the data for Baltimore
NEIBaltimore<-NEI[NEI$fips == "24510",]

#ForVisual verification
#NEITotalsByYearBaltimore <- aggregate(Emissions ~ year,NEIBaltimore,sum)
#deep <- aggregate(Emissions ~ year + type, NEIBaltimore, sum)
#deep1 <- aggregate(Emissions ~ year, NEIBaltimore, sum)


#Using the ggplot2 system, make a plot showing the total PM2.5 emissions
#for Baltimore by source type for the years 1999, 2002, 2005, and 2008.

#Save the plot to a png file

png("./GitHub/ExData_Plotting2/plot3.png",,width=480,height=480,units="px",bg="white")

myggplot <- ggplot(NEIBaltimore,aes(factor(year),Emissions,fill=type)) + 
        geom_bar(stat="identity") + 
        theme_bw(base_size=14) + guides(fill=FALSE)+ 
        facet_grid(type~.,scales = "free_x",space="free") +  
        labs(x="Year", y="Total PM2.5 Emissions (tons)") +  
        labs(title="PM2.5 Emissions For Baltimore 1999-2008 - by Type") 
print(myggplot)

dev.off()
