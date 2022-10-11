require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(email: 'joao@gmail.com', password:'password', name: 'João')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')
    
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    product_a = ProductModel.create!(name:'Produto A', weight: 15, width: 10, height: 20, depth: 30, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)

    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, sku: 'SOU71-SAMSU-NOI77-12', supplier: supplier)

    #Act
    login_as user
    visit root_url
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Gravar'

    #Assert
    expect(current_url).to eq order_url(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro fornecedor' do
    #Arrange
    user = User.create!(email: 'joao@gmail.com', password:'password', name: 'João')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')
    
    supplier_a = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   

    supplier_b = Supplier.create!(corporate_name: 'LG Eletronica do Brasil', brand_name: 'LG', registration_number: '01166372000236',
                                  full_address: 'Avenida Doutor Chucri Zaidan, 940', city: 'São Paulo', state: 'SP', phone: '1140027052', email: 'contato@lg.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, estimated_delivery_date: 1.day.from_now, status: :pending)

    product_a = ProductModel.create!(name:'Produto A', weight: 15, width: 10, height: 20, depth: 30, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier_a)

    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, sku: 'SOU71-SAMSU-NOI77-12', supplier: supplier_b)
    
    #Act
    login_as user
    visit root_url
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    #Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'

  end
end