Feature: Facilitator wants to find a need to help with
  Scenario: Facilitator lists needs
    Given I go to all_needs
    And I see all the need categories listed
    When I select the need "Alimentación"
    Then I should see all the needs of the category "Alimentación"
    And I should see the number of proyects that have them
