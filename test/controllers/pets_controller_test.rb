require 'test_helper'

class PetsControllerTest < ActionController::TestCase

  # Necessary setup to allow ensure we support the API JSON type
  setup do
     @request.headers['Accept'] = Mime::JSON
     @request.headers['Content-Type'] = Mime::JSON.to_s
   end

  test "can get #index" do
    get :index
    assert_response :success
  end

  test "#index returns json" do
    get :index
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#index returns an Array of Pet objects" do
    get :index
    # Assign the result of the response from the controller action
    body = JSON.parse(response.body)
    assert_instance_of Array, body
  end

  test "returns three pet objects" do
    get :index
    body = JSON.parse(response.body)
    assert_equal 3, body.length
  end

  test "each pet object contains the relevant keys" do
    keys = %w( age human id name )
    get :index
    body = JSON.parse(response.body)
    assert_equal keys, body.map(&:keys).flatten.uniq.sort
  end

  test "returns the first pet object" do
    get :show, id: pets(:one)
    body = JSON.parse(response.body)
    assert_equal Hash, body.class
    assert_response :success
  end

  test "#show returns json" do
    get :show, id: pets(:one)
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#show with a real id gives an ok response" do
    get :show, id: pets(:one)
    assert_response :ok
  end

  test "#show with a real id gives no content response" do
    get :show, id: 1
    assert_response :no_content
  end

  test "returns the current pet" do
    get :show, id: pets(:one)
    body = JSON.parse(response.body)
    assert_equal body["name"], "Peanut"
    assert_response :success
  end

end
