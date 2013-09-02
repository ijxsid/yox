require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
            password: "foobar", password_confirmation: "foobar") 
  end
  
  subject { @user }


  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:remember_token)}
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }


  it { should be_valid(:name) }
  it { should_not be_admin}

  describe "with admin set to 'true'" do
    before do
      @user.save
      @user.toggle!(:admin)
    end
    it { should be_admin}
  
  end

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
      addresses = %w[add@foo,com baz_at_foo.com LAR_RITA@com. eureka.rigth@ 
        rikew@i+9.com ottopia@rock_raz.com]

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

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match password_confirmation" do
    before { @user.password_confirmation = "mismatch"}
    it { should_not be_valid }
  end

  describe "when password_confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when password is too short " do
    before { @user.password = @user.password_confirmation = "a"*5}
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do

    before { @user.save }
    let(:found_user) { User.where(email: @user.email).take }
      
      describe "with a valid password" do
        it { should == found_user.authenticate(@user.password) }
          
      end

      describe "with an invalid password" do
        let(:user_with_invalid_password) {found_user.authenticate("invalid")}
        it { should_not == user_with_invalid_password }
        specify { user_with_invalid_password.should be_false}
    
      end
  end

  describe "remember token" do
    before { @user.save}
    its(:remember_token) { should_not be_blank}
  end


  describe "microposts associations" do

    before { @user.save }

    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end

    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end
    it "should have right microposts in right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
      
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty

      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end

          
    end
  end
end
