require 'rails_helper'
require 'user'

# params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation)


RSpec.describe User, type: :model do
  describe 'Validations' do
    before do 
      @user = User.new({:first_name => "Steve", :last_name => "Mcneely", :email => "hotmale@hotmail.com", password:"somejunk", password_confirmation:"somejunk"})
    end    


    it 'Should have a first_name' do
        expect(@user.first_name).to be_present
    end
    
    it 'Should have a last_name' do
      expect(@user.last_name).to be_present
    end
    
    it 'Should have an email' do
      expect(@user.email).to be_present
    end
    
    it 'Should have a password' do
      expect(@user.password).to be_present
    end

    it 'The password fields should match' do
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'Should have a unique email from other users' do
      existing_user = User.find_by_email(@user.email)

      puts existing_user
      expect(existing_user).to be_nil
    end

  end
end
