require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user should enter first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
end
test "user should enter last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
end
test "user should enter profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
end
  test "user's profile is unique"
  user = User.new
  user.profile_name = users(:michael).profile_name
  assert !user.save
  assert !user.errors[:profile_name].empty?
end
end