require 'spec_helper'
describe 'liveconfig' do

  context 'with default values for all parameters' do
    it { should contain_class('liveconfig') }
  end
end
