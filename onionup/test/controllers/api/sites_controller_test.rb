require 'test_helper'

class Api::SitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_sites_index_url
    assert_response :success
  end

  test "should get show" do
    get api_sites_show_url
    assert_response :success
  end

  test "should get create" do
    get api_sites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_sites_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get api_sites_edit_url
    assert_response :success
  end

  test "should get update" do
    get api_sites_update_url
    assert_response :success
  end

end
