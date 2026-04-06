# 🛒 SALES_ANALYSIS (Walmart Dataset)

## 📌 Overview

This project focuses on analyzing Walmart sales data by building a complete data pipeline — from raw CSV data to structured databases and business insights using SQL.

The goal is to clean, transform, and analyze transactional data to uncover patterns in sales, customer behavior, and branch performance.

---

## ⚙️ Tech Stack

* Python (Pandas) → Data cleaning & preprocessing
* SQL (MySQL & PostgreSQL) → Data storage & analysis
* SQLAlchemy → Database connection
* Jupyter Notebook → Development & analysis

---

## 📂 Project Structure

```
SALES_ANALYSIS/
│── Walmart_dataset.csv        # Raw dataset
│── project.ipynb              # Data cleaning & pipeline
│── walmart_queries.sql        # SQL analysis queries
│── README.md                 # Project documentation
```

---

## 🔄 Data Pipeline

```
Raw CSV Data
     ↓
Data Cleaning (Pandas)
     ↓
Feature Engineering
     ↓
Store in MySQL & PostgreSQL
     ↓
SQL Analysis (CTE, Window Functions)
```

---

## 🧹 Data Cleaning (Python)

* Removed duplicate records
* Handled missing values
* Converted currency strings to numeric format
* Standardized column names
* Created new column: total = unit_price × quantity

---

## 🗄️ Database Integration

* Data loaded into MySQL and PostgreSQL
* Used SQLAlchemy for connection
* Created structured table: walmart

---

## 📊 Key SQL Analysis

### ✔ Basic Analysis

* Total number of transactions
* Payment method distribution
* Unique branch count
* Minimum quantity sold

---

### 📈 Business Insights

#### ⭐ Highest Rated Category per Branch

Used RANK() window function

#### 📅 Busiest Day per Branch

Identified peak transaction days

#### 💳 Preferred Payment Method

Used CTE + RANK()

#### 🕒 Sales by Time of Day

Classified into Morning / Afternoon / Evening

#### 💰 Profit Analysis

Calculated total profit using:
unit_price × quantity × profit_margin

#### 📉 Yearly Revenue Trend

Used LAG() to compare year-over-year revenue

---

## 🧠 Key Concepts Used

* Data Cleaning & Preprocessing
* Feature Engineering
* SQL Aggregations
* Window Functions (RANK, LAG)
* Common Table Expressions (CTEs)
* Business Logic Implementation

---

## 🚀 How to Run

1. Clone the repository

2. Install dependencies:
   pip install pandas sqlalchemy pymysql psycopg2

3. Run project.ipynb

4. Execute walmart_queries.sql in your database

---


