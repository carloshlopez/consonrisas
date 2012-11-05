class FbGlobalAlertCreatedWorker < IronWorker::Base

	merge_gem 'fb_graph'

	attr_accessor :link, :message
	def run

		page = FbGraph::Page.new("207633962587548")
		page.feed!(:access_token =>EVN['Fb_CS_TOKEN'], :link => link, :message => message)
		
	end


end
