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

# test Students

first_student = User.new
first_student.email = 'student1@student.com'
first_student.name = 'bane'
first_student.password = '123456'
first_student.password_confirmation = '123456'
first_student.save!
first_student.remove_role :provisional
first_student.add_role :student

second_student = User.new
second_student.email = 'student2@student.com'
second_student.name = 'batman'
second_student.password = '123456'
second_student.password_confirmation = '123456'
second_student.save!
second_student.remove_role :provisional
second_student.add_role :student
