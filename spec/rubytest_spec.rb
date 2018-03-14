require 'rubytest'

describe RubyTest do

let(:jobs) {RubyTest.new}

  describe 'job_order' do

    it 'returns an empty string when passed no jobs' do
      expected = []
      expect(jobs.job_order("")).to eq(expected)
    end

    it 'returns a string when passed a job' do
      expected = ["a"]
      expect(jobs.job_order("a => ")).to eq(expected)
    end

    it 'returns a string when passed multiple jobs' do
      expected = ["a","b","c"]
      expect(jobs.job_order("a => , b => , c => ")).to eq(expected)
    end

    it 'returns an ordered list of jobs with one dependency' do
      expected = ["a","c","b"]
      expect(jobs.job_order("a => , b => c, c => ")).to eq(expected)
    end

    it 'returns an ordered list of jobs with multiple dependencies' do
      expected = ["a", "f", "c", "b", "d", "e"]
      expect(jobs.job_order("a => , b => c, c => f, d => a, e => b, f => ")).to eq(expected)
    end

    #this fails due to poor grouping method.
    it 'returns an ordered list of jobs with multiple dependencies - whole alphabet' do
      expected = ["a", "f", "i", "m", "n", "c", "b", "d", "e", "k", "j", "h", "g", "l"]
      expect(jobs.job_order("a => , b => c, c => f, d => a, e => b, f => , g => h, h => j, i => , j => k, k => m, l => n, m =>, n => ")).to eq(expected)
    end

  end

  describe 'dependency_check' do

    it 'raises an error when a job tries to depend on itself' do
      expect{ jobs.dependency_check("a => , b => , c => c") }.to raise_error(InvalidJobs)
    end

    it 'does not raise an error when a job does not depend on itself' do
      expect{ jobs.dependency_check("a => , b => , c => a") }.not_to raise_error
    end

  end

  describe 'circular_check' do

    it 'returns an array of key/value pairs' do
      expected = ["c", "f", "f", "b", "b", "c"]
      expect(jobs.circular_check("a => , b => c, c => f, d => a, e => , f => b")).to eq(expected)
    end

    it 'returns an nil if there are no dependencies' do
      expected = nil
      expect(jobs.circular_check("a => , b => , c => ")).to eq(expected)
    end

    it 'returns nil if there are dependencies that do not have keys in the job list' do
      expected = nil
      expect(jobs.circular_check("a => g, b => f, c => x")).to eq(expected)
    end

  end

  describe 'error_count' do

    it 'returns an integer when has looping jobs' do
      expected = 3
      expect(jobs.error_count("a => , b => c, c => f, d => a, e => , f => b")).to eq(expected)
    end

    it 'does not return an integer when it doesnt have looping jobs' do
      expected = 0
      expect(jobs.error_count("a => , b => c, c => f, d => a, e => , f => ")).to eq(expected)
    end

  end

  describe 'error_check' do

    it 'raises an error when a job tries to depend on itself' do
      expect{ jobs.error_check("a => , b => c, c => f, d => a, e => , f => b") }.to raise_error(InvalidJobs)
    end

    #risks false positives but I only want to test that this specific error is not raised.
    it 'does not raise an error when a job does not depend on itself' do
      expect{ jobs.error_check("a => , b => , c => a") }.not_to raise_error(InvalidJobs)
    end

  end

  describe 'parse' do

    it 'returns an empty string when passed no jobs' do
      expected = {}
      expect(jobs.parse("")).to eq(expected)
    end

    it 'returns a string when passed a job' do
      expected = {"a" => nil}
      expect(jobs.parse("a => ")).to eq(expected)
    end

    it 'returns a string when passed multiple jobs' do
      expected = {"a"=>nil, "b"=>nil, "c"=>nil}
      expect(jobs.parse("a => , b => , c => ")).to eq(expected)
    end

    it 'returns an ordered list of jobs with multiple dependencies' do
      expected = {"a"=>nil, "b"=>"c", "c"=>"f", "d"=>"a", "e"=>"b", "f"=>nil}
      expect(jobs.parse("a => , b => c, c => f, d => a, e => b, f => ")).to eq(expected)
    end

  end

  describe 'sequence' do

    it 'returns an empty string when passed no jobs' do
      expected = []
      expect(jobs.sequence("")).to eq(expected)
    end

    it 'returns a string when passed a job' do
      expected = ["a"]
      expect(jobs.sequence("a => ")).to eq(expected)
    end

    it 'returns a string when passed multiple jobs' do
      expected = ["a","b","c"]
      expect(jobs.sequence("a => , b => , c => ")).to eq(expected)
    end

    it 'returns an ordered list of jobs with one dependency' do
      expected = ["a","c","b"]
      expect(jobs.sequence("a => , b => c, c => ")).to eq(expected)
    end

    it 'returns an ordered list of jobs with multiple dependencies' do
      expected = ["a", "f", "c", "b", "d", "e"]
      expect(jobs.sequence("a => , b => c, c => f, d => a, e => b, f => ")).to eq(expected)
    end

    it 'raises an error when a job tries to depend on itself' do
      expect{ jobs.sequence("a => , b => , c => c") }.to raise_error(InvalidJobs)
    end

    it 'raises an error when a job tries to depend on itself' do
      expect{ jobs.sequence("a => , b => c, c => f, d => a, e => , f => b") }.to raise_error(InvalidJobs)
    end
  end

end
