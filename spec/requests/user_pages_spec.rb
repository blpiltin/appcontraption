require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user, admin: true)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_heading('All users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
      
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
      
    end

  end

  # describe "signup page" do
  #   before { visit signup_path }

  #   it { should have_heading('Sign up') }
  #   it { should have_title(full_title('Sign up')) }
  # end
  
  describe "profile page" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let(:user) { FactoryGirl.create(:user) }
    let!(:g1) { FactoryGirl.create(
      :gadget, user: user, 
      gadget_type: GadgetType.find_by_name("Menu") ) }
    let!(:g2) { FactoryGirl.create(
      :gadget, user: user, 
      gadget_type: GadgetType.find_by_name("Events") ) }

    before do
      sign_in admin
      visit user_path(user) 
    end

    it { should have_heading(user.name) }
    it { should have_title(user.name) }

    describe "gadgets listing" do

      it { should have_selector('h3', text: 'Gadgets') }
      it { should have_link(g1.name, href: gadget_path(g1)) }

      describe "followed users" do
        before do
          sign_in user
          visit following_user_path(user)
        end

        it { should have_title(full_title('Following')) }
        it { should have_selector('h3', text: 'Following') }
        it { should have_link(other_user.name, href: user_path(other_user)) }
      end

      describe "followers" do
        before do
          sign_in other_user
          visit followers_user_path(other_user)
        end

        it { should have_title(full_title('Followers')) }
        it { should have_selector('h3', text: 'Followers') }
        it { should have_link(user.name, href: user_path(user)) }
      end
    end
  end

  describe "new" do

    before { visit new_user_path }

    let(:submit) { "Save" }

    describe "with invalid information" do

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('New user') }
        it { should have_content('error') }

        describe "should show correct error messages" do
          it { should have_content('Name can\'t be blank') }
          it { should have_content('Email can\'t be blank') }
          it { should have_content('Email is invalid') }
          it { should have_content('Password can\'t be blank') }
          it { should have_content('Password is too short') }
          it { should have_content('Password confirmation can\'t be blank') }
        end

        describe "should not show password digest can't be blank" do
          it { should_not have_content("Password digest can't be blank") }
        end

      end

    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(user.name) }

      end

    end

    describe "edit" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
        visit edit_user_path(user)
      end

      describe "page" do
        it { should have_heading("Update your profile") }
        it { should have_title("Edit user") }
        it { should have_link('change', href: 'http://gravatar.com/emails') }
      end

      describe "with invalid information" do
        before { click_button "Save changes" }

        it { should have_content('error') }
      end

      describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }

        before do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save changes"
        end

        it { should have_title(new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { user.reload.name.should  == new_name }
        specify { user.reload.email.should == new_email }
      end

    end

  end

end
