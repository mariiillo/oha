require_relative "../lib/oha.rb"

class SomeUseCase
  include Oha
end

RSpec.describe Oha do
  it "has a version number" do
    expect(Oha::VERSION).not_to be nil
  end

  describe "Oha behaviour" do
    describe ".call" do
      let(:params) { double }
      let(:call_use_case) do
        SomeUseCase.call(params) do
          bind(:success).to { puts "success trigered" }
        end
      end

      it "receives params and a block with the list of events that can be triggered" do
        expect { call_use_case }.to_not raise_error
      end

    end

    describe "#initialize" do
      let(:params) { double }
      let(:call_use_case_without_block) do
        SomeUseCase.call(params)
      end

      it "raises an Error if no block was given" do
        expect { call_use_case_without_block }.to raise_error(Oha::NoBlockGivenError)
      end
    end
  end
end
