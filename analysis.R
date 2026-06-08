# ----------------------------------
# Healthcare Analytics Project (R)
# Conjoint + Market Basket + Portfolio
# ----------------------------------

# Libraries
library(dplyr)
library(ggplot2)
library(arules)
library(arulesViz)
library(Rglpk)

# ----------------------------------
# 1. Conjoint Analysis
# ----------------------------------

attributes <- list(
  Location = c("Urban", "Suburban", "Rural"),
  Facilities = c("Basic", "Standard", "Advanced"),
  Specialization = c("General", "Cardiology", "Orthopedic", "Neurology"),
  Appointment_Time = c("Short", "Medium", "Long")
)

concept_cards <- as.data.frame(do.call(expand.grid, attributes))

set.seed(42)
ratings <- matrix(sample(1:10, size = nrow(concept_cards)*100, replace = TRUE), 
                  ncol = nrow(concept_cards))

data <- as.data.frame(ratings)

y <- rowMeans(data)
model <- lm(y ~ ., data = concept_cards)

cat("Part-Worth Utilities:\n")
print(coef(model))

# Plot part-worths
part_worth_data <- data.frame(
  Attribute = names(coef(model))[-1],
  Value = coef(model)[-1]
)

ggplot(part_worth_data, aes(x = Attribute, y = Value, fill = Attribute)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("Part-Worth Utilities")

# ----------------------------------
# 2. Market Basket Analysis
# ----------------------------------

transactions <- list(
  c("X-ray", "Blood Test", "Medicine"),
  c("Blood Test", "ECG", "Medicine", "Appointment"),
  c("X-ray", "Medicine", "Appointment"),
  c("Blood Test", "ECG", "Medicine"),
  c("Medicine", "Appointment")
)

trans <- as(transactions, "transactions")

rules <- apriori(trans, parameter = list(supp = 0.1, conf = 0.8))

inspect(rules)

plot(rules, method = "graph")

# ----------------------------------
# 3. Portfolio Optimization
# ----------------------------------

expected_returns <- c(0.1, 0.15, 0.12, 0.08, 0.11)

cov_matrix <- matrix(c(
  0.04,0.02,0.01,0.02,0.03,
  0.02,0.09,0.03,0.01,0.02,
  0.01,0.03,0.05,0.02,0.01,
  0.02,0.01,0.02,0.06,0.03,
  0.03,0.02,0.01,0.03,0.07
), nrow = 5, byrow = TRUE)

n <- length(expected_returns)

obj <- expected_returns
mat <- rbind(rep(1,n), expected_returns)
dir <- c("==","<=")
rhs <- c(1,0.12)

sol <- Rglpk_solve_LP(obj, mat, dir, rhs)

weights <- sol$solution

cat("Optimal Portfolio Weights:\n")
print(weights)

# Plot portfolio
portfolio_data <- data.frame(
  Asset = paste("Asset", 1:5),
  Weight = weights
)

ggplot(portfolio_data, aes(x = Asset, y = Weight)) +
  geom_bar(stat = "identity", fill = "red") +
  theme_minimal() +
  ggtitle("Optimal Portfolio Weights")
