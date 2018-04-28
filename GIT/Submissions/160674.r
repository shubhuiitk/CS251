num_samples <- 50000
data <- rexp(num_samples, 0.2)
x <- data.frame(X=seq(1,num_samples,1), Y=sort(data))
temp <- split(data, as.integer((seq_along(data) - 1) /100 ))
plot(x)

for(j in 1:5)
{

pdata <- rep(0, 100);

for(i in 1:100){
    val=round(temp[[j]][i], 0);
    if(val <= 20){
       pdata[val] = pdata[val] + 1/100; 
    }
}
xcols <- c(0:99)
plot(xcols, pdata, "l", xlab="X", ylab="f(X)")

cdata <- rep(0, 100)

cdata[1] <- pdata[1]

for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
}
plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");

}


print (mean(temp[[1]]))
print (sd(temp[[1]]))
print (mean(temp[[2]]))
print (sd(temp[[2]]))
print (mean(temp[[3]]))
print (sd(temp[[3]]))
print (mean(temp[[4]]))
print (sd(temp[[4]]))
print (mean(temp[[5]]))
print (sd(temp[[5]]))

mdata <- 0

for(i in 1:500){
    mdata[i] = mean(temp[[i]])
}

tab <- table(round(mdata,1))
plot(tab, "h", xlab="Value", ylab="Frequency")

pdata <- rep(0, 100);

for(i in 1:500){
    val=round(mdata[i], 0);
    if(val <= 20){
       pdata[val] = pdata[val] + 1/100; 
    }
}
xcols <- c(0:99)
plot(xcols, pdata, "l", xlab="X", ylab="f(X)")

cdata <- rep(0, 100)

cdata[1] <- pdata[1]

for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
}
plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");


print(sd(mdata))
print(mean(data))
a <- 1/0.2
a

