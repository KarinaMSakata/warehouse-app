class Warehouse < ApplicationRecord
  has_many :stock_products
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: {is: 3}
  validates :cep, length: {is: 8}  

  def full_description
    "#{code} | #{name}"
  end
end
