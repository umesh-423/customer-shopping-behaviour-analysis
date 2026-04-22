# 🛍️ Customer Shopping Behaviour Analysis

An end-to-end data analytics project covering Python-based data cleaning & feature engineering, PostgreSQL for SQL analysis, and Power BI for interactive dashboards — built on a retail customer dataset of 3,900 records.

---

## 📌 Project Overview

This project analyses customer shopping behaviour to surface insights around revenue trends, discount impact, subscription value, and customer segmentation. The workflow spans the full analytics stack: raw data → cleaned DataFrame → PostgreSQL → Power BI dashboard.

---

## 🗂️ Project Structure

```
customer-shopping-behaviour-analysis/
│
├── Customer_Behavior.ipynb       # Data cleaning, feature engineering & DB load
├── customer_trends.sql           # 10 business questions answered in PostgreSQL
├── Customer_Behavior.pbix        # Interactive Power BI dashboard
├── requirements.txt              # Python dependencies
└── README.md
```

---

## 🔧 Tech Stack

| Layer | Tools |
|---|---|
| Data Cleaning & EDA | Python, Pandas, NumPy |
| Database | PostgreSQL (via SQLAlchemy + psycopg2) |
| BI & Visualisation | Power BI (DAX, Power Query) |
| Environment | Jupyter Notebook |

---

## 📊 Dataset

**Source:** Customer Shopping Behaviour Dataset (CSV)  
**Records:** ~3,900 customers  
**Features (18):** Customer ID, Age, Gender, Item Purchased, Category, Purchase Amount (USD), Location, Size, Color, Season, Review Rating, Subscription Status, Shipping Type, Discount Applied, Promo Code Used, Previous Purchases, Payment Method, Frequency of Purchases

---

## 🧹 Data Cleaning & Feature Engineering (Python)

Performed in `Customer_Behavior.ipynb`:

- **Null handling** — 37 missing `Review Rating` values imputed using **median by category** (group-aware imputation)
- **Column standardisation** — renamed to `snake_case` for SQL compatibility
- **Redundancy removal** — discovered `discount_applied` and `promo_code_used` were perfectly correlated (`True` for all rows); dropped `promo_code_used`
- **Feature: `age_group`** — created using `pd.qcut()` into 4 equal-distribution bins: `Young Adult`, `Adult`, `Middle-Aged`, `Senior`
- **Feature: `purchase_frequency_days`** — mapped categorical frequency labels (e.g. `Weekly` → 7, `Fortnightly` → 14, `Annually` → 365) to numeric values
- **ETL to PostgreSQL** — loaded cleaned DataFrame into a `customer` table using SQLAlchemy engine

---

## 🗃️ SQL Analysis (PostgreSQL)

Ten business questions answered in `customer_trends.sql`:

| # | Question |
|---|---|
| Q1 | Total revenue by gender |
| Q2 | Discount users who paid above-average purchase amounts |
| Q3 | Top 5 products by average review rating |
| Q4 | Avg purchase amount: Express vs Standard shipping |
| Q5 | Do subscribers spend more? Revenue & avg spend comparison |
| Q6 | Top 5 products by discount application rate |
| Q7 | Customer segmentation: New / Returning / Loyal (CTE) |
| Q8 | Top 3 products per category (Window Function: `ROW_NUMBER`) |
| Q9 | Repeat buyers (>5 purchases) vs subscription likelihood |
| Q10 | Revenue contribution by age group |

**SQL techniques used:** `GROUP BY`, `HAVING`, subqueries, `CASE WHEN`, CTEs (`WITH`), and window functions (`ROW_NUMBER OVER PARTITION BY`).

---

## 📈 Power BI Dashboard

`Customer_Behavior.pbix` contains an interactive dashboard covering:

- Revenue breakdown by gender, age group, and category
- Subscription vs non-subscription spend comparison
- Top-performing products and shipping type analysis
- Seasonal purchase trends
- Discount impact on purchase behaviour

> **Requirement:** Power BI Desktop (free) to open the `.pbix` file.

---

## 🚀 Getting Started

### Prerequisites

- Python 3.9+
- PostgreSQL (local instance)
- Power BI Desktop

### Installation

```bash
git clone https://github.com/your-username/customer-shopping-behaviour-analysis.git
cd customer-shopping-behaviour-analysis
pip install -r requirements.txt
```

### Running the Pipeline

1. **Create a PostgreSQL database** named `customer_behavior`
2. **Update credentials** in the notebook (`username`, `password`, `host`, `port`)
3. **Run** `Customer_Behavior.ipynb` top-to-bottom — this cleans the data and loads it into PostgreSQL
4. **Open** `customer_trends.sql` in pgAdmin or any PostgreSQL client and run the queries
5. **Open** `Customer_Behavior.pbix` in Power BI Desktop to explore the dashboard

---

## 💡 Key Insights

- **Subscribers generate significantly higher revenue** and have a higher average spend than non-subscribers
- **Loyal customers** (10+ previous purchases) represent a disproportionate share of total revenue
- **Discount usage does not always mean lower spend** — a segment of discount users pays above the average purchase amount
- **Express and Standard shipping customers** show comparable average order values, suggesting shipping preference is driven by urgency rather than budget

---

## 👤 Author

**Umesh Iyer**  
Data Analyst | Python · SQL · Power BI  
📧 umeshiyer2@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/your-profile) · [GitHub](https://github.com/your-username)

---

## 📄 License

This project is for educational and portfolio purposes.
