require 'spec_helper'

describe "UserPages" do
  subject {page}

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before do

      valid_signin user
      visit users_path 
    end

    it { should have_title('All users')}
    it { should have_selector('h1', text: 'All users') }

    describe "pagination" do

      before(:all) {30.times {FactoryGirl.create(:user) } }
      after(:all) {User.delete_all}
      it {should have_selector('div.pagination') }
      it "should list each user" do
        User.all.each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    

    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          valid_signin admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do

          expect do
            click_link 'delete'
          end.to change(User, :count).by(-1)
        end

        it { should_not have_link('delete', href:user_path(admin)) }
      end

      describe "as non-admin users" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { valid_signin non_admin, no_capybara: true }

        describe "submitting the DELETE request to users#destroy " do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to root_path }
        end
      end
    end
  end

  describe "Signup page" do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up'))}
      
  end

  describe "Profile page" do
    let(:user) {FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name) }
    it { should have_title(full_title(user.name)) }
      
  end

  describe "Signup" do
    let(:submit) { "Create my account" }
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
        
      end

      describe "after submission with invalid information" do
        before { click_button submit }
        it { should have_title(full_title('Sign up')) } 
        it { should have_content('error') }


      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "ijs@oaks.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving a user" do
        before { click_button submit }
        let(:user) { User.where(email: "ijs@oaks.com").take }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: "Welcome")}
        it { should have_link("Sign out") }
      end

    end



  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do

      # In order to access edit page, we need to sign in.
      valid_signin user 
      visit edit_user_path(user)
    end


    describe "page" do
    
    it { should have_selector('h1', text: "Update your profile") }
    it { should have_title("Edit user") }
    it { should have_link("change", href: "https://gravatar.com/emails")}  
    end
    
    describe "with invalid information" do
      before { click_button "Save changes"}
      
      it { should have_content('error') }

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@email.com" }

      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }

      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
      
    end
  end
end
