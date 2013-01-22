require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_heading(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'appcontraption' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'something@something.com') }

      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        FactoryGirl.create(:micropost, user: wrong_user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: wrong_user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      it "should count the number of posts" do
        3.times do
          visit root_path
          page.should have_selector("div.micropost-count", 
            text: user.feed.count.to_s + ' ' + 
              'micropost'.pluralize(user.feed.count))
          user.feed.first.delete if user.feed.any?
        end
      end

      it "should not have delete links for other users posts" do
        user.microposts.delete_all
        visit root_path
        user.feed.each do |item|
          item.should_not have_link('delete')
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end

  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_title full_title('About Us')
    click_link "Help"
    page.should have_title full_title('Help')
    click_link "Contact"
    page.should have_title full_title('Contact')
    click_link "Home"
    page.should have_title full_title('')
    click_link "Sign up now!"
    page.should have_title full_title('Sign up')
    click_link "appcontraption"
    page.should have_title full_title('')
  end

end