class StationAdmin < Admin

  ## Validations
  validates :station_id, presence: true

  ## Associations
  belongs_to :station


end
