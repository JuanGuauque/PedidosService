class Recetum < ApplicationRecord
  require 'net/http'
  require 'uri'
  require 'json'

  def self.choose_receta
    num_receta = rand(1...6)
    Recetum.find(num_receta)
  end

  def self.verify_cantidades(ingredientes)
    uri = URI.parse("http://bodegaservice:3000/disponibilidad_ingredientes")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, 'Content-Type' => 'application/json')
    request.body = { ingredientes: ingredientes }.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.rest_disponibles(ingrediente, old_cantidad, new_cantidad)
    uri = URI.parse("http://bodegaservice:3000/ingrediente/#{ingrediente}")

    # Utilizar el objeto URI para configurar Net::HTTP
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri, 'Content-Type' => 'application/json')

    new_cantidad = old_cantidad - new_cantidad

    # Configurar los datos a enviar (cantidad comprada)
    request.body = { cantidad: new_cantidad }.to_json
    response = http.request(request)

    # Analizar la respuesta y devolverla
    JSON.parse(response.body)
  end

  def self.comprar(ingrediente)
    uri = URI.parse("http://plazamercadoservice:3000/comprar?ingrediente=#{ingrediente}")

    # Utilizar el objeto URI para configurar Net::HTTP
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')

    response = http.request(request)

    # Analizar la respuesta y devolverla
    JSON.parse(response.body)
  end

  def self.compare_cantidades(id_receta, cantidades_disp)
    receta = Recetum.find(id_receta)
    ingredientes = receta.ingredientes.split(/\s*,\s*/)
    receta.cantidades.split(/\s*,\s*/).each_with_index do |cantidad, _index|
      cantidad_d = cantidades_disp[ingredientes[_index]]['cantidad'].to_i rescue 0
      cantidad = cantidad.to_i
      if cantidad <= cantidad_d
        Recetum.rest_disponibles(ingredientes[_index], cantidad_d, cantidad)
      else
        comprar = Recetum.comprar(ingredientes[_index])
        if comprar['mensaje'] == 'Vuelva otro día.'
          comprar = Recetum.comprar(ingredientes[_index])
        else 
          Recetum.rest_disponibles(ingredientes[_index], cantidad_d, cantidad)
        end
      end
    end
  end
end
