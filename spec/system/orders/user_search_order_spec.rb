require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')
    
    #Act
    login_as(user)
    visit root_url
    
    #Assert
    within ('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end
    
    it 'e deve estar autenticado' do
      #Arrange
      #Act
      visit root_url

      #Assert
      within ('header nav') do
        expect(page).not_to have_field 'Buscar Pedido'
        expect(page).not_to have_button 'Buscar'
      end
    end

    it 'e encontra um pedido' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')                               

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      #Act
      login_as(user)
      visit root_url
      fill_in 'Buscar Pedido', with: order.code
      click_on 'Buscar'

      #Assert
      expect(page).to have_content "Resultados da Busca por: #{order.code}"
      expect(page).to have_content '1 pedido encontrado'
      expect(page).to have_content "Código #{order.code}"
      expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
      expect(page).to have_content 'Fornecedor: Samsung Eletronica da Amazonia LTDA'
    end

    
    it 'e encontra multiplos pedidos' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                          address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      second_warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000,
                                          address: 'Avenida do Porto, 80', cep: '25000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   
      
      allow(SecureRandom).to receive(:alphanumeric).and_return ('GRU12345678')
      first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      allow(SecureRandom).to receive(:alphanumeric).and_return ('GRU9876543')
      second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      allow(SecureRandom).to receive(:alphanumeric).and_return ('SDU0000000')
      third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      #Act
      login_as(user)
      visit root_url
      fill_in 'Buscar Pedido', with: 'GRU'
      click_on 'Buscar'

      #Assert
      expect(page).to have_content '2 pedidos encontrados'
      expect(page).to have_content 'GRU12345678'
      expect(page).to have_content 'GRU9876543'
      expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
      expect(page).not_to have_content 'SDU0000000'
      expect(page).not_to have_content 'Galpão Destino: SDU | Aeroporto Rio' 
    end
    
    it 'e vê detalhes de um pedido' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                          address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   
      
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
                               
      #Act
      login_as(user)
      visit root_url
      click_on 'Meus Pedidos'
      click_on order.code

      #Assert
      expect(page).to have_content 'Detalhes do Pedido'
      expect(page).to have_content order.code
      expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
      expect(page).to have_content 'Fornecedor: Samsung Eletronica da Amazonia LTDA'
      formatted_date = I18n.localize(1.day.from_now.to_date)
      expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
    end

    it 'e vê detalhes de um pedido' do
      #Arrange
      user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                          address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   
      
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
                               
      #Act
      login_as(user)
      visit root_url
      click_on 'Meus Pedidos'
      click_on order.code

      #Assert
      expect(page).to have_content 'Detalhes do Pedido'
      expect(page).to have_content order.code
      expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
      expect(page).to have_content 'Fornecedor: Samsung Eletronica da Amazonia LTDA'
      formatted_date = I18n.localize(1.day.from_now.to_date)
      expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
    end

    it 'e não visita pedidos de outros usuários' do
      #Arrange
      maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

      joao = User.create!(email: 'joao@gmail.com', password:'password', name: 'João')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                          address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

      supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   
      
      order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
                               
      #Act
      login_as(joao)
      visit order_url(order.id)

      #Assert
      expect(current_url).not_to eq order_url(order.id)
      expect(current_url).to eq root_url
      expect(page).to have_content 'Você não possui acesso a este pedido'
      
    end
end