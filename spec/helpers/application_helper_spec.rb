require 'spec_helper'

describe ApplicationHelper do
   
   describe "full_title" do
     
    it "should include the page title" do
      full_title('foo').should =~ /foo/
       
    end

    it "should include the base title" do
      full_title('foo').should =~ /^Rails Sample App/
       
    end

    it "should not include vertical bar when page title is absent" do
      full_title('').should_not =~ /\|/
    end
    
   end
end