require 'spec_helper'

describe "lookups/edit" do
  before(:each) do
    @lookup = assign(:lookup, stub_model(Lookup,
      :ac_type => "MyString",
      :name => "MyString",
      :code => 1,
      :position => 1
    ))
  end

  it "renders the edit lookup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lookups_path(@lookup), :method => "post" do
      assert_select "input#lookup_ac_type", :name => "lookup[ac_type]"
      assert_select "input#lookup_name", :name => "lookup[name]"
      assert_select "input#lookup_code", :name => "lookup[code]"
      assert_select "input#lookup_position", :name => "lookup[position]"
    end
  end
end
