#this feature is to test register account holder
#required and existing account
#required random username
@Regression
Feature: Register new user and new account

Background: setup tests and create new account
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountResult = callonce read('CreateAccount.feature')
* def accountId = createAccountResult.response.id
* def fullName = createAccountResult.response.firstName + " " + createAccountResult.response.lastName

Scenario: sign up and register new user
Given path "/api/sign-up/register"
* def dataGenerator = Java.type('api.Utility.Data.GenerateData')
* def auto_username = dataGenerator.getUsername()
And request 
"""
{
  "primaryPersonId": "#(accountId)",
  "fullname": "#(fullName)",
  "username": "#(auto_username)",
  "password": "tek@far",
  "authority": "CUSTOMER",
  "accountType": "CUSTOMER"
}
"""
When method post
Then status 201
And print response
And assert response.username == auto_username
And assert response.fullName == fullName
And assert response.accountType == "CUSTOMER"

