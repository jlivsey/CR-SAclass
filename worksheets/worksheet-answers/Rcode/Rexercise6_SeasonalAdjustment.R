library(seasonal)

f <- '//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/cr/cr regional ipc.dat'

ipc <- import.ts(file = f, format = "datevalue")
plot(ipc)

c <- seas(ipc, x11 = "",
          outlier.types = "all", 
          automdl = "", 
          slidingspans = "", 
          regression.aictest = NULL)

summary(c)
spectrumgraph(c, "ori")  # NEED: source X13Graphs.r
spectrumgraph(c, "sa")  # NEED: source X13Graphs.r
spectrumgraph(c, "irr") # NEED: source X13Graphs.r
spectrumgraph(c, "rsd") # NEED: source X13Graphs.r
spec.ar(ipc)
qs(c)
out(c)
udg(c, "f3.m07") # Look in HTML document "diag list.html"
monthplot(c); abline(h=1)

# seasonal regressors - test for seasonality
c_seasreg <- seas(ipc, x11 = "",
                  outlier.types = "all", 
                   automdl = "", 
                   slidingspans = "", 
                   regression.aictest = NULL, 
                   regression.variables = c("seasonal", "TC2017.Jan"),
                   arima.model = "(1 1 0)(1 0 0)")
summary(c_seasreg)

monthplot(c)


# ---- Analysis of fuel dealers data ----

f <- '//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/retail/fuel dealers.dat'

x <- import.ts(file = f, format = "datevalue")
plot(x)

fd.x11 <- 
  seas(
    x,
    x11 = "", 
    arima.model = "(0 1 1)(0 1 1)"
  )

spectrumgraph(m, "ori")

# hardcode seasonal filter
fd.x11.hardfilter <- 
  seas(
    x,
    x11 = "", 
    x11.seasonalma = "s3x5",
    arima.model = "(0 1 1)(0 1 1)",
    slidingspans = "",
    history = ""
  )
out(fd.x11.hardfilter)

sigraph(fd.x11.hardfilter)

# New seasonal object 
fd.x11sl <- 
  seas(
    x,
    x11 = "", 
    arima.model = "(0 1 1)(0 1 1)",
    x11.sigmalim = c(1.8, 2.8)
  )
sigraph(fd.x11sl)


# ---- SEATS adjustments ----
fd.seats <- seas(x)
fd.seats2 <- seas(x, series.span = "2004.1,")







