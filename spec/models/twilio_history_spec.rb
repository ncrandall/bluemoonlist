require 'spec_helper'

describe TwilioHistory do

before { history = TwilioHistory.new }

it { should respond_to :account_sid }
it { should respond_to :to_zip }
it { should respond_to :from_state }
it { should respond_to :called }
it { should respond_to :from_country }
it { should respond_to :caller_country }
it { should respond_to :called_zip }
it { should respond_to :direction }
it { should respond_to :from_city }
it { should respond_to :called_country }
it { should respond_to :duration }
it { should respond_to :caller_state }
it { should respond_to :call_sid }
it { should respond_to :called_state }
it { should respond_to :from }
it { should respond_to :caller_zip }
it { should respond_to :from_zip }
it { should respond_to :call_status }
it { should respond_to :to_city }
it { should respond_to :to_state }
it { should respond_to :to }
it { should respond_to :call_duration }
it { should respond_to :to_country }
it { should respond_to :caller_city }
it { should respond_to :api_version }
it { should respond_to :caller }
it { should respond_to :called_city }
it { should respond_to :digits }
it { should be_valid }

end