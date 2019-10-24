require 'rails_helper'

feature 'Add unit to customer' do
  before(:each) do
    auth_api
    list_gyms
  end
  
  scenario 'successfully' do
    #arrange
    unit = create(:unit, name: 'Nova Paulista')
    user = create(:customer)
    create(:profile, account: user)
    
    #act
    login_as(user, scope: :account)
    visit root_path
    # save_and_open_page
    within("div.academia-#{unit.id}") do
      click_on 'Cadastrar Nesta Unidade'
    end

    #assert

    within("div.academia-#{unit.id}") do
      expect(page).to have_content('Está é a sua Unidade')
    end
  end

  scenario 'if signed user is as personal it should not show buttons' do
    #Arrange
    unit = create(:unit, name: 'Nova Paulista')
    account = create(:personal)
    profile = create(:profile, account: account)

    #Act
    login_as(account, scope: :account)
    visit root_path

    #Assert
    within("div.academia-#{unit.id}") do
      expect(page).to_not have_link('Cadastrar Nesta Unidade')
    end
  end
end
