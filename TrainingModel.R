# Load the dataset
PizzaData <- read.csv("data/pizza_data.csv", colClasses = c(
  company = "factor",
  price_rupiah = "numeric",
  diameter = "numeric",
  topping = "factor",
  variant = "factor",
  size = "factor",
  extra_sauce = "factor",
  extra_cheese = "factor"
))

# Load necessary libraries
library(caret)     # For data splitting and cross-validation
library(boot)      # For bootstrapping
library(ggplot2)   # For visualization (optional)

# Data Splitting
set.seed(123)  # Set seed for reproducibility

# Split the dataset into training (70%) and testing (30%)
trainIndex <- createDataPartition(PizzaData$price_rupiah, p = 0.7, 
                                  list = FALSE, 
                                  times = 1)
trainData <- PizzaData[trainIndex, ]
testData <- PizzaData[-trainIndex, ]

# Print sizes of training and testing datasets
cat("Training Data Size: ", nrow(trainData), "\n")
cat("Testing Data Size: ", nrow(testData), "\n")

# Cross-Validation (Basic)
## 10-fold Cross-validation
set.seed(123)  # Set seed for reproducibility
cv_model <- train(price_rupiah ~ diameter + topping + size + extra_sauce + extra_cheese,
                  data = trainData, 
                  method = "lm", 
                  trControl = trainControl(method = "cv", number = 10))  # 10-fold cross-validation
cat("Basic Cross-validation RMSE: ", cv_model$results$RMSE, "\n")

# Load necessary libraries
library(caret)     # For model training
library(randomForest)  # For Random Forest
library(e1071)      # For Support Vector Machines (SVM)
library(ggplot2)    # For visualization (optional)

# Data Splitting (70% training, 30% testing)
set.seed(123)
trainIndex <- createDataPartition(PizzaData$price_rupiah, p = 0.7, list = FALSE, times = 1)
trainData <- PizzaData[trainIndex, ]
testData <- PizzaData[-trainIndex, ]

# 1. Linear Regression Model
lm_model <- train(price_rupiah ~ diameter + topping + size + extra_sauce + extra_cheese,
                  data = trainData, 
                  method = "lm", 
                  trControl = trainControl(method = "cv", number = 10))  # 10-fold Cross-validation

# Print results for Linear Regression
cat("Linear Regression RMSE: ", lm_model$results$RMSE, "\n")

# 2. Random Forest Model
rf_model <- train(price_rupiah ~ diameter + topping + size + extra_sauce + extra_cheese,
                  data = trainData, 
                  method = "rf", 
                  trControl = trainControl(method = "cv", number = 10),  # 10-fold Cross-validation
                  tuneLength = 5)  # Tune for 5 different values of mtry (number of features for splitting)

# Print results for Random Forest
cat("Random Forest RMSE: ", rf_model$results$RMSE, "\n")

# 3. Support Vector Regression (SVR) Model
svr_model <- train(price_rupiah ~ diameter + topping + size + extra_sauce + extra_cheese,
                   data = trainData, 
                   method = "svmRadial", 
                   trControl = trainControl(method = "cv", number = 10),  # 10-fold Cross-validation
                   tuneLength = 5)  # Tune for 5 different values of sigma (RBF kernel parameter)

# Print results for Support Vector Regression
cat("Support Vector Regression RMSE: ", svr_model$results$RMSE, "\n")

# Evaluate models on test data
# 1. Predict with Linear Regression
lm_predictions <- predict(lm_model, newdata = testData)
lm_rmse <- sqrt(mean((lm_predictions - testData$price_rupiah)^2))
cat("Test RMSE for Linear Regression: ", lm_rmse, "\n")

# 2. Predict with Random Forest
rf_predictions <- predict(rf_model, newdata = testData)
rf_rmse <- sqrt(mean((rf_predictions - testData$price_rupiah)^2))
cat("Test RMSE for Random Forest: ", rf_rmse, "\n")

# 3. Predict with Support Vector Regression
svr_predictions <- predict(svr_model, newdata = testData)
svr_rmse <- sqrt(mean((svr_predictions - testData$price_rupiah)^2))
cat("Test RMSE for Support Vector Regression: ", svr_rmse, "\n")

