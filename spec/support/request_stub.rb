module RequestStub
  def cpf_status
    filename = 'cpf_status.json'
    url      = 'http://academy.com.br/api/v1/clients/consult_cpf/99999999999'
    json_response = File.read(Rails.root.join('spec', 'support', "#{filename}"))

    stub_request(:get, url)
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
           }
      )
      .to_return(status: 302, body: json_response, headers:  {'Content-Type': 'application/json'})
  end

  def cpf_status_inactive
    filename = 'cpf_inactive.json'
    url      = 'http://academy.com.br/api/v1/clients/consult_cpf/88888888888'
    json_response = File.read(Rails.root.join('spec', 'support', "#{filename}"))

    stub_request(:get, url)
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
           }
      )
      .to_return(status: 302, body: json_response, headers:  {'Content-Type': 'application/json'})
  end

  def cpf_status_empty
    filename = 'cpf_status.json'
    url      = 'http://academy.com.br/api/v1/clients/consult_cpf/12345678908'
    json_response = File.read(Rails.root.join('spec', 'support', "#{filename}"))

    stub_request(:get, url)
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
           }
      )
      .to_return(status: 404, body: 'Não encontrado' , headers:  {})
  end

  def list_gyms
    filename = 'gyms.json'
    url      = 'http://academy.com.br/api/v1/gyms'
    json_response = JSON.parse(
      File.read(Rails.root.join('spec', 'support', "#{filename}")
    ), symbolize_names: true)
    stub_request(:get, url).
      to_return(status: 200, body: json_response)
  end

  def list_payments
    filename = 'payments.json'
    url      = 'http://0.0.0.0:5000/api/v1/payments/41370123850'
    json_response = File.read(Rails.root.join('spec', 'support', "#{filename}"))

    stub_request(:get, url)
      .to_return(status: 200, body: json_response, headers:  {'Content-Type': 'application/json'})
  end
  def list_plans(id)
    filename = 'plans.json'
    url      = "http://academy.com.br/api/v1/gyms/#{id}/plans"
    json_response = File.read(Rails.root.join('spec', 'support', "#{filename}"))
    stub_request(:get, url).
      to_return(status: 200, body: json_response, headers: {'Content-Type': 'application/json'})
  end
  def auth_api
    stub_request(:post, "http://esperto_fit_academy_web_run_1:3000/employees/sign_in").
          with(
            body: {"commit"=>"Entrar", "employee"=>{"email"=>"admin@espertofit.com.br", "password"=>"123456"}},
            headers: {
        	  'Accept'=>'*/*',
        	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        	  'Content-Type'=>'application/x-www-form-urlencoded',
        	  'User-Agent'=>'Faraday v0.15.4'
            }).
          to_return(status: 200, body: "", headers: {})
  end
end
