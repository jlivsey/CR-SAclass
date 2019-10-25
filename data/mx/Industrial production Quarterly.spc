
series{ 
    file = "Industrial production Quarterly.dat"
    period = 4
    format = Datevalue
}
transform{ 
    function = auto
}
regression{ 
    variables = ( )
    aictest = ( td easter )
}
outlier{ 
    types = ( AO LS TC )
}
arima{ 
    model =  (0 1 0)(0 1 1)
}
forecast{ 
    maxlead = 20
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
    seasonalma = s3x3
    savelog = all
}
slidingspans{ 
    savelog = percent
    additivesa = percent
}
history{ 
    estimates = (fcst aic sadj sadjchng trend trendchng)
    savelog = (asa ach atr atc) start = 2014.1
}
