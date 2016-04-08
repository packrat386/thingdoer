require 'spec_helper'

describe ThingDoer::Thing do
  context 'asked to do a thing' do
    let(:thing) { double('thing', do: 'done') }

    ThingDoer::DOABLE.each do |doable|
      it "does #{doable}" do
        expect(described_class.new(thing).send(doable)).to eq('done')
      end
    end
  end

  context 'arguments are passed' do
    let(:thing) { double('thing', do: 'done') }
    let(:arg) { double('argument') }

    it 'passes along arguments' do
      expect(thing).to receive(:do).with(arg)
      described_class.new(thing).do(arg)
    end
  end

  context 'a block is passed' do
    let(:thing) { double('thing') }
    let(:arg) { double('argument') }

    it 'yields to a block' do
      described_class.new(thing).do(arg) do |yielded|
        expect(yielded).to eq(arg)
      end
    end
  end

  context "the thing can't be done" do
    let(:thing) { double('thing') }

    it 'raises an UndoableError' do
      expect do
        described_class.new(thing).do
      end.to raise_error(ThingDoer::UndoableError)
    end
  end

  context 'unrecognized method' do
    context 'the underlying object recognizes the method' do
      let(:thing) { double('thing') }

      it 'passes it through' do
        expect(thing).to receive(:some) { 'method' }
        expect(described_class.new(thing).some).to eq('method')
      end
    end

    context "the underlying object doesn't recognize the method" do
      let(:thing) { double('thing') }

      it 'raises an UndoableError' do
        expect do
          described_class.new(thing).do
        end.to raise_error(ThingDoer::UndoableError)
      end
    end
  end
end
