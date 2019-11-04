library(seasonal)

bookdata <- import.ts(file = "C:\\Users\\livse301\\Documents\\GitHub\\CR-SAclass\\data\\retail\\Book stores.dat",
                    format = "datevalue")

plot(bookdata)

m <- seas(bookdata, x11="")

out(m)

library(seasonalview)
view(m)

sa <- final(m)
plot(sa)

tr <- trend(m)

plot(bookdata)
lines(sa, col = 2)
lines(tr, col = 3)

summary(m)
udg(m)

udg(m, "nfcst")

vignette("seas")


