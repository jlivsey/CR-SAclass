library(seasonal)

f <- '//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/retail/automobile dealers.dat'

ad <- import.ts(file = f, format = "datevalue")

plot(ad)

m <- seas(ad, outlier.types = "all", x11 = "")

summary(m)

# hard-code ARIMA model 
m_arima <- seas(ad, 
                outlier.types = "all", 
                x11 = "", 
                arima.model = '(0 1 1)(0 1 1)')
out(m_arima)
summary(m_arima)



# hard-code transformation, regression variables and outliers

static(m)

m_static <- 
  seas(x = ad, 
       x11 = "", 
       regression.variables = c("td", "tc2001.Oct", 
                                "ao2005.Jul", "ls2008.Oct", "ao2009.Aug"),
       arima.model = "(0 1 1)(0 1 1)", 
       regression.aictest = NULL, 
    #   outlier = NULL, 
       transform.function = "log")

summary(m_static)