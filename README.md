# Forex-MCMC
*Predicting forex rates with high accuracy using MCMC with Bayesian structural time-series*

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Required Libraries
```{r}
library(bsts)
library(ggplot2)
library(scales)
library(forecast)
```

## Overview

This notebook contains code for log-term prediction of daily forex currency pair rates. However, instructions are included in the notebook for using a dataset with smaller than 24hr candles. 

* You can find the compiled notebook containing all of the results [here](https://github.com/Dorsa-Arezooji/Forex-MCMC/blob/master/Forex-MCMC.nb.html).

## What does it do?

1. The data is loaded, preprocessed, and split into training and testing automatically. 

2. A number of different models are defined (using the `bsts` library) to fit the training data and make predictions:

<img src="images/GBPCHF-Model4.png" width="600">

The performance of different models are plotted and compared with each other regarding their fit (in training):

<img src="images/GBPCHF-fit.png" width="600">

and accuracy (in prediction):

<img src="images/GBPCHF-bsts-models.png" width="600">

  * The optimal model with the highest accuracy is used on another currency pair to examine its performance.

<img src="images/EURGBP-pred-Model4.png" width="600">

3. Finally, the performance of the Bayesian models are compared with that of popular time-series forecasting models such as *ARIMA*.

<img src="images/GBPCHF-all.png" width="600">

 * The Bayesian models outperformed the ARIMA model, yielding a prediction accuracy of `98.3%` as aposed to `75.7%`.
    
## References

[1]  Scott, Steven & Varian, Hal. (2014). Predicting the Present with Bayesian Structural Time Series. Int. J. of Mathematical Modelling and Numerical Optimisation. 5. 4 - 23. 10.1504/IJMMNO.2014.059942. 

[2]  Scott, Steven. (2020). The ["bsts"](https://cran.r-project.org/web/packages/bsts/bsts.pdf) Package Manual,
