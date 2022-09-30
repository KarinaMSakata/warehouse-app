require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do 
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Meus Pedidos'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'e não vê outros pedidos' do
    #Arrange
    maria = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')

    joao = User.create!(email: 'joao@gmail.com', password:'password', name: 'João
    ')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')   
    
   
    first_order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    second_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    third_order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

    #Act
    login_as(maria)
    visit root_url
    click_on 'Meus Pedidos'

    #Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code 
    expect(page).to have_content third_order.code
  end

end