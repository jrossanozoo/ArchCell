
define class Din_EntidadNotadecreditocompra_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Notadecreditocompra"
	cClaseResponse = this.cNamespaceDTOs + ".NotadecreditocompraResponse"
	cClaseModelo = "NotadecreditocompraModelo"
	cEntidad = "Notadecreditocompra"
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
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditocompraModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditocompraModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditocompraListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditocompraListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "NotadecreditocompraModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocomprobanterg1361", toEntidad, "Tipocomprobanterg1361" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventaextendido", toEntidad, "Puntodeventaextendido" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante", toEntidad, "Monedacomprobante_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cotizacion", toEntidad, "Cotizacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numint", toEntidad, "Numint" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionpagopreferente", toEntidad, "Condicionpagopreferente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Remito", toEntidad, "Remito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafactura", toEntidad, "Fechafactura" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavencimiento", toEntidad, "Fechavencimiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cai", toEntidad, "Cai" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavtocai", toEntidad, "Fechavtocai" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Centrodecosto", toEntidad, "Centrodecosto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Distribucionporcentrodecosto", toEntidad, "Distribucionporcentrodecosto_PK" )
			this.SetearDetalleFacturadetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuento", toEntidad, "Porcentajedescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuento", toEntidad, "Descuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodescuentoconimpuestos3", toEntidad, "Montodescuentoconimpuestos3" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargoporcentaje", toEntidad, "Recargoporcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto", toEntidad, "Recargomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomontoconimpuestos", toEntidad, "Recargomontoconimpuestos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Impuestos", toEntidad, "Impuestos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto2", toEntidad, "Recargomonto2" )
			this.SetearDetalleImpuestoscomprobante( toEntidad, toModeloEnRequest )
			this.SetearDetalleValoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleFacturaDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "FacturaDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"FacturaDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.FacturaDetalle.LimpiarItem()
			else
				try
					toEntidad.FacturaDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.FacturaDetalle.LimpiarItem()
				endtry 
			endif
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.FacturaDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.FacturaDetalle.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.FacturaDetalle.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.FacturaDetalle.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.FacturaDetalle.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.FacturaDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.FacturaDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.FacturaDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.FacturaDetalle.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.FacturaDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.FacturaDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.FacturaDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.FacturaDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.FacturaDetalle.oItem, "Monto" )
			toEntidad.FacturaDetalle.Actualizar()
			
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
					this.BindearEvento( toEntidad.ValoresDetalle.oItem.oCompCajero.oCompChequesDeTerceros, "EventoPedirCheque", this, "ManejarCheque" )
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
				this.DesBindearEvento( toEntidad.ValoresDetalle.oItem.oCompCajero.oCompChequesDeTerceros, "EventoPedirCheque", this, "ManejarCheque" )
			endif
			toEntidad.ValoresDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "TipoComprobanteRG1361", toEntidad.TipoComprobanteRG1361)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaExtendido", toEntidad.PuntoDeVentaExtendido)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaComprobante", toEntidad.MonedaComprobante_PK)
			this.SetearAtributoDecimal( toModeloResponse, "Cotizacion", toEntidad.Cotizacion)
			this.SetearAtributoLong( toModeloResponse, "NumInt", toEntidad.NumInt)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "CondicionPagoPreferente", toEntidad.CondicionPagoPreferente_PK)
			this.SetearAtributoString( toModeloResponse, "Remito", toEntidad.Remito)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaFactura", toEntidad.FechaFactura)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVencimiento", toEntidad.FechaVencimiento)
			this.SetearAtributoLong( toModeloResponse, "CAI", toEntidad.CAI)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVtoCAI", toEntidad.FechaVtoCAI)
			this.SetearAtributoString( toModeloResponse, "CentroDeCosto", toEntidad.CentroDeCosto_PK)
			this.SetearAtributoString( toModeloResponse, "DistribucionPorCentroDeCosto", toEntidad.DistribucionPorCentroDeCosto_PK)
			this.CargarColeccionModeloFacturaDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuento", toEntidad.PorcentajeDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "Descuento", toEntidad.Descuento)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDescuentoConImpuestos3", toEntidad.MontoDescuentoConImpuestos3)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoPorcentaje", toEntidad.RecargoPorcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto", toEntidad.RecargoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMontoConImpuestos", toEntidad.RecargoMontoConImpuestos)
			this.SetearAtributoDecimal( toModeloResponse, "Impuestos", toEntidad.Impuestos)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto2", toEntidad.RecargoMonto2)
			this.CargarColeccionModeloImpuestosComprobante( toModeloResponse, toEntidad )
			this.CargarColeccionModeloValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloFacturaDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "FacturaDetalle" ) 
		with toEntidad
			for lnI = 1 to .FacturaDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemArticulosnccompra" )
				this.SetearAtributoString( loItem, "Articulo", .FacturaDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Codigo", .FacturaDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .FacturaDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .FacturaDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .FacturaDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .FacturaDetalle.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "Descuento", .FacturaDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Cantidad", .FacturaDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .FacturaDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDecimal( loItem, "Precio", .FacturaDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Monto", .FacturaDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .FacturaDetalle.Item(lnI).NroItem )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpuestonccompra" )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValoresnccompra" )
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
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocomprobanterg1361", "TCRG1361")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letra", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventaextendido", "FPTOVENEXT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cotizacion", "COTIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numint", "NUMINT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionpagopreferente", "CONDPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Remito", "NROREMITO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecios", "CODLISTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechafactura", "FFCHFAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavencimiento", "FFCHVENC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cai", "NCAI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavtocai", "FVTOCAI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Centrodecosto", "CCOSTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Distribucionporcentrodecosto", "DISCCOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedescuento", "FPODES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuento", "FDESCU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodescuentoconimpuestos3", "FMTDES3")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargoporcentaje", "RECPOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto", "MR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomontoconimpuestos", "RECMNTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Impuestos", "FIMPUESTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Recargomonto2", "RECMONTO2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), FOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Total", "FTOTAL")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fperson LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Condpago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nroremito LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codlista LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccosto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Disccos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine