Feature: Login
  User should be able to login successfully after clicking login button.
    
Scenario: User logs in successfully
    Given I expect the user enters email
    And I expect the user enters password
    When user hits Login button
    Then user should land on next screen