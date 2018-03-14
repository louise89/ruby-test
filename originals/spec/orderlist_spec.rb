require 'orderlist'
require 'rspec'

describe '.OrderList' do
	describe '#sequence' do

	subject {:orderlist}
	let(:orderlist) {OrderList.new}

	context "when one job is supplied" do
		it {is_expected.to respond_with ["a"]}
	end

	context "when multiple jobs supplied" do
		it {is_expected.to respond_with ["a", "c", "b"]}
	end

	it "should raise an error when a job refers to itself" do
		 expect{sequence([["a", "a"]])}.to respond_with ["Dependent Error in #{jobs}. A job cannot refer to itself!"]
		end
	end

	it "should raise an error when jobs are circular" do
		expect{sequence([["a"], ["b", "c"], ["c", "f"], ["d", "a"], ["e"], ["f", "b"]])}.to respond_with ["Circular Reference error in #{jobs}. Jobs cannot have circular dependencies!"]
	end

end

#I have never written rspec before, and I don't think that this is working, when I tried to follow along with
#a class their examples also would not work, so I think I do not have the rspec gem installed correctly
#(or the above code is incorrect!)
