# Adri Frick's Inventory Analysis Project
# Question: How long does product stay on shelf until sold out?
# Output: graph of date ranges
library(lubridate)

# Step 1: Get Inventory & Set Headers
inventory.csv <- read.csv("Inventory Info.csv", header=TRUE)
names(inventory.csv) <- c("Name", "Qty" , "Price" , "Sold" , "Purchased")

# Step 2: Ignore observations with >=1 value in Qty column
inventory.sold <- subset (inventory.csv, Qty <= 0)

# Step 3: Format Data
date.sold <- parse_date_time(inventory.sold$Sold, orders = "mdy_HM")
date.purchased <- parse_date_time(inventory.sold$Purchased, orders = "mdy_HM")

# Step 4: Calculate difference between C and D for each item
unsold.weeks <- difftime (date.sold,date.purchased, , units = "weeks")
item.name <- lapply (inventory.sold [1], as.character)

inventory.report <- data.frame(item.name, date.purchased, date.sold, unsold.weeks)

# Step 5: Output
print(inventory.report)

plot(date.sold, type="l")
