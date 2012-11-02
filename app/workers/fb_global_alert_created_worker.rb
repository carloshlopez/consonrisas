class FbGlobalAlertCreatedWorker < IronWorker::Base

	merge_gem 'fb_graph'

	attr_accessor :link, :message
	def run

		page = FbGraph::Page.new("161001857373976")
		page.feed!(:access_token => "AAACS5JoBfWYBAHA56RhnFVn5iZChyqDoiu9so4yV4s0gs54o2ZBPwlmXxsxYouy4fvXEJgeJO8f1PCdHZAkFSGfZBikSf14XtZA5tnaESqkJZCXmuEedMg", :link => link, :message => message)
		
	end


end