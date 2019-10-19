require_relative "../../lib/oha/binder"

module Oha
  RSpec.describe Binder do
    describe "#initialize" do
      let(:event) { :some_event }

      it "receives an event name" do
        expect { Oha::Binder.new(event) }.to_not raise_error
      end

      it "sets context and event as ivars" do
        instance = Oha::Binder.new(event)
        expect(instance.instance_variable_get(:@event)).to eq event
      end
    end

    describe "#to" do
      it "receives a callable object as parameter"
      it "sets the behaviour"
    end
  end
end
