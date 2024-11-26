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

# Check for missing values in the entire dataset
missing_values <- sapply(PizzaData, function(x) sum(is.na(x)))

# Display the count of missing values per column
print(missing_values)

# Check if there are any missing values in the entire dataset
if (any(is.na(PizzaData))) {
  cat("There are missing values in the dataset.\n")
} else {
  cat("There are no missing values in the dataset.\n")
}

# Check the total number of missing values in the dataset
total_missing <- sum(is.na(PizzaData))
cat("Total number of missing values in the dataset:", total_missing, "\n")

# Optionally, display rows with missing values (if any)
if (total_missing > 0) {
  print(PizzaData[!complete.cases(PizzaData), ])
}

