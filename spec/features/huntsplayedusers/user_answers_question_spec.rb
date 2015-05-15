require 'rails_helper'

feature 'user adds a location', %Q{
  As a user
  I want to add a location
  So I can share my favorite place with others

  [x] 1) User must be signed in
  [x] 2) User should be able to add location or choose existing location
  [x] 3) Location must have an address
} do


  let!(:huntsplayeduser) { FactoryGirl.build(:huntsplayeduser) }
  let!(:questionset) { FactoryGirl.create(:questionset)}

  scenario 'user signs in and answers a question correctly' do
    sign_in_as(huntsplayeduser.user)
    visit hunt_questionset_path(questionset.hunt_id,questionset)


    fill_in 'Address', with: "Boston, MA, USA"

    click_button 'Answer'

    expect(page).to have_content('Correct, move on!')

  end
end


