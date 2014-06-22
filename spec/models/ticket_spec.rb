require 'spec_helper'

describe Ticket do
  let(:ticket) { FactoryGirl.create(:ticket) }

  subject { ticket }

  it { should respond_to(:friendly_id) }
  it { should respond_to(:description) }
  it { should respond_to(:project) }

  it { should be_valid }

  describe "when friendly_id is not presented" do
  	before { ticket.friendly_id = nil }
  	it { should_not be_valid }
  end

  describe "when description is not presented" do
  	before { ticket.description = nil }
  	it { should_not be_valid }
  end

  describe "when a project is not presented" do
  	before { ticket.project = nil }
  	it { should_not be_valid }
  end

  describe "when description exceeds the maximum limit" do
  	before do
  		ticket.description = "a" * 256
  	end 
  	it { should_not be_valid }
  end
end
