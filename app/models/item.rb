class Item < ApplicationRecord
  belongs_to :event
  enum :status, {
    full: "full",
    low: "low",
    out: "out"
  }

  enum :category, {
    food: "food",
    drink_A: "Alcohol",
    drink_N: "Non-Alcohol",
    dessert: "dessert"
  }

  validates :name, :status, :category, presence: true
end
