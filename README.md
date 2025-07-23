# Inventory Management Data Warehouse – ABC Consumer Electronics

## 📘 Project Overview

This project presents the design and implementation of a data warehouse solution for ABC Consumer Electronics Ltd, focusing on inventory management. It was developed using Microsoft SQL Server as part of MSc Data Analytics coursework (CS7079) at London Metropolitan University.

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


---

## 📄 Report

📄 [Read the final coursework report](docs/ABC_DataWarehouse_Report.pdf)

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
