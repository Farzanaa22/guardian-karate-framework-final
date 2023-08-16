@Regression
Feature: Plan Code Feature

Background: Setup test and get valid token
Given url "https://tek-insurance-api.azurewebsites.net"
#callonce is calling another feature file to be run before the current feature file
* def tokenFeatureResult = callonce read('GenerateToken.feature')
And print tokenFeatureResult
* def validToken = tokenFeatureResult.response.token

#Scenario #9
Scenario: Validate get plan codes
And path "/api/plans/get-all-plan-code"
And header Authorization = "Bearer " + validToken
When method get
Then status 200
And print response
# for assertion since it's an array of 4 objects we need to give the response 
# index number stating from 0
# and the result id boolean so do not need double quotation
And assert response[0].planExpired == false
And assert response[1].planExpired == false
And assert response[2].planExpired == false
And assert response[3].planExpired == false
