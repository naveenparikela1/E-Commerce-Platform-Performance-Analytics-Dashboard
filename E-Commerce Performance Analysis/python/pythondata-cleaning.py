"""
Data Cleaning Script - E-Commerce Performance Analysis
Cleans raw CSV data and exports a processed version for analysis.
"""

import pandas as pd
import numpy as np

# ---------------- Load Data ----------------
df = pd.read_csv("../data/ecommerce_data.csv")
print("Raw Data Shape:", df.shape)
print("\nMissing Values:\n", df.isnull().sum())

# ---------------- Handle Missing Values ----------------
df["customer_gender"] = df["customer_gender"].fillna("Unknown")
df["region"] = df["region"].fillna("Unknown")

# Drop rows missing critical fields
df = df.dropna(subset=["order_id", "order_date", "unit_price"])

# ---------------- Remove Duplicates ----------------
df = df.drop_duplicates(subset="order_id")

# ---------------- Fix Data Types ----------------
df["order_date"] = pd.to_datetime(df["order_date"], errors="coerce")
df["quantity"] = pd.to_numeric(df["quantity"], errors="coerce").fillna(0).astype(int)
df["unit_price"] = pd.to_numeric(df["unit_price"], errors="coerce")
df["discount"] = pd.to_numeric(df["discount"], errors="coerce").fillna(0)
df["customer_age"] = pd.to_numeric(df["customer_age"], errors="coerce").fillna(0).astype(int)

# ---------------- Standardize Text ----------------
df["product_category"] = df["product_category"].str.strip().str.title()
df["region"] = df["region"].str.strip().str.title()
df["payment_method"] = df["payment_method"].str.strip().str.upper()
df["order_status"] = df["order_status"].str.strip().str.title()

# ---------------- Remove Invalid Rows ----------------
df = df[df["unit_price"] > 0]
df = df[df["quantity"] > 0]
df = df[df["customer_age"].between(0, 100)]

# ---------------- Feature Engineering ----------------
df["total_amount"] = df["quantity"] * df["unit_price"] * (1 - df["discount"])
df["order_month"] = df["order_date"].dt.to_period("M").astype(str)
df["age_group"] = pd.cut(
    df["customer_age"],
    bins=[0, 18, 25, 35, 45, 60, 100],
    labels=["<18", "18-25", "26-35", "36-45", "46-60", "60+"]
)

# ---------------- Save Cleaned Data ----------------
df.to_csv("../data/ecommerce_cleaned.csv", index=False)
print("\n✅ Cleaning complete! Cleaned data saved.")
print("Final Shape:", df.shape)
print("\nSummary:\n", df.describe())
