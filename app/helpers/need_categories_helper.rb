module NeedCategoriesHelper
  def need_category_name(need)
    name = ""
    name = need.name_es if "#{I18n.locale}" == "es"
    name = need.name_en if "#{I18n.locale}" == "en"
    name
  end
end
