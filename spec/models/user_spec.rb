require 'spec_helper'

describe User do
  let!(:user) do
    @user = User.new
  end

  it 'account is not created unless all info is presented' do
    expect(@user.save).to eql(false)
  end

  it 'account is not created if username is not provided' do
    @user.email = "email@mail.com"
    @user.password = "abc123456"

    expect(@user.save).to eql(false)
  end

  it 'account is not created if email is not valid' do
    @user.username = "username"
    @user.email = 'notvalidemail'
    @user.password = 'abc123456'

    expect(@user.save).to eql(false)
  end

  it 'account is not created if password is not long enough' do
    @user.username = "username"
    @user.email = "email@mail.com"
    @user.password = "short"

    expect(@user.save).to eql(false)
  end

  it { should have_many(:lists) }
end
