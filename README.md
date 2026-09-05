# Zen EliteStride Maison - SQL Sales Analysis (PostgreSQL / pgAdmin)
---
![Zen EliteStride Maison_SQL](https://github.com/Tusneld/Zen-EliteStride-Maison-Shoe-Sales-Analysis-PostgreSQL/blob/d1c9155f350f73730d53465caf3621b9906e1b37/Zen%20EliteStride%20Maison%20-%20Shoe%20Sales%20Analysis%20(PostgreSQL)/Creating%20KPI%20in%20SQL.PNG)
---

Third stage of a five-part analytics pipeline built on the same shoe sales
dataset: **Excel → Power BI → SQL → Python → Machine Learning**. This stage
recreates the Power BI KPIs and business questions in PostgreSQL, then
extends the analysis with window functions, indexing, a stored procedure,
and role-based access control.

## Overview

Zen EliteStride Maison is a fictional footwear retailer. The dataset covers
500 transactions across 8 products, 4 categories, 6 brands, and 14
countries. This project answers management's core business questions in
SQL and demonstrates production-relevant database practices beyond basic
querying.

## Business questions answered

1. How is the business performing overall?
2. How have revenue and profit changed over time?
3. Which products are driving sales?
4. Which products are driving profitability?
5. Which categories and brands perform best?
6. Which countries contribute the most to the business?
7. What purchasing patterns can we identify from payment method and product preferences?
8. What actions should management take based on the findings?

Plus 5 advanced-SQL questions covering window functions, indexing, a stored
procedure, and privilege management (see `full_analysis.sql`, Section 4).

## Key findings

- **Total revenue: 355,048 | Total profit: 162,335 | Margin: 45.72%**, consistent (42-48%) every month - a stable, healthy margin.
- **Formal category, especially Clarks and Zara**, is the strongest revenue and profit driver.
- **Derby** has the highest profit margin of any product (56.25%) but the lowest volume - a likely visibility/marketing gap rather than weak demand.
- **USA, UK, and Ghana** are the top three markets by revenue; Albania, Canada, and Australia trail furthest behind.

Full reasoning and all supporting numbers are in `full_analysis.sql`
(Business Question 8) and in the query results for Questions 1-7.

## Data cleaning

The raw data has inconsistent casing and stray whitespace in text columns
(e.g. `'monk straps '`, `'MONK STRAPS'`, `'Monk Straps'` all refer to the
same product). Two SQL views - `shoe_sales_clean` and `price_clean` - standardize this with `TRIM()` and `INITCAP()` so the join between sales
and price data matches every row correctly. A data-quality check query
confirms zero unmatched products after cleaning.

## Tech stack

- PostgreSQL 16+
- pgAdmin 4 (Query Tool, Import/Export, role management)

## Files in this repo

| File | Description |
|---|---|
| `full_analysis.sql` | Schema, cleaning views, all 7 business questions, and 5 advanced SQL questions - all fully commented |
| `shoe_sales.csv` | Cleaned transaction data (500 rows) |
| `price.csv` | Product price/cost reference table (8 rows) |

## How to run this

1. Create a database named `zen_elitestride` in pgAdmin.
2. Run the schema section of `full_analysis.sql` (creates `shoe_sales` and `price` tables).
3. Import `shoe_sales.csv` and `price.csv` via pgAdmin's Import/Export tool.
4. Run the rest of `full_analysis.sql` to reproduce every result.

## Advanced SQL demonstrated

- **Window functions** - 3-month rolling average revenue per product, month-over-month change, and top-3-products-per-country ranking.
- **Indexing** - composite index on `(sale_date, product)`, verified with `EXPLAIN ANALYZE`.
- **Stored procedure** - `refresh_monthly_kpis()`, a callable procedure that rebuilds a `monthly_kpi_summary` table on demand.
- **Roles & privileges** - a read-only `sales_analyst` role with `SELECT`-only access via `GRANT`/`REVOKE`.

## Part of a larger pipeline

This is stage 3 of 5. The same dataset and business questions are also
answered in:

- **Excel** - pivot-table dashboard
- **Power BI** - DAX measures and interactive report
- **Python** - pandas cleaning, KPI recomputation, and visualization
- **Machine Learning** - regression and classification models testing whether order size and payment method are predictable from order attributes

## Author

**Tusnelde Endjala**
Portfolio: [tusnelde.vercel.app](https://tusnelde.vercel.app)
GitHub: [@Tusneld](https://github.com/Tusneld)
