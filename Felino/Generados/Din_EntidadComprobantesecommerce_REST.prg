
define class Din_EntidadComprobantesecommerce_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Comprobantesecommerce"
	cClaseResponse = this.cNamespaceDTOs + ".ComprobantesecommerceResponse"
	cClaseModelo = "ComprobantesecommerceModelo"
	cEntidad = "Comprobantesecommerce"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numero" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numero = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numero = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantesecommerceModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantesecommerceModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantesecommerceListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantesecommerceListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantesecommerceModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ecommerce", toEntidad, "Ecommerce_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearDetalleDetalleoperaciones( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleOperaciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleOperaciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleOperaciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleOperaciones.LimpiarItem()
			else
				try
					toEntidad.DetalleOperaciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleOperaciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Numerooperacion", toEntidad.DetalleOperaciones.oItem, "NumeroOperacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.DetalleOperaciones.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.DetalleOperaciones.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedescripcion", toEntidad.DetalleOperaciones.oItem, "ClienteDescripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedragon", toEntidad.DetalleOperaciones.oItem, "ClienteDragon_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Envio", toEntidad.DetalleOperaciones.oItem, "Envio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Fullenvios", toEntidad.DetalleOperaciones.oItem, "FullEnvios" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cancelada", toEntidad.DetalleOperaciones.oItem, "Cancelada" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocomprobante", toEntidad.DetalleOperaciones.oItem, "TipoComprobante" )
			this.SetearAtributoModeloEnEntidad( loItem, "Pagado", toEntidad.DetalleOperaciones.oItem, "Pagado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Buzon", toEntidad.DetalleOperaciones.oItem, "Buzon" )
			this.SetearAtributoModeloEnEntidad( loItem, "Basededatos", toEntidad.DetalleOperaciones.oItem, "BaseDeDatos" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerocomprobante", toEntidad.DetalleOperaciones.oItem, "NumeroComprobante" )
			toEntidad.DetalleOperaciones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Ecommerce", toEntidad.Ecommerce_PK)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.CargarColeccionModeloDetalleOperaciones( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleOperaciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleOperaciones" ) 
		with toEntidad
			for lnI = 1 to .DetalleOperaciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOperacionesecom" )
				this.SetearAtributoLong( loItem, "Numero", .DetalleOperaciones.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "NumeroOperacion", .DetalleOperaciones.Item(lnI).NumeroOperacion)
				this.SetearAtributoInteger( loItem, "Cantidad", .DetalleOperaciones.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "Monto", .DetalleOperaciones.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "ClienteDescripcion", .DetalleOperaciones.Item(lnI).ClienteDescripcion)
				this.SetearAtributoString( loItem, "ClienteDragon", .DetalleOperaciones.Item(lnI).ClienteDragon_PK)
				this.SetearAtributoString( loItem, "Envio", .DetalleOperaciones.Item(lnI).Envio)
				this.SetearAtributo( loItem, "FullEnvios", .DetalleOperaciones.Item(lnI).FullEnvios)
				this.SetearAtributo( loItem, "Cancelada", .DetalleOperaciones.Item(lnI).Cancelada)
				this.SetearAtributoString( loItem, "TipoComprobante", .DetalleOperaciones.Item(lnI).TipoComprobante)
				this.SetearAtributo( loItem, "Pagado", .DetalleOperaciones.Item(lnI).Pagado)
				this.SetearAtributoString( loItem, "Buzon", .DetalleOperaciones.Item(lnI).Buzon)
				this.SetearAtributoString( loItem, "BaseDeDatos", .DetalleOperaciones.Item(lnI).BaseDeDatos)
				this.SetearAtributoString( loItem, "NumeroComprobante", .DetalleOperaciones.Item(lnI).NumeroComprobante)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleOperaciones.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ecommerce", "ECOMMERCE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ecommerce LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine