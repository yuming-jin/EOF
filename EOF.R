EOF <- function(stdata = NA,var1 = NA, var2 = NA, time = NA,EOFnumber = 2){
  library(reshape2)
  dimnames(stdata) <- list(var1,var2,time)
  Z <- array()  # array mxn m as space, n as time
  var1var2 <- melt(stdata[,,1])[,c(1,2)]
  for(i in 1:length(time)){
    tmp <- stdata[,,i]
    Z <- cbind(Z,melt(tmp)[,3])
  }
  Z <- Z[,-1]
  
  Z <- t(Z) # convert to time x space
  nT <- nrow(Z) #number of time points
  
  space_mean <- apply(Z,2,mean) # Compute the mean value at each space of the whole ts
  space_detrend <- Z - outer(rep(1, nT), space_mean)
  Zt <- space_detrend #Normalization
  
  E <- svd(Zt) #svd return three matrix: V (space), U(time), and D (singular value)
  
  V <- E$v
  colnames(E$v) <- paste0("EOF", 1:length(E$d)) # label columns
  EOFspace <- cbind(var1var2, E$v[,seq(1,EOFnumber,1)])
  
  colnames(E$u) <- paste0("EOF", 1:length(E$d))
  EOFtime <- data.frame(cbind(time, E$u[,seq(1,EOFnumber,1)]))
  
  EOFtime[,-1] <- EOFtime[,-1]
  EOFd <- E$d/sum(E$d)
  
  eof_output <- list(EOFspace,EOFtime,EOFd)
  return(eof_output)
  print('Return spacial pattern as EOFspace, temporal pattern as EOFtime, and sigular value as EOFd')
}
