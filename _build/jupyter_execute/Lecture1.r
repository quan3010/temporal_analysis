# install.packages("TraMineR")
library("TraMineR")
packageVersion("TraMineR")
library(readr)
library(tidyverse)

# options(warn=-1)
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
head(actcal.spell)

head(actcal)

actcal.seq <- seqdef(actcal, var = c("jan00", "feb00", "mar00",
         "apr00", "may00", "jun00", "jul00", "aug00", "sep00", "oct00",
         "nov00", "dec00"))


lasi21_logdata <- read_csv("~/Downloads/lasi21_logdata.csv")

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
head(lasi21_logdata2)

log_spell <- lasi21_logdata2 %>% 
            group_by(session_num) %>% 
            mutate(start = lag(time_unit), start=replace_na(start,1), end=time_unit) %>% 
            select(session_num,start,end,site_type)
log_spell %>% filter(session_num==22)

log_spell <- as.data.frame(log_spell)
log_spell.seq <- seqdef(log_spell, var = c(id="session_num", begin="start", end="end", status="site_type"), 
                   informat = "SPELL",  process = FALSE)

head(log_spell.seq)

print(log_spell.seq[31:41,], format="SPS")

seqiplot(log_spell.seq[31:41,1:100], with.legend = T, main = "Index plot (10 first sequences)")

s1 <- c("a","b","c","d",NA,NA)
s2 <- c(NA,"a","b",NA,"c","d")
s3 <- c(NA,NA, "a","b","c","d")

df <- data.frame(rbind(s1,s2,s3))
colnames(df) <- c(1990:1995)
df

seqdef(df)

seqdef(df,left="DEL")

seqdef(df,left="DEL", gaps="DEL")


