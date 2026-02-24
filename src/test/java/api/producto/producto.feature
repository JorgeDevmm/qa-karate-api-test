Feature: Gestion de Productos

  Background:
    * url baseURL
    * path 'productos'

  @ObtenerTodosProductos
  Scenario: Obtener todos los productos
    When method get
    Then status 200

  @ObtenerProducto
  Scenario: Obtener un producto
    * def producto_id = 2
    Given path producto_id
    When method get
    Then status 200

  @EliminarProducto
  Scenario: Eliminar un producto
    * def producto_id = 2
    Given path producto_id
    When method delete
    Then status 200
    * match response.mensaje contains 'eliminado'

  @OrdenarProductos
  Scenario: Ordenar Productos
    Given params {sortBy: 'precio',order: 'order'}
    When method get
    Then status 200

  @BuscarProductos
  Scenario: Buscar Productos
    Given param nombre = 'Vinagreta'
    When method get
    Then status 200

  @FiltrarProductos
  Scenario: FiltrarProductos
    Given params {filterBy:'perecible',value:false}
    When method get
    Then status 200


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

  @ActualizarProducto
  Scenario: Actualizar Producto
    * def producto_id = 3
    * def producto_actualizar_body = read('producto_actualizar_body.json')
    Given path producto_id
    * request producto_actualizar_body
    When method put
    Then status 200

  @ActualizarParcialmenteProducto
  Scenario: Actualizar parcialmente producto
    * def producto_id = 3
    * def producto_actualizar_parcial_body = read('producto_actualizar_parcial_body.json')
    Given path producto_id
    * request producto_actualizar_parcial_body
    When method patch
    Then status 200


