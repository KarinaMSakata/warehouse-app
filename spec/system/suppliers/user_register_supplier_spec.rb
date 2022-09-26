require 'rails_helper'
describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela de fornecedores' do 
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    #Assert
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
  end

  it 'com sucesso' do
    #Arrange

    #Act
    visit root_url
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'Samsung Eletronica da Amazonia LTDA'
    fill_in 'Nome Fantasia', with: 'Samsung'
    fill_in 'CNPJ', with: '00280273000137'
    fill_in 'Endereço', with: 'Distrito Industrial, 1000'
    fill_in 'Cidade', with: 'Manaus'
    fill_in 'Estado', with: 'AM'
    fill_in 'Telefone', with: '9230853976'
    fill_in 'E-mail', with: 'contato@samsung.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Fornecedor cadastrado com sucesso.'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Samsung Eletronica da Amazonia LTDA'
    expect(page).to have_content 'CNPJ: 00.280.273/0001-37'
    expect(page).to have_content 'Endereço: Distrito Industrial, 1000 - Manaus-AM'
    expect(page).to have_content 'Telefone: (92)3085-3976'
    expect(page).to have_content 'E-mail: contato@samsung.com'    
  end

  it 'com dados incompletos' do
    #Arrange
    
    #Act
    visit root_url
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o fornecedor.'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end