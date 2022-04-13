library(tidyr)

regress <- function(x, y)
{
  n <- length(y[y&x])
  k <- 1 
  DF <<- data.frame(x, y) %>% 
    mutate(
      meany = mean(y), 
      meanx = mean(x), 
      Sxy = (y-meany)*(x-meanx),
      Sxx = (x-meanx)^2,
      b1hat = sum(Sxy)/sum(Sxx)
    ) %>% mutate(
      b0hat = meany - (b1hat*meanx)
    ) %>% mutate(
      fittedy = b0hat + (b1hat * x)
    ) %>% mutate(
      residual = y - fittedy
    ) %>% mutate(
      SSR = sum(residual^2)
    ) %>% mutate(
      Syy = (y - meany)^2
    ) %>% mutate(
      SST = sum(Syy)
    ) %>% mutate(
      R2 = 1-(SSR/SST)
    ) %>% mutate(
      SER = SSR /(n-k -1)
    ) %>% mutate(
      seb1 = (((SSR)/(n-2))^(1/2))/(sum(Sxx))^(1/2)           
    ) %>% mutate(
      seb0 = (((SSR)/(n-2))^(1/2))*((1/n)+((meanx)^(1/2))/sum(Sxx))
    )%>% mutate(
      c = qt(.975, df = n-k-1)
    )%>% mutate(
      LowerBoundB1 =  b1hat- c* seb1
    )%>% mutate(
      UpperBoundB1 = b1hat+ c* seb1
    )%>% mutate(
      `Population parameters in 95% CI?` = (LowerBoundB1< b1)&(UpperBoundB1>b1)
    )
      
  print(tibble(head(DF)))
 
}

b0 <- 5
b1 <- 3

b1hat_simulated <- list()
seb1_simulated <- list()
LowerBoundB1_simulated <- list()
UpperBoundB1_simulated <- list()  
CI_simulated <- list()

set.seed(10)
for (i in 1: 1000)
{
  x =rnorm(1000, mean = 2, sd = 1)
  u = rnorm(1000, mean = 0, sd = 1)
  y = b0 + b1*x + u
  regress(x,y)
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

str(results$CI_simulated)
unique(results$CI_simulated)

paste(round((sum(results$CI_simulated ==FALSE)/ (sum(results$CI_simulated)+sum(results$CI_simulated ==FALSE)))*100, 3), "% of confidence intervals excluded the slope parameter", sep ="")


n <- length(x)
k <- 1  
ModelResults <- tribble(
  ~source, ~SS,  ~df,
  "Explained", (unique(DF$SST)- unique(DF$SSR)), k,
  "Residual:", unique(DF$SSR), n-k-1,
  "Total:", unique(DF$SST), n-1,
)

Modelstats <- tibble(
  "Number of Observations" =  n,
  "R squared" = unique(DF$R2),
  "F Statsistic" = (unique(DF$R2)/(k))/((1- unique(DF$R2))/(n-k)),
  "P >F" = pf((unique(DF$R2)/(k))/((1- unique(DF$R2))/(n-k)), 1, n-k-1, lower.tail = FALSE)
)

ModelResults
Modelstats

