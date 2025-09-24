
define class Din_EntidadDatostarjeta_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Datostarjeta"
	cClaseResponse = this.cNamespaceDTOs + ".DatostarjetaResponse"
	cClaseModelo = "DatostarjetaModelo"
	cEntidad = "Datostarjeta"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatostarjetaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatostarjetaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DatostarjetaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DatostarjetaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DatostarjetaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pos", toEntidad, "Pos_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Integrado", toEntidad, "Integrado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dispositivomovil", toEntidad, "Dispositivomovil" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idpuestoqr", toEntidad, "Idpuestoqr" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipopagolapos", toEntidad, "Tipopagolapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Terminalessmartlapos", toEntidad, "Terminalessmartlapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipopagosmartlapos", toEntidad, "Tipopagosmartlapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailgocuotas", toEntidad, "Mailgocuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipopagoposnet", toEntidad, "Tipopagoposnet" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idpagoclover", toEntidad, "Idpagoclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocupon", toEntidad, "Tipocupon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idordenclover", toEntidad, "Idordenclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idsmartlapos", toEntidad, "Idsmartlapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuponreferente", toEntidad, "Cuponreferente" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechareferente", toEntidad, "Fechareferente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lotereferente", toEntidad, "Lotereferente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autorizaciontelefonica", toEntidad, "Autorizaciontelefonica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autorizaciontelefonicaoffline", toEntidad, "Autorizaciontelefonicaoffline" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tarjeta", toEntidad, "Tarjeta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuotas", toEntidad, "Cuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ultimosdigitos", toEntidad, "Ultimosdigitos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigoplan", toEntidad, "Codigoplan" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombretitular", toEntidad, "Nombretitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodocumentotitular", toEntidad, "Tipodocumentotitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrodocumentotitular", toEntidad, "Nrodocumentotitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefonotitular", toEntidad, "Telefonotitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidadfinanciera", toEntidad, "Entidadfinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasedetarjeta", toEntidad, "Clasedetarjeta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocupon", toEntidad, "Numerocupon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerolote", toEntidad, "Numerolote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autorizacionpos", toEntidad, "Autorizacionpos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocierredelote", toEntidad, "Numerocierredelote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totaldescuento", toEntidad, "Totaldescuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalconrecargoporcuota", toEntidad, "Totalconrecargoporcuota" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalrecargo", toEntidad, "Totalrecargo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalconrecargo", toEntidad, "Totalconrecargo" )
			this.SetearDetalleDetalleplanes( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ticketicard", toEntidad, "Ticketicard" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetallePlanes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetallePlanes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetallePlanes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetallePlanes.LimpiarItem()
			else
				try
					toEntidad.DetallePlanes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetallePlanes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Cuota", toEntidad.DetallePlanes.oItem, "Cuota" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodesde", toEntidad.DetallePlanes.oItem, "MontoDesde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodemonto", toEntidad.DetallePlanes.oItem, "TipoDeMonto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargo", toEntidad.DetallePlanes.oItem, "Recargo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Totalporcuota", toEntidad.DetallePlanes.oItem, "TotalPorCuota" )
			this.SetearAtributoModeloEnEntidad( loItem, "Totalrecargo", toEntidad.DetallePlanes.oItem, "TotalRecargo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.DetallePlanes.oItem, "Total" )
			toEntidad.DetallePlanes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "POS", toEntidad.POS_PK)
			this.SetearAtributoString( toModeloResponse, "Integrado", toEntidad.Integrado)
			this.SetearAtributoString( toModeloResponse, "DispositivoMovil", toEntidad.DispositivoMovil)
			this.SetearAtributoString( toModeloResponse, "IdPuestoQR", toEntidad.IdPuestoQR)
			this.SetearAtributoInteger( toModeloResponse, "TipoPagoLaPos", toEntidad.TipoPagoLaPos)
			this.SetearAtributoString( toModeloResponse, "TerminalesSmartLaPos", toEntidad.TerminalesSmartLaPos)
			this.SetearAtributoInteger( toModeloResponse, "TipoPagoSmartLaPos", toEntidad.TipoPagoSmartLaPos)
			this.SetearAtributoString( toModeloResponse, "mailGoCuotas", toEntidad.mailGoCuotas)
			this.SetearAtributoInteger( toModeloResponse, "TipoPagoPosnet", toEntidad.TipoPagoPosnet)
			this.SetearAtributoString( toModeloResponse, "IdPagoClover", toEntidad.IdPagoClover)
			this.SetearAtributoString( toModeloResponse, "TipoCupon", toEntidad.TipoCupon)
			this.SetearAtributoString( toModeloResponse, "IdOrdenClover", toEntidad.IdOrdenClover)
			this.SetearAtributoString( toModeloResponse, "IdSmartLaPos", toEntidad.IdSmartLaPos)
			this.SetearAtributoLong( toModeloResponse, "CuponReferente", toEntidad.CuponReferente)
			this.SetearAtributoDateTime( toModeloResponse, "FechaReferente", toEntidad.FechaReferente)
			this.SetearAtributoInteger( toModeloResponse, "LoteReferente", toEntidad.LoteReferente)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoString( toModeloResponse, "AutorizacionTelefonica", toEntidad.AutorizacionTelefonica)
			this.SetearAtributoInteger( toModeloResponse, "AutorizacionTelefonicaOffLine", toEntidad.AutorizacionTelefonicaOffLine)
			this.SetearAtributoString( toModeloResponse, "Tarjeta", toEntidad.Tarjeta_PK)
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributoInteger( toModeloResponse, "Cuotas", toEntidad.Cuotas)
			this.SetearAtributoString( toModeloResponse, "UltimosDigitos", toEntidad.UltimosDigitos)
			this.SetearAtributoString( toModeloResponse, "CodigoPlan", toEntidad.CodigoPlan)
			this.SetearAtributoString( toModeloResponse, "NombreTitular", toEntidad.NombreTitular)
			this.SetearAtributoString( toModeloResponse, "TipoDocumentoTitular", toEntidad.TipoDocumentoTitular)
			this.SetearAtributoString( toModeloResponse, "NroDocumentoTitular", toEntidad.NroDocumentoTitular)
			this.SetearAtributoString( toModeloResponse, "TelefonoTitular", toEntidad.TelefonoTitular)
			this.SetearAtributoString( toModeloResponse, "EntidadFinanciera", toEntidad.EntidadFinanciera_PK)
			this.SetearAtributoString( toModeloResponse, "ClaseDeTarjeta", toEntidad.ClaseDeTarjeta)
			this.SetearAtributoLong( toModeloResponse, "NumeroCupon", toEntidad.NumeroCupon)
			this.SetearAtributoInteger( toModeloResponse, "NumeroLote", toEntidad.NumeroLote)
			this.SetearAtributo( toModeloResponse, "AutorizacionPOS", toEntidad.AutorizacionPOS)
			this.SetearAtributoInteger( toModeloResponse, "NumeroCierreDeLote", toEntidad.NumeroCierreDeLote)
			this.SetearAtributoDecimal( toModeloResponse, "TotalDescuento", toEntidad.TotalDescuento)
			this.SetearAtributoDecimal( toModeloResponse, "TotalConRecargoPorCuota", toEntidad.TotalConRecargoPorCuota)
			this.SetearAtributoDecimal( toModeloResponse, "TotalRecargo", toEntidad.TotalRecargo)
			this.SetearAtributoDecimal( toModeloResponse, "TotalConRecargo", toEntidad.TotalConRecargo)
			this.CargarColeccionModeloDetallePlanes( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "TicketICard", toEntidad.TicketICard)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetallePlanes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetallePlanes" ) 
		with toEntidad
			for lnI = 1 to .DetallePlanes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDatosplanes" )
				this.SetearAtributoString( loItem, "Codigo", .DetallePlanes.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "Cuota", .DetallePlanes.Item(lnI).Cuota)
				this.SetearAtributoDecimal( loItem, "MontoDesde", .DetallePlanes.Item(lnI).MontoDesde)
				this.SetearAtributoString( loItem, "TipoDeMonto", .DetallePlanes.Item(lnI).TipoDeMonto)
				this.SetearAtributoDecimal( loItem, "Recargo", .DetallePlanes.Item(lnI).Recargo)
				this.SetearAtributoDecimal( loItem, "TotalPorCuota", .DetallePlanes.Item(lnI).TotalPorCuota)
				this.SetearAtributoDecimal( loItem, "TotalRecargo", .DetallePlanes.Item(lnI).TotalRecargo)
				this.SetearAtributoDecimal( loItem, "Total", .DetallePlanes.Item(lnI).Total)
				this.SetearAtributoInteger( loItem, "NroItem", .DetallePlanes.Item(lnI).NroItem )
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