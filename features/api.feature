Feature: API

  @api_get
  Scenario: Test API Get
    Given I want to get the users
    When I send an api request
    Then the response is a success

  @api_post
  Scenario: Test API post
    Given I want to post a user
    When I send an api request
    Then the user is added

  @api_put
  Scenario: Test API post
    Given I want to update a user
    When I send an api request
    Then the response is a success
    And the user is updated

  Scenario: api get with parameters
    Given I want to get the users with parameters
    And I want to get "3" pages with "4" users per page
    When I send an api request
    Then the response is a success
    And the response displays "3" pages with "4" users per page