require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do 
    it 'pedido deve ter um código' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
      
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.new(user: user, warehouse: warehouse, 
                        supplier: supplier, estimated_delivery_date: '2022-10-30')
      
      #Act 
      result = order.valid?
    
      #Assert
      expect(result).to eq true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      #Arrange
      order = Order.new(estimated_delivery_date: '')
      
      #Act 
      order.valid?
      result = order.errors.include? :estimated_delivery_date
    
      #Assert
      expect(result).to be true
    end

    it 'galpão deve ser obrigatório' do
      #Arrange
      order = Order.new(warehouse: nil)
      
      #Act 
      order.valid?
      result = order.errors.include? :warehouse
    
      #Assert
      expect(result).to be true
    end

    it 'fornecedor deve ser obrigatório' do
      #Arrange
      order = Order.new(supplier: nil)
      
      #Act 
      order.valid?
      result = order.errors.include? :supplier
    
      #Assert
      expect(result).to be true
    end


    it 'data estimada de entrega não pode ser passada' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      
      #Act 
      order.valid?
         
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include (' deve ser futura.')
    end

    it 'data estimada de entrega não pode ser hoje' do
      #Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      
      #Act 
      order.valid?
    
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include (' deve ser futura.')
    end

    it 'data estimada de entrega deve ser igual ou maior que amanhã' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      
      #Act 
      order.valid?
    
      #Assert
      expect(order.errors.include? :estimated_delivery_date).to be false
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
      
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.new(user: user, warehouse: warehouse, 
                        supplier: supplier, estimated_delivery_date: '2022-10-30')
      
      #Act
      order.save!
      result = order.code

      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e o código é único' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
      
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      first_order = Order.create!(user: user, warehouse: warehouse, 
                                  supplier: supplier, estimated_delivery_date: '2022-10-30')

      second_order = Order.new(user: user, warehouse: warehouse, 
                               supplier: supplier, estimated_delivery_date: '2022-11-15')
      #Act
      second_order.save!
      result = second_order.code
      #Assert
      expect(result).not_to eq first_order.code
  
    end
  end
end
