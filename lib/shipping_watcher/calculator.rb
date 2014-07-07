require 'correios-frete'

class Calculator
  def initialize(cep_origem:, cep_destino:, peso:, comprimento:, largura:, altura:)
    @cep_origem  = cep_origem
    @cep_destino = cep_destino
    @peso        = peso
    @comprimento = comprimento
    @largura     = largura
    @altura      = altura
  end

  def compute()
    frete = Correios::Frete::Calculador.new(:cep_origem => "04094-050", :cep_destino => "90619-900", :peso => 0.3, :comprimento => 30, :largura => 15, :altura => 2)
    frete.calcular(:sedex, :pac)
  end
end