# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

["Fundación", "Proveedor", "Facilitador", "Eventos"].each do |r|
    Role.find_or_create_by_name(r)
end

the_admin = Member.find_by_email("carloshlopez@gmail.com")
if the_admin
  the_admin.update_attribute :admin, true
else
  admin = Member.create! do |u|
    u.email = 'carloshlopez@gmail.com'
    u.password = 'usuario123'
    u.password_confirmation = 'usuario123'
    u.admin = true
  end
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

NeedCategory.create(:name_es=>"Alimentación", :name_en=>"Nutrition") unless NeedCategory.find_by_name_en("Nutrition")
NeedCategory.create(:name_es=>"Educación", :name_en=>"Education") unless NeedCategory.find_by_name_en("Education")
NeedCategory.create(:name_es=>"Ropa", :name_en=>"Clothing") unless NeedCategory.find_by_name_en("Clothing")
NeedCategory.create(:name_es=>"Vivienda", :name_en=>"Housing") unless NeedCategory.find_by_name_en("Housing")

puts "-----------"
puts "Added Need Categories"
puts "-----------"

