Feature: GeoNetwork loading
        A guest looking for the new metadata record.
 
 Scenario: Check if metadata is available as guest
 				# Loading search page
        Given I navigate to "{endPointToTest}/srv/eng/catalog.search#/search"
        Then I wait 5 seconds for element having id "gn-any-field" to display
 	      And I enter "Cucumber" into input field having id "gn-any-field"
 	      And I click on element having id "trigger-search-button-id"
 	      And I click on link having partial text "Cucumber"
 	      Then I wait for 3 sec

        
        