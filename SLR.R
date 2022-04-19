library(dplyr)
library(ggplot2)

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
