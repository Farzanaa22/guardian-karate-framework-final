
Feature: updating an account car

Background: Setup test
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountResult = callonce read('CreateAccount.feature')
* def validToken = createAccountResult.validToken
* def generateAccountId = createAccountResult.response.id

Scenario: update existing car info 
#Create and add car first to the account
Given path "/api/accounts/add-account-car"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = generateAccountId
And request
"""
{
	"id": "0",
  "make": "BMW",
  "model": "Alpina",
  "year": "2019",
  "licensePlate": "vb145r"
}
"""
When method post
Then status 201
And print response
And assert response.make == "BMW"
And assert response.year == "2019"
And assert response.licensePlate == "vb145r"
* def carId = response.id
#updating existing account car
And path "/api/accounts/update-account-car"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = generateAccountId
And request 
"""
{
  "id": "#(carId)",
  "make": "BMW",
  "model": "Alpina 7",
  "year": "2023",
  "licensePlate": "vh145r"
}
"""
When method put
And print response
Then status 202
And assert response.make == "BMW"
And assert response.year == "2023"
And assert response.licensePlate == "vh145r"

