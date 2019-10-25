#X:\courses\2015\series\retail\Food and beverage stores.spc was created on 9/22/2016 3:13:07 PM
#Created using X-13A-S version 1.1 build 35

series{ 
    file = "Food and beverage stores.dat"
    period = 12
    format = Datevalue modelspan=(2005.1, )
}
transform{ 
    function = log
}
regression{ 
    variables = ( td  easter[8]  AO1999.Dec AO2000.Jan LS2008.Dec )
    #aictest = ( td easter )
    #savelog = aictest
}
outlier{ 
    types = ( AO LS )
}
arima{ 
    model =  (0 1 1)(0 1 1)
}
forecast{ 
    maxlead = 12
    print = none
}
estimate{ 
    print = (roots regcmatrix acm)
    savelog = (aicc aic bic hq afc)
}
check{ 
    print = all
    savelog = (lbq nrm)
}
x11{ 
    seasonalma = s3x5
    savelog = all
}
slidingspans{ 
    savelog = percent
    additivesa = percent
}
history{ 
    estimates = (fcst aic sadj sadjchng trend trendchng)
    savelog = (asa ach atr atc)
}
