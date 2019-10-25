#x:\courses\2019cr\data\bp\bpdef.spc was created on 8/9/2019 2:06:56 PM

series{ 
    format = Datevalue
    period = 12 modelspan=(2006.1, )
}
spectrum{ 
    savelog = peaks
}
transform{ 
    function = auto
}
regression{ 
    variables = ()
    aictest = ( td easter )
    savelog = aictest
}
outlier{ 
    types = ( AO LS TC )
}
automdl{ 
    savelog = amd
#    maxorder = (3 1)
#    mixed = no
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
    seasonalma = MSR
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
