require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
    it 'e pedido foi entregue' do
    #Arrange
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
 
    order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
    #Act
    login_as(carla)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content("Situação do Pedido: Entregue")
    end

    it 'e pedido foi cancelado' do
    #Arrange
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
 
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
 
    order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
    #Act
    login_as(carla)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content'Situação do Pedido: Cancelado'
    end
end