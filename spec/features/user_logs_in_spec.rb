require 'rails_helper'

feature 'User Logs In' do

  scenario 'Successfully' do
    auth_api
    cpf_status_empty
    list_gyms
    user = create(:account, password:'123456', document: '12345678908')
    create(:profile, account: user)
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Olá, #{user.profile.first_name}"
  end

  scenario 'and must exist' do
    auth_api
    list_gyms
    #Act
    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: 'abc@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    #Assert
    expect(current_path).to eq new_account_session_path
    expect(page).to have_content "Email ou senha inválida"
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and must not be banished' do
    auth_api
    cpf_status
    list_gyms
    user = create(:account, password:'123456', document: '99999999999')
    create(:profile, account: user)
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    #Assert
    expect(current_path).to eq new_account_registration_path
    expect(page).to have_content "CPF banido"
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and must not be Inactive' do
    auth_api
    cpf_status_inactive
    list_gyms
    user = create(:account, password:'123456', document: '88888888888')
    create(:profile, account: user)
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    #Assert
    expect(current_path).to eq new_account_registration_path
    expect(page).to have_content "CPF Inativo"
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end

end
