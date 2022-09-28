require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(current_url).to eq new_user_session_url
  end
  
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                     full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'

    #Assert
    expect(page).to have_content 'Samsung Eletronica da Amazonia LTDA'
    expect(page).to have_content 'CNPJ: 00.280.273/0001-37'
    expect(page).to have_content 'Endereço: Distrito Industrial, 1000 - Manaus-AM'
    expect(page).to have_content 'Telefone: (92)3085-3976 '
    expect(page).to have_content 'E-mail: contato@samsung.com'
  end

  it 'e volta para tela inicial' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                     full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
                     #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Voltar'

    #Assert
    expect(current_url).to eq root_url
  end
end

