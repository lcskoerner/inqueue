class Line < ApplicationRecord
  belongs_to :place
  belongs_to :user

  scope :active, -> { where(active: true) }
end
