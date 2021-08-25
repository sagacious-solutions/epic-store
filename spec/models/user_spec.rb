require 'rails_helper'
require 'user'

# params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation)


RSpec.describe User, type: :model do
  describe 'Validations' do
    before do 
      @user = User.new({:first_name => "Steve", :last_name => "Mcneely", :email => "stdfgdkfkljgjnm@hotmail.com", password:"somejunk", password_confirmation:"somejunk"})
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

    it "should not create a user if the passwords don't match" do
      bad_user = User.new({:first_name => "Steve", :last_name => "Mcneely", :email => "steeeeeeeve@hotmail.com", password:"somejunk", password_confirmation:"badpassword"})
      
      expect(bad_user.save).to be_falsey
    end
    
  end

   describe '.authenticate_with_credentials' do
    before do
      User.find_by_email("dsfdf@hotmail.com").destroy
      @new_user = User.new({:first_name => "Steve", :last_name => "Mcneely", :email => "dsfdf@hotmail.com", password:"somejunk", password_confirmation:"somejunk"})
      @new_user.save
    end

    it "should return the user if their credentials are valid" do
      expect(@new_user.authenticate_with_credentials("dsfdf@hotmail.com", "somejunk")).to eq(@new_user)
    end

    it "should return the false if their credentials are invalid" do
      expect(@new_user.authenticate_with_credentials("dsfdf@hotmail.com", "wrongpassword")).to be_falsey
    end

    it "should return the user if their credentials are valid but have leading and trailing whitespace in email" do
      expect(@new_user.authenticate_with_credentials("  dsfdf@hotmail.com   ", "somejunk")).to eq(@new_user)
    end

    it "should return the user if their case doesn't match the case of the email on record" do
      expect(@new_user.authenticate_with_credentials("  DsFdf@HotMAIL.com   ", "somejunk")).to eq(@new_user)
    end

    after do 
      User.find_by_email("dsfdf@hotmail.com").destroy
    end  

   end
end
