require 'spec_helper'
require 'sig_exception'

describe StatusesController do
  context '#index' do
    it 'produces a concatenation of all the text signed by the keyid' do
      status1 = create(:status)
      key = status1.key
      status2 = create(:status, key: key)

      get :index, key_id: key.keyid, format: 'asc'

      expect(response.body).to eq("#{status1.signed_body}\n#{status2.signed_body}")
    end
  end

  context '#create' do
    it 'produces a 400 on SigException' do
      status = double('status')
      status.stub(:save).and_raise(SigException, "foo bar")
      Status.stub(new: status)

      post :create, status: { signed_body: "baz" }

      expect(response.body).to eq("foo bar")
    end
  end

  context '#show' do
    it 'produces the signature when requested with the ASC format' do
      status = create(:status)

      get :show, hexid: status.hexid, format: 'asc'

      expect(response.body).to eq(status.signed_body)
    end
  end
end
