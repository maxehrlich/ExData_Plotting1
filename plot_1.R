#file has to be in the same folder as the script!!!
#read table
data<-read.table("household_power_consumption.txt",header=T, sep=";")
#make date-format
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Time<-strptime(data$Time,format="%H:%M:%S")

#filter relevant rows (2007-02-01 and 2007-02-02)
data_filtered<-data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

#Global_active_power as numeric column
data_filtered$Global_active_power<-as.numeric(levels(data_filtered$Global_active_power))[data_filtered$Global_active_power]

#adjust margins and textsizes
par(mar=c(4,0,1,1))
par(cex.lab=.7)
par(cex.axis=.7)
par(cex.main=1)
#create histogram with red color, new x-label and new title
with(data_filtered,hist(Global_active_power,col ="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))

#save as pdf
pdf(file="plot_1.pdf") 
with(data_filtered,hist(Global_active_power,col ="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()

