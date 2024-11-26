# Load the dataset
PizzaData <- read.csv("data/pizza_v1.csv", colClasses = c(
  company = "factor",
  price_rupiah = "numeric",
  diameter = "numeric",
  topping = "factor",
  variant = "factor",
  size = "factor",
  extra_sauce = "factor",
  extra_cheese = "factor"
))

# Display structure to verify data types
str(PizzaData)

# Display the first few rows to ensure data is loaded correctly
head(PizzaData)

# View the dataset in a spreadsheet-like interface (optional)
View(PizzaData)
