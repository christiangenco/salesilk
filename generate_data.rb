require 'faker'
require 'json'

def random_sales
  return 0 if rand < 0.2
  100 * rand(1000)
end

data = 100.times.map{
  {
    distributor: Faker::Company.name,
    innovation: random_sales,
    kanata: random_sales,
    perry: random_sales,
    richardson: random_sales,
    tomax: random_sales,
    profile: {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      address: Faker::Address.street_address + ", " + Faker::Address.city + " " + Faker::Address.state,
      id: rand(100_000) + 100_000
    }
  }
}

puts "window.data = " + data.to_json


