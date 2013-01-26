require 'spec_helper'

describe "lookups/show" do
  before(:each) do
    @lookup = assign(:lookup, stub_model(Lookup,
      :ac_type => "Ac Type",
      :name => "Name",
      :code => 1,
      :position => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ac Type/)
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
