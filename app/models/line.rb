class Line < ApplicationRecord
  belongs_to :place
  belongs_to :user

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
