class LoginAcademy
  
  def self.sign_in 
    url = 'http://esperto_fit_academy_web_run_1:3000/employees/sign_in'
    response = Faraday.post(url, "employee"=>{"email"=>"admin@espertofit.com.br", "password"=>"123456", "remember_me"=>"1"}, "commit"=>"Entrar")
    return response.headers[:authorization]
  end

  def decode_token(response)
    token = params['Authorization'].split('Bearer ').last
    secret = ENV['DEVISE_JWT_SECRET_KEY']
    JWT.decode(token, secret, true, algorithm: 'HS256',
               verify_jti: true)[0]['jti']
  end
end