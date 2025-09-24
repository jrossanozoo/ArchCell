
define class Din_COMPONENTECOMPROBANTE as ZooSession of ZooSession.prg
	oComprobantes = null

	*-----------------------------------------------------------------------------------------
	function Init( t1, t2, t3, t4 ) As Boolean
		local llRetorno as boolean, loex as exception
		llRetorno = dodefault()
		this.oComprobantes = _screen.zoo.CrearObjeto( "ZooColeccion" )
		if llRetorno
			this.oComprobantes.Agregar( "1, 2, 3, 4, 5, 6, 11, 12, 13, 23, 25, 27, 28, 29, 33, 35, 36, 43, 45, 46, 47, 48, 49, 51, 52, 53, 54, 55, 56, 57, 58", "VENTAS" )
			this.oComprobantes.Agregar( "1, 2, 3, 4, 5, 6, 11, 27, 28, 29, 33, 35, 36, 47, 48, 49, 51, 52, 53, 54, 55, 56", "VENTASFISCAL" )
			this.oComprobantes.Agregar( "1, 2, 3, 4, 5, 6, 27, 28, 29, 33, 35, 36, 47, 48, 49, 51, 52, 53, 54, 55, 56", "VENTASFISCALCONVALORES" )
			this.oComprobantes.Agregar( "27, 28, 29, 33, 35, 36, 54, 55, 56", "VENTASFISCALCE" )
			this.oComprobantes.Agregar( "8, 9, 10, 30, 31, 32, 37, 38, 39, 40, 41, 42, 44, 50", "COMPRAS" )
			this.oComprobantes.Agregar( "8, 9, 10, 31", "COMPRASFISCAL" )
			this.oComprobantes.Agregar( "8, 9, 10, 31", "COMPRASFISCALCONVALORES" )
			this.oComprobantes.Agregar( "-1, 8, 9, 10, 31", "COMPRASFISCALSUBDIARIOIVACOMPRAS" )
			this.oComprobantes.Agregar( "1, 2, 3, 4, 5, 6, 27, 28, 29, 33, 35, 36, 47, 48, 49, 51, 52, 53, 54, 55, 56", "VENTASFISCALCONVALORESAGRUPADOS" )
			this.oComprobantes.Agregar( "2, 5, 6, 51, 52, 53", "VENTASTICKETFISCALESCONVALOR" )
			this.oComprobantes.Agregar( "27, 28, 29, 33, 35, 36, 54, 55, 56", "VENTASELECTRONICOSCONVALOR" )
			this.oComprobantes.Agregar( "4, 47, 48, 49", "VENTASTEXPORTACIONCONVALOR" )
			this.oComprobantes.Agregar( "1, 3", "VENTASMANUALESLESCONVALOR" )
		endif

		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerIdentificadorDeComprobante( tnTipoComprobante as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoComprobante = 1
				lcRetorno = '011'
			case tnTipoComprobante = 2
				lcRetorno = '019'
			case tnTipoComprobante = 3
				lcRetorno = '020'
			case tnTipoComprobante = 4
				lcRetorno = '021'
			case tnTipoComprobante = 5
				lcRetorno = '022'
			case tnTipoComprobante = 6
				lcRetorno = '023'
			case tnTipoComprobante = 8
				lcRetorno = 'Fdc'
			case tnTipoComprobante = 9
				lcRetorno = 'Ndc'
			case tnTipoComprobante = 10
				lcRetorno = 'Ncc'
			case tnTipoComprobante = 11
				lcRetorno = '032'
			case tnTipoComprobante = 12
				lcRetorno = '048'
			case tnTipoComprobante = 13
				lcRetorno = '054'
			case tnTipoComprobante = 23
				lcRetorno = 'Ped'
			case tnTipoComprobante = 25
				lcRetorno = 'Pre'
			case tnTipoComprobante = 27
				lcRetorno = '127'
			case tnTipoComprobante = 28
				lcRetorno = '128'
			case tnTipoComprobante = 29
				lcRetorno = '129'
			case tnTipoComprobante = 30
				lcRetorno = 'Pdc'
			case tnTipoComprobante = 31
				lcRetorno = 'Odp'
			case tnTipoComprobante = 32
				lcRetorno = 'Cdv'
			case tnTipoComprobante = 33
				lcRetorno = 'Fee'
			case tnTipoComprobante = 35
				lcRetorno = 'Nee'
			case tnTipoComprobante = 36
				lcRetorno = 'Dee'
			case tnTipoComprobante = 37
				lcRetorno = 'Pag'
			case tnTipoComprobante = 38
				lcRetorno = 'Pco'
			case tnTipoComprobante = 39
				lcRetorno = 'Soc'
			case tnTipoComprobante = 40
				lcRetorno = 'Rdc'
			case tnTipoComprobante = 41
				lcRetorno = 'Rco'
			case tnTipoComprobante = 42
				lcRetorno = 'Ajp'
			case tnTipoComprobante = 43
				lcRetorno = 'Aju'
			case tnTipoComprobante = 44
				lcRetorno = 'Cac'
			case tnTipoComprobante = 45
				lcRetorno = 'Cds'
			case tnTipoComprobante = 46
				lcRetorno = 'Dct'
			case tnTipoComprobante = 47
				lcRetorno = 'Fmx'
			case tnTipoComprobante = 48
				lcRetorno = 'Ncx'
			case tnTipoComprobante = 49
				lcRetorno = 'Ndx'
			case tnTipoComprobante = 50
				lcRetorno = 'Cop'
			case tnTipoComprobante = 51
				lcRetorno = 'Fag'
			case tnTipoComprobante = 52
				lcRetorno = 'Nag'
			case tnTipoComprobante = 53
				lcRetorno = 'Xad'
			case tnTipoComprobante = 54
				lcRetorno = 'Fem'
			case tnTipoComprobante = 55
				lcRetorno = 'Cem'
			case tnTipoComprobante = 56
				lcRetorno = 'Dem'
			case tnTipoComprobante = 57
				lcRetorno = 'Prm'
			case tnTipoComprobante = 58
				lcRetorno = 'Sen'
			otherwise
				lcRetorno = 'XXX'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerNombreDeComprobanteDeVentas( tnTipoComprobante as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoComprobante = 1
				lcRetorno = 'Factura Manual De Venta'
			case tnTipoComprobante = 2
				lcRetorno = 'Factura Fiscal De Venta'
			case tnTipoComprobante = 3
				lcRetorno = 'Nota De Crédito Manual De Venta'
			case tnTipoComprobante = 4
				lcRetorno = 'Nota De Débito Manual De Venta'
			case tnTipoComprobante = 5
				lcRetorno = 'Nota De Crédito Fiscal De Venta'
			case tnTipoComprobante = 6
				lcRetorno = 'Nota De Débito Fiscal De Venta'
			case tnTipoComprobante = 8
				lcRetorno = 'Factura De Compra'
			case tnTipoComprobante = 9
				lcRetorno = 'Nota De Débito De Compra'
			case tnTipoComprobante = 10
				lcRetorno = 'Nota De Crédito De Compra'
			case tnTipoComprobante = 11
				lcRetorno = 'Remito De Venta'
			case tnTipoComprobante = 12
				lcRetorno = 'Cancelación De Venta'
			case tnTipoComprobante = 13
				lcRetorno = 'Recibo'
			case tnTipoComprobante = 23
				lcRetorno = 'Pedido De Venta'
			case tnTipoComprobante = 25
				lcRetorno = 'Presupuesto De Venta'
			case tnTipoComprobante = 27
				lcRetorno = 'Factura Electrónica De Venta'
			case tnTipoComprobante = 28
				lcRetorno = 'Nota De Crédito Electrónica De Venta'
			case tnTipoComprobante = 29
				lcRetorno = 'Nota De Débito Electrónica De Venta'
			case tnTipoComprobante = 30
				lcRetorno = 'Presupuesto De Compra'
			case tnTipoComprobante = 31
				lcRetorno = 'Orden De Pago'
			case tnTipoComprobante = 32
				lcRetorno = 'Canje De Valores'
			case tnTipoComprobante = 33
				lcRetorno = 'Factura Electrónica Exportación De Venta'
			case tnTipoComprobante = 35
				lcRetorno = 'Nota De Crédito Electrónica Exportación De Venta'
			case tnTipoComprobante = 36
				lcRetorno = 'Nota De Débito Electrónica Exportación De Venta'
			case tnTipoComprobante = 37
				lcRetorno = 'Pago'
			case tnTipoComprobante = 38
				lcRetorno = 'Pedido De Compra'
			case tnTipoComprobante = 39
				lcRetorno = 'Solicitud De Compra'
			case tnTipoComprobante = 40
				lcRetorno = 'Requerimiento De Compra'
			case tnTipoComprobante = 41
				lcRetorno = 'Remito De Compra'
			case tnTipoComprobante = 42
				lcRetorno = 'Ajuste De Cuenta Corriente De Proveedores'
			case tnTipoComprobante = 43
				lcRetorno = 'Ajuste De Cuenta Corriente De Clientes'
			case tnTipoComprobante = 44
				lcRetorno = 'Cancelación De Compra'
			case tnTipoComprobante = 45
				lcRetorno = 'Cancelación De Señas'
			case tnTipoComprobante = 46
				lcRetorno = 'Descarga De Cheques De Terceros'
			case tnTipoComprobante = 47
				lcRetorno = 'Factura De Exportación De Venta'
			case tnTipoComprobante = 48
				lcRetorno = 'Nota De Crédito De Exportación De Venta'
			case tnTipoComprobante = 49
				lcRetorno = 'Nota De Débito De Exportación De Venta'
			case tnTipoComprobante = 50
				lcRetorno = 'Otros Pagos'
			case tnTipoComprobante = 51
				lcRetorno = 'Factura'
			case tnTipoComprobante = 52
				lcRetorno = 'Nota De Crédito'
			case tnTipoComprobante = 53
				lcRetorno = 'Nota De Débito'
			case tnTipoComprobante = 54
				lcRetorno = 'Factura De Crédito Electrónica Mipyme De Venta'
			case tnTipoComprobante = 55
				lcRetorno = 'Nota De Crédito Electrónica Mipyme De Venta'
			case tnTipoComprobante = 56
				lcRetorno = 'Nota De Débito Electrónica Mipyme De Venta'
			case tnTipoComprobante = 57
				lcRetorno = 'Preparación De Mercadería'
			case tnTipoComprobante = 58
				lcRetorno = 'Seña'
			otherwise
				lcRetorno = '[' + transform( tnTipoComprobante ) + '] Comprobante Desconocido'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function GenerarXmlComprobantes()
		local lcNombreCursor as String, lcComprobantesXML as String, lnPais as integer
		lnPais = goparametros.nucleo.datosgenerales.pais
		lcNombreCursor = 'c_' + sys( 2015 )
		create cursor &lcNombreCursor( id n(4), Comprobante c(60), Entidad C(40) )

		insert into &lcNombreCursor values( -1 , 'Todos', '')
				insert into &lcNombreCursor values( 1, 'Factura Manual De Venta', 'FACTURA')
				insert into &lcNombreCursor values( 2, 'Factura Fiscal De Venta', 'TICKETFACTURA')
				insert into &lcNombreCursor values( 3, 'Nota De Crédito Manual De Venta', 'NOTADECREDITO')
				insert into &lcNombreCursor values( 4, 'Nota De Débito Manual De Venta', 'NOTADEDEBITO')
				insert into &lcNombreCursor values( 5, 'Nota De Crédito Fiscal De Venta', 'TICKETNOTADECREDITO')
				insert into &lcNombreCursor values( 6, 'Nota De Débito Fiscal De Venta', 'TICKETNOTADEDEBITO')
				insert into &lcNombreCursor values( 8, 'Factura De Compra', 'FACTURADECOMPRA')
				insert into &lcNombreCursor values( 9, 'Nota De Débito De Compra', 'NOTADEDEBITOCOMPRA')
				insert into &lcNombreCursor values( 10, 'Nota De Crédito De Compra', 'NOTADECREDITOCOMPRA')
				insert into &lcNombreCursor values( 11, 'Remito De Venta', 'REMITO')
				insert into &lcNombreCursor values( 12, 'Cancelación De Venta', 'DEVOLUCION')
				insert into &lcNombreCursor values( 13, 'Recibo', 'RECIBO')
				insert into &lcNombreCursor values( 23, 'Pedido De Venta', 'PEDIDO')
				insert into &lcNombreCursor values( 25, 'Presupuesto De Venta', 'PRESUPUESTO')
				insert into &lcNombreCursor values( 27, 'Factura Electrónica De Venta', 'FACTURAELECTRONICA')
				insert into &lcNombreCursor values( 28, 'Nota De Crédito Electrónica De Venta', 'NOTADECREDITOELECTRONICA')
				insert into &lcNombreCursor values( 29, 'Nota De Débito Electrónica De Venta', 'NOTADEDEBITOELECTRONICA')
				insert into &lcNombreCursor values( 30, 'Presupuesto De Compra', 'PRESUPUESTODECOMPRA')
				insert into &lcNombreCursor values( 31, 'Orden De Pago', 'ORDENDEPAGO')
				insert into &lcNombreCursor values( 32, 'Canje De Valores', 'CANJEDECUPONES')
				insert into &lcNombreCursor values( 33, 'Factura Electrónica Exportación De Venta', 'FACTURAELECTRONICAEXPORTACION')
				insert into &lcNombreCursor values( 35, 'Nota De Crédito Electrónica Exportación De Venta', 'NOTADECREDITOELECTRONICAEXPORTACION')
				insert into &lcNombreCursor values( 36, 'Nota De Débito Electrónica Exportación De Venta', 'NOTADEDEBITOELECTRONICAEXPORTACION')
				insert into &lcNombreCursor values( 37, 'Pago', 'PAGO')
				insert into &lcNombreCursor values( 38, 'Pedido De Compra', 'PEDIDODECOMPRA')
				insert into &lcNombreCursor values( 39, 'Solicitud De Compra', 'SOLICITUDDECOMPRA')
				insert into &lcNombreCursor values( 40, 'Requerimiento De Compra', 'REQUERIMIENTODECOMPRA')
				insert into &lcNombreCursor values( 41, 'Remito De Compra', 'REMITODECOMPRA')
				insert into &lcNombreCursor values( 42, 'Ajuste De Cuenta Corriente De Proveedores', 'AJUSTECCPROVEEDOR')
				insert into &lcNombreCursor values( 43, 'Ajuste De Cuenta Corriente De Clientes', 'AJUSTECCCLIENTE')
				insert into &lcNombreCursor values( 44, 'Cancelación De Compra', 'CANCELACIONDECOMPRA')
				insert into &lcNombreCursor values( 45, 'Cancelación De Señas', 'CANCELACIONDESENIAS')
				insert into &lcNombreCursor values( 46, 'Descarga De Cheques De Terceros', 'DESCARGADECHEQUES')
				insert into &lcNombreCursor values( 47, 'Factura De Exportación De Venta', 'FACTURADEEXPORTACION')
				insert into &lcNombreCursor values( 48, 'Nota De Crédito De Exportación De Venta', 'NOTADECREDITODEEXPORTACION')
				insert into &lcNombreCursor values( 49, 'Nota De Débito De Exportación De Venta', 'NOTADEDEBITODEEXPORTACION')
				insert into &lcNombreCursor values( 50, 'Otros Pagos', 'COMPROBANTEPAGO')
				insert into &lcNombreCursor values( 51, 'Factura', 'FACTURAAGRUPADA')
				insert into &lcNombreCursor values( 52, 'Nota De Crédito', 'NOTADECREDITOAGRUPADA')
				insert into &lcNombreCursor values( 53, 'Nota De Débito', 'NOTADEDEBITOAGRUPADA')
				insert into &lcNombreCursor values( 54, 'Factura De Crédito Electrónica Mipyme De Venta', 'FACTURAELECTRONICADECREDITO')
				insert into &lcNombreCursor values( 55, 'Nota De Crédito Electrónica Mipyme De Venta', 'NOTADECREDITOELECTRONICADECREDITO')
				insert into &lcNombreCursor values( 56, 'Nota De Débito Electrónica Mipyme De Venta', 'NOTADEDEBITOELECTRONICADECREDITO')
				insert into &lcNombreCursor values( 57, 'Preparación De Mercadería', 'PREPARACIONDEMERCADERIA')
				insert into &lcNombreCursor values( 58, 'Seña', 'SENIA')
		do case
			case lnPais = 1
			case lnPais = 2
			case lnPais = 3
		endcase

		lcComprobantesXML = this.CursorAXml( lcNombreCursor )
		use in select ( lcNombreCursor )
		return lcComprobantesXML
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerCadenaComprobantes( tcClave as string ) as String
		Local lcRetorno as String
		
		lcRetorno = []
		if this.oComprobantes.Buscar( tcClave )
			lcRetorno = this.oComprobantes.Item[ tcClave ]
		else
			loex = newobject(  "zooexception", "zooexception.prg" )
			loex.message = "El tipo de filtro no posee comprobantes asociados (" + tcClave + ")"
			loex.details = loex.message
			goServicios.Errores.LevantarExcepcion( loEx )
		endif
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerEntidadDeComprobanteDeVentas( tnTipoComprobante as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoComprobante = 1
				lcRetorno = 'Factura'
			case tnTipoComprobante = 2
				lcRetorno = 'Ticketfactura'
			case tnTipoComprobante = 3
				lcRetorno = 'Notadecredito'
			case tnTipoComprobante = 4
				lcRetorno = 'Notadedebito'
			case tnTipoComprobante = 5
				lcRetorno = 'Ticketnotadecredito'
			case tnTipoComprobante = 6
				lcRetorno = 'Ticketnotadedebito'
			case tnTipoComprobante = 8
				lcRetorno = 'Facturadecompra'
			case tnTipoComprobante = 9
				lcRetorno = 'Notadedebitocompra'
			case tnTipoComprobante = 10
				lcRetorno = 'Notadecreditocompra'
			case tnTipoComprobante = 11
				lcRetorno = 'Remito'
			case tnTipoComprobante = 12
				lcRetorno = 'Devolucion'
			case tnTipoComprobante = 13
				lcRetorno = 'Recibo'
			case tnTipoComprobante = 23
				lcRetorno = 'Pedido'
			case tnTipoComprobante = 25
				lcRetorno = 'Presupuesto'
			case tnTipoComprobante = 27
				lcRetorno = 'Facturaelectronica'
			case tnTipoComprobante = 28
				lcRetorno = 'Notadecreditoelectronica'
			case tnTipoComprobante = 29
				lcRetorno = 'Notadedebitoelectronica'
			case tnTipoComprobante = 30
				lcRetorno = 'Presupuestodecompra'
			case tnTipoComprobante = 31
				lcRetorno = 'Ordendepago'
			case tnTipoComprobante = 32
				lcRetorno = 'Canjedecupones'
			case tnTipoComprobante = 33
				lcRetorno = 'Facturaelectronicaexportacion'
			case tnTipoComprobante = 35
				lcRetorno = 'Notadecreditoelectronicaexportacion'
			case tnTipoComprobante = 36
				lcRetorno = 'Notadedebitoelectronicaexportacion'
			case tnTipoComprobante = 37
				lcRetorno = 'Pago'
			case tnTipoComprobante = 38
				lcRetorno = 'Pedidodecompra'
			case tnTipoComprobante = 39
				lcRetorno = 'Solicituddecompra'
			case tnTipoComprobante = 40
				lcRetorno = 'Requerimientodecompra'
			case tnTipoComprobante = 41
				lcRetorno = 'Remitodecompra'
			case tnTipoComprobante = 42
				lcRetorno = 'Ajusteccproveedor'
			case tnTipoComprobante = 43
				lcRetorno = 'Ajustecccliente'
			case tnTipoComprobante = 44
				lcRetorno = 'Cancelaciondecompra'
			case tnTipoComprobante = 45
				lcRetorno = 'Cancelaciondesenias'
			case tnTipoComprobante = 46
				lcRetorno = 'Descargadecheques'
			case tnTipoComprobante = 47
				lcRetorno = 'Facturadeexportacion'
			case tnTipoComprobante = 48
				lcRetorno = 'Notadecreditodeexportacion'
			case tnTipoComprobante = 49
				lcRetorno = 'Notadedebitodeexportacion'
			case tnTipoComprobante = 50
				lcRetorno = 'Comprobantepago'
			case tnTipoComprobante = 51
				lcRetorno = 'Facturaagrupada'
			case tnTipoComprobante = 52
				lcRetorno = 'Notadecreditoagrupada'
			case tnTipoComprobante = 53
				lcRetorno = 'Notadedebitoagrupada'
			case tnTipoComprobante = 54
				lcRetorno = 'Facturaelectronicadecredito'
			case tnTipoComprobante = 55
				lcRetorno = 'Notadecreditoelectronicadecredito'
			case tnTipoComprobante = 56
				lcRetorno = 'Notadedebitoelectronicadecredito'
			case tnTipoComprobante = 57
				lcRetorno = 'Preparaciondemercaderia'
			case tnTipoComprobante = 58
				lcRetorno = 'Senia'
			otherwise
				lcRetorno = '[' + transform( tnTipoComprobante ) + '] Comprobante Desconocido'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerNumeroComprobante( tcEntidad as string ) as Integer
		Local lnRetorno as integer
		
		lnRetorno = 0
		do case
			case upper(tcEntidad) = 'FACTURA'
				lnRetorno = 1
			case upper(tcEntidad) = 'TICKETFACTURA'
				lnRetorno = 2
			case upper(tcEntidad) = 'NOTADECREDITO'
				lnRetorno = 3
			case upper(tcEntidad) = 'NOTADEDEBITO'
				lnRetorno = 4
			case upper(tcEntidad) = 'TICKETNOTADECREDITO'
				lnRetorno = 5
			case upper(tcEntidad) = 'TICKETNOTADEDEBITO'
				lnRetorno = 6
			case upper(tcEntidad) = 'FACTURADECOMPRA'
				lnRetorno = 8
			case upper(tcEntidad) = 'NOTADEDEBITOCOMPRA'
				lnRetorno = 9
			case upper(tcEntidad) = 'NOTADECREDITOCOMPRA'
				lnRetorno = 10
			case upper(tcEntidad) = 'REMITO'
				lnRetorno = 11
			case upper(tcEntidad) = 'DEVOLUCION'
				lnRetorno = 12
			case upper(tcEntidad) = 'RECIBO'
				lnRetorno = 13
			case upper(tcEntidad) = 'PEDIDO'
				lnRetorno = 23
			case upper(tcEntidad) = 'PRESUPUESTO'
				lnRetorno = 25
			case upper(tcEntidad) = 'FACTURAELECTRONICA'
				lnRetorno = 27
			case upper(tcEntidad) = 'NOTADECREDITOELECTRONICA'
				lnRetorno = 28
			case upper(tcEntidad) = 'NOTADEDEBITOELECTRONICA'
				lnRetorno = 29
			case upper(tcEntidad) = 'PRESUPUESTODECOMPRA'
				lnRetorno = 30
			case upper(tcEntidad) = 'ORDENDEPAGO'
				lnRetorno = 31
			case upper(tcEntidad) = 'CANJEDECUPONES'
				lnRetorno = 32
			case upper(tcEntidad) = 'FACTURAELECTRONICAEXPORTACION'
				lnRetorno = 33
			case upper(tcEntidad) = 'NOTADECREDITOELECTRONICAEXPORTACION'
				lnRetorno = 35
			case upper(tcEntidad) = 'NOTADEDEBITOELECTRONICAEXPORTACION'
				lnRetorno = 36
			case upper(tcEntidad) = 'PAGO'
				lnRetorno = 37
			case upper(tcEntidad) = 'PEDIDODECOMPRA'
				lnRetorno = 38
			case upper(tcEntidad) = 'SOLICITUDDECOMPRA'
				lnRetorno = 39
			case upper(tcEntidad) = 'REQUERIMIENTODECOMPRA'
				lnRetorno = 40
			case upper(tcEntidad) = 'REMITODECOMPRA'
				lnRetorno = 41
			case upper(tcEntidad) = 'AJUSTECCPROVEEDOR'
				lnRetorno = 42
			case upper(tcEntidad) = 'AJUSTECCCLIENTE'
				lnRetorno = 43
			case upper(tcEntidad) = 'CANCELACIONDECOMPRA'
				lnRetorno = 44
			case upper(tcEntidad) = 'CANCELACIONDESENIAS'
				lnRetorno = 45
			case upper(tcEntidad) = 'DESCARGADECHEQUES'
				lnRetorno = 46
			case upper(tcEntidad) = 'FACTURADEEXPORTACION'
				lnRetorno = 47
			case upper(tcEntidad) = 'NOTADECREDITODEEXPORTACION'
				lnRetorno = 48
			case upper(tcEntidad) = 'NOTADEDEBITODEEXPORTACION'
				lnRetorno = 49
			case upper(tcEntidad) = 'COMPROBANTEPAGO'
				lnRetorno = 50
			case upper(tcEntidad) = 'FACTURAAGRUPADA'
				lnRetorno = 51
			case upper(tcEntidad) = 'NOTADECREDITOAGRUPADA'
				lnRetorno = 52
			case upper(tcEntidad) = 'NOTADEDEBITOAGRUPADA'
				lnRetorno = 53
			case upper(tcEntidad) = 'FACTURAELECTRONICADECREDITO'
				lnRetorno = 54
			case upper(tcEntidad) = 'NOTADECREDITOELECTRONICADECREDITO'
				lnRetorno = 55
			case upper(tcEntidad) = 'NOTADEDEBITOELECTRONICADECREDITO'
				lnRetorno = 56
			case upper(tcEntidad) = 'PREPARACIONDEMERCADERIA'
				lnRetorno = 57
			case upper(tcEntidad) = 'SENIA'
				lnRetorno = 58
		endcase
		return lnRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerEstadoDeStockDeComprobante( tcEntidad as string ) as string
		Local lcRetorno as string
		
		lcRetorno = ''
		do case
			case upper(tcEntidad) = 'FACTURA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'TICKETFACTURA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'TICKETNOTADECREDITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'TICKETNOTADEDEBITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'FACTURADECOMPRA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITOCOMPRA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITOCOMPRA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'REMITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'DEVOLUCION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'RECIBO'
				lcRetorno = ''
			case upper(tcEntidad) = 'PEDIDO'
				lcRetorno = 'Pedido'
			case upper(tcEntidad) = 'PRESUPUESTO'
				lcRetorno = 'Presupuestado'
			case upper(tcEntidad) = 'FACTURAELECTRONICA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITOELECTRONICA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITOELECTRONICA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'PRESUPUESTODECOMPRA'
				lcRetorno = 'PreCompra'
			case upper(tcEntidad) = 'ORDENDEPAGO'
				lcRetorno = ''
			case upper(tcEntidad) = 'CANJEDECUPONES'
				lcRetorno = ''
			case upper(tcEntidad) = 'FACTURAELECTRONICAEXPORTACION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITOELECTRONICAEXPORTACION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITOELECTRONICAEXPORTACION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'PAGO'
				lcRetorno = ''
			case upper(tcEntidad) = 'PEDIDODECOMPRA'
				lcRetorno = 'PedCompra'
			case upper(tcEntidad) = 'SOLICITUDDECOMPRA'
				lcRetorno = 'SolCompra'
			case upper(tcEntidad) = 'REQUERIMIENTODECOMPRA'
				lcRetorno = 'ReqCompra'
			case upper(tcEntidad) = 'REMITODECOMPRA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'AJUSTECCPROVEEDOR'
				lcRetorno = ''
			case upper(tcEntidad) = 'AJUSTECCCLIENTE'
				lcRetorno = ''
			case upper(tcEntidad) = 'CANCELACIONDECOMPRA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'CANCELACIONDESENIAS'
				lcRetorno = ''
			case upper(tcEntidad) = 'DESCARGADECHEQUES'
				lcRetorno = ''
			case upper(tcEntidad) = 'FACTURADEEXPORTACION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITODEEXPORTACION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITODEEXPORTACION'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'COMPROBANTEPAGO'
				lcRetorno = ''
			case upper(tcEntidad) = 'FACTURAAGRUPADA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITOAGRUPADA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITOAGRUPADA'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'FACTURAELECTRONICADECREDITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADECREDITOELECTRONICADECREDITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'NOTADEDEBITOELECTRONICADECREDITO'
				lcRetorno = 'Cantidad'
			case upper(tcEntidad) = 'PREPARACIONDEMERCADERIA'
				lcRetorno = 'Preparado'
			case upper(tcEntidad) = 'SENIA'
				lcRetorno = 'Seniado'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerEstadosDeStock( ) as zoocoleccion
		Local lcolEstados as zoocoleccion 
		
		lcolEstados = _screen.zoo.crearobjeto('zoocoleccion')
		lcolEstados.Agregar( "Cantidad")
		lcolEstados.Agregar( "PedCompra")
		lcolEstados.Agregar( "Pedido")
		lcolEstados.Agregar( "PreCompra")
		lcolEstados.Agregar( "Preparado")
		lcolEstados.Agregar( "Presupuestado")
		lcolEstados.Agregar( "ReqCompra")
		lcolEstados.Agregar( "Seniado")
		lcolEstados.Agregar( "SolCompra")
		lcolEstados.Agregar( "EntregaPen")
		
		return lcolEstados
	endfunc

enddefine