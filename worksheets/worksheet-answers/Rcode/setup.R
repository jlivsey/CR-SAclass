library(seasonal)

fsdata <- import.ts(file = "//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/retail/furniture stores.dat",
                    format = "datevalue",
                    name = "James-furniture")

fs <- seas(fsdata, series.span="1998.1,", x11="")

out(fs)

view(fs)



dat <- import.ts(file = "//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/cr/CR Regional IMAE.dat",
                    format = "datevalue")
plot(dat)
spec.ar(dat)
spec.pgram(dat)

acf(diff(dat))

n <- length(dat)
M <- matrix(dat[-((n-7):n)], ncol = 12)
plot.ts(M[, 1:4])


