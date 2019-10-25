#yearyeargraph(m,abbrv,graph.title) :
##Creates a graph with each year its own line.
##m is a seasonal object
##abbrv is the series type to graph -- something that can be passed to series(m,abbrv)
##graph.title is the graph title.
##common graphs might have:
##	abbrv="a1" graph.title="Original Series"
##	abbrv="b1" graph.title="Prior-Adjusted Series"
##	abbrv="d11" graph.title="Seasonally Adjusted Series"
##	abbrv="d12" graph.title="Trend"

#ssfegraph(m1,m2)
##Sum of squared forecast error difference graph
##m1 and m2 are seasonal objects
##that have been run with history.estimates="fcst"

#spectrumgraph(seasonal object,component)
##plots the spectrum graph calculated by X-13A-S 
#set component = "rsd" for residuals, "ori" for original, "sa" for 
#seasonally adjusted series, or "irr" for irregular

#sigraph(seasonal object)
##for a series with an X11 adjustment, plots the seasonal factors,
##and the unadjusted and adjusted SI ratios

#sfcompgraph(m1,m2,sf1="sf",sf2="sf")
##overlays the seasonal factors of the seasonal objects m1 and m2.
##By default the purely seasonal factors (d10 or s10) will be plotted;
##to instead plot the combined seasonal factors (d16 or s16) of m1 and/or m2, set sf1="cf" and/or sf2="cf"

yearyeargraph <- function(m,abbrv,graph.title=""){
fq <- udg(m,"freq")
ser <- series(m,abbrv)

first.year <- start(ser)[1]
last.year <- end(ser)[1]

if(last.year - first.year + 1 > 18){
  first.year <- last.year - 17
  print("Only the last 18 years will be plotted.")
}
our.colors <- c("navy","purple","magenta3","thistle4","steelblue4","springgreen4","lightseagreen",
 "darkgoldenrod2","firebrick2","darkred","indianred4","coral3","rosybrown4","gray57","honeydew3",
 "yellowgreen","darkorange","pink2","dodgerblue2")
 
 
plot(1:(fq+1), type="n",   ylim=range(ser), bty="o",las="1",ann=FALSE, )
title(main=paste(graph.title," -- ",deparse(substitute(m))))
if(fq==12) title(xlab = "Month")
else if(fq==4) title(xlab = "Quarter")
else title(xlab="Period")

y.vals <- window(ser,start=c(first.year,1),end=c(first.year+1,1))
x.ax.val <- start(ser)[2]:13
lines(x.ax.val,y.vals,col=our.colors[1])

for(v in first.year + 1:last.year){
	y.vals <- window(ser,start=c(v,1),end=c(v+1,1))
	x.ax.val <- 1:length(y.vals)
	lines(x.ax.val,y.vals,col=our.colors[v - first.year + 1])
}
 

}

ssfegraph <- function(m1,m2) {
 
 require(seasonal)
 fq1 <- udg(m1,"freq")
 fq2 <- udg(m2,"freq")
 if(fq1 != fq2) stop("Series must have the same period.")

 h1 <- series(m1,"fce")
 h2 <- series(m2,"fce")

 if(time(h1)[1] != time(h2)[1]){
    if(time(h1)[1] > time(h2)[1]){ first.time <- start(h1) }
    else{ first.time <- start(h2) }
     
	 ftp <- first.time
	 ftp[2] <- ftp[2] - 1
	 if (ftp[2] == 0){
		ftp[2] <-12
	      ftp[1] <- ftp[1] - 1
   	 }
       first.time.s <- first.time
       first.time.s[2] <- first.time.s[2] + (fq1-1)
       if(first.time.s[2] > fq1){
		first.time.s[1] <- first.time.s[1] + 1
            first.time.s[2] <- first.time.s[2] - fq1
       }
	 ftps <- first.time.s
	 ftps[2] <- ftps[2] - 1
       if(ftps[2] == 0){
		ftps[2] <- fq1
		ftps[1] <- ftps[1] - 1
 	}

    z1 <- window(h1,start=first.time)    
    z2 <- window(h2,start=first.time)
       if(time(h1)[1] > time(h2)[1]) {
	z2[,1] = z2[,1] - window(h2,start=ftp,end=ftp)[1]
	z2[,2] <- z2[,2] - window(h2,start=ftps,end=ftps)[2]
	z2[1:11,2] <- 0
	
    }
    else{
	z1[,1] = z1[,1] - window(h1,start=ftp,end=ftp)[1]
	z1[,2] <- z1[,2] - window(h1,start=ftps,end=ftps)[2]
	z1[1:11,2] <- 0

    }



   h1 <- z1
   h2 <- z2
 }
                               


 diff1 <- h1[,1] - h2[,1]
 diff12 <- h1[,2] - h2[,2]

 sdiff1 <- (diff1 * length(diff1)) / h2[length(h2[,1]),1]
 sdiff12 <- (diff12 * (length(diff12)-(fq1-1))) / h2[length(h2[,2]),2]
 
 
 ttl <- paste("Squared Forecast Error Differences,",deparse(substitute(m1)),"-",deparse(substitute(m2)))
 plot(sdiff1,ylim=range(sdiff1,sdiff12),main=ttl,
    ylab="",xlab="")
 lines(sdiff12,col="red")
 abline(h=0,col="gray")


}


spectrumgraph <- function(m,comp){
require(seasonal)
if(udg(m,"freq") != 12){ stop("monthly only") }
if(comp == "rsd") {
	spcmp<- series(m,"spr")
	ttl <- "Residuals"
}
else if(comp == "sa"){
	if(udg(m,"samode") == "SEATS seasonal adjustment") spcmp <- series(m,"s1s")
	else spcmp <- series(m,"sp1")
	ttl <- "Seasonally Adjusted Series"
}
else if(comp == "ori"){ 
	spcmp<-series(m,"sp0")
	ttl <- "Original Series"
}
else if(comp == "irr"){ 
	if(udg(m,"samode") == "SEATS seasonal adjustment") spcmp <- series(m,"s2s")
	else spcmp <- series(m,"sp2")
	ttl <- "Irregular"
}
else{ stop("Component must be ori, rsd, sa, or irr") }

mincmp <- min(spcmp[,2])
maxcmp <- max(spcmp[,2])
medcmp <- median(spcmp[,2])

vs <- (maxcmp - mincmp) * 6/52

fq <- list()
de <- list()

fq[seq(1,181,3)] <- spcmp[,1]
fq[seq(2,182,3)] <- spcmp[,1]
fq[seq(3,183,3)] <- spcmp[,1]
de[seq(1,181,3)] <- mincmp
de[seq(2,182,3)] <- spcmp[,2]
de[seq(3,183,3)] <- mincmp
 
plot(0,xlim=range(seq(0,0.5,1/12)),type="n",ylim=range(spcmp[,2],maxcmp+vs/6),ann=FALSE,
)
title(main=paste("Spectrum of the",ttl," -- ",deparse(substitute(m))))
title(xlab = "Frequency")

abline(v=seq(0,1/2,1/12),lty=5,col="red")
abline(v=c(0.3482,0.432),lty=5,col="orange")
lines(fq,de,lty=1,col="black",lwd=2)
segments(x0=0.51,x1=0.51,y0=medcmp,y1=medcmp+vs,col="blue",lwd=2)
segments(y0=medcmp,y1=medcmp,x0=0.505,x1=0.515,col="blue",lwd=2)
for(q in 1:5){
 kc <- paste0("spc",comp,".s",q)
 tp <- udg(m,kc)
 
 if(tp[1] != "nopeak" && length(tp) == 2){
   if(as.numeric(tp[1]) >= 6.0 && tp[2] == "+"){
    text(x=q/12,y=spcmp[1+q*10,2]+vs/6,labels="S",col="blue")
 }
 }
}
tdf <- c(43,53)
for(q in 1:2){
 kc <- paste0("spc",comp,".t",q)
 tp <- udg(m,kc)
 
 if(tp[1] != "nopeak" && length(tp) == 2){
   if(as.numeric(tp[1]) >= 6.0 && tp[2] == "+"){
    text(x=spcmp[tdf[q],1],y=spcmp[tdf[q],2] + vs/6,labels="T",col="blue")
 }
 }
}

}



sigraph <- function(m) {

pd <- udg(m,"freq")
if(pd != 4 && pd != 12) { stop("monthly or quarterly only") }
require(seasonal)
d8 <- series(m,"d8")
d9 <- series(m,"d9")
d10 <- series(m,"d10")

maxlen <- length(subset(d10,cycle(d10)==1))
for(v in 2:pd) {
 maxlen <- max(maxlen,length(subset(d10,cycle(d10)==v)))
}

#sirat <-d8
#sirat[!is.na(d9)] <- d9[!is.na(d9)]

#rsi <- d8
#rsi[is.na(d9)] <- NA

msf <- d10
for(v in 1:pd){
 mm <- mean(subset(d10,cycle(d10)==v))
 msf[cycle(d10)==v] <- mm
}

ylimlp <- range(d10,d8,d9[!is.na(d9)])
upp <- maxlen * pd + pd
midpt <- (maxlen+1)/2

plot(1:upp, type="n", xaxt="n", ylim=ylimlp, bty="o",las="1",ann=FALSE,xaxs="i")

abline(v=seq(maxlen+1,upp,maxlen+1),lty=1,col="gray")

if(pd == 12) {
title(xlab = "Month") 
for(v in 1:12){
 mtext(month.abb[v],side=1,at=midpt * (2*v - 1))
}
}
else {
title(xlab = "Quarter") 
for(v in 1:4){
mtext(paste("Q",v),side=1,at=midpt * (2*v - 1))
}
}

title(main=paste("SI Ratios -- ",deparse(substitute(m))))


for(v in 1:pd){
 start = (v-1)*(maxlen + 1) + 1
 end = start + length(subset(d10,cycle(d10)==v)) -1
 lines(start:end,subset(d10,cycle(d10)==v),col="blue",lwd=1)
 lines(start:end,subset(msf,cycle(d10)==v),col="darkblue",lwd=1)
 points(start:end,subset(d8,cycle(d10)==v),col="gray",pch=21)
 points(start:end,subset(d9,cycle(d10)==v),col="red",pch=19)

}

}

sfcompgraph <- function(m1,m2,sf1="sf",sf2="sf") {

pd <- udg(m1,"freq")
pd2 <- udg(m2,"freq")
if(pd != 4 && pd != 12) { stop("monthly or quarterly only") }
if(pd != pd2) {stop("series periods do not match")}

require(seasonal)

if(sf1 != "cf"){
if(udg(m1,"samode") == "SEATS seasonal adjustment") d10 <- series(m1,"s10")
else d10 <- series(m1,"d10")
}
else{
if(udg(m1,"samode") == "SEATS seasonal adjustment") d10 <- series(m1,"s16")
else d10 <- series(m1,"d16")
}

if(sf2 != "cf"){
if(udg(m2,"samode") == "SEATS seasonal adjustment") d10a <- series(m2,"s10")
else d10a <- series(m2,"d10")
}
else{
if(udg(m2,"samode") == "SEATS seasonal adjustment") d10a <- series(m2,"s16")
else d10a <- series(m2,"d16")
}


if(sf1 == sf2 && sf1=="cf") comb <- "Combined"
else if(sf1 == "cf" || sf1=="cf") comb <- "[Combined]"
else comb <- ""

start.year <- min(start(d10)[1],start(d10a)[1])
end.year <- max(end(d10)[1],end(d10a)[1])
maxlen <- end.year - start.year + 1
 
#print(start.year)
#print(end.year)
#print(maxlen)

msf <- d10
msfa <- d10a
for(v in 1:pd){
 mm <- mean(subset(d10,cycle(d10)==v))
 msf[cycle(d10)==v] <- mm

 mm <- mean(subset(d10a,cycle(d10a)==v))
 msfa[cycle(d10a)==v] <- mm
}

ylimlp <- range(d10,d10a)
upp <- maxlen * pd + pd
midpt <- (maxlen+1)/2

plot(1:upp, type="n", xaxt="n", ylim=ylimlp, bty="o",las="1",ann=FALSE,xaxs="i")

abline(v=seq(maxlen+1,upp,maxlen+1),lty=1,col="gray")

if(pd == 12) {
title(xlab = "Month") 
for(v in 1:12){
 mtext(month.abb[v],side=1,at=midpt * (2*v - 1))
}
}
else {
title(xlab = "Quarter") 
for(v in 1:4){
mtext(paste("Q",v),side=1,at=midpt * (2*v - 1))
}
}

title(main=paste(comb,"Seasonal Factors -- ",deparse(substitute(m1)),"and",deparse(substitute(m2))))


for(v in 1:pd){
 start = (v-1)*(maxlen + 1) + 1 - start.year + start(d10)[1]
 
 end = start + length(subset(d10,cycle(d10)==v)) -1
 
 lines(start:end,subset(d10,cycle(d10)==v),col="blue",lwd=1)
 lines(start:end,subset(msf,cycle(d10)==v),col="darkblue",lwd=1)
 start = (v-1)*(maxlen + 1) + 1 - start.year + start(d10a)[1]
 
 end = start + length(subset(d10a,cycle(d10a)==v)) -1
 
 lines(start:end,subset(d10a,cycle(d10a)==v),col="red",lwd=1)
 lines(start:end,subset(msfa,cycle(d10a)==v),col="darkred",lwd=1)

}

}
  