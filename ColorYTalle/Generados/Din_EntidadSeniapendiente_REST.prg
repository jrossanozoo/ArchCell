
define class Din_EntidadSeniapendiente_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Seniapendiente"
	cClaseResponse = this.cNamespaceDTOs + ".SeniapendienteResponse"
	cClaseModelo = "SeniapendienteModelo"
	cEntidad = "Seniapendiente"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Cliente" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Cliente = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Cliente = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "SeniapendienteModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeniapendienteModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeniapendienteListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeniapendienteListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SeniapendienteModelo"
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
			this.SetearDetalleDetalleseniaspendientes( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleSeniasPendientes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleSeniasPendientes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleSeniasPendientes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleSeniasPendientes.LimpiarItem()
			else
				try
					toEntidad.DetalleSeniasPendientes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleSeniasPendientes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobante", toEntidad.DetalleSeniasPendientes.oItem, "Comprobante" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaalta", toEntidad.DetalleSeniasPendientes.oItem, "FechaAlta" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechavto", toEntidad.DetalleSeniasPendientes.oItem, "FechaVto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Importe", toEntidad.DetalleSeniasPendientes.oItem, "Importe" )
			this.SetearAtributoModeloEnEntidad( loItem, "Moneda", toEntidad.DetalleSeniasPendientes.oItem, "Moneda" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seleccionada", toEntidad.DetalleSeniasPendientes.oItem, "Seleccionada" )
			toEntidad.DetalleSeniasPendientes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente)
			this.CargarColeccionModeloDetalleSeniasPendientes( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleSeniasPendientes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleSeniasPendientes" ) 
		with toEntidad
			for lnI = 1 to .DetalleSeniasPendientes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemSeniapendiente" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleSeniasPendientes.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Comprobante", .DetalleSeniasPendientes.Item(lnI).Comprobante)
				this.SetearAtributoDatetime( loItem, "FechaAlta", .DetalleSeniasPendientes.Item(lnI).FechaAlta)
				this.SetearAtributoDatetime( loItem, "FechaVto", .DetalleSeniasPendientes.Item(lnI).FechaVto)
				this.SetearAtributoDecimal( loItem, "Importe", .DetalleSeniasPendientes.Item(lnI).Importe)
				this.SetearAtributoString( loItem, "Moneda", .DetalleSeniasPendientes.Item(lnI).Moneda)
				this.SetearAtributo( loItem, "Seleccionada", .DetalleSeniasPendientes.Item(lnI).Seleccionada)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleSeniasPendientes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
		endif
	
		return lcRetorno 
	endfunc
	

enddefine