require 'spec_helper'

describe KeysController do
  context '#show' do
    it 'raises ActiveRecord::RecordNotFound on a missing key' do
      expect { get :show, id: '0x12345678' }.
        to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
