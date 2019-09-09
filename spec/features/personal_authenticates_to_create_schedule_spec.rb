require 'rails_helper'

feature 'Personal authenticates to create schedule' do
  scenario 'successfully' do
    personal = create(:personal, email: 'teste@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(page).to have_link('Cadastrar Agenda')
    expect(page).to have_link('Sair')

  end

  scenario 'and a not loged in personal cant create schedule' do
    visit root_path

    expect(page).not_to have_link('Cadastrar Agenda')
    expect(page).to have_link('Entrar')

  end

  scenario 'and customers cant create schedule' do
    customer = create(:account, email: 'teste@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(page).not_to have_link('Cadastrar Agenda')
  end

  scenario 'and signed in user can sign out' do
    customer = create(:account, email: 'teste@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    click_on 'Sair'

    expect(page).to have_link('Cadastrar na EspertoFit')
  end
end