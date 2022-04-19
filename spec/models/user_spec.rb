require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation' do

    it "should be created with all proper fields" do
      @user = User.new({
        name: "Jack",
        email: "test1@test.com",
        password: "12345",
        password_confirmation: "12345"
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
        password: "12345",
        password_confirmation: "123456"
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")

    end


    it "should not be created with no email field " do
      @user = User.new({
        name: "Jack",
        email: nil,
        password: "123456",
        password_confirmation: "123456"
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to include("can't be blank")

    end

    it "should not be created with no name field " do
      @user = User.new({
        name: nil,
        email: "test1@test.com",
        password: "123456",
        password_confirmation: "123456"
      })

      expect(@user).to_not be_valid
      expect(@user.errors[:name]).to include("can't be blank")

    end

    describe "email uniqueness"  do
      before(:all) do
        @user = User.new({
          name: "Jacky",
          email: "test@test.com",
          password: "123456",
          password_confirmation: "123456"
        })
        @user.save
      end

      it "should not be created with email alreay in database" do

        @user2 = User.new({
          name: "Jacky",
          email: "test@test.com",
          password: "123456",
          password_confirmation: "123456"
        })
  
        expect(@user2).to_not be_valid  
        expect(@user.errors[:email]).to include("has already been taken")
      end
    end

    

  end
end
