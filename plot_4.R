#file has to be in the same folder as the script!!!
#read table
data<-read.table("household_power_consumption.txt",header=T, sep=";")
#make date-format
data$Date<-as.Date(data$Date,format="%d/%m/%Y")


#filter relevant rows (2007-02-01 and 2007-02-02)
data_filtered<-data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

#make datetime
data_filtered$Datetime<-with(data_filtered,strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))

#sub_metering columns,Global_active_power,Global_reactive_power and Voltage as numeric column
data_filtered$Sub_metering_1<-as.numeric(levels(data_filtered$Sub_metering_1))[data_filtered$Sub_metering_1]
data_filtered$Sub_metering_2<-as.numeric(levels(data_filtered$Sub_metering_2))[data_filtered$Sub_metering_2]
data_filtered$Sub_metering_3<-as.numeric(levels(data_filtered$Sub_metering_3))[data_filtered$Sub_metering_3]
data_filtered$Global_active_power<-as.numeric(levels(data_filtered$Global_active_power))[data_filtered$Global_active_power]
data_filtered$Global_reactive_power<-as.numeric(levels(data_filtered$Global_reactive_power))[data_filtered$Global_reactive_power]
data_filtered$Voltage<-as.numeric(levels(data_filtered$Voltage))[data_filtered$Voltage]

#define sizes of text and margins
par(mar=c(4,4,1,1))
par(mfrow=c(2,2))
#plot 1
with(data_filtered,plot(Datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
#plot2
with(data_filtered,plot(Datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
#plot3
with(data_filtered,plot(Datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(data_filtered,lines(Datetime,Sub_metering_2, type="l",col="red"))
with(data_filtered,lines(Datetime,Sub_metering_3, type="l",col="blue"))
#add legend, make smaller, choose color, choose text
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.7,bty="n")
#plot4
with(data_filtered,plot(Datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global Reactive Power"))

#save as pdf
pdf(file="plot_4.pdf") 
par(mfrow=c(2,2))
with(data_filtered,plot(Datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(data_filtered,plot(Datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(data_filtered,plot(Datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(data_filtered,lines(Datetime,Sub_metering_2, type="l",col="red"))
with(data_filtered,lines(Datetime,Sub_metering_3, type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.7,bty="n")
with(data_filtered,plot(Datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global Reactive Power"))
dev.off()
