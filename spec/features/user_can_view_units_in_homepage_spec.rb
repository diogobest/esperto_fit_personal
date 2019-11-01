require 'rails_helper'

feature 'Customer view all available units' do
  before(:each) {
    auth_api
    list_gyms
  }
  scenario 'Successfully' do
    #Arrange
    customer = create(:customer, email: 'teste@email.com', password: '123456')
    profile = create(:profile, account: customer, first_name: 'Joao')
    
    #Act
    login_as(customer, scope: :account)
    visit root_path
    #Assert
    expect(page).to have_content('Academia 01')
    expect(page).to have_content('Academia 02')
    expect(page).to have_content('Academia 03')
  end

  scenario 'and can sign up to a unity' do
    unit = create(:unit, name: 'Paulista')
    other_unit = create(:unit, name: 'Brigadeiro')
    customer = create(:customer, email: 'teste@email.com', password: '123456')
    profile = create(:profile, account: customer, first_name: 'Joao')
    login_as(customer, scope: :account)

    visit root_path
    within("div.academia-#{unit.id}") do
      click_on 'Cadastrar Nesta Unidade'
    end
    within("div.academia-#{unit.id}") do
      expect(page).to have_content('Está é a sua Unidade')
      expect(page).not_to have_link('Cadastrar Nesta Unidade')
    end
    
    within("div.academia-#{other_unit.id}") do
      expect(page).to have_link('Mudar para esta unidade')
      expect(page).not_to have_link('Cadastrar Nesta Unidade')
    end
  end
end