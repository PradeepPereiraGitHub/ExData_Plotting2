#Read the data in
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Subset just the data for Baltimore and LA
NEIBaltimore<-NEI[NEI$fips == "24510" & NEI$type=="ON-ROAD",]
NEILA<-NEI[NEI$fips == "06037" & NEI$type=="ON-ROAD",]
 
#Assuming all motor vehicles will be of the type 'Onroad'
SCC_All_On_Road <- SCC[SCC$Data.Category == "Onroad",]

#Subset the rows from the NEI dataset whose SCC column values match those of the
#SCC data SC colum values for the category 'Onroad'
#Do it for both Baltimore and LA
NEIBaltimore_On_Road <- subset(NEIBaltimore, SCC %in% SCC_All_On_Road$SCC)
NEILA_On_Road <- subset(NEILA, SCC %in% SCC_All_On_Road$SCC)

library(dplyr)
#Arrange them by SCC num
NEIBaltimore_On_Road <- arrange(NEIBaltimore_On_Road,SCC)
NEILA_On_Road <- arrange(NEILA_On_Road,SCC)

#Add a city column for ggplot-ting purposes
NEIBaltimore_On_Road$City <- "Baltimore"
NEILA_On_Road$City <- "Los Angeles"


#Combine them row wise
Baltimore_LA_On_Road <- rbind(NEIBaltimore_On_Road,NEILA_On_Road)

#Aggregate emissions by year and City and sum on the emissions
Baltimore_LA_On_Road_TotalsByYear <- aggregate(Emissions ~ year+City,Baltimore_LA_On_Road,sum)


# png("./GitHub/ExData_Plotting2/plot6baseplot.png",,width=480,height=480,units="px",bg="white")
# 
# plot(Baltimore_LA_On_Road_TotalsByYear,pch = 17,col = "blue", type="b", 
#      xlab="Year", ylab="Total PM2.5 On Road Based Emissions(tons) - Baltimore & LA", 
#      main="Total Vehicular PM2.5 Emissions In Baltimore & LA By Year"
# )
# dev.off()

library(ggplot2)

png("./GitHub/ExData_Plotting2/plot6ggplot.png",width=480,height=480,units="px",bg="white")

myggplot <- ggplot(Baltimore_LA_On_Road,aes(factor(year),y=Emissions/10^2,fill=City)) + 
        geom_bar(aes(fill=year),stat="identity") + 
        theme_bw(base_size=14) + guides(fill=FALSE)+ 
        facet_grid(City~.,scales = "free_x",space="free") +  
        labs(x="Year", y="Total PM2.5 On Road Based Emissions(10^2 tons) - Baltimore & LA") +  
        labs(title="Total Vehicular PM2.5 Emissions In Baltimore & LA By Year") 
print(myggplot)


dev.off()

