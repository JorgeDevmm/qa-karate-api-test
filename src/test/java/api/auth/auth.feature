Feature: Login

  Background:
    * url baseURL
    * def auth = 'auth'
    * def login = 'login'

  @Login @Smoke
  Scenario: Login
    * def login_body = read('login_body.json')
    Given path auth, login
    * request login_body
    When method post
    Then status 200
    * def response_accessToken = response.accessToken
    * def response_refreshToken = response.refreshToken
    * print 'accessToken: ', response_accessToken ,' refreshToken: ', response_refreshToken
    * assert response.id == 1
    * assert response.nombre == 'Blass'
    * assert response.apellido == 'Academy'
    * assert response.accessToken.length >= 280
    * assert response.refreshToken.length >= 280