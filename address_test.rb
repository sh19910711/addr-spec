require_relative 'address'
require 'minitest/unit'
require 'minitest/autorun'

class TestAddress < MiniTest::Unit::TestCase
  [
    "abc@example.com",
    "a.b.c@example.com",

    '"abc"@example.com',

    '" abc"@example.com',
    '"abc "@example.com',
    '" abc "@example.com',

    "123@example.com",
  ].each do |address|
    define_method "test_valid_#{address}" do
      assert validate_address(address), "#{address} is expected valid"
    end
  end

  [
    "a..bc@example.com",
    "　a@example.com",
    '" qcontent".@example.com',
    '.abc@example.com'
  ].each do |address|
    define_method "test_invalid_#{address}" do
      assert validate_address(address) == false, "#{address} is expected invalid"
    end
  end
end
