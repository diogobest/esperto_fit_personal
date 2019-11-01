require 'rails_helper'

feature 'api gets customer payments history' do
  before(:each) do
    auth_api
    list_gyms
    list_payments
  end

  scenario 'successfully' do
    # account = create(:account, :customer)
    unit = create(:unit)
    customer =  create(:customer,document: 22345678901,  unit: unit)
    profile = create(:profile, account: customer)
    login_as(customer, scope: :account)

    visit root_path
    click_on 'João'
    click_on 'Meus Pagamentos'

    expect(page).to have_content('2019-09-15')
    expect(page).to have_content(40.0)
  end

  scenario 'and finds nothing' do
    unit = create(:unit)
    customer =  create(:customer,document: 123123123, unit: unit)
    profile = create(:profile, account: customer)
    login_as(customer, scope: :account)

    stub_request(:get, "http://0.0.0.0:3000/api/v1/payments/123123123").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: "", headers: {})

    visit root_path
    click_on 'João'
    click_on 'Meus Pagamentos'

    expect(page).to have_content('Nenhum pagamento registrado')
    expect(page).not_to have_content('15/03/20')
    expect(page).not_to have_content('R$ 50,00')
  end
end