# Superstore Business Performance Analysis

End-to-end business analysis of 9,994 retail orders using SQL, Python, and Power BI to identify profit drivers, underperforming segments, and operational inefficiencies.

**Analyst:** Amit Govind | **Tools:** SQLite · Python · Power BI | **Dataset:** Sample Superstore (2014–2017)

---

## Key Findings

- **Central region** generates $501K in sales but only 7.92% profit margin — a structural margin problem, not a volume problem
- **Tables sub-category** posts -$17.7K profit despite $206K in sales — driven by high shipping and handling costs, not discounting alone
- **Furniture category** averages 17.39% discount yet delivers only 2.49% margin, while Technology maintains 17.4% margin at lower discounts
- **Texas, Ohio, and Illinois** are losing money at scale — high order volume states with negative margins requiring product mix investigation
- **Profit grew from $49.5K (2014) to $93.4K (2017)** but margin peaked in 2016, signalling a sustainability question heading into 2018

---

## Dashboard Preview

![Executive Summary](dashboard/page1_dashboard.png)

![Deep Dive Analysis](dashboard/page2_dashboard.png)

---

## Project Structure

| Folder | Contents |
|--------|----------|
| `sql/` | SQL queries (SQLite) |
| `python/` | Jupyter notebook with EDA + Claude API integration |
| `outputs/` | Charts, AI-generated executive summaries |
| `dashboard/` | Power BI file + dashboard screenshots |
| `presentation/` | Full SQL analysis documentation |

---

## Tools & Skills Demonstrated

- **SQL** — aggregations, GROUP BY, HAVING, SUBSTR for date parsing, margin calculations
- **Python** — pandas EDA, matplotlib/seaborn visualisation, feature engineering (Days to Ship), Claude API integration for automated executive summaries
- **Power BI** — interactive dashboard, DAX measures, slicers, map visualisation

- ---

## Business Recommendations

Based on the analysis, here are the prioritized actions with the highest expected impact:

1. **Discontinue or restructure the Tables sub-category** — With -$17.7K profit on $206K in sales, Tables is the single highest-priority fix. Options include renegotiating supplier/shipping contracts, introducing a minimum order value, or phasing out the product line entirely. Estimated impact: $15-20K annual profit recovery.

2. **Implement discount caps on Furniture** — Furniture averages 17.39% discount yet delivers only 2.49% margin. Capping discounts at 10% on Furniture would meaningfully improve margins without significantly impacting volume based on the discount-profit correlation observed.

3. **Investigate Central region logistics** — Central posts 7.92% margin vs 14.94% in the West on similar sales volume. The gap is too large to be explained by product mix alone. A logistics cost and discount pattern audit in Central is the recommended next step.

> **Note:** These recommendations are based on transaction-level data only. A full cost accounting analysis including logistics, returns, and overheads would be required before implementing any structural changes.
