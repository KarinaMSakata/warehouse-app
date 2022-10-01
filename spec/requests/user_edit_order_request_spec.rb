require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
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
    patch(order_url(order.id), params:{order: {supplier_id:3}})

    #Assert
    expect(response). to redirect_to root_url
  end

  it 'e não está autenticado' do
    #Arrange
    maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   
    
    order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
                            
    #Act
    patch(order_url(order.id), params:{order: {supplier_id:3}})

    #Assert
    expect(response). to redirect_to new_user_session_url
  end

end