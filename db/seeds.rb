# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_teacher = User.new
first_teacher.email = 'admin@admin.com'
first_teacher.password = 'admin1'
first_teacher.password_confirmation = 'admin1'
first_teacher.save!
first_teacher.remove_role :provisional
first_teacher.add_role :teacher
