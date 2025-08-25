class Product < ApplicationRecord
  has_one_attached :photo
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0 }

  def owner?
  user_id == Current.user&.id
  end
end
