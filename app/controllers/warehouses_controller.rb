class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  def create
    #1 - Recebe os dados do formulario
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address,
                                      :cep, :area)
    #2 - Cria um novo galpão no banco de dados
    w = Warehouse.new(warehouse_params)
    w.save
    #3 - Redireciona para a pagina escolhida
    redirect_to root_path
  end
end