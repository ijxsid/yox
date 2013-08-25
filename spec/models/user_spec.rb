require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com") }

  subject { @user }


  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid(:name) }

  describe "when name is not present" do
    before { @user.name = "  " }
    it {should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it {should_not be_valid }
  end

  describe "when name is too long" do
    before {@user.name = 'q' * 101  }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[add@foo,com baz_at_foo.com LAR_RITA@com. eureka.rigth@]
      
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end  

    end
  end


  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[add@foo.com baz.foo@baz.com LAR@rita.com eureka.rigth@rok.c]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end  

    end
  end

end
