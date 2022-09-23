class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    #1 - Recebe os dados do formulario
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address,
                                      :cep, :area)
    #2 - Cria um novo galpão no banco de dados
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      #3 - Redireciona para a pagina escolhida 
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
    else
      flash.now.notice = 'Galpão não cadastrado.'
      render 'new' 
    end
  end 
end