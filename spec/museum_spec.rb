require './lib/museum'
require './lib/exhibit'
require './lib/patron'

RSpec.describe Museum do
	let(:dmns){ Museum.new("Denver Museum of Nature and Science") }

	describe '#initialize' do
		it 'exists' do
			expect(dmns).to be_instance_of(Museum)
		end

		it 'has attributes' do
			expect(dmns.name).to eq("Denver Museum of Nature and Science")
		end
	end
end