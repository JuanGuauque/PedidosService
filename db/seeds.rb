# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#Receta 1
Recetum.create!(nombre: 'Ensalada con pollo',ingredientes: 'Tomato, Onion, Lemon, Lettuce, Chicken', cantidades: '2, 1, 2, 2, 1')

#Receta 2
Recetum.create!(nombre: 'Pollo gratinado',ingredientes: 'Chicken, Cheese, Potato', cantidades: '1, 2, 3')

#Receta 3
Recetum.create!(nombre: 'Carne con papas',ingredientes: 'Meat, Lettuce, Potato', cantidades: '1, 2, 3')

#Receta 4
Recetum.create!(nombre: 'Arroz paisa',ingredientes: 'Rice, Ketchup, Meat, Chicken', cantidades: '3, 2, 1, 1')

#Receta 5
Recetum.create!(nombre: 'Parrillada',ingredientes: 'Meat, Chicken, Potato, Ketchuo, Onion', cantidades: '3, 2, 4, 2, 3')

#Receta 6
Recetum.create!(nombre: 'Corrientazo',ingredientes: 'Chicken, Rice, Potato, Tomato, Lettuce', cantidades: '1, 2, 1, 2, 2')