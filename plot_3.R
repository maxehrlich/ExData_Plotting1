#file has to be in the same folder as the script!!!
#read table
data<-read.table("household_power_consumption.txt",header=T, sep=";")
#make date-format
data$Date<-as.Date(data$Date,format="%d/%m/%Y")


#filter relevant rows (2007-02-01 and 2007-02-02)
data_filtered<-data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

#make datetime
data_filtered$Datetime<-with(data_filtered,strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))

#sub_metering columns as numeric column
data_filtered$Sub_metering_1<-as.numeric(levels(data_filtered$Sub_metering_1))[data_filtered$Sub_metering_1]
data_filtered$Sub_metering_2<-as.numeric(levels(data_filtered$Sub_metering_2))[data_filtered$Sub_metering_2]
data_filtered$Sub_metering_3<-as.numeric(levels(data_filtered$Sub_metering_3))[data_filtered$Sub_metering_3]

#define sizes of text and margins
par(mar=c(3,1,1,1))
par(cex.lab=.7)
par(cex.axis=.7)
par(cex.main=1)
par("mar")
#create lineplot wit first column
with(data_filtered,plot(Datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
#add lines for other columns
with(data_filtered,lines(Datetime,Sub_metering_2, type="l",col="red"))
with(data_filtered,lines(Datetime,Sub_metering_3, type="l",col="blue"))
#add legend, make smaller, choose color, choose text
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.5)

#save as pdf
pdf(file="plot_3.pdf") 
with(data_filtered,plot(Datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(data_filtered,lines(Datetime,Sub_metering_2, type="l",col="red"))
with(data_filtered,lines(Datetime,Sub_metering_3, type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1)
dev.off()
