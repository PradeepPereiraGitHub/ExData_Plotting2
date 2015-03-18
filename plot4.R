#Read the data in
# NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
# SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
# 
# #Subset just the data for Baltimore
# NEIBaltimore<-NEI[NEI$fips == "24510",]
# 
# 
# Short.Name, EI.Sector, SCC.Level.Three, SCC.Level.Four

#Locate all the occurences of the word 'coal' across the appropriate columns
#from the SCC table, get the rows that return true
# Short.Name.coal<-grepl("coal", SCC$Short.Name, ignore.case=TRUE)
# EI.Sector.coal<-grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
# SCC.Level.Three.coal<-grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE)
# SCC.Level.Four.coal<-grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
# 
# #Add all these ocurrences of rows together where a logical match for 'coal' 
# #occurs in all of thes above columns
# All.coal.Occ.In.SCC <- Short.Name.coal & EI.Sector.coal & SCC.Level.Three.coal & SCC.Level.Four.coal
# 
# #Get all 'SCC' column values from the SCC table that match these logical occurences
# SCC_All_Coal <- SCC[All.coal.Occ.In.SCC,]$SCC
# 
# NEI_All_Coal <- NEI[NEI$SCC %in% SCC_All_Coal,]
# NEI_All_Coal <- arrange(NEI_All_Coal,SCC)
# 
# NEI_All_Coal_TotalsByYear <- aggregate(Emissions ~ year,NEI_All_Coal,sum)

#Get all 'SCC' rows from the SCC table that match the whose columns match 
#occurence of the word 'coal' (case insensitive). 
#We have selected only 4 relevant columns as mentioned below - after having a 
#visual check in the SCC table
#Short.Name, EI.Sector, SCC.Level.Three, SCC.Level.Four

SCC_All_Coal <- subset(SCC, 
                     grepl("coal", Short.Name, ignore.case=TRUE) 
                   | grepl("coal", EI.Sector, ignore.case=TRUE)
                   | grepl("coal", SCC.Level.Three, ignore.case=TRUE)
                   | grepl("coal", SCC.Level.Four, ignore.case=TRUE)                           
                      )

#Subset the rows from the NEI dataset whose SCC column values match those of the
#SCC data SC colum values for the word 'coal'
NEI_All_Coal <- subset(NEI, SCC %in% SCC_All_Coal$SCC)

#Arrange it by SCC num
NEI_All_Coal <- arrange(NEI_All_Coal,SCC)

#Aggregate emissions by year and sum on the emissions
NEI_All_Coal_TotalsByYear <- aggregate(Emissions ~ year,NEI_All_Coal,sum)


png("./GitHub/ExData_Plotting2/plot4baseplot.png",,width=480,height=480,units="px",bg="white")

plot(NEI_All_Coal_TotalsByYear,pch = 17,col = "blue", type="b", 
     xlab="Year", ylab="Total PM2.5 Coal Based Emissions(tons)", 
     main="Total Coal Based PM2.5 Emissions In U.S.A By Year"
)
dev.off()

png("./GitHub/ExData_Plotting2/plot4ggplot.png",,width=480,height=480,units="px",bg="white")

myggplot <- ggplot(NEI_All_Coal,aes(factor(year),Emissions/10^5,fill=type)) + 
        geom_bar(stat="identity") + 
        theme_bw(base_size=14) + guides(fill=FALSE)+ 
        facet_grid(type~.,scales = "free_x",space="free") +  
        labs(x="Year", y="Total PM2.5 Coal Based Emissions(10^5 tons)") +  
        labs(title="Total Coal Based PM2.5 Emissions In U.S.A By Year - By Type") 
print(myggplot)

dev.off()

# 
# ggplot(deepcoalNEI,aes(factor(year),Emissions/10^5,fill=type)) + 
#         geom_bar(stat="identity") + 
#         theme_bw(base_size=14) + guides(fill=FALSE)+ 
#         facet_grid(type~.,scales = "free_x",space="free") +  
#         labs(x="Year", y="Total PM2.5 Coal Based Emissions(10^5 tons)") +  
#         labs(title="Total Coal Based PM2.5 Emissions In U.S.A By Year - By Type") 