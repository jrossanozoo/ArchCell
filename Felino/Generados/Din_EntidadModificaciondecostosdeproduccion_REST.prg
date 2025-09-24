
define class Din_EntidadModificaciondecostosdeproduccion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Modificaciondecostosdeproduccion"
	cClaseResponse = this.cNamespaceDTOs + ".ModificaciondecostosdeproduccionResponse"
	cClaseModelo = "ModificaciondecostosdeproduccionModelo"
	cEntidad = "Modificaciondecostosdeproduccion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ModificaciondecostosdeproduccionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModificaciondecostosdeproduccionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModificaciondecostosdeproduccionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ModificaciondecostosdeproduccionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ModificaciondecostosdeproduccionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observ", toEntidad, "Observ" )
			this.SetearDetalleModcostos( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleModCostos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModCostos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModCostos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModCostos.LimpiarItem()
			else
				try
					toEntidad.ModCostos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModCostos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.ModCostos.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.ModCostos.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ModCostos.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ModCostos.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.ModCostos.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesodetalle", toEntidad.ModCostos.oItem, "ProcesoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Taller", toEntidad.ModCostos.oItem, "Taller_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallerdetalle", toEntidad.ModCostos.oItem, "TallerDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desdecantidad", toEntidad.ModCostos.oItem, "DesdeCantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Listadecosto", toEntidad.ModCostos.oItem, "ListaDeCosto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costodelista", toEntidad.ModCostos.oItem, "CostoDeLista" )
			this.SetearAtributoModeloEnEntidad( loItem, "Costoactualizado", toEntidad.ModCostos.oItem, "CostoActualizado" )
			toEntidad.ModCostos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Observ", toEntidad.Observ)
			this.CargarColeccionModeloModCostos( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloModCostos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModCostos" ) 
		with toEntidad
			for lnI = 1 to .ModCostos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemModcostoprod" )
				this.SetearAtributoString( loItem, "Codigo", .ModCostos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Semielaborado", .ModCostos.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .ModCostos.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .ModCostos.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ModCostos.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Proceso", .ModCostos.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ProcesoDetalle", .ModCostos.Item(lnI).ProcesoDetalle)
				this.SetearAtributoString( loItem, "Taller", .ModCostos.Item(lnI).Taller_PK)
				this.SetearAtributoString( loItem, "TallerDetalle", .ModCostos.Item(lnI).TallerDetalle)
				this.SetearAtributoInteger( loItem, "DesdeCantidad", .ModCostos.Item(lnI).DesdeCantidad)
				this.SetearAtributoString( loItem, "ListaDeCosto", .ModCostos.Item(lnI).ListaDeCosto_PK)
				this.SetearAtributoDecimal( loItem, "CostoDeLista", .ModCostos.Item(lnI).CostoDeLista)
				this.SetearAtributoDecimal( loItem, "CostoActualizado", .ModCostos.Item(lnI).CostoActualizado)
				this.SetearAtributoInteger( loItem, "NroItem", .ModCostos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observ", "CONVERT( VARCHAR(MAX), COBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine