require 'spec_helper'

describe UsersHelper do

  before do
    @user = User.new(name: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end

  describe "gravatar" do
    it "should take optional size parameter" do
      gravatar_for(@user, size: 40).should_not be_nil
    end
  end
end