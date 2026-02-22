Feature: Gestion de animales

  Background:
    * url 'https://api.blassacademy.com'
    * path 'animales'

  @ObtenerTodosAnimales
  Scenario: Obtener todos los animales
    When method get
    Then status 200

  @ObtenerAnimal
  Scenario: Obtener un animal
    * def id = 5
    Given path id
    When method get
    Then status 200
    * def response_id = response.id
    * def response_nombre = response.nombre
    * print 'El id del animal es: ', response_id , ' - y su nombre es:', response_nombre
    * match response_id == id
    * match response_nombre == 'Fido'


  @EliminarAnimal
  Scenario: ELiminar un animal
    * def animal = 5
    Given path animal
    When method delete
    Then status 200
    * match response.mensaje contains "eliminado"

  @OrdenarAnimales
  Scenario: OrdenarAnimales
    Given params {sortBy: 'peso', order: 'asc'}
    When method get
    Then status 200

  @BuscarAnimales
  Scenario: Buscar Animales
    Given param nombre = 'Oreo'
    When method get
    Then status 200
    * def response_id = response.id
    * match response[0].nombre == 'Oreo'

  @FiltrarAnimales
  Scenario: Filtrar Animales
    Given params {filterBy: 'tipo', value: 'domestico'}
    When method get
    Then status 200

  @CrearAnimales
  Scenario: Crear animales
    * def animalBody =
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
    Given request animalBody
    When method post
    Then status 201
    * def id = response.id
    * print 'El id del Animal creado es ', id

  @ActualizarAnimal
  Scenario: Actualizar Animal
    * def animal_id = 5
    * def animal_request =
      """
      {
        "nombre": "Blass",
        "tipo": "Tranquilo",
        "edad": 15,
        "peso": 32.00,
        "genero": "Macho",
        "amo": {
          "nombre": "Christophe",
          "apellido": "Chapulin",
          "correo": "Christophe_Stanton52@hotmail.com",
          "edad": 30,
          "pais": "Guam"
        }
      }
      """
    Given path animal_id
    * request animal_request
    When method put
    Then status 200
    * match response.id == animal_id

  @ActualizarParcialmenteAnimal
  Scenario: Actualizar Parcialmente Animal
    * def animales_body =
      """
      {
        "nombre": "Blass",
        "tipo": "salvaje",
        "edad": 25,
        "peso": 32.00
      }
      """
    * def param_id = 5
    Given path param_id
    * request animales_body
    When method patch
    Then status 200





