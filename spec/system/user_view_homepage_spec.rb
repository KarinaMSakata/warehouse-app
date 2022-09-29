require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit(root_path)

    #Assert
    expect(current_url).to eq(new_user_session_url)
  end 

  it 'e vê o nome da app' do
    #Arrange

    #Act
    visit(root_path)

    #Assert
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_url)

  end 

  it 'e vê os galpões cadastrados' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    #cadastrar 2 galpões: Rio e Maceió
    Warehouse.create(name: 'Rio', code: 'SDU', city:'Rio de Janeiro', area: 60_000, 
                     address: 'Av. do Porto, 1000', cep: '20000000', description: 'Galpão do Rio')
    Warehouse.create(name: 'Maceió', code:'MCZ', city:'Maceió', area: 50_000,
                     address: 'Av. Atlantica, 50', cep: '80000000', description: 'Perto do Aeroporto')
        
    #Act
    login_as(user)
    visit(root_path)

    #Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceió')
    expect(page).to have_content('50000 m2')
  end

  it 'e não exitem galpões cadastrados' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')
    
    #Act
    login_as(user)
    visit(root_path)

    #Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end

  it 'e vê a opção de Fornecedores' do
    #Arrange

    #Act
    visit root_url

    #Assert
    expect(page).to have_content 'Fornecedores'

  end
end