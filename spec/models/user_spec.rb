require 'spec_helper'

feature User do
  scenario 'user account is not created unless all info is presented' do
    user = User.new

    user.save

    expect(user.valid?).to eql(false)
  end
end
