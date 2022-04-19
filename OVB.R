#### Omitted Variables 

source("SLR.R")

b0 <- 5
b1 <- 3
b2 <- 2

b1hat_simulated <- list()
seb1_simulated <- list()
LowerBoundB1_simulated <- list()
UpperBoundB1_simulated <- list()  
CI_simulated <- list()

set.seed(10)
for (i in 1: 1000)
{
  x1 =rnorm(10, mean = 2, sd = 1)
  x2 =rnorm(10, mean = 3, sd = 1.7)
  u = rnorm(10, mean = 0, sd = 1)
  y = b0 + b1*x1 + u +b2*x2
  regress(x1,y)
  b1hat_simulated[length(b1hat_simulated)+1] <- unique(DF$b1hat)
  seb1_simulated[length(seb1_simulated)+1] <- unique(DF$seb1)
  LowerBoundB1_simulated[length(LowerBoundB1_simulated)+1] <- unique(DF$LowerBoundB1)
  UpperBoundB1_simulated[length(UpperBoundB1_simulated)+1] <- unique(DF$UpperBoundB1)
  CI_simulated[length(CI_simulated)+1] <- unique(DF$`Population parameters in 95% CI?`)
}


results <- data.frame(
  b1hat_simulated = unlist(b1hat_simulated),
  seb1_simulated = unlist(seb1_simulated),
  LowerBoundB1_simulated = unlist(LowerBoundB1_simulated),
  UpperBoundB1_simulated = unlist(UpperBoundB1_simulated),
  CI_simulated = unlist(CI_simulated)
)
results

paste(round((sum(results$CI_simulated ==FALSE)/ (sum(results$CI_simulated)+sum(results$CI_simulated ==FALSE)))*100, 3), "% of confidence intervals excluded the slope parameter", sep ="")

mean(unlist(b1hat_simulated))

qplot(seq_along(unlist(b1hat_simulated)), unlist(b1hat_simulated))+
  geom_point(,colour="RED3") +
  labs(title ="Slope Parameter Plots - Omitted Variable",
       caption = "Population parameter: b1=3", 
       x="Estimated parameter",
       y= "Iteration")

#### OVB  ###################################
#############################################
set.seed(10)
for (i in 1: 1000)
{
  x1 =rnorm(10, mean = 2, sd = 1)
  x2 =rnorm(10, mean = 3, sd = 1.7) * 0.3*x1
  u = rnorm(10, mean = 0, sd = 1)
  y = b0 + b1*x1 + u +b2*x2
  regress(x1,y)
  b1hat_simulated[length(b1hat_simulated)+1] <- unique(DF$b1hat)
  seb1_simulated[length(seb1_simulated)+1] <- unique(DF$seb1)
  LowerBoundB1_simulated[length(LowerBoundB1_simulated)+1] <- unique(DF$LowerBoundB1)
  UpperBoundB1_simulated[length(UpperBoundB1_simulated)+1] <- unique(DF$UpperBoundB1)
  CI_simulated[length(CI_simulated)+1] <- unique(DF$`Population parameters in 95% CI?`)
}


results <- data.frame(
  b1hat_simulated = unlist(b1hat_simulated),
  seb1_simulated = unlist(seb1_simulated),
  LowerBoundB1_simulated = unlist(LowerBoundB1_simulated),
  UpperBoundB1_simulated = unlist(UpperBoundB1_simulated),
  CI_simulated = unlist(CI_simulated)
)
results


mean(unlist(b1hat_simulated))

qplot(seq_along(unlist(b1hat_simulated)), unlist(b1hat_simulated))+
  geom_point(,colour="BLUE4") +
  labs(title ="Slope Parameter Plots - Omitted Variable bias",
       caption = "Population parameter: b1=3", 
       x="Estimated parameter",
       y= "Iteration")



paste(round((sum(results$CI_simulated ==FALSE)/ (sum(results$CI_simulated)+sum(results$CI_simulated ==FALSE)))*100, 3), "% of confidence intervals excluded the slope parameter", sep ="")
