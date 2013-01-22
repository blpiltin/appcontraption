require 'spec_helper'

describe "Contact pages" do

  subject { page }

  describe "send message" do

    before { visit contact_path }
  
    it { should have_heading('Contact') }
    it { should have_title(full_title('Contact')) }

    let(:submit) { "Send" }

    describe "with invalid information" do

      it "should not create a message" do
        expect { click_button submit }.not_to change(Message, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(full_title('Contact')) }
        it { should have_content('error') }

        describe "should show correct error messages" do
          it { should have_content('Name can\'t be blank') }
          it { should have_content('Email can\'t be blank') }
          it { should have_content('Email is invalid') }
          it { should have_content('Subject can\'t be blank') }
          it { should have_content('Body can\'t be blank') }
        end

      end

    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Subject",          with: "Test Subject"
        fill_in "Message",          with: "This is some text to test with."
      end

      it "should create a message" do
        expect { click_button submit }.to change(Message, :count).by(1)
      end

      describe "after saving the message" do
        before { click_button submit }
        let(:message) { Message.find_by_email('user@example.com') }

        it { should have_heading('appcontraption') }
        it { should have_title(full_title('')) }
        it { should have_selector('div.alert.alert-success', 
          text: 'Your message was sent successfully.') }

      end

    end
  end

end
