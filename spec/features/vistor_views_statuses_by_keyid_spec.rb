require "spec_helper"

feature "This vistor views statues by id" do
  scenario "and the user has written statuses" do
    body = "I like pie in the sky"
    status = create(:status, body: body)
    create(:status, body: body)

    visit key_path(status.keyid)

    puts page.source
    click_link "I like pie"
    expect(page).to have_content body
    expect(page).to have_content status.keyid
  end
end
