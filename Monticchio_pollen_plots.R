# Create a simple plot of a pollen diagram for Monticchio

# Set the working directory
setwd("~/GitHub/Bclim_talks")

# Load in the data
FossilPollen <- as.matrix(read.table("monticchio_pollen_131213.txt",header=TRUE))[,c(2,3,28)] # Only loading in three of the taxa - you can change this to more if required

# Load in the ages of each layer
FossilChron <- as.matrix(read.table("Monticchio_chrons.txt"))

##################################################################

# Now create a plot

polnames <- colnames(FossilPollen)

# Use the layout function to create a nice plotting layout
temp <- sort(rep(seq(3,ncol(FossilPollen)+2),3))
mylayout <- c(1,2,temp)
layout(rbind(mylayout))

# Run the next (commented out) line if you want to see what the plot structure will look like
#layout.show(max(mylayout))


# Create the left-most plot which just contains the y-axis label
par(mar=c(0,0,0,0))
plot(1,1,type="l",xlab="",ylab="",las=1,xaxt="n",yaxt="n",bty="n")
text(1,1,"Age (thousands of years before present)",cex=1.5,srt=90)

# Set the time limits of which to plot
mylim <- FossilChron<20 # Only plots the most recent 20 thousand years
# mylim <- FossilChron<130 # Plot the most recent 130 thousand years

# Draw the second plot which just contains the y-axis
par(mar=c(0,1,3,0))
plot(FossilPollen[mylim,1],FossilChron[mylim],type="n",bty="n",ylim=c(max(FossilChron[mylim]),min(FossilChron[mylim])),xlab="",ylab="",las=1,xaxt="n",yaxt="n")
axis(2,labels=TRUE,las=1)

# Now set the margins for the next plots
par(mar=c(0,0,3,1))

# Now loop through each pollen variety creating a plot
for(i in 1:ncol(FossilPollen)) {
  
  plot(FossilPollen[mylim,i],FossilChron[mylim],type="n",bty="n",yaxt="n",xaxt="n",ylim=c(max(FossilChron[mylim]),min(FossilChron[mylim])),xlab="",ylab="",yaxt="n")
  
  # Add a grid
  grid()
  
  # Add a title
  title(polnames[i],line=1,cex.main=1.5)
  
  # add in the pollen counts
  for(j in 1:nrow(FossilPollen[mylim,])) lines(c(0,FossilPollen[j,i]),c(FossilChron[j],FossilChron[j]),col=i,lwd=3)
  
}
