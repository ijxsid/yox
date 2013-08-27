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
      it { should have_selector('div.alert.alert-error', text: "Invalid")}
      
    end
  end
end
