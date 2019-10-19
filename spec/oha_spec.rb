require_relative "../lib/oha.rb"
require_relative "../lib/oha/binder.rb"

class SomeUseCase
  include Oha
end

RSpec.describe Oha do
  it "has a version number" do
    expect(Oha::VERSION).not_to be nil
  end

  describe "Oha behaviour" do
    let(:params) { double }

    describe ".call" do
      let(:call_use_case) do
        SomeUseCase.call(params) { |use_case| }
      end

      it "receives params and a block with the list of events that can be triggered" do
        expect { call_use_case }.to_not raise_error
      end

      it "yields an instance of the included class" do
        yielded_instance = nil
        SomeUseCase.call do |use_case_instance|
          yielded_instance = use_case_instance
        end
        expect(yielded_instance.class).to eq SomeUseCase
      end
    end

    describe "#initialize" do
      let(:call_use_case_without_block) do
        SomeUseCase.call(params)
      end

      let(:call_use_case) do
        SomeUseCase.call(params) { |use_case| }
      end

      it "sets mappings" do
        use_case = call_use_case
        expect(use_case.instance_variable_get(:@mappings)).to an_instance_of(Hash)
        expect(use_case.instance_variable_get(:@mappings)).to be_empty
      end

      it "raises an Error if no block was given" do
        expect { call_use_case_without_block }.to raise_error(Oha::NoBlockGivenError)
      end
    end

    describe "#bind" do
      it "receives an event name and returns an Oha::Binding object" do
        use_case = SomeUseCase.new { }
        returned_value = use_case.bind(:succes)
        expect(returned_value).to be_an_instance_of(Oha::Binder)
      end
    end
  end
end
