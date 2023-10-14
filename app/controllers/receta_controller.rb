class RecetaController < ApplicationController
  def recetas
    @recetas = Recetum.all
    recetas_hash = {}

    @recetas.each do |receta|
      recetas_hash[receta.id] = {
        nombre: receta.nombre,
        ingredientes: receta.ingredientes.split(/\s*,\s*/),
        cantidades: receta.cantidades.split(/\s*,\s*/)
      }
    end

    recetas_json = JSON.generate(recetas_hash)

    render json: recetas_json
  end

  def make_receta
    @receta = Recetum.choose_receta
    @use_ingredientes = Recetum.verify_cantidades(@receta.ingredientes)
    @compare_cantidades = Recetum.compare_cantidades(@receta.id, @use_ingredientes)
    Pedido.create!(recetum_id: @receta.id, estado: 'Preparado')
    render json: { mensaje: 'Pedido listo.' }
  end

  def pedidos
    @pedidos = Pedido.all
    pedidos_hash = {}
    @pedidos.each do |pedido|
      pedidos_hash[pedido.id] = {
        nombre: pedido.recetum.nombre,
        estado: pedido.estado,
        pedido_at: pedido.created_at
      }
    end
    pedidos_json = JSON.generate(pedidos_hash)
    render json: pedidos_json
  end
end
