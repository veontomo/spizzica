### UTILITY METHODS ###

def create_visitor
  @visitor ||= {:email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
#  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###





Given /^the following users exist:/ do |users_table|
  users_table.hashes.each do |user_data|
    role = Role.find_by_name(user_data["role"]) || Role.create!(:name => user_data["role"])
    user = {:email => user_data["email"], :password => user_data["password"], :role_ids => role.id }
    User.create!(user)
   end
  assert User.all.count == users_table.hashes.size
  end

Given /^the following Beer Styles exist:/ do |bs_t|
  bs_t.hashes.each do |bs|
   Beerstyle.create!(bs)
  end
  assert Beerstyle.all.count == bs_t.hashes.size
end

Given /^the following "(.+)" exist:/ do |models, bs_t|
  model=models.singularize
  bs_t.hashes.each do |bs|
   model.constantize.create!(bs)
  end
  assert model.constantize.all.count == bs_t.hashes.size
end

# Given /^the following Manufacturers exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Manufacturer.create!(bs)
  # end
  # assert Manufacturer.all.count == bs_t.hashes.size
# end
#
# Given /^the following Containers exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Container.create!(bs)
  # end
  # assert Container.all.count == bs_t.hashes.size
# end
#
# Given /^the following Lids exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Lid.create!(bs)
  # end
  # assert Lid.all.count == bs_t.hashes.size
# end
#
# Given /^the following Aromas exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Aroma.create!(bs)
  # end
  # assert Aroma.all.count == bs_t.hashes.size
# end
#
# Given /^the following Tastes exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Taste.create!(bs)
  # end
  # assert Taste.all.count == bs_t.hashes.size
# end
#
# Given /^the following Colors exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Color.create!(bs)
  # end
  # assert Color.all.count == bs_t.hashes.size
# end
#
#
# Given /^the following Foams exist:/ do |bs_t|
  # bs_t.hashes.each do |bs|
   # Foam.create!(bs)
  # end
  # assert Foam.all.count == bs_t.hashes.size
# end


Then /^I should see links to: (.+)+$/ do |links|
  linksArr=links.split(",")
  linksArr.each do |link|
    find(:link, link.strip)
    #Given %{I should see link to "#{link}"}
  end
end

Then /^I should see the following: (.+)$/ do |arr|
   words=arr.split(",")
   words.each do |word|
     step "I should see #{word.strip}"
   end
end

# Then /^I should see the following: (.+)+$/ do |items|
  # itemsArr=items.split(",")
  # itemsArr.each do |item|
    # find(:link, link.strip)
    # #Given %{I should see link to "#{link}"}
  # end
# end



Given /^I should see link to (.+)/ do |link|
 find(:link, link)
end

Given /^I am not logged in$/ do
  #visit '/users/sign_out'
  if page.has_content?("Logout")
    click_link("Logout")
  end
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"

end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
#  page.should have_content "Welcome! You have signed up successfully."
  page.should have_content "A message with a confirmation link has been sent to your email address."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end