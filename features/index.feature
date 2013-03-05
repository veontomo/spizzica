Feature: index page
 As a site visitor
 In order to start using the site
 I want to connect to the site from '/'

Background: 
 Given I am on the homepage

Scenario: presence of "Spizzicaluna" on the home page
 Then I should see "Spizzicaluna"

Scenario: presence of the link to Users
 And I follow "Users"
 Then I should see "Listing users"

Scenario: presence of the link to Orders
 And I follow "Orders"
 Then I should see "Listing orders"

Scenario: presence of the link to Items
 And I follow "Items"
 Then I should see "Listing items"
