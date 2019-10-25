#X:\courses\2019CR\data\Res2019\HousesForSaleUS.spc was created on 8/9/2019 11:37:51 AM
#Created using X-13A-S version 1.1 build 48

series{ 
    file = "HousesForSaleUS.dat"
    format = Datevalue
    period = 12
}
spectrum{ 
    savelog = peaks
}
transform{ 
    function = log
}
regression{ 
    variables = ( tdstock1coef[31]   easterstock[1]  AO2013.Jun )
    #aictest = (tdstock easterstock )
    #savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
arima{ 
    model =  (2 1 0)(1 0 0)
}
forecast{ 
    maxlead = 36
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
