require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')
    #Act
    visit root_url
    click_on 'Fazer Login'
    fill_in 'E-mail', with: 'karina@gmail.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do 
      expect(page).to_not have_link 'Fazer Login'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Karina | karina@gmail.com'
    end
  end

    it 'e faz logout' do
      #Arrange
      User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

      #Act

      visit root_url
      click_on 'Fazer Login'
      fill_in 'E-mail', with: 'karina@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
      click_on 'Sair'

      #Assert
      expect(page).to have_link 'Fazer Login'
      expect(page).to_not have_button 'Sair'
      expect(page).to_not have_content 'karina@gmail.com'
    end
end