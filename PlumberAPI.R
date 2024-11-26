# Plumber API
# Load the saved RandomForest model
loaded_rf_model <- readRDS("./models/saved_rf_model.rds")

#* @apiTitle Pizza Price Prediction Model API

#* @apiDescription Predicts pizza price based on features like diameter, topping, size, etc.

#* @param diameter Diameter of the pizza
#* @param topping Topping on the pizza (e.g., "chicken", "pepperoni")
#* @param variant Variant of the pizza (e.g., "double_signature")
#* @param size Size of the pizza (e.g., "jumbo", "regular")
#* @param extra_sauce Whether extra sauce is added (yes/no)
#* @param extra_cheese Whether extra cheese is added (yes/no)

#* @get /predict_price
predict_price <- function(diameter, topping, variant, size, extra_sauce, extra_cheese) {
  
  # Create a data frame using the arguments
  to_be_predicted <- data.frame(
    diameter = as.numeric(diameter),
    topping = as.character(topping),
    variant = as.character(variant),
    size = as.character(size),
    extra_sauce = as.character(extra_sauce),
    extra_cheese = as.character(extra_cheese)
  )
  
  # Use the loaded model to make predictions
  prediction <- predict(loaded_rf_model, newdata = to_be_predicted)
  
  # Return the prediction
  return(list(predicted_price = prediction))
}
