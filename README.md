# Econometrics-Simulation


This repository seeks to simulate some basic econometric theory.

The file "SLR.R" Consists of a basic function to implement a simple linear regression. As a part of this function I can generate model statistics such as the R squared, F statistic for overall significance of the regression, and its related p-value, as well as standard errors for the slope parameter.

The file “Confidence Intervals.R” uses the function built in “SLR.R” to simulate a simple linear regression, as the data is also artificial, the true population parameter is known which will prove useful. By simulating new data and running the regression function, I find that 5.6% of the estimated 95% confidence intervals for the slope parameter exclude the population parameter This relates to the natural interpretation of a confidence interval as, in the long run, an x% confidence interval should contain the true parameter x% of the time. From the slope paramater plot below we can see that OLS has led to an unbiased estimator (as the expectation of the estimated parameter is the population parameter). This is a useful property however it can fail if the assumptions aren't satisfied, as we will see.

![image](https://user-images.githubusercontent.com/95538088/164058462-ece51c34-aaa3-4db1-8efa-40ebabf32976.png)

It is interesting to change the parameters of the code to see how the results change. For instance, changing the number of observations from 1000 to 10, and calculating a biased standard error for the slope by dividing by n rather than n-2 (to account for our degrees of freedom adjustment), the 95% confidence interval excludes the true parameter in 6.8% of the trials. I recommend changing the parameters for yourself to see how the results change. 


The next file, “OVB.R”, uses the same rationale as “Confidence Intervals.R”, however now the dependent variable is constructed to be a function of multiple variables. Thus, when the simple linear regression is computed, there is greater noise. This can be seen in a comparison of the residual plots, as the predicted parameter now has much greater variation, and there are a number of trials where the positive population parameter is estimated as being negative. This should serve as a reminder for careful thought when designing an empirical specification as missing variables can disrupt the analysis. Nevertheless, this greater uncertainty is reflected in the standard errors: the confidence intervals remain such that we still have the true parameter outside of this interval in approximately of trials. Additionally, in this case the omitted variable is independent of the explanatory variable, thus the distribution of the estimated slope parameters is still centered roughly around the population parameter. Running the regression again but making the omitted variable correlated with the explanatory variable, we find that this omission now leads to bias in the estimation of the slope parameter.  The mean of the estimated slope parameter over the trials is now approximately 3.9, whereas previously the mean was approximately 3 (the population parameter).  This has also distorted the confidence interval as what should have been constructed to be a 5% interval now excludes the population parameter in over 30% of trials. This shows a much more dangerous case for OLS, in which care should be taken. 

![image](https://user-images.githubusercontent.com/95538088/164059796-a9fe86b9-c517-4e27-8c7d-d7748159977d.png)
  
