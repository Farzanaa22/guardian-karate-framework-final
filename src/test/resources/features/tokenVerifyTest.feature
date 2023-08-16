@Smoke
Feature: Token Verify Feature

Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
   
    #scenario#4
    Scenario: Verify a valid token
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response == "true"
    
    #scenario#5
    Scenario: Verify a valid token and invalid username
    
     And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "wrong username"
    And param token = response.token
      
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"
    
    #scenario #6
    Scenario: Verify a valid username and invalid token
      
      And path "/api/token/verify"
    And param username = "supervisor"
    And param token = "wrong token"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
      
      
    
     