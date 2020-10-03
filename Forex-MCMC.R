# Loading the required packages
library(bsts)
library(ggplot2)
library(scales)
library(forecast)

# Setting the working directory and seed
setwd('/home/dorsa/Desktop/projects/ForexMCMC')
set.seed(2020)

# Functions
load_split = function(data_csv, n_skip = 1, train_test_split, print_df = FALSE){
  data = read.csv(data_csv, skip = n_skip, header = FALSE, col.names = c('TimeStamp', 'Rate'))
  df = data.frame(as.Date(data$TimeStamp, format = "%d %b %Y"), as.numeric(data$Rate))
  names(df) = c('TimeStamp', 'Rate')
  n = nrow(df)
  n_train = floor(n * train_test_split) 
  n_test = n - n_train
  df.train = df[1:n_train,]
  df.test = df[-(1:n_train),]
  rownames(df.test) = 1:nrow(df.test)
  l = list(df, df.train, df.test, n_train, n_test)
  if (print_df == TRUE){
    print('train df: ', quote = FALSE)
    print(df.train)
    print('test df: ', quote = FALSE)
    print(df.test)
  }
  return(l)
}

resDF = function(pred, actual){
  res = unlist(c(pred["original.series"], pred["mean"]))
  interval_L = unlist(c(rep(NA, n_train), pred[["interval"]][1,]))
  interval_U = unlist(c(rep(NA, n_train), pred[["interval"]][2,]))
  results = data.frame(actual[[1]], actual[[2]], res, interval_L, interval_U)
  names(results) = c('DateTime', 'Actual', 'Prediction', 'L', 'U')
  return(results)
}

resviz = function(results, title = ''){
  ggplot(results, aes(x = DateTime)) + 
    theme_bw() + theme(legend.title = element_blank(), plot.title = element_text(hjust = 0.5), legend.position = "bottom") + labs(title = title, x = 'Time', y = 'Rate') + 
    geom_line(aes(y = Actual, color = 'Actual')) +
    geom_line(aes(y = Prediction, color = 'Prediction'), linetype = 5) +
    geom_ribbon(aes(ymin = L, ymax = U), fill = 'grey', alpha = 0.3) +
    geom_vline(xintercept = results[n_train, 1], linetype = 4, color = 'blue', alpha = 0.3 )
}

Accuracy = function(test, pred){
  accuracy = 100 - mean(abs(test[['Rate']] - pred[['mean']])/test[['Rate']]) * 100
  return(accuracy)
}

# Preparing the datasets
df_list = load_split('GBPCHF_daily_2016_2020.csv', train_test_split = 0.6, print_df = TRUE)
df = df_list[[1]]
df.train = df_list[[2]]
df.test = df_list[[3]]
n_train = df_list[[4]]
n_test = df_list[[5]]

# Defining the model
ss_4 = AddLocalLinearTrend(list(), df.train[[2]])
ss_4 = AddTrig(ss_4, df.train[[2]], period = 365, frequencies = c(1, 2, 4, 12))
model_4 = bsts(df.train[[2]], state.specification = ss_4, niter = 2000, seed = 2020)

# Prediction and performance
pred_model_4 = predict(model_4, horizon = n_test, burn = SuggestBurn(0.1, model_4))
res_model_4 = resDF(pred_model_5, df)
resviz(res_model_4, title = 'GBPCHF - Model 4')
print(Accuracy(df.test, pred_model_4))

# Visualization
ggplot(df.test, aes(x = TimeStamp)) + theme_bw() + 
  theme(legend.title = element_blank(), plot.title = element_text(hjust = 0.5), legend.position = c(0.25, 0.2), legend.direction = "vertical") + 
  labs(title = 'GBPCHF - Predictions vs Actual', x = 'Time', y = 'Rate') + scale_x_date(date_labels = "%b %y") +
  geom_line(aes(y = Rate, color = 'Actual'), alpha = 0.3) +
  geom_line(aes(y = pred_model_4[['mean']], color = 'Model 4: Local Linear Trend + Trig'))
