Feature: End-to-end account creation

Background: test and setup verify token
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
* def validToken = result.response.token
And print result
