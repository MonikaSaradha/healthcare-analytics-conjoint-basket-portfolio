# Healthcare Analytics: Conjoint, Market Basket & Portfolio Optimization

Application of advanced analytics techniques to healthcare data to understand patient behavior, service associations, and optimal investment strategies.

---

## Overview

This project applies multiple analytical techniques to a healthcare use case (Apollo Hospitals) to extract insights on patient preferences, service usage patterns, and investment decisions.

The analysis combines statistical modeling and data mining methods to support data-driven decision-making in healthcare.

---

## Techniques Used

### Conjoint Analysis

* Identifies key attributes influencing patient preferences
* Estimates part-worth utilities using regression
* Helps understand which service features matter most

### Market Basket Analysis

* Uses the Apriori algorithm to identify associations between healthcare services
* Detects frequently co-occurring services
* Useful for recommendation systems and service bundling

### Portfolio Optimization

* Determines optimal allocation of assets
* Balances expected return and risk
* Supports investment decision-making

---

## Dataset

* Simulated and structured healthcare data representing:

  * Patient preference ratings
  * Service transaction records
  * Financial asset information

---

## Key Insights

* Location plays a major role in patient preference decisions
* Strong associations exist between diagnostic services and medicine
* Certain service combinations frequently occur together
* Optimal portfolio allocation is concentrated on a high-return asset

---

## Applications

* Healthcare service design and optimization
* Cross-selling and recommendation systems
* Investment planning in healthcare organizations

---

## Tech Stack

* R
* dplyr, ggplot2
* arules, arulesViz
* Rglpk (optimization)

---

## Project Structure

* `analysis.R` – implementation of conjoint analysis, market basket analysis, and portfolio optimization
* `README.md` – project overview
* `project_report.pdf` – detailed analysis and results
