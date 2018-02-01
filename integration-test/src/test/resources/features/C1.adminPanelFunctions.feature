Feature: Admin panel functions
        As admin at work
 
 Scenario: Load main functions
 				# Page loading
        Given I navigate to "{endPointToTest}"
 	      Then I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      # Login ad admin
        Then I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "admin" into input field having id "inputUsername"
        And I enter "{adminPassword}" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Load settings page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/settings/system"
        And I wait 10 seconds for element having id "gn-btn-settings-save" to display
        # Load UI settings page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/settings/ui"
        And I wait 10 seconds for element having id "gn-btn-settings-save" to display
        # Load UI settings page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/settings/ui"
        And I wait 10 seconds for element having id "gn-btn-settings-save" to display
        # Load admin group page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/organization/groups"
        And I wait 10 seconds for element having id "gn-btn-group-add" to display
        # Load harvesters page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/harvest"
        Then I wait for 2 sec
        Then I zoom in page
        # Load dashboard
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/dashboard"
        Then I wait for 2 sec
        Then I zoom in page
        # Load reports page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/reports"
        Then I wait for 2 sec
        Then I zoom in page
        # Load classification page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/classification"
        Then I wait for 2 sec
        Then I zoom in page
				# Load standards page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/standards"
        Then I wait for 2 sec
        Then I zoom in page
        # Load standards page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/tools"
        Then I wait for 2 sec
        Then I zoom in page
        # Logout
        Then I navigate to "{endPointToTest}/signout"
            