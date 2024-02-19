# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  User.create(email: 'jim@jim.com', password: 'password', role: 'admin')
  User.create(email: 'member@member.com', password: 'password', role: 'member')
end

def create_food(name, kcal)
  Food.create(name: name, kcal_per_100g: kcal)
end

# Chick Serrano Sandwich
create_food('Dunklebrot', 250)
create_food('KilKerry Sliced Cheddar', 392)
create_food('Sliced Chicken', 100)
create_food('Serrano Ham', 173)
create_food('Heinz Mayonnaise', 682)

# Chips
create_food('Chipsfrisch Sour Cream', 532)
create_food('Wanted Tortilla Chips', 497)

# Halloumi Salad
create_food('Red Onion', 40)
create_food('Tomato', 19)
create_food('Halloumi', 349)
create_food('Croutons', 455)
create_food('Caesar Dressing', 175)

# Tea 
create_food('Milk', 64)
create_food('Honey', 300)

# Veg
create_food('Sweet Potato', 860)

# World of Pizza 
create_food('Pizza Salami', 227)

# Enchilada Soup 
create_food('Black Beans', 107)
create_food('Sweet Corn', 80)
create_food('Tomaten Passiert', 27)
create_food('Powdered Chicken Stock', 4)
create_food('Tomaten Stuckig', 23)
create_food('Boneless Skinless Chicken Breast', 107)
create_food('Sweet Onion', 132)
create_food('Olive Oil', 888)

# foods = [[beans, 265], [corn, 285], [passiert, 250], [chx_stock, 14], [diced_tom, 400], [chx, 600], [onion, 240], [oil, 14]]


# def total_cal(ingredients, calories = 0, grams = 0)
#   ingredients.each do |pair|
#     calories += pair[0].kcal_per_gram * pair[1]
#     grams += pair[1]
#   end
#   puts "calories: #{calories}"
#   puts "grams: #{grams}"
#   puts "calories per gram: #{calories / grams}"
# end
