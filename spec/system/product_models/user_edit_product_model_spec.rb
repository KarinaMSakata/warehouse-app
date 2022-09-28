require 'rails_helper'

describe 'Usuário edita um modelo de produto' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'a partir da página de detalhes' do 
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                         sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'TV 32'
    click_on 'Editar Produto'
    
    #Assert
    expect(page).to have_content 'Editar Modelo de Produto'
    expect(page).to have_field 'Nome', with: 'TV 32'
    expect(page).to have_field 'Peso', with: 8000
    expect(page).to have_field 'Largura', with: 70
    expect(page).to have_field 'Altura', with: 45
    expect(page).to have_field 'Profundidade', with: 10
    expect(page).to have_field 'SKU', with: 'TV32-SAMSU-XPTO90-12'
    expect(page).to have_select 'Fornecedor', selected: 'Samsung'

  end

  it 'com sucesso' do
    #Arrange 
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                         sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'TV 32'
    click_on 'Editar Produto'
    fill_in 'Nome', with: 'TV 32 Polegadas'
    fill_in 'Peso', with: 8500
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Produto alterado com sucesso.'
    expect(page).to have_content 'TV 32 Polegadas'
    expect(page).to have_content 'Peso: 8500g'
  end

  it 'e mantém os campos obrigatórios' do
    #Arrange 
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                         sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'TV 32'
    click_on 'Editar Produto'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: nil
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possível alterar o produto.'
  end
  
end

