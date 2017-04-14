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

    "1.2.3@example.com",
    '"1.2.3"@example.com',

    "'@example.com",
    "\"'\"@example.com",

    '"a\"b"@example.com',
    %w{"><script>alert('or/**/2=1#')</script>"@example.com},
    %w{"d(e)f"@example.com},
  ].each do |address|
    define_method "test_valid_#{address}" do
      assert validate_address(address), "#{address} is expected valid"
    end
  end

  [
    "a..bc@example.com",
    "　a@example.com",
    "b　a@example.com",
    "b　@example.com",
    '" qcontent".@example.com',
    '.abc@example.com',
    "ab\\cd@example.com",
    '"a""@example.com',

    '""@example.com',

  ].each do |address|
    define_method "test_invalid_#{address}" do
      assert validate_address(address) == false, "#{address} is expected invalid"
    end
  end

  [
    "abc",
    "a.b.c",
    "ab.c"
  ].each do |atom|
    define_method "test_valid_atom_#{atom}" do
      assert /^(#{dot_atom})$/ === atom, "atom: #{atom} is expected valid"
    end
  end

  [
    ".abc",
    "abc.",
    "a..b",
    "ab..c"
  ].each do |atom|
    define_method "test_invalid_atom_#{atom}" do
      assert (/^(#{dot_atom})$/ === atom) == false, "atom: #{atom} is expected invalid"
    end
  end
end
