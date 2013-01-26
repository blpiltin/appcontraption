require 'spec_helper'

describe "gadgets/new" do
  before(:each) do
    assign(:gadget, stub_model(Gadget,
      :label => "MyString",
      :icon => "MyString",
      :description => "MyText",
      :position => 1,
      :user_id => 1,
      :gadget_type_id => 1
    ).as_new_record)
  end

  it "renders new gadget form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gadgets_path, :method => "post" do
      assert_select "input#gadget_label", :name => "gadget[label]"
      assert_select "input#gadget_icon", :name => "gadget[icon]"
      assert_select "textarea#gadget_description", :name => "gadget[description]"
      assert_select "input#gadget_position", :name => "gadget[position]"
      assert_select "input#gadget_user_id", :name => "gadget[user_id]"
      assert_select "input#gadget_gadget_type_id", :name => "gadget[gadget_type_id]"
    end
  end
end
