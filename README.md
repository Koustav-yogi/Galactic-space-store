🚀 The Galactic Space Store - SQL Project

Project Overview
This project simulates a database for a futuristic space store using PostgreSQL. It handles inventory management, customer tracking, and order processing. The goal was to build a scalable, normalized relational database and perform data analysis using advanced SQL techniques.

🛠️ Tech Stack
Database: PostgreSQL 18
Concepts Applied: Joins (Inner, Left, Right), Subqueries, Window Functions, Views, Normalization (3NF), Indexes.

📂 Key Features
Relational Structure: Designed products, customers, and orders tables with Primary/Foreign keys.
Advanced Analysis: Used RANK() and PARTITION BY to categorize best-selling items.
Optimization: Implemented Indexes for faster search performance on high-volume columns.
Data Cleaning: Automated ID generation using string manipulation (TRIM, UPPER, CONCAT).

🧠 SQL Practice Questions (Interview Prep)
Below are practice questions based on this database schema for revision.

🔹 Module 1: Basics
Find all products that cost between $10 and $100.
Find all customers whose name starts with 'A'.

🔹 Module 2: Aggregates
Calculate the total revenue if every item in stock was sold once.
Find the average price of all "Gadgets".

🔹 Module 3: Joins
List all customers who have never placed an order (Hint: LEFT JOIN and check for NULL).
Show the total amount spent by "Alice".

🔹 Module 4: Advanced

Window Function: Rank the products by price, but reset the ranking for each category.

Subquery: Find products that cost more than the average price of the entire store.

Date Function: Calculate the age of an order in days using AGE().

📝 Usage
You can run the galactic_store.sql file in any PostgreSQL interface (pgAdmin, Postico, or DBeaver) to recreate the entire database and run the analysis queries.
