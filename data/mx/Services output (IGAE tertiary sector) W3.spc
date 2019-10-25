
series{ 
    file = "Services output (IGAE tertiary sector).dat"
    period = 12
    format = Datevalue #modelspan=(2008.1,)
}
spectrum{ 
    savelog = peaks
}
transform{ 
    function = log
}
regression{ 
    variables = ( tdnolpyear lpyear 
	LS1995.Feb LS1995.Apr LS2000.Jan LS2008.Dec TC2009.Apr 
   )
    aictest = ( easter )
}
outlier{ 
    types = ( AO LS TC )
}
arima{ model = (1 1 0)(0 1 1) }
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
    savelog = (asa ach atr atc)
}
