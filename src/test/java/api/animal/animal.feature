Feature: Gestion de animales

  Background:
    * url baseURL
    * def animales = 'animales'
    * def animal_id = 5

  @ObtenerTodosAnimales
  Scenario: Obtener todos los animales
    Given path animales
    When method get
    Then status 200

  @ObtenerAnimal
  Scenario: Obtener un animal
    Given path animales, animal_id
    When method get
    Then status 200
    * def response_id = response.id
    * def response_nombre = response.nombre
    * print 'El id del animal es: ', response_id , ' - y su nombre es:', response_nombre
    * match response_id == animal_id
    * match response_nombre == 'Fido'


  @EliminarAnimal
  Scenario: ELiminar un animal
    Given path animales, animal_id
    When method delete
    Then status 200
    * match response.mensaje contains "eliminado"

  @OrdenarAnimales
  Scenario: OrdenarAnimales
    Given path animales
    * params {sortBy: 'peso', order: 'asc'}
    When method get
    Then status 200

  @BuscarAnimales
  Scenario: Buscar Animales
    Given path animales
    * param nombre = 'Oreo'
    When method get
    Then status 200
    * def response_id = response.id
    * match response[0].nombre == 'Oreo'

  @FiltrarAnimales
  Scenario: Filtrar Animales
    Given path animales
    * params {filterBy: 'tipo', value: 'domestico'}
    When method get
    Then status 200

  @CrearAnimales
  Scenario: Crear animales
    * def animal_crear_body = read('animal_crear_body.json')
    Given path animales
    * request animal_crear_body
    When method post
    Then status 201
    * def id = response.id
    * print 'El id del Animal creado es ', id

  @ActualizarAnimal
  Scenario: Actualizar Animal
    * def animal_actualizar_body = read('animal_actualizar_body.json')
    Given path animales, animal_id
    * request animal_actualizar_body
    When method put
    Then status 200
    * match response.id == animal_id

  @ActualizarParcialmenteAnimal
  Scenario: Actualizar Parcialmente Animal
    * def animal_actualizar_parcial_body = read('animal_actualizar_parcial_body.json')
    * def param_id = 5
    Given path animales, param_id
    * request animal_actualizar_parcial_body
    When method patch
    Then status 200





