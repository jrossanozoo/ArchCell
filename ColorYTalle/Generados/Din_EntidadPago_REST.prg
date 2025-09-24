
define class Din_EntidadPago_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Pago"
	cClaseResponse = this.cNamespaceDTOs + ".PagoResponse"
	cClaseModelo = "PagoModelo"
	cEntidad = "Pago"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PagoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "PagoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "PagoListarRequest"
			case tcOperacion == "Anular"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PagoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "PagoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendepago", toEntidad, "Ordendepago_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendepago_proveedor", toEntidad, "Ordendepago_proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendepago_monedacomprobante", toEntidad, "Ordendepago_monedacomprobante_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Ordendepago_fecha", toEntidad, "Ordendepago_fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendepago_cotizacion", toEntidad, "Ordendepago_cotizacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recibo", toEntidad, "Recibo" )
			this.SetearDetalleOrdendepago_pagodetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleOrdendepago_valoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendepago_obs", toEntidad, "Ordendepago_obs" )
			this.SetearDetalleOrdendepago_impuestoscomprobante( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ordendepago_total", toEntidad, "Ordendepago_total" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenDePago_PagoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenDePago_PagoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenDePago_PagoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenDePago_PagoDetalle.LimpiarItem()
			else
				try
					toEntidad.OrdenDePago_PagoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenDePago_PagoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.OrdenDePago_PagoDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Emision", toEntidad.OrdenDePago_PagoDetalle.oItem, "Emision" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Vencimiento", toEntidad.OrdenDePago_PagoDetalle.oItem, "Vencimiento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.OrdenDePago_PagoDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Anotacion", toEntidad.OrdenDePago_PagoDetalle.oItem, "Anotacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoaux", toEntidad.OrdenDePago_PagoDetalle.oItem, "SaldoAux" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.OrdenDePago_PagoDetalle.oItem, "Monto" )
			toEntidad.OrdenDePago_PagoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenDePago_ValoresDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenDePago_ValoresDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenDePago_ValoresDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenDePago_ValoresDetalle.LimpiarItem()
			else
				try
					toEntidad.OrdenDePago_ValoresDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenDePago_ValoresDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.OrdenDePago_ValoresDetalle.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.OrdenDePago_ValoresDetalle.oItem, "ValorDetalle" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.OrdenDePago_ValoresDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.OrdenDePago_ValoresDetalle.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.OrdenDePago_ValoresDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargoporcentaje", toEntidad.OrdenDePago_ValoresDetalle.oItem, "RecargoPorcentaje" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargomonto", toEntidad.OrdenDePago_ValoresDetalle.oItem, "RecargoMonto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.OrdenDePago_ValoresDetalle.oItem, "Total" )
			toEntidad.OrdenDePago_ValoresDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenDePago_ImpuestosComprobante( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenDePago_ImpuestosComprobante" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenDePago_ImpuestosComprobante[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenDePago_ImpuestosComprobante.LimpiarItem()
			else
				try
					toEntidad.OrdenDePago_ImpuestosComprobante.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenDePago_ImpuestosComprobante.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codimp", toEntidad.OrdenDePago_ImpuestosComprobante.oItem, "CodImp_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codimpdetalle", toEntidad.OrdenDePago_ImpuestosComprobante.oItem, "CodImpDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.OrdenDePago_ImpuestosComprobante.oItem, "Monto" )
			toEntidad.OrdenDePago_ImpuestosComprobante.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "OrdenDePago", toEntidad.OrdenDePago_PK)
			this.SetearAtributoString( toModeloResponse, "OrdenDePago_Proveedor", toEntidad.OrdenDePago_Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "OrdenDePago_MonedaComprobante", toEntidad.OrdenDePago_MonedaComprobante_PK)
			this.SetearAtributoDateTime( toModeloResponse, "OrdenDePago_Fecha", toEntidad.OrdenDePago_Fecha)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDecimal( toModeloResponse, "OrdenDePago_Cotizacion", toEntidad.OrdenDePago_Cotizacion)
			this.SetearAtributoString( toModeloResponse, "Recibo", toEntidad.Recibo)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloOrdenDePago_PagoDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloOrdenDePago_ValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "OrdenDePago_Obs", toEntidad.OrdenDePago_Obs)
			this.CargarColeccionModeloOrdenDePago_ImpuestosComprobante( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "OrdenDePago_Total", toEntidad.OrdenDePago_Total)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.CargarColeccionModeloNoPermiteModificacion( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenDePago_PagoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenDePago_PagoDetalle" ) 
		with toEntidad
			for lnI = 1 to .OrdenDePago_PagoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPago" )
				this.SetearAtributoString( loItem, "Codigo", .OrdenDePago_PagoDetalle.Item(lnI).Codigo)
				this.SetearAtributoDatetime( loItem, "Fecha", .OrdenDePago_PagoDetalle.Item(lnI).Fecha)
				this.SetearAtributoDatetime( loItem, "Emision", .OrdenDePago_PagoDetalle.Item(lnI).Emision)
				this.SetearAtributoDatetime( loItem, "Vencimiento", .OrdenDePago_PagoDetalle.Item(lnI).Vencimiento)
				this.SetearAtributoString( loItem, "Descripcion", .OrdenDePago_PagoDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Anotacion", .OrdenDePago_PagoDetalle.Item(lnI).Anotacion)
				this.SetearAtributoDecimal( loItem, "SaldoAux", .OrdenDePago_PagoDetalle.Item(lnI).SaldoAux)
				this.SetearAtributoDecimal( loItem, "Monto", .OrdenDePago_PagoDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenDePago_PagoDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenDePago_ValoresDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenDePago_ValoresDetalle" ) 
		with toEntidad
			for lnI = 1 to .OrdenDePago_ValoresDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPagovalores" )
				this.SetearAtributoString( loItem, "Codigo", .OrdenDePago_ValoresDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .OrdenDePago_ValoresDetalle.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .OrdenDePago_ValoresDetalle.Item(lnI).ValorDetalle)
				this.SetearAtributoDatetime( loItem, "Fecha", .OrdenDePago_ValoresDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "NumeroInterno", .OrdenDePago_ValoresDetalle.Item(lnI).NumeroInterno)
				this.SetearAtributoDecimal( loItem, "Monto", .OrdenDePago_ValoresDetalle.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "RecargoPorcentaje", .OrdenDePago_ValoresDetalle.Item(lnI).RecargoPorcentaje)
				this.SetearAtributoDecimal( loItem, "RecargoMonto", .OrdenDePago_ValoresDetalle.Item(lnI).RecargoMonto)
				this.SetearAtributoDecimal( loItem, "Total", .OrdenDePago_ValoresDetalle.Item(lnI).Total)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenDePago_ValoresDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenDePago_ImpuestosComprobante( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenDePago_ImpuestosComprobante" ) 
		with toEntidad
			for lnI = 1 to .OrdenDePago_ImpuestosComprobante.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpuestopago" )
				this.SetearAtributoString( loItem, "Codigo", .OrdenDePago_ImpuestosComprobante.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodImp", .OrdenDePago_ImpuestosComprobante.Item(lnI).CodImp_PK)
				this.SetearAtributoString( loItem, "CodImpDetalle", .OrdenDePago_ImpuestosComprobante.Item(lnI).CodImpDetalle)
				this.SetearAtributoDecimal( loItem, "Monto", .OrdenDePago_ImpuestosComprobante.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenDePago_ImpuestosComprobante.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago", "OPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago_proveedor", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago_monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago_fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHAP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago_cotizacion", "COTIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recibo", "RECIBO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago_obs", "CONVERT( VARCHAR(MAX), FOPOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ordendepago_total", "FTOTAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), FOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Opago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fperson LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Recibo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fopobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloNoPermiteModificacion( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		if this.lPermiteModificacion
			loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "NoPermiteModificacion" )
			loColeccionObservaciones = toEntidad.ObtenerResultadoDeVotacion()
			for lnI = 1 to loColeccionObservaciones.Count
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loColeccionObservaciones.Item[lnI] )
			endfor
		endif
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerXmlDatosEntidad( toEntidad as Object, toRequest as Object ) as String
		loRequestDesempaquetada = this.DesempaquetarRequest( toRequest )
		this.lPermiteModificacion = _screen.DotNetBridge.ObtenerValorPropiedad( loRequestDesempaquetada , "AgregarModificacion" )
		return dodefault( toEntidad, toRequest )
	endfunc

enddefine