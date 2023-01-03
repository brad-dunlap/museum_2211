class Museum
	attr_reader :name,
							:exhibits,
							:patrons

	def initialize(name)
		@name = name
		@exhibits = []
		@patrons = []
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
		
	end
end