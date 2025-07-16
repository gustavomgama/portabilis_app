require 'rails_helper'

RSpec.describe "Users management", type: :system do
  before :each do
    User.create(email: "test@email.com", password: "123123", role: 1)
  end
  it "logs in" do
    visit new_user_session_path

    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "123123"

    click_on "Sign In"
    expect(page).to have_content("Signed in successfully.")
  end

  it "creates a user" do
    visit new_user_session_path

    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "123123"

    click_on "Sign In"
    expect(page).to have_content("Signed in successfully.")

    click_on "Users"

    click_on "Create User"

    fill_in "Email", with: "test2@example.com"
    fill_in "Password", with: "123123"

    click_on "Create User"

    expect(page).to have_content("User created")
    expect(page).to have_current_path(users_path)
  end
end
