
define class Din_EntidadMovimientobancario_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Movimientobancario"
	cClaseResponse = this.cNamespaceDTOs + ".MovimientobancarioResponse"
	cClaseModelo = "MovimientobancarioModelo"
	cEntidad = "Movimientobancario"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Identificador" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Identificador = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Identificador = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientobancarioModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientobancarioModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientobancarioListarRequest"
			case "Accion" $ tcOperacion
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			otherwise
				goServicios.Errores.LevantarExcepcionTexto( tcOperacion + " no implementada.")
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseResponse( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientobancarioListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "MovimientobancarioModelo"
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerCursorIds( toEntidad as Object, tcFiltro as String, tcOrderBy as String, tnCantidad as Integer, tnPagina as Integer ) as String
		return toEntidad.oAd.ObtenerIdentificadoresPaginado( tcOrderBy, tcFiltro, tnCantidad, tnPagina )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearEntidadConDatosModelo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		with toEntidad
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Identificador", toEntidad, "Identificador" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentabancaria", toEntidad, "Cuentabancaria_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Orden", toEntidad, "Orden" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocuenta", toEntidad, "Numerocuenta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hora", toEntidad, "Hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Concepto", toEntidad, "Concepto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Referencia", toEntidad, "Referencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datoadicional1", toEntidad, "Datoadicional1" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datoadicional2", toEntidad, "Datoadicional2" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datoadicional3", toEntidad, "Datoadicional3" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Importe", toEntidad, "Importe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Saldo", toEntidad, "Saldo" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Identificador", toEntidad.Identificador)
			this.SetearAtributoString( toModeloResponse, "CuentaBancaria", toEntidad.CuentaBancaria_PK)
			this.SetearAtributoInteger( toModeloResponse, "Orden", toEntidad.Orden)
			this.SetearAtributoString( toModeloResponse, "NumeroCuenta", toEntidad.NumeroCuenta)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Hora", toEntidad.Hora)
			this.SetearAtributoString( toModeloResponse, "Concepto", toEntidad.Concepto_PK)
			this.SetearAtributoString( toModeloResponse, "Referencia", toEntidad.Referencia)
			this.SetearAtributoString( toModeloResponse, "DatoAdicional1", toEntidad.DatoAdicional1)
			this.SetearAtributoString( toModeloResponse, "DatoAdicional2", toEntidad.DatoAdicional2)
			this.SetearAtributoString( toModeloResponse, "DatoAdicional3", toEntidad.DatoAdicional3)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDecimal( toModeloResponse, "Importe", toEntidad.Importe)
			this.SetearAtributoDecimal( toModeloResponse, "Saldo", toEntidad.Saldo)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuentabancaria", "CTABANC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Orden", "ORDEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hora", "HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Concepto", "CONCEPTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Referencia", "REFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datoadicional1", "DATAD1")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datoadicional2", "DATAD2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datoadicional3", "DATAD3")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "IDCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Importe", "IMPORTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Saldo", "SALDO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctabanc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Concepto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Refe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Datad1 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Datad2 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Datad3 LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine