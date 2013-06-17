require 'spec_helper'

feature User do
  let(:user) do
    @previous_count = User.count
    @user = User.new
  end

  scenario 'user account is not created unless all info is presented' do
    user

    @user.save

    expect(User.count).to eql(@previous_count)
  end

  scenario 'user account is not created if email is not valid' do
    user

    @user.email = 'notvalidemail'
    @user.password = 'abc123456'
    @user.save

    expect(User.count).to eql(@previous_count)
  end

  scenario 'user account is not created if password is not long enough' do
    user

    @user.email = "email@mail.com"
    @user.password = "short"
    @user.save

    expect(User.count).to eql(@previous_count)
  end
end
