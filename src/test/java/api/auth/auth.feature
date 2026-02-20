Feature: Gestion de animale

  @CreacionAnimal
  Scenario:
    * def animal =
      """
      {
        "nombre": "Nova",
        "tipo": "cautivo",
        "edad": 3,
        "peso": 42.3,
        "genero": "hermafrodita",
        "amo": {
          "nombre": "Dovie",
          "apellido": "McLaughlin",
          "correo": "Dovie_McLaughlin42@hotmail.com",
          "edad": 52,
          "pais": "Paraguay"
        }
      }
      """
    Given url 'https://api.blassacademy.com/animales'
    * request animal
    When method post
    Then status 201
    * def id = response.id
    * print 'El id del Animal creado es ', id