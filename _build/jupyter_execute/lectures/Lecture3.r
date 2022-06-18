library(tidyverse)
library(arules)
library(arulesViz)
library(arulesSequences)

df <- data.frame(matrix(ncol = 2, nrow = 1000))
colnames(df) <- c("id","course")

set.seed(123)
df$id <- sample(x=1:250,1000,replace = T)

set.seed(123)
df$course <- sample(x=c("PSY","MATH","STATS","ECON","PHY","ENG","POLS","BIO","CHEM"),1000,replace=T)

df <- df %>% distinct() %>% arrange(id)
head(df)

df <- df %>% group_by(id) %>% 
  summarise(courselist = paste0(course, collapse = ","),count = n())
head(df)

# convert to transaction data object
df$courselist <- as.factor(df$courselist)

# export to csv
write.csv(df$courselist,"course.csv", row.names = FALSE, col.names = FALSE, quote = FALSE)

# read in the csv file
df_obj <- read.transactions('course.csv', format = 'basket', sep=',')
df_obj

itemFrequencyPlot(df_obj,topN=20,type="relative", main="Relative Item Frequency Plot")

association.rules <- apriori(df_obj, parameter = list(supp=0.02, conf=0.6,maxlen=6))


inspect(association.rules[1:10])

# Finding Rules related to given items

# Find what students enrolled before choosing 'ECON'
item.association.rules <- apriori(df_obj, parameter = list(supp=0.02, conf=0.6),
                                  appearance = list(default="lhs",rhs="ECON"))

inspect(head(item.association.rules))

# Find what students enrolled after choosing 'MATH' and 'PHY'
item2.association.rules <- apriori(df_obj, parameter = list(supp=0.02, conf=0.6),
                                   appearance = list(default="rhs",lhs=c("MATH","PHY")))

inspect(head(item2.association.rules))

plot(association.rules)
# plot(association.rules, engine = "plotly")

plot(association.rules,method="two-key plot")

plot(association.rules, method = "graph")
# plot(association.rules, method = "graph",  engine = "htmlwidget")

# Parallel plot
plot(association.rules, method="paracoord")

# Support and confidence values
supportLevels <- c(0.1, 0.05, 0.01, 0.005)
confidenceLevels <- c(0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1)

# Empty integers 
rules_sup10 <- integer(length=9)
rules_sup5 <- integer(length=9)
rules_sup1 <- integer(length=9)
rules_sup0.5 <- integer(length=9)

# Apriori algorithm with a support level of 10%
for (i in 1:length(confidenceLevels)) {
  
  rules_sup10[i] <- length(apriori(df_obj, parameter=list(sup=supportLevels[1], 
                                   conf=confidenceLevels[i], target="rules")))
  
}

# Apriori algorithm with a support level of 5%
for (i in 1:length(confidenceLevels)){
  
  rules_sup5[i] <- length(apriori(df_obj, parameter=list(sup=supportLevels[2], 
                                  conf=confidenceLevels[i], target="rules")))
  
}

# Apriori algorithm with a support level of 1%
for (i in 1:length(confidenceLevels)){
  
  rules_sup1[i] <- length(apriori(df_obj, parameter=list(sup=supportLevels[3], 
                                  conf=confidenceLevels[i], target="rules")))
  
}

# Apriori algorithm with a support level of 0.5%
for (i in 1:length(confidenceLevels)){
  
  rules_sup0.5[i] <- length(apriori(df_obj, parameter=list(sup=supportLevels[4], 
                                    conf=confidenceLevels[i], target="rules")))
  
}

# Number of rules found with a support level of 10%
plot1 <- qplot(confidenceLevels, rules_sup10, geom=c("point", "line"), 
               xlab="Confidence level", ylab="Number of rules found", 
               main="Apriori with a support level of 10%") +
  theme_bw()

# Number of rules found with a support level of 5%
plot2 <- qplot(confidenceLevels, rules_sup5, geom=c("point", "line"), 
               xlab="Confidence level", ylab="Number of rules found", 
               main="Apriori with a support level of 5%") + 
  scale_y_continuous(breaks=seq(0, 10, 2)) +
  theme_bw()

# Number of rules found with a support level of 1%
plot3 <- qplot(confidenceLevels, rules_sup1, geom=c("point", "line"), 
               xlab="Confidence level", ylab="Number of rules found", 
               main="Apriori with a support level of 1%") + 
  scale_y_continuous(breaks=seq(0, 50, 10)) +
  theme_bw()

# Number of rules found with a support level of 0.5%
plot4 <- qplot(confidenceLevels, rules_sup0.5, geom=c("point", "line"), 
               xlab="Confidence level", ylab="Number of rules found", 
               main="Apriori with a support level of 0.5%") + 
  scale_y_continuous(breaks=seq(0, 130, 20)) +
  theme_bw()

# Subplot
library(gridExtra)
library(grid)
grid.arrange(plot1, plot2, plot3, plot4, ncol=2)

# Data frame
num_rules <- data.frame(rules_sup10, rules_sup5, rules_sup1, rules_sup0.5, confidenceLevels)

# Number of rules found with a support level of 10%, 5%, 1% and 0.5%
ggplot(data=num_rules, aes(x=confidenceLevels)) +
  
  # Plot line and points (support level of 10%)
  geom_line(aes(y=rules_sup10, colour="Support level of 10%")) + 
  geom_point(aes(y=rules_sup10, colour="Support level of 10%")) +
  
  # Plot line and points (support level of 5%)
  geom_line(aes(y=rules_sup5, colour="Support level of 5%")) +
  geom_point(aes(y=rules_sup5, colour="Support level of 5%")) +
  
  # Plot line and points (support level of 1%)
  geom_line(aes(y=rules_sup1, colour="Support level of 1%")) + 
  geom_point(aes(y=rules_sup1, colour="Support level of 1%")) +
  
  # Plot line and points (support level of 0.5%)
  geom_line(aes(y=rules_sup0.5, colour="Support level of 0.5%")) +
  geom_point(aes(y=rules_sup0.5, colour="Support level of 0.5%")) +
  
  # Labs and theme
  labs(x="Confidence levels", y="Number of rules found", 
       title="Apriori algorithm with different support levels") +
  theme_bw() +
  theme(legend.title=element_blank())

# create data semester 1
dt1 <- data.frame(matrix(ncol = 2, nrow = 1000))
colnames(dt1) <- c("sequenceID","item")

set.seed(123)
dt1$sequenceID <- sample(x=1:250,1000,replace = T)

set.seed(123)
dt1$item <- sample(x=c("PSY","MATH","STATS","ECON"),1000,replace=T)

dt1$eventID <- 1
dt1 <- unique(dt1)

# create data semester 2
dt2 <- data.frame(matrix(ncol = 2, nrow = 1000))
colnames(dt2) <- c("sequenceID","item")

set.seed(123)
dt2$sequenceID <- sample(x=1:250,1000,replace = T)

set.seed(123)
dt2$item <- sample(x=c("STATS","ECON","PHY","ENG","POLS"),1000,replace=T)

dt2$eventID <- 2
dt2 <- unique(dt2)

# # create data semester 3
dt3 <- data.frame(matrix(ncol = 2, nrow = 1000))
colnames(dt3) <- c("sequenceID","item")

set.seed(123)
dt3$sequenceID <- sample(x=1:250,1000,replace = T)

set.seed(123)
dt3$item <- sample(x=c("PHY","ENG","POLS","BIO","CHEM"),1000,replace=T)

dt3$eventID <- 3
dt3 <- unique(dt3)


dt <- rbind(dt1,dt2,dt3)
dt <- dt %>% arrange(sequenceID, eventID)
head(dt)

dt <- dt %>% group_by(sequenceID, eventID) %>% 
  summarise(item = paste0(item, collapse = ","),size = n())

dt <- dt %>% select(sequenceID,eventID,size,item)
head(dt)

library(arulesSequences)
write.table(dt, "course_term.csv", sep=";", row.names = FALSE, col.names = FALSE, quote = FALSE)
trans_matrix <- read_baskets("course_term.csv", sep = ";", info = c("sequenceID","eventID", "size"))
summary(trans_matrix)

# Get frequent sequences and corresponding support values
s1 <- cspade(trans_matrix, parameter = list(support = 0.02), control = list(verbose = F))
s1.df <- as(s1, "data.frame")
summary(s1)
inspect(head(s1))

#Convert Back to DS
itemsets_df <- as(s1, "data.frame") %>% as_tibble()
library(tidyverse)
#Top 10 Frequent Item Sets
itemsets_df %>%
  slice_max(support, n = 10) %>% 
  ggplot(aes(x = fct_reorder(sequence, support),
                    y = support,
                    fill = sequence)) + 
    geom_col() + 
    geom_label(aes(label = support %>% scales::percent()), hjust = 0.5) + 
    labs(x = "Site", y = "Support", title = "Most Frequently Visited Item Sets",
         caption = "**Support** is the percent of segments the contain the item set") + 
    scale_fill_discrete(guide = F) +
    scale_y_continuous(labels = scales::percent,
                       expand = expansion(mult = c(0, .1))) + 
    coord_flip() + 
    cowplot::theme_cowplot() 

rules <- ruleInduction(s1, 
                       confidence = 0.01, 
                       control = list(verbose = FALSE))

inspect(head(rules, 5))

rules_cleaned <- rules[!is.redundant(rules)]
rules_df <- as(rules_cleaned, "data.frame") %>% 
  as_tibble() %>% 
  separate(col = rule, into = c('lhs', 'rhs'), sep = " => ", remove = F)

rules_df %>% 
  arrange(-confidence) %>% 
  select(lhs, rhs, support, confidence, lift) %>% 
  head() %>% 
  knitr::kable()
