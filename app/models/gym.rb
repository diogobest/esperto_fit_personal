class Gym
  attr_reader :id, :name, :open_hour, :close_hour,
              :working_days, :address, :gallery

  def initialize(**args)
    args.each do |key, value|
      instance_variable_set("@#{key.to_s}", value)
    end
  end

  def self.all
    token = LoginAcademy.sign_in
    response = EspertoAcademy.client.get do |req|
      req.url 'gyms'
      req.headers[:authorization] = token
    end
    # byebug
    return response.body[:data].map { |gym| new(gym[:attributes]) } if response.status == 200
  # rescue Faraday::ConnectionFailed
  #   [ ]
  # rescue Faraday::ParsingError
  #   [ ]
  end


  def imgs
    return ['logo_Compact_White.jpg'] unless self.gallery
    self.gallery
  end  
end
