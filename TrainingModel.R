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

