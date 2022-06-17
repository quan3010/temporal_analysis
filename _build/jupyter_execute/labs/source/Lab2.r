# ASSIGNMENT CONFIG
requirements: requirements.R
files:
  - data
generate:
    show_stdout: true
    show_hidden: true
environment: environment.yml
export_cell: false
library(tidyverse)
library(TraMineR)
library(cluster)
data(biofam)
str(biofam)

# state labels
bfstates <- c("Parent", "Left", "Married", "Left+Marr", "Child", "Left+Child", "Left+Marr+Child", "Divorced")

# define sequence object
biofam.seq <- seqdef(biofam, 10:25, states = bfstates, labels = bfstates)

# BEGIN QUESTION
name: q1
points: manual# BEGIN SOLUTION
biofam.seq.LCS <- NULL

# BEGIN SOLUTION
biofam.seq.LCS <- seqdist(biofam.seq, method='LCS', norm = 'auto')
biofam.seq.LCS

# END SOLUTION
# END SOLUTION# BEGIN SOLUTION
most_sim <- head(which(biofam.seq.LCS==min(biofam.seq.LCS), arr.ind=T))
most_sim
least_sim <- head(which(biofam.seq.LCS==max(biofam.seq.LCS), arr.ind=T))
least_sim

# BEGIN SOLUTION
seqiplot(biofam.seq[c(1,most_sim[,1]),])
seqiplot(biofam.seq[c(1,least_sim[,1]),])

# END SOLUTION
# END SOLUTION# BEGIN SOLUTION
biofam.seq.subcost <- NULL
biofam.seq.OM <- NULL

# BEGIN SOLUTION
biofam.seq.subcost <- seqcost(biofam.seq, method = "TRATE")
biofam.seq.OM <- seqdist(biofam.seq, method='OM', sm=biofam.seq.subcost$sm)
biofam.seq.OM

# END SOLUTION
# END SOLUTION
?seqdist
# BEGIN SOLUTION
clusterward <- NULL

# BEGIN SOLUTION

clusterward <- agnes(biofam.seq.OM, diss = TRUE, method = "ward")

# Run this to generate the dendogram
plot(clusterward, which.plot=2)

# END SOLUTION
# END SOLUTION# BEGIN SOLUTION
# BEGIN SOLUTION

# cut the dendogram tree to generate two clusters
cluster5 <- cutree(clusterward, k = 5)

# check the number of observations in each cluster
table(cluster5)

# plot sequence frequency by cluster membership
seqfplot(biofam.seq, group = cluster5, pbarw = T)

# plot state distribution by cluster membership
seqdplot(biofam.seq, group = cluster5)

# END SOLUTION


s1 = Read (2) - Write (2)
s2 = Read(5) - Write (5)

?seqcost()
# END SOLUTION# END QUESTION