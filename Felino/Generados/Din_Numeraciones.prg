
define class Din_Numeraciones as ZooSession of ZooSession.prg

	protected oColEntidades, oEntidad, oColTalonarios
	oColEntidades = null
	oColTalonarios = null

	*-----------------------------------------------------------------------------------------
	function ObtenerItemEntidad()
		local loItem as Empty
		loItem = newobject( 'Empty' )
		AddProperty( loItem, 'cEntidad', '' )
		AddProperty( loItem, 'cAtributo', '' )
		AddProperty( loItem, 'lNumeracionPrincipal', .f. )
		AddProperty( loItem, 'oColTalonarios', null )
		return loItem
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerItemTalonario()
		local loItem as Empty
		loItem = newobject( 'Empty' )
		AddProperty( loItem, 'cTalonario', '' )
		AddProperty( loItem, 'cCondicion', '' )
		AddProperty( loItem, 'cServicio', '' )
		AddProperty( loItem, 'lPuedeReservar', '' )
		return loItem
	endfunc
	*-----------------------------------------------------------------------------------------
	function Inicializar()

		this.oColEntidades = newobject( 'zooColeccion', 'zooColeccion.prg' )
		dodefa()

	endfunc
	*-----------------------------------------------------------------------------------------
	function SetearEntidad( toEntidad as object )
		local loItem as object, loItemTalonario as object
		 dodefault( toEntidad )
		Do Case

			Case upper(alltrim( toEntidad.cNombre)) == 'AJUSTEDEESTADOS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [AJUSTEDEESTADOS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [AJUSTEDEESTADOS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['AJE']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'AJUSTEDESTOCK'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [AJUSTEDESTOCK]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [AJUSTEDESTOCK.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['AJS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ARQUEODECAJA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ARQUEODECAJA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ARQUEODECAJA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ARQUEODECAJA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ASIENTO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ASIENTO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ASIENTO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ASIENTOS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ASIGNARZBD'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ASIGNARZBD]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ASIGNARZBD.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ASIGNARZBD']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ASOCIACIONARTICULOSOPERACIONESAFIP'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ASOCIACIONARTICULOSOPERACIONESAFIP]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ASOCIACIONARTICULOSOPERACIONESAFIP.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ASOCIACIONARTOPER']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'AJUSTECCCLIENTE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [AjusteCCCliente]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [AJUSTECCCLIENTE.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['43'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'AJUSTECCPROVEEDOR'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [AjusteCCProveedor]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [AJUSTECCPROVEEDOR.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['44'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'BOLSASYCAJAS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [BOLSASYCAJAS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [BOLSASYCAJAS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['BOLSASYCAJAS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CAEAINFORMA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CAEAINFORMA]
				loItem.cAtributo = [NUMEROINTERNO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CAEAINFORMA.NUMEROINTERNO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ["CAEAINFORMA"]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CAEPORLOTE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CAEPORLOTE]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CAEPORLOTE.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CAEPORLOTE']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CALCULODEPRECIOS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CALCULODEPRECIOS]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CALCULODEPRECIOS.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CALCPRECIOS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CANCELACIONDECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CANCELACIONDECOMPRA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CANCELACIONDECOMPRA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['42'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CANCELACIONDESENIAS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CANCELACIONDESENIAS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CANCELACIONDESENIAS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CANCELACIONDESENIAS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CANJEDECUPONES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CANJEDECUPONES]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CANJEDECUPONES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CDC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CATEGORIASECOMMERCE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CATEGORIASECOMMERCE]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CATEGORIASECOMMERCE.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ["CATEGORIASECOMMERCE"]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CHEQUE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CHEQUE]
				loItem.cAtributo = [NUMEROC]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CHEQUE.NUMEROC] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CH'+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CHEQUEPROPIO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CHEQUEPROPIO]
				loItem.cAtributo = [NUMEROC]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CHEQUEPROPIO.NUMEROC] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CP'+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CIERREDELOTE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CIERREDELOTE]
				loItem.cAtributo = [NUMEROC]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CIERREDELOTE.NUMEROC] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CL']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CIERREEJERCICIO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CIERREEJERCICIO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CIERREEJERCICIO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CIERREEJ']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CODIGOAUTORIZACIONDJCP'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CODIGOAUTORIZACIONDJCP]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CODIGOAUTORIZACIONDJCP.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CODIGOAUTORIZACIONDJCP']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTEDECAJA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTEDECAJA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTEDECAJA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['COMPROBANTEDECAJA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTEDERETENCIONES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTEDERETENCIONES]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTEDERETENCIONES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CDR' + #PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTEDERETENCIONESGANANCIAS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTEDERETENCIONESGANANCIAS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTEDERETENCIONESGANANCIAS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CRG' + #PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTEDERETENCIONESIVA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTEDERETENCIONESIVA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTEDERETENCIONESIVA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CRI' + #PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTEDERETENCIONESSUSS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTEDERETENCIONESSUSS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTEDERETENCIONESSUSS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CRS' + #PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTEPAGO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTEPAGO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTEPAGO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['COMPROBANTEPAGO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'COMPROBANTESECOMMERCE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [COMPROBANTESECOMMERCE]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [COMPROBANTESECOMMERCE.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['COMPROBANTESECOMMERCE']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CONCILIACIONDECAJA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CONCILIACIONDECAJA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CONCILIACIONDECAJA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CONCILIACIONDECAJA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CONCILIACIONES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CONCILIACIONES]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CONCILIACIONES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CONCILIACIONES']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CONTABILIZACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CONTABILIZACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CONTABILIZACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CONTA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CRITERIOSVALORES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CRITERIOSVALORES]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CRITERIOSVALORES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CRITERIOSVALORES']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'CUPON'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [CUPON]
				loItem.cAtributo = [NUMEROINTERNO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [CUPON.NUMEROINTERNO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['CUP'+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'DEVOLUCION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [DEVOLUCION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [DEVOLUCION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['12'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'DESCARGADECHEQUES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [Descargadecheques]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [DESCARGADECHEQUES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['46'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'EJERCICIO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [EJERCICIO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [EJERCICIO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['EJERCICIO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ENTREGADEMERCADERIAS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ENTREGADEMERCADERIAS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ENTREGADEMERCADERIAS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ENTREGADEMERCADERIAS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ETIQUETASECOMMERCE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ETIQUETASECOMMERCE]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ETIQUETASECOMMERCE.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ["ETIQUETASECOMMERCE"]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['1'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURADECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURADECOMPRA]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURADECOMPRA.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['FDC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURADEEXPORTACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURADEEXPORTACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURADEEXPORTACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['47'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURAELECTRONICA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURAELECTRONICA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURAELECTRONICA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['27'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURAELECTRONICADECREDITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURAELECTRONICADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURAELECTRONICADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['54'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURAELECTRONICAEXPORTACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURAELECTRONICAEXPORTACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURAELECTRONICAEXPORTACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['33'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'GESTIONCHCUSTODIA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [GESTIONCHCUSTODIA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [GESTIONCHCUSTODIA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['GESTIONCHCUSTODIA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRART'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRART]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRART.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRART']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRCAJ'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRCAJ]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRCAJ.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRCAJ']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRCCA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRCCA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRCCA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRCCA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRCCC'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRCCC]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRCCC.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRCCC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRCLI'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRCLI]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRCLI.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRCLI']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRCON'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRCON]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRCON.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRCON']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRDES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRDES]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRDES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRDES']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRIMP'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRIMP]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRIMP.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRIMP']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRLIQ'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRLIQ]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRLIQ.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRLIQ']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIROPE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIROPE]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIROPE.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIROPE']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRPRO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRPRO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRPRO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRPRO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPDIRVAL'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPDIRVAL]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPDIRVAL.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPDIRVAL']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPRESIONDEETIQUETA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPRESIONDEETIQUETA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPRESIONDEETIQUETA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPET']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPRIMIRCOMPROBANTEPORLOTE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPRIMIRCOMPROBANTEPORLOTE]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPRIMIRCOMPROBANTEPORLOTE.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ICPL']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'IMPVERCC'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [IMPVERCC]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [IMPVERCC.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['IMPVERCC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'LIMITECONSUMO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [LIMITECONSUMO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [LIMITECONSUMO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['LIMCONSUMO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'LIQUIDACIONMENSUAL'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [LIQUIDACIONMENSUAL]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [LIQUIDACIONMENSUAL.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['LQM']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'LISTADEPRECIOSCALCULADA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [LISTADEPRECIOSCALCULADA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [LISTADEPRECIOSCALCULADA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['LISTADEPRECIOSCALCULADA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'MERCADERIAENTRANSITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [MERCADERIAENTRANSITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [MERCADERIAENTRANSITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['MERCENTRANS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'MINIMOREPOSICION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [MINIMOREPOSICION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [MINIMOREPOSICION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['MINREPOSICION']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'MODIFICACIONPRECIOS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [MODIFICACIONPRECIOS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [MODIFICACIONPRECIOS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['MODIPRECIOS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'MOVIMIENTODESTOCK'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [MOVIMIENTODESTOCK]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [MOVIMIENTODESTOCK.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['MOVSTOCK']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['3'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITOCOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOCOMPRA]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOCOMPRA.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['NCC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITODEEXPORTACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITODEEXPORTACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITODEEXPORTACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['48'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITOELECTRONICA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOELECTRONICA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOELECTRONICA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['28'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITOELECTRONICADECREDITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOELECTRONICADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOELECTRONICADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['55'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITOELECTRONICAEXPORTACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOELECTRONICAEXPORTACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOELECTRONICAEXPORTACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['35'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['4'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITOCOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOCOMPRA]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOCOMPRA.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['NDC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITODEEXPORTACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITODEEXPORTACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITODEEXPORTACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['49'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITOELECTRONICA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOELECTRONICA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOELECTRONICA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['29'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITOELECTRONICADECREDITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOELECTRONICADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOELECTRONICADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['56'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITOELECTRONICAEXPORTACION'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOELECTRONICAEXPORTACION]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOELECTRONICAEXPORTACION.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['36'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'ORDENDEPAGO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [ORDENDEPAGO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [ORDENDEPAGO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['31'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PAGO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PAGO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PAGO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['37'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PASAJEDESTOCK'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PASAJEDESTOCK]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PASAJEDESTOCK.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['PASAJEDESTOCK']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PEDIDO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PEDIDO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PEDIDO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['23'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PEDIDODECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PEDIDODECOMPRA]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PEDIDODECOMPRA.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['38'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PREPARACIONDEMERCADERIA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PREPARACIONDEMERCADERIA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PREPARACIONDEMERCADERIA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['57'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PRESUPUESTO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PRESUPUESTO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PRESUPUESTO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['25'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PRESUPUESTODECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PRESUPUESTODECOMPRA]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PRESUPUESTODECOMPRA.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['30'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PUNTOSDEVENTA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [PUNTOSDEVENTA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PUNTOSDEVENTA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['PUNTOSDEVENTA']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'PICKING'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [Picking]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [PICKING.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['Picking']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'RECIBO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [RECIBO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [RECIBO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['13'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'REMITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [REMITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [REMITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['11'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'REMITODECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [REMITODECOMPRA]
				loItem.cAtributo = [NUMINT]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [REMITODECOMPRA.NUMINT] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['RCO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'REMITOELECTRONICO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [REMITOELECTRONICO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [REMITOELECTRONICO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['REMITOELECTRONICO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'REPORTEAUDITORIACIERREZ'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [REPORTEAUDITORIACIERREZ]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [REPORTEAUDITORIACIERREZ.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['REPAUDICIERREZ']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'REPORTEELECTRONICO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [REPORTEELECTRONICO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [REPORTEELECTRONICO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['REPORTEELECTRONICO ']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'REQUERIMIENTODECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [REQUERIMIENTODECOMPRA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [REQUERIMIENTODECOMPRA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['40'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'SOLICITUDDECOMPRA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [SOLICITUDDECOMPRA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [SOLICITUDDECOMPRA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['39'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TICKETFACTURA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TICKETFACTURA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TICKETFACTURA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['FC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [CF]
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )
				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['RF'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [REG]
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TICKETNOTADECREDITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TICKETNOTADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TICKETNOTADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['NC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [CF]
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )
				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['RNC'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [REG]
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TICKETNOTADEDEBITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TICKETNOTADEDEBITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TICKETNOTADEDEBITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ND']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [CF]
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TIDIFERENCIASDEINVENTARIO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TIDiferenciasDeInventario]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TIDIFERENCIASDEINVENTARIO.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['TIDiferenciasDeInventario']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TIINVENTARIOACONT'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TIInventarioACont]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TIINVENTARIOACONT.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['TIInventarioACont']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TIINVENTARIOFISICO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TIInventarioFisico]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TIINVENTARIOFISICO.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['TIInventarioFisico']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TIINVENTARIOFISICODETALLE'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TIInventarioFisicoDetalle]
				loItem.cAtributo = [CODIGO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TIINVENTARIOFISICODETALLE.CODIGO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['TIInventarioFisicoDetalle']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TRANSFERENCIAENTRECUENTAS'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TRANSFERENCIAENTRECUENTAS]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .F.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TRANSFERENCIAENTRECUENTAS.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['TRANSFERENCIAENTRECUENTAS']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'TRATAMIENTOCOMPROBANTES'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TRATAMIENTOCOMPROBANTES]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TRATAMIENTOCOMPROBANTES.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['TRATCOMPROBANTES']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'VALORESENTRANSITO'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [VALORESENTRANSITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [VALORESENTRANSITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['VALORESENTRANSITO']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'FACTURAAGRUPADA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['1'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURAAGRUPADA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURAAGRUPADA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['FA'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURAELECTRONICA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURAELECTRONICA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['27'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [FACTURAELECTRONICADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [FACTURAELECTRONICADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['54'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TICKETFACTURA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TICKETFACTURA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['FC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [CF]
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )
				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['RF'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [REG]
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADEDEBITOAGRUPADA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['4'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOAGRUPADA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOAGRUPADA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['53'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOELECTRONICA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOELECTRONICA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['29'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADEDEBITOELECTRONICADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADEDEBITOELECTRONICADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['56'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TICKETNOTADEDEBITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TICKETNOTADEDEBITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['ND']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [CF]
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

			Case upper(alltrim( toEntidad.cNombre)) == 'NOTADECREDITOAGRUPADA'
				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['3'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOAGRUPADA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOAGRUPADA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['52'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOELECTRONICA]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOELECTRONICA.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['28'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [NOTADECREDITOELECTRONICADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [NOTADECREDITOELECTRONICADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['55'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = []
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

				loItem = this.ObtenerItemEntidad()
				loItem.cEntidad = [TICKETNOTADECREDITO]
				loItem.cAtributo = [NUMERO]
				loItem.lNumeracionPrincipal = .T.
				loItem.oColTalonarios = newobject( 'zooColeccion', 'zooColeccion.prg' )
				this.oColEntidades.agregar( loItem, [TICKETNOTADECREDITO.NUMERO] )

				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['NC']
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [CF]
				loItemTalonario.lPuedeReservar = .T.
				loItem.oColTalonarios.agregar( loItemTalonario )
				loItemTalonario = this.ObtenerItemTalonario()
				loItemTalonario.cTalonario = ['RNC'+#letra@+#PuntoDeVenta@]
				loItemTalonario.cCondicion = []
				loItemTalonario.cServicio = [REG]
				loItemTalonario.lPuedeReservar = .F.
				loItem.oColTalonarios.agregar( loItemTalonario )

		EndCase
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerNumero( tcAtributo as string )
	endfunc

	*-----------------------------------------------------------------------------------------
	function Grabar()
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerAtributo( tcEntidad as String )
		local lcAtributo as String
		Do Case

			Case upper(alltrim( tcEntidad)) == 'AJUSTEDEESTADOS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'AJUSTEDESTOCK'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ARQUEODECAJA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ASIENTO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ASIGNARZBD'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ASOCIACIONARTICULOSOPERACIONESAFIP'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'AJUSTECCCLIENTE'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'AJUSTECCPROVEEDOR'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'BOLSASYCAJAS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CAEAINFORMA'
				lcAtributo = 'NUMEROINTERNO'
			Case upper(alltrim( tcEntidad)) == 'CAEPORLOTE'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'CALCULODEPRECIOS'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'CANCELACIONDECOMPRA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CANCELACIONDESENIAS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CANJEDECUPONES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CATEGORIASECOMMERCE'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'CHEQUE'
				lcAtributo = 'NUMEROC'
			Case upper(alltrim( tcEntidad)) == 'CHEQUEPROPIO'
				lcAtributo = 'NUMEROC'
			Case upper(alltrim( tcEntidad)) == 'CIERREDELOTE'
				lcAtributo = 'NUMEROC'
			Case upper(alltrim( tcEntidad)) == 'CIERREEJERCICIO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CODIGOAUTORIZACIONDJCP'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTEDECAJA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTEDERETENCIONES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTEDERETENCIONESGANANCIAS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTEDERETENCIONESIVA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTEDERETENCIONESSUSS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTEPAGO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'COMPROBANTESECOMMERCE'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CONCILIACIONDECAJA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CONCILIACIONES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CONTABILIZACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CRITERIOSVALORES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'CUPON'
				lcAtributo = 'NUMEROINTERNO'
			Case upper(alltrim( tcEntidad)) == 'DEVOLUCION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'DESCARGADECHEQUES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'EJERCICIO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ENTREGADEMERCADERIAS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ETIQUETASECOMMERCE'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'FACTURA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'FACTURAAGRUPADA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'FACTURADECOMPRA'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'FACTURADEEXPORTACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'FACTURAELECTRONICA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'FACTURAELECTRONICADECREDITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'FACTURAELECTRONICAEXPORTACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'GESTIONCHCUSTODIA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRART'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRCAJ'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRCCA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRCCC'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRCLI'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRCON'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRDES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRIMP'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRLIQ'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIROPE'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRPRO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPDIRVAL'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPRESIONDEETIQUETA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'IMPRIMIRCOMPROBANTEPORLOTE'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'IMPVERCC'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'LIMITECONSUMO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'LIQUIDACIONMENSUAL'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'LISTADEPRECIOSCALCULADA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'MERCADERIAENTRANSITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'MINIMOREPOSICION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'MODIFICACIONPRECIOS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'MOVIMIENTODESTOCK'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITOAGRUPADA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITOCOMPRA'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITODEEXPORTACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITOELECTRONICA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITOELECTRONICADECREDITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADECREDITOELECTRONICAEXPORTACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITOAGRUPADA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITOCOMPRA'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITODEEXPORTACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITOELECTRONICA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITOELECTRONICADECREDITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'NOTADEDEBITOELECTRONICAEXPORTACION'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'ORDENDEPAGO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'PAGO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'PASAJEDESTOCK'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'PEDIDO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'PEDIDODECOMPRA'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'PREPARACIONDEMERCADERIA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'PRESUPUESTO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'PRESUPUESTODECOMPRA'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'PUNTOSDEVENTA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'PICKING'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'RECIBO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'REMITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'REMITODECOMPRA'
				lcAtributo = 'NUMINT'
			Case upper(alltrim( tcEntidad)) == 'REMITOELECTRONICO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'REPORTEAUDITORIACIERREZ'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'REPORTEELECTRONICO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'REQUERIMIENTODECOMPRA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'SOLICITUDDECOMPRA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TICKETFACTURA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TICKETFACTURA'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TICKETNOTADECREDITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TICKETNOTADECREDITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TICKETNOTADEDEBITO'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TIDIFERENCIASDEINVENTARIO'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'TIINVENTARIOACONT'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'TIINVENTARIOFISICO'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'TIINVENTARIOFISICODETALLE'
				lcAtributo = 'CODIGO'
			Case upper(alltrim( tcEntidad)) == 'TRANSFERENCIAENTRECUENTAS'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'TRATAMIENTOCOMPROBANTES'
				lcAtributo = 'NUMERO'
			Case upper(alltrim( tcEntidad)) == 'VALORESENTRANSITO'
				lcAtributo = 'NUMERO'
			otherwise
				lcAtributo = ''
		EndCase

		return lcAtributo

	endfunc

enddefine