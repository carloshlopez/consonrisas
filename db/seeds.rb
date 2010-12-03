# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


["Fundación", "Proveedor", "Facilitador"].each do |r|
    Role.find_or_create_by_name(r)
end

puts "-----------"
puts "Added Roles"
puts "-----------"
  


Population.create(:name=>"Niños", :description=>"Menores de edad", :age_min=>0, :age_max=>18)
Population.create(:name=>"Adolecentes", :description=>"Niños más grandes", :age_min=>13, :age_max=>18)
Population.create(:name=>"Adultos", :description=>"Todos los mayores de edad", :age_min=>18, :age_max=>60)
Population.create(:name=>"Tercera Edad", :description=>"Los abuelitos", :age_min=>61, :age_max=>100)

puts "-----------"
puts "Added Populations"
puts "-----------"
  

