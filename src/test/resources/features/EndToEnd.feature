@Regression
Feature: End-to-End account creation

  Background:

    Given url "https://tek-insurance-api.azurewebsites.net"

    * def verifyToken = callonce read("GenerateToken.feature")

    And print verifyToken

    * def getToken = verifyToken.response.token

  Scenario: create primary account

    Then path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + getToken
    * def generateData = Java.type('api.Utility.Data.GenerateData')
    * def AutoEmail = generateAutoEmail.getEmail()
    When request
      """
      {
      "email": "#(AutoEmail)",
      "firstName": "Alian",
      "lastName": "Vali",
      "title": "mr",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2007-04-02",
      "new": true

      }

      """

    And method post

    And status 201

    Then print response

    * def id = response.id

    #add phone number

    And path "/api/accounts/add-account-phone"

    And header Authorization = "Bearer " + getToken

    Then param primaryPersonId = id

    * def phoneNumber = Java.type('api.Utility.Data.GenerateData')

    * def phoneNum = phonenumber.getPhoneNumber()

    And request

      """

      {

      "phoneNumber": "#(phoneNum)",

      "phoneExtension": "404",

      "phoneTime": "morning",

      "phoneType": "cellphone"

      }

      """

    Then method post

    And status 201

    And print response

    And assert response.phoneType == "cellphone"

    #add car 

    Then path "/api/accounts/add-account-car"

    And header Authorization = "Bearer " + getToken

    When param primaryPersonId = id

    * def palet = Java.type('api.Utility.Data.GenerateData')

    * def licencePlate = palet.getLicensePlate()

    And request

      """

      {

      "make": "Bmw",

      "model": "X6",

      "year": "2023",

      "licensePlate": "#(licencePlate)"

      }

      """

    And method post

    And status 201

    Then print response

    And assert response.year == 2030

    # add address

    Then path "/api/accounts/add-account-address"

    And header Authorization = "Bearer " + getToken

    And param primaryPersonId = id

    And request

      """

      {

      "addressType": "Apartment",

      "addressLine1": "1345 west 14th Ave",

      "city": "Vancouver",

      "state": "BC",

      "postalCode": "V6H1F2",

      "countryCode": "01",

      "current": true

      }

      """

    Then method post

    And status 201

    And print response

#delete  account
    Then path "/api/accounts/delete-account"

    And header Authorization = "Bearer " + getToken

    And param primaryPersonId = id

    Then method delete

    And status 200

    And print response
