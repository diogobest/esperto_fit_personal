require 'rails_helper'

feature 'Visitor access units list' do
  scenario 'and view empty list' do
    visit root_path
    click_on 'Unidades Disponíveis'

    expect(page).to have_content('Nenhuma Unidade Disponível no Momento')
  end

  scenario 'successfully' do
    create(:unit)
    create(:unit)
    create(:unit)
    lista = Unit.all
    
    visit root_path
    click_on 'Unidades Disponíveis'

    expect(page).to have_css('h2', text: 'Unidades Disponíveis')
    expect(page).to have_css('li', text: lista[0].name)
    expect(page).to have_css('li', text: lista[1].name)
    expect(page).to have_css('li', text: lista[2].name)
    
  end
end