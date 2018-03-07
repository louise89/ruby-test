require 'rubytest'

describe RubyTest do

let(:jobs) {RubyTest.new}

  describe 'job_order' do

    it 'returns an empty string when passed no jobs' do
      expected = ""
      expect(jobs.job_order("")).to eq(expected)
    end

  end
end
