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
demo_user = User.new(
  username: 'DemoUser',
  password: 'asdfasdf'
)
user1.save!
demo_user.save!

site1 = Site.new(
  url:  URI.parse('http://answerstedhctbek.onion/'),
  user_id: user1.id
)
site2 = Site.new(
  url: URI.parse('http://google.com'),
  user_id: user1.id
)
hidden_nytimes = Site.new(
  url: URI.parse('https://www.nytimes3xbfgragh.onion/'),
  user_id: demo_user.id
)
hidden_facebook = Site.new(
  url: URI.parse('https://facebookcorewwwi.onion/'),
  user_id: demo_user.id
)
hidden_propublica = Site.new(
  url: URI.parse('https://www.propub3r6espa33w.onion/'),
  user_id: demo_user.id
)
hidden_duckduckgo = Site.new(
  url: URI.parse('http://3g2upl4pq6kufc4m.onion/'),
  user_id: demo_user.id
)

site1.save!
site2.save!

hidden_nytimes.save!
hidden_facebook.save!
hidden_propublica.save!
hidden_duckduckgo.save!