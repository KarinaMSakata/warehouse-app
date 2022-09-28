require 'rails_helper'

describe 'Usuário vê detalhes do modelo de um produto' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'

    #Assert
    expect(current_url).to eq new_user_session_url
  end
  
  it 'dentro da página de fornecedores' do
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
        
    #Assert
    expect(page).to have_content 'Samsung Eletronica da Amazonia LTDA'
    expect(page).to have_content 'CNPJ: 00.280.273/0001-37'
    expect(page).to have_content 'Endereço: Distrito Industrial, 1000 - Manaus-AM'
    expect(page).to have_content 'Telefone: (92)3085-3976 '
    expect(page).to have_content 'E-mail: contato@samsung.com'
    expect(page).to have_content 'Produtos/Estoque'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90-12'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'e a partir da tela do fornecedor' do
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

    #Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90-12'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end
end