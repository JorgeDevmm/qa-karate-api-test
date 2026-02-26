Feature: Gestion de Productos

  Background:
    * url baseURL
    * path 'productos'

  @ObtenerTodosProductos @Regression
  Scenario: Obtener todos los productos
    When method get
    Then status 200
    * assert responseTime < maxResponseTime

  @ObtenerProducto @Smoke @Regression
  Scenario: Obtener un producto
    * def critica =
      """
      {
        "puntaje": 4.74,
        "comentario": "Asado a su gusto y rociado con una audaz salsa salteada de balti, servido junto con brotes de soja tostados.",
        "correo": "Elisa.S@yahoo.com",
        "usuario": "Elisa.Si82"
      }
      """
    * def producto_id = 2
    Given path producto_id
    When method get
    Then status 200
    * match response.criticas[1] contains critica
    * assert responseTime < maxResponseTime
    * assert response.id == 2
    * assert response.cantidad == 10
    * assert response.perecible == false
    * assert response.criticas[1].puntaje == 4.74
    * assert response.etiquetas[2] == 'Fresco'

  @EliminarProducto @Regression
  Scenario: Eliminar un producto
    * def producto_id = 2
    Given path producto_id
    When method delete
    Then status 200
    * assert responseTime < maxResponseTime
    * match response.mensaje contains 'eliminado'

  @OrdenarProductos
  Scenario: Ordenar Productos
    Given params {sortBy: 'precio',order: 'order'}
    When method get
    Then status 200
    * assert responseTime < maxResponseTime

  @BuscarProductos @Smoke
  Scenario: Buscar Productos
    Given param nombre = 'Vinagreta'
    When method get
    Then status 200
    * assert responseTime < maxResponseTime

  @FiltrarProductos
  Scenario: FiltrarProductos
    Given params {filterBy:'perecible',value:false}
    When method get
    Then status 200
    * assert responseTime < maxResponseTime


  @CrearProducto
  Scenario: Crear un producto
    * def producto_crear_body = read('producto_crear_body.json')
    * def producto_nombre = producto_crear_body.nombre
    Given request producto_crear_body
    When method post
    Then status 201
    * def id = response.id
    * print "El id del producto es: ", id
    * match response.nombre == producto_nombre
    * assert responseTime < maxResponseTime

  @ActualizarProducto
  Scenario: Actualizar Producto
    * def producto_id = 3
    * def producto_actualizar_body = read('producto_actualizar_body.json')
    Given path producto_id
    * request producto_actualizar_body
    When method put
    Then status 200
    * assert responseTime < maxResponseTime

  @ActualizarParcialmenteProducto @Smoke
  Scenario: Actualizar parcialmente producto
    * def producto_id = 3
    * def producto_actualizar_parcial_body = read('producto_actualizar_parcial_body.json')
    Given path producto_id
    * request producto_actualizar_parcial_body
    When method patch
    Then status 200
    * assert responseTime < maxResponseTime


