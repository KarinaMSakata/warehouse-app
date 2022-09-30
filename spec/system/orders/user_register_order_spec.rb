require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Registrar Pedido'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
    
    Warehouse.create!(name: 'Gapão do Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, 
                      address: 'Av. do Porto, 1000', cep: '20000000', description: 'Galpão do Rio')
      
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                 address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')
                                        
    Supplier.create!(corporate_name: 'LG Eletronica do Brasil', brand_name: 'LG', registration_number: '01166372000236',
                     full_address: 'Avenida Doutor Chucri Zaidan, 940', city: 'São Paulo', state: 'SP', phone: '1140027052', email: 'contato@lg.com')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
    allow(SecureRandom).to receive(:alphanumeric).and_return ('ABCD123456')
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Registrar Pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão Destino'
    select 'Samsung | Samsung Eletronica da Amazonia LTDA', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'
    
    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABCD123456'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung Eletronica da Amazonia LTDA'
    expect(page).to have_content 'Usuário Responsável: Maria | maria@gmail.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Galpão do Rio'
    expect(page).not_to have_content 'LG Eletronica do Brasil'
  end

  it 'e data prevista de entrega passada não é aceita' do
    #Arrange
    user = User.create!(email: 'maria@gmail.com', password:'password', name: 'Maria')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', description: 'Galpão destinado para cargas internacionais.')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
    allow(SecureRandom).to receive(:alphanumeric).and_return ('ABCD123456')
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Registrar Pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão Destino'
    select 'Samsung | Samsung Eletronica da Amazonia LTDA', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: 1.day.ago
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o pedido.'
    expect(page).to have_content 'Data Prevista de Entrega deve ser futura.'
  end
end