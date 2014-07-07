require 'correios-frete'

class Calculator
  @cep_origem
  @cep_destino
  @peso
  @comprimento
  @largura
  @altura
  def initialize(cep_origem:, cep_destino:, peso:, comprimento:, largura:, altura:)
    @cep_origem  = cep_origem
    @cep_destino = cep_destino
    @peso        = peso
    @comprimento = comprimento
    @largura     = largura
    @altura      = altura
  end

  def compute()
    frete = Correios::Frete::Calculador.new(:cep_origem => @cep_origem, :cep_destino => @cep_destino, :peso => @peso, :comprimento => @comprimento, :largura => @largura, :altura => @altura)
    frete.calcular(:sedex, :pac)
  end
end