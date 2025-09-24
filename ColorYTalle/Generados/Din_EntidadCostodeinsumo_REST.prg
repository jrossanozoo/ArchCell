
define class Din_EntidadCostodeinsumo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Costodeinsumo"
	cClaseResponse = this.cNamespaceDTOs + ".CostodeinsumoResponse"
	cClaseModelo = "CostodeinsumoModelo"
	cEntidad = "Costodeinsumo"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CostodeinsumoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CostodeinsumoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CostodeinsumoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CostodeinsumoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CostodeinsumoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Insumo", toEntidad, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Color", toEntidad, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Talle", toEntidad, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadecosto", toEntidad, "Listadecosto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Costodirecto", toEntidad, "Costodirecto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proceso", toEntidad, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Taller", toEntidad, "Taller_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Desdecantidad", toEntidad, "Desdecantidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Insumo", toEntidad.Insumo_PK)
			this.SetearAtributoString( toModeloResponse, "Color", toEntidad.Color_PK)
			this.SetearAtributoString( toModeloResponse, "Talle", toEntidad.Talle_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDeCosto", toEntidad.ListaDeCosto_PK)
			this.SetearAtributoDecimal( toModeloResponse, "CostoDirecto", toEntidad.CostoDirecto)
			this.SetearAtributoString( toModeloResponse, "Proceso", toEntidad.Proceso_PK)
			this.SetearAtributoString( toModeloResponse, "Taller", toEntidad.Taller_PK)
			this.SetearAtributoInteger( toModeloResponse, "DesdeCantidad", toEntidad.DesdeCantidad)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Insumo", "INSUMO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Color", "CCOLOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Talle", "TALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadecosto", "LISTACOST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Costodirecto", "CDIRECTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proceso", "PROCESO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Taller", "TALLER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Desdecantidad", "CANTIDAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Insumo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccolor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Talle LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Listacost LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Proceso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Taller LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine