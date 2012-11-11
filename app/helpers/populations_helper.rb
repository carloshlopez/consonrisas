module PopulationsHelper
  def population_name(id)
    name = ""
    p = Population.find(id)
    name = p.name_es if "#{I18n.locale}" == "es"
    name = p.name_en if "#{I18n.locale}" == "en"
    name
  end
  
end
