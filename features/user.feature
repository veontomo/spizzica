Feature: presence of items
	As a visitor 
	In order to select an item
	I want to see items

Scenario: non-authenticated user
	Given I am on the user page
	Then I should see "Listing users" 
