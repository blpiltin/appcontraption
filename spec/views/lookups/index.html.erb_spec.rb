require 'spec_helper'

describe "lookups/index" do
  before(:each) do
    assign(:lookups, [
      stub_model(Lookup,
        :ac_type => "Ac Type",
        :name => "Name",
        :code => 1,
        :position => 2
      ),
      stub_model(Lookup,
        :ac_type => "Ac Type",
        :name => "Name",
        :code => 1,
        :position => 2
      )
    ])
  end

  it "renders a list of lookups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ac Type".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
