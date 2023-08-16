# account should be exist to be deleted. to get 200 status code
#Make sure account thta is not exist to get 404 status code
@Regression
Feature: Delete Account functionality


Background: Test Setup and Create new account
* def createAccount = callonce read('CreateAccount.feature')
* def validToken = createAccount.validToken
* def createdAccountId = createAccount.response.id
And print createAccount
Given url "https://tek-insurance-api.azurewebsites.net"

#Scenario # 11
Scenario: Verify user delete an existing account successfully

Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 200
And print response
And assert response == "Account Successfully deleted"
Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 404
And print response
And assert response.errorMessage == "Account with id " + createdAccountId + " not exist"


	