class Plan
  attr_reader :id, :name, :price, :minimum_permanence

  def initialize(**args)
    args.each do |key, value|
      instance_variable_set("@#{key.to_s}", value)
    end
  end

  def self.gym_plans(gym_id)
    token = LoginAcademy.sign_in
    response = EspertoAcademy.client.get do |req|
      req.url "gyms/#{gym_id}/plans"
      req.headers[:authorization] = token
    end
    return [] unless response.status == 200 

    response.body[:data].map { |plan| new(plan[:attributes]) }

  rescue Faraday::ConnectionFailed
    # [] 
  rescue Faraday::ParsingError
    # [] 
  end


end
