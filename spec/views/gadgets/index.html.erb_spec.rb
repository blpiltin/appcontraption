require 'spec_helper'

describe "gadgets/index" do
  before(:each) do
    assign(:gadgets, [
      stub_model(Gadget,
        :label => "Label",
        :icon => "Icon",
        :description => "MyText",
        :position => 1,
        :user_id => 2,
        :gadget_type_id => 3
      ),
      stub_model(Gadget,
        :label => "Label",
        :icon => "Icon",
        :description => "MyText",
        :position => 1,
        :user_id => 2,
        :gadget_type_id => 3
      )
    ])
  end

  it "renders a list of gadgets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Icon".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
