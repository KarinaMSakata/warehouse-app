require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'', weight: 8000, width: 70, height: 45, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

        it 'false when weight is empty' do
          #Arrange
          fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                        full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
          pm = ProductModel.new(name:'TV 32', weight: nil, width: 70, height: 45, depth: 10,
                                sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
  
          #Act
          result = pm.valid?
  
          #Assert
          expect(result).to eq false
        end

        it 'false when width is empty' do
          #Arrange
          fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                        full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
          pm = ProductModel.new(name:'TV 32', weight: 8000, width: nil, height: 45, depth: 10,
                                sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
  
          #Act
          result = pm.valid?
  
          #Assert
          expect(result).to eq false
        end

        it 'false when height is empty' do
          #Arrange
          fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                        full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
          pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: nil, depth: 10,
                                sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
  
          #Act
          result = pm.valid?
  
          #Assert
          expect(result).to eq false
        end

        it 'false when depth is empty' do
          #Arrange
          fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                        full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
          pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: nil,
                                sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
  
          #Act
          result = pm.valid?
  
          #Assert
          expect(result).to eq false
        end

        it 'false when sku is empty' do
          #Arrange
          fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                        full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
          pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                sku: '', supplier: fornecedor)
  
          #Act
          result = pm.valid?
  
          #Assert
          expect(result).to eq false
        end

        it 'false when supplier is empty' do
          #Arrange
          fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                        full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')
  
          pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                sku: 'TV32-SAMSU-XPTO90-12', supplier: nil)
  
          #Act
          result = pm.valid?
  
          #Assert
          expect(result).to eq false
        end
    end

    context 'length' do
      it 'false when sku do not 20 characters' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                              sku: 'TV32', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end
    end

    context 'uniqueness' do
      it 'false when sku is already in use' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        first_pm = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                        sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        second_pm = ProductModel.new(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15,
                                         depth: 20, sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
      
      #Act
      result = second_pm.valid?

      #Assert
      expect(result).to eq false
      end

    end

    context 'numericality' do
      it 'false when weight is equal 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 0, width: 70, height: 45, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end
            
      it 'false when weight is less than 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: -50, width: 70, height: 45, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end
      
      it 'false when width is equal 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 0, height: 45, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when width is less than 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: -80, height: 45, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end
      
      it 'false when height is equal 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 0, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when height is less than 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: -90, depth: 10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end
      
      it 'false when depth is equal 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 0,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end

      it 'false when depth is less than 0' do
        #Arrange
        fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                      full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: -10,
                              sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)

        #Act
        result = pm.valid?
        #Assert
        expect(result).to eq false
      end

    end
  end
end
