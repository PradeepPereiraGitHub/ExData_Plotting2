#Read the data in
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Subset just the data for Baltimore
NEIBaltimore<-NEI[NEI$fips== "24510",]

NEITotalsByYearBaltimore <- aggregate(Emissions ~ year,NEIBaltimore,sum)
deep<- aggregate(Emissions ~ year + type, NEIBaltimore, sum)
deep1<- aggregate(Emissions ~ year, NEIBaltimore, sum)


#Using the base plotting system, make a plot showing the total PM2.5 emissions
#for Baltimore for each of the years 1999, 2002, 2005, and 2008.

#Save the plot to a png file

png("./GitHub/ExData_Plotting2/plot2.png",width=480,height=480,units="px",bg="white")

qplot(x, y, data=NEIBaltimore, geom="line")
dev.off()
ggplot(deep,aes(factor(year),Emissions,fill=type)) + 
        geom_bar(stat="identity") + 
        theme_bw() + guides(fill=FALSE)+ 
        facet_grid(.~type,scales = "free",space="free") +  
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) 

ggplot(data=deep, aes(factor(year),Emissions, fill=type)) +    
        geom_bar(stat="identity", position="dodge") +
        ggtitle("Baltimore, MD Emission by Type: 1999-2008") +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)"))  

ggplot(deep,aes(type,Emissions,fill=type)) + 
             geom_bar(stat="identity") + 
             theme_bw() + guides(fill=FALSE)+ 
             facet_grid(.~year,scales = "free",space="free") +  
             labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
             labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) 

ggplot(deep,aes(factor(year),Emissions,fill=type)) + 
             geom_bar(stat="identity") + 
             theme_bw() + guides(fill=FALSE)+ 
             facet_grid(.~type,scales = "free",space="free") +  
             labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
             labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) 
 

ggplot(deep,aes(factor(year),Emissions,fill=type)) + 
        geom_bar(stat="identity") + 
        theme_bw() +  guides(fill=FALSE) + 
        facet_grid(type~.,scales = "free_x",space="free") +  
        
           labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) +  
           labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008")) 

#STUPIDLY SIMPLE
ggplot(NEIBaltimore,aes(factor(year),Emissions,fill=type)) + 
        geom_bar(stat="identity") + 
        theme_bw() + guides(fill=FALSE)+ 
        facet_grid(.~type,scales = "free",space="free") +  
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) 
