Feature: API

  @api_get
  Scenario: Test API Get
    Given I want to get the users
    When I send an api GET request
    Then the response is a success

  @api_put
    Scenario: Test API post
      Given I want to post a user
      When I send an api request
      Then the user is added