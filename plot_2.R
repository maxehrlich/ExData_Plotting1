#file has to be in the same folder as the script!!!
#read table
data<-read.table("household_power_consumption.txt",header=T, sep=";")
#make date-format
data$Date<-as.Date(data$Date,format="%d/%m/%Y")


#filter relevant rows (2007-02-01 and 2007-02-02)
data_filtered<-data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

#make datetime
data_filtered$Datetime<-with(data_filtered,strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))

#Global_active_power as numeric column
data_filtered$Global_active_power<-as.numeric(levels(data_filtered$Global_active_power))[data_filtered$Global_active_power]

#create lineplot
with(data_filtered,plot(Datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

#save as pdf
pdf(file="plot_2.pdf") 
with(data_filtered,plot(Datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()
