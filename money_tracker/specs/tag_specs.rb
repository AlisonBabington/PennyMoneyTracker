require('minitest/autorun')
require('minitest/rg')
require_relative('../models/tags.rb')

class TagTest < Minitest::Test

  def test_tag_has_name
    tag1 = Tag.new({"name" => "Grocieries"})
    assert_equal("Grocieries", tag1.name)
  end

end
