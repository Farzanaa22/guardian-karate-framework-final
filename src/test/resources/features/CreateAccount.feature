@Regression
Feature: Create account

Background: Setup 
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
And print result
* def validToken = result.response.token

#Scenario #10
Scenario: Create valid account
Given path "/api/accounts/add-primary-account"
And header Authorization = "Bearer " + validToken
#calling JAva class in feature file.this utility will create object from Java class
* def generateDataObject = Java.type('api.Utility.Data.GenerateData')
* def autoEmail = generateDataObject.getEmail()
And request
"""
{
  "email": "#(autoEmail)",
  "firstName": "Farah",
  "lastName": "Nami",
  "title": "Ms.",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Student",
  "dateOfBirth": "1998-05-27",
  "new": true
}
"""
When method post
Then status 201
And print response
And assert response.email == autoEmail
# using delete endpoint to remove generate account for continius execution
#Given path "/api/accounts/delete-account"
#And param primaryPersonId = response.id
#And header Authorization = "Bearer " + validToken
#When method delete
#Then status 200
#And print response
#And assert response == "Account Successfully deleted"

