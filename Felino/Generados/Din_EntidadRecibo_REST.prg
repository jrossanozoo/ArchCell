
define class Din_EntidadRecibo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Recibo"
	cClaseResponse = this.cNamespaceDTOs + ".ReciboResponse"
	cClaseModelo = "ReciboModelo"
	cEntidad = "Recibo"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ReciboModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ReciboModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ReciboListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ReciboListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ReciboModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montoconciliar", toEntidad, "Montoconciliar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedescripcion", toEntidad, "Clientedescripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letra", toEntidad, "Letra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Deuda", toEntidad, "Deuda" )
			this.SetearDetalleRecibodetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuento", toEntidad, "Porcentajedescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuentomonto", toEntidad, "Descuentomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodedescuento", toEntidad, "Montodedescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargoporcentaje", toEntidad, "Recargoporcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recargomonto", toEntidad, "Recargomonto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montoderecargo", toEntidad, "Montoderecargo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuentosyrecargosenvalores", toEntidad, "Descuentosyrecargosenvalores" )
			this.SetearDetalleRetencionesrecibidas( toEntidad, toModeloEnRequest )
			this.SetearDetalleValoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vueltovirtual", toEntidad, "Vueltovirtual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleReciboDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ReciboDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ReciboDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ReciboDetalle.LimpiarItem()
			else
				try
					toEntidad.ReciboDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ReciboDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Vencimiento", toEntidad.ReciboDetalle.oItem, "Vencimiento" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.ReciboDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.ReciboDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Saldoaux", toEntidad.ReciboDetalle.oItem, "SaldoAux" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ReciboDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Anotacion", toEntidad.ReciboDetalle.oItem, "Anotacion" )
			toEntidad.ReciboDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleRetencionesRecibidas( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "RetencionesRecibidas" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"RetencionesRecibidas[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.RetencionesRecibidas.LimpiarItem()
			else
				try
					toEntidad.RetencionesRecibidas.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.RetencionesRecibidas.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Impuesto", toEntidad.RetencionesRecibidas.oItem, "Impuesto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Impuestodetalle", toEntidad.RetencionesRecibidas.oItem, "ImpuestoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.RetencionesRecibidas.oItem, "Monto" )
			toEntidad.RetencionesRecibidas.Actualizar()
			
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
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.ValoresDetalle.oItem, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordetalle", toEntidad.ValoresDetalle.oItem, "ValorDetalle" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.ValoresDetalle.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerointerno", toEntidad.ValoresDetalle.oItem, "NumeroInterno" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ValoresDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentajedesrec", toEntidad.ValoresDetalle.oItem, "PorcentajeDesRec" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodesrec", toEntidad.ValoresDetalle.oItem, "MontoDesRec" )
			if !llEsTarjeta and !llDebePedirDatosCheque
				if toEntidad.ValoresDetalle.oItem.Valor.Tipo == 8 or llDebeSetearNumeroInternoCheque
					this.ManejarDatosExtraValor( toEntidad, loItem )
				else
					this.SetearAtributoModeloEnEntidad( loItem, "Recibido", toEntidad.ValoresDetalle.oItem, "Recibido" )
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
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoDecimal( toModeloResponse, "MontoConciliar", toEntidad.MontoConciliar)
			this.SetearAtributoString( toModeloResponse, "ClienteDescripcion", toEntidad.ClienteDescripcion)
			this.SetearAtributoString( toModeloResponse, "Letra", toEntidad.Letra)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDecimal( toModeloResponse, "Deuda", toEntidad.Deuda)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.CargarColeccionModeloReciboDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuento", toEntidad.PorcentajeDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "DescuentoMonto", toEntidad.DescuentoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDeDescuento", toEntidad.MontoDeDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoPorcentaje", toEntidad.RecargoPorcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "RecargoMonto", toEntidad.RecargoMonto)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDeRecargo", toEntidad.MontoDeRecargo)
			this.SetearAtributoDecimal( toModeloResponse, "DescuentosYRecargosEnValores", toEntidad.DescuentosYRecargosEnValores)
			this.CargarColeccionModeloRetencionesRecibidas( toModeloResponse, toEntidad )
			this.CargarColeccionModeloValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "VueltoVirtual", toEntidad.VueltoVirtual)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloReciboDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ReciboDetalle" ) 
		with toEntidad
			for lnI = 1 to .ReciboDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRecibo" )
				this.SetearAtributoString( loItem, "Codigo", .ReciboDetalle.Item(lnI).Codigo)
				this.SetearAtributoDatetime( loItem, "Vencimiento", .ReciboDetalle.Item(lnI).Vencimiento)
				this.SetearAtributoDatetime( loItem, "Fecha", .ReciboDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Descripcion", .ReciboDetalle.Item(lnI).Descripcion)
				this.SetearAtributoDecimal( loItem, "SaldoAux", .ReciboDetalle.Item(lnI).SaldoAux)
				this.SetearAtributoDecimal( loItem, "Monto", .ReciboDetalle.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "Anotacion", .ReciboDetalle.Item(lnI).Anotacion)
				this.SetearAtributoInteger( loItem, "NroItem", .ReciboDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloRetencionesRecibidas( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "RetencionesRecibidas" ) 
		with toEntidad
			for lnI = 1 to .RetencionesRecibidas.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRetencionrecibo" )
				this.SetearAtributoString( loItem, "Codigo", .RetencionesRecibidas.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Impuesto", .RetencionesRecibidas.Item(lnI).Impuesto_PK)
				this.SetearAtributoString( loItem, "ImpuestoDetalle", .RetencionesRecibidas.Item(lnI).ImpuestoDetalle)
				this.SetearAtributoDecimal( loItem, "Monto", .RetencionesRecibidas.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .RetencionesRecibidas.Item(lnI).NroItem )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValores" )
				this.SetearAtributoString( loItem, "Codigo", .ValoresDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Valor", .ValoresDetalle.Item(lnI).Valor_PK)
				this.SetearAtributoString( loItem, "ValorDetalle", .ValoresDetalle.Item(lnI).ValorDetalle)
				this.SetearAtributoDatetime( loItem, "Fecha", .ValoresDetalle.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "NumeroInterno", .ValoresDetalle.Item(lnI).NumeroInterno)
				this.SetearAtributoDecimal( loItem, "Monto", .ValoresDetalle.Item(lnI).Monto)
				this.SetearAtributoDecimal( loItem, "PorcentajeDesRec", .ValoresDetalle.Item(lnI).PorcentajeDesRec)
				this.SetearAtributoDecimal( loItem, "MontoDesRec", .ValoresDetalle.Item(lnI).MontoDesRec)
				this.SetearAtributoDecimal( loItem, "Recibido", .ValoresDetalle.Item(lnI).Recibido)
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
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "FVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedescripcion", "FCLIENTE")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fcliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fobs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine