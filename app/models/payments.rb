class Payments
  attr_reader :cpf, :payments

  def initialize(**args)
  end

  def self.find(cpf)
    response = EspertoPayment.client.get do |req|
      req.url "payments/#{cpf}"
    end
    return response.body if response.status == 200

    # []  
  rescue Faraday::ConnectionFailed
    # []
  rescue Faraday::ParsingError
    # [] 
  end

end
