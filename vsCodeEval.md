# Visual Studio Code
## Evaluaci�n del uso de visual studio code para desarrollo de Organic

![N|Solid](https://www.zoologic.com.ar/zl/wp-content/uploads/2023/09/300px.jpg)

### Introducci�n
Visual studio code como editor multiplataforma, multilenguaje, liviano y personalizable mediante extensiones. Es el mas usado para cursos y bootcamp. Es gratuito y open source

- Integraci�n con github
- Integraci�n con copilot
- Soporte de MCP

El editor alternativo para programaci�n, cursor, que incluye un asistente de IA esta basado en el mismo visual studio code.

### Uso de copilot para codigo foxpro

SE uso copilot para la creacion de una extension para usar foxUnit dentro de visual studio code. De esta experiencia se extrajeron las siguientes conclusiones:

Hubo un buen trabajo en el armado de la soluci�n y la migraci�n de foxUnit a una version adaptada para usar en visual studio code, pero varios errores en la codificaci�n del lenguaje

- No creaba bien el script de ejecucion desde vode (esa parte la solucion� Gemini)
- Cometio errores de lenguaje, como incluir una sentencia RETURN dentro de un bloque try - catch - endtry e intento usar ELSEIF que foxpro no lo implementa. En ambos casos se le dio instrucciones para corregirlo.
- Hizo mal uso de algunas funciones dejando un parametro intermedio sin pasar. Para estos casos se hizo un debug paso a paso para encontrar los errores.
- Ante varios intentos no funcionaba la funcion para deserializar un json. Esa funcion se tuvo que reescribir manualmente contemplando todas las posibilidades, como tipo de comillas para delimitar texto y espacios entre token. Lo que se destaca es que el json es creado por la misma aplicacion, con lo que la funcion de serializar lo hacia distinto de la de deserializar aunque fue hecha por el mismo copilot.


## Casos de uso

- Caso de uso 1 (03:54)
- Caso de uso 2 (03:28)
- Caso de uso 3 (05:26)
- Caso de uso 4 (10:08)
- Caso de uso 5 (05:19)

### Cuadro comparativo
| Casos de uso | Analisis | Implementacion | Codificacion |
| ------------ | -------- | -------------- | ------------ |
| 1 | 10 / 8 | 2 / 1,5 | 14 / 13 |
| 2 | 7 / 6 | 1 / 1 | 12 / 12 |
| 3 | 3 / 2 | 2 / 2 | 26 / 22 |
| 4 | 1 / 0,5 | 2 / 1 | 9 /  3 |
| 5 | 8 / 5 | 4 / 5 | 82 /  77 |
------------------------------------------------------------

Coeficiente = 0,75

## Desempe�o

Caso de uso 1
- Identific� correctamente el AntesDeGrabar()
- Refactoriz� correctamente la funci�n AntesDeGrabar()
- Identific� err�neamente la propiedad Credito como tope de cta cte
- Identific� la propiedad nTopeDelCliente pero no la uso.

> _Resumen_
> Implement� correctamente la validaci�n en AntesDeGrabar() llamando a una funci�n nueva que respeta las convenciones de organic pero hubo que corregir la propiedad usada para la validaci�n.

Caso de uso 2
- Detect� los tipos de valores por definiciones
- Detect� las propiedades por un generado (_REST)
- Detect� un tipo de valor tarjeta, el otro lo infiri�
- uso como ADN los archivos XML
- Implement� Setear_Tipo() creandola en la entidad, no en el generado, usando el dodefault() correctamente y respetando las convenciones de organic

> _Resumen_
> Implement� correctamente la funcionalidad requerida usando el Setear_Tipo() correctamente en entColorYTalle_Valor.prg (con el editor en ese archivo se hizo el requerimiento)

Caso de uso 3
- Agrego correctamente la funci�n AntesDeGrabar() en el archivo entColorYTalle_ComprobanteDeVentasConValores.prg (se estaba posicionado en ColorYTalle pero no se tenia abierto ese archivo)
- Agrego bien las variables locales pero definidas una en cada l�nea
- Hizo uso del m�todo para obtener la deuda actual del cliente por nombre de m�todo, pero este funcionaba con el kontroler, no con la entidad.
- Hizo correcto uso de la mensajeria pero una clase global inexistente (goEntidades)

> _Resumen_
> Implement� correctamente la funcionalidad y los c�lculos, pero hubo que refactorizarla para usar el _Screen.Zoo.InstanciarEntidad( "" ) y para que funcione en la entidad y no solo en el con el formulario (en el kontroler)

Caso de uso 4
- El cambio sobre la propiedad la hizo con un bindeo y no usando la funci�n Setear_.
- Identific� correctamente las propiedades, incluyendo el _PK en la que correspondia (SituacionFiscal_pk)
- Refactoriz� correctamente AntesDeGrabar() para incorporar las 2 nuevas validaciones
- Las dos funciones agregadas las ubico incorrectamente en otra clase del mismo prg; se le inform� y lo corrigi�.
- Hizo uso correcto de la mensajeria.

> _Resumen_
> Se le pidieron 3 cambios en el mismo requerimiento. En uno la funci�n estaba correcta pero no la implementaci�n ya que la hizo a traves de un bindeo y con la funci�n Setear_. Las otras dos las implement� correctamente pero habia otra clase posterior en el mismo prg y la ubic� en esa. Al informale el error lo corrigi� y quedo bien. Fue mas el aporte que los cambios. Agrego el siguiente diagrama de la funcionalidad implementada

```mermaid
graph TD
    A[Grabar Comprobante] --> B[AntesDeGrabar]
    B --> C[dodefault - Validaciones base]
    C --> D{�Validaciones base OK?}
    D -->|No| M[Cancelar grabado]
    D -->|S�| E[ValidarLetraSegunSituacionFiscal]
    E --> F{�Hay Cliente?}
    F -->|No| I[Continuar sin validar]
    F -->|S�| G{�SituacionFiscal_pk = 1?}
    G -->|S�| H1[Letra debe ser 'A']
    G -->|No| H2[Letra debe ser 'B']
    H1 --> J{�Letra correcta?}
    H2 --> J
    J -->|No| K[Mostrar error y cancelar]
    J -->|S�| I
    I --> L[RedondearTotalA2Decimales]
    L --> N[Continuar con resto de validaciones]
    K --> M
```

Caso de uso 5
- Identific� correctamente que Setear_Total() no existia en ent_comprobantedeventas y lo agrego respetando la nomenclatura y la herencia. Agreg� de acuerdo a lo solicitado la funci�n para obtener el total actualizado mensual con una secci�n comentada TODO para implementar la consulta.
- Agrego bien las variables locales pero definidas una en cada l�nea
- Agrego bien las propiedades y los calculos, pero los aplic� directamente sin hacer uso de la funci�n cargamanual() pudiendo ser ejecutada al navegar.
- Detect� funciones existente, pero hace uso de recalculardescuentos() que en principio se ejecuta autom�ticamente y no hace falta.

> _Resumen_
> Implement� correctamente la funcionalidad y los c�lculos, interpret� correctamente la necesidad de agregar el m�todo Setear_Total() respetando las convenciones de organic, pero hubo que refactorizarla para usar cargamanual() para que no se ejecute al navegar y quitar el recalculardescuentos() que es invocada al cambiar el descuento.


