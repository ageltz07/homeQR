class Item < ApplicationRecord
  belongs_to :event
  enum status: {
    full: "full",
    low: "low",
    none: "none"
  }, _default: "full"

  validates :name, presence: true
end
