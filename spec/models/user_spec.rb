require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it 'user needs password and password_confirmation fields' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test'
      @user.last_name = 'test'
      @user.password = 'testing'
      @user.password_confirmation = 'testings'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'fails without password field, but has confirmation field' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test'
      @user.last_name = 'test'
      # @user.password = 'testing'
      @user.password_confirmation = 'testing'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'fails without confirmation field' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test'
      @user.last_name = 'test'
      @user.password = 'testing'
      # @user.password_confirmation = 'test'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'needs password and password_confirmation fields' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test'
      @user.last_name = 'test'
      # @user.password = 'testing'
      # @user.password_confirmation = 'test'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'password must be at least 6 characters' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test'
      @user.last_name = 'test'
      @user.password = 'test'
      @user.password_confirmation = 'test'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'unique emails only, not case sensitive' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test1'
      @user.last_name = 'test1'
      @user.password = 'testing'
      @user.password_confirmation = 'testing'

      expect(@user.valid?).to be true
      @user.save
      @user2 = User.new();
      @user2.email = 'Test@Testing.Test'
      @user2.first_name = 'test1'
      @user2.last_name = 'test1'
      @user2.password = 'testing'
      @user2.password_confirmation = 'testing'
      expect(@user2.valid?).to be false
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it 'first name required' do
      @user = User.new();
      @user.email = 'test@testing.test'
      # @user.first_name = 'test'
      @user.last_name = 'test'
      @user.password = 'testing'
      @user.password_confirmation = 'testing'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'last name required' do
      @user = User.new();
      @user.email = 'test@testing.test'
      @user.first_name = 'test'
      # @user.last_name = 'test'
      @user.password = 'testing'
      @user.password_confirmation = 'testing'

      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
  end
  describe 'authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', '12345678')
      expect(user).not_to be(nil)
    end
    it 'should fail with invalid credentials' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', '1234678')
      expect(user).to be(nil)
    end
    it 'should pass with whitespace on email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      user = User.authenticate_with_credentials('  test@test.com     ', '12345678')
      expect(user.email).to be == "test@test.com"
    end
    it 'should pass with wrong case on email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.save

      user = User.authenticate_with_credentials('Test@test.COM', '12345678')
      expect(user.email).to be == "test@test.com"
    end
  end
end
