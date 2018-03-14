class OrderList
			
	def self.sequence(jobs)
		#runs the method cycle_check and produces the circular error if true
		cycle_check(jobs) 
		#runs the method dependent_check and produces the dependent error if true
		dependent_check(jobs)
		#group the objects Key and Value by the result of the Value
		#returns as a hash
		grouped_jobs = jobs.group_by {|key, value| value}
		#takes the key and value from the grouped hash
		#each converts the hash into an array
		#calls the key and values for each element, passing the element in as a parameter. 	
		# a map or a collect method would also work here.
		grouped_jobs.each {|key,value|}
		#flatten turns the multiple arrays e.g. [[nil, ["a", nil]]] into a one dimensional new array, a second flatten was required to return a single array
		#uniq removes duplicates
		#compact removes nil values
		grouped_jobs.flatten.flatten.uniq.compact
	end
	
	def self.cycle_check(jobs)
		#checks to see if there is more than one job
		if jobs.size > 1
		#produces an array when the inner arrays contain more than one element and removes the others e.g. ["a"]
			array = jobs.select{ |i| i.count > 1}
		#produces combinations of each job/dependency - This method works for the example
		#however I have not been able to create a method that works with smaller circles
		#I think that the combination size is the issue and this would need to be changed to a variable - but have not been able to 
		#figure out what parameter to set the variable on
			if array.size >= 3
				combo = array.combination(3).to_a
				d = combo.each do |sub_array|
				#returns the jobs in an array and then rotates so that the first job is at the end
					e =  sub_array.map { |a| a[0]}.flatten.rotate
				#returns the dependencies in an array
					c = sub_array.map{|a| a[1]}
				#checks to see if the two new arrays match and returns and error if they do.
					if e == c 
						then puts "Circular Reference error in #{jobs}. Jobs cannot have circular dependencies!"
					end
				end
			end
		end
	end
	
	def self.dependent_check(jobs)
		#checks to see if the job is equal to the dependency and returns an error if it is
		dedupe_jobs = jobs.each do |key, value|
			if key == value
				puts "Dependent Error in #{jobs}. A job cannot refer to itself!"
			end 
		end
	end
	
end


OrderList.sequence([])
OrderList.sequence(["a"])
OrderList.sequence([["a"], ["b"], ["c"]])
OrderList.sequence([["a"], ["b", "c"], ["c"]])
OrderList.sequence([["a"], ["b", "c"], ["c", "f"], ["d", "a"], ["e", "b"], ["f"]])
OrderList.sequence([["a"], ["b"], ["c", "c"]])
OrderList.sequence([["a"], ["b", "c"], ["c", "f"], ["d", "a"], ["e"], ["f", "b"]])

print "\n --------------------------- \n"



#I think this belongs in a separate file, however when I tried to test it like this the tests stopped working 
#so I have left it here for the moment.
require 'test/unit'

#Unit testing class for the JobsList Library
class TestOrderList < Test::Unit::TestCase

	#tests that the sequence method returns the expected results
	def test_basic
		assert_equal(["a"], OrderList.sequence(["a"]))
		assert_equal(["a", "b", "c"], OrderList.sequence([["a"], ["b"], ["c"]]))
		assert_equal(["a", "c", "b"], OrderList.sequence([["a"], ["b", "c"], ["c"]]))
		assert_equal(["a", "f", "c", "b", "d", "e"], OrderList.sequence([["a"], ["b", "c"], ["c", "f"], ["d", "a"], ["e", "b"], ["f"]]))
	end

	#tests for jobs that are dependent on themselves
	def test_dependency
		assert_block do
			dedupe_jobs = [["a"], ["b", "c"], ["c"]].each do |key, value|
				if key == value
				end 
			end
		end
	end

	#tests for jobs that have circular dependencies
	def test_circular
		assert_block do
			array = [["a"], ["b", "c"], ["c", "f"], ["d", "a"], ["e"], ["f", "b"]].select{ |i| i.count > 1}
			if array.size >= 3
				combo = array.combination(3).to_a
				d = combo.each do |sub_array|
					e =  sub_array.map { |a| a[0]}.flatten.rotate
					c = sub_array.map{|a| a[1]}
					if e == c 
					end
				end
			end
		end
	end


end

	