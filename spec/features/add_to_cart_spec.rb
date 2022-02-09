require 'rails_helper'

RSpec.feature "User can add product into the cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        image: open_asset('apparel1.jpg')
      )
    end
    #signup first
    visit root_path

    click_on('Signup')

    fill_in("user_first_name", with: "Allen")
    fill_in("user_last_name", with: "Zhao")
    fill_in("user_email", with: "111@qq.com")
    fill_in("user_password", with: "123456")
    fill_in("user_password_confirmation", with: "123456")
    
    click_on("Submit")
  end
 
  scenario "by clicking on 'Add to Cart' on different items, the cart total increased by 2" do
    visit root_path

      product_footers = page.all("footer.actions")
      product_footers[1].click_on "Add"

      product_footers = page.all("footer.actions")
      product_footers[2].click_on "Add"

    
    expect(page).to have_content 'My Cart (2)'

  end
end
