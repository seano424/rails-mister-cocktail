# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb
# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")
require 'faker'
require 'open-uri'
require 'json'
puts 'Destroying all ingredients from DB...'
Ingredient.destroy_all
puts 'Creating all ingredients...'
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
response = open(url).read
ingredients = JSON.parse(response)
ingredients["drinks"].each do |ingredient|
  Ingredient.create!(
    name: ingredient['strIngredient1']
  )
end
puts 'Finished'

puts 'Destroying all drinks from DB...'
Cocktail.destroy_all
puts 'Creating all cocktails...'
10.times do
  url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
  response = open(url).read
  cocktails = JSON.parse(response)
  cocktails["drinks"].each do |drink|
    Cocktail.create!(
      name: drink['strDrink'],
      image: drink['strDrinkThumb']
    )
  end
end
puts 'finished'
