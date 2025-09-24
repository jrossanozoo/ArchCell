
define class Din_EntidadAsociacionarticulosoperacionesafip_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Asociacionarticulosoperacionesafip"
	cClaseResponse = this.cNamespaceDTOs + ".AsociacionarticulosoperacionesafipResponse"
	cClaseModelo = "AsociacionarticulosoperacionesafipModelo"
	cEntidad = "Asociacionarticulosoperacionesafip"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Codint" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Codint = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Codint = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "AsociacionarticulosoperacionesafipModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "AsociacionarticulosoperacionesafipModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "AsociacionarticulosoperacionesafipListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AsociacionarticulosoperacionesafipListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "AsociacionarticulosoperacionesafipModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo", toEntidad, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Operacionventa", toEntidad, "Operacionventa_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Operacioncompra", toEntidad, "Operacioncompra_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "CodInt", toEntidad.CodInt)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Articulo", toEntidad.Articulo_PK)
			this.SetearAtributoString( toModeloResponse, "OperacionVenta", toEntidad.OperacionVenta_PK)
			this.SetearAtributoString( toModeloResponse, "OperacionCompra", toEntidad.OperacionCompra_PK)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "AONUM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulo", "AOART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Operacionventa", "AOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Operacioncompra", "AOCOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), AOOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aoart LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aoven LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aocom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aoobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine