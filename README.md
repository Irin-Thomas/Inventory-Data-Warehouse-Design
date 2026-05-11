# Inventory Management Data Warehouse – ABC Consumer ElectronicsEnterprise Inventory Data Warehouse & Business Intelligence System

# SQL Server | Star Schema Modeling | ETL Pipelines | Inventory Analytics
## 📘 Project Overview

The solution was developed to centralize inventory data, improve stock visibility, and support business reporting across suppliers, products, and retail outlets.

Using dimensional modeling and ETL processes, the warehouse enables:

- Inventory trend analysis
- Supplier performance tracking
- Purchase order monitoring
- Stock movement reporting
- Time-based business analytics

## 📌 Business Problem

ABC Consumer Electronics required a centralized reporting system to analyze inventory operations across multiple outlets.

The operational system lacked:

- Historical inventory tracking
- Consolidated reporting
- Supplier-level inventory visibility
- Weekly and monthly analytics
- Overstock and understock monitoring

To solve this, a dimensional data warehouse was designed using a star schema architecture in SQL Server.

## ⭐ Key Highlights
- Designed a star schema inventory warehouse
- Built SQL-based ETL workflows
- Created fact and dimension tables for analytics
- Developed reporting queries for inventory insights
- Enabled time-series inventory analysis
- Implemented supplier and outlet reporting
---

## 🔧 Tools & Technologies

- Microsoft SQL Server Management Studio (SSMS)
- Star Schema Design
- ETL (SQL-based)
- Dimensional Modeling
- Reporting Queries

---

## 🧱 Schema Overview

The warehouse consists of 3 fact tables:
- `FactSentPurchaseOrders`
- `FactReceivedPurchaseOrders`
- `FactInventory`

And 4 key dimension tables:
- `dime_Product`
- `dime_Supplier`
- `dime_Outlet`
- `dime_Date`

📊 Diagram: See `schema/inventory_star_schema.png`

---

## 🧪 Reporting Features

- Daily stock levels and weekly stock trends
- Over/understock alerts by supplier or category
- Daily and weekly sent/received order summaries
- Monthly received orders by supplier

---

## 📂 Repository Structure

- [Code](https://github.com/Irin-Thomas/Inventory-Data-Warehouse-Design/tree/main/Code)
- [Report](https://github.com/Irin-Thomas/Inventory-Data-Warehouse-Design/blob/main/Report/IRIN_DATAWAREHOUSE%20Report.pdf)
---

## 📄 Report

📄 [Read the final coursework report](https://github.com/Irin-Thomas/Inventory-Data-Warehouse-Design/blob/main/Report/IRIN_DATAWAREHOUSE%20Report.pdf)

---
## Sart Schema 
<img width="750" height="830" alt="image" src="https://github.com/user-attachments/assets/81b332ea-9472-4012-9a40-1ce65a864305" />

---

## 💭 Reflection

Through this project, I learned how to:
- Design a dimensional data model aligned with business needs
- Create and populate a warehouse schema in SQL Server
- Apply constraints and data cleaning in production
- Develop real-time queries for reporting

---

## 📬 Contact

[irinthomas0@gmail.com](mailto:irinthomas0@gmail.com)
