
define class Din_EntidadContabilizacion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Contabilizacion"
	cClaseResponse = this.cNamespaceDTOs + ".ContabilizacionResponse"
	cClaseModelo = "ContabilizacionModelo"
	cEntidad = "Contabilizacion"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ContabilizacionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ContabilizacionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ContabilizacionListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ContabilizacionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ContabilizacionModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ejercicio", toEntidad, "Ejercicio_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Razonsocial", toEntidad, "Razonsocial_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursal", toEntidad, "Sucursal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaventaslocales", toEntidad, "Contabilizaventaslocales" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaventasexportacion", toEntidad, "Contabilizaventasexportacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizarecibos", toEntidad, "Contabilizarecibos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizacompras", toEntidad, "Contabilizacompras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizapagos", toEntidad, "Contabilizapagos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaotrospagos", toEntidad, "Contabilizaotrospagos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizacaja", toEntidad, "Contabilizacaja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizacanjes", toEntidad, "Contabilizacanjes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizadescargas", toEntidad, "Contabilizadescargas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaliqtarjetas", toEntidad, "Contabilizaliqtarjetas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizatransferencias", toEntidad, "Contabilizatransferencias" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaajustecccliente", toEntidad, "Contabilizaajustecccliente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaajusteccproveedor", toEntidad, "Contabilizaajusteccproveedor" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizachequesconciliados", toEntidad, "Contabilizachequesconciliados" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizacostomercaderiavendida", toEntidad, "Contabilizacostomercaderiavendida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rangodeasientosgenerados", toEntidad, "Rangodeasientosgenerados" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bdprocesadas", toEntidad, "Bdprocesadas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizafacturamanual", toEntidad, "Contabilizafacturamanual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotadebitomanual", toEntidad, "Contabilizanotadebitomanual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotacreditomanual", toEntidad, "Contabilizanotacreditomanual" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizafacturafiscal", toEntidad, "Contabilizafacturafiscal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotadebitofiscal", toEntidad, "Contabilizanotadebitofiscal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotacreditofiscal", toEntidad, "Contabilizanotacreditofiscal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizafacturaelectronica", toEntidad, "Contabilizafacturaelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotadebitoelectronica", toEntidad, "Contabilizanotadebitoelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotacreditoelectronica", toEntidad, "Contabilizanotacreditoelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizafacturadecompra", toEntidad, "Contabilizafacturadecompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotacreditodecompra", toEntidad, "Contabilizanotacreditodecompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizanotadebitodecompra", toEntidad, "Contabilizanotadebitodecompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizadespachoimportaccompra", toEntidad, "Contabilizadespachoimportaccompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaliquidacionescompra", toEntidad, "Contabilizaliquidacionescompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizaliqservpublcompra", toEntidad, "Contabilizaliqservpublcompra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contabilizareciboscompra", toEntidad, "Contabilizareciboscompra" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoInteger( toModeloResponse, "Ejercicio", toEntidad.Ejercicio_PK)
			this.SetearAtributoString( toModeloResponse, "RazonSocial", toEntidad.RazonSocial_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributoString( toModeloResponse, "Sucursal", toEntidad.Sucursal_PK)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributo( toModeloResponse, "ContabilizaVentasLocales", toEntidad.ContabilizaVentasLocales)
			this.SetearAtributo( toModeloResponse, "ContabilizaVentasExportacion", toEntidad.ContabilizaVentasExportacion)
			this.SetearAtributo( toModeloResponse, "ContabilizaRecibos", toEntidad.ContabilizaRecibos)
			this.SetearAtributo( toModeloResponse, "ContabilizaCompras", toEntidad.ContabilizaCompras)
			this.SetearAtributo( toModeloResponse, "ContabilizaPagos", toEntidad.ContabilizaPagos)
			this.SetearAtributo( toModeloResponse, "ContabilizaOtrosPagos", toEntidad.ContabilizaOtrosPagos)
			this.SetearAtributo( toModeloResponse, "ContabilizaCaja", toEntidad.ContabilizaCaja)
			this.SetearAtributo( toModeloResponse, "ContabilizaCanjes", toEntidad.ContabilizaCanjes)
			this.SetearAtributo( toModeloResponse, "ContabilizaDescargas", toEntidad.ContabilizaDescargas)
			this.SetearAtributo( toModeloResponse, "ContabilizaLiqTarjetas", toEntidad.ContabilizaLiqTarjetas)
			this.SetearAtributo( toModeloResponse, "ContabilizaTransferencias", toEntidad.ContabilizaTransferencias)
			this.SetearAtributo( toModeloResponse, "ContabilizaAjusteCCCliente", toEntidad.ContabilizaAjusteCCCliente)
			this.SetearAtributo( toModeloResponse, "ContabilizaAjusteCCProveedor", toEntidad.ContabilizaAjusteCCProveedor)
			this.SetearAtributo( toModeloResponse, "ContabilizaChequesConciliados", toEntidad.ContabilizaChequesConciliados)
			this.SetearAtributo( toModeloResponse, "ContabilizaCostoMercaderiaVendida", toEntidad.ContabilizaCostoMercaderiaVendida)
			this.SetearAtributoString( toModeloResponse, "RangoDeAsientosGenerados", toEntidad.RangoDeAsientosGenerados)
			this.SetearAtributo( toModeloResponse, "BDProcesadas", toEntidad.BDProcesadas)
			this.SetearAtributo( toModeloResponse, "ContabilizaFacturaManual", toEntidad.ContabilizaFacturaManual)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaDebitoManual", toEntidad.ContabilizaNotaDebitoManual)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaCreditoManual", toEntidad.ContabilizaNotaCreditoManual)
			this.SetearAtributo( toModeloResponse, "ContabilizaFacturaFiscal", toEntidad.ContabilizaFacturaFiscal)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaDebitoFiscal", toEntidad.ContabilizaNotaDebitoFiscal)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaCreditoFiscal", toEntidad.ContabilizaNotaCreditoFiscal)
			this.SetearAtributo( toModeloResponse, "ContabilizaFacturaElectronica", toEntidad.ContabilizaFacturaElectronica)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaDebitoElectronica", toEntidad.ContabilizaNotaDebitoElectronica)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaCreditoElectronica", toEntidad.ContabilizaNotaCreditoElectronica)
			this.SetearAtributo( toModeloResponse, "ContabilizaFacturaDeCompra", toEntidad.ContabilizaFacturaDeCompra)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaCreditoDeCompra", toEntidad.ContabilizaNotaCreditoDeCompra)
			this.SetearAtributo( toModeloResponse, "ContabilizaNotaDebitoDeCompra", toEntidad.ContabilizaNotaDebitoDeCompra)
			this.SetearAtributo( toModeloResponse, "ContabilizaDespachoImportacCompra", toEntidad.ContabilizaDespachoImportacCompra)
			this.SetearAtributo( toModeloResponse, "ContabilizaLiquidacionesCompra", toEntidad.ContabilizaLiquidacionesCompra)
			this.SetearAtributo( toModeloResponse, "ContabilizaLiqServPublCompra", toEntidad.ContabilizaLiqServPublCompra)
			this.SetearAtributo( toModeloResponse, "ContabilizaRecibosCompra", toEntidad.ContabilizaRecibosCompra)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), EOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ejercicio", "EJERCICIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Razonsocial", "RSOCIAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECHADES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHAHAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sucursal", "SUCURSAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaventaslocales", "F_VTASLOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaventasexportacion", "F_VTASEXP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizarecibos", "F_RECIBOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizacompras", "F_COMPRAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizapagos", "F_PAGOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaotrospagos", "F_OTROSPAG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizacaja", "F_CAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizacanjes", "F_CANJES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizadescargas", "F_DESCCHEQ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaliqtarjetas", "F_LIQTARJ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizatransferencias", "F_TRANSF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaajustecccliente", "F_CCCLIENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaajusteccproveedor", "F_CCPROVED")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizachequesconciliados", "F_CONCILIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizacostomercaderiavendida", "F_CMV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rangodeasientosgenerados", "RANGOASIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bdprocesadas", "CONVERT( VARCHAR(MAX), BASESPROC)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizafacturamanual", "F_FACTMAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotadebitomanual", "F_NDMAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotacreditomanual", "F_NCMAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizafacturafiscal", "F_FACTFIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotadebitofiscal", "F_NDFIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotacreditofiscal", "F_NCFIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizafacturaelectronica", "F_FACTELE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotadebitoelectronica", "F_NDELE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotacreditoelectronica", "F_NCELE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizafacturadecompra", "F_COMPR_FC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotacreditodecompra", "F_COMPR_NC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizanotadebitodecompra", "F_COMPR_ND")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizadespachoimportaccompra", "F_COMPR_O1")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaliquidacionescompra", "F_COMPR_O2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizaliqservpublcompra", "F_COMPR_O3")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contabilizareciboscompra", "F_COMPR_O4")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Eobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rsocial LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucursal LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Base LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rangoasie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Basesproc LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine