
define class Din_EntidadCOMPROBANTEDERETENCIONESSUSSAtributosAnulacion as custom
	*----------------------------------------------
	function ObtenerAtributosAnulacion() as zoocoleccion OF zoocoleccion.prg
		Local loRetorno as zoocoleccion OF zoocoleccion.prg
		loRetorno = NewObject( "zoocoleccion", "zoocoleccion.prg" )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ANULADO"
		loItem.cValorDefault = ".T."
		loItem.xValor = ""
		loItem.cCampo = "Anulado"
		loItem.nLongitud = 1
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "BASEDEDATOSALTAFW"
		loItem.cValorDefault = "_screen.Zoo.App.cSucursalActiva"
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
		loItem.cAtributo = "CODIGO"
		loItem.cValorDefault = "goservicios.librerias.obtenerguidpk()"
		loItem.xValor = ""
		loItem.cCampo = "CODIGO"
		loItem.nLongitud = 38
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
		loItem.cAtributo = "FECHAALTAFW"
		loItem.cValorDefault = "goservicios.librerias.obtenerFecha()"
		loItem.xValor = ""
		loItem.cCampo = "FAltaFW"
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
		loItem.cAtributo = "MONEDACOMPROBANTE_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Moneda"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "MONEDASISTEMA_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "MonSis"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NUMERO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Numero"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PUNTODEVENTA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "PtoVenta"
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
		loItem.cAtributo = "TIMESTAMP"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "TIMESTAMP"
		loItem.nLongitud = 20
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "TIPOIMPUESTO_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "TipoImp"
		loItem.nLongitud = 10
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
		
		Return loRetorno
	endfunc

enddefine