@Regression

Feature: Add phone to account feature

Background: test setup and create new account
* def createAccount = callonce read('CreateAccount.feature')
* def validToken = createAccount.validToken
* def createdAccountId = createAccount.response.id
And print createAccount
Given url "https://tek-insurance-api.azurewebsites.net"

#Scenario # 12
Scenario: Adding phone number to an account
Given path "/api/accounts/add-account-phone"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = createdAccountId

* def dataGenerator = Java.type('api.Utility.Data.GenerateData')
* def autoPhoneNum = dataGenerator.getPhoneNumber()
And request
"""
{
  "phoneNumber": "#(autoPhoneNum)",
  "phoneExtension": "",
  "phoneTime": "Evening",
  "phoneType": "Mobile"
}
"""
When method post
Then status 201
And print response
And assert response.phoneNumber == autoPhoneNum
