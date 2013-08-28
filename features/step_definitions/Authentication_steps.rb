

Given(/^a user visits the signin page$/) do
   visit signin_path
end

When(/^he submits invalid signin information$/) do
  click_button "Sign in"
end


Then(/^he should see an error message$/) do
  page.should have_selector('div.alert.alert-error')  
end


Given(/^user has an account$/) do
  @user = User.create(name: "Gregg",email:"gp@mail.com", 
                            password:"foobar", password_confirmation:"foobar")

end

When(/^he submits valid signin information$/) do
  fill_in "Email",     with: @user.email
  fill_in "Password",  with: @user.password
  click_button "Sign in"
end


Then(/^he should see his profile page$/) do
  page.should have_title(@user.name) 
end

Then(/^he should see Sign out link.$/) do
  page.should have_link("Sign out", href: signout_path)
end
