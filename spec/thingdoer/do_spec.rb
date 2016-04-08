require 'spec_helper'

describe ThingDoer do
  ThingDoer::DOABLE.each do |underlying|
    context "with underlying method #{underlying}" do
      let(:thing) { double('thing', underlying => 'done') }
      ThingDoer::DOABLE.each do |doable|
        context "when attempting #{doable}" do
          it "does #{underlying}" do
            expect(ThingDoer.do_the_thing(thing)).to eq('done')
          end
        end
      end
    end
  end
end
