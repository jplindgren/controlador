require 'spec_helper'

describe "Tickets pages" do
	subject { page }

	let(:ticket) { FactoryGirl.create(:ticket) }

	before { sign_in user }
	
end
