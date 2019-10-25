
series{ 
    file = "Automobile dealers.dat"
    period = 12
    format = Datevalue
}
transform{ 
    function = auto 
    savelog = atr
}
regression{ 
    aictest = ( td easter )
    savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
automdl{ savelog = amd }
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
