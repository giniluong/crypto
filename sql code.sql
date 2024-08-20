
-- Crypto vs. Traditional Stocks Analysis

/** Base code to calculate Daily Returns for BTC & ETH.
The first part defines the close price and previous close price. 
The second part of the code calculates the daily returns with the 2 defined variables. 
Base code is iterated for ETH **/

WITH DailyReturns_BTC AS (
    SELECT
        a.date,
        a.adj_close AS ClosePrice_BTC,
        LAG(a.adj_close) OVER (ORDER BY a.date) AS PreviousClosePrice_BTC
    FROM
        btc_usd a  -- Aliasing BTC_USD as "a"
),
ReturnCalculations_BTC AS (
    SELECT
        date,
        (ClosePrice_BTC - PreviousClosePrice_BTC) / PreviousClosePrice_BTC AS DailyReturn_BTC
    FROM
        DailyReturns_BTC
    WHERE
        PreviousClosePrice_BTC IS NOT NULL
),
DailyReturns_ETH AS (
    SELECT
        b.date,
        b.adj_close AS ClosePrice_ETH,
        LAG(b.adj_close) OVER (ORDER BY b.date) AS PreviousClosePrice_ETH
    FROM
        eth_usd b  -- Aliasing ETH_USD as "b"
),
ReturnCalculations_ETH AS (
    SELECT
        date,
        (ClosePrice_ETH - PreviousClosePrice_ETH) / PreviousClosePrice_ETH AS DailyReturn_ETH
    FROM
        DailyReturns_ETH
    WHERE
        PreviousClosePrice_ETH IS NOT NULL
)

-- We run the below code with the base code to get the Average Returns of BTC & ETH.
	
SELECT
	AVG(DailyReturn_BTC) AS AvgReturn_BTC,
	AVG(DailyReturn_ETH) AS AvgReturn_ETH
FROM
	ReturnCalculations_BTC btc
JOIN
	ReturnCalculations_ETH eth
ON
	btc.date = eth.date


-- To compute the Standard Deviation of BTC & ETH.

SELECT
	STDDEV(DailyReturn_BTC) AS Std_BTC,
	STDDEV(DailyReturn_ETH) AS Std_ETH
FROM
	ReturnCalculations_BTC btc
JOIN
	ReturnCalculations_ETH eth
ON
	btc.date = eth.date


-- To compute the Correlation between BTC & ETH

SELECT
    CORR(DailyReturn_BTC, DailyReturn_ETH) AS Correlation_BTC_ETH
FROM
    ReturnCalculations_BTC btc
JOIN
    ReturnCalculations_ETH eth
ON
    btc.date = eth.date
