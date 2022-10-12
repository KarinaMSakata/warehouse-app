require 'rails_helper'
describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    #Arrange
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                      description: 'Galpão destinado para cargas internacionais.')
   
    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    order = Order.create!(user: user, supplier: fornecedor, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    
    produto_tv = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
    
    produto_soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15,
                                            depth: 20, sku: 'SOU71-SAMSU-NOI77-12', supplier: fornecedor)

    produto_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 9,
                                            depth: 20, sku: 'NOTEI5-SAMSU-TLI9999', supplier: fornecedor)
    
    3.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: produto_tv)}    
    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: produto_notebook)}
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Aeroporto SP'
  
    #Assert
      within("section#stock_products") do
        expect(page).to have_content 'Itens em Estoque'
        expect(page).to have_content '3 x TV32-SAMSU-XPTO90-12'
        expect(page).to have_content '2 x NOTEI5-SAMSU-TLI9999'
        expect(page).not_to have_content 'SOU71-SAMSU-NOI77-12'
      end
    end

  it 'e dá baixa em um item' do 
    user = User.create!(email: 'karina@gmail.com', password:'password', name: 'Karina')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                      description: 'Galpão destinado para cargas internacionais.')
   
    fornecedor = Supplier.create!(corporate_name: 'Samsung Eletronica da Amazonia LTDA', brand_name: 'Samsung', registration_number: '00280273000137',
                                  full_address: 'Distrito Industrial, 1000', city: 'Manaus', state: 'AM', phone: '9230853976', email: 'contato@samsung.com')

    order = Order.create!(user: user, supplier: fornecedor, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    
    produto_tv = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90-12', supplier: fornecedor)
    
    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: produto_tv)}    
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Aeroporto SP'
    select 'TV32-SAMSU-XPTO90-12', from: 'Item para saída'
    fill_in 'Destinatário', with: "Maria Ferreira"
    fill_in 'Endereço Destino', with: "Rua das Palmeiras, 100 - Campinas - São Paulo"
    click_on 'Confirmar Retirada'

    #Assert
    expect(current_url).to eq warehouse_url(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso.'
    expect(page).to have_content '1 x TV32-SAMSU-XPTO90-1'
  end
end