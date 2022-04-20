require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation' do

    it "should be created with all proper fields" do
      @user = User.new({
        name: "Jack",
        email: "test1@test.com",
        password: "1234567",
        password_confirmation: "1234567"
      })

      expect(@user).to be_valid

    end


    it "should not be created with no password and password_confirmation fields " do
      @user = User.new({
        name: "Jack",
        email: "test1@test.com",
        password: nil,
        password_confirmation: nil
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to include("can't be blank")


    end

    it "should not be created with  different password and password_confirmation fields " do
      @user = User.new({
        name: "Jack",
        email: "test1@test.com",
        password: "1234577",
        password_confirmation: "1234567"
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")

    end


    it "should not be created with no email field " do
      @user = User.new({
        name: "Jack",
        email: nil,
        password: "1234567",
        password_confirmation: "1234567"
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include("can't be blank")

    end

    it "should not be created with no name field " do
      @user = User.new({
        name: nil,
        email: "test1@test.com",
        password: "1234567",
        password_confirmation: "1234567"
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:name]).to include("can't be blank")

    end

    describe "email uniqueness"  do
      before(:all) do
        @user = User.create!({
          name: "Jacky",
          email: "test@test.com",
          password: "1234567",
          password_confirmation: "1234567"
        })
     end

      it "should not be created with email alreay in database" do

        @user2 = User.new({
          name: "Jacky",
          email: "test@test.com",
          password: "1234567",
          password_confirmation: "1234567"
        })
          
        expect(@user2).to_not be_valid  
        expect(@user2.errors[:email]).to include("has already been taken")
      end
    end

    describe "minimum password legnth"  do
      subject { 
          described_class.new(
          name: "Jacky",
          email: "test@test.com",
          password: "1234567",
          password_confirmation: "1234567"
          )
      }

      it "should not be created with password less than 6" do

        subject.password = "12345"
        subject.password_confirmation = "12345"

  
        expect(subject).to_not be_valid  
        expect(subject.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end

    

  end


  describe '.authenticate_with_credentials' do
    before(:all) do
      @user = User.create!({
        name: "Jacky",
        email: "test2@test.com",
        password: "abcdefg",
        password_confirmation: "abcdefg"
      })
    end

    it "should authenticate with proper credentials" do
      email = "test2@test.com"
      password = "abcdefg"
      @user1 = User.authenticate_with_credentials(email, password)

      expect(@user1).not_to be_nil

    end

  end
end
