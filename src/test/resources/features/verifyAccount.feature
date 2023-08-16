@Regression
Feature: Verify Account/ api/accounts/get-account

Background: setup test
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
And print result
* def validToken = result.response.token
#Scenario #7
Scenario: Verify an account that is already exist
Given path "/api/accounts/get-account"
#With def step we can create variable and assign value for reusibility
* def existingId = 9460
And param primaryPersonId = existingId
#Heather have to add to request
And header Authorization = "Bearer "+ validToken
When method get
Then status 200
And print response
And assert response.primaryPerson.id == existingId

#Scenario #8
Scenario: Verify get-account with id not exist
Given path "/api/accounts/get-account"
And param primaryPersonId = "94600"
And header Authorization = "Bearer "+ validToken
When method get
Then status 404
And print response
And assert response.errorMessage == "Account with id 94600 not found"

