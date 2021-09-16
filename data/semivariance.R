#semivariance function 

#Semivariance function for over water distance

semivariance <- function(xdists, yresp, ncats = NA){
  #Function to calculate semivariance using a distance matrix
  #
  #Where:
  #xdists is the distance matrix
  #yresp is the response and rows of yresp correspond to sites in rows and columns of dists
  #ncats is the resolution. Defaults to sturges rule for histogram classes (as per Legendre book)
  
  nsites <- nrow(xdists)
  y_mean <- mean(yresp)
  
  #Set number of classes if not inputted
  if (is.na(ncats)) 
    ncats <- round(1 + (3.3* log10(((nsites^2)/2)-(nsites/2))))
  
  #
  # DIVIDE SITES INTO DISTANCE CATEGORIES
  #
  
  #Get rid of symmetrical values, and don't allow comparisons of a site to itself
  distdiag <- xdists
  distdiag[!lower.tri(xdists, diag=F)] = NA 
  
  #Group sites
  distcatsm <- cut(as.vector(distdiag), breaks = ncats, labels = F)
  #Get midpoints of cuts
  cutlabs <- levels(cut(as.vector(distdiag), breaks = ncats, dig.lab=4))
  distints <- cbind(lower = as.numeric( sub("\\((.+),.*", "\\1", cutlabs) ),
                    upper = as.numeric( sub("[^,]*,([^]]*)\\]", "\\1", cutlabs) ))
  distmids <- apply(distints, 1, median)
  
  #
  # SEMIVARIANCE CALCULATION
  #
  #Wd is the number of site pairs for a distance class ie Wd = sum(wd)
  #w[h,i] = 1 if the pair is this distance class and 0 if not
  #y[i] is the value at a site
  
  semivar <- rep(NA, ncats)
  moransI <- rep(NA, ncats)
  gearysc <- rep(NA, ncats)
  idistcats <- 1:ncats
  
  #
  #Weights matrix for each distance
  #
  wd.mat <- matrix(0, nrow = nsites^2, ncol = ncats)
  for (d in 1:ncats){
    wd.mat[distcatsm == d,d] <- 1
  }
  Wd <- colSums(wd.mat)
  #NB: Can I vectorise this? 
  #
  #Calculate semivariance
  #
  #Compare every value to every other value
  #squared difference
  sqrdiff <- (rep(yresp,nsites) - rep(yresp, each = nsites) ) ^2
  #NB can also be calculated transpose(Y) %*% Y where Y is a matrix of centred values
  yresp.comp <- matrix(sqrdiff, nrow = nsites^2, ncol = ncats)
  covar <- colSums(wd.mat * yresp.comp)
  semivar <- (1/(2*Wd)) * covar
  
  #
  # Calculate Morans I
  #	
  #squared difference
  sqrdiff <- (rep(yresp,nsites) - y_mean) * (rep(yresp, each = nsites) - y_mean)
  yresp.comp <- matrix(sqrdiff, nrow = nsites^2, ncol = ncats)
  sqrdiff.mean <- (yresp - y_mean)^2
  morans.covar <- colSums(wd.mat * yresp.comp)
  moransI <- (1/Wd) * morans.covar / ((1/nsites) * sum(sqrdiff.mean))
  
  return(data.frame(distances = distmids, semivar = semivar, moransI = moransI))
  
}


#
# Function to plot residuals spatially 
# and their semivariogram 
#
#inputs: dat: sf dataframe used to fit a model
#model: a model object (e.g. from gam or glm)
#site_distmat: matrix of distances between sites 
# where row order is same as that in dat 
#
# Returns a list with a tmap of residuals and a ggplot
# of the semivariogram
plot_spatial_AC <- function(dat, model,
                            site_distmat){
  dat$resids <- resid(model)
  
  t1 <- tm_shape(dat) + 
    tm_symbols(col = "resids", size = 0.5)
  dsemivar <- semivariance(site_distmat, 
                               dat$resids, ncats = 15)
  
  g1 <- ggplot(dsemivar) + 
    aes(x = distances, y = semivar) + 
    geom_point() + 
    stat_smooth()
  
  return(list(t1, g1))
  
}