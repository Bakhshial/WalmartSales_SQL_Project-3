# Walmart Sales Data Analysis
Project Overview
This project analyzes Walmart sales data to uncover trends, customer behavior, and sales strategies. By exploring various attributes such as product lines, customer types, payment methods, and sales metrics, we aim to provide data-driven insights to enhance sales performance and customer satisfaction.

### Dataset Description
The dataset contains sales data from three Walmart branches (Mandalay, Yangon, and Naypyitaw) with 1000 records and 17 columns:

invoice_id: Unique identifier for each invoice

branch: Branch code (A, B, C)

city: City where the branch is located

customer_type: Type of customer (Member, Normal)

gender: Gender of the customer

product_line: Category of the product purchased

unit_price: Price per unit of the product

quantity: Quantity of the product purchased

VAT: Value Added Tax

total: Total amount paid

date: Date of purchase

time: Time of purchase

payment_method: Payment method used

cogs: Cost of goods sold

gross_margin_pct: Gross margin percentage

gross_income: Gross income from the sale

rating: Customer rating for the purchase

Additional columns created during feature engineering:

time_of_day: Categorized time of day (Morning, Afternoon, Evening)

day_name: Day of the week

month_name: Month of the year

### Feature Engineering
To enhance the analysis, several new features were created:

Time of Day: Categorized the time column into Morning, Afternoon, and Evening.

Day Name: Extracted the name of the day from the date column.

Month Name: Extracted the name of the month from the date column.

### Exploratory Data Analysis (EDA)
The EDA focuses on answering key business questions:

Product Performance: Which product lines are the most popular and profitable?

Sales Trends: What are the monthly, weekly, and daily sales trends?

Customer Behavior: How do different customer types and genders influence sales?

Branch Performance: How do different branches perform in terms of sales and customer ratings?

### Key Findings
Top-Selling Product Line: Electronic accessories are the top-selling and most profitable product line.

Sales Trends: January has the highest total revenue, with Morning sales receiving the highest customer ratings.

Customer Insights: Normal customers contribute more to total sales compared to members, and female customers are more frequent shoppers.

Branch Performance: The Naypyitaw branch (C) has the highest total sales and customer ratings.







Sales Trends: January has the highest total revenue, with Morning sales receiving the highest customer ratings.
Customer Insights: Normal customers contribute more to total sales compared to members, and female customers are more frequent shoppers.
Branch Performance: The Naypyitaw branch (C) has the highest total sales and customer ratings.
