Feature: managing styles of beer
 As an admin
 In order to wasten the assortiment
 I want to be able to add style of beer

Background: logged in as an admin
 Given the following users exist:
  | email               | password         | role       |
  | admin@test.com       | admin_password    | admin      |
  | visitor@visitor.com | visitor_password | registered |
  And I am on the "home page"
  And I follow "Login"
  And I fill in "Email" with "admin@test.com"
  And I fill in "Password" with "admin_password"
  And I press "Sign in"
  Then I should see "admin"

 Scenario:  adding a beer style
  Given I am on the page "Beer Styles"
  And I follow "New Beerstyle"
  Then I fill in "Name" with "pilsner"
  Then I press "Save"
  And I should see "pilsner"
