require_relative "../../lib/oha/binder"

module Oha
  RSpec.describe Binder do
    let(:event) { :some_event }

    describe "#initialize" do
      it "receives an event name" do
        expect { Oha::Binder.new(event) }.to_not raise_error
      end

      it "sets context and event as ivars" do
        instance = Oha::Binder.new(event)
        expect(instance.instance_variable_get(:@event)).to eq event
      end
    end

    describe "#to" do
      let(:callable_object) { double(call: "#call called") }
      it "receives a callable object as parameter" do
        instance = described_class.new(event)
        expect{ instance.to(callable_object) }.to_not raise_error
        expect{ instance.to }.to raise_error ArgumentError
      end

      it "sets the behaviour"
    end
  end
end
