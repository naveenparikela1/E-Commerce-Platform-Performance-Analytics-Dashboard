# 🛒 Online Shopping Platform Performance Analysis

A complete data analysis project analyzing e-commerce sales performance using SQL, Python, and an interactive dashboard.

## 📌 Project Overview
This project analyzes online shopping platform data to uncover insights about:
- Sales & revenue trends
- Top-performing product categories
- Customer behavior & demographics
- Regional performance
- Monthly growth patterns

## 🗂️ Project Structure
online-shopping-platform-performance/
│
├── README.md
├── requirements.txt
│
├── dashboard/
│   └── ecommerce_dashboard.py
│
├── data/
│   └── ecommerce_data.csv
│
├── python/
│   ├── data_cleaning.py
│   └── data_analysis.py
│
├── sql/
│   ├── schema.sql
│   └── analysis_queries.sql
│
└── screenshots/
    └── dashboard.png

## 🛠️ Tech Stack
- **SQL** – Data storage & querying (MySQL)
- **Python** – Data cleaning & analysis (Pandas, NumPy)
- **Streamlit** – Interactive dashboard
- **Matplotlib / Plotly** – Visualizations

## 🚀 How to Run

### 1. Install dependencies
pip install -r requirements.txt

### 2. Set up database
Run `sql/schema.sql` in MySQL, then load `data/ecommerce_data.csv`.

### 3. Run data pipeline
python python/data_cleaning.py
python python/data_analysis.py

### 4. Launch dashboard
streamlit run dashboard/ecommerce_dashboard.py

## 📊 Key Insights
- Electronics generate the highest revenue share
- Q4 shows peak sales due to holiday season
- Repeat customers contribute ~40% of total revenue

## 👤 Author
Your Name – [GitHub Profile](https://github.com/yourusername)
