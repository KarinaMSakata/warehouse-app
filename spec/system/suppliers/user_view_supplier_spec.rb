require 'rails_helper'

describe 'Usuário vê Fornecedores' do 
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(current_url).to eq new_user_session_url
  end
  
  it 'a partir do menu' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')
    
    #Act
    login_as(user)
    visit root_url
    within 'nav' do
      click_on 'Fornecedores'
    end

    #Assert
    expect(current_url).to eq suppliers_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                     full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
    
    Supplier.create!(corporate_name: 'LG Eletronica do Brasil', brand_name: 'LG', registration_number: '01166372000236',
                    full_address: 'Avenida Doutor Chucri Zaidan, 940', city: 'São Paulo', state: 'SP', phone: '1140027052', email: 'contato@lg.com')
      
      #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Manaus-AM'
    expect(page).to have_content 'LG'
    expect(page).to have_content 'São Paulo-SP'
  end

  it 'e não existem fornecedores cadastrados' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end
   
end