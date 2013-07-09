require 'spec_helper'

describe Rating do
  let(:provider) { FactoryGirl.create(:provider) }
  let(:rating) { FactoryGirl.create(:rating, provider: provider) }

  subject { rating }

  it { should respond_to :description }
  it { should respond_to :provider }
  it { should respond_to :rating }
  it { should respond_to :request }

end