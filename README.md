# Pizza_Sales
This repository contains a detailed analysis of pizza sales data, conducted as part of my internship at Mentorness. The analysis aims to uncover key insights and trends in pizza sales, including sales patterns, pricing strategies, size preferences, menu efficiency, category performance, and product mix.

# Pizza Sales Data Analysis

This repository contains a comprehensive analysis of pizza sales data, performed as part of my internship at Mentorness. The analysis explores various aspects of pizza sales, providing valuable insights and recommendations for optimizing sales and inventory management.

## Project Overview

### Objectives
- Identify sales patterns and peak sales periods.
- Analyze pricing strategies for different pizza categories.
- Determine the most popular pizza sizes.
- Evaluate the efficiency of the current menu.
- Assess the performance of different pizza categories.
- Provide actionable recommendations based on the findings.

### Data Description
The dataset used for this analysis includes the following tables:

#### 1. `order_details`
- `order_details_id`: Unique identifier for the order detail.
- `order_id`: Identifier linking to the orders table.
- `pizza_id`: Identifier linking to the pizza table.
- `quantity`: Number of pizzas ordered.

#### 2. `orders`
- `order_id`: Unique identifier for the order.
- `date`: Date the order was placed.
- `time`: Time the order was placed.

#### 3. `pizza_type`
- `pizza_type_id`: Unique identifier for the pizza type.
- `name`: Name of the pizza.
- `category`: Category of the pizza (e.g., vegetarian, meat, etc.).
- `ingredients`: List of ingredients used in the pizza.

#### 4. `pizza`
- `pizza_id`: Unique identifier for the pizza.
- `pizza_type_id`: Identifier linking to the pizza_type table.
- `size`: Size of the pizza (e.g., small, medium, large).
- `price`: Price of the pizza.

### Key Findings
- **Sales Patterns:** Friday is the busiest day, while Sundays are the slowest. Optimize staffing and inventory for peak Friday sales and consider promotions for slower days.
- **Pricing Strategy:** Classic pizzas have a wide price range; Chicken pizzas have a narrower but higher price range. Consider premium pricing for popular Classic pizzas and maintain premium positioning for Chicken pizzas.
- **Size Preferences:** Large pizzas are the most popular across all categories. Ensure adequate inventory for Large pizzas.
- **Menu Efficiency:** Chicken pizzas generate high revenue per item despite fewer varieties. Explore new Chicken pizza varieties.
- **Category Performance:** Veggie pizzas have the most types but the lowest revenue. Reassess Veggie pizza pricing and promotion strategies.
- **Product Mix:** Classic pizzas lead in orders, but Chicken pizzas generate the highest revenue. Promote high-revenue Chicken pizzas more prominently and evaluate underperforming Classic pizzas.

### Analysis and Queries
The SQL queries used for this analysis are included in the `queries.sql` file.

### Presentation
The insights and recommendations from this analysis are summarized in the `Pizza_Sales_Presentation.pdf` file.
