
-- Crypto vs. Traditional Stocks Analysis

-- Calculate daily returns for BTC-USD

WITH DailyReturns_BTC AS (
    SELECT
        Date,
        adj_close AS ClosePrice_BTC,
        LAG(adj_close) OVER (ORDER BY Date) AS PreviousClosePrice_BTC
    FROM
        BTCUSDdaily
),
ReturnCalculations_BTC AS (
    SELECT
        Date,
        (ClosePrice_BTC - PreviousClosePrice_BTC) / PreviousClosePrice_BTC AS DailyReturn_BTC
    FROM
        DailyReturns_BTC
    WHERE
        PreviousClosePrice_BTC IS NOT NULL
)

SELECT
	date,
    DailyReturn_BTC
FROM 
	ReturnCalculations_BTC
