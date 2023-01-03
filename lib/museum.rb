class Museum
	attr_reader :name,
							:exhibits,
							:patrons,
							:patrons_by_exhibit_interest

	def initialize(name)
		@name = name
		@exhibits = []
		@patrons = []
		@patrons_by_exhibit_interest = {}
	end

	def add_exhibit(exhibit)
		@exhibits << exhibit
	end

	def recommend_exhibits(patron)
		patron.interests
	end

	def admit(patron)
		@patrons << patron
	end

	def patrons_by_exhibit_interest	
		@exhibits.each do |exhibit|
			if @patrons_by_exhibit_interest[exhibit].nil?
				@patrons_by_exhibit_interest[exhibit]= []
			end

			@patrons.each do |patron|			
				if recommend_exhibits(patron).include?(exhibit.name)
					@patrons_by_exhibit_interest[exhibit] << patron 
				end
			end
		end
		@patrons_by_exhibit_interest
	end
end