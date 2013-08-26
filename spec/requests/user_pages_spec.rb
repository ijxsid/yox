require 'spec_helper'

describe "UserPages" do
  subject {page}

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
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
        
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
        expect { click_button "Create my account" }.to change(User, :count).by(1)
      end

      describe "after saving a user" do
        before { click_button "Create my account"}
        let(:user) { User.where(email: "ijs@oaks.com").take }

        it { should have_title(user.name) }
      end

    end



  end
end
