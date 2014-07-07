require 'correios-frete'

class Calculator
  @cep_origem
  @cep_destino
  @peso
  @comprimento
  @largura
  @altura

  def compute()
    frete = Correios::Frete::Calculador.new(:cep_origem => @cep_origem, :cep_destino => @cep_destino, :peso => @peso, :comprimento => @comprimento, :largura => @largura, :altura => @altura)
    p frete
    frete.calcular(:sedex, :pac, :sedex_10)
  end
end