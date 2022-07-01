require 'test_helper'

class ChefTest < ActiveSupport::TestCase

    def setup
        @chef = Chef.new(chefs_name: "claud", email: "claud@gmail.com",
                        password: "password", password_confirmation: "password")
    end

    test "chef should be valid" do
        assert @chef.valid?
    end

    # validate chefs name    
    test "chef's name should be present" do
        @chef.chefs_name = ""
        assert_not @chef.valid?
    end

    test "chef's name should be less than 30 characters" do
        @chef.chefs_name = "a" * 31
        assert_not @chef.valid?
    end

    # validate chefs email
    test "chef's email should be present" do
        @chef.email = ""
        assert_not @chef.valid?
    end

    test "chef's email should not be too long" do
        @chef.email = "a" * 245 + "@example.com"
        assert_not @chef.valid?
    end

    test "chef's email should be in the correct format" do
        valid_emails = %w[user@example.com CLAUD@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
        valid_emails.each do |valids|
            @chef.email = valids
            assert @chef.valid?, "#{valids.inspect} should be valid"
        end
    end

    test "invalid chef's email should be rejected" do
        invalid_emails = %w[claud@example claud@example,com claud.name@gmail. claud@bar+foo.com]
        invalid_emails.each do |invalids|
            @chef.email = invalids
            assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
        end
    end

    test "chef's email should be unique and case insensitive" do
        duplicate_chef = @chef.dup
        duplicate_chef.email = @chef.email.upcase
        @chef.save
        assert_not duplicate_chef.valid?
    end

    test "chef's emails should be lower case" do
        mixed_email = "ClaUd@ExamPle.com"
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email
    end

    test "password should be present" do
        @chef.password = @chef.password_confirmation = " "
        assert_not @chef.valid?
    end

    test "password should have at least 5 charaters" do
        @chef.password = @chef.password_confirmation = "x" * 4
        assert_not @chef.valid?
    end

end