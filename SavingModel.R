# Saving the model
saveRDS(rf_model, "./models/saved_rf_model.rds")

# Load the saved model
loaded_rf_model <- readRDS("./models/saved_rf_model.rds")

# Example data to make predictions (adjust according to your dataset's features)
new_data <- data.frame(
  diameter = 18,  # Example value for diameter
  topping = "chicken",  # Example value for topping
  variant = "double_signature",  # Example value for variant
  size = "jumbo",  # Example value for size
  extra_sauce = "yes",  # Example value for extra_sauce
  extra_cheese = "yes"  # Example value for extra_cheese
)

# Use the loaded model to make predictions
predictions_loaded_model <- predict(loaded_rf_model, newdata = new_data)

# Print predictions
print(predictions_loaded_model)
