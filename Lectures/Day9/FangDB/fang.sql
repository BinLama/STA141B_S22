CREATE TABLE fang_info (
 ticker TEXT,
 company_name TEXT,
 sic_code INTEGER,
 net_income REAL
);

CREATE TABLE fang_sic (
 SIC INTEGER,
 Description TEXT
);

CREATE TABLE fang_prices (
 ticker TEXT,
 date TEXT,
 high REAL
);

.mode csv
.import fang_info.csv fang_info
.import fang_sic.csv fang_sic
.import fang_prices.csv fang_prices

