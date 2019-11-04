library(seasonal)

f <- '//it171oafs-oa17/ECON_SHARE/X-13/courses/2019CR/data/mx/National Unemployment Rate.dat'
nur <- import.ts(file = f, format = 'datevalue')

plot(nur)

amd <- seas(nur, regression.aictest = NULL, x11.seasonalma = 's3x3')

summary(amd)
out(amd)

# No mixed model
amd_nomix <- seas(nur, 
                  regression.aictest = NULL, 
                  x11.seasonalma = 's3x3',
                  automdl.mixed = 'no')

summary(amd_nomix)


# First differencing
amd_diff11 <- seas(nur, 
                  regression.aictest = NULL, 
                  x11.seasonalma = 's3x3',
                  automdl.diff = c(1, 1))
summary(amd_diff11)


# Look at Transformation 
plot(nur)
plot(log(nur))
out(amd)

amd_notransf <- seas(nur, 
                   regression.aictest = NULL, 
                   x11.seasonalma = 's3x3',
                   transform.function = 'none')
summary(amd_notransf)


# Plot final adjustments
plot(final(amd))
lines(final(amd_diff11), col = "blue")
lines(final(amd_notransf), col = "red")

