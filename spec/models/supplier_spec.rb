require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando a razão social está vazia' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o nome fantasia está vazio' do
        supplier = Supplier.new(corporate_name: 'Samsung do Brasil', brand_name: '', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o CNPJ está vazio' do
        supplier = Supplier.new(corporate_name: 'Samsung do Brasil', brand_name: 'Samsung', registration_number: '',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
        expect(supplier.valid?).to eq false
      end

      it 'falso quando o email está vazio' do
        supplier = Supplier.new(corporate_name: 'Samsung do Brasil', brand_name: 'Samsung', registration_number: '00280273000137',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: '')
        expect(supplier.valid?).to eq false
      end  
    end

    context 'uniqueness' do
      it 'falso quando o CNPJ já estiver em uso' do
        first_supplier = Supplier.create(corporate_name: 'Samsung do Brasil', brand_name: 'Samsung', registration_number: '00280273000137',
                                         full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        second_supplier = Supplier.new(corporate_name: 'LG Eletronica do Brasil', brand_name: 'LG', registration_number: '00280273000137',
                                       full_address: 'Avenida Doutor Chucri Zaidan, 940', city: 'São Paulo', state: 'SP', phone: '1140027052', email: 'contato@lg.com')
                   
        expect(second_supplier.valid?).to eq false
      end
    end 

    context 'length' do
      it 'falso quando o CNPJ não contém 14 numeros' do
        supplier = Supplier.new(corporate_name: 'Samsung do Brasil', brand_name: 'Samsung', registration_number: '12345678910',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
        expect(supplier.valid?).to eq false
      end
    end

    context 'numericality' do
      it 'falso quando o CNPJ não contém apenas numeros' do
        supplier = Supplier.new(corporate_name: 'Samsung do Brasil', brand_name: 'Samsung', registration_number: '12.345.678/0001-91',
                                full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
        expect(supplier.valid?).to eq false
      end
    end
  end

  describe '#full_description' do 
    it 'exibe o nome fantasia e a razão social' do
      #Arrange
      s = Supplier.new(brand_name: 'Americanas', corporate_name: 'B2W do Brasil LTDA')

      #Act
      result = s.full_description

      #Assert
      expect(result).to eq 'Americanas | B2W do Brasil LTDA'
    end

  end
end 
