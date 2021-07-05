require_relative '../../lib/oha/binder'

module Oha
  RSpec.describe Binder do
    let(:event) { :some_event }
    let(:context) { spy(:context) }

    describe '#bind' do
      it 'receives an event name' do
        expect { described_class.new(context).bind(event) }.to_not raise_error
      end

      it 'sets event as ivars' do
        instance = described_class.new(context).bind(event)
        expect(instance.instance_variable_get(:@event)).to eq event
      end
    end

    describe '#to' do
      let(:context) { double(set_callback: '#set callback called') }
      let(:instance) { described_class.new(context).bind(event) }
      let(:callable_object) { double(call: '#call called') }

      it 'receives a callable object as parameter' do
        expect { instance.to(callable_object) }.to_not raise_error
        expect { instance.to }.to raise_error ArgumentError
      end

      it 'returns self' do
        expect(instance.to(callable_object)).to be_an_instance_of(described_class)
      end

      it 'sets the behaviour' do
        instance.to(callable_object)

        expect(context).to have_received(:set_callback).with(:some_event, callable_object)
      end
    end
  end
end
