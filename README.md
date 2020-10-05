# EOF
Empirical Orthogonal Function to compute spatial and temporal pattern of geographic data (Adapted from *Wikle, C. K., Zammit-Mangion, A., and Cressie, N. (2019), Spatio-Temporal Statistics with R*)

---------------------
**Required R packages**

*reshape2*

---------------------

**Defination of Variables**

stdata: 2D array of data, matrix format: space (row) x time (columun)

var1: value of first dimension of space (ex. longitude)

var2: value of second dimension of space (ex. latitude)

time: value of timestep

EOFnumber: number of EOF to obtain in the output

---------------------

**Example**
```
library(ncdf4)

library(lubridate)

nc <- nc_open('uwnd.mon.mean.nc') #download from: https://psl.noaa.gov/data/gridded/data.ncep.reanalysis2.pressure.html

time <- ncvar_get(nc=nc,varid='time')

date <- as.POSIXct(as.character(as.Date(time/24,origin='1800-01-01')))

time <- decimal_date(as.POSIXct(as.character(as.Date(time/24,origin='1800-01-01'))))

lon <- ncvar_get(nc=nc,varid='lon')

lat <- ncvar_get(nc=nc,varid='lat')

p <- ncvar_get(nc=nc,varid='level')

u <- ncvar_get(nc=nc,varid='uwnd')

u <- u[,,which(p==500),]

nc <- nc_open('vwnd.mon.mean.nc') #download from: https://psl.noaa.gov/data/gridded/data.ncep.reanalysis2.pressure.html

v <- ncvar_get(nc=nc,varid='vwnd')

v <- v[,,which(p==500),]

wind <- u+1i*v

stdata <- u

var1 <- lon

var2 <- lat

time <- time

eof_output <- EOF(stdata = stdata,var1 = var1, var2 = var2, time = time,EOFnumber = 2)

EOFspace <- eof_output[[1]]

EOFtime <- eof_output[[2]]

EOFd <- eof_output[[3]]
```

