
define class Din_EntidadCHEQUEPROPIOAtributosAnulacion as custom
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
		loItem.cAtributo = "BDORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cBdorig"
		loItem.nLongitud = 8
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
		loItem.cAtributo = "CHEQUERA_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Chequera"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CLIENTE_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "Cliente"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CLIENTEAFECTANTE_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "clAfec"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CODIGO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cCod"
		loItem.nLongitud = 38
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CODIGOCOMPROBANTEAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cCodCompA"
		loItem.nLongitud = 38
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CODIGOCOMPROBANTEORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cCodComp"
		loItem.nLongitud = 38
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "COMPROBANTEAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "CompA"
		loItem.nLongitud = 20
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "COMPROBANTEORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cCompOri"
		loItem.nLongitud = 20
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "DESCRIPCIONTIPOCOMPROBANTEAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = ""
		loItem.nLongitud = 80
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "DESCRIPCIONTIPOCOMPROBANTEORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = ""
		loItem.nLongitud = 80
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ENTIDADFINANCIERA_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cEntFin"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "ESTADO"
		loItem.cValorDefault = "ANULA"
		loItem.xValor = ""
		loItem.cCampo = "Estado"
		loItem.nLongitud = 5
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
		loItem.cCampo = "cFecha"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FechaA"
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
		loItem.cAtributo = "FECHAEMISION"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cFechaEmi"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "FECHAENDOSO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cFecEnd"
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
		loItem.cAtributo = "FECHAORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cFecOri"
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
		loItem.cAtributo = "FECHAVENCIMIENTO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FechaVenci"
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
		loItem.cAtributo = "LETRAAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FLETRAA"
		loItem.nLongitud = 1
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "LETRAORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cLetra"
		loItem.nLongitud = 1
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "MONTO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cMonto"
		loItem.nLongitud = 16
		loItem.nDecimales = 2
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NUMERO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cNumero"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NUMEROAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FNUMCOMPA"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NUMEROC"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "numeroC"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "NUMEROORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cnum"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "OBSERVACION"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cObss"
		loItem.nLongitud = 0
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PROVEEDOR_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "prvOrig"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PROVEEDORAFECTANTE_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "prvAfec"
		loItem.nLongitud = 5
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PUNTODEVENTA"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "ptoventa"
		loItem.nLongitud = 4
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PUNTODEVENTAAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "FPTOVENA"
		loItem.nLongitud = 4
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "PUNTODEVENTAORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cptovta"
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
		loItem.cAtributo = "SERIEORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cSerie"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "TIPO"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "TipoCH"
		loItem.nLongitud = 2
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "TIPODECOMPROBANTEAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cTipCA"
		loItem.nLongitud = 2
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "TIPODECOMPROBANTEORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cTipC"
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
		loItem.cAtributo = "USUARIOORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cUsuario"
		loItem.nLongitud = 100
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "VENDEDOR_PK"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cVend"
		loItem.nLongitud = 5
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
		loItem.cAtributo = "CBASEDEDATOSAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "cBDeDatA"
		loItem.nLongitud = 8
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CSERIEAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "CSERIEA"
		loItem.nLongitud = 10
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CVERSIONAFECTANTE"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "CVERSIONA"
		loItem.nLongitud = 13
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		loItem = newobject( "ItemAtributoAnulacion", "ItemAtributoAnulacion.prg" )
		loItem.cAtributo = "CVERSIONORIGEN"
		loItem.cValorDefault = ""
		loItem.xValor = ""
		loItem.cCampo = "CVERSION"
		loItem.nLongitud = 13
		loItem.nDecimales = 0
		loRetorno.Add( loItem, upper( loItem.cAtributo ) )
		
		Return loRetorno
	endfunc

enddefine