require 'rails_helper'

RSpec.describe Album, type: :model do
  subject(:album) {Album.create(name: "Teapot Teapot Teapot", year: 2000, band_id: Band.last.id)}

  before(:each) do
    band = Band.create(name: "I'm A Little Teapot")
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:year) }
  it { should validate_uniqueness_of(:name).scoped_to(:band_id)}
  it { should validate_inclusion_of(:year).in_range(1900..2018)}
  it { should have_many(:tracks) }
  it { should belong_to(:band) }

  it do should allow_values(true, false).
    for(:live)
  end

  it 'should set the default value of live to false' do
    expect(album.live).to be false
  end
end
