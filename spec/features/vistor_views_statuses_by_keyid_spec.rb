require "spec_helper"
require "hkp"

feature "When a visitor views statues by keyid" do
  scenario "the visitor sees the key's statuses" do
    hkp = double("hkp")
    stub_hkp(hkp, "0A52C0DB14A5A932")
    stub_hkp(hkp, "CD6B99AA8A13C05D")
    Hkp.stub(new: hkp)

    expected_status = create(:status, signed_body: read_fixture("i_like_pie.asc"))
    other_status = create(:status, signed_body: read_fixture("my_first_tweet.asc"))

    visit key_path(expected_status.keyid)
    expect(page).to have_content expected_status.key.primary_name
    expect(page).not_to have_content other_status.body.first(5)

    click_link expected_status.body.first(3)
    expect(page).to have_content expected_status.body
  end

  private

  def read_fixture(filename)
      File.read(Rails.root.join("spec", "fixtures", filename))
  end

  def stub_hkp(hkp, fingerprint)
    hkp.stub(:fetch).with(fingerprint) do
        read_fixture("#{fingerprint}.asc")
    end
  end

end
