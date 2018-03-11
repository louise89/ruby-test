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

    # it 'returns an ordered list of jobs with multiple dependencies - whole alphabet' do
    #   expected = ["a", "f", "i", "m", "n", "c", "b", "d", "e", "k", "j", "h", "g", "l"]
    #   expect(jobs.job_order("a => , b => c, c => f, d => a, e => b, f => , g => h, h => j, i => , j => k, k => m, l => n, m =>, n => ")).to eq(expected)
    # end

    it 'raises an error when a job tries to depend on itself' do
      expect{ jobs.dependency_check("a => , b => , c => c") }.to raise_error(InvalidJobs)
    end

    it 'does not raise an error when a job does not depend on itself' do
      expect{ jobs.dependency_check("a => , b => , c => a") }.not_to raise_error
    end

  end
end
