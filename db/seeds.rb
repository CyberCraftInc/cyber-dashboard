# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Project.delete_all
User.delete_all
Project.create!(name: "first project",
                desc: "desc for first project"
)
Project.create!(name: "second project",
                desc: "desc for second project"
)
Project.create!(name: "third project",
                desc: "desc for third project"
)
User.create!(
    first_name: "fir",
    last_name: "st",
    email: "first@example.com",
    phone: "380971111111",
    project_id: 1
)
User.create!(
    first_name: "sec",
    last_name: "ond",
    email: "second@example.com",
    phone: "380971111112",
    project_id: 2
)
User.create!(
    first_name: "thi",
    last_name: "rd",
    email: "third@example.com",
    phone: "380971111113",
    project_id: 3
)
User.create!(
    first_name: "fo",
    last_name: "ur",
    email: "four@example.com",
    phone: "380971111141",
    project_id: 1
)
User.create!(
    first_name: "fiv",
    last_name: "e",
    email: "five@example.com",
    phone: "380971111115",
    project_id: 1
)
