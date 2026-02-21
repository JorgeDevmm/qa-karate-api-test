Feature: Login

  Background:
    * url 'https://api.blassacademy.com'

  @CreacionAnimal
  Scenario: Login
    * def datos_login =
      """
      {
        "username": "standard_user",
        "password": "secret_blass_academy"
      }
      """
    Given path 'auth','login'
    * request datos_login
    When method post
    Then status 200
    * def response_accessToken = response.accessToken
    * def response_refreshToken = response.refreshToken
    * print 'accessToken: ', response_accessToken ,' refreshToken: ', response_refreshToken