require 'rails_helper'

RSpec.feature "HomePages", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Projects")
  end

  scenario "Vistor cannot add new project without logging in" do
    visit root_path
    expect(page).not_to have_text("Log in")
  end

  scenario "User can add new project after logging in" do
    visit root_path
    createUser
    login_as(@user)
    visit root_path
    click_button "New Project"
    expect(page).to have_text("Description")
  end


end

def createUser
  @user = User.create(email: "123@abc.com", password: "abc123456")
end
