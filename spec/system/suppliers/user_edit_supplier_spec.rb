require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(current_url).to eq new_user_session_url
  end
  
  it 'a partir da página de detalhes' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                     full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar Fornecedor'

    #Assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field 'Razão Social', with: 'Samsung Eletronica da Amazonia LTDA'
    expect(page).to have_field 'Nome Fantasia', with: 'Samsung'
    expect(page).to have_field 'CNPJ', with: '00280273000137'
    expect(page).to have_field 'Endereço', with: 'Distrito Industrial, 1000'
    expect(page).to have_field 'Cidade', with: 'Manaus'
    expect(page).to have_field 'Estado', with: 'AM'
    expect(page).to have_field 'Telefone', with: '9230853976'
    expect(page).to have_field 'E-mail', with: 'contato@samsung.com'
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                     full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar Fornecedor'
    fill_in 'Nome Fantasia', with: 'Samsung do Brasil'
    fill_in 'Endereço', with: 'Av das Empresas, 2000'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Fornecedor alterado com sucesso'
    expect(page).to have_content 'Samsung do Brasil'
    expect(page).to have_content 'Endereço: Av das Empresas, 2000'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'SP'
  end
  
  it 'e mantém os campos obrigatórios' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                     full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possível atualizar o fornecedor.'
  end
end
