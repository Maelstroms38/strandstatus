require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
 context "#new" do
 context "when not logged in" do
 	should "redirect to the login page" do
 		get :new
 		assert_response :redirect
 	end
 end
 	should "return 404"
 	get :new, friend_id: 'invalid'
 	assert_response :not_found
 end
 should "ask if friend is really wanted"
 get :new, friend_id: users(:michael)
 assert_match /Do you really wamt to friend?/, response.body
end
end
end
end