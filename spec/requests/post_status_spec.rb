require 'spec_helper'
require 'hkp'

describe 'visitor posts a status' do
  it 'uses attached public key' do
    signed_body = read_fixture('i_like_pie.asc')
    pub = read_fixture('CD6B99AA8A13C05D.asc')

    Hkp.stub(new: nil)

    post statuses_path, { status: { signed_body: signed_body, raw_pub_key: pub } }

    expect(Hkp).not_to have_received(:new)
    expect(response.code.to_i).to eq(201)
  end
end
