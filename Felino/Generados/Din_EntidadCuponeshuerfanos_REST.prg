
define class Din_EntidadCuponeshuerfanos_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Cuponeshuerfanos"
	cClaseResponse = this.cNamespaceDTOs + ".CuponeshuerfanosResponse"
	cClaseModelo = "CuponeshuerfanosModelo"
	cEntidad = "Cuponeshuerfanos"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CuponeshuerfanosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CuponeshuerfanosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CuponeshuerfanosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CuponeshuerfanosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CuponeshuerfanosModelo"
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
			this.SetearDetalleCupones( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleCupones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Cupones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Cupones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Cupones.LimpiarItem()
			else
				try
					toEntidad.Cupones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Cupones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Interno", toEntidad.Cupones.oItem, "Interno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.Cupones.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerocupon", toEntidad.Cupones.oItem, "NumeroCupon" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.Cupones.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargo", toEntidad.Cupones.oItem, "Recargo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.Cupones.oItem, "Total" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cuotas", toEntidad.Cupones.oItem, "Cuotas" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.Cupones.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Hora", toEntidad.Cupones.oItem, "Hora" )
			this.SetearAtributoModeloEnEntidad( loItem, "Pos", toEntidad.Cupones.oItem, "POS" )
			this.SetearAtributoModeloEnEntidad( loItem, "Incluido", toEntidad.Cupones.oItem, "Incluido" )
			this.SetearAtributoModeloEnEntidad( loItem, "Moneda", toEntidad.Cupones.oItem, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Autorizacionpos", toEntidad.Cupones.oItem, "AutorizacionPOS" )
			toEntidad.Cupones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloCupones( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloCupones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Cupones" ) 
		with toEntidad
			for lnI = 1 to .Cupones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCuponhuerfano" )
				this.SetearAtributoString( loItem, "Codigo", .Cupones.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Interno", .Cupones.Item(lnI).Interno)
				this.SetearAtributoString( loItem, "NumeroInterno", .Cupones.Item(lnI).NumeroInterno)
				this.SetearAtributoLong( loItem, "NumeroCupon", .Cupones.Item(lnI).NumeroCupon)
				this.SetearAtributoDecimal( loItem, "Monto", .Cupones.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "Recargo", .Cupones.Item(lnI).Recargo)
				this.SetearAtributoDecimal( loItem, "Total", .Cupones.Item(lnI).Total)
				this.SetearAtributoInteger( loItem, "Cuotas", .Cupones.Item(lnI).Cuotas)
				this.SetearAtributoDatetime( loItem, "Fecha", .Cupones.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Hora", .Cupones.Item(lnI).Hora)
				this.SetearAtributoString( loItem, "POS", .Cupones.Item(lnI).POS)
				this.SetearAtributo( loItem, "Incluido", .Cupones.Item(lnI).Incluido)
				this.SetearAtributoString( loItem, "Moneda", .Cupones.Item(lnI).Moneda_PK)
				this.SetearAtributo( loItem, "AutorizacionPOS", .Cupones.Item(lnI).AutorizacionPOS)
				this.SetearAtributoInteger( loItem, "NroItem", .Cupones.Item(lnI).NroItem )
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