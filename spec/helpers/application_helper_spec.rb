require 'spec_helper'

describe ApplicationHelper do
	describe "wrap" do

		context "when sentence is bigger than the limit" do
			it "should cut it" do
				expect(wrap("a" * 31)).to match(/a{30}/)
			end	
		end
		
		context "when sentence is smaller than the limit" do
			it "should display normally" do
				expect(wrap("a" * 29)).to match(/a{29}/)
			end
		end
		
	end
end