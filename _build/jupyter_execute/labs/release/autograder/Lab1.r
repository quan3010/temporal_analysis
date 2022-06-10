library(tidyverse)
library(TraMineR)
data(biofam)
str(biofam)

# state labels
bfstates <- c("Parent", "Left", "Married", "Left+Marr", "Child", "Left+Child", "Left+Marr+Child", "Divorced")

# BEGIN SOLUTION
biofam.seq <- seqdef(biofam, 10:25, states = bfstates, labels = bfstates)
# END SOLUTION

# BEGIN SOLUTION
seqformat(biofam.seq, from ='STS', to='SPS')
# END SOLUTION

# Hint: seqiplot()

# BEGIN SOLUTION
seqiplot(biofam.seq, , idxs = 1:15)
# END SOLUTION

# Hint: seqdplot()

# BEGIN SOLUTION
seqdplot(biofam.seq, main = "State distribution plot")
# END SOLUTION

# Hint: seqfplot()

# BEGIN SOLUTION
seqfplot(biofam.seq, main = "Sequence frequency plot", idxs = 1:10)
# END SOLUTION

# Hint: seqdss()

# BEGIN SOLUTION
print(head(seqdss(biofam.seq)))
# END SOLUTION

seq_num <- nrow(biofam.seq) # SOLUTION

summary(seqlength(biofam.seq)) # SOLUTION

# Hint: seqtrate()

# BEGIN SOLUTION
seqtrate(biofam.seq)
# END SOLUTION

# BEGIN SOLUTION
df <- as.tibble(seqindic(biofam.seq, indic=c("entr","turbn","cplx")))
df$index <- rownames(seqindic(biofam.seq, indic=c("entr","turbn","cplx")))
top10 <- df %>% arrange(desc(Entr)) %>% head(10)
top10

biofam.seq$index <- rownames(biofam.seq)
seqiplot(biofam.seq %>% filter(index %in% top10$index))
# END SOLUTION

# BEGIN SOLUTION
seqmtplot(biofam.seq)
# END SOLUTION
