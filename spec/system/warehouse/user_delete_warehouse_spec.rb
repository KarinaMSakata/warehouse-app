require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do 
    #Arrange
    Warehouse.create!(name: 'Cuiabá', code: 'CWB', area:10000, cep:'56000000',
                      city: 'Cuiabá', description: 'Galpão no centro do país',
                      address: 'Av. dos Jacarés, 1000')

    #Act
    visit root_url
    click_on 'Cuiabá'
    click_on 'Remover'

    #Assert
    expect(current_url).to eq root_url
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga os demais' do
    #Arrange
    first_warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', area:10000, cep:'56000000',
                                        city: 'Cuiabá', description: 'Galpão no centro do país',
                                        address: 'Av. dos Jacarés, 1000')

    first_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area:20000, cep:'46000000',
                                        city: 'Belo Horizonte', description: 'Galpão para cargas mineiras',
                                        address: 'Av. dos Tiradentes, 20')                                  
    #Act
    visit root_url
    click_on 'Cuiabá'
    click_on 'Remover'

    #Assert
    expect(current_url).to eq root_url
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'
  

  end
end