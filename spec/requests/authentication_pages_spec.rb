require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }
  describe "Sign in page" do

    before { visit signin_path }
    it { should have_selector('h1', text: 'Sign in') }
    it { should have_title('Sign in') }

  end
  
  describe "sign in" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }
    
      it { should have_title('Sign in') }
      it { should have_error_message("Invalid")}
      
      describe "after visiting the home page" do
        before { click_link "Home" }
        it { should_not have_error_message }
        
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link("Profile", href: user_path(user)) }
      it { should have_link("Settings", href: edit_user_path(user))}
      it { should have_link("Sign out", href: signout_path) }
      it { should_not have_link("Sign in", href: signin_path) }

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end

    end
  end

  describe "authorization" do

    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) } 
      describe "in Users controller" do


        describe "visiting the edit page" do

          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
          it { should have_selector('div.alert.alert-notice') }

        end

        describe "submitting to update action" do
          before { patch user_path(user)}
          specify { response.should redirect_to signin_path }

        end
      end
    end

    describe "for wrong users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { valid_signin user, no_capybara: true}

      describe "when visiting the editpage of the wrong user" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title('Edit user') }

      end

      describe "when submitting a PATCH request to users#update" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to root_path}
      end
    end
  end

end
