require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do 
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
      
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 

      product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)
                                      
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      #Assert
      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do 
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
      
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      second_warehouse = Warehouse.create!(name: 'Gapão do Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, 
                                           address: 'Av. do Porto, 1000', cep: '20000000', description: 'Galpão do Rio')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 

      product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)
      
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      
      original_serial_number = stock_product.serial_number
      
      #Act
      stock_product.update(warehouse: second_warehouse)
 
      #Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end

  describe "#available?" do
    it 'true se não tiver destino' do 
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 

      product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)
                                      
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      #Assert
      expect(stock_product.available?).to be true

    end

    it 'false se tiver destino' do 
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 

      product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)
                                      
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      stock_product.create_stock_product_destination!(recipient: "João", address: "Rua do João, 10")

      #Assert
      expect(stock_product.available?).to be false
    end
  end
  end

end
