# qa-karate-api-test

Descripción profesional
----------------------

`qa-karate-api-test` es un proyecto de pruebas automatizadas basado en Karate (DSL para API testing) y Maven. Está
organizado por áreas funcionales (carpeta `api` con subcarpetas por recurso) y preparado para ejecución local y en CI (
GitHub Actions).

Objetivos

- Mantener pruebas legibles en formato Gherkin (.feature).
- Permitir ejecución por feature, por tag y en paralelo.
- Generar reportes HTML/JSON en `target/karate-reports` con trazabilidad (incluye SHA de commit en los nombres).

Estructura del proyecto
----------------------

Raíz del proyecto (resumen):

- `pom.xml` — configuración Maven y dependencias (Karate, JUnit, plugins).
- `src/test/java/` — runners (JUnit) y código de soporte.
- `src/test/resources/api/` — carpeta principal de features y recursos por dominio:
    - `api/animal/*.feature` + runner por path
    - `api/auth/*.feature` + runner por path
    - `api/producto/*.feature` + runner por path
- `target/karate-reports/` — reportes generados tras la ejecución (HTML, JSON, assets).
- `.github/workflows/karate-test.yml` — flujo de CI para ejecutar las pruebas en GitHub Actions.

Convenciones y runners
----------------------

- En cada subcarpeta (`animal`, `auth`, `producto`) hay:
    - Uno o más archivos `*.feature` con escenarios Gherkin.
    - Un runner que ejecuta por path (ej. `Karate.run("classpath:api/animal").relativeTo(getClass())` o equivalente).
- A nivel de `api/` hay:
    - Un runner que ejecuta por tag (ej. `@CreacionAnimal`).
    - Un runner que ejecuta toda la carpeta `api` en paralelo.

Comandos para ejecutar localmente
--------------------------------

Ejemplo para ejecutar por tag desde la consola (ya configurado en tu proyecto):

```powershell
mvn -B test -Dkarate.options="--tags @CreacionAnimal" -Dkarate.output.dir=target/karate-reports
```

Notas sobre el comando:

- `-B` (batch mode) es útil en CI para salida menos verbosa.
- `-Dkarate.options` permite filtrar por tags, características, u opciones de Karate.
- `-Dkarate.output.dir` fuerza la ubicación donde Karate escribe los reportes.

Nombre y trazabilidad de reportes
--------------------------------

Los reportes se generan con un identificador único que puede incluir el ID/numero de ejecución y una varibale del
contexto del commit hash que lo representamos con sha para
trazabilidad.
Ejemplo de convención en CI (GitHub Actions):

```
name: karate-reports-${{ github.run_id }}-${{ github.run_number }}-${{ github.sha }}
```

Esto facilita correlacionar un conjunto de reportes con la ejecución de CI y el commit que disparó la ejecución.

Integración Continua (GitHub Actions)
------------------------------------

- El archivo `.github/workflows/karate-test.yml` debe contener pasos para: checkout, setup de JDK, cache de Maven (
  opcional), `mvn test` con los parámetros necesarios, y luego almacenar/artifacts los reportes (o publicarlos).
- Asegúrate de usar `actions/checkout@v3` con `fetch-depth: 0` si necesitas el SHA completo en los artefactos.

