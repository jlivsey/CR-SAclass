
series{ 
    file = "CR Regional IPC.dat"
    format = Datevalue
    period = 12 #span=(2011.1,)
}
spectrum{ }
transform{  function = auto }
regression{}# variables = (seasonal) }
outlier{    types = all }
 automdl{ }
#arima{ model = (1 2 1) } 
forecast{ }
estimate{ }
check{ }
x11{ }
slidingspans{ }
