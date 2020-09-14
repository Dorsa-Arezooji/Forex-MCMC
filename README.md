# Forex-MCMC
*Predicting forex rates using "Bayesian Structural Time-Series" and MCMC*

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Overviw
This notebook contains code for log-term prediction of daily forex currency pair rates. However, instructions are included in the notebook for using a dataset with smaller than 24hr candles.

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

<img src="images/GBPCHF-fit.png" width="600">

 * The Bayesian models outperformed the ARIMA model, yielding a prediction accuracy of `98.3%` as aposed to `75.7%`.
    
