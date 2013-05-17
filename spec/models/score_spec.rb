require 'spec_helper'

describe Score do

	let(:provider) { FactoryGirl.create(:provider) }
	let(:category) { FactoryGirl.create(:category) }
	let(:score) { provider.scores.build(:category_id => category.id) }

	subject { score }

	it { should respond_to :score }
	it { should be_valid }

end