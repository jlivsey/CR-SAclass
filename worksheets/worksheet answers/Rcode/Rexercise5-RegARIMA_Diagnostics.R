library(seasonal)

f <- '//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/retail/Furniture and home furnishings stores.dat'

x <- import.ts(file = f, format = "datevalue")
plot(x)

m1 <- seas(x, x11 = "",
           history.estimates = "fcst",
           history.start = "2010.Jan")
summary(m1)

out(m1)



acf(residuals(m1))
pacf(residuals(m1))


# Second Model
m2 <- seas(x, x11 = "",
           history.estimates = "fcst",
           history.start = "2010.Jan",
           arima.model = "(0 1 2)(0 1 1)",
           regression.variables = c("AO2000.Dec", "TD"),
           transform.function = "log")
summary(m2)

# Out-of-sample forecast error plot

h1 <- series(m1, "fce")
h2 <- series(m2, "fce")
diff1 <- h1[,1] - h2[,1]
diff12 <- h1[,2] - h2[,2]
sdiff1 <- (diff1 * length(diff1)) / h2[length(h2[,1]),1]
sdiff12 <- (diff12 * length(diff12)) / h2[length(h2[,2]),2]
plot(sdiff1, 
     ylim = range(sdiff1,sdiff12), 
     main = "Squared Forecast Error Differences, Model 1 - Model 3")
lines(sdiff12, col = "red")
abline(h=0, col = "grey")
