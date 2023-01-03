require './lib/museum'
require './lib/exhibit'
require './lib/patron'

RSpec.describe Museum do
	let(:dmns){ Museum.new("Denver Museum of Nature and Science") }
  let(:gems_and_minerals) {Exhibit.new({name: "Gems and Minerals", cost: 0}) }
	let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
	let(:imax) { Exhibit.new({name: "IMAX",cost: 15}) }
	let(:patron_1) { Patron.new("Bob", 20) }
	let(:patron_2) { Patron.new("Sally", 20) }
	let(:patron_3) { Patron.new("Johnny", 5) }
	describe '#initialize' do
		it 'exists' do
			expect(dmns).to be_instance_of(Museum)
		end

		it 'has attributes' do
			expect(dmns.name).to eq("Denver Museum of Nature and Science")
			expect(dmns.exhibits).to eq([])
		end
	end

	describe '#add_exhibit' do
		it 'can add exhibits' do
			dmns.add_exhibit(gems_and_minerals)
			dmns.add_exhibit(dead_sea_scrolls)
			dmns.add_exhibit(imax)
			expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
		end
	end

	describe '#recommend_exhibits' do
		it 'can recommend exhibits' do
			patron_1.add_interest("Dead Sea Scrolls")
			patron_1.add_interest("Gems and Minerals")
			patron_2.add_interest("IMAX")
			expect(dmns.recommend_exhibits(patron_1)).to eq(["Dead Sea Scrolls", "Gems and Minerals"])
			expect(dmns.recommend_exhibits(patron_2)).to eq(["IMAX"])
		end
	end

	describe '#admit(patron)' do
		it 'can determine patrons' do
			expect(dmns.patrons).to eq([])
			dmns.admit(patron_1)
			dmns.admit(patron_2)
			dmns.admit(patron_3)
			expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
		end
	end

	describe '#patrons_by_exhibit_interest' do
		it 'can determine patrons by interest' do
			dmns.add_exhibit(gems_and_minerals)
			dmns.add_exhibit(dead_sea_scrolls)
			dmns.add_exhibit(imax)
			patron_1.add_interest("Gems and Minerals")
			patron_1.add_interest("Dead Sea Scrolls")
			patron_2.add_interest("Dead Sea Scrolls")
			patron_3.add_interest("Dead Sea Scrolls")
			dmns.admit(patron_1)
			dmns.admit(patron_2)
			dmns.admit(patron_3)

			expected_hash = {
				gems_and_minerals => [patron_1], 
				dead_sea_scrolls => [patron_1, patron_2, patron_3], 
				imax => []
			}

			expect(dmns.patrons_by_exhibit_interest).to eq(expected_hash)
		end
	end
end