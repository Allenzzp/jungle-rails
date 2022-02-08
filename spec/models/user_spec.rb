require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "create user failed when password and password_confirmation fields don't match" do
      @user = User.create(
        first_name: "Allen",
        last_name: "Zhao",
        email: "111222333@qq.com",
        password: "123456",
        password_confirmation: "1234567"
      )
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "emails must be unique" do
      User.create(
        first_name: "Alex",
        last_name: "Wang",
        email: "111@qq.com",
        password: "123456",
        password_confirmation: "123456"
      )
      @user = User.create(
        first_name: "Allen",
        last_name: "Zhao",
        email: "111@qq.com",
        password: "abc123",
        password_confirmation: "abc123"
      )
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    it 'create user without password_confirmation should fail' do
      @user = User.create(
        first_name: "Allen",
        last_name: "Zhao",
        email: "111222333@qq.com",
        password: "123456",
        password_confirmation: nil
      )
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'create user without first_name should fail' do
      @user = User.create(
        first_name: nil,
        last_name: "Zhao",
        email: "111222333@qq.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'create user without last_name should fail' do
      @user = User.create(
        first_name: "Allen",
        last_name: nil,
        email: "111222333@qq.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'create user without email should fail' do
      @user = User.create(
        first_name: "Allen",
        last_name: "Zhao",
        email: nil,
        password: "123456",
        password_confirmation: "123456"
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'password should be at least 6 characters' do
      @user = User.create(
        first_name: "Allen",
        last_name: "Zhao",
        email: "abc@gmail.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    #for tmrw!!!!!!
  end
end
