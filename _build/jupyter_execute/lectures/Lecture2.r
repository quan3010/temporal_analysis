library(tidyverse)
library(TraMineR)
library(cluster)

data(famform)
famform.seq <- seqdef(famform)
print(famform.seq)

seqdist(famform.seq, method='LCP')

print(famform.seq)
seqdist(famform.seq, method='LCP', norm="auto")

print(famform.seq)
seqdist(famform.seq, method='RLCP')

print(famform.seq)
seqdist(famform.seq, method='LCS')

# Normalized version

seqdist(famform.seq, method='LCS', norm = 'auto')

s1 <- c("a","b","c","d",NA,NA)
s2 <- c("a","b",NA,"c","d",NA)
s3 <- c("a","b",NA,"c","d","a")

df <- data.frame(rbind(s1,s2,s3))
colnames(df) <- c(1990:1995)
df.seq <- seqdef(df)
print(df.seq)

seqdist(df.seq, method='LCS', with.miss=TRUE)

print(famform.seq)
sub_cost <- seqcost(famform.seq, method = "CONSTANT", cval = 2)
sub_cost

famform.seq_OM <- seqdist(famform.seq, method = "OM", sm = sub_cost$sm)
famform.seq_OM

famform.seq_OM[1,5]

print(famform.seq)
sub_cost_TRATE <- seqcost(famform.seq, method = "TRATE", cval = 2)
sub_cost_TRATE
seqdist(famform.seq, method = "OM", sm = sub_cost_TRATE$sm)

?seqcost

clusterward <- agnes(famform.seq_OM, diss = TRUE, method = "ward")

plot(clusterward)

plot(clusterward, which.plot=2)

# cut the dendogram tree to generate two clusters
cluster2 <- cutree(clusterward, k = 2)

# create label for clusters
factor(cluster2, labels = c("Type 1", "Type 2"))

# check the number of observations in each cluster
table(cluster2)

# plot sequence frequency by cluster membership
seqfplot(famform.seq, group = cluster2, pbarw = T)

?agnes
