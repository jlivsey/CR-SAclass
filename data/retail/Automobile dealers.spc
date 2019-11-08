
series{ 
    file = "Automobile dealers.dat"
    period = 12
    format = Datevalue
}
transform{ 
    function = log
    savelog = atr
}
regression{ 
   variables = ( td  TC2001.10
 AO2005.7 LS2008.10 AO2009.8 ) 
    #aictest = ( td easter )
    savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
arima{ model=(0 1 1)(0 1 1) }
#automdl{ savelog = amd }
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
