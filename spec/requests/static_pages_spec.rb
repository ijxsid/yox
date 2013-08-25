require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    
    it "should have the h1 'Sample App'" do
      
      visit '/static_pages/home'
      page.should have_selector('h1', 'Sample App')                          
      
    end

    it "should have base title" do

      visit '/static_pages/home'
      page.should have_title("Rails Sample App")
      
    end

    it "should not have costum page title" do

      visit '/static_pages/home'
      page.should_not have_title(" | Home")
      
    end


  end

  describe "Help page" do
    
    it "should have the h1 'Help'" do
      
      visit '/static_pages/help'
      page.should have_selector('h1',' Help')
      
    end

    it "should have indicative title" do

      visit '/static_pages/help'
      page.should have_title('Rails Sample App | Help')
      
    end
  
  end

  describe "About page" do
    
    it "should have the h1 'About Us'" do
      
      visit '/static_pages/about'
      page.should have_selector('h1', 'About Us')
      
    end

    it "should have indicative title" do

      visit '/static_pages/about'
      page.should have_title("Rails Sample App | About Us")
      
    end

  end

  describe "Contact page" do
    
    it "should have the  h1 'Contact'" do
      
      visit '/static_pages/contact'
      page.should have_selector('h1', 'Contact')                          
      
    end

    it "should have indicative title" do

      visit '/static_pages/contact'
      page.should have_title("Rails Sample App | Contact")
      
    end


  end
end
