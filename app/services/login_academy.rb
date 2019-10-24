class LoginAcademy

  def self.sign_in 
    url = 'http://esperto_fit_academy_web_run_1:3000/employees/sign_in'
    response = Faraday.post(url, "employee"=>{"email"=>ENV['LOGIN'], "password"=>ENV['PASSWORD']}, "commit"=>"Entrar")
    return response.headers[:authorization]
  end
  
end