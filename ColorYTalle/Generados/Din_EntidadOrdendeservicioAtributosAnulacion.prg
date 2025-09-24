
define class Din_EntidadORDENDESERVICIOAtributosAnulacion as custom
	*----------------------------------------------
	function ObtenerAtributosAnulacion() as zoocoleccion OF zoocoleccion.prg
		Local loRetorno as zoocoleccion OF zoocoleccion.prg
		loRetorno = NewObject( "zoocoleccion", "zoocoleccion.prg" )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ARTICULO_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "OSArt"
		loItem.nLongitud = 15
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "BASEDEDATOSALTAFW"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "BDAltaFW"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "BASEDEDATOSMODIFICACIONFW"
		loItem.cValorDefault = "_screen.Zoo.App.cSucursalActiva"
		loItem.xValor = ""
		loItem.cCampo = "BDModiFW"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CLIENTE_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Cliente"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CLIENTEDESCRIPCION"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "DescClient"
		loItem.nLongitud = 185
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CODIGO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Codigo"
		loItem.nLongitud = 20
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "COLOR_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "OSColor"
		loItem.nLongitud = 6
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ENTIDADADICIONAL1_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "EntAdic1"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ENTIDADADICIONAL2_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "EntAdic2"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ENTIDADADICIONAL3_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "EntAdic3"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ESTADO_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Estado"
		loItem.nLongitud = 30
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ESTADOTRANSFERENCIA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "EstTrans"
		loItem.nLongitud = 20
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Fecha"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAADICIONAL1"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FecAdic1"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAADICIONAL2"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FecAdic2"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAADICIONAL3"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FecAdic3"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAALTAFW"
		loItem.cValorDefault = "goservicios.librerias.obtenerFecha()"
		loItem.xValor = ""
		loItem.cCampo = "FAltaFW"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAENTREGA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FechaEnt"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAEXPO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FecExpo"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAFACTURA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FechaFac"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAIMPO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FecImpo"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAMODIFICACIONFW"
		loItem.cValorDefault = "goservicios.librerias.obtenerFecha()"
		loItem.xValor = ""
		loItem.cCampo = "FModiFW"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHATRANSFERENCIA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FecTrans"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "GUIDPRESUPUESTO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "GuidPresup"
		loItem.nLongitud = 38
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "HORAALTAFW"
		loItem.cValorDefault = "goservicios.librerias.obtenerHora()"
		loItem.xValor = ""
		loItem.cCampo = "HAltaFW"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "HORAEXPO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "HoraExpo"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "HORAIMPO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "HoraImpo"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "HORAMODIFICACIONFW"
		loItem.cValorDefault = "goservicios.librerias.obtenerHora()"
		loItem.xValor = ""
		loItem.cCampo = "HModiFW"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "IDGLOBALCLIENTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "IdCent"
		loItem.nLongitud = 38
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "LETRAPRESUPUESTO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "LetraPresu"
		loItem.nLongitud = 1
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NROFACTURA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "NroFac"
		loItem.nLongitud = 30
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NUMEROPRESUPUESTO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "NumPresup"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "OBS"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Obs"
		loItem.nLongitud = 0
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PRESUPUESTO_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = ""
		loItem.nLongitud = 38
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PTOVTAPRESUPUESTO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "PVPresup"
		loItem.nLongitud = 4
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "SERIEALTAFW"
		loItem.cValorDefault = "_screen.Zoo.App.cSerie"
		loItem.xValor = ""
		loItem.cCampo = "SAltaFW"
		loItem.nLongitud = 7
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "SERIEMODIFICACIONFW"
		loItem.cValorDefault = "_screen.Zoo.App.cSerie"
		loItem.xValor = ""
		loItem.cCampo = "SModiFW"
		loItem.nLongitud = 7
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "SUCURSAL_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Sucursal"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "TALLE_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "OSTalle"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "TIPODEORDEN_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "TipoOrden"
		loItem.nLongitud = 20
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "USUARIOALTAFW"
		loItem.cValorDefault = "goServicios.Seguridad.cUsuarioLogueado"
		loItem.xValor = ""
		loItem.cCampo = "UAltaFW"
		loItem.nLongitud = 100
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "USUARIOMODIFICACIONFW"
		loItem.cValorDefault = "goServicios.Seguridad.cUsuarioLogueado"
		loItem.xValor = ""
		loItem.cCampo = "UModiFW"
		loItem.nLongitud = 100
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "VALOR"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Valor"
		loItem.nLongitud = 15
		loItem.nDecimales = 2
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "VENDEDOR_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Vendedor"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "VENDEDORDESCRIPCION"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "DescVend"
		loItem.nLongitud = 60
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "VERSIONALTAFW"
		loItem.cValorDefault = "_screen.zoo.app.ObtenerVersion()"
		loItem.xValor = ""
		loItem.cCampo = "VAltaFW"
		loItem.nLongitud = 13
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "VERSIONMODIFICACIONFW"
		loItem.cValorDefault = "_screen.zoo.app.ObtenerVersion()"
		loItem.xValor = ""
		loItem.cCampo = "VModiFW"
		loItem.nLongitud = 13
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ZADSFW"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "ZADSFW"
		loItem.nLongitud = 0
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ANULADO"
		loItem.cValorDefault = ".T."
		loItem.xValor = ""
		loItem.cCampo = "Anulado"
		loItem.nLongitud = 1
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		Return loRetorno
	endfunc

enddefine