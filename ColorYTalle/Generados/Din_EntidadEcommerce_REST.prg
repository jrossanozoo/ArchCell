
define class Din_EntidadEcommerce_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Ecommerce"
	cClaseResponse = this.cNamespaceDTOs + ".EcommerceResponse"
	cClaseModelo = "EcommerceModelo"
	cEntidad = "Ecommerce"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EcommerceModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "EcommerceModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "EcommerceListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "EcommerceListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "EcommerceModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuenta", toEntidad, "Cuenta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoecommerce", toEntidad, "Tipoecommerce" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idvinculacion", toEntidad, "Idvinculacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ultimaorder", toEntidad, "Ultimaorder" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accion", toEntidad, "Accion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Buzon", toEntidad, "Buzon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Utilizastockotrabase", toEntidad, "Utilizastockotrabase" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bdorigenstock", toEntidad, "Bdorigenstock" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Accionfullenv", toEntidad, "Accionfullenv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Buzonfullenv", toEntidad, "Buzonfullenv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosfullenv", toEntidad, "Basededatosfullenv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Generacancelacion", toEntidad, "Generacancelacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usavalecambio", toEntidad, "Usavalecambio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturarsinpersonalizar", toEntidad, "Facturarsinpersonalizar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Percepcionesactacte", toEntidad, "Percepcionesactacte" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechanovedades", toEntidad, "Fechanovedades" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Aplicarcostoenvio", toEntidad, "Aplicarcostoenvio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportista", toEntidad, "Transportista_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Motivo", toEntidad, "Motivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pago", toEntidad, "Pago_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valorctacte", toEntidad, "Valorctacte_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionpagopreferente", toEntidad, "Condicionpagopreferente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedefault", toEntidad, "Clientedefault_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Concenvio", toEntidad, "Concenvio_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Conccolor", toEntidad, "Conccolor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Conctalle", toEntidad, "Conctalle_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Concarticulo", toEntidad, "Concarticulo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cargaautomaticavalores", toEntidad, "Cargaautomaticavalores" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usaequivalores", toEntidad, "Usaequivalores" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vacio", toEntidad, "Vacio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descartar", toEntidad, "Descartar" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedido", toEntidad, "Pedido" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Remito", toEntidad, "Remito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturamanual", toEntidad, "Facturamanual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidofacturamanual", toEntidad, "Pedidofacturamanual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturamanualconentregaposterior", toEntidad, "Facturamanualconentregaposterior" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidofacturamanualconentregapos", toEntidad, "Pedidofacturamanualconentregapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturamanualconvtacont", toEntidad, "Facturamanualconvtacont" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronica", toEntidad, "Facturaelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidofacturaelectronica", toEntidad, "Pedidofacturaelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronicaconentregaposterior", toEntidad, "Facturaelectronicaconentregaposterior" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidofacturaelectronicaconentregapos", toEntidad, "Pedidofacturaelectronicaconentregapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronicaconvtacont", toEntidad, "Facturaelectronicaconvtacont" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturafiscal", toEntidad, "Facturafiscal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidofacturafiscal", toEntidad, "Pedidofacturafiscal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturafiscalconentregaposterior", toEntidad, "Facturafiscalconentregaposterior" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pedidofacturafiscalconentregapos", toEntidad, "Pedidofacturafiscalconentregapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturafiscalconvtacont", toEntidad, "Facturafiscalconvtacont" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosdeenvio", toEntidad, "Datosdeenvio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefonodeenvio", toEntidad, "Telefonodeenvio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosdepago", toEntidad, "Datosdepago" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerodecarrito", toEntidad, "Numerodecarrito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Enlacedelaoperacion", toEntidad, "Enlacedelaoperacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Datosderetiro", toEntidad, "Datosderetiro" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observaciones", toEntidad, "Observaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pagado", toEntidad, "Pagado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Aplicarpromocionesautomaticas", toEntidad, "Aplicarpromocionesautomaticas" )
			this.SetearDetalleEquivaloresdetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleEquiValoresDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "EquiValoresDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"EquiValoresDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.EquiValoresDetalle.LimpiarItem()
			else
				try
					toEntidad.EquiValoresDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.EquiValoresDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Valorecommerce", toEntidad.EquiValoresDetalle.oItem, "ValorEcommerce" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipovalorecommerce", toEntidad.EquiValoresDetalle.oItem, "TipoValorEcommerce" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordragonfish", toEntidad.EquiValoresDetalle.oItem, "ValorDragonfish_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valordescripcion", toEntidad.EquiValoresDetalle.oItem, "ValorDescripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipovalordragon", toEntidad.EquiValoresDetalle.oItem, "TipoValorDragon" )
			toEntidad.EquiValoresDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "Cuenta", toEntidad.Cuenta)
			this.SetearAtributoInteger( toModeloResponse, "TipoEcommerce", toEntidad.TipoEcommerce)
			this.SetearAtributoLong( toModeloResponse, "IDVinculacion", toEntidad.IDVinculacion)
			this.SetearAtributoLong( toModeloResponse, "UltimaOrder", toEntidad.UltimaOrder)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Accion", toEntidad.Accion)
			this.SetearAtributoString( toModeloResponse, "Buzon", toEntidad.Buzon)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributo( toModeloResponse, "UtilizaStockOtraBase", toEntidad.UtilizaStockOtraBase)
			this.SetearAtributoString( toModeloResponse, "BDOrigenStock", toEntidad.BDOrigenStock)
			this.SetearAtributoString( toModeloResponse, "AccionFullEnv", toEntidad.AccionFullEnv)
			this.SetearAtributoString( toModeloResponse, "BuzonFullEnv", toEntidad.BuzonFullEnv)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatosFullEnv", toEntidad.BaseDeDatosFullEnv)
			this.SetearAtributo( toModeloResponse, "GeneraCancelacion", toEntidad.GeneraCancelacion)
			this.SetearAtributo( toModeloResponse, "UsaValeCambio", toEntidad.UsaValeCambio)
			this.SetearAtributo( toModeloResponse, "FacturarSinPersonalizar", toEntidad.FacturarSinPersonalizar)
			this.SetearAtributo( toModeloResponse, "PercepcionesACtaCte", toEntidad.PercepcionesACtaCte)
			this.SetearAtributoDateTime( toModeloResponse, "FechaNovedades", toEntidad.FechaNovedades)
			this.SetearAtributoInteger( toModeloResponse, "AplicarCostoEnvio", toEntidad.AplicarCostoEnvio)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "Transportista", toEntidad.Transportista_PK)
			this.SetearAtributoString( toModeloResponse, "Motivo", toEntidad.Motivo_PK)
			this.SetearAtributoString( toModeloResponse, "Pago", toEntidad.Pago_PK)
			this.SetearAtributoString( toModeloResponse, "ValorCtaCte", toEntidad.ValorCtaCte_PK)
			this.SetearAtributoString( toModeloResponse, "CondicionPagoPreferente", toEntidad.CondicionPagoPreferente_PK)
			this.SetearAtributoString( toModeloResponse, "ClienteDefault", toEntidad.ClienteDefault_PK)
			this.SetearAtributoString( toModeloResponse, "Concenvio", toEntidad.Concenvio_PK)
			this.SetearAtributoString( toModeloResponse, "ConcColor", toEntidad.ConcColor_PK)
			this.SetearAtributoString( toModeloResponse, "ConcTalle", toEntidad.ConcTalle_PK)
			this.SetearAtributoString( toModeloResponse, "ConcArticulo", toEntidad.ConcArticulo_PK)
			this.SetearAtributo( toModeloResponse, "CargaAutomaticaValores", toEntidad.CargaAutomaticaValores)
			this.SetearAtributo( toModeloResponse, "UsaEquiValores", toEntidad.UsaEquiValores)
			this.SetearAtributo( toModeloResponse, "Vacio", toEntidad.Vacio)
			this.SetearAtributo( toModeloResponse, "Descartar", toEntidad.Descartar)
			this.SetearAtributo( toModeloResponse, "Pedido", toEntidad.Pedido)
			this.SetearAtributo( toModeloResponse, "Remito", toEntidad.Remito)
			this.SetearAtributo( toModeloResponse, "FacturaManual", toEntidad.FacturaManual)
			this.SetearAtributo( toModeloResponse, "PedidoFacturaManual", toEntidad.PedidoFacturaManual)
			this.SetearAtributo( toModeloResponse, "FacturaManualConEntregaPosterior", toEntidad.FacturaManualConEntregaPosterior)
			this.SetearAtributo( toModeloResponse, "PedidoFacturaManualConEntregaPos", toEntidad.PedidoFacturaManualConEntregaPos)
			this.SetearAtributo( toModeloResponse, "FacturaManualConVtaCont", toEntidad.FacturaManualConVtaCont)
			this.SetearAtributo( toModeloResponse, "FacturaElectronica", toEntidad.FacturaElectronica)
			this.SetearAtributo( toModeloResponse, "PedidoFacturaElectronica", toEntidad.PedidoFacturaElectronica)
			this.SetearAtributo( toModeloResponse, "FacturaElectronicaConEntregaPosterior", toEntidad.FacturaElectronicaConEntregaPosterior)
			this.SetearAtributo( toModeloResponse, "PedidoFacturaElectronicaConEntregaPos", toEntidad.PedidoFacturaElectronicaConEntregaPos)
			this.SetearAtributo( toModeloResponse, "FacturaElectronicaConVtaCont", toEntidad.FacturaElectronicaConVtaCont)
			this.SetearAtributo( toModeloResponse, "FacturaFiscal", toEntidad.FacturaFiscal)
			this.SetearAtributo( toModeloResponse, "PedidoFacturaFiscal", toEntidad.PedidoFacturaFiscal)
			this.SetearAtributo( toModeloResponse, "FacturaFiscalConEntregaPosterior", toEntidad.FacturaFiscalConEntregaPosterior)
			this.SetearAtributo( toModeloResponse, "PedidoFacturaFiscalConEntregaPos", toEntidad.PedidoFacturaFiscalConEntregaPos)
			this.SetearAtributo( toModeloResponse, "FacturaFiscalConVtaCont", toEntidad.FacturaFiscalConVtaCont)
			this.SetearAtributo( toModeloResponse, "DatosDeEnvio", toEntidad.DatosDeEnvio)
			this.SetearAtributo( toModeloResponse, "TelefonoDeEnvio", toEntidad.TelefonoDeEnvio)
			this.SetearAtributo( toModeloResponse, "DatosDePago", toEntidad.DatosDePago)
			this.SetearAtributo( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributo( toModeloResponse, "NumeroDeCarrito", toEntidad.NumeroDeCarrito)
			this.SetearAtributo( toModeloResponse, "EnlaceDeLaOperacion", toEntidad.EnlaceDeLaOperacion)
			this.SetearAtributo( toModeloResponse, "DatosDeRetiro", toEntidad.DatosDeRetiro)
			this.SetearAtributo( toModeloResponse, "Observaciones", toEntidad.Observaciones)
			this.SetearAtributo( toModeloResponse, "Pagado", toEntidad.Pagado)
			this.SetearAtributo( toModeloResponse, "AplicarPromocionesAutomaticas", toEntidad.AplicarPromocionesAutomaticas)
			this.CargarColeccionModeloEquiValoresDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloEquiValoresDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "EquiValoresDetalle" ) 
		with toEntidad
			for lnI = 1 to .EquiValoresDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemEquivalores" )
				this.SetearAtributoString( loItem, "Codigo", .EquiValoresDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ValorEcommerce", .EquiValoresDetalle.Item(lnI).ValorEcommerce)
				this.SetearAtributoString( loItem, "TipoValorEcommerce", .EquiValoresDetalle.Item(lnI).TipoValorEcommerce)
				this.SetearAtributoString( loItem, "ValorDragonfish", .EquiValoresDetalle.Item(lnI).ValorDragonfish_PK)
				this.SetearAtributoString( loItem, "ValorDescripcion", .EquiValoresDetalle.Item(lnI).ValorDescripcion)
				this.SetearAtributoString( loItem, "TipoValorDragon", .EquiValoresDetalle.Item(lnI).TipoValorDragon)
				this.SetearAtributoInteger( loItem, "NroItem", .EquiValoresDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CUENTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuenta", "CUENTACOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoecommerce", "TIPOECOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idvinculacion", "IDVINC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ultimaorder", "ULTORDER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Accion", "ACCION")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Buzon", "BUZON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BASEDEDATO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Utilizastockotrabase", "USAOTRABD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bdorigenstock", "ORIGENST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Accionfullenv", "ACCIONFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Buzonfullenv", "BUZONFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatosfullenv", "BDFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Generacancelacion", "GENERACAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usavalecambio", "VALECAMB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturarsinpersonalizar", "FACTSINPER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Percepcionesactacte", "PERCCTACTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechanovedades", "FECNOV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Aplicarcostoenvio", "APLICENVIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecios", "CODLISTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "VENDEDOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportista", "TRANSPOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Motivo", "MOTIVO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pago", "PAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valorctacte", "VALCTACTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionpagopreferente", "CONDPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedefault", "CLIEDEF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Concenvio", "CONVENV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Conccolor", "CONCCOLOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Conctalle", "CONCTALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Concarticulo", "CONCART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cargaautomaticavalores", "CARGAAUTOV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usaequivalores", "USAEQUIVAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vacio", "VACIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descartar", "DESCARTAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedido", "PEDIDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Remito", "REMITO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturamanual", "FACTMANUAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidofacturamanual", "PEFACTMAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturamanualconentregaposterior", "FACTMCEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidofacturamanualconentregapos", "PEFACTMCEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturamanualconvtacont", "FACTMVC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturaelectronica", "FACTELEC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidofacturaelectronica", "PEFACTELEC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturaelectronicaconentregaposterior", "FACTECEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidofacturaelectronicaconentregapos", "PEFACTECEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturaelectronicaconvtacont", "FACTEVC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturafiscal", "FACTFISCAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidofacturafiscal", "PEFACTFISC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturafiscalconentregaposterior", "FACTFCEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pedidofacturafiscalconentregapos", "PEFACTFCEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturafiscalconvtacont", "FACTFVC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datosdeenvio", "DTOSENVIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefonodeenvio", "TELENVIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datosdepago", "DTOSPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerodecarrito", "NROCARRITO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Enlacedelaoperacion", "ENLACEOP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Datosderetiro", "DATOSRET")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observaciones", "OBSERVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pagado", "PAGADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Aplicarpromocionesautomaticas", "PROMOS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cuenta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cuentacom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Accion LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Buzon LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Basededato LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Origenst LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Accionfe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Buzonfe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bdfe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codlista LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendedor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Transpor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Motivo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Valctacte LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Condpago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliedef LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Convenv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Conccolor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Conctalle LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Concart LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine