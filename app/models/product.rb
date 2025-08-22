class Product < ApplicationRecord
  has_one_attached :photo
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0 }
end
