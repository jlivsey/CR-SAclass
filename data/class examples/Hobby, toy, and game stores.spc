#Hobby, toy, and game stores.spc was created on 5/10/2018 4:56:49 PM
#Created using X-13A-S version 1.1 build 48

series{ 
  file="Hobby, toy, and game stores.dat" format=datevalue
  span=(2002.Jan,)
  comptype=add
}
spectrum{savelog=all}
transform{function=log}
regression{variables=( td easter[8] ) # AO1996.May AO1996.Dec )
 #aictest=( td easter ) savelog=aictest
}
outlier{types=( AO LS TC ) lsrun=3}
arima{model=(0 1 2)(0 1 1)}
forecast{maxlead=36 print=none}
estimate{print=all savelog=all}
#estimate{print=(roots regcmatrix acm) savelog=all}
check{print=all savelog=all}
x11{
  seasonalma=s3x3
  savelog=all
}
slidingspans{savelog=percent additivesa=percent print=all}
history{start=2014.1 estimates=(fcst aic sadj sadjchng trend trendchng)
  print=all savelog=all
}
