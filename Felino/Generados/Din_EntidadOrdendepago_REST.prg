
define class Din_EntidadOrdendepago_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Ordendepago"
	cClaseResponse = this.cNamespaceDTOs + ".OrdendepagoResponse"
	cClaseModelo = "OrdendepagoModelo"
	cEntidad = "Ordendepago"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendepagoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendepagoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendepagoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendepagoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendepagoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuario", toEntidad, "Usuario" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante", toEntidad, "Monedacomprobante_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montoconciliar", toEntidad, "Montoconciliar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cotizacion", toEntidad, "Cotizacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedordescripcion", toEntidad, "Proveedordescripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Deuda", toEntidad, "Deuda" )
			this.SetearDetalleOrdendepagodetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleImpuestoscomprobante( toEntidad, toModeloEnRequest )
			this.SetearDetalleValoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOrdenDePagoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OrdenDePagoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OrdenDePagoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OrdenDePagoDetalle.LimpiarItem()
			else
				try
					toEntidad.OrdenDePagoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OrdenDePagoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.OrdenDePagoDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Emision", toEntidad.OrdenDePagoDetalle.oItem, "Emision" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Vencimiento", toEntidad.OrdenDePagoDetalle.oItem, "Vencimiento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.OrdenDePagoDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoaux", toEntidad.OrdenDePagoDetalle.oItem, "SaldoAux" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.OrdenDePagoDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Anotacion", toEntidad.OrdenDePagoDetalle.oItem, "Anotacion" )
			toEntidad.OrdenDePagoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleImpuestosComprobante( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ImpuestosComprobante" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ImpuestosComprobante[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ImpuestosComprobante.LimpiarItem()
			else
				try
					toEntidad.ImpuestosComprobante.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ImpuestosComprobante.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codimp", toEntidad.ImpuestosComprobante.oItem, "CodImp_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codimpdetalle", toEntidad.ImpuestosComprobante.oItem, "CodImpDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ImpuestosComprobante.oItem, "Monto" )
			toEntidad.ImpuestosComprobante.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleValoresDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		local lcValor as String, llEsTarjeta as Boolean, llEsChequeDeTercero as Boolean, llEsChequePropio as Boolean 
		local llDebePedirDatosCheque as Boolean, llDebeSetearNumeroInternoCheque as Boolean 
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ValoresDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ValoresDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ValoresDetalle.LimpiarItem()
			else
				try
					toEntidad.ValoresDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ValoresDetalle.LimpiarItem()
				endtry 
			endif
			lcValor = _screen.dotnetbridge.ObtenerValorpropiedad( loItem, "Valor" )
			llEsTarjeta = this.VerificarSiValorEsTipoTarjeta( lcValor )
			if !llEsTarjeta
				llDebePedirDatosCheque = this.DebePedirDatosCheque( lcValor )
				if !llDebePedirDatosCheque
					llDebeSetearNumeroInternoCheque = this.DebeSetearNumeroInternoCheque( lcValor )
				endif
			endif
			if llEsTarjeta
				this.SetearAtributoModeloEnEntidad( loItem, "Recibido", this, "nMontoParaCupon" )
				this.SetearAtributoModeloEnEntidad( loItem, "DatosTarjeta", this, "oDatosTarjetaRequest" )
				this.BindearEvento( toEntidad, "EventoObtenerDatosDelCupon", this, "ManejarCupon" )
			else
				if llDebePedirDatosCheque
					this.BindearEvento( toEntidad.ValoresDetalle.oItem.oCompCajero.oCompChequesPropios, "EventoPedirCheque", this, "ManejarCheque" )
					this.SetearAtributoModeloEnEntidad( loItem, "DatosCheque", this, "oDatosChequeRequest" )
				endif
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ValoresDetalle.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.ValoresDetalle.oItem, "ValorDetalle" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.ValoresDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.ValoresDetalle.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ValoresDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargoporcentaje", toEntidad.ValoresDetalle.oItem, "RecargoPorcentaje" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargomonto", toEntidad.ValoresDetalle.oItem, "RecargoMonto" )
			if !llEsTarjeta and !llDebePedirDatosCheque
				if toEntidad.ValoresDetalle.oItem.Valor.Tipo == 8 or llDebeSetearNumeroInternoCheque
					this.ManejarDatosExtraValor( toEntidad, loItem )
				else
					this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.ValoresDetalle.oItem, "Total" )
				endif
			endif
			this.DesBindearEvento( toEntidad, "EventoObtenerDatosDelCupon", this, "ManejarCupon" )
			if llDebePedirDatosCheque
				this.DesBindearEvento( toEntidad.ValoresDetalle.oItem.oCompCajero.oCompChequesPropios, "EventoPedirCheque", this, "ManejarCheque" )
			endif
			toEntidad.ValoresDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "Usuario", toEntidad.Usuario)
			this.SetearAtributoString( toModeloResponse, "MonedaComprobante", toEntidad.MonedaComprobante_PK)
			this.SetearAtributoDecimal( toModeloResponse, "MontoConciliar", toEntidad.MontoConciliar)
			this.SetearAtributoDecimal( toModeloResponse, "Cotizacion", toEntidad.Cotizacion)
			this.SetearAtributoString( toModeloResponse, "ProveedorDescripcion", toEntidad.ProveedorDescripcion)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDecimal( toModeloResponse, "Deuda", toEntidad.Deuda)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloOrdenDePagoDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloImpuestosComprobante( toModeloResponse, toEntidad )
			this.CargarColeccionModeloValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOrdenDePagoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OrdenDePagoDetalle" ) 
		with toEntidad
			for lnI = 1 to .OrdenDePagoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOrdendepago" )
				this.SetearAtributoString( loItem, "Codigo", .OrdenDePagoDetalle.Item(lnI).Codigo)
				this.SetearAtributoDatetime( loItem, "Fecha", .OrdenDePagoDetalle.Item(lnI).Fecha)
				this.SetearAtributoDatetime( loItem, "Emision", .OrdenDePagoDetalle.Item(lnI).Emision)
				this.SetearAtributoDatetime( loItem, "Vencimiento", .OrdenDePagoDetalle.Item(lnI).Vencimiento)
				this.SetearAtributoString( loItem, "Descripcion", .OrdenDePagoDetalle.Item(lnI).Descripcion)
				this.SetearAtributoDecimal( loItem, "SaldoAux", .OrdenDePagoDetalle.Item(lnI).SaldoAux)
				this.SetearAtributoDecimal( loItem, "Monto", .OrdenDePagoDetalle.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "Anotacion", .OrdenDePagoDetalle.Item(lnI).Anotacion)
				this.SetearAtributoInteger( loItem, "NroItem", .OrdenDePagoDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloImpuestosComprobante( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ImpuestosComprobante" ) 
		with toEntidad
			for lnI = 1 to .ImpuestosComprobante.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpuestoordendepago" )
				this.SetearAtributoString( loItem, "Codigo", .ImpuestosComprobante.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodImp", .ImpuestosComprobante.Item(lnI).CodImp_PK)
				this.SetearAtributoString( loItem, "CodImpDetalle", .ImpuestosComprobante.Item(lnI).CodImpDetalle)
				this.SetearAtributoDecimal( loItem, "Monto", .ImpuestosComprobante.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .ImpuestosComprobante.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloValoresDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ValoresDetalle" ) 
		with toEntidad
			for lnI = 1 to .ValoresDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValorescompra" )
				this.SetearAtributoString( loItem, "Codigo", .ValoresDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .ValoresDetalle.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .ValoresDetalle.Item(lnI).ValorDetalle)
				this.SetearAtributoDatetime( loItem, "Fecha", .ValoresDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "NumeroInterno", .ValoresDetalle.Item(lnI).NumeroInterno)
				this.SetearAtributoDecimal( loItem, "Monto", .ValoresDetalle.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "RecargoPorcentaje", .ValoresDetalle.Item(lnI).RecargoPorcentaje)
				this.SetearAtributoDecimal( loItem, "RecargoMonto", .ValoresDetalle.Item(lnI).RecargoMonto)
				this.SetearAtributoDecimal( loItem, "Total", .ValoresDetalle.Item(lnI).Total)
				this.SetearDatosExtraDelItem( loItem, toEntidad, lnI )
				this.SetearAtributoInteger( loItem, "NroItem", .ValoresDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuario", "FVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cotizacion", "COTIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedordescripcion", "FPROVED")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "FTOTAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), FOBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fperson LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fven LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fproved LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine