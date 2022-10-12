require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  
  test "create action should require a logged in user" do
    assert_no_difference "Relationship.count" do
      post relationships_path
    end
    assert_redirected_to login_path
  end

  test "destroy action should require a logged in user" do
    assert_no_difference "Relationship.count" do
      delete relationship_path(relationships(:one))
    end
    assert_redirected_to login_path
  end
end
