# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.new(
  username: 'asdfasdf',
  password: 'asdfasdf'
)
user1.save!

site1 = Site.new(
  url:  URI.parse('http://answerstedhctbek.onion/'),
  user_id: user1.id
)
site2 = Site.new(
  url: URI.parse('http://google.com'),
  user_id: user1.id
)

site1.save!
site2.save!