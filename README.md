# Financial-Portfolio-Optimization
This project optimizes a Mean-Variance portfolio using tickers from 2016 to March 2021. Data is cleaned using RStudio, PostgreSQL, and Excel. A custom calendar identifies trading days and holidays. The portfolio’s performance is compared to the SP500TR benchmark, and time-series analysis predicts future values, assessing trends and fluctuations.

* **Executive Summary**:
This project focuses on optimizing a Mean-Variance (MV) portfolio with twelve unique stock tickers selected by each of the group members using data from 2016 to 2021 (until March 26). The data is collected from sources such as Quandl and Yahoo Finance and is cleaned using ETL processes in RStudio.
The objective of the project is to optimize the portfolio to maximize projected returns while minimizing financial risk. The portfolio is compared to the SP500TR benchmark data to assess its performance.
The project uses technologies and software such as RStudio, R language, PostgreSQL, and Excel. R is a statistical toolkit used to analyze data and produce statistical tools. The stock tickers are selected based on the initials of the group members' last names.
The project uses a custom calendar to extract daily data such as prices and returns from the dataset. The custom calendar is created using Excel to identify trading days and public holidays. The mean-variance portfolio is optimized by grouping the twelve different stock tickers. It uses the mar (minimum acceptable return) to find the optimal solution for the specifications provided in portfolio analytics.
The project concludes by analyzing the portfolio's performance against the benchmark data and predicting future values using time-series analysis. The report provides cumulative and annualized returns for the selected stock tickers, along with general or seasonal trends and any irregular fluctuations.

* **TABLE OF CONTENTS**
1. Introduction 
2. Background 
3. Objective 
4. Technologies and Software 
5. Stock Tickers Selection 
6. Analysis 
7. Conclusion 

* ETL:
ETL (Extract, Transform, and Load), it is a data integration procedure that entails extracting data from numerous sources, transforming the data into an analysis-ready format, and loading the changed data into the desired system. As it enables businesses to collect data from diverse sources, transform it into a dependable format, and store it for analysis and reporting needs, ETL is a critical step in data warehousing and business intelligence.
1. Data Extraction: This is the initial stage of the ETL process. Data is extracted from a variety of sources, including databases, files, and APIs, during this phase. Finding suitable data sources and choosing the data to be retrieved are both steps in the extraction process. The data is kept in a staging area or another temporary storage location after it has been removed.
2. Transformation is the second step. The extracted data is now cleaned, organized, and converted into a format that may be used for analysis. Data cleansing, data aggregation, data enrichment, data mapping, and other processes may all be part of the transformation process. The modified data is kept for future use in a temporary place.
3. Loading is the last stage of the ETL procedure. The modified data is now imported into the destination system, which will act as a data warehouse. Data integrity and consistency are ensured by mapping the converted data to the destination system's data model throughout the loading phase. Data can be examined, reported on, and used for decision-making once it has been fed into the target system.

This project involves data integration that includes the ETL procedure. It lets us collect information from various sources, structure it into a dependable and consistent manner, and load it into a target system for analysis and reporting needs.
The SP500 index and the daily adjusted close price for every company in the portfolio were integrated into R Studio for transformation and analysis. The results were combined using the reshape2 package into data frames with rows for each trading day and columns for each ticker. In order to produce a multi-variate time series where the row names reflected the trade date, the obtained data was then combined with a custom calendar and changed. Each ticker's daily returns were swiftly calculated using the CalculateReturns function. The tabular return data were transformed into extensible time series data (XTS) in the last transformation stage to create returns for the stocks (assets) and returns for the index (benchmark).

* **TECHNOLOGIES AND SOFTWARES:**
In this report, we discuss three powerful tools that were used in this statistical analysis.
1. Rstudio and R Language: We used R language for statistical computation and graphics, and its integrated development environment called RStudio. R offers a vast array of statistical techniques, graphical tools, and import/export options that can be extended using user-created packages. These packages, which are easy to install and use, make R an appealing choice for analysis. Moreover, R's packaging system facilitates data sharing and preservation, making it a valuable tool for research communities.
2. PostgreSQL: A free and open-source relational database management system that focuses on flexibility and SQL compliance. PostgreSQL offers various features such as triggers, foreign keys, stored procedures, and transactions that make it a reliable database system for handling different workloads. With its flexibility and scalability, PostgreSQL can handle anything from small workstations to data warehouses or web applications with many concurrent users.
3. Microsoft Excel: A widely used spreadsheet tool that offers many features such as pivot tables, graphing tools, and VBA programming language. Excel allows analysts to organize large amounts of data into workbooks with one or more worksheets and perform complex calculations and data analysis. In this project, we took data from SP500TR, cleaned it up, and arranged it using Excel.


Additionally, we developed a custom calendar using Excel to make our analysis more robust and accurate.
Overall, these tools offer a broad range of capabilities to help researchers and analysts in various fields to perform data analysis and visualization more efficiently and effectively. By using these tools, users can gain valuable insights into complex data sets and make informed decisions based on their analysis.


* ![image](https://github.com/user-attachments/assets/e7f7de3d-ea6a-4f7c-a86b-cbed01797ac6)



* **ANALYSIS**
Cumulative return chart (2016 - 2020)
The following chart (figure 1) depicts the cumulative returns of the 12 chosen tickers from 2016 to 2020. The horizontal axis indicates the time period, while the vertical axis displays the cumulative returns in percentage. This graphical representation enables us to visualize and analyze the performance of each ticker with ease.
It can be deduced from the chart that despite having one of the highest cumulative returns, the ACFN stock has been characterized by a significant level of volatility. Additionally, the BSMX and BRX have shown to have exceptionally low returns over the given period.

![image](https://github.com/user-attachments/assets/9efd775c-dc73-4ba3-9532-901dfde8b8b9)

Weights of optimized portfolio and the sum of the weights
Weights in a portfolio refers to the percentage of the total portfolio value that is allocated to each individual asset or security within the portfolio. The weights are used to determine the overall performance of the portfolio and reflect the relative importance of each asset in the portfolio. The higher the weight assigned to an asset, the more significant its impact on the overall portfolio performance. In our portfolio, NTTYY (Nippon Telegraph and Telephone Corporation) has the highest weight, while the ARW and BRX have negative weights which can be used for short selling.
![image](https://github.com/user-attachments/assets/a3b05e3b-929f-412e-81ce-0b0d5327dd91)

* Cumulative return chart of your optimized portfolio
The following figure shows the Cumulative return forecast for our portfolio and the SP500TR index for 2021 over the period of 3 months. Looking at the bigger picture, it is clear that although our portfolio performed better than the SP500 stock in terms of cumulative returns, the trendlines of the two are correlated for most part of the forecast. This suggests that our portfolio and SP500 stocks are influenced by similar economic factors and may be part of the same industry or sector.

![image](https://github.com/user-attachments/assets/575cb64e-7e7a-4090-a3a6-b5aa8e5eb524)

* Annualized returns for your portfolio and SP500TR index for 2021
The annualized return for the portfolio is 37.16% as compared to SP500 stock which is 29.87%. There is not much difference in the volatility when compared between our portfolio as well as the SP500TR. Furthermore, the annualized sharp helps investors understand whether the returns they are receiving are commensurate with the amount of risk they are taking on. Our portfolio having a higher value than the SP500 stock indicates that our investors will receive returns equivalent to the risks then endure. Overall, the performance of the portfolio seems encouraging.

![image](https://github.com/user-attachments/assets/34b2e523-f20f-4d14-b0d4-a71ef1a2998d)

* **CONCLUSION**
For this project the Mean-Variance (MV) portfolio was optimized using company tickers based on the initials of the last names of the group members. The data used for this optimization spanned five years, from 2016 to 2020, and was tested over the first three months of 2021. In addition to the portfolio optimization, the cumulative and annualized returns for the selected stock tickers were calculated. This analysis provided valuable insights into the performance of the portfolio and helped us make informed decisions regarding our investment strategy.
The annualized return of our portfolio was higher than that of the SP500 stock, indicating that our investment strategy was successful in generating returns. The volatility between our portfolio and the SP500TR was comparable, meaning that our portfolio did not involve significantly higher risk. Additionally, the higher annualized Sharpe ratio for our portfolio indicates that the returns received were proportionate to the risks taken on by investors. Overall, the performance of the portfolio appears promising, suggesting that our investment strategy was effective in achieving our objectives.
Nevertheless, additional research is imperative to ascertain whether it consistently surpasses the benchmark and whether it constitutes a suitable long-term investment approach.
