class Museum
	attr_reader :name,
							:exhibits,
							:patrons,
							:patrons_by_exhibit_interest,
							:patrons_of_exhibits,
							:revenue

	def initialize(name)
		@name = name
		@exhibits = []
		@patrons = []
		@patrons_by_exhibit_interest = {}
		@patrons_of_exhibits = Hash.new { |h, k| h[k]= []}
		@revenue = 0
	end

	def add_exhibit(exhibit)
		@exhibits << exhibit
	end

	def recommend_exhibits(patron)
		@exhibits.select do |exhibit|
			patron.interests.include?(exhibit.name)
		end
	end

	def admit(patron)
		@patrons << patron

		recommended_exhibits_by_price = recommend_exhibits(patron).sort_by(&:cost).reverse

		recommended_exhibits_by_price.each do |exhibit|

			if patron.spending_money >= exhibit.cost
				@patrons_of_exhibits[exhibits] << patron
				patron.spending_money -= exhibit.cost
				@revenue += exhibit.cost
			end
		end
	end

	def patrons_by_exhibit_interest	
		@exhibits.each do |exhibit|
			if @patrons_by_exhibit_interest[exhibit].nil?
				@patrons_by_exhibit_interest[exhibit]= []
			end

			@patrons.each do |patron|			
				if recommend_exhibits(patron).include?(exhibit)
					@patrons_by_exhibit_interest[exhibit] << patron 
				end
			end
		end
		@patrons_by_exhibit_interest
	end

	def ticket_lottery_contestants(exhibit)
		patrons_by_exhibit_interest[exhibit].find_all { |patron| patron.spending_money < exhibit.cost}
	end

	def draw_lottery_winner(exhibit)		
		array = ticket_lottery_contestants(exhibit)
		return nil if array.empty?
		array.sample.name		
	end

	def announce_lottery_winner(exhibit)
		winner = draw_lottery_winner(exhibit)
		if winner != nil
			"#{winner} has won the #{exhibit.name} exhibit lottery"
		else
			"No winners for this lottery"
		end
	end
end