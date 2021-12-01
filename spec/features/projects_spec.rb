require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  
  context "Create new project" do
    before(:each) do
      createUser
      login_as(@user)
      visit new_project_path
      fill_in 'project_title', with: "Test title"
    end

    after(:each) do
      logout
    end

    scenario "should be successful" do
      fill_in "project_description", with: "Test description"
      click_button "Submit"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Submit"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      createUser
      login_as(@user)
      visit edit_project_path(project)
    end

    after(:each) do
      logout
    end

    scenario "should be successful" do
      fill_in "project_description", with: "New description content"
      click_button "Submit"
      expect(page).to have_content("Project was successfully updated.")
    end

    scenario "should fail" do
      fill_in "project_description", with: ""
      click_button "Submit"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }

    scenario "remove project" do
      createUser
      login_as(@user)
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
      logout
    end
  end
end

def createUser
  @user = User.create(email: "123@abc.com", password: "abc123456")
end
