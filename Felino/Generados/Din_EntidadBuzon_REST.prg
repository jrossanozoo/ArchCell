
define class Din_EntidadBuzon_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Buzon"
	cClaseResponse = this.cNamespaceDTOs + ".BuzonResponse"
	cClaseModelo = "BuzonModelo"
	cEntidad = "Buzon"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Codigo" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Codigo = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Codigo = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "BuzonModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "BuzonModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "BuzonListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "BuzonListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "BuzonModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Directorio", toEntidad, "Directorio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serie", toEntidad, "Serie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Origendedatos", toEntidad, "Origendedatos_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comportamiento", toEntidad, "Comportamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Origenfranquicia", toEntidad, "Origenfranquicia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientefranquicia", toEntidad, "Clientefranquicia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedorfranquicia", toEntidad, "Proveedorfranquicia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "DIRECTORIO", toEntidad.DIRECTORIO)
			this.SetearAtributoLong( toModeloResponse, "Serie", toEntidad.Serie)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoString( toModeloResponse, "OrigenDeDatos", toEntidad.OrigenDeDatos_PK)
			this.SetearAtributoString( toModeloResponse, "CLIENTE", toEntidad.CLIENTE_PK)
			this.SetearAtributoString( toModeloResponse, "PROVEEDOR", toEntidad.PROVEEDOR_PK)
			this.SetearAtributoInteger( toModeloResponse, "Comportamiento", toEntidad.Comportamiento)
			this.SetearAtributoString( toModeloResponse, "OrigenFranquicia", toEntidad.OrigenFranquicia_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteFranquicia", toEntidad.ClienteFranquicia_PK)
			this.SetearAtributoString( toModeloResponse, "ProveedorFranquicia", toEntidad.ProveedorFranquicia_PK)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serie", "HSERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BDATOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Origendedatos", "HSUCORI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "CLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "PROVEEDOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comportamiento", "COMPORT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Origenfranquicia", "ORIGFRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientefranquicia", "CLIEFRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedorfranquicia", "PROVFRAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hoscod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bdatos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hsucori LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Proveedor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Origfran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliefran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Provfran LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine