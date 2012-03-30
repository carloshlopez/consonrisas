module NeedCategoriesHelper
  def need_category_name(id)
    name = ""
    p = NeedCategory.find(id)
    name = p.name_es if "#{I18n.locale}" == "es"
    name = p.name_en if "#{I18n.locale}" == "en"
    name
  end
end
