# install.packages("TraMineR")
options(repr.plot.width=15, repr.plot.height=8)
library("TraMineR")
packageVersion("TraMineR")
library(readr)
library(tidyverse)

data(actcal)
actcal <- data.frame(lapply(actcal, function(x) { gsub("^A\\b", "Read", x)}))
actcal <- data.frame(lapply(actcal, function(x) { gsub("^B\\b", "Watch", x)}))
actcal <- data.frame(lapply(actcal, function(x) { gsub("^C\\b", "Discuss", x)}))
actcal <- data.frame(lapply(actcal, function(x) { gsub("^D\\b", "Practice", x)}))
actcal.seq <- seqdef(actcal, var = 13:24)
# actcal.seq
seqiplot(actcal.seq, main = "Index plot (first 10 sequences)",with.legend = TRUE)

alphabet(actcal.seq)

head(actcal.seq)

# print(head(actcal.seq), format='SPS')
actcal.sps <- seqformat(actcal, 13:24, from = "STS", to = "SPS", compress = TRUE)
head(actcal.sps)

tstate <- seqetm(actcal.seq, method='state')
actcal.tse <- seqformat(actcal, 13:24, from = "STS", to = "TSE", tevent=tstate)
head(actcal.tse)

actcal.spell <- seqformat(actcal, 13:24, from = "STS", to = "SPELL")
head(actcal.seq)
head(actcal.spell)

head(actcal)

actcal.seq <- seqdef(actcal, var = c("jan00", "feb00", "mar00",
         "apr00", "may00", "jun00", "jul00", "aug00", "sep00", "oct00",
         "nov00", "dec00"))


lasi21_logdata <- read_csv("~/Downloads/lasi21_logdata.csv")
head(lasi21_logdata)

# Fixing some typos
lasi21_logdata$site_type <- ifelse(grepl("ssignment", lasi21_logdata$instancename), "assignment",lasi21_logdata$site_type )
lasi21_logdata$site_type <- ifelse(grepl("exam", lasi21_logdata$instancename), "assignment",lasi21_logdata$site_type )

# Convert dataframe to data.table for faster processing
lasi21_logdata <- lasi21_logdata %>% select(id,date_time,spent_time,site_type)

head(lasi21_logdata)

# convert ms to minutes
lasi21_logdata$spent_time_m <- round(lasi21_logdata$spent_time/60000, digits=1)

# create a flag for session break (aka where time spent > 30 minutes)
lasi21_logdata$session_flag <- 0
lasi21_logdata$session_flag <- ifelse(lasi21_logdata$spent_time_m>30, 1, lasi21_logdata$session_flag)

# filter out all spent_time < 90s
lasi21_logdata2 <- lasi21_logdata %>%  filter(spent_time>=90000)


# create session number 
lasi21_logdata2 <- lasi21_logdata2 %>% 
                        arrange(id,date_time,spent_time) %>% 
                        mutate(session_num = cumsum(session_flag))

# remove session break
lasi21_logdata2 <- lasi21_logdata2 %>%  filter(session_flag==0)

# for each learning session, calculate the cummulative time spent
lasi21_logdata2 <- lasi21_logdata2 %>% 
                        arrange(id,date_time,spent_time) %>% 
                        group_by(session_num) %>% 
                        mutate(spent_time_m_cum = cumsum(spent_time_m))

# create time unit as 1 minute (60s)
lasi21_logdata2$time_unit <- round(lasi21_logdata2$spent_time_m_cum,digits=0)
head(lasi21_logdata2,10)

log_spell <- lasi21_logdata2 %>% 
            group_by(session_num) %>% 
            mutate(start = lag(time_unit), start=replace_na(start,1), end=time_unit) %>% 
            select(session_num,start,end,site_type)
log_spell %>% filter(session_num==22)

log_spell <- as.data.frame(log_spell)
log_sts.seq <- seqdef(log_spell, var = c(id="session_num", begin="start", end="end", status="site_type"), 
                   informat = "SPELL",  process = FALSE)

head(log_sts.seq)

print(log_sts.seq[31:41,], format="SPS")

seqiplot(log_sts.seq[31:41,1:100], with.legend = T, main = "Index plot (10 first sequences)")

s1 <- c("a","b","c","d",NA,NA)
s2 <- c(NA,"a","b",NA,"c","d")
s3 <- c(NA,NA, "a","b","c","d")

df <- data.frame(rbind(s1,s2,s3))
colnames(df) <- c(1990:1995)
df

seqdef(df)

seqdef(df,left="DEL")

seqdef(df,left="DEL", gaps="DEL")

# Plot data during the first 100 minutes only

seqiplot(log_sts.seq[,1:100], main = "Index plot (first 20 sequences)", idxs = 1:20)

seqdplot(log_sts.seq[,1:300], main = "State distribution plot")

print(seqstatd(log_sts.seq[,1:5]))

seqfplot(log_sts.seq[,1:100], main = "Sequence frequency plot", pbarw = TRUE, idxs = 1:10)

print(seqtab(log_sts.seq[,1:100]))

# ?seqtrate

seqtrate(log_sts.seq[,1:100])

seqmtplot(log_sts.seq[,1:100], group = NULL, title = "Mean time")

hist(seqlength(log_sts.seq), main = 'Histogram of sequence length', xlab="Sequence length in minutes")

print(seqdss(log_sts.seq[31:41,1:100]))

seqiplot(log_sts.seq[31:41,1:100])
seqient(log_sts.seq[31:41,1:100], norm = TRUE)

hist(seqient(log_sts.seq), main = 'Histogram of sequence entropy', xlab="Normalized Shannon's entropy")

ient.quant <- quantile(seqient(log_sts.seq[,1:100]), c(0, 0.55, 0.9, 1))
ient.quant

ient.group <- cut(seqient(log_sts.seq[,1:100]), ient.quant, labels = c("55th or lower", "55th-90th", "above 90th"), include.lowest = T)
ient.group <- factor(ient.group, levels = c("55th or lower", "55th-90th", "above 90th"))
table(ient.group)

options(repr.plot.width=15, repr.plot.height=8)
seqfplot(log_sts.seq[,1:100], group = ient.group, pbarw = TRUE)

seqiplot(log_sts.seq[31:401,1:100])
cbind(seqST(log_sts.seq[31:41,1:100]),seqient(log_sts.seq[31:41,1:100]))

# ?seqindic

seqindic(log_sts.seq[31:41,1:100], indic=c("lgth","trans","entr","turbn","cplx"))
