UPDATE custom_calendar
SET prev_trading_day = PTD.ptd
FROM (SELECT date, (SELECT MAX(CC.date) FROM custom_calendar CC WHERE
CC.trading=1 AND CC.date<custom_calendar.date) ptd FROM custom_calendar) PTD
WHERE custom_calendar.date = PTD.date;
UPDATE custom_calendar SET eom = EOMI.endofm FROM (SELECT CC.date,CASE
WHEN EOM.y IS NULL THEN 0 ELSE 1 END endofm FROM custom_calendar CC LEFT
JOIN (SELECT y,m,MAX(d) lastd FROM custom_calendar WHERE trading=1 GROUP BY
y,m) EOM ON CC.y=EOM.y AND CC.m=EOM.m AND CC.d=EOM.lastd) EOMI
WHERE custom_calendar.date = EOMI.date;

#Section B:
this just removes everything from memory// 
rm(list=ls(all=T))
#did you install this package?
require(RPostgres)
require(DBI)
conn <- dbConnect(RPostgres::Postgres()
,user="stockmarketreader"
,password="read123"
,host="localhost"
,port=5432
,dbname="stockmarket"
)
#custom calendar
qry<-"SELECT * FROM custom_calendar
WHERE date BETWEEN '2015-12-31' AND '2021-03-26' ORDER by date"
ccal<-dbGetQuery(conn,qry)
#eod prices and indices
qry1="SELECT symbol,date,adj_close FROM eod_indices
WHERE date BETWEEN '2015-12-31' AND '2021-03-26'"
qry2="SELECT ticker,date,adj_close FROM eod_quotes
WHERE date BETWEEN '2015-12-31' AND '2021-03-26'"
eod<-dbGetQuery(conn,paste(qry1,'UNION',qry2))
dbDisconnect(conn)
rm(conn)