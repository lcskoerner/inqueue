class Place < ApplicationRecord
  has_many :lines
  geocoded_by :address
  after_validation :geocode if :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
    using: {
      tsearch: { prefix: true }
    }

  scope :active_line, -> { joins(:lines).where(lines: { active: true }) }
end
