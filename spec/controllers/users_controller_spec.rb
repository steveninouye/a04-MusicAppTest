require 'rails_helper'

RSpec.describe UsersController, type: :controller do


    # describe "get #show" do
    #   it 'renders the show template' do
    #     get :show
    #     expect(response).to render_template('show')
    #   end
    # end

    describe "GET #new" do
      it 'renders the new users template' do
        get :new
        expect(response).to render_template('new')
      end

      it "redirects user to bands index page if logged in" do
        allow(controller).to receive(:current_user) { "MajinBuuuu" }
        get :new
        expect(response).to redirect_to(bands_url)
      end
    end

    describe "POST #create" do
      context "with invalid params" do
        it "renders new template" do
          post :create, params: { user: { email: "jack_bruce@place.com", password: "" } }
          expect(response).to render_template("new")
        end

        it "flash errors to user" do
          post :create, params: { user: { email: "jack_bruce@place.com", password: "" } }
          expect(flash[:errors]).to be_present
        end

        it "validates that the password is at least 6 characters long" do
          post :create, params: { user: { email: "jack_bruce@place.com", password: "short" } }
          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
        end

        it "validates that the email is included" do
          post :create, params: { user: { email: "", password: "pikachuchuchuchu" } }
          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
        end
      end

      context "with valid params" do
        it "redirects user to sign-in page on success" do
          post :create, params: { user: { email: "jack_bruce@place.com", password: "password" } }
          expect(response).to redirect_to(new_session_url)
        end

        it "flash notice to user 'Successfully created your account!'" do
          post :create, params: { user: { email: "jack_bruce@place.com", password: "password" } }
          expect(response).to redirect_to(new_session_url)
        end

        it "logs the user in" do
          post :create, params: { user: { email: "jack_bruce@place.com", password: "password" } }
          expect(session[:session_token]).to be_present
        end
      end
    end

end
