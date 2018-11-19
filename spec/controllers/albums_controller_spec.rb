require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  before(:each) do
    band = Band.create(name: 'JigglyPuff Rockstars')
    Album.create(band_id: band.id, name: "I am JigglyPuff", year: 2000)
  end

  context 'When not logged in' do

    it "should not allow user to view any routes if not logged in" do
      get :show, params: { id: 1 }
      expect(response).to redirect_to(new_session_url)
      get :new
      expect(response).to redirect_to(new_session_url)
      get :edit, params: { id: 1 }
      expect(response).to redirect_to(new_session_url)
    end

    describe 'renders a 401 when trying to send information to create' do
      before {post :create}
      it {should respond_with(401)}
    end

    describe 'renders a 401 when trying to send information to update' do
      before { get :update, params: { id: 1 } }
      it {should respond_with(401)}
    end

    describe 'renders a 401 when trying to send information to delete' do
      before { delete :destroy, params: { id: 1 } }
      it {should respond_with(401)}
    end

  end

  context 'When logged in' do
    before(:each) do
      allow(controller).to receive(:current_user) { "MajinBuuuu" }
    end

    describe "GET #show" do
      it "renders show template" do
        get :show, params: { id: 1 }
        expect(response).to render_template('show')
      end
    end

    describe "GET #new" do
      it "renders new template" do
        get :new, params: { band_id: 1}
        expect(response).to render_template('new')
      end
    end

    describe "POST #create" do
      describe 'with valid information' do
        it "saves album to databse" do
          # post :create, params: { album: { band_id: 1, name: "Barny Pebble", year: 1969 } }
          # expect(Album.last.name).to eq('Barny Pebble')
        end

        it "redirects to the album sho page"

      end
    end

  end

  #
  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
