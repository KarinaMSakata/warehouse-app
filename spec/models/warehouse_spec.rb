require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        warehouse = Warehouse.new(name: '', code: 'RIO', address:'Endereço',
                                  cep: '25000-000', city: 'Rio', area:1000,
                                  description:'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when code is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: '', address:'Endereço',
                                  cep: '25000-000', city: 'Rio', area:1000,
                                  description:'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when address is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address:'',
                                  cep: '25000-000', city: 'Rio', area:1000,
                                  description:'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when cep is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address:'Endereço',
                                  cep: '', city: 'Rio', area:1000,
                                  description:'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when city is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address:'Endereço',
                                  cep: '25000-000', city: '', area:1000,
                                  description:'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when area is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address:'Endereço',
                                  cep: '25000-000', city: 'Rio', area:'',
                                  description:'Alguma descrição')
        expect(warehouse.valid?).to eq false
      end

      it 'false when description is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address:'Endereço',
                                  cep: '25000-000', city: 'Rio', area:1000,
                                  description:'')
        expect(warehouse.valid?).to eq false
      end
    end 
    context 'uniqueness' do

      it 'false when code is already in use' do
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address:'Endereço',
                                           cep: '25000-000', city: 'Rio', area:1000,
                                           description:'Alguma descrição')

        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address:'Avenida',
                                          cep: '35000-000', city: 'Niteroi', area:1500,
                                          description:'Outra descrição')
        
        expect(second_warehouse.valid?).to eq false
      end

      it 'false when name is already in use' do
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address:'Endereço',
                                           cep: '25000-000', city: 'Rio', area:1000,
                                           description:'Alguma descrição')

        second_warehouse = Warehouse.new(name: 'Rio', code: 'SDU', address:'Avenida',
                                          cep: '35000-000', city: 'Niteroi', area:1500,
                                          description:'Outra descrição')
        
        expect(second_warehouse.valid?).to eq false
      end
    end
  end
end
