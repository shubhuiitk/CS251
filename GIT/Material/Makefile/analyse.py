#!/usr/bin/python
import re
import os


data=[]
params=[]
threads=[]
mean_data=[]

with open("params.txt") as f:
    for line in f:
        for i in line.split():
            params.append(i)


with open("threads.txt") as f:
    for line in f:
        for i in line.split():
            threads.append(i)

with open("runtest") as f:
    for line in f:
        words=line.split("\n")
        data.append(words[0])

f = open("speedvar.txt","w")
g = open("speedup.txt","w")
h = open("mean.txt", "w")
count,sum1,sum2 = 0,0,0.0
for p in params:

    for i in range(0,100):
        sum1 = sum1 + int(data[count+i])
    mean1 = round(sum1/100.0 , 2);
    sum1=0

    for i in range(100,200):
        sum1 = sum1 + int(data[count+i])
    mean2 = round(sum1/100.0 , 2);
    sum1=0

    for i in range(200,300):
        sum1 = sum1 + int(data[count+i])
    mean3 = round(sum1/100.0 , 2);
    sum1=0

    for i in range(300,400):
        sum1 = sum1 + int(data[count+i])
    mean4 = round(sum1/100.0 , 2);
    sum1=0

    for i in range(400,500):
        sum1 = sum1 + int(data[count+i])
    mean5 = round(sum1/100.0 , 2);
    sum1=0.0

    for i in range(0,100):
        sum1 = sum1 + (float(data[count+i])/mean1*1.0)
        sum2 = sum2 + (float(data[count+i])/mean1*1.0)*(float(data[count+i])/mean1)
    var1 = round( sum2/100.0 - sum1*sum1/10000.0 ,5)
    sum1=0.0
    sum2=0.0

    for i in range(100,200):
        sum1 = sum1 + (float(data[count+i])/mean1*1.0)
        sum2 = sum2 + (float(data[count+i])/mean1*1.0)*(float(data[count+i])/mean1)
    var2 = round( sum2/100.0 - sum1*sum1/10000.0 ,5)
    sum1=0.0
    sum2=0.0

    for i in range(200,300):
        sum1 = sum1 + (float(data[count+i])/mean1*1.0)
        sum2 = sum2 + (float(data[count+i])/mean1*1.0)*(float(data[count+i])/mean1)
    var3 = round( sum2/100.0 - sum1*sum1/10000.0 ,5)
    sum1=0.0
    sum2=0.0

    for i in range(300,400):
        sum1 = sum1 + (float(data[count+i])/mean1*1.0)
        sum2 = sum2 + (float(data[count+i])/mean1*1.0)*(float(data[count+i])/mean1)
    var4 = round( sum2/100.0 - sum1*sum1/10000.0 ,5)
    sum1=0.0
    sum2=0.0

    for i in range(400,500):
        sum1 = sum1 + (float(data[count+i])/mean1*1.0)
        sum2 = sum2 + (float(data[count+i])/mean1*1.0)*(float(data[count+i])/mean1)
    var5 = round( sum2/100.0 - sum1*sum1/10000.0 ,5)
    sum1=0.0
    sum2=0.0

    count=count+500
    temp2 = p + " " + str(mean1) + " " + str(mean2) + " " + str(mean3) + " " + str(mean4) + " " + str(mean5)
    h.write(temp2 + "\n")
    temp = p + " " + str(mean1*1.0/mean1) + " " + str(mean1/mean2*1.0) + " " + str(mean1*1.0/mean3) + " " + str(mean1*1.0/mean4) + " " + str(mean1*1.0/mean5)
    g.write(temp + "\n")
    temp = temp + " " + str(var1) + " " + str(var2) + " " + str(var3) + " " + str(var4) + " " + str(var5) + "\n"
    f.write(temp)
f.close()
g.close()

f = open("threaddata.txt","w")
cnt=0
for t in range(0,5):
    for inpar in range(0,len(params)):
        for i in range(0,100):
            temp = params[inpar] + " " + data[cnt + 500*inpar + i] + "\n"
            f.write(temp)
    cnt = cnt + 100
f.close()
