# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Admin.create(email: "leaniman@gmail.com", password: "123456789", password_confirmation: "123456789")

if ArticleCategory.count == 0
  ["incyde", "current", "seminars-conferences", "knowledgebase", "promotions"].each do |category_name|
    ArticleCategory.create(code: category_name)
  end
end

#Sector.create(name: "Artes Gráficas")
#Sector.create(name: "Alimentación y Bebidas")
#Sector.create(name: "Comercio y Servicios")
#Sector.create(name: "Deportes, Ocio, Espectáculos, Eventos")
#Sector.create(name: "Educación")
#Sector.create(name: "Informática")
#Sector.create(name: "Inmobiliarias")
#Sector.create(name: "Medio Ambiente")
#Sector.create(name: "Obras Públicas")
#Sector.create(name: "Seguridad y Mantenimiento")
#Sector.create(name: "Textil y Piel - Calzado")
#Sector.create(name: "Transporte y Logística")

require File.expand_path(File.dirname(__FILE__))+"/load_sectors.rb"

#c1 = Country.create(name: "España")
#
#r1 = c1.regions.create(name: "Comunidad Autónoma de Madrid")
#r2 = c1.regions.create(name: "Cataluña")
#r3 = c1.regions.create(name: "Andalucía")
#
#p1 = r1.provinces.create(name: "Madrid")
#p2 = r1.provinces.create(name: "Barcelona")
#p3 = r1.provinces.create(name: "Málaga")
#
#p1.cities.create(name: "Madrid")
#p1.cities.create(name: "Alcobendas")
#p2.cities.create(name: "Barcelona")
#p3.cities.create(name: "Málaga")



#b1 = BusinessIncubator.first
#b2 = BusinessIncubator.last
#s1 = Sector.first
#co = Country.first
#re = co.regions.first
#pr = re.provinces.first
#ci = pr.cities.first
#b1.companies.create(sector_id: s1.id, email: "c2@leandromartin.es", password: "321321321", name: "Viverista 2", country: co, region:re, province: pr, city: ci)
#b1.companies.create(sector_id: s1.id, email: "c3@leandromartin.es", password: "321321321", name: "Viverista 3", country: co, region:re, province: pr, city: ci)
#b2.companies.create(sector_id: s1.id, email: "c4@leandromartin.es", password: "321321321", name: "Viverista 4", country: co, region:re, province: pr, city: ci)
#b2.companies.create(sector_id: s1.id, email: "c5@leandromartin.es", password: "321321321", name: "Viverista 5", country: co, region:re, province: pr, city: ci)
#b2.companies.create(sector_id: s1.id, email: "c6@leandromartin.es", password: "321321321", name: "Viverista 6", country: co, region:re, province: pr, city: ci)
