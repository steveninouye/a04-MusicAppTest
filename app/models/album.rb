class Album < ApplicationRecord
  belongs_to :band
  has_many :tracks, dependent: :destroy

  # can't use presence validation with boolean field
  validates :band, :name, :year, presence: true
  validates :live, inclusion: { in: [true, false] }
  validates :name, uniqueness: { scope: :band_id }
  validates_inclusion_of :year, :in => 1900..2018

  after_initialize :set_defaults

  def set_defaults
    self.live ||= false
  end
end
