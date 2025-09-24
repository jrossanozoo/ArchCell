En este espacio de trabajo hay una solución desarrollada en el lenguaje visual foxpro version 9.0. Esta construida con un framework desarrollado internamente denominado Organic.
Las dimensiones y los hechos se construyen mediante una definición que crea entidades con un esquema generado. El framework tiene una estructura dividida en carpetas por proyectos, el proyecto Nucleo que incluye las clases base y servicios de la aplicacion, el proyecto Dibujante que contiene los elementos visuales, el proyecto Felino que contiene las entidades base de todas las aplicaciones y el proyecto ColorYTalle que es una aplicaciones con las entidades especificas; cada proyecto correspondo a una carpeta, Nucleo a Nucleo, Dibujante a Dibujante, Felino a Felino y ColorYTalle a Dragonfish que es el producto final. 
Convenciones de escritura de código: Las indentaciones se realizan con 1 carácter tabulador, no se usan espacion. Cada clase, funcion o procedimiento tiene su correspondiente cierre a la misma alguna de la definición (pares Define Class - Enddefine, Funcion - EndFunc, Procedure - EndProc), lo mismo para los condicionales (if - else - endif, do case - case - endcase) y los bucles (with - endwith, for - endfor, do while - enddo)  En todos estos casos el código interno esta indentado con 1 carécter tabulador
Las definiciones de las entidades se encuentra dentro de cada proyecto en la carpeta ADN. Las definiciones estan en formato xml y csv. El archivo Entidad.csv esta en la carpeta ADN/csv (lo mismo el archivo entidad.xml en la carpeta ADN/xml) y tiene la definicion de todas las entidades con su nombre, descripcion y un tipo que es muy importante porque define si en el campo tipo si es una entidad (valor E) o un item (valor I). En una relacion uno a muchos la entidad es uno y el item muchos. La diferencia entre entidades de dimensiones y entidades de hechos no tiene una especificacion clara pero todas las entidades heredan de la clase entidad.prg y la mayoria de las de hechos de la clase comprobante.prg. La definicion de las propiedades de las entidades esta individualmente en archivos tanto csv en la carpeta ADN/csv como archivos xml en la carpeta ADN/xml y esta compuestos por la palabra Diccionario seguido del nombre de la entidad en el archivo Entidad.csv (o entidad.xml) tambien en la carpeta ADN/csv o ADN/xml dependiendo del tipo de archivo.
Dentro de cada proyecto se encuentra una subcarpeta con los modulos. Todos los proyectos tienen un modulo base (carpeta _base), el resto de los modulos coincide con el nombre de la carpeta. El proyecto Nucleo tiene el módulo data y entidades, el proyecto Dibujante los módulos ClasesVisuales y Formularios, el proyecto Felino los módulos Altas, Caja, Produccon y Ventas y el proyecto ColorYTalle los módulos Alta, Produccion y Ventas. 
Todas las entidades tienen un mÃ©todo para inicializar y otro para liberar los recursos, en ambos se debe primero llamar a la funcion dodefault(). Si en la clase caja se quiere inicializar una instancia de un validador y bindear un evento cambioitem de un detalle al metodo itemcambiado el ejemplo es

        *-----------------------------------------------------------------------------------------
        function Inicializar()
                dodefault()
                this.oValidador = _screen.zoo.CrearObjeto( 'Validador' )
                This.BindearEvento( this.Detalle.oItem, "EventoCambioItem", This, "itemCambiado" )
        endfunc

El metodo para liberar recursos (Destroy) para esta misma entidad en este mismo caso es:

        *-----------------------------------------------------------------------------------------
        function Destroy() as Void
                dodefault()
                this.oValidador.Release()
        endfunc 

Siempre que se inicialice un objeto en el metodo inicializar() se debe liberar en el metodo Destroy()

En las entidades de dimension la clase tipo entidad es la cabecera y la clase tipo item es una coleccion con la que se arma la relacion de uno a muchos.
La estructura de la aplicacion consta de una clases base de la que heredan los distintos tipos de clases. Los servicios son clases globales que pueden accederse desde cualquier entidad; ejemplo de servicios son goCaja, goMensajes y goDatos. Algunas se puede acceder desde goServicios como goServicios.Mensajes y goServicios.Datos. Los componentes son clases que van asociadas a entidades o a items que son los elementos de las colecciones en las entidades de hechos. Casos de componentes son oComponenteFiscal y oCompSenias de la entidad factura, oCompCajero del item de la coleccion de valores de la factura y oCompPrecios y oCompStock del item de la coleccion de articulos de la factura.
La entidad tiene las reglas de negocio y contiene la capa de presentacion (propiedad oKontroler) y la de acceso a datos (propiedad oAD). 
El esquema de herencia de las entidades son una clase base (entidad.prg), una clase generada con la nomenclatura din_Entidad seguido del nombre de la clase y esta puede heredar directamente de entidad (como el caso de la entidad Cliente) o de una clase intermedia (como el caso de la entidad Factura que hereda de ent_ComprobanteDeVentasConValores.prg)
Las entidades tienen una estructura para sus operaciones CRUD que son los mÃ©todos Nuevo(), Modificar(), Anular y Eliminar(). La cancelacion del proceso de nuevo o modificar se ejecuta con el metodo Cancelar() y la grabación de los datos de la entidad en edición se hace con el metodo Grabar() que llama primero al metodo AntesDeGrabar(), luego valida los datos con el mÃ©todo Validar(), luego graba los datos y ejecuta un ultimo mÃ©todo Despuesdegrabar(). Todos estos metodos estan en las clases generadas y en las clases base. 
Las reglas de negocio especÃ­ficas se agregan a la clase especializada que lleva el prefijo ent_, debiendo llamar primero al metodo dodefault(). Para un ejemplo de inicializar la fecha con el dia de hoy en una entidad factura, en la clase ent_factura.prg se agrega el siguiente mÃ©todo:

        *-------------------------------------------------------------------------------------------------
        Function Nuevo() As Boolean
                with This
                        dodefault()
                        .Fecha = date()
                endwith 
        Endfunc

Otro ejemplo es agregar una validacion al grabar una factura para que el total no sea cero, cuyo ejemplo es:

        *-------------------------------------------------------------------------------------------------
        Function Validar() As boolean
                local llRetorno as Boolean
                With This
                        llRetorno = dodefault()
                        llRetorno = llRetorno and .Total # 0
                endwith
                Return llRetorno
        endfunc

Las colecciones tienen dos elementos, el detalle (la coleccion en si) y el item (cada uno de los elementos). El detalle herede de detalle.prg y los item de itemactivo.prg
Los generados controlan el acceso (metodo atributo_access) y asignacion (metodo atributo_assign) para aplicar las reglas de negocio. Para escribir reglas de negocio personalizadas se una clase con la convencion de la sigla ent_ seguido del nombre de la entidad. Por ejemplo en el caso de factura la especializacion es ent_factura.prg. 

Las funciones definen la propiedad que devuelve el valor con la letra l (de variable local) seguida del tipo de dato (c para texto, n para numero, d para fecha, l para logico y o para objeto) y la palabra Retorno; un caso tipo en una validacion que devuelve un valor logico es la variabla local llRetorno. 

Cada atributo o propiedad tiene un metodo para validad (con la convencion validar_ seguido del nombre del atributo) y un metodo para asignar el valor (con la convencion setear_ seguido del nombre de la propiedad). El metodo que valida recibe como parametro generico el valor a asignar y devuelve un valor booleano verdadero si paso la validacion y falso en caso de que no sea valido. Como en visual foxpro al metodo de la clase padre se llama con el metodo dodefault() en el caso de querer validar que el atributo monto tenga solo dos decimales el uso es 


        *--------------------------------------------------------------
        function Validar_Monto( txVal as variant ) as Boolean
                local llRetorno = dodefault( txVal )
                llRetorno = llRetorno and mod( txVal * 100, 1 )
                Return llRetorno
        endfunc

Este es el caso en que se quiera validar que el monto cumple con el criterio de tener 2 decimales, pero en el caso de querer aplicar la regla se usa el metodo Setear_ (en lugar de validar) con este modelo 


        *------------------------------------------------
        function Setear_Monto( txVal as variant ) as void

                txVal = round( txVal, 2)
                dodefault( txVal )

        endfunc

Para las funciones la convencion es tambien que las variables locales se definen con la letra l seguido del tipo (c para texto, n para numero, d para fecha, l para logico y o para objeto) y el nombre. Y los parametros siguen el mismo formato pero empiezan con la letra t en lugar de la l. Un ejemplo de un metodo para obtener el iva sobre un monto es

        *------------------------------------------------------------------------
        function ObtenerIVA( tnMonto as Number, tnPorcentaje as Number) as Number
                local lnRetorno as Number, lnCoeficiente as Number
                lnCoeficiente = tnPorcentaje / 100
                lnRetorno = tnMonto * lnCoeficiente
                return lnRetorno
        endfunc 

Para enviar un mensaje al usuario se usa el objeto goMensajes siendo el metodo estandar Enviar y el comando goMensajes.Enviar( lcMensaje ). Hay otros tipos de mensajes especificos como el Advertir, Alertar o informar (goMensajes.Advertir(), goMensajes.Alertar() y goMensajes.Informar() respectivamente) y un metodo especial que es el goEnviarSinEsperaProcesando() que se usa para informar al usuario de un proceso y se ejecuta al inicio del proceso con un mensaje como parametro y al final del proceso sin parametro para que cierre el mensaje.
Las reglas de negocio que se implementen al cargar un comprobante deben hacer uso del método CargaManual() que devuelve si esta en modo edición para permitir ejecutar calculos o validaciones, no en el caso de setear un valor. Un ejemplo es el siguiente que implementa el recalculo de impuestos si detecta un cambio en la situacion fiscal del cliente:

        *--------------------------------------------------------------
        function Setear_SituacionFiscal( txVal as Variant ) as Void
            with This
                if .CargaManual()
                    if vartype( .Cliente ) = "O" and !isnull( .Cliente ) and !empty( .Cliente.Codigo )
                        if .Cliente.SituacionFiscal # txVal
                            .RecalcularImpuestos()
                        endif
                    endif
                endif
            endwith
            dodefault( txVal )
        endfunc

