#x:\courses\2019cr\data\bp\WeTotal.spc was created on 8/9/2019 1:35:30 PM
#Created using X-13A-S version 1.1 build 48

series{ 
    file = "WeTotal.dat"
    format = Datevalue #modelspan=(2009.1,)
    period = 12
}
spectrum{ 
    savelog = peaks
}
transform{ 
    function = log
}
regression{ 
    variables = (td1coef  AO2010.Dec )
#    aictest = ( td easter )
    #savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
#automdl{maxorder=(3 1) mixed=no }
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
seats{}
#x11{ 
#    seasonalma = s3x5 sigmalim=(1.8 2.8)
#    savelog = all
#}
slidingspans{ 
    savelog = percent
    additivesa = percent
}
history{ 
    estimates = (fcst aic sadj sadjchng trend trendchng)
    savelog = (asa ach atr atc)
}
