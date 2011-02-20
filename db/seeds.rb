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
  


Population.create(:name_es=>"Niños", :description_es=>"Menores de edad", :name_en=>"Kids", :description_en=>"Minors", :age_min=>0, :age_max=>18) unless Population.find_by_name_en("Kids")
Population.create(:name_es=>"Adolescentes", :description_es=>"Niños más grandes", :name_en=>"Teenagers", :description_en=>"Older Kids", :age_min=>13, :age_max=>18) unless Population.find_by_name_en("Teenagers")
Population.create(:name_es=>"Adultos", :description_es=>"Todos los mayores de edad", :name_en=>"Adults", :description_en=>"Adults", :age_min=>18, :age_max=>60) unless Population.find_by_name_en("Adults")
Population.create(:name_es=>"Tercera Edad", :description_es=>"Los abuelitos", :name_en=>"Grandpas", :description_en=>"Old adults", :age_min=>61, :age_max=>100) unless Population.find_by_name_en("Grandpas")

puts "-----------"
puts "Added Populations"
puts "-----------"
  

