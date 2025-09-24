
define class Din_EntidadFechacancelacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Fechacancelacion"
	cClaseResponse = this.cNamespaceDTOs + ".FechacancelacionResponse"
	cClaseModelo = "FechacancelacionModelo"
	cEntidad = "Fechacancelacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FechacancelacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "FechacancelacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "FechacancelacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "FechacancelacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "FechacancelacionModelo"
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
			this.SetearDetalleDetallefechacancelacion( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleFechaCancelacion( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleFechaCancelacion" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleFechaCancelacion[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleFechaCancelacion.LimpiarItem()
			else
				try
					toEntidad.DetalleFechaCancelacion.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleFechaCancelacion.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Idpublicacion", toEntidad.DetalleFechaCancelacion.oItem, "IDPublicacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.DetalleFechaCancelacion.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.DetalleFechaCancelacion.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.DetalleFechaCancelacion.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.DetalleFechaCancelacion.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.DetalleFechaCancelacion.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.DetalleFechaCancelacion.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.DetalleFechaCancelacion.oItem, "Monto" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechacancelacion", toEntidad.DetalleFechaCancelacion.oItem, "FechaCancelacion" )
			toEntidad.DetalleFechaCancelacion.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloDetalleFechaCancelacion( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleFechaCancelacion( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleFechaCancelacion" ) 
		with toEntidad
			for lnI = 1 to .DetalleFechaCancelacion.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemFechacancelacion" )
				this.SetearAtributoString( loItem, "Codigo", .DetalleFechaCancelacion.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "IDPublicacion", .DetalleFechaCancelacion.Item(lnI).IDPublicacion)
				this.SetearAtributoString( loItem, "Articulo", .DetalleFechaCancelacion.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .DetalleFechaCancelacion.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .DetalleFechaCancelacion.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "Talle", .DetalleFechaCancelacion.Item(lnI).Talle_PK)
				this.SetearAtributoLong( loItem, "Cantidad", .DetalleFechaCancelacion.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Precio", .DetalleFechaCancelacion.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Monto", .DetalleFechaCancelacion.Item(lnI).Monto)
				this.SetearAtributoDatetime( loItem, "FechaCancelacion", .DetalleFechaCancelacion.Item(lnI).FechaCancelacion)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleFechaCancelacion.Item(lnI).NroItem )
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