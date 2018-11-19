require 'rails_helper'

RSpec.describe Track, type: :model do
  subject(:track) {Track.create(ord: 1, lyrics: "I'm a little teapot, short and stout", album_id: Album.last.id, name: "Pikachu")}

  before(:each) do
      band = Band.create(name: "I'm A Little Teapot")
      Album.create(name: "Teapot Teapot Teapot", year: 2000, band_id: band.id)
  end

  it { should validate_presence_of(:lyrics) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:ord) }
  it { should validate_uniqueness_of(:ord).scoped_to(:album_id)}

  it { should belong_to(:album) }
  it { should have_one(:band) }

  it do should allow_values(true, false).
    for(:bonus)
  end

  it 'should set the default value of live to false' do
    expect(track.bonus).to be false
  end
end
