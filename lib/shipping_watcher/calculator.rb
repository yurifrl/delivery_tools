require 'correios-frete'
Correios::Frete.configure do |config|
  config.request_timeout = 9  # Configura o tempo de espera para 3 segundos
end

class Calculator
  attr_accessor :cep_origem, :cep_destino, :items

  def compute
    pacote = Correios::Frete::Pacote.new

    @items.each do |item|
      item = Correios::Frete::PacoteItem.new(:peso => item[:peso].to_f, :comprimento => item[:comprimento].to_f, :largura => item[:largura].to_f, :altura => item[:altura].to_f)
      pacote.adicionar_item(item)
    end
    frete = Correios::Frete::Calculador.new(:cep_origem => @cep_origem, :cep_destino => @cep_destino, :encomenda => pacote)
    frete.calcular(:sedex, :pac, :sedex_10)
  end

  def valid?
    frete = Correios::Frete::Calculador.new(:cep_origem => @cep_origem, :cep_destino => @cep_destino)
    frete.calcular(:sedex, :pac, :sedex_10)
  end
end