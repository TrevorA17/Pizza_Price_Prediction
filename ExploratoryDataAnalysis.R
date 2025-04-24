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

# Measures of Frequency for categorical variables (e.g., company, topping, variant)
company_freq <- table(PizzaData$company)
topping_freq <- table(PizzaData$topping)
variant_freq <- table(PizzaData$variant)
size_freq <- table(PizzaData$size)

# Display frequency tables
print(company_freq)
print(topping_freq)
print(variant_freq)
print(size_freq)

# For extra features: Frequency of 'extra_sauce' and 'extra_cheese'
extra_sauce_freq <- table(PizzaData$extra_sauce)
extra_cheese_freq <- table(PizzaData$extra_cheese)

# Display these frequencies
print(extra_sauce_freq)
print(extra_cheese_freq)

# Mean (average) of price_rupiah and diameter
mean_price <- mean(PizzaData$price_rupiah)
mean_diameter <- mean(PizzaData$diameter)

# Median (middle value) of price_rupiah and diameter
median_price <- median(PizzaData$price_rupiah)
median_diameter <- median(PizzaData$diameter)

# Mode (most frequent value) - Custom function for mode
get_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}

# Mode for categorical variables
mode_topping <- get_mode(PizzaData$topping)
mode_variant <- get_mode(PizzaData$variant)
mode_size <- get_mode(PizzaData$size)

# Display results
print(paste("Mean Price:", mean_price))
print(paste("Mean Diameter:", mean_diameter))
print(paste("Median Price:", median_price))
print(paste("Median Diameter:", median_diameter))
print(paste("Mode Topping:", mode_topping))
print(paste("Mode Variant:", mode_variant))
print(paste("Mode Size:", mode_size))

# Variance and Standard Deviation for price_rupiah and diameter
var_price <- var(PizzaData$price_rupiah)
sd_price <- sd(PizzaData$price_rupiah)

var_diameter <- var(PizzaData$diameter)
sd_diameter <- sd(PizzaData$diameter)

# Range (minimum and maximum) for price_rupiah and diameter
range_price <- range(PizzaData$price_rupiah)
range_diameter <- range(PizzaData$diameter)

# Interquartile Range (IQR) for price_rupiah and diameter
iqr_price <- IQR(PizzaData$price_rupiah)
iqr_diameter <- IQR(PizzaData$diameter)

# Display results
print(paste("Variance in Price:", var_price))
print(paste("Standard Deviation in Price:", sd_price))
print(paste("Range of Price:", range_price))
print(paste("IQR of Price:", iqr_price))

print(paste("Variance in Diameter:", var_diameter))
print(paste("Standard Deviation in Diameter:", sd_diameter))
print(paste("Range of Diameter:", range_diameter))
print(paste("IQR of Diameter:", iqr_diameter))

# Correlation between price_rupiah and diameter (only for numerical variables)
cor_price_diameter <- cor(PizzaData$price_rupiah, PizzaData$diameter)

# Cross-tabulation between categorical variables (e.g., company and size)
company_size_crosstab <- table(PizzaData$company, PizzaData$size)

# Display results
print(paste("Correlation between Price and Diameter:", cor_price_diameter))
print("Company and Size Cross-tabulation:")
print(company_size_crosstab)

# Skewness and Kurtosis for price_rupiah
library(e1071)
skew_price <- skewness(PizzaData$price_rupiah)
kurt_price <- kurtosis(PizzaData$price_rupiah)

print(paste("Skewness of Price:", skew_price))
print(paste("Kurtosis of Price:", kurt_price))

# ANOVA for price based on pizza size
anova_size <- aov(price_rupiah ~ size, data = PizzaData)

# Display ANOVA table for size
summary(anova_size)

# Post-hoc test if ANOVA for size is significant
tukey_size <- TukeyHSD(anova_size)

# Display the post-hoc test results
print(tukey_size)

# Check assumptions:
# 1. Residuals vs Fitted plot (for homogeneity of variances)
# 2. Normal Q-Q plot (for normality of residuals)
par(mfrow = c(1, 2))  # Set up two plots side by side
plot(anova_size, 1)   # Residuals vs Fitted plot
plot(anova_size, 2)   # Normal Q-Q plot

# Levene's Test for homogeneity of variances
library(car)
leveneTest(price_rupiah ~ size, data = PizzaData)

# ANOVA for price based on topping type
anova_topping <- aov(price_rupiah ~ topping, data = PizzaData)
summary(anova_topping)

# Post-hoc test if ANOVA for topping is significant
tukey_topping <- TukeyHSD(anova_topping)
print(tukey_topping)

# ANOVA for price based on pizza variant
anova_variant <- aov(price_rupiah ~ variant, data = PizzaData)
summary(anova_variant)

# Post-hoc test if ANOVA for variant is significant
tukey_variant <- TukeyHSD(anova_variant)
print(tukey_variant)

# Load necessary libraries
library(ggplot2)
library(GGally)
library(car)

# Univariate Plots
## 1. Histogram for price_rupiah
ggplot(PizzaData, aes(x = price_rupiah)) +
  geom_histogram(binwidth = 5000, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Pizza Prices", x = "Price (in Rupiah)", y = "Frequency") +
  theme_minimal()

## 2. Boxplot for price_rupiah by pizza size
ggplot(PizzaData, aes(x = size, y = price_rupiah, fill = size)) +
  geom_boxplot() +
  labs(title = "Boxplot of Price by Pizza Size", x = "Size", y = "Price (in Rupiah)") +
  theme_minimal()

## 3. Bar plot for topping frequency
ggplot(PizzaData, aes(x = topping)) +
  geom_bar(fill = "lightgreen", color = "black") +
  labs(title = "Bar Plot of Topping Frequency", x = "Topping", y = "Count") +
  theme_minimal()

# Multivariate Plots


## 2. Boxplot for price_rupiah by topping and size
ggplot(PizzaData, aes(x = topping, y = price_rupiah, fill = size)) +
  geom_boxplot() +
  labs(title = "Boxplot of Price by Topping and Size", x = "Topping", y = "Price (in Rupiah)") +
  theme_minimal()


## 4. Facet grid to compare price_rupiah by size and topping
ggplot(PizzaData, aes(x = topping, y = price_rupiah)) +
  geom_boxplot(aes(color = topping)) +
  facet_grid(~ size) +
  labs(title = "Facet Grid: Price by Topping and Size", x = "Topping", y = "Price (in Rupiah)") +
  theme_minimal()


