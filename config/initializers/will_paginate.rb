WillPaginate::ViewHelpers.pagination_options[:previous_label] = "<<"
WillPaginate::ViewHelpers.pagination_options[:next_label] = ">>"

ActiveRecord::Base.instance_eval do
  def per_page; 10; end
end 

