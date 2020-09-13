class Line < ApplicationRecord
  belongs_to :place
  has_many :lines
end
