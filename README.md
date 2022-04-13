# Econometrics-Simulation

This repository seeks to simulate some basic econometric theory.

The file "SLR" Consists of a basic function to implement a simple linear regression. As a part of this function I can generate model statistics such as the R squared, F statistic for overall significance of the regression, and its related p-value.

Arguably more interesting is the confidence interval for the slope parameter, which I construct step by step.
By simulating new data and running the regression function, I find that 5.4% of the estimated 95% confidence intervals for the  slope parameter exclude the population parameter (which is known due to the artificial nature of this experiment). This relates to the natural interpretation of a confidence interval as, in the long run, an x% confidence interval should contain the true parameter x% of the time.
It is interesting to change the parameters of the code to see how the results change. For instance, changing the number of observations from 1000 to 10, and calculating a biased standard error for the slope by dividing by n rather than n-2 (to account for our degrees of freedom adjustment), the 95% confidence interval excludes the true parameter in 6.8% of the trials. I recommend changing the parameters for yourself to see how the results change.

My plans for this repository are to develop further simulations to look at omitted variables bias and heteroskedasticity.
