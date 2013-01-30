module GadgetsHelper

	def view_for_gadget(gadget)
		type = gadget.gadget_type.name.downcase
		case type
		when 'menu' 
			'temp'
		when 'events'
			'temp'
		when 'photos'
			'temp'
		when 'contact'
			'temp'
		when 'homepage'
			'temp'
		when 'music'
			'temp'
		else 
			'temp'
		end
	end

end
