require 'spec_helper'

describe "Gadget pages" do

  subject { page }

  describe "show" do
    
    let(:user) { FactoryGirl.create(:user) }
    let(:gadget) { FactoryGirl.create(:gadget) }

    before do
      sign_in user
      visit gadget_path(gadget)
    end

    it { should have_title(full_title(gadget.name)) }
    it { should have_selector('h1', gadget.name) }

    it "should list each gadget" do
      user.gadgets.each do |gadget|
        page.should have_selector('li', text: gadget.type.name)
      end
    end

    it { should_not have_link('Add Gadget', href: new_gadget_path) }
    it { should_not have_link('Delete')}
  end

end