series{ 
    file = "Complementary Consumer Confidence Index.dat"
    period = 12
    format = Datevalue #span=(2009.1,)
}
spectrum{ 
    savelog = peaks
}
transform{ 
    function = none
}
regression{ 
    variables = ( TC2017.Jan )
    aictest = ( td easter )
    #savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
#automdl{}
arima{ 
    model =  (1 1 0)(1 0 0)
}
forecast{ 
    maxlead = 60
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
#seats{}
x11{ 
    seasonalma = s3x5
    savelog = all
}
slidingspans{ 
    savelog = percent
    additivesa = percent
}
#history{ 
#    estimates = (fcst aic sadj sadjchng trend trendchng)
#    savelog = (asa ach atr atc)
#}
