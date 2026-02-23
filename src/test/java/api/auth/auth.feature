Feature: Login

  Background:
    * url 'https://api.blassacademy.com'
    * path 'auth'

  @Login
  Scenario: Login
    * def login_body = read('login_body.json')
    Given path 'login'
    * request login_body
    When method post
    Then status 200
    * def response_accessToken = response.accessToken
    * def response_refreshToken = response.refreshToken
    * print 'accessToken: ', response_accessToken ,' refreshToken: ', response_refreshToken