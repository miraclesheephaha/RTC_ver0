#Disable command echo to keep the output clean(don't print each command)
echo -off
#Read 32-bit status value from I/O port 0x0500
mm 500 -w 4 -IO
# mm 0500 05000001 -w 4 -IO
###

#RTC time set 0:0:0 and time start

#CMOS index=0x01
mm 70 00 -w 1 -IO
#CMOS[0X01]=0X00
mm 71 00 -w 1 -IO

mm 70 02 -w 1 -IO
mm 71 00 -w 1 -IO
mm 70 04 -w 1 -IO
mm 71 00 -w 1 -IO

#Alarm set
mm 70 01 -w 1 -IO
mm 71 05 -w 1 -IO
mm 70 03 -w 1 -IO
mm 71 00 -w 1 -IO
mm 70 05 -w 1 -IO
mm 71 00 -w 1 -IO

mm 70 0C -w 1 -IO
mm 71 -w 1 -IO

mm 70 0B -w 1 -IO
mm 71 20 -w 1 -IO

time
#stall 5000000 # wait 5sec
mm 500 -w 4 -IO
mm 70 0C -w 1 -IO
mm 71 -w 1 -IO # read register C
mm 70 0C -w 1 -IO
mm 71 -w 1 -IO

#Clear RTC_STS bit in PM1 register to avoid pending wake
mm 501 04 -w 1 -IO
mm 0500 05000001 -w 4 -IO
mm 0504 00003C00 -w 4 -IO
time



