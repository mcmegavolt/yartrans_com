require 'test_helper'

class Article::CategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Article::Category.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Article::Category.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Article::Category.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to article_category_url(assigns(:article_category))
  end

  def test_edit
    get :edit, :id => Article::Category.first
    assert_template 'edit'
  end

  def test_update_invalid
    Article::Category.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Article::Category.first
    assert_template 'edit'
  end

  def test_update_valid
    Article::Category.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Article::Category.first
    assert_redirected_to article_category_url(assigns(:article_category))
  end

  def test_destroy
    article_category = Article::Category.first
    delete :destroy, :id => article_category
    assert_redirected_to article_categories_url
    assert !Article::Category.exists?(article_category.id)
  end
end
