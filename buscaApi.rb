require 'rest-client'
require 'json'

url_marcas = 'https://parallelum.com.br/fipe/api/v1/carros/marcas'


begin
    response_marcas = RestClient.get(url_marcas)
    response_marcas.headers[:content_type] =~ /json/
    data_marcas = JSON.parse(response_marcas.body)



    puts "----------------Todas as marcas existentes----------------"
    data_marcas.each do |marcas|
        puts "Código: #{marcas['codigo']} | Marca: #{marcas['nome']}"
    end
    puts "-------------------------------------------------------------"

    puts "-------------------------------------------------------------"
    puts "Escolha um Código de veículo para buscar os modelos:"
    user_input_codigo = gets.chomp



    # Buscando modelos
    urlModelos = "https://parallelum.com.br/fipe/api/v1/carros/marcas/#{user_input_codigo}/modelos"

    response_modelos = RestClient.get(urlModelos)
    response_modelos.headers[:content_type] =~ /json/

    data_modelos = JSON.parse(response_modelos.body)

    data_modelos['modelos'].each do |modelo|
        puts "Código: #{modelo['codigo']} | Marca: #{modelo['nome']}"
    end

    puts "-------------------------------------------------------------"
    puts "Escolha um Código de modelo de Veciulo para buscar o Ano:"
    user_input_codigo_modelo = gets.chomp


    #https://parallelum.com.br/fipe/api/v1/carros/marcas/55/modelos/2164/anos
    urlAnos = "https://parallelum.com.br/fipe/api/v1/carros/marcas/#{user_input_codigo}/modelos/#{user_input_codigo_modelo}/anos"

    response_anos = RestClient.get(urlAnos)
    response_anos.headers[:content_type] =~ /json/

    data_veiculos = JSON.parse(response_anos.body)

    puts "----------------Codigo e Congiuração do veiculo----------------"
    data_veiculos.each do |anos|
        puts "Código: #{anos['codigo']} | Ano e Combustivel: #{anos['nome']}"
        
    end
    puts "---------------------------------------------------------------"

    puts "-------------------------------------------------------------"
    puts "Escolha um Código de modelo de Veciulo para buscar a FIPE:"
    user_input_codigo_ano = gets.chomp

    urlVeiculos = "https://parallelum.com.br/fipe/api/v1/carros/marcas/#{user_input_codigo}/modelos/#{user_input_codigo_modelo}/anos/#{user_input_codigo_ano}"
    response_veic = RestClient.get(urlVeiculos)
    response_veic.headers[:content_type] =~ /json/
    data_vec = JSON.parse(response_veic.body)

    anoModelo = data_vec["AnoModelo"]
    valorVeiculo = data_vec["Valor"]
    marcaVeiculo = data_vec["Marca"]
    combustivelVeiculo = data_vec["Combustivel"]
    mesReferencia = data_vec["MesReferencia"]
    puts "----------------Veiculo encontrado------------------------------"
    puts "Ano modelo: #{anoModelo}"
    puts "Valor do veiculo: #{valorVeiculo}"
    puts "Marca do Veiculo: #{marcaVeiculo}"    
    puts "Tipo de combustivel do veiculo: #{combustivelVeiculo}"
    puts "Mes e ano de referencia da FIPE: #{mesReferencia}"
    puts "-----------------------------------------------------------------"

rescue RestClient::ExceptionWithResponse => e
    puts "Erro na solicitação: #{e.response.code}"
rescue RestClient::Exception, StandardError => e
    puts "Erro: #{e.message}"
end