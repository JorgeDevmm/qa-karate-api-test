Feature: Login

  Background:
    * url baseURL
    * def auth = 'auth'
    * def login = 'login'

  @Login
  Scenario: Login
    * def login_body = read('login_body.json')
    Given path auth, login
    * request login_body
    When method post
    Then status 200
    * def response_accessToken = response.accessToken
    * def response_refreshToken = response.refreshToken
    * print 'accessToken: ', response_accessToken ,' refreshToken: ', response_refreshToken