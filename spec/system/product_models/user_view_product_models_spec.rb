require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do
    #Arrange
    #Act
    visit root_url
    within ('nav') do
      click_on 'Modelos de Produtos'
    end

    #Assert
    expect(current_url).to eq new_user_session_url

  end
  it 'a partir do menu' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')
    #Act
    login_as(user)
    visit root_url
    within ('nav') do
      click_on 'Modelos de Produtos'
    end

    #Assert
    expect(current_url). to eq product_models_url
  end

  it 'com sucesso' do
      #Arrange
      user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

      fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                    full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

      ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                           sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
      ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15,
                           depth: 20, sku: 'SOU71-SAMSU-NOI77-12', supplier: fornecedor)
      #Act
      login_as(user)
      visit root_url
      within ('nav') do
        click_on 'Modelos de Produtos'
      end
      #Assert
      expect(page).to have_content 'TV 32'
      expect(page).to have_content 'TV32-SAMSU-XPTO90-12'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'SoundBar 7.1 Surround'
      expect(page).to have_content 'SOU71-SAMSU-NOI77-12'
      expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')
    #Act
    login_as(user)
    visit root_url
    click_on 'Modelos de Produtos'

    #Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'

  end
end