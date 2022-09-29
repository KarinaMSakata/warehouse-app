require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        usuario = User.new(email: 'maria@email.com', password:'password', name: '')
        
        #Act
        result = usuario.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when email is empty' do
        #Arrange
        usuario = User.new(email: '', password:'password', name: 'Maria')
        
        #Act
        result = usuario.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when password is empty' do
        #Arrange
        usuario = User.new(email: 'maria@email.com', password:'', name: 'Maria')
        
        #Act
        result = usuario.valid?

        #Assert
        expect(result).to eq false
      end
    end
  end   

  describe '#description' do
    it 'exibe o nome e o email' do
      #Arrange
      u = User.new(name: 'Julia Almeida', email:'julia@gmail.com')
      
      #Act
      result = u.description

      #Assert
      expect(result).to eq "Julia Almeida | julia@gmail.com"

    end
  end
end
