class FbGlobalAlertCreatedWorker < IronWorker::Base

	merge_gem 'fb_graph'

	attr_accessor :link, :message
	def run

		page = FbGraph::Page.new("207633962587548")
		page.feed!(:access_token =>'AAACTCRhuePUBAGW0okACn6o5nQjueWh3Ibwd3QeglNFM97iMeiQrOC4S7wJ7s7yA8JnwehH3jaBZAI0f08YkngMOjTkGzGrsZC8LZC5fn16niobwMkd', :link => link, :message => message)
		
	end


end
