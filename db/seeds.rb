# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# user = User.create(email: "admin@admin.ru", password: "password", role: "admin", name: 'admin_name', surname: "admin_surname", middle_name: "admin_middle_name", year: 2000)
# user.confirm
User.create(email: "qwerty@mail.ru", password: "password", name: 'name', surname: "surname", middle_name: "middle_name", year: 2000, confirmed_at: '2023-07-21 10:25:15.076243')
User.create(email: "adlksfj@mail.ru", password: "adlkjfshggj", name: 'lkafjds', surname: "lkjafds", middle_name: "adfadf", year: 2000, confirmed_at: '2023-07-21 10:25:15.076243')