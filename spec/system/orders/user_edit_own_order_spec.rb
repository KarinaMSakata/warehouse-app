require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    #Act
    visit edit_order_url(order.id)
    
    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'com sucesso' do
    #Arrange
    maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    second_supplier = Supplier.create!(corporate_name: 'LG Eletronica do Brasil', brand_name: 'LG', registration_number: '01166372000236',
                                  full_address: 'Avenida Doutor Chucri Zaidan, 940', city: 'São Paulo', state: 'SP', phone: '1140027052', email: 'contato@lg.com')
    order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
   
    #Act
    login_as(maria)
    visit root_url
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '22/10/2022'
    select 'LG | LG Eletronica do Brasil', from: 'Fornecedor'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: LG Eletronica do Brasil'
    expect(page).to have_content 'Data Prevista de Entrega: 22/10/2022' 
  end

  
  it 'caso seja o responsável' do
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
    visit edit_order_url(order.id)

    #Assert
    expect(current_url).to eq root_url
    expect(page).to have_content 'Você não possui acesso a este pedido'
    
  end
end