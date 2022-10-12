require 'rails_helper'

describe 'Usuáro informa novo status de pedido' do
  it 'e pedido foi entregue' do
    #Arrange 
    maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)

    order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
   
    OrderItem.create!(order: order, product_model: product, quantity: 5)
    #Act
    login_as(maria)
    visit root_url
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    #Assert
    expect(current_url).to eq order_url(order.id)
    expect(page).to have_content "Status: Entregue"
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 5
    expect(StockProduct.where(product_model: product, warehouse: warehouse).count).to eq 5
  end

  it 'e pedido foi cancelado' do
    #Arrange 
    maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90-12', supplier: supplier)

    order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    OrderItem.create!(order: order, product_model: product, quantity: 5)
   
    #Act
    login_as(maria)
    visit root_url
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    #Assert
    expect(current_url).to eq order_url(order.id)
    expect(page).to have_content "Status: Cancelado"
    expect(StockProduct.count).to eq 0
  end

end