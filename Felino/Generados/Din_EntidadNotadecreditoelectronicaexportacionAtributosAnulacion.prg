
define class Din_EntidadNOTADECREDITOELECTRONICAEXPORTACIONAtributosAnulacion as custom
	*----------------------------------------------
	function ObtenerAtributosAnulacion() as zoocoleccion OF zoocoleccion.prg
		Local loRetorno as zoocoleccion OF zoocoleccion.prg
		loRetorno = NewObject( "zoocoleccion", "zoocoleccion.prg" )
		
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
		loItem.cAtributo = "COMPROBANTEFISCAL"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FCOMPFIS"
		loItem.nLongitud = 1
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
		loItem.cCampo = "FFCH"
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
		loItem.cAtributo = "FECHAMODIFICACION"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FD2"
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
		loItem.cAtributo = "FECHAVTOSENIA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "vtosenia"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "HORA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FHORA"
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
		loItem.cAtributo = "LETRA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FLETRA"
		loItem.nLongitud = 1
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
		loItem.cCampo = "FNUMCOMP"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PUNTODEVENTA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FPTOVEN"
		loItem.nLongitud = 4
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "SECUENCIA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FACTSEC"
		loItem.nLongitud = 2
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
		loItem.cAtributo = "SIMBOLOMONETARIOCOMPROBANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "SimbMon"
		loItem.nLongitud = 3
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "SITUACIONFISCAL_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "SitFiscCli"
		loItem.nLongitud = 2
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
		loItem.cAtributo = "TIPOCOMPROBANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FACTTIPO"
		loItem.nLongitud = 2
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
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ANULADO"
		loItem.cValorDefault = ".T."
		loItem.xValor = ""
		loItem.cCampo = "Anulado"
		loItem.nLongitud = 1
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "SIGNODEMOVIMIENTO"
		loItem.cValorDefault = "1"
		loItem.xValor = ""
		loItem.cCampo = "signomov"
		loItem.nLongitud = 2
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		Return loRetorno
	endfunc

enddefine