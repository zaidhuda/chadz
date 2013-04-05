require 'test_helper'

class MessageboxesControllerTest < ActionController::TestCase
  setup do
    @messagebox = messageboxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messageboxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messagebox" do
    assert_difference('Messagebox.count') do
      post :create, messagebox: { name: @messagebox.name }
    end

    assert_redirected_to messagebox_path(assigns(:messagebox))
  end

  test "should show messagebox" do
    get :show, id: @messagebox
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messagebox
    assert_response :success
  end

  test "should update messagebox" do
    put :update, id: @messagebox, messagebox: { name: @messagebox.name }
    assert_redirected_to messagebox_path(assigns(:messagebox))
  end

  test "should destroy messagebox" do
    assert_difference('Messagebox.count', -1) do
      delete :destroy, id: @messagebox
    end

    assert_redirected_to messageboxes_path
  end
end
