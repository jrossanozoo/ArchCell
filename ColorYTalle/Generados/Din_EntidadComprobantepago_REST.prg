
define class Din_EntidadComprobantepago_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Comprobantepago"
	cClaseResponse = this.cNamespaceDTOs + ".ComprobantepagoResponse"
	cClaseModelo = "ComprobantepagoModelo"
	cEntidad = "Comprobantepago"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantepagoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantepagoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantepagoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantepagoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ComprobantepagoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Referencia", toEntidad, "Referencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monedacomprobante", toEntidad, "Monedacomprobante_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacompro", toEntidad, "Fechacompro" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Centrodecosto", toEntidad, "Centrodecosto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Distribucionporcentrodecosto", toEntidad, "Distribucionporcentrodecosto_PK" )
			this.SetearDetalleComprobantepagodetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleValoresdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Total", toEntidad, "Total" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleComprobantePagoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ComprobantePagoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ComprobantePagoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ComprobantePagoDetalle.LimpiarItem()
			else
				try
					toEntidad.ComprobantePagoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ComprobantePagoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Concepto", toEntidad.ComprobantePagoDetalle.oItem, "Concepto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Conceptodetalle", toEntidad.ComprobantePagoDetalle.oItem, "ConceptoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Centrodecosto", toEntidad.ComprobantePagoDetalle.oItem, "CentroDeCosto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Distribucioncentrodecosto", toEntidad.ComprobantePagoDetalle.oItem, "DistribucionCentroDeCosto_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ComprobantePagoDetalle.oItem, "Monto" )
			toEntidad.ComprobantePagoDetalle.Actualizar()
			
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
			this.SetearAtributoString( toModeloResponse, "Referencia", toEntidad.Referencia)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "MonedaComprobante", toEntidad.MonedaComprobante_PK)
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaCompro", toEntidad.FechaCompro)
			this.SetearAtributoString( toModeloResponse, "CentroDeCosto", toEntidad.CentroDeCosto_PK)
			this.SetearAtributoString( toModeloResponse, "DistribucionPorCentroDeCosto", toEntidad.DistribucionPorCentroDeCosto_PK)
			this.CargarColeccionModeloComprobantePagoDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloValoresDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoDecimal( toModeloResponse, "Total", toEntidad.Total)
			this.CargarColeccionModeloNoPermiteModificacion( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloComprobantePagoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ComprobantePagoDetalle" ) 
		with toEntidad
			for lnI = 1 to .ComprobantePagoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemComprobantepago" )
				this.SetearAtributoString( loItem, "Codigo", .ComprobantePagoDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Concepto", .ComprobantePagoDetalle.Item(lnI).Concepto_PK)
				this.SetearAtributoString( loItem, "ConceptoDetalle", .ComprobantePagoDetalle.Item(lnI).ConceptoDetalle)
				this.SetearAtributoString( loItem, "CentroDeCosto", .ComprobantePagoDetalle.Item(lnI).CentroDeCosto_PK)
				this.SetearAtributoString( loItem, "DistribucionCentroDeCosto", .ComprobantePagoDetalle.Item(lnI).DistribucionCentroDeCosto_PK)
				this.SetearAtributoDecimal( loItem, "Monto", .ComprobantePagoDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .ComprobantePagoDetalle.Item(lnI).NroItem )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValorescompropago" )
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
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Referencia", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "FPERSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monedacomprobante", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FFCH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacompro", "FFCHCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Centrodecosto", "CCOSTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Distribucionporcentrodecosto", "DISCCOS")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fnumcomp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fperson LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccosto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Disccos LIKE '%" + lcExpresionBusqueda + "%'"
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