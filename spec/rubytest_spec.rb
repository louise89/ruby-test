require 'rubytest'

describe RubyTest do

let(:jobs) {RubyTest.new}

  describe 'job_order' do

    it 'returns an empty string when passed no jobs' do
      expected = [""]
      expect(jobs.job_order([""])).to eq(expected)
    end

    it 'returns a string when passed a job' do
      expected = ["a"]
      expect(jobs.job_order(["a"])).to eq(expected)
    end

    it 'returns a string when passed multiple jobs' do
      expected = ["a","b","c"]
      expect(jobs.job_order([["a"], ["b"], ["c"]])).to eq(expected)
    end

    it 'returns an ordered list of jobs with one dependency' do
      expected = ["a","c","b"]
      expect(jobs.job_order([["a"], ["b", "c"], ["c"]])).to eq(expected)
    end

    it 'returns an ordered list of jobs with multiple dependencies' do
      expected = ["a", "f", "c", "b", "d", "e"]
      expect(jobs.job_order([["a"], ["b", "c"], ["c", "f"], ["d", "a"], ["e", "b"], ["f"]])).to eq(expected)
    end

    it 'returns an ordered list of jobs with multiple dependencies - whole alphabet' do
      expected = ["a", "f", "c", "b", "d", "e"]
      expect(jobs.job_order([["a"],["b","c"],["c", "a"],["d"],["e","f"],["f"],["g","h"],["h"],["i"]])).to eq(expected)
    end

  end
end
