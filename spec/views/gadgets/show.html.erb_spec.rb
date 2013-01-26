require 'spec_helper'

describe "gadgets/show" do
  before(:each) do
    @gadget = assign(:gadget, stub_model(Gadget,
      :label => "Label",
      :icon => "Icon",
      :description => "MyText",
      :position => 1,
      :user_id => 2,
      :gadget_type_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Label/)
    rendered.should match(/Icon/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
