require 'spec_helper'

describe "lookups/new" do
  before(:each) do
    assign(:lookup, stub_model(Lookup,
      :ac_type => "MyString",
      :name => "MyString",
      :code => 1,
      :position => 1
    ).as_new_record)
  end

  it "renders new lookup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lookups_path, :method => "post" do
      assert_select "input#lookup_ac_type", :name => "lookup[ac_type]"
      assert_select "input#lookup_name", :name => "lookup[name]"
      assert_select "input#lookup_code", :name => "lookup[code]"
      assert_select "input#lookup_position", :name => "lookup[position]"
    end
  end
end
