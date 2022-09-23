class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: {maximum: 3}
  validates :cep, length: {minimum: 8, maximum: 8}  
end
