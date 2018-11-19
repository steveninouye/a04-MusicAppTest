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
      before { post :create }
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
      it "renders new temp" do
        get :new, params: { band_id: 1 }
        expect(response).to render_template('new')
      end
    end

    describe "POST #create" do
      describe 'with valid information' do
        it "saves album to databse" do
          post :create, params: { album: { band_id: 1, name: "Barny Pebble", year: 1969 } }
          expect(Album.last.name).to eq('Barny Pebble')
        end

        it "redirects to the album show page" do
          post :create, params: { album: { band_id: 1, name: "Barny Pebble", year: 1969 } }
          expect(response).to redirect_to(album_url(Album.last))
        end

        it "should flash notices" do
          post :create, params: { album: { band_id: 1, name: "Barny Pebble", year: 1969 } }
          expect(flash[:notices]).to be_present
        end
      end

      describe 'with invalid information' do
        it 'renders new template' do
          post :create, params: { album: { band_id: 1, name: "Barny Pebble" } }
          expect(response).to render_template('new')
        end

        it 'flash errors' do
          post :create, params: { album: { band_id: 1, name: "Barny Pebble" } }
          expect(flash[:errors]).to be_present
        end
      end
    end

    describe "GET #edit" do
      it 'renders edit template' do
        get :edit, params: { id: 1 }
        expect(response).to render_template('edit')
      end
    end

    describe "PATCH #update" do
      describe 'with valid information' do
        it "updates the album in databse" do
          patch :update, params: { id: 1, album: { band_id: 1, name: "Bam Bam Bam", year: 1969 } }
          expect(Album.find_by(id: 1).name).to eq('Bam Bam Bam')
        end

        it "should flash notices" do
          post :create, params: { album: { band_id: 1, name: "Barny Pebble", year: 1969 } }
          expect(flash[:notices]).to be_present
        end

        it "redirects to the album show page" do
          patch :update, params: { id: 1, album: { band_id: 1, name: "Bam Bam Bam", year: 1969 } }
          expect(response).to redirect_to(album_url(Album.find_by(id: 1)))
        end
      end

      describe 'with invalid information' do
        it 'renders edit template' do
          patch :update, params: { id: 1, album: { band_id: 1, name: "", year: 1969 } }
          expect(response).to render_template('edit')
        end

        it 'flash errors' do
          patch :update, params: { id: 1, album: { band_id: 1, name: "", year: 1969 } }
          expect(flash[:errors]).to be_present
        end
      end
    end

    describe "DELETE #destroy" do
      it "should delete the album from the database" do
        delete :destroy, params: { id: 1 }
        expect(Album.find_by(id: 1)).to be nil
      end

      it "should flash notices" do
        delete :destroy, params: { id: 1 }
        expect(flash[:notices]).to be_present
      end

      it "should redirect to the band it belonged to" do
        delete :destroy, params: { id: 1 }
        expect(response).to redirect_to(band_url(Band.find_by(name: 'JigglyPuff Rockstars')))
      end
    end
  end
end
