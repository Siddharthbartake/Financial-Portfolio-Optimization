head(ccal)
tail(ccal)
nrow(ccal)
head(eod)
tail(eod)
nrow(eod)
head(eod[which(eod$symbol=='SP500TR'),])
eod_row<-data.frame(symbol='SP500TR',date=as.Date('2015-12-31'),adj_close=3821.60) #3821.60
eod<-rbind(eod,eod_row)
tail(eod)
-------------------------------------------------------------------#Use Calendar
  tdays<-ccal[which(ccal$trading==1),,drop=F]
head(tdays)
nrow(tdays)-1 #trading days between 2015 and 2020
-------------------------------------------------------------------
  #Completeness
  #Percentage of completeness
  pct<-table(eod$symbol)/(nrow(tdays)-1)
selected_symbols_daily<-names(pct)[which(pct>=0.99)]
eod_complete<-eod[which(eod$symbol %in% selected_symbols_daily),,drop=F]
#check
head(eod_complete)
tail(eod_complete)
nrow(eod_complete)
-------------------------------------------------------------------
  #Transform (Pivot)
  require(reshape2)
eod_pvt<-dcast(eod_complete, date ~ symbol,value.var='adj_close',fun.aggregate = mean,
               fill=NULL)
#check
eod_pvt[1:15,1:5] #first 15 rows and first 5 columns
ncol(eod_pvt) #column count
nrow(eod_pvt)
-------------------------------------------------------------------
  #Merge with Calendar

eod_pvt_complete<-merge.data.frame(x=tdays[,'date',drop=F],y=eod_pvt,by='date',all.x=T)
#check
eod_pvt_complete[1:15,1:5] #first 15 rows and first 5 columns
ncol(eod_pvt_complete)
nrow(eod_pvt_complete)
#use dates as row names and remove the date column
rownames(eod_pvt_complete)<-eod_pvt_complete$date
eod_pvt_complete$date<-NULL #remove the "date" column
#re-check
eod_pvt_complete[1:15,1:5] #first 15 rows and first 5 columns
ncol(eod_pvt_complete)
nrow(eod_pvt_complete)
--------------------------------------------------------------------
  #Missing Data Imputation
  require(zoo)
eod_pvt_complete<-na.locf(eod_pvt_complete,na.rm=F,fromLast=F,maxgap=3) #last observation carried forward
#re-check
eod_pvt_complete[1:15,1:5] #first 15 rows and first 5 columns
ncol(eod_pvt_complete)
nrow(eod_pvt_complete)
#Calculating Returns
require(PerformanceAnalytics)
eod_ret<-CalculateReturns(eod_pvt_complete)
#check
eod_ret[1:15,1:4] #first 15 rows and first 4 columns
ncol(eod_ret)
nrow(eod_ret)
#remove the first row
eod_ret<-tail(eod_ret,-1) #use tail with a negative value
#check
eod_ret[1:15,1:5] #first 15 rows and first 4 columns
ncol(eod_ret)
nrow(eod_ret)
#Check for extreme returns
colMax <- function(data) sapply(data, max, na.rm = TRUE)

#Apply it
max_daily_ret<-colMax(eod_ret)
max_daily_ret[1:13] #first 10 max returns
#And proceed just like we did with percentage (completeness)
selected_symbols_daily<-names(max_daily_ret)[which(max_daily_ret<=1.00)]
length(selected_symbols_daily)
#subset eod_ret
eod_ret<-eod_ret[,which(colnames(eod_ret) %in% selected_symbols_daily),drop=F]
#check
eod_ret[1:15,1:3] #first 15 rows and first 3 columns
ncol(eod_ret)
nrow(eod_ret)
#Tabular Return Data Analytics
#We need to convert data frames to xts
Ra<-as.xts (eod_ret[,c('NSIT','NTTYY','NBTB','AMS','ARW','ACFN','BSMX','BRX','JJSF','JSCPY','JBSS','BRO'),drop=F])
Rb<-as.xts(eod_ret[,'SP500TR',drop=F])
#check
head(Ra)
head(Rb)
tail(Ra)
tail(Rb)
Ra2016to2020<-Ra[index(Ra)<'2021-01-01']
Rb2016to2020<-Rb[index(Rb)<'2021-01-01']
#check
head(Ra2016to2020)
head(Rb2016to2020)
tail(Ra2016to2020)
tail(Rb2016to2020)
#And now we can use the analytical package
#Stats
table.Stats(Ra2016to2020)
#Distributions
table.Distributions(Ra2016to2020)

#Returns
table.AnnualizedReturns(cbind(Rb,Ra),scale=252) #note for monthly use scale=12
#Accumulate Returns
acc_Ra<-Return.cumulative(Ra2016to2020)
acc_Rb<-Return.cumulative(Rb2016to2020)
#Capital Assets Pricing Model
table.CAPM(Ra2016to2020,Rb2016to2020)
#Graphical Return Data Analytics
#Cumulative returns chart
chart.CumReturns((cbind(Ra2016to2020,Rb2016to2020)),legend.loc = 'topleft')
chart.CumReturns(Ra2016to2020,legend.loc = 'topleft')
--------------------------------------------------------------------------------------------------------------------
  #MV Portfolio Optimization
  #withhold the last 253 trading days (Upto Dec 2020)
  Ra_training<-head(Ra,-58)
Rb_training<-head(Rb,-58)
#use the last 253 trading days for testing (Jan 2021- Mar 2021)
Ra_testing<-tail(Ra,58)
Rb_testing<-tail(Rb,58)
--------------------------------------------------------------------------------------------------------------------
  #test
  nrow(Ra_training)
nrow(Ra_testing)
nrow(Rb_training)
nrow(Rb_testing)
tail(Ra_training)
head(Rb_training)
tail(Rb_training)
head(Ra_testing)
tail(Ra_testing)
head(Rb_testing)
tail(Rb_testing) #last day off
--------------------------------------------------------------------------------------------------------------------
  #optimize the MV (Markowitz 1950s) portfolio weights based on training
  table.AnnualizedReturns(Rb_training)
mar<-mean(Rb_training) #we need daily minimum acceptable return
require(PortfolioAnalytics)

require(ROI)
require(ROI.plugin.quadprog) #make sure to install it
pspec<-portfolio.spec(assets=colnames(Ra_training))
pspec<-add.objective(portfolio=pspec,type="risk",name='StdDev')
pspec<-add.constraint(portfolio=pspec,type="full_investment")
pspec<-add.constraint(portfolio=pspec,type="return",return_target=mar)
--------------------------------------------------------------------
  #optimize portfolio
  opt_p<-optimize.portfolio(R=Ra_training,portfolio=pspec,optimize_method = 'ROI')
#require(Rmpfr)
#extract weights
opt_w<-opt_p$weights
#opt_w <- mpfr(opt_p$weights,4)
sum(opt_w)
-------------------------------------------------------------------
  #apply weights to test returns
  Rp<-Rb_testing #easier to apply the existing structure
#define new column that is the dot product of the two vectors
Rp$ptf<-Ra_testing %*% opt_w
#check
head(Rp)
tail(Rp)
#Compare basic metrics
table.AnnualizedReturns(Rp)
Return.cumulative(Rp)
-------------------------------------------------------------------
  #Chart Hypothetical Portfolio Returns
  chart.CumReturns(Rp,legend.loc = 'bottomright')