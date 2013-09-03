require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    
    before { visit root_path}

    it { should have_selector('h1', 'Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title(" | Home") }

    describe "for signed in users" do

      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem Ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        valid_signin user
        visit root_path
      end

      it "should render users' feed " do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end 
      end

    end

  end

  describe "Help page" do

    before { visit help_path}
    
    it { should have_selector('h1',' Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do

    before { visit about_path}
    
    it { should have_selector('h1', 'About Us') }
    it { should have_title(full_title('About')) }

  end

  describe "Contact page" do

    before { visit contact_path}

    it { should have_selector('h1', 'Contact') }
    it { should have_title(full_title('Contact')) }

  end

  describe "links on the layout" do
    
    before { visit root_path}

    it 'should have a valid link to Sign in page' do

      click_link 'Sign in'
      page.should have_title(full_title('Sign in'))
    end
    
    it 'should have a valid link to About page' do
      click_link 'About'
      page.should have_title(full_title('About Us'))
    end

    it "should have a valid link to contact page" do
      click_link 'Contact'
      page.should have_title(full_title('Contact'))
      
    end

    it "should have a valid link to help page" do
      click_link 'Help'
      page.should have_title(full_title('Help'))
      
    end

    it "should have a valid link to Sign up page" do
      click_link 'Sign up now!'
      page.should have_title full_title('Sign up')
      
    end


  end
end
