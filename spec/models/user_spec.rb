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
end
