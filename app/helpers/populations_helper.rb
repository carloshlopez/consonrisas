module PopulationsHelper
  def population_name(id)
    if id
      Population.find(id).name
    else
      "undefined"      
    end

  end
end
