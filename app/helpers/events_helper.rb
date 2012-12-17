module EventsHelper

	def has_multiple_profiles(member)
		!member.fundation_admins.empty? or !member.provider_admins.empty?
	end

	def is_attending(member, event)
		is_attending = false;
		is_attending = true unless EventFacilitator.find_by_event_id_and_facilitator_id(event.id, member.facilitator.id).nil?

		unless is_attending
			fundations_ids = member.fundations.map(&:id)
			is_attending = true unless EventFundation.where('event_id = ? and fundation_id IN(?)', event.id, fundations_ids).empty?
		end

		unless is_attending
			providers_ids = member.providers.map(&:id)
			bool = EventProvider.where('event_id = ? and provider_id IN(?)', event.id, providers_ids).empty?
			puts "La respuesta es: " + bool.to_s
			is_attending = true unless bool
		end

		return is_attending
	end

end
