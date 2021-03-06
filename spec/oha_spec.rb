require_relative '../lib/oha'

class SomeUseCase
  include Oha

  def payload
    {
      foo: 'bar'
    }
  end
end

RSpec.describe Oha do
  it 'has a version number' do
    expect(Oha::VERSION).not_to be nil
  end

  describe 'Oha behaviour' do
    let(:params) { double }

    describe '.call' do
      let(:call_use_case) do
        SomeUseCase.call(params) { |use_case| }
      end

      it 'receives params and a block with the list of events that can be triggered' do
        expect { call_use_case }.to_not raise_error
      end

      it 'yields an instance of the included class' do
        yielded_instance = nil
        SomeUseCase.call do |use_case_instance|
          yielded_instance = use_case_instance
        end
        expect(yielded_instance).to be_an_instance_of Oha::Binder
      end
    end

    describe '#initialize' do
      let(:call_use_case_without_block) do
        SomeUseCase.call(params)
      end

      let(:call_use_case) do
        SomeUseCase.call(params) { |use_case| }
      end

      it 'sets @binder' do
        use_case = call_use_case
        expect(use_case.instance_variable_get(:@binder)).to be_an_instance_of Oha::Binder
      end

      it 'raises an Error if no block was given' do
        expect { call_use_case_without_block }.to raise_error Oha::Errors::NoBlockGivenError
      end
    end

    describe '#trigger' do
      it 'executes the callback associated to an event' do
        subject = SomeUseCase.call(params) do |use_case|
          use_case.bind(:foo).to(->(payload) { "Hello #{payload[:foo]}" })
        end

        expect(subject.trigger(:foo, { foo: 'bar' })).to eq 'Hello bar'
      end

      it 'receives an event name as parameter' do
        subject = SomeUseCase.call(params) do |use_case|
          use_case.bind(:foo).to(->(payload) { 'bar' })
        end

        expect { subject.trigger(:foo) }.not_to raise_error
      end

      it 'raises an error if the event name is unknown' do
        subject = SomeUseCase.call(params) do |use_case|
          use_case.bind(:foo).to(-> { 'bar' })
        end

        expect { subject.trigger(:baz) }.to raise_error(Oha::Errors::EventNotDefined)
      end
    end
  end
end
