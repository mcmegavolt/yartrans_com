require 'test_helper'

class Article::CategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Article::Category.new.valid?
  end
end
