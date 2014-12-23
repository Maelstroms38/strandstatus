require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "Creating friendship" do 
  	assert_nothing_raised do
  	UserFriendship.create user: users(:michael), friend: users(:max)
end
end
end