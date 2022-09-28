require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Modelos de Produtos'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
                                  
    outro_fornecedor = Supplier.create!(corporate_name: 'LG Eletronica do Brasil', brand_name: 'LG', registration_number: '01166372000236',
                                        full_address: 'Avenida Doutor Chucri Zaidan, 940', city: 'São Paulo', state: 'SP', phone: '1140027052', email: 'contato@lg.com')
               
    #Act
    login_as(user)
    visit root_url
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Largura', with: 90
    fill_in 'Altura', with: 60
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV40-SAMS-XPTO-12345'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'TV 40 polegadas'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV40-SAMS-XPTO-12345'
    expect(page).to have_content 'Dimensão: 60cm x 90cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
  end

  it 'e deve preencher todos os campos' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: nil
    fill_in 'Largura', with: nil
    fill_in 'Altura', with: nil
    fill_in 'Profundidade', with: nil
    fill_in 'SKU', with: ''
    select '', from: 'Fornecedor'
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto.'
  end
end