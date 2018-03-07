require 'rubytest'

describe RubyTest do

let(:jobs) {RubyTest.new}

  describe 'job_order' do

    it 'returns an empty string when passed no jobs' do
      expected = ""
      expect(jobs.job_order("")).to eq(expected)
    end

    it 'returns a string when passed a job' do
      expected = "a"
      expect(jobs.job_order("a")).to eq(expected)
    end

    it 'returns a string when passed multiple jobs' do
      expected = "abc"
      expect(jobs.job_order("abc")).to eq(expected)
    end

  end
end
