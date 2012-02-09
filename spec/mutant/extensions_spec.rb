require 'spec_helper'

describe Class do
  describe '#basename' do
    context 'when called on Thing::Spirit' do
      setup_thing { class Spirit; end }

      it 'returns "Spirit"' do
        Thing::Spirit.basename.should eq('Spirit')
      end
    end
  end
end