#x:\courses\2019cr\data\bp\MWTotal.spc was created on 8/9/2019 1:34:51 PM
#Created using X-13A-S version 1.1 build 48

series{ 
    file = "MWTotal.dat"
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
    variables = ( td1coef   easter[1] )
    #aictest = ( td easter )
    #savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
arima{ 
    model =  (0 1 1)(0 1 1)
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
