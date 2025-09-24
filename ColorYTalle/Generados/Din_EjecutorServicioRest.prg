
define class Din_EjecutorServicioRest as EjecutorServicioRest of EjecutorServicioRest.prg

	oOperacionesEntidadAccionesautomaticas = null
	oOperacionesEntidadAgrupamientopublicaciones = null
	oOperacionesEntidadAjustecccliente = null
	oOperacionesEntidadAjusteccproveedor = null
	oOperacionesEntidadAjustechequerechazado = null
	oOperacionesEntidadAjustedeestados = null
	oOperacionesEntidadAjustedestock = null
	oOperacionesEntidadAliviodecaja = null
	oOperacionesEntidadAperturaejercicio = null
	oOperacionesEntidadArqueodecaja = null
	oOperacionesEntidadArticulo = null
	oOperacionesEntidadAsiento = null
	oOperacionesEntidadAsientosperiodicos = null
	oOperacionesEntidadAsientotipo = null
	oOperacionesEntidadAsignarzbd = null
	oOperacionesEntidadBolsasycajas = null
	oOperacionesEntidadCaea = null
	oOperacionesEntidadCaeainforma = null
	oOperacionesEntidadCaeporlote = null
	oOperacionesEntidadCai = null
	oOperacionesEntidadCajaestado = null
	oOperacionesEntidadCalculodeprecios = null
	oOperacionesEntidadCancelaciondecompra = null
	oOperacionesEntidadCancelaciondesenias = null
	oOperacionesEntidadCanjedecupones = null
	oOperacionesEntidadCategoriacliente = null
	oOperacionesEntidadCategoriadearticulo = null
	oOperacionesEntidadCategoriasecommerce = null
	oOperacionesEntidadCategoriasgoogleshopping = null
	oOperacionesEntidadCentrodecosto = null
	oOperacionesEntidadCheque = null
	oOperacionesEntidadChequepropio = null
	oOperacionesEntidadChequera = null
	oOperacionesEntidadChequesdisponibles = null
	oOperacionesEntidadCierredelote = null
	oOperacionesEntidadCierreejercicio = null
	oOperacionesEntidadClasedetarjeta = null
	oOperacionesEntidadClasificacionarticulo = null
	oOperacionesEntidadClasificacioncliente = null
	oOperacionesEntidadClasificacionconceptocaja = null
	oOperacionesEntidadClasificacionconceptopago = null
	oOperacionesEntidadClasificacionproveedor = null
	oOperacionesEntidadClasificacionvendedor = null
	oOperacionesEntidadCliente = null
	oOperacionesEntidadClienteecommerce = null
	oOperacionesEntidadClienterecomendante = null
	oOperacionesEntidadCodbarraalter = null
	oOperacionesEntidadCodigoautorizaciondjcp = null
	oOperacionesEntidadCodigodeservicio = null
	oOperacionesEntidadColor = null
	oOperacionesEntidadComision = null
	oOperacionesEntidadCompletardesdeventas = null
	oOperacionesEntidadComprobantedecaja = null
	oOperacionesEntidadComprobantederetenciones = null
	oOperacionesEntidadComprobantederetencionesganancias = null
	oOperacionesEntidadComprobantederetencionesiva = null
	oOperacionesEntidadComprobantederetencionessuss = null
	oOperacionesEntidadComprobantederetencionrecibido = null
	oOperacionesEntidadComprobantepago = null
	oOperacionesEntidadComprobantesecommerce = null
	oOperacionesEntidadConceptocaja = null
	oOperacionesEntidadConceptoentidadfinanciera = null
	oOperacionesEntidadConceptoliquidaciontarjeta = null
	oOperacionesEntidadConceptopago = null
	oOperacionesEntidadConciliaciondecaja = null
	oOperacionesEntidadConciliaciones = null
	oOperacionesEntidadCondiciondepago = null
	oOperacionesEntidadCondiciondepagoencomprobante = null
	oOperacionesEntidadConfiguracionarticuloecommerce = null
	oOperacionesEntidadConfirmacionfechavtomipyme = null
	oOperacionesEntidadConfirmacionvaloresentransito = null
	oOperacionesEntidadContabilizacion = null
	oOperacionesEntidadConveniomultilateral = null
	oOperacionesEntidadCorredor = null
	oOperacionesEntidadCriteriosvalores = null
	oOperacionesEntidadCuentabancaria = null
	oOperacionesEntidadCuentacorreo = null
	oOperacionesEntidadCupon = null
	oOperacionesEntidadCuponeshuerfanos = null
	oOperacionesEntidadCuponespendientes = null
	oOperacionesEntidadCurvadetalles = null
	oOperacionesEntidadDatosadicionalessiprib = null
	oOperacionesEntidadDatosfiscales = null
	oOperacionesEntidadDatosretencionrecibido = null
	oOperacionesEntidadDatostareaprogramadaecommerce = null
	oOperacionesEntidadDescargadecheques = null
	oOperacionesEntidadDescuento = null
	oOperacionesEntidadDespachodeimportacion = null
	oOperacionesEntidadDestinodescargacheques = null
	oOperacionesEntidadDevolucion = null
	oOperacionesEntidadDireccionentregaencomprobante = null
	oOperacionesEntidadDisenoimpresion = null
	oOperacionesEntidadDistribucioncentrodecosto = null
	oOperacionesEntidadEcommerce = null
	oOperacionesEntidadEdicionimpuestoivacompras = null
	oOperacionesEntidadEjercicio = null
	oOperacionesEntidadEmail = null
	oOperacionesEntidadEmailencomprobante = null
	oOperacionesEntidadEntidadadicional1 = null
	oOperacionesEntidadEntidadadicional2 = null
	oOperacionesEntidadEntidadadicional3 = null
	oOperacionesEntidadEntidadfinanciera = null
	oOperacionesEntidadEntregademercaderias = null
	oOperacionesEntidadEnviodecuentacorrientepormail = null
	oOperacionesEntidadEquivalencia = null
	oOperacionesEntidadErrorsap = null
	oOperacionesEntidadEstadosdeinteraccion = null
	oOperacionesEntidadEstiloimpresion = null
	oOperacionesEntidadEtiquetasecommerce = null
	oOperacionesEntidadFactura = null
	oOperacionesEntidadFacturaagrupada = null
	oOperacionesEntidadFacturadecompra = null
	oOperacionesEntidadFacturadeexportacion = null
	oOperacionesEntidadFacturaelectronica = null
	oOperacionesEntidadFacturaelectronicadecredito = null
	oOperacionesEntidadFacturaelectronicaexportacion = null
	oOperacionesEntidadFamilia = null
	oOperacionesEntidadFechacancelacion = null
	oOperacionesEntidadFeriado = null
	oOperacionesEntidadFormula = null
	oOperacionesEntidadGestionchcustodia = null
	oOperacionesEntidadGestionvendedor = null
	oOperacionesEntidadGrupo = null
	oOperacionesEntidadGrupovalor = null
	oOperacionesEntidadGtin = null
	oOperacionesEntidadHerramientaagrupadoradepacks = null
	oOperacionesEntidadImpdirart = null
	oOperacionesEntidadImpdircaj = null
	oOperacionesEntidadImpdircca = null
	oOperacionesEntidadImpdirccc = null
	oOperacionesEntidadImpdircli = null
	oOperacionesEntidadImpdircon = null
	oOperacionesEntidadImpdircue = null
	oOperacionesEntidadImpdirdes = null
	oOperacionesEntidadImpdirimp = null
	oOperacionesEntidadImpdirliq = null
	oOperacionesEntidadImpdirmot = null
	oOperacionesEntidadImpdirope = null
	oOperacionesEntidadImpdirpro = null
	oOperacionesEntidadImpdirval = null
	oOperacionesEntidadImpresiondeetiqueta = null
	oOperacionesEntidadImprimircomprobanteporlote = null
	oOperacionesEntidadImpuesto = null
	oOperacionesEntidadImpvercc = null
	oOperacionesEntidadInconsistenciasap = null
	oOperacionesEntidadIncoterms = null
	oOperacionesEntidadIndicesinflacion = null
	oOperacionesEntidadInteracciondeorden = null
	oOperacionesEntidadJurisdiccion = null
	oOperacionesEntidadLimiteconsumo = null
	oOperacionesEntidadLinea = null
	oOperacionesEntidadLinkqrenetiqueta = null
	oOperacionesEntidadLiquidaciondiaria = null
	oOperacionesEntidadLiquidacionmensual = null
	oOperacionesEntidadListadeprecios = null
	oOperacionesEntidadListadeprecioscalculada = null
	oOperacionesEntidadMailporlote = null
	oOperacionesEntidadMarca = null
	oOperacionesEntidadMaterial = null
	oOperacionesEntidadMercaderiaentransito = null
	oOperacionesEntidadMinimoreposicion = null
	oOperacionesEntidadModificacionprecios = null
	oOperacionesEntidadMoneda = null
	oOperacionesEntidadMonedaafip = null
	oOperacionesEntidadMotivo = null
	oOperacionesEntidadMotivodescuentoydevolucion = null
	oOperacionesEntidadMovimientobancario = null
	oOperacionesEntidadMovimientodestock = null
	oOperacionesEntidadNombredefantasia = null
	oOperacionesEntidadNomencladorarba = null
	oOperacionesEntidadNotadecredito = null
	oOperacionesEntidadNotadecreditoagrupada = null
	oOperacionesEntidadNotadecreditocompra = null
	oOperacionesEntidadNotadecreditodeexportacion = null
	oOperacionesEntidadNotadecreditoelectronica = null
	oOperacionesEntidadNotadecreditoelectronicadecredito = null
	oOperacionesEntidadNotadecreditoelectronicaexportacion = null
	oOperacionesEntidadNotadedebito = null
	oOperacionesEntidadNotadedebitoagrupada = null
	oOperacionesEntidadNotadedebitocompra = null
	oOperacionesEntidadNotadedebitodeexportacion = null
	oOperacionesEntidadNotadedebitoelectronica = null
	oOperacionesEntidadNotadedebitoelectronicadecredito = null
	oOperacionesEntidadNotadedebitoelectronicaexportacion = null
	oOperacionesEntidadNuevoenbasea = null
	oOperacionesEntidadNuevoentregaonline = null
	oOperacionesEntidadNumeraciones = null
	oOperacionesEntidadOperacionecommerce = null
	oOperacionesEntidadOperadoradetarjeta = null
	oOperacionesEntidadOrdendepago = null
	oOperacionesEntidadOrdendeservicio = null
	oOperacionesEntidadOrigendedatos = null
	oOperacionesEntidadPago = null
	oOperacionesEntidadPaisafip = null
	oOperacionesEntidadPaises = null
	oOperacionesEntidadPaletadecolores = null
	oOperacionesEntidadPasajedestock = null
	oOperacionesEntidadPedido = null
	oOperacionesEntidadPedidodecompra = null
	oOperacionesEntidadPicking = null
	oOperacionesEntidadPlandecuentas = null
	oOperacionesEntidadPos = null
	oOperacionesEntidadPreciodearticulo = null
	oOperacionesEntidadPreparaciondemercaderia = null
	oOperacionesEntidadPresupuesto = null
	oOperacionesEntidadPresupuestodecompra = null
	oOperacionesEntidadPromocion = null
	oOperacionesEntidadPropiedadeslistados = null
	oOperacionesEntidadProveedor = null
	oOperacionesEntidadProvincia = null
	oOperacionesEntidadPuntosdeventa = null
	oOperacionesEntidadRazonsocial = null
	oOperacionesEntidadRecibo = null
	oOperacionesEntidadRedondeodeprecios = null
	oOperacionesEntidadRegimenimpositivo = null
	oOperacionesEntidadRegistrodecostos = null
	oOperacionesEntidadRegistrodecuenta = null
	oOperacionesEntidadRemito = null
	oOperacionesEntidadRemitodecompra = null
	oOperacionesEntidadRemitoelectronico = null
	oOperacionesEntidadRenumeraasientos = null
	oOperacionesEntidadReporteauditoriacierrez = null
	oOperacionesEntidadReporteelectronico = null
	oOperacionesEntidadRequerimientodecompra = null
	oOperacionesEntidadSaltodecampo = null
	oOperacionesEntidadSeleccionbasesarchivadas = null
	oOperacionesEntidadSeleccioncomprobanteasociado = null
	oOperacionesEntidadSelecciondespacho = null
	oOperacionesEntidadSeleccionoperacionecommerce = null
	oOperacionesEntidadSeleccionordendeservicio = null
	oOperacionesEntidadSelecompainsertar = null
	oOperacionesEntidadSenia = null
	oOperacionesEntidadSeniapendiente = null
	oOperacionesEntidadSolicituddecompra = null
	oOperacionesEntidadSucursalbancaria = null
	oOperacionesEntidadTalle = null
	oOperacionesEntidadTalonario = null
	oOperacionesEntidadTemporada = null
	oOperacionesEntidadTicketfactura = null
	oOperacionesEntidadTicketnotadecredito = null
	oOperacionesEntidadTicketnotadedebito = null
	oOperacionesEntidadTidiferenciasdeinventario = null
	oOperacionesEntidadTidiferenciasdeinventariodetalle = null
	oOperacionesEntidadTiinventarioacont = null
	oOperacionesEntidadTiinventariofisico = null
	oOperacionesEntidadTiinventariofisicodetalle = null
	oOperacionesEntidadTipocliente = null
	oOperacionesEntidadTipodearticulo = null
	oOperacionesEntidadTipodedireccion = null
	oOperacionesEntidadTipodeorden = null
	oOperacionesEntidadTipoimpuesto = null
	oOperacionesEntidadTransferenciaentrecuentas = null
	oOperacionesEntidadTransportista = null
	oOperacionesEntidadTratamientocomprobantes = null
	oOperacionesEntidadUnidaddemedida = null
	oOperacionesEntidadUnidaddemedidaafip = null
	oOperacionesEntidadUnidaddemedidaarba = null
	oOperacionesEntidadValedecambio = null
	oOperacionesEntidadValor = null
	oOperacionesEntidadValoresentransito = null
	oOperacionesEntidadVendedor = null
	oOperacionesEntidadVendedorencomprobante = null
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAccionesautomaticas_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAccionesautomaticas ) = 'O' or isnull( this.oOperacionesEntidadAccionesautomaticas ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Accionesautomaticas")
			this.oOperacionesEntidadAccionesautomaticas = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAccionesautomaticas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAgrupamientopublicaciones_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAgrupamientopublicaciones ) = 'O' or isnull( this.oOperacionesEntidadAgrupamientopublicaciones ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Agrupamientopublicaciones")
			this.oOperacionesEntidadAgrupamientopublicaciones = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAgrupamientopublicaciones
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAjustecccliente_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAjustecccliente ) = 'O' or isnull( this.oOperacionesEntidadAjustecccliente ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ajustecccliente")
			this.oOperacionesEntidadAjustecccliente = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAjustecccliente
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAjusteccproveedor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAjusteccproveedor ) = 'O' or isnull( this.oOperacionesEntidadAjusteccproveedor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ajusteccproveedor")
			this.oOperacionesEntidadAjusteccproveedor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAjusteccproveedor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAjustechequerechazado_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAjustechequerechazado ) = 'O' or isnull( this.oOperacionesEntidadAjustechequerechazado ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ajustechequerechazado")
			this.oOperacionesEntidadAjustechequerechazado = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAjustechequerechazado
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAjustedeestados_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAjustedeestados ) = 'O' or isnull( this.oOperacionesEntidadAjustedeestados ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ajustedeestados")
			this.oOperacionesEntidadAjustedeestados = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAjustedeestados
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAjustedestock_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAjustedestock ) = 'O' or isnull( this.oOperacionesEntidadAjustedestock ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ajustedestock")
			this.oOperacionesEntidadAjustedestock = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAjustedestock
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAliviodecaja_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAliviodecaja ) = 'O' or isnull( this.oOperacionesEntidadAliviodecaja ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Aliviodecaja")
			this.oOperacionesEntidadAliviodecaja = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAliviodecaja
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAperturaejercicio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAperturaejercicio ) = 'O' or isnull( this.oOperacionesEntidadAperturaejercicio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Aperturaejercicio")
			this.oOperacionesEntidadAperturaejercicio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAperturaejercicio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadArqueodecaja_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadArqueodecaja ) = 'O' or isnull( this.oOperacionesEntidadArqueodecaja ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Arqueodecaja")
			this.oOperacionesEntidadArqueodecaja = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadArqueodecaja
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadArticulo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadArticulo ) = 'O' or isnull( this.oOperacionesEntidadArticulo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Articulo")
			this.oOperacionesEntidadArticulo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadArticulo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAsiento_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAsiento ) = 'O' or isnull( this.oOperacionesEntidadAsiento ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Asiento")
			this.oOperacionesEntidadAsiento = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAsiento
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAsientosperiodicos_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAsientosperiodicos ) = 'O' or isnull( this.oOperacionesEntidadAsientosperiodicos ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Asientosperiodicos")
			this.oOperacionesEntidadAsientosperiodicos = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAsientosperiodicos
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAsientotipo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAsientotipo ) = 'O' or isnull( this.oOperacionesEntidadAsientotipo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Asientotipo")
			this.oOperacionesEntidadAsientotipo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAsientotipo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadAsignarzbd_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadAsignarzbd ) = 'O' or isnull( this.oOperacionesEntidadAsignarzbd ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Asignarzbd")
			this.oOperacionesEntidadAsignarzbd = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadAsignarzbd
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadBolsasycajas_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadBolsasycajas ) = 'O' or isnull( this.oOperacionesEntidadBolsasycajas ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Bolsasycajas")
			this.oOperacionesEntidadBolsasycajas = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadBolsasycajas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCaea_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCaea ) = 'O' or isnull( this.oOperacionesEntidadCaea ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Caea")
			this.oOperacionesEntidadCaea = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCaea
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCaeainforma_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCaeainforma ) = 'O' or isnull( this.oOperacionesEntidadCaeainforma ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Caeainforma")
			this.oOperacionesEntidadCaeainforma = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCaeainforma
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCaeporlote_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCaeporlote ) = 'O' or isnull( this.oOperacionesEntidadCaeporlote ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Caeporlote")
			this.oOperacionesEntidadCaeporlote = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCaeporlote
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCai_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCai ) = 'O' or isnull( this.oOperacionesEntidadCai ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cai")
			this.oOperacionesEntidadCai = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCai
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCajaestado_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCajaestado ) = 'O' or isnull( this.oOperacionesEntidadCajaestado ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cajaestado")
			this.oOperacionesEntidadCajaestado = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCajaestado
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCalculodeprecios_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCalculodeprecios ) = 'O' or isnull( this.oOperacionesEntidadCalculodeprecios ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Calculodeprecios")
			this.oOperacionesEntidadCalculodeprecios = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCalculodeprecios
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCancelaciondecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCancelaciondecompra ) = 'O' or isnull( this.oOperacionesEntidadCancelaciondecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cancelaciondecompra")
			this.oOperacionesEntidadCancelaciondecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCancelaciondecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCancelaciondesenias_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCancelaciondesenias ) = 'O' or isnull( this.oOperacionesEntidadCancelaciondesenias ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cancelaciondesenias")
			this.oOperacionesEntidadCancelaciondesenias = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCancelaciondesenias
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCanjedecupones_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCanjedecupones ) = 'O' or isnull( this.oOperacionesEntidadCanjedecupones ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Canjedecupones")
			this.oOperacionesEntidadCanjedecupones = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCanjedecupones
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCategoriacliente_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCategoriacliente ) = 'O' or isnull( this.oOperacionesEntidadCategoriacliente ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Categoriacliente")
			this.oOperacionesEntidadCategoriacliente = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCategoriacliente
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCategoriadearticulo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCategoriadearticulo ) = 'O' or isnull( this.oOperacionesEntidadCategoriadearticulo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Categoriadearticulo")
			this.oOperacionesEntidadCategoriadearticulo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCategoriadearticulo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCategoriasecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCategoriasecommerce ) = 'O' or isnull( this.oOperacionesEntidadCategoriasecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Categoriasecommerce")
			this.oOperacionesEntidadCategoriasecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCategoriasecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCategoriasgoogleshopping_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCategoriasgoogleshopping ) = 'O' or isnull( this.oOperacionesEntidadCategoriasgoogleshopping ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Categoriasgoogleshopping")
			this.oOperacionesEntidadCategoriasgoogleshopping = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCategoriasgoogleshopping
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCentrodecosto_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCentrodecosto ) = 'O' or isnull( this.oOperacionesEntidadCentrodecosto ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Centrodecosto")
			this.oOperacionesEntidadCentrodecosto = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCentrodecosto
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCheque_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCheque ) = 'O' or isnull( this.oOperacionesEntidadCheque ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cheque")
			this.oOperacionesEntidadCheque = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCheque
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadChequepropio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadChequepropio ) = 'O' or isnull( this.oOperacionesEntidadChequepropio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Chequepropio")
			this.oOperacionesEntidadChequepropio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadChequepropio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadChequera_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadChequera ) = 'O' or isnull( this.oOperacionesEntidadChequera ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Chequera")
			this.oOperacionesEntidadChequera = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadChequera
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadChequesdisponibles_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadChequesdisponibles ) = 'O' or isnull( this.oOperacionesEntidadChequesdisponibles ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Chequesdisponibles")
			this.oOperacionesEntidadChequesdisponibles = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadChequesdisponibles
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCierredelote_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCierredelote ) = 'O' or isnull( this.oOperacionesEntidadCierredelote ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cierredelote")
			this.oOperacionesEntidadCierredelote = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCierredelote
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCierreejercicio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCierreejercicio ) = 'O' or isnull( this.oOperacionesEntidadCierreejercicio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cierreejercicio")
			this.oOperacionesEntidadCierreejercicio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCierreejercicio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasedetarjeta_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasedetarjeta ) = 'O' or isnull( this.oOperacionesEntidadClasedetarjeta ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasedetarjeta")
			this.oOperacionesEntidadClasedetarjeta = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasedetarjeta
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasificacionarticulo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasificacionarticulo ) = 'O' or isnull( this.oOperacionesEntidadClasificacionarticulo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasificacionarticulo")
			this.oOperacionesEntidadClasificacionarticulo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasificacionarticulo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasificacioncliente_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasificacioncliente ) = 'O' or isnull( this.oOperacionesEntidadClasificacioncliente ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasificacioncliente")
			this.oOperacionesEntidadClasificacioncliente = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasificacioncliente
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasificacionconceptocaja_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasificacionconceptocaja ) = 'O' or isnull( this.oOperacionesEntidadClasificacionconceptocaja ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasificacionconceptocaja")
			this.oOperacionesEntidadClasificacionconceptocaja = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasificacionconceptocaja
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasificacionconceptopago_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasificacionconceptopago ) = 'O' or isnull( this.oOperacionesEntidadClasificacionconceptopago ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasificacionconceptopago")
			this.oOperacionesEntidadClasificacionconceptopago = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasificacionconceptopago
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasificacionproveedor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasificacionproveedor ) = 'O' or isnull( this.oOperacionesEntidadClasificacionproveedor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasificacionproveedor")
			this.oOperacionesEntidadClasificacionproveedor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasificacionproveedor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClasificacionvendedor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClasificacionvendedor ) = 'O' or isnull( this.oOperacionesEntidadClasificacionvendedor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clasificacionvendedor")
			this.oOperacionesEntidadClasificacionvendedor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClasificacionvendedor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCliente_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCliente ) = 'O' or isnull( this.oOperacionesEntidadCliente ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cliente")
			this.oOperacionesEntidadCliente = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCliente
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClienteecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClienteecommerce ) = 'O' or isnull( this.oOperacionesEntidadClienteecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clienteecommerce")
			this.oOperacionesEntidadClienteecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClienteecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadClienterecomendante_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadClienterecomendante ) = 'O' or isnull( this.oOperacionesEntidadClienterecomendante ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Clienterecomendante")
			this.oOperacionesEntidadClienterecomendante = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadClienterecomendante
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCodbarraalter_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCodbarraalter ) = 'O' or isnull( this.oOperacionesEntidadCodbarraalter ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Codbarraalter")
			this.oOperacionesEntidadCodbarraalter = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCodbarraalter
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCodigoautorizaciondjcp_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCodigoautorizaciondjcp ) = 'O' or isnull( this.oOperacionesEntidadCodigoautorizaciondjcp ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Codigoautorizaciondjcp")
			this.oOperacionesEntidadCodigoautorizaciondjcp = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCodigoautorizaciondjcp
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCodigodeservicio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCodigodeservicio ) = 'O' or isnull( this.oOperacionesEntidadCodigodeservicio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Codigodeservicio")
			this.oOperacionesEntidadCodigodeservicio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCodigodeservicio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadColor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadColor ) = 'O' or isnull( this.oOperacionesEntidadColor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Color")
			this.oOperacionesEntidadColor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadColor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComision_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComision ) = 'O' or isnull( this.oOperacionesEntidadComision ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comision")
			this.oOperacionesEntidadComision = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComision
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCompletardesdeventas_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCompletardesdeventas ) = 'O' or isnull( this.oOperacionesEntidadCompletardesdeventas ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Completardesdeventas")
			this.oOperacionesEntidadCompletardesdeventas = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCompletardesdeventas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantedecaja_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantedecaja ) = 'O' or isnull( this.oOperacionesEntidadComprobantedecaja ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantedecaja")
			this.oOperacionesEntidadComprobantedecaja = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantedecaja
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantederetenciones_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantederetenciones ) = 'O' or isnull( this.oOperacionesEntidadComprobantederetenciones ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantederetenciones")
			this.oOperacionesEntidadComprobantederetenciones = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantederetenciones
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantederetencionesganancias_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantederetencionesganancias ) = 'O' or isnull( this.oOperacionesEntidadComprobantederetencionesganancias ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantederetencionesganancias")
			this.oOperacionesEntidadComprobantederetencionesganancias = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantederetencionesganancias
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantederetencionesiva_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantederetencionesiva ) = 'O' or isnull( this.oOperacionesEntidadComprobantederetencionesiva ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantederetencionesiva")
			this.oOperacionesEntidadComprobantederetencionesiva = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantederetencionesiva
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantederetencionessuss_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantederetencionessuss ) = 'O' or isnull( this.oOperacionesEntidadComprobantederetencionessuss ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantederetencionessuss")
			this.oOperacionesEntidadComprobantederetencionessuss = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantederetencionessuss
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantederetencionrecibido_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantederetencionrecibido ) = 'O' or isnull( this.oOperacionesEntidadComprobantederetencionrecibido ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantederetencionrecibido")
			this.oOperacionesEntidadComprobantederetencionrecibido = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantederetencionrecibido
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantepago_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantepago ) = 'O' or isnull( this.oOperacionesEntidadComprobantepago ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantepago")
			this.oOperacionesEntidadComprobantepago = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantepago
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadComprobantesecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadComprobantesecommerce ) = 'O' or isnull( this.oOperacionesEntidadComprobantesecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Comprobantesecommerce")
			this.oOperacionesEntidadComprobantesecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadComprobantesecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConceptocaja_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConceptocaja ) = 'O' or isnull( this.oOperacionesEntidadConceptocaja ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conceptocaja")
			this.oOperacionesEntidadConceptocaja = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConceptocaja
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConceptoentidadfinanciera_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConceptoentidadfinanciera ) = 'O' or isnull( this.oOperacionesEntidadConceptoentidadfinanciera ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conceptoentidadfinanciera")
			this.oOperacionesEntidadConceptoentidadfinanciera = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConceptoentidadfinanciera
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConceptoliquidaciontarjeta_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConceptoliquidaciontarjeta ) = 'O' or isnull( this.oOperacionesEntidadConceptoliquidaciontarjeta ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conceptoliquidaciontarjeta")
			this.oOperacionesEntidadConceptoliquidaciontarjeta = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConceptoliquidaciontarjeta
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConceptopago_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConceptopago ) = 'O' or isnull( this.oOperacionesEntidadConceptopago ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conceptopago")
			this.oOperacionesEntidadConceptopago = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConceptopago
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConciliaciondecaja_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConciliaciondecaja ) = 'O' or isnull( this.oOperacionesEntidadConciliaciondecaja ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conciliaciondecaja")
			this.oOperacionesEntidadConciliaciondecaja = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConciliaciondecaja
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConciliaciones_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConciliaciones ) = 'O' or isnull( this.oOperacionesEntidadConciliaciones ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conciliaciones")
			this.oOperacionesEntidadConciliaciones = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConciliaciones
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCondiciondepago_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCondiciondepago ) = 'O' or isnull( this.oOperacionesEntidadCondiciondepago ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Condiciondepago")
			this.oOperacionesEntidadCondiciondepago = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCondiciondepago
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCondiciondepagoencomprobante_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCondiciondepagoencomprobante ) = 'O' or isnull( this.oOperacionesEntidadCondiciondepagoencomprobante ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Condiciondepagoencomprobante")
			this.oOperacionesEntidadCondiciondepagoencomprobante = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCondiciondepagoencomprobante
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConfiguracionarticuloecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConfiguracionarticuloecommerce ) = 'O' or isnull( this.oOperacionesEntidadConfiguracionarticuloecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Configuracionarticuloecommerce")
			this.oOperacionesEntidadConfiguracionarticuloecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConfiguracionarticuloecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConfirmacionfechavtomipyme_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConfirmacionfechavtomipyme ) = 'O' or isnull( this.oOperacionesEntidadConfirmacionfechavtomipyme ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Confirmacionfechavtomipyme")
			this.oOperacionesEntidadConfirmacionfechavtomipyme = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConfirmacionfechavtomipyme
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConfirmacionvaloresentransito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConfirmacionvaloresentransito ) = 'O' or isnull( this.oOperacionesEntidadConfirmacionvaloresentransito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Confirmacionvaloresentransito")
			this.oOperacionesEntidadConfirmacionvaloresentransito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConfirmacionvaloresentransito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadContabilizacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadContabilizacion ) = 'O' or isnull( this.oOperacionesEntidadContabilizacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Contabilizacion")
			this.oOperacionesEntidadContabilizacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadContabilizacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadConveniomultilateral_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadConveniomultilateral ) = 'O' or isnull( this.oOperacionesEntidadConveniomultilateral ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Conveniomultilateral")
			this.oOperacionesEntidadConveniomultilateral = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadConveniomultilateral
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCorredor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCorredor ) = 'O' or isnull( this.oOperacionesEntidadCorredor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Corredor")
			this.oOperacionesEntidadCorredor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCorredor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCriteriosvalores_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCriteriosvalores ) = 'O' or isnull( this.oOperacionesEntidadCriteriosvalores ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Criteriosvalores")
			this.oOperacionesEntidadCriteriosvalores = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCriteriosvalores
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCuentabancaria_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCuentabancaria ) = 'O' or isnull( this.oOperacionesEntidadCuentabancaria ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cuentabancaria")
			this.oOperacionesEntidadCuentabancaria = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCuentabancaria
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCuentacorreo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCuentacorreo ) = 'O' or isnull( this.oOperacionesEntidadCuentacorreo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cuentacorreo")
			this.oOperacionesEntidadCuentacorreo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCuentacorreo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCupon_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCupon ) = 'O' or isnull( this.oOperacionesEntidadCupon ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cupon")
			this.oOperacionesEntidadCupon = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCupon
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCuponeshuerfanos_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCuponeshuerfanos ) = 'O' or isnull( this.oOperacionesEntidadCuponeshuerfanos ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cuponeshuerfanos")
			this.oOperacionesEntidadCuponeshuerfanos = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCuponeshuerfanos
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCuponespendientes_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCuponespendientes ) = 'O' or isnull( this.oOperacionesEntidadCuponespendientes ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Cuponespendientes")
			this.oOperacionesEntidadCuponespendientes = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCuponespendientes
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadCurvadetalles_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadCurvadetalles ) = 'O' or isnull( this.oOperacionesEntidadCurvadetalles ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Curvadetalles")
			this.oOperacionesEntidadCurvadetalles = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadCurvadetalles
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDatosadicionalessiprib_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDatosadicionalessiprib ) = 'O' or isnull( this.oOperacionesEntidadDatosadicionalessiprib ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Datosadicionalessiprib")
			this.oOperacionesEntidadDatosadicionalessiprib = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDatosadicionalessiprib
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDatosfiscales_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDatosfiscales ) = 'O' or isnull( this.oOperacionesEntidadDatosfiscales ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Datosfiscales")
			this.oOperacionesEntidadDatosfiscales = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDatosfiscales
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDatosretencionrecibido_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDatosretencionrecibido ) = 'O' or isnull( this.oOperacionesEntidadDatosretencionrecibido ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Datosretencionrecibido")
			this.oOperacionesEntidadDatosretencionrecibido = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDatosretencionrecibido
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDatostareaprogramadaecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDatostareaprogramadaecommerce ) = 'O' or isnull( this.oOperacionesEntidadDatostareaprogramadaecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Datostareaprogramadaecommerce")
			this.oOperacionesEntidadDatostareaprogramadaecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDatostareaprogramadaecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDescargadecheques_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDescargadecheques ) = 'O' or isnull( this.oOperacionesEntidadDescargadecheques ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Descargadecheques")
			this.oOperacionesEntidadDescargadecheques = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDescargadecheques
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDescuento_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDescuento ) = 'O' or isnull( this.oOperacionesEntidadDescuento ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Descuento")
			this.oOperacionesEntidadDescuento = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDescuento
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDespachodeimportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDespachodeimportacion ) = 'O' or isnull( this.oOperacionesEntidadDespachodeimportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Despachodeimportacion")
			this.oOperacionesEntidadDespachodeimportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDespachodeimportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDestinodescargacheques_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDestinodescargacheques ) = 'O' or isnull( this.oOperacionesEntidadDestinodescargacheques ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Destinodescargacheques")
			this.oOperacionesEntidadDestinodescargacheques = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDestinodescargacheques
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDevolucion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDevolucion ) = 'O' or isnull( this.oOperacionesEntidadDevolucion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Devolucion")
			this.oOperacionesEntidadDevolucion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDevolucion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDireccionentregaencomprobante_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDireccionentregaencomprobante ) = 'O' or isnull( this.oOperacionesEntidadDireccionentregaencomprobante ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Direccionentregaencomprobante")
			this.oOperacionesEntidadDireccionentregaencomprobante = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDireccionentregaencomprobante
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDisenoimpresion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDisenoimpresion ) = 'O' or isnull( this.oOperacionesEntidadDisenoimpresion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Disenoimpresion")
			this.oOperacionesEntidadDisenoimpresion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDisenoimpresion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadDistribucioncentrodecosto_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadDistribucioncentrodecosto ) = 'O' or isnull( this.oOperacionesEntidadDistribucioncentrodecosto ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Distribucioncentrodecosto")
			this.oOperacionesEntidadDistribucioncentrodecosto = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadDistribucioncentrodecosto
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEcommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEcommerce ) = 'O' or isnull( this.oOperacionesEntidadEcommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ecommerce")
			this.oOperacionesEntidadEcommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEcommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEdicionimpuestoivacompras_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEdicionimpuestoivacompras ) = 'O' or isnull( this.oOperacionesEntidadEdicionimpuestoivacompras ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Edicionimpuestoivacompras")
			this.oOperacionesEntidadEdicionimpuestoivacompras = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEdicionimpuestoivacompras
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEjercicio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEjercicio ) = 'O' or isnull( this.oOperacionesEntidadEjercicio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ejercicio")
			this.oOperacionesEntidadEjercicio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEjercicio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEmail_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEmail ) = 'O' or isnull( this.oOperacionesEntidadEmail ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Email")
			this.oOperacionesEntidadEmail = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEmail
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEmailencomprobante_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEmailencomprobante ) = 'O' or isnull( this.oOperacionesEntidadEmailencomprobante ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Emailencomprobante")
			this.oOperacionesEntidadEmailencomprobante = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEmailencomprobante
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEntidadadicional1_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEntidadadicional1 ) = 'O' or isnull( this.oOperacionesEntidadEntidadadicional1 ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Entidadadicional1")
			this.oOperacionesEntidadEntidadadicional1 = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEntidadadicional1
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEntidadadicional2_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEntidadadicional2 ) = 'O' or isnull( this.oOperacionesEntidadEntidadadicional2 ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Entidadadicional2")
			this.oOperacionesEntidadEntidadadicional2 = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEntidadadicional2
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEntidadadicional3_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEntidadadicional3 ) = 'O' or isnull( this.oOperacionesEntidadEntidadadicional3 ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Entidadadicional3")
			this.oOperacionesEntidadEntidadadicional3 = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEntidadadicional3
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEntidadfinanciera_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEntidadfinanciera ) = 'O' or isnull( this.oOperacionesEntidadEntidadfinanciera ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Entidadfinanciera")
			this.oOperacionesEntidadEntidadfinanciera = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEntidadfinanciera
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEntregademercaderias_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEntregademercaderias ) = 'O' or isnull( this.oOperacionesEntidadEntregademercaderias ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Entregademercaderias")
			this.oOperacionesEntidadEntregademercaderias = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEntregademercaderias
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEnviodecuentacorrientepormail_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEnviodecuentacorrientepormail ) = 'O' or isnull( this.oOperacionesEntidadEnviodecuentacorrientepormail ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Enviodecuentacorrientepormail")
			this.oOperacionesEntidadEnviodecuentacorrientepormail = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEnviodecuentacorrientepormail
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEquivalencia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEquivalencia ) = 'O' or isnull( this.oOperacionesEntidadEquivalencia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Equivalencia")
			this.oOperacionesEntidadEquivalencia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEquivalencia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadErrorsap_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadErrorsap ) = 'O' or isnull( this.oOperacionesEntidadErrorsap ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Errorsap")
			this.oOperacionesEntidadErrorsap = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadErrorsap
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEstadosdeinteraccion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEstadosdeinteraccion ) = 'O' or isnull( this.oOperacionesEntidadEstadosdeinteraccion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Estadosdeinteraccion")
			this.oOperacionesEntidadEstadosdeinteraccion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEstadosdeinteraccion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEstiloimpresion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEstiloimpresion ) = 'O' or isnull( this.oOperacionesEntidadEstiloimpresion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Estiloimpresion")
			this.oOperacionesEntidadEstiloimpresion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEstiloimpresion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadEtiquetasecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadEtiquetasecommerce ) = 'O' or isnull( this.oOperacionesEntidadEtiquetasecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Etiquetasecommerce")
			this.oOperacionesEntidadEtiquetasecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadEtiquetasecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFactura_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFactura ) = 'O' or isnull( this.oOperacionesEntidadFactura ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Factura")
			this.oOperacionesEntidadFactura = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFactura
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFacturaagrupada_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFacturaagrupada ) = 'O' or isnull( this.oOperacionesEntidadFacturaagrupada ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Facturaagrupada")
			this.oOperacionesEntidadFacturaagrupada = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFacturaagrupada
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFacturadecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFacturadecompra ) = 'O' or isnull( this.oOperacionesEntidadFacturadecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Facturadecompra")
			this.oOperacionesEntidadFacturadecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFacturadecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFacturadeexportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFacturadeexportacion ) = 'O' or isnull( this.oOperacionesEntidadFacturadeexportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Facturadeexportacion")
			this.oOperacionesEntidadFacturadeexportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFacturadeexportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFacturaelectronica_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFacturaelectronica ) = 'O' or isnull( this.oOperacionesEntidadFacturaelectronica ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Facturaelectronica")
			this.oOperacionesEntidadFacturaelectronica = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFacturaelectronica
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFacturaelectronicadecredito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFacturaelectronicadecredito ) = 'O' or isnull( this.oOperacionesEntidadFacturaelectronicadecredito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Facturaelectronicadecredito")
			this.oOperacionesEntidadFacturaelectronicadecredito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFacturaelectronicadecredito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFacturaelectronicaexportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFacturaelectronicaexportacion ) = 'O' or isnull( this.oOperacionesEntidadFacturaelectronicaexportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Facturaelectronicaexportacion")
			this.oOperacionesEntidadFacturaelectronicaexportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFacturaelectronicaexportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFamilia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFamilia ) = 'O' or isnull( this.oOperacionesEntidadFamilia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Familia")
			this.oOperacionesEntidadFamilia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFamilia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFechacancelacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFechacancelacion ) = 'O' or isnull( this.oOperacionesEntidadFechacancelacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Fechacancelacion")
			this.oOperacionesEntidadFechacancelacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFechacancelacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFeriado_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFeriado ) = 'O' or isnull( this.oOperacionesEntidadFeriado ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Feriado")
			this.oOperacionesEntidadFeriado = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFeriado
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadFormula_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadFormula ) = 'O' or isnull( this.oOperacionesEntidadFormula ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Formula")
			this.oOperacionesEntidadFormula = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadFormula
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadGestionchcustodia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadGestionchcustodia ) = 'O' or isnull( this.oOperacionesEntidadGestionchcustodia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Gestionchcustodia")
			this.oOperacionesEntidadGestionchcustodia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadGestionchcustodia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadGestionvendedor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadGestionvendedor ) = 'O' or isnull( this.oOperacionesEntidadGestionvendedor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Gestionvendedor")
			this.oOperacionesEntidadGestionvendedor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadGestionvendedor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadGrupo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadGrupo ) = 'O' or isnull( this.oOperacionesEntidadGrupo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Grupo")
			this.oOperacionesEntidadGrupo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadGrupo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadGrupovalor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadGrupovalor ) = 'O' or isnull( this.oOperacionesEntidadGrupovalor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Grupovalor")
			this.oOperacionesEntidadGrupovalor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadGrupovalor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadGtin_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadGtin ) = 'O' or isnull( this.oOperacionesEntidadGtin ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Gtin")
			this.oOperacionesEntidadGtin = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadGtin
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadHerramientaagrupadoradepacks_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadHerramientaagrupadoradepacks ) = 'O' or isnull( this.oOperacionesEntidadHerramientaagrupadoradepacks ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Herramientaagrupadoradepacks")
			this.oOperacionesEntidadHerramientaagrupadoradepacks = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadHerramientaagrupadoradepacks
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirart_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirart ) = 'O' or isnull( this.oOperacionesEntidadImpdirart ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirart")
			this.oOperacionesEntidadImpdirart = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirart
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdircaj_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdircaj ) = 'O' or isnull( this.oOperacionesEntidadImpdircaj ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdircaj")
			this.oOperacionesEntidadImpdircaj = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdircaj
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdircca_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdircca ) = 'O' or isnull( this.oOperacionesEntidadImpdircca ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdircca")
			this.oOperacionesEntidadImpdircca = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdircca
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirccc_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirccc ) = 'O' or isnull( this.oOperacionesEntidadImpdirccc ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirccc")
			this.oOperacionesEntidadImpdirccc = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirccc
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdircli_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdircli ) = 'O' or isnull( this.oOperacionesEntidadImpdircli ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdircli")
			this.oOperacionesEntidadImpdircli = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdircli
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdircon_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdircon ) = 'O' or isnull( this.oOperacionesEntidadImpdircon ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdircon")
			this.oOperacionesEntidadImpdircon = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdircon
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdircue_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdircue ) = 'O' or isnull( this.oOperacionesEntidadImpdircue ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdircue")
			this.oOperacionesEntidadImpdircue = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdircue
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirdes_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirdes ) = 'O' or isnull( this.oOperacionesEntidadImpdirdes ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirdes")
			this.oOperacionesEntidadImpdirdes = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirdes
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirimp_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirimp ) = 'O' or isnull( this.oOperacionesEntidadImpdirimp ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirimp")
			this.oOperacionesEntidadImpdirimp = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirimp
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirliq_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirliq ) = 'O' or isnull( this.oOperacionesEntidadImpdirliq ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirliq")
			this.oOperacionesEntidadImpdirliq = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirliq
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirmot_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirmot ) = 'O' or isnull( this.oOperacionesEntidadImpdirmot ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirmot")
			this.oOperacionesEntidadImpdirmot = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirmot
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirope_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirope ) = 'O' or isnull( this.oOperacionesEntidadImpdirope ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirope")
			this.oOperacionesEntidadImpdirope = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirope
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirpro_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirpro ) = 'O' or isnull( this.oOperacionesEntidadImpdirpro ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirpro")
			this.oOperacionesEntidadImpdirpro = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirpro
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpdirval_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpdirval ) = 'O' or isnull( this.oOperacionesEntidadImpdirval ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impdirval")
			this.oOperacionesEntidadImpdirval = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpdirval
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpresiondeetiqueta_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpresiondeetiqueta ) = 'O' or isnull( this.oOperacionesEntidadImpresiondeetiqueta ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impresiondeetiqueta")
			this.oOperacionesEntidadImpresiondeetiqueta = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpresiondeetiqueta
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImprimircomprobanteporlote_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImprimircomprobanteporlote ) = 'O' or isnull( this.oOperacionesEntidadImprimircomprobanteporlote ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Imprimircomprobanteporlote")
			this.oOperacionesEntidadImprimircomprobanteporlote = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImprimircomprobanteporlote
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpuesto_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpuesto ) = 'O' or isnull( this.oOperacionesEntidadImpuesto ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impuesto")
			this.oOperacionesEntidadImpuesto = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpuesto
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadImpvercc_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadImpvercc ) = 'O' or isnull( this.oOperacionesEntidadImpvercc ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Impvercc")
			this.oOperacionesEntidadImpvercc = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadImpvercc
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadInconsistenciasap_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadInconsistenciasap ) = 'O' or isnull( this.oOperacionesEntidadInconsistenciasap ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Inconsistenciasap")
			this.oOperacionesEntidadInconsistenciasap = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadInconsistenciasap
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadIncoterms_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadIncoterms ) = 'O' or isnull( this.oOperacionesEntidadIncoterms ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Incoterms")
			this.oOperacionesEntidadIncoterms = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadIncoterms
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadIndicesinflacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadIndicesinflacion ) = 'O' or isnull( this.oOperacionesEntidadIndicesinflacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Indicesinflacion")
			this.oOperacionesEntidadIndicesinflacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadIndicesinflacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadInteracciondeorden_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadInteracciondeorden ) = 'O' or isnull( this.oOperacionesEntidadInteracciondeorden ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Interacciondeorden")
			this.oOperacionesEntidadInteracciondeorden = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadInteracciondeorden
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadJurisdiccion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadJurisdiccion ) = 'O' or isnull( this.oOperacionesEntidadJurisdiccion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Jurisdiccion")
			this.oOperacionesEntidadJurisdiccion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadJurisdiccion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadLimiteconsumo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadLimiteconsumo ) = 'O' or isnull( this.oOperacionesEntidadLimiteconsumo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Limiteconsumo")
			this.oOperacionesEntidadLimiteconsumo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadLimiteconsumo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadLinea_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadLinea ) = 'O' or isnull( this.oOperacionesEntidadLinea ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Linea")
			this.oOperacionesEntidadLinea = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadLinea
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadLinkqrenetiqueta_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadLinkqrenetiqueta ) = 'O' or isnull( this.oOperacionesEntidadLinkqrenetiqueta ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Linkqrenetiqueta")
			this.oOperacionesEntidadLinkqrenetiqueta = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadLinkqrenetiqueta
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadLiquidaciondiaria_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadLiquidaciondiaria ) = 'O' or isnull( this.oOperacionesEntidadLiquidaciondiaria ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Liquidaciondiaria")
			this.oOperacionesEntidadLiquidaciondiaria = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadLiquidaciondiaria
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadLiquidacionmensual_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadLiquidacionmensual ) = 'O' or isnull( this.oOperacionesEntidadLiquidacionmensual ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Liquidacionmensual")
			this.oOperacionesEntidadLiquidacionmensual = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadLiquidacionmensual
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadListadeprecios_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadListadeprecios ) = 'O' or isnull( this.oOperacionesEntidadListadeprecios ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Listadeprecios")
			this.oOperacionesEntidadListadeprecios = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadListadeprecios
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadListadeprecioscalculada_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadListadeprecioscalculada ) = 'O' or isnull( this.oOperacionesEntidadListadeprecioscalculada ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Listadeprecioscalculada")
			this.oOperacionesEntidadListadeprecioscalculada = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadListadeprecioscalculada
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMailporlote_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMailporlote ) = 'O' or isnull( this.oOperacionesEntidadMailporlote ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Mailporlote")
			this.oOperacionesEntidadMailporlote = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMailporlote
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMarca_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMarca ) = 'O' or isnull( this.oOperacionesEntidadMarca ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Marca")
			this.oOperacionesEntidadMarca = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMarca
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMaterial_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMaterial ) = 'O' or isnull( this.oOperacionesEntidadMaterial ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Material")
			this.oOperacionesEntidadMaterial = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMaterial
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMercaderiaentransito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMercaderiaentransito ) = 'O' or isnull( this.oOperacionesEntidadMercaderiaentransito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Mercaderiaentransito")
			this.oOperacionesEntidadMercaderiaentransito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMercaderiaentransito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMinimoreposicion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMinimoreposicion ) = 'O' or isnull( this.oOperacionesEntidadMinimoreposicion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Minimoreposicion")
			this.oOperacionesEntidadMinimoreposicion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMinimoreposicion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadModificacionprecios_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadModificacionprecios ) = 'O' or isnull( this.oOperacionesEntidadModificacionprecios ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Modificacionprecios")
			this.oOperacionesEntidadModificacionprecios = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadModificacionprecios
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMoneda_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMoneda ) = 'O' or isnull( this.oOperacionesEntidadMoneda ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Moneda")
			this.oOperacionesEntidadMoneda = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMoneda
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMonedaafip_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMonedaafip ) = 'O' or isnull( this.oOperacionesEntidadMonedaafip ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Monedaafip")
			this.oOperacionesEntidadMonedaafip = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMonedaafip
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMotivo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMotivo ) = 'O' or isnull( this.oOperacionesEntidadMotivo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Motivo")
			this.oOperacionesEntidadMotivo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMotivo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMotivodescuentoydevolucion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMotivodescuentoydevolucion ) = 'O' or isnull( this.oOperacionesEntidadMotivodescuentoydevolucion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Motivodescuentoydevolucion")
			this.oOperacionesEntidadMotivodescuentoydevolucion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMotivodescuentoydevolucion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMovimientobancario_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMovimientobancario ) = 'O' or isnull( this.oOperacionesEntidadMovimientobancario ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Movimientobancario")
			this.oOperacionesEntidadMovimientobancario = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMovimientobancario
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadMovimientodestock_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadMovimientodestock ) = 'O' or isnull( this.oOperacionesEntidadMovimientodestock ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Movimientodestock")
			this.oOperacionesEntidadMovimientodestock = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadMovimientodestock
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNombredefantasia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNombredefantasia ) = 'O' or isnull( this.oOperacionesEntidadNombredefantasia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Nombredefantasia")
			this.oOperacionesEntidadNombredefantasia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNombredefantasia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNomencladorarba_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNomencladorarba ) = 'O' or isnull( this.oOperacionesEntidadNomencladorarba ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Nomencladorarba")
			this.oOperacionesEntidadNomencladorarba = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNomencladorarba
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecredito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecredito ) = 'O' or isnull( this.oOperacionesEntidadNotadecredito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecredito")
			this.oOperacionesEntidadNotadecredito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecredito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecreditoagrupada_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecreditoagrupada ) = 'O' or isnull( this.oOperacionesEntidadNotadecreditoagrupada ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecreditoagrupada")
			this.oOperacionesEntidadNotadecreditoagrupada = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecreditoagrupada
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecreditocompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecreditocompra ) = 'O' or isnull( this.oOperacionesEntidadNotadecreditocompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecreditocompra")
			this.oOperacionesEntidadNotadecreditocompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecreditocompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecreditodeexportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecreditodeexportacion ) = 'O' or isnull( this.oOperacionesEntidadNotadecreditodeexportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecreditodeexportacion")
			this.oOperacionesEntidadNotadecreditodeexportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecreditodeexportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecreditoelectronica_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecreditoelectronica ) = 'O' or isnull( this.oOperacionesEntidadNotadecreditoelectronica ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecreditoelectronica")
			this.oOperacionesEntidadNotadecreditoelectronica = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecreditoelectronica
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecreditoelectronicadecredito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecreditoelectronicadecredito ) = 'O' or isnull( this.oOperacionesEntidadNotadecreditoelectronicadecredito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecreditoelectronicadecredito")
			this.oOperacionesEntidadNotadecreditoelectronicadecredito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecreditoelectronicadecredito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadecreditoelectronicaexportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadecreditoelectronicaexportacion ) = 'O' or isnull( this.oOperacionesEntidadNotadecreditoelectronicaexportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadecreditoelectronicaexportacion")
			this.oOperacionesEntidadNotadecreditoelectronicaexportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadecreditoelectronicaexportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebito ) = 'O' or isnull( this.oOperacionesEntidadNotadedebito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebito")
			this.oOperacionesEntidadNotadedebito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebitoagrupada_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebitoagrupada ) = 'O' or isnull( this.oOperacionesEntidadNotadedebitoagrupada ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebitoagrupada")
			this.oOperacionesEntidadNotadedebitoagrupada = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebitoagrupada
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebitocompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebitocompra ) = 'O' or isnull( this.oOperacionesEntidadNotadedebitocompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebitocompra")
			this.oOperacionesEntidadNotadedebitocompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebitocompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebitodeexportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebitodeexportacion ) = 'O' or isnull( this.oOperacionesEntidadNotadedebitodeexportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebitodeexportacion")
			this.oOperacionesEntidadNotadedebitodeexportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebitodeexportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebitoelectronica_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebitoelectronica ) = 'O' or isnull( this.oOperacionesEntidadNotadedebitoelectronica ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebitoelectronica")
			this.oOperacionesEntidadNotadedebitoelectronica = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebitoelectronica
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebitoelectronicadecredito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebitoelectronicadecredito ) = 'O' or isnull( this.oOperacionesEntidadNotadedebitoelectronicadecredito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebitoelectronicadecredito")
			this.oOperacionesEntidadNotadedebitoelectronicadecredito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebitoelectronicadecredito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNotadedebitoelectronicaexportacion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNotadedebitoelectronicaexportacion ) = 'O' or isnull( this.oOperacionesEntidadNotadedebitoelectronicaexportacion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Notadedebitoelectronicaexportacion")
			this.oOperacionesEntidadNotadedebitoelectronicaexportacion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNotadedebitoelectronicaexportacion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNuevoenbasea_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNuevoenbasea ) = 'O' or isnull( this.oOperacionesEntidadNuevoenbasea ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Nuevoenbasea")
			this.oOperacionesEntidadNuevoenbasea = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNuevoenbasea
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNuevoentregaonline_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNuevoentregaonline ) = 'O' or isnull( this.oOperacionesEntidadNuevoentregaonline ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Nuevoentregaonline")
			this.oOperacionesEntidadNuevoentregaonline = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNuevoentregaonline
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadNumeraciones_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadNumeraciones ) = 'O' or isnull( this.oOperacionesEntidadNumeraciones ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Numeraciones")
			this.oOperacionesEntidadNumeraciones = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadNumeraciones
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadOperacionecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadOperacionecommerce ) = 'O' or isnull( this.oOperacionesEntidadOperacionecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Operacionecommerce")
			this.oOperacionesEntidadOperacionecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadOperacionecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadOperadoradetarjeta_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadOperadoradetarjeta ) = 'O' or isnull( this.oOperacionesEntidadOperadoradetarjeta ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Operadoradetarjeta")
			this.oOperacionesEntidadOperadoradetarjeta = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadOperadoradetarjeta
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadOrdendepago_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadOrdendepago ) = 'O' or isnull( this.oOperacionesEntidadOrdendepago ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ordendepago")
			this.oOperacionesEntidadOrdendepago = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadOrdendepago
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadOrdendeservicio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadOrdendeservicio ) = 'O' or isnull( this.oOperacionesEntidadOrdendeservicio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ordendeservicio")
			this.oOperacionesEntidadOrdendeservicio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadOrdendeservicio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadOrigendedatos_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadOrigendedatos ) = 'O' or isnull( this.oOperacionesEntidadOrigendedatos ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Origendedatos")
			this.oOperacionesEntidadOrigendedatos = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadOrigendedatos
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPago_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPago ) = 'O' or isnull( this.oOperacionesEntidadPago ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Pago")
			this.oOperacionesEntidadPago = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPago
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPaisafip_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPaisafip ) = 'O' or isnull( this.oOperacionesEntidadPaisafip ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Paisafip")
			this.oOperacionesEntidadPaisafip = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPaisafip
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPaises_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPaises ) = 'O' or isnull( this.oOperacionesEntidadPaises ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Paises")
			this.oOperacionesEntidadPaises = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPaises
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPaletadecolores_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPaletadecolores ) = 'O' or isnull( this.oOperacionesEntidadPaletadecolores ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Paletadecolores")
			this.oOperacionesEntidadPaletadecolores = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPaletadecolores
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPasajedestock_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPasajedestock ) = 'O' or isnull( this.oOperacionesEntidadPasajedestock ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Pasajedestock")
			this.oOperacionesEntidadPasajedestock = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPasajedestock
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPedido_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPedido ) = 'O' or isnull( this.oOperacionesEntidadPedido ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Pedido")
			this.oOperacionesEntidadPedido = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPedido
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPedidodecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPedidodecompra ) = 'O' or isnull( this.oOperacionesEntidadPedidodecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Pedidodecompra")
			this.oOperacionesEntidadPedidodecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPedidodecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPicking_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPicking ) = 'O' or isnull( this.oOperacionesEntidadPicking ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Picking")
			this.oOperacionesEntidadPicking = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPicking
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPlandecuentas_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPlandecuentas ) = 'O' or isnull( this.oOperacionesEntidadPlandecuentas ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Plandecuentas")
			this.oOperacionesEntidadPlandecuentas = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPlandecuentas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPos_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPos ) = 'O' or isnull( this.oOperacionesEntidadPos ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Pos")
			this.oOperacionesEntidadPos = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPos
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPreciodearticulo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPreciodearticulo ) = 'O' or isnull( this.oOperacionesEntidadPreciodearticulo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Preciodearticulo")
			this.oOperacionesEntidadPreciodearticulo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPreciodearticulo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPreparaciondemercaderia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPreparaciondemercaderia ) = 'O' or isnull( this.oOperacionesEntidadPreparaciondemercaderia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Preparaciondemercaderia")
			this.oOperacionesEntidadPreparaciondemercaderia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPreparaciondemercaderia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPresupuesto_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPresupuesto ) = 'O' or isnull( this.oOperacionesEntidadPresupuesto ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Presupuesto")
			this.oOperacionesEntidadPresupuesto = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPresupuesto
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPresupuestodecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPresupuestodecompra ) = 'O' or isnull( this.oOperacionesEntidadPresupuestodecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Presupuestodecompra")
			this.oOperacionesEntidadPresupuestodecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPresupuestodecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPromocion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPromocion ) = 'O' or isnull( this.oOperacionesEntidadPromocion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Promocion")
			this.oOperacionesEntidadPromocion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPromocion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPropiedadeslistados_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPropiedadeslistados ) = 'O' or isnull( this.oOperacionesEntidadPropiedadeslistados ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Propiedadeslistados")
			this.oOperacionesEntidadPropiedadeslistados = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPropiedadeslistados
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadProveedor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadProveedor ) = 'O' or isnull( this.oOperacionesEntidadProveedor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Proveedor")
			this.oOperacionesEntidadProveedor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadProveedor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadProvincia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadProvincia ) = 'O' or isnull( this.oOperacionesEntidadProvincia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Provincia")
			this.oOperacionesEntidadProvincia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadProvincia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadPuntosdeventa_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadPuntosdeventa ) = 'O' or isnull( this.oOperacionesEntidadPuntosdeventa ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Puntosdeventa")
			this.oOperacionesEntidadPuntosdeventa = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadPuntosdeventa
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRazonsocial_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRazonsocial ) = 'O' or isnull( this.oOperacionesEntidadRazonsocial ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Razonsocial")
			this.oOperacionesEntidadRazonsocial = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRazonsocial
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRecibo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRecibo ) = 'O' or isnull( this.oOperacionesEntidadRecibo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Recibo")
			this.oOperacionesEntidadRecibo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRecibo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRedondeodeprecios_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRedondeodeprecios ) = 'O' or isnull( this.oOperacionesEntidadRedondeodeprecios ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Redondeodeprecios")
			this.oOperacionesEntidadRedondeodeprecios = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRedondeodeprecios
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRegimenimpositivo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRegimenimpositivo ) = 'O' or isnull( this.oOperacionesEntidadRegimenimpositivo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Regimenimpositivo")
			this.oOperacionesEntidadRegimenimpositivo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRegimenimpositivo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRegistrodecostos_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRegistrodecostos ) = 'O' or isnull( this.oOperacionesEntidadRegistrodecostos ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Registrodecostos")
			this.oOperacionesEntidadRegistrodecostos = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRegistrodecostos
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRegistrodecuenta_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRegistrodecuenta ) = 'O' or isnull( this.oOperacionesEntidadRegistrodecuenta ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Registrodecuenta")
			this.oOperacionesEntidadRegistrodecuenta = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRegistrodecuenta
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRemito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRemito ) = 'O' or isnull( this.oOperacionesEntidadRemito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Remito")
			this.oOperacionesEntidadRemito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRemito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRemitodecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRemitodecompra ) = 'O' or isnull( this.oOperacionesEntidadRemitodecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Remitodecompra")
			this.oOperacionesEntidadRemitodecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRemitodecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRemitoelectronico_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRemitoelectronico ) = 'O' or isnull( this.oOperacionesEntidadRemitoelectronico ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Remitoelectronico")
			this.oOperacionesEntidadRemitoelectronico = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRemitoelectronico
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRenumeraasientos_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRenumeraasientos ) = 'O' or isnull( this.oOperacionesEntidadRenumeraasientos ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Renumeraasientos")
			this.oOperacionesEntidadRenumeraasientos = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRenumeraasientos
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadReporteauditoriacierrez_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadReporteauditoriacierrez ) = 'O' or isnull( this.oOperacionesEntidadReporteauditoriacierrez ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Reporteauditoriacierrez")
			this.oOperacionesEntidadReporteauditoriacierrez = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadReporteauditoriacierrez
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadReporteelectronico_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadReporteelectronico ) = 'O' or isnull( this.oOperacionesEntidadReporteelectronico ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Reporteelectronico")
			this.oOperacionesEntidadReporteelectronico = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadReporteelectronico
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadRequerimientodecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadRequerimientodecompra ) = 'O' or isnull( this.oOperacionesEntidadRequerimientodecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Requerimientodecompra")
			this.oOperacionesEntidadRequerimientodecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadRequerimientodecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSaltodecampo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSaltodecampo ) = 'O' or isnull( this.oOperacionesEntidadSaltodecampo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Saltodecampo")
			this.oOperacionesEntidadSaltodecampo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSaltodecampo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSeleccionbasesarchivadas_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSeleccionbasesarchivadas ) = 'O' or isnull( this.oOperacionesEntidadSeleccionbasesarchivadas ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Seleccionbasesarchivadas")
			this.oOperacionesEntidadSeleccionbasesarchivadas = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSeleccionbasesarchivadas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSeleccioncomprobanteasociado_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSeleccioncomprobanteasociado ) = 'O' or isnull( this.oOperacionesEntidadSeleccioncomprobanteasociado ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Seleccioncomprobanteasociado")
			this.oOperacionesEntidadSeleccioncomprobanteasociado = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSeleccioncomprobanteasociado
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSelecciondespacho_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSelecciondespacho ) = 'O' or isnull( this.oOperacionesEntidadSelecciondespacho ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Selecciondespacho")
			this.oOperacionesEntidadSelecciondespacho = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSelecciondespacho
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSeleccionoperacionecommerce_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSeleccionoperacionecommerce ) = 'O' or isnull( this.oOperacionesEntidadSeleccionoperacionecommerce ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Seleccionoperacionecommerce")
			this.oOperacionesEntidadSeleccionoperacionecommerce = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSeleccionoperacionecommerce
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSeleccionordendeservicio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSeleccionordendeservicio ) = 'O' or isnull( this.oOperacionesEntidadSeleccionordendeservicio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Seleccionordendeservicio")
			this.oOperacionesEntidadSeleccionordendeservicio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSeleccionordendeservicio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSelecompainsertar_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSelecompainsertar ) = 'O' or isnull( this.oOperacionesEntidadSelecompainsertar ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Selecompainsertar")
			this.oOperacionesEntidadSelecompainsertar = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSelecompainsertar
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSenia_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSenia ) = 'O' or isnull( this.oOperacionesEntidadSenia ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Senia")
			this.oOperacionesEntidadSenia = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSenia
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSeniapendiente_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSeniapendiente ) = 'O' or isnull( this.oOperacionesEntidadSeniapendiente ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Seniapendiente")
			this.oOperacionesEntidadSeniapendiente = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSeniapendiente
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSolicituddecompra_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSolicituddecompra ) = 'O' or isnull( this.oOperacionesEntidadSolicituddecompra ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Solicituddecompra")
			this.oOperacionesEntidadSolicituddecompra = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSolicituddecompra
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadSucursalbancaria_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadSucursalbancaria ) = 'O' or isnull( this.oOperacionesEntidadSucursalbancaria ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Sucursalbancaria")
			this.oOperacionesEntidadSucursalbancaria = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadSucursalbancaria
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTalle_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTalle ) = 'O' or isnull( this.oOperacionesEntidadTalle ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Talle")
			this.oOperacionesEntidadTalle = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTalle
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTalonario_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTalonario ) = 'O' or isnull( this.oOperacionesEntidadTalonario ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Talonario")
			this.oOperacionesEntidadTalonario = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTalonario
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTemporada_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTemporada ) = 'O' or isnull( this.oOperacionesEntidadTemporada ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Temporada")
			this.oOperacionesEntidadTemporada = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTemporada
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTicketfactura_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTicketfactura ) = 'O' or isnull( this.oOperacionesEntidadTicketfactura ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ticketfactura")
			this.oOperacionesEntidadTicketfactura = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTicketfactura
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTicketnotadecredito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTicketnotadecredito ) = 'O' or isnull( this.oOperacionesEntidadTicketnotadecredito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ticketnotadecredito")
			this.oOperacionesEntidadTicketnotadecredito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTicketnotadecredito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTicketnotadedebito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTicketnotadedebito ) = 'O' or isnull( this.oOperacionesEntidadTicketnotadedebito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Ticketnotadedebito")
			this.oOperacionesEntidadTicketnotadedebito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTicketnotadedebito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTidiferenciasdeinventario_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTidiferenciasdeinventario ) = 'O' or isnull( this.oOperacionesEntidadTidiferenciasdeinventario ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tidiferenciasdeinventario")
			this.oOperacionesEntidadTidiferenciasdeinventario = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTidiferenciasdeinventario
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTidiferenciasdeinventariodetalle_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTidiferenciasdeinventariodetalle ) = 'O' or isnull( this.oOperacionesEntidadTidiferenciasdeinventariodetalle ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tidiferenciasdeinventariodetalle")
			this.oOperacionesEntidadTidiferenciasdeinventariodetalle = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTidiferenciasdeinventariodetalle
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTiinventarioacont_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTiinventarioacont ) = 'O' or isnull( this.oOperacionesEntidadTiinventarioacont ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tiinventarioacont")
			this.oOperacionesEntidadTiinventarioacont = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTiinventarioacont
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTiinventariofisico_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTiinventariofisico ) = 'O' or isnull( this.oOperacionesEntidadTiinventariofisico ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tiinventariofisico")
			this.oOperacionesEntidadTiinventariofisico = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTiinventariofisico
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTiinventariofisicodetalle_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTiinventariofisicodetalle ) = 'O' or isnull( this.oOperacionesEntidadTiinventariofisicodetalle ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tiinventariofisicodetalle")
			this.oOperacionesEntidadTiinventariofisicodetalle = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTiinventariofisicodetalle
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTipocliente_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTipocliente ) = 'O' or isnull( this.oOperacionesEntidadTipocliente ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tipocliente")
			this.oOperacionesEntidadTipocliente = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTipocliente
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTipodearticulo_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTipodearticulo ) = 'O' or isnull( this.oOperacionesEntidadTipodearticulo ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tipodearticulo")
			this.oOperacionesEntidadTipodearticulo = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTipodearticulo
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTipodedireccion_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTipodedireccion ) = 'O' or isnull( this.oOperacionesEntidadTipodedireccion ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tipodedireccion")
			this.oOperacionesEntidadTipodedireccion = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTipodedireccion
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTipodeorden_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTipodeorden ) = 'O' or isnull( this.oOperacionesEntidadTipodeorden ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tipodeorden")
			this.oOperacionesEntidadTipodeorden = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTipodeorden
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTipoimpuesto_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTipoimpuesto ) = 'O' or isnull( this.oOperacionesEntidadTipoimpuesto ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tipoimpuesto")
			this.oOperacionesEntidadTipoimpuesto = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTipoimpuesto
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTransferenciaentrecuentas_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTransferenciaentrecuentas ) = 'O' or isnull( this.oOperacionesEntidadTransferenciaentrecuentas ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Transferenciaentrecuentas")
			this.oOperacionesEntidadTransferenciaentrecuentas = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTransferenciaentrecuentas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTransportista_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTransportista ) = 'O' or isnull( this.oOperacionesEntidadTransportista ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Transportista")
			this.oOperacionesEntidadTransportista = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTransportista
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadTratamientocomprobantes_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadTratamientocomprobantes ) = 'O' or isnull( this.oOperacionesEntidadTratamientocomprobantes ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Tratamientocomprobantes")
			this.oOperacionesEntidadTratamientocomprobantes = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadTratamientocomprobantes
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadUnidaddemedida_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadUnidaddemedida ) = 'O' or isnull( this.oOperacionesEntidadUnidaddemedida ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Unidaddemedida")
			this.oOperacionesEntidadUnidaddemedida = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadUnidaddemedida
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadUnidaddemedidaafip_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadUnidaddemedidaafip ) = 'O' or isnull( this.oOperacionesEntidadUnidaddemedidaafip ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Unidaddemedidaafip")
			this.oOperacionesEntidadUnidaddemedidaafip = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadUnidaddemedidaafip
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadUnidaddemedidaarba_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadUnidaddemedidaarba ) = 'O' or isnull( this.oOperacionesEntidadUnidaddemedidaarba ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Unidaddemedidaarba")
			this.oOperacionesEntidadUnidaddemedidaarba = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadUnidaddemedidaarba
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadValedecambio_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadValedecambio ) = 'O' or isnull( this.oOperacionesEntidadValedecambio ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Valedecambio")
			this.oOperacionesEntidadValedecambio = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadValedecambio
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadValor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadValor ) = 'O' or isnull( this.oOperacionesEntidadValor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Valor")
			this.oOperacionesEntidadValor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadValor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadValoresentransito_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadValoresentransito ) = 'O' or isnull( this.oOperacionesEntidadValoresentransito ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Valoresentransito")
			this.oOperacionesEntidadValoresentransito = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadValoresentransito
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadVendedor_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadVendedor ) = 'O' or isnull( this.oOperacionesEntidadVendedor ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Vendedor")
			this.oOperacionesEntidadVendedor = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadVendedor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function oOperacionesEntidadVendedorencomprobante_Access() as Void
		if !this.ldestroy and ( !vartype( this.oOperacionesEntidadVendedorencomprobante ) = 'O' or isnull( this.oOperacionesEntidadVendedorencomprobante ) )
			lcClase = this.ObtenerNombreClaseServicioEntidad("Vendedorencomprobante")
			this.oOperacionesEntidadVendedorencomprobante = _screen.zoo.crearObjeto( lcClase )
		endif
		return this.oOperacionesEntidadVendedorencomprobante
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AccionesautomaticasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAccionesautomaticas, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AccionesautomaticasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAccionesautomaticas, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AccionesautomaticasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAccionesautomaticas, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AccionesautomaticasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAccionesautomaticas, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AccionesautomaticasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAccionesautomaticas, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AgrupamientopublicacionesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAgrupamientopublicaciones, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AgrupamientopublicacionesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAgrupamientopublicaciones, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AgrupamientopublicacionesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAgrupamientopublicaciones, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AgrupamientopublicacionesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAgrupamientopublicaciones, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AgrupamientopublicacionesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAgrupamientopublicaciones, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccclienteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustecccliente, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AjusteccclienteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustecccliente, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccclienteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustecccliente, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccclienteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustecccliente, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccclienteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustecccliente, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccclienteAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustecccliente, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccproveedorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAjusteccproveedor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AjusteccproveedorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjusteccproveedor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccproveedorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjusteccproveedor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccproveedorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjusteccproveedor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccproveedorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjusteccproveedor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjusteccproveedorAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjusteccproveedor, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustechequerechazadoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustechequerechazado, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AjustechequerechazadoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustechequerechazado, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustechequerechazadoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustechequerechazado, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustechequerechazadoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustechequerechazado, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustechequerechazadoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustechequerechazado, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedeestadosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedeestados, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AjustedeestadosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedeestados, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedeestadosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedeestados, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedeestadosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedeestados, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedeestadosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedeestados, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedestockNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedestock, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AjustedestockMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedestock, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedestockListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedestock, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedestockEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedestock, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AjustedestockModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAjustedestock, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AliviodecajaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAliviodecaja, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AliviodecajaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAliviodecaja, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AliviodecajaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAliviodecaja, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AliviodecajaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAliviodecaja, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AliviodecajaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAliviodecaja, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AperturaejercicioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAperturaejercicio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AperturaejercicioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAperturaejercicio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AperturaejercicioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAperturaejercicio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AperturaejercicioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAperturaejercicio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AperturaejercicioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAperturaejercicio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArqueodecajaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadArqueodecaja, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ArqueodecajaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArqueodecaja, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArqueodecajaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArqueodecaja, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArqueodecajaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArqueodecaja, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArqueodecajaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArqueodecaja, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArticuloNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadArticulo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ArticuloMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArticulo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArticuloListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArticulo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArticuloEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArticulo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ArticuloModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadArticulo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAsiento, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AsientoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsiento, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsiento, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsiento, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsiento, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientosperiodicosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientosperiodicos, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AsientosperiodicosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientosperiodicos, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientosperiodicosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientosperiodicos, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientosperiodicosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientosperiodicos, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientosperiodicosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientosperiodicos, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientotipoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientotipo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AsientotipoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientotipo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientotipoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientotipo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientotipoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientotipo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsientotipoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsientotipo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsignarzbdNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadAsignarzbd, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function AsignarzbdMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsignarzbd, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsignarzbdListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsignarzbd, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsignarzbdEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsignarzbd, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function AsignarzbdModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadAsignarzbd, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function BolsasycajasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadBolsasycajas, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function BolsasycajasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadBolsasycajas, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function BolsasycajasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadBolsasycajas, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function BolsasycajasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadBolsasycajas, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function BolsasycajasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadBolsasycajas, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function BolsasycajasAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadBolsasycajas, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCaea, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CaeaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaea, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaea, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaea, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaea, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeainformaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeainforma, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CaeainformaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeainforma, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeainformaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeainforma, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeainformaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeainforma, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeainformaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeainforma, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeporloteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeporlote, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CaeporloteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeporlote, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeporloteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeporlote, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeporloteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeporlote, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaeporloteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCaeporlote, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaiNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCai, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CaiMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCai, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaiListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCai, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaiEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCai, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CaiModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCai, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CajaestadoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCajaestado, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CajaestadoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCajaestado, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CajaestadoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCajaestado, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CajaestadoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCajaestado, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CajaestadoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCajaestado, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CalculodepreciosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCalculodeprecios, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CalculodepreciosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCalculodeprecios, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CalculodepreciosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCalculodeprecios, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CalculodepreciosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCalculodeprecios, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CalculodepreciosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCalculodeprecios, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CalculodepreciosAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCalculodeprecios, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondeseniasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondesenias, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondeseniasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondesenias, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondeseniasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondesenias, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondeseniasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondesenias, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondeseniasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondesenias, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CancelaciondeseniasAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCancelaciondesenias, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CanjedecuponesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCanjedecupones, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CanjedecuponesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCanjedecupones, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CanjedecuponesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCanjedecupones, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CanjedecuponesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCanjedecupones, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CanjedecuponesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCanjedecupones, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CanjedecuponesAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCanjedecupones, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriaclienteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriacliente, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CategoriaclienteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriacliente, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriaclienteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriacliente, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriaclienteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriacliente, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriaclienteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriacliente, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriadearticuloNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriadearticulo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CategoriadearticuloMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriadearticulo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriadearticuloListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriadearticulo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriadearticuloEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriadearticulo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriadearticuloModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriadearticulo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CategoriasecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasgoogleshoppingNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasgoogleshopping, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CategoriasgoogleshoppingMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasgoogleshopping, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasgoogleshoppingListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasgoogleshopping, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasgoogleshoppingEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasgoogleshopping, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CategoriasgoogleshoppingModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCategoriasgoogleshopping, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CentrodecostoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCentrodecosto, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CentrodecostoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCentrodecosto, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CentrodecostoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCentrodecosto, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CentrodecostoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCentrodecosto, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CentrodecostoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCentrodecosto, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCheque, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ChequeMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCheque, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCheque, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCheque, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCheque, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequepropioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadChequepropio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ChequepropioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequepropio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequepropioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequepropio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequepropioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequepropio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequepropioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequepropio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequepropioAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequepropio, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadChequera, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ChequeraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequera, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequera, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequera, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequeraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequera, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequesdisponiblesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadChequesdisponibles, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ChequesdisponiblesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequesdisponibles, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequesdisponiblesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequesdisponibles, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequesdisponiblesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequesdisponibles, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ChequesdisponiblesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadChequesdisponibles, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierredeloteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCierredelote, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CierredeloteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierredelote, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierredeloteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierredelote, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierredeloteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierredelote, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierredeloteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierredelote, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierreejercicioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCierreejercicio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CierreejercicioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierreejercicio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierreejercicioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierreejercicio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierreejercicioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierreejercicio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CierreejercicioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCierreejercicio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasedetarjetaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasedetarjeta, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasedetarjetaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasedetarjeta, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasedetarjetaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasedetarjeta, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasedetarjetaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasedetarjeta, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasedetarjetaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasedetarjeta, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionarticuloNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionarticulo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionarticuloMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionarticulo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionarticuloListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionarticulo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionarticuloEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionarticulo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionarticuloModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionarticulo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionclienteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacioncliente, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionclienteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacioncliente, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionclienteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacioncliente, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionclienteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacioncliente, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionclienteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacioncliente, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptocajaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptocaja, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptocajaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptocaja, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptocajaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptocaja, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptocajaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptocaja, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptocajaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptocaja, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptopagoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptopago, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptopagoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptopago, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptopagoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptopago, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptopagoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptopago, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionconceptopagoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionconceptopago, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionproveedorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionproveedor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionproveedorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionproveedor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionproveedorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionproveedor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionproveedorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionproveedor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionproveedorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionproveedor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionvendedorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionvendedor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionvendedorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionvendedor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionvendedorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionvendedor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionvendedorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionvendedor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClasificacionvendedorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClasificacionvendedor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCliente, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClienteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCliente, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCliente, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCliente, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCliente, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClienteecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClienteecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienteecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienteecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienteecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienteecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienteecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienterecomendanteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadClienterecomendante, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ClienterecomendanteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienterecomendante, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienterecomendanteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienterecomendante, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienterecomendanteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienterecomendante, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ClienterecomendanteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadClienterecomendante, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodbarraalterNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCodbarraalter, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CodbarraalterMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodbarraalter, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodbarraalterListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodbarraalter, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodbarraalterEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodbarraalter, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodbarraalterModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodbarraalter, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigoautorizaciondjcpNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigoautorizaciondjcp, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CodigoautorizaciondjcpMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigoautorizaciondjcp, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigoautorizaciondjcpListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigoautorizaciondjcp, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigoautorizaciondjcpEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigoautorizaciondjcp, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigoautorizaciondjcpModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigoautorizaciondjcp, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigodeservicioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigodeservicio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CodigodeservicioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigodeservicio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigodeservicioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigodeservicio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigodeservicioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigodeservicio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CodigodeservicioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCodigodeservicio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ColorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadColor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ColorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadColor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ColorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadColor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ColorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadColor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ColorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadColor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComisionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComision, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComisionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComision, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComisionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComision, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComisionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComision, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComisionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComision, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CompletardesdeventasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCompletardesdeventas, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CompletardesdeventasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCompletardesdeventas, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CompletardesdeventasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCompletardesdeventas, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CompletardesdeventasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCompletardesdeventas, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CompletardesdeventasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCompletardesdeventas, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantedecajaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantedecaja, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantedecajaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantedecaja, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantedecajaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantedecaja, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantedecajaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantedecaja, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantedecajaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantedecaja, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetenciones, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetenciones, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetenciones, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetenciones, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetenciones, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetenciones, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesgananciasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesganancias, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesgananciasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesganancias, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesgananciasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesganancias, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesgananciasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesganancias, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesgananciasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesganancias, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesgananciasAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesganancias, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesivaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesiva, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesivaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesiva, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesivaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesiva, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesivaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesiva, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesivaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesiva, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionesivaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionesiva, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionessussNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionessuss, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionessussMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionessuss, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionessussListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionessuss, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionessussEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionessuss, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionessussModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionessuss, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionessussAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionessuss, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionrecibidoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionrecibido, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionrecibidoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionrecibido, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionrecibidoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionrecibido, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionrecibidoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionrecibido, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantederetencionrecibidoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantederetencionrecibido, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantepagoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantepago, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantepagoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantepago, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantepagoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantepago, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantepagoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantepago, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantepagoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantepago, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantepagoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantepago, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantesecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantesecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ComprobantesecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantesecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantesecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantesecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantesecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantesecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ComprobantesecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadComprobantesecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptocajaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptocaja, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConceptocajaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptocaja, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptocajaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptocaja, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptocajaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptocaja, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptocajaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptocaja, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoentidadfinancieraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoentidadfinanciera, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConceptoentidadfinancieraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoentidadfinanciera, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoentidadfinancieraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoentidadfinanciera, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoentidadfinancieraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoentidadfinanciera, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoentidadfinancieraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoentidadfinanciera, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoliquidaciontarjetaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoliquidaciontarjeta, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConceptoliquidaciontarjetaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoliquidaciontarjeta, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoliquidaciontarjetaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoliquidaciontarjeta, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoliquidaciontarjetaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoliquidaciontarjeta, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptoliquidaciontarjetaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptoliquidaciontarjeta, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptopagoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptopago, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConceptopagoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptopago, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptopagoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptopago, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptopagoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptopago, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConceptopagoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConceptopago, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliaciondecajaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciondecaja, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConciliaciondecajaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciondecaja, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliaciondecajaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciondecaja, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliaciondecajaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciondecaja, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliaciondecajaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciondecaja, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliacionesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciones, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConciliacionesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciones, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliacionesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciones, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliacionesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciones, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConciliacionesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConciliaciones, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepago, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepago, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepago, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepago, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepago, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoencomprobanteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepagoencomprobante, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoencomprobanteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepagoencomprobante, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoencomprobanteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepagoencomprobante, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoencomprobanteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepagoencomprobante, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CondiciondepagoencomprobanteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCondiciondepagoencomprobante, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfiguracionarticuloecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConfiguracionarticuloecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConfiguracionarticuloecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfiguracionarticuloecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfiguracionarticuloecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfiguracionarticuloecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfiguracionarticuloecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfiguracionarticuloecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfiguracionarticuloecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfiguracionarticuloecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionfechavtomipymeNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionfechavtomipyme, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionfechavtomipymeMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionfechavtomipyme, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionfechavtomipymeListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionfechavtomipyme, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionfechavtomipymeEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionfechavtomipyme, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionfechavtomipymeModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionfechavtomipyme, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionvaloresentransitoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionvaloresentransito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionvaloresentransitoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionvaloresentransito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionvaloresentransitoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionvaloresentransito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionvaloresentransitoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionvaloresentransito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConfirmacionvaloresentransitoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConfirmacionvaloresentransito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ContabilizacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadContabilizacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ContabilizacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadContabilizacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ContabilizacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadContabilizacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ContabilizacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadContabilizacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ContabilizacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadContabilizacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConveniomultilateralNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadConveniomultilateral, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ConveniomultilateralMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConveniomultilateral, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConveniomultilateralListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConveniomultilateral, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConveniomultilateralEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConveniomultilateral, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ConveniomultilateralModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadConveniomultilateral, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CorredorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCorredor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CorredorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCorredor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CorredorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCorredor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CorredorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCorredor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CorredorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCorredor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CriteriosvaloresNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCriteriosvalores, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CriteriosvaloresMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCriteriosvalores, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CriteriosvaloresListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCriteriosvalores, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CriteriosvaloresEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCriteriosvalores, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CriteriosvaloresModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCriteriosvalores, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentabancariaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentabancaria, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CuentabancariaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentabancaria, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentabancariaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentabancaria, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentabancariaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentabancaria, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentabancariaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentabancaria, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentacorreoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentacorreo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CuentacorreoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentacorreo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentacorreoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentacorreo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentacorreoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentacorreo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuentacorreoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuentacorreo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCupon, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CuponMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCupon, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCupon, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCupon, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCupon, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponeshuerfanosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponeshuerfanos, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CuponeshuerfanosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponeshuerfanos, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponeshuerfanosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponeshuerfanos, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponeshuerfanosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponeshuerfanos, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponeshuerfanosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponeshuerfanos, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponespendientesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponespendientes, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CuponespendientesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponespendientes, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponespendientesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponespendientes, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponespendientesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponespendientes, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CuponespendientesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCuponespendientes, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CurvadetallesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadCurvadetalles, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CurvadetallesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCurvadetalles, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CurvadetallesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCurvadetalles, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CurvadetallesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCurvadetalles, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function CurvadetallesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadCurvadetalles, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosadicionalessipribNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosadicionalessiprib, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DatosadicionalessipribMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosadicionalessiprib, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosadicionalessipribListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosadicionalessiprib, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosadicionalessipribEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosadicionalessiprib, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosadicionalessipribModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosadicionalessiprib, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosfiscalesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosfiscales, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DatosfiscalesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosfiscales, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosfiscalesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosfiscales, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosfiscalesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosfiscales, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosfiscalesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosfiscales, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosretencionrecibidoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosretencionrecibido, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DatosretencionrecibidoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosretencionrecibido, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosretencionrecibidoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosretencionrecibido, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosretencionrecibidoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosretencionrecibido, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatosretencionrecibidoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatosretencionrecibido, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatostareaprogramadaecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDatostareaprogramadaecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DatostareaprogramadaecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatostareaprogramadaecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatostareaprogramadaecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatostareaprogramadaecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatostareaprogramadaecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatostareaprogramadaecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DatostareaprogramadaecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDatostareaprogramadaecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescargadechequesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDescargadecheques, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DescargadechequesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescargadecheques, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescargadechequesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescargadecheques, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescargadechequesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescargadecheques, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescargadechequesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescargadecheques, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescargadechequesAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescargadecheques, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescuentoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDescuento, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DescuentoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescuento, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescuentoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescuento, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescuentoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescuento, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DescuentoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDescuento, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DespachodeimportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDespachodeimportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DespachodeimportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDespachodeimportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DespachodeimportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDespachodeimportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DespachodeimportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDespachodeimportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DespachodeimportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDespachodeimportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DestinodescargachequesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDestinodescargacheques, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DestinodescargachequesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDestinodescargacheques, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DestinodescargachequesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDestinodescargacheques, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DestinodescargachequesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDestinodescargacheques, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DestinodescargachequesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDestinodescargacheques, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DevolucionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDevolucion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DevolucionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDevolucion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DevolucionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDevolucion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DevolucionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDevolucion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DevolucionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDevolucion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DevolucionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDevolucion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DireccionentregaencomprobanteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDireccionentregaencomprobante, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DireccionentregaencomprobanteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDireccionentregaencomprobante, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DireccionentregaencomprobanteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDireccionentregaencomprobante, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DireccionentregaencomprobanteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDireccionentregaencomprobante, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DireccionentregaencomprobanteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDireccionentregaencomprobante, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DisenoimpresionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDisenoimpresion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DisenoimpresionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDisenoimpresion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DisenoimpresionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDisenoimpresion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DisenoimpresionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDisenoimpresion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DisenoimpresionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDisenoimpresion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DistribucioncentrodecostoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadDistribucioncentrodecosto, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function DistribucioncentrodecostoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDistribucioncentrodecosto, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DistribucioncentrodecostoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDistribucioncentrodecosto, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DistribucioncentrodecostoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDistribucioncentrodecosto, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function DistribucioncentrodecostoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadDistribucioncentrodecosto, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EcommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEcommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EcommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEcommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EcommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEcommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EcommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEcommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EcommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEcommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EdicionimpuestoivacomprasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEdicionimpuestoivacompras, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EdicionimpuestoivacomprasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEdicionimpuestoivacompras, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EdicionimpuestoivacomprasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEdicionimpuestoivacompras, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EdicionimpuestoivacomprasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEdicionimpuestoivacompras, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EdicionimpuestoivacomprasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEdicionimpuestoivacompras, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EjercicioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEjercicio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EjercicioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEjercicio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EjercicioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEjercicio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EjercicioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEjercicio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EjercicioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEjercicio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEmail, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EmailMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmail, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmail, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmail, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmail, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailencomprobanteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEmailencomprobante, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EmailencomprobanteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmailencomprobante, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailencomprobanteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmailencomprobante, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailencomprobanteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmailencomprobante, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EmailencomprobanteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEmailencomprobante, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional1Nuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional1, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional1Mostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional1, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional1Listar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional1, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional1Eliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional1, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional1Modificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional1, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional2Nuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional2, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional2Mostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional2, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional2Listar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional2, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional2Eliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional2, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional2Modificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional2, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional3Nuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional3, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional3Mostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional3, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional3Listar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional3, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional3Eliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional3, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function Entidadadicional3Modificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadadicional3, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntidadfinancieraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadfinanciera, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EntidadfinancieraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadfinanciera, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntidadfinancieraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadfinanciera, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntidadfinancieraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadfinanciera, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntidadfinancieraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntidadfinanciera, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntregademercaderiasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEntregademercaderias, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EntregademercaderiasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntregademercaderias, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntregademercaderiasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntregademercaderias, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntregademercaderiasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntregademercaderias, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EntregademercaderiasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEntregademercaderias, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EnviodecuentacorrientepormailNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEnviodecuentacorrientepormail, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EnviodecuentacorrientepormailMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEnviodecuentacorrientepormail, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EnviodecuentacorrientepormailListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEnviodecuentacorrientepormail, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EnviodecuentacorrientepormailEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEnviodecuentacorrientepormail, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EnviodecuentacorrientepormailModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEnviodecuentacorrientepormail, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EquivalenciaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEquivalencia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EquivalenciaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEquivalencia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EquivalenciaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEquivalencia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EquivalenciaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEquivalencia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EquivalenciaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEquivalencia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ErrorsapNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadErrorsap, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ErrorsapMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadErrorsap, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ErrorsapListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadErrorsap, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ErrorsapEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadErrorsap, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ErrorsapModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadErrorsap, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstadosdeinteraccionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEstadosdeinteraccion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EstadosdeinteraccionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstadosdeinteraccion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstadosdeinteraccionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstadosdeinteraccion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstadosdeinteraccionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstadosdeinteraccion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstadosdeinteraccionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstadosdeinteraccion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstiloimpresionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEstiloimpresion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EstiloimpresionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstiloimpresion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstiloimpresionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstiloimpresion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstiloimpresionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstiloimpresion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EstiloimpresionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEstiloimpresion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EtiquetasecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadEtiquetasecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function EtiquetasecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEtiquetasecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EtiquetasecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEtiquetasecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EtiquetasecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEtiquetasecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function EtiquetasecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadEtiquetasecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFactura, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFactura, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFactura, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFactura, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFactura, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFactura, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaagrupadaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaagrupada, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturaagrupadaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaagrupada, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaagrupadaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaagrupada, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaagrupadaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaagrupada, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaagrupadaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaagrupada, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaagrupadaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaagrupada, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturadecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadeexportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadeexportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturadeexportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadeexportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadeexportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadeexportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadeexportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadeexportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadeexportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadeexportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturadeexportacionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturadeexportacion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronica, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronica, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronica, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronica, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronica, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronica, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicadecreditoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicadecredito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicadecreditoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicadecredito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicadecreditoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicadecredito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicadecreditoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicadecredito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicadecreditoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicadecredito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicadecreditoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicadecredito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaexportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicaexportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaexportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicaexportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaexportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicaexportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaexportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicaexportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaexportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicaexportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FacturaelectronicaexportacionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFacturaelectronicaexportacion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FamiliaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFamilia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FamiliaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFamilia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FamiliaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFamilia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FamiliaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFamilia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FamiliaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFamilia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FechacancelacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFechacancelacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FechacancelacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFechacancelacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FechacancelacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFechacancelacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FechacancelacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFechacancelacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FechacancelacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFechacancelacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FeriadoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFeriado, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FeriadoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFeriado, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FeriadoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFeriado, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FeriadoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFeriado, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FeriadoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFeriado, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FormulaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadFormula, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function FormulaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFormula, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FormulaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFormula, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FormulaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFormula, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function FormulaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadFormula, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionchcustodiaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionchcustodia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function GestionchcustodiaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionchcustodia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionchcustodiaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionchcustodia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionchcustodiaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionchcustodia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionchcustodiaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionchcustodia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionvendedorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionvendedor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function GestionvendedorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionvendedor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionvendedorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionvendedor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionvendedorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionvendedor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GestionvendedorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGestionvendedor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function GrupoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupovalorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupovalor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function GrupovalorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupovalor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupovalorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupovalor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupovalorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupovalor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GrupovalorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGrupovalor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GtinNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadGtin, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function GtinMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGtin, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GtinListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGtin, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GtinEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGtin, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function GtinModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadGtin, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function HerramientaagrupadoradepacksNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadHerramientaagrupadoradepacks, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function HerramientaagrupadoradepacksMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadHerramientaagrupadoradepacks, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function HerramientaagrupadoradepacksListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadHerramientaagrupadoradepacks, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function HerramientaagrupadoradepacksEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadHerramientaagrupadoradepacks, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function HerramientaagrupadoradepacksModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadHerramientaagrupadoradepacks, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirartNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirart, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirartMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirart, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirartListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirart, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirartEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirart, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirartModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirart, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircajNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircaj, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdircajMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircaj, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircajListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircaj, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircajEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircaj, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircajModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircaj, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirccaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircca, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirccaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircca, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirccaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircca, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirccaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircca, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirccaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircca, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircccNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirccc, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdircccMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirccc, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircccListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirccc, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircccEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirccc, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircccModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirccc, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircliNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircli, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdircliMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircli, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircliListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircli, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircliEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircli, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircliModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircli, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirconNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircon, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirconMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircon, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirconListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircon, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirconEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircon, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirconModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircon, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircueNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircue, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdircueMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircue, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircueListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircue, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircueEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircue, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdircueModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdircue, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirdesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirdes, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirdesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirdes, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirdesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirdes, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirdesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirdes, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirdesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirdes, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirimpNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirimp, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirimpMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirimp, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirimpListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirimp, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirimpEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirimp, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirimpModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirimp, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirliqNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirliq, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirliqMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirliq, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirliqListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirliq, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirliqEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirliq, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirliqModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirliq, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirmotNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirmot, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirmotMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirmot, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirmotListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirmot, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirmotEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirmot, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirmotModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirmot, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdiropeNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirope, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdiropeMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirope, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdiropeListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirope, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdiropeEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirope, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdiropeModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirope, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirproNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirpro, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirproMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirpro, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirproListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirpro, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirproEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirpro, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirproModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirpro, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirvalNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirval, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpdirvalMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirval, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirvalListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirval, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirvalEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirval, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpdirvalModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpdirval, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpresiondeetiquetaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpresiondeetiqueta, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpresiondeetiquetaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpresiondeetiqueta, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpresiondeetiquetaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpresiondeetiqueta, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpresiondeetiquetaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpresiondeetiqueta, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpresiondeetiquetaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpresiondeetiqueta, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImprimircomprobanteporloteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImprimircomprobanteporlote, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImprimircomprobanteporloteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImprimircomprobanteporlote, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImprimircomprobanteporloteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImprimircomprobanteporlote, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImprimircomprobanteporloteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImprimircomprobanteporlote, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImprimircomprobanteporloteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImprimircomprobanteporlote, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpuestoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpuesto, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpuestoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpuesto, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpuestoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpuesto, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpuestoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpuesto, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpuestoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpuesto, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpverccNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadImpvercc, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ImpverccMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpvercc, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpverccListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpvercc, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpverccEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpvercc, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ImpverccModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadImpvercc, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InconsistenciasapNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadInconsistenciasap, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function InconsistenciasapMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInconsistenciasap, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InconsistenciasapListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInconsistenciasap, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InconsistenciasapEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInconsistenciasap, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InconsistenciasapModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInconsistenciasap, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IncotermsNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadIncoterms, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function IncotermsMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIncoterms, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IncotermsListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIncoterms, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IncotermsEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIncoterms, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IncotermsModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIncoterms, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IndicesinflacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadIndicesinflacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function IndicesinflacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIndicesinflacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IndicesinflacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIndicesinflacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IndicesinflacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIndicesinflacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function IndicesinflacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadIndicesinflacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InteracciondeordenNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadInteracciondeorden, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function InteracciondeordenMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInteracciondeorden, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InteracciondeordenListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInteracciondeorden, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InteracciondeordenEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInteracciondeorden, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InteracciondeordenModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInteracciondeorden, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function InteracciondeordenAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadInteracciondeorden, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function JurisdiccionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadJurisdiccion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function JurisdiccionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadJurisdiccion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function JurisdiccionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadJurisdiccion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function JurisdiccionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadJurisdiccion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function JurisdiccionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadJurisdiccion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LimiteconsumoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadLimiteconsumo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function LimiteconsumoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLimiteconsumo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LimiteconsumoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLimiteconsumo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LimiteconsumoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLimiteconsumo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LimiteconsumoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLimiteconsumo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LineaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadLinea, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function LineaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinea, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LineaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinea, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LineaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinea, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LineaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinea, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LinkqrenetiquetaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadLinkqrenetiqueta, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function LinkqrenetiquetaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinkqrenetiqueta, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LinkqrenetiquetaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinkqrenetiqueta, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LinkqrenetiquetaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinkqrenetiqueta, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LinkqrenetiquetaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLinkqrenetiqueta, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidaciondiariaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidaciondiaria, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function LiquidaciondiariaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidaciondiaria, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidaciondiariaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidaciondiaria, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidaciondiariaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidaciondiaria, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidaciondiariaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidaciondiaria, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidacionmensualNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidacionmensual, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function LiquidacionmensualMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidacionmensual, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidacionmensualListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidacionmensual, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidacionmensualEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidacionmensual, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function LiquidacionmensualModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadLiquidacionmensual, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadepreciosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecios, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ListadepreciosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecios, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadepreciosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecios, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadepreciosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecios, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadepreciosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecios, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadeprecioscalculadaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecioscalculada, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ListadeprecioscalculadaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecioscalculada, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadeprecioscalculadaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecioscalculada, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadeprecioscalculadaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecioscalculada, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ListadeprecioscalculadaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadListadeprecioscalculada, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MailporloteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMailporlote, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MailporloteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMailporlote, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MailporloteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMailporlote, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MailporloteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMailporlote, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MailporloteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMailporlote, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MarcaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMarca, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MarcaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMarca, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MarcaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMarca, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MarcaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMarca, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MarcaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMarca, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MaterialNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMaterial, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MaterialMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMaterial, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MaterialListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMaterial, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MaterialEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMaterial, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MaterialModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMaterial, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MercaderiaentransitoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMercaderiaentransito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MercaderiaentransitoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMercaderiaentransito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MercaderiaentransitoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMercaderiaentransito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MercaderiaentransitoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMercaderiaentransito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MercaderiaentransitoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMercaderiaentransito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MercaderiaentransitoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMercaderiaentransito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MinimoreposicionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMinimoreposicion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MinimoreposicionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMinimoreposicion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MinimoreposicionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMinimoreposicion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MinimoreposicionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMinimoreposicion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MinimoreposicionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMinimoreposicion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ModificacionpreciosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadModificacionprecios, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ModificacionpreciosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadModificacionprecios, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ModificacionpreciosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadModificacionprecios, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ModificacionpreciosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadModificacionprecios, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ModificacionpreciosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadModificacionprecios, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ModificacionpreciosAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadModificacionprecios, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMoneda, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MonedaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMoneda, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMoneda, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMoneda, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMoneda, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaafipNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMonedaafip, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MonedaafipMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMonedaafip, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaafipListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMonedaafip, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaafipEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMonedaafip, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MonedaafipModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMonedaafip, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MotivoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivodescuentoydevolucionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivodescuentoydevolucion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MotivodescuentoydevolucionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivodescuentoydevolucion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivodescuentoydevolucionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivodescuentoydevolucion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivodescuentoydevolucionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivodescuentoydevolucion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MotivodescuentoydevolucionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMotivodescuentoydevolucion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientobancarioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientobancario, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MovimientobancarioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientobancario, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientobancarioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientobancario, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientobancarioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientobancario, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientobancarioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientobancario, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientodestockNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientodestock, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function MovimientodestockMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientodestock, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientodestockListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientodestock, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientodestockEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientodestock, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientodestockModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientodestock, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function MovimientodestockAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadMovimientodestock, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NombredefantasiaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNombredefantasia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NombredefantasiaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNombredefantasia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NombredefantasiaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNombredefantasia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NombredefantasiaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNombredefantasia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NombredefantasiaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNombredefantasia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NomencladorarbaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNomencladorarba, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NomencladorarbaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNomencladorarba, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NomencladorarbaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNomencladorarba, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NomencladorarbaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNomencladorarba, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NomencladorarbaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNomencladorarba, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecredito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecredito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecredito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecredito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecredito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecredito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoagrupadaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoagrupada, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoagrupadaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoagrupada, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoagrupadaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoagrupada, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoagrupadaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoagrupada, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoagrupadaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoagrupada, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoagrupadaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoagrupada, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditocompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditocompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditocompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditocompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditocompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditocompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditocompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditocompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditocompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditocompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditocompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditocompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditodeexportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditodeexportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditodeexportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditodeexportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditodeexportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditodeexportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditodeexportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditodeexportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditodeexportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditodeexportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditodeexportacionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditodeexportacion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronica, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronica, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronica, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronica, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronica, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronica, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicadecreditoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicadecredito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicadecreditoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicadecredito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicadecreditoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicadecredito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicadecreditoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicadecredito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicadecreditoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicadecredito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicadecreditoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicadecredito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaexportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicaexportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaexportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicaexportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaexportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicaexportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaexportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicaexportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaexportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicaexportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadecreditoelectronicaexportacionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadecreditoelectronicaexportacion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoagrupadaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoagrupada, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoagrupadaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoagrupada, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoagrupadaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoagrupada, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoagrupadaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoagrupada, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoagrupadaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoagrupada, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoagrupadaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoagrupada, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitocompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitocompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitocompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitocompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitocompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitocompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitocompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitocompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitocompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitocompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitocompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitocompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitodeexportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitodeexportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitodeexportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitodeexportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitodeexportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitodeexportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitodeexportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitodeexportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitodeexportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitodeexportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitodeexportacionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitodeexportacion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronica, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronica, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronica, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronica, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronica, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronica, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicadecreditoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicadecredito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicadecreditoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicadecredito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicadecreditoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicadecredito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicadecreditoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicadecredito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicadecreditoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicadecredito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicadecreditoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicadecredito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaexportacionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicaexportacion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaexportacionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicaexportacion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaexportacionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicaexportacion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaexportacionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicaexportacion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaexportacionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicaexportacion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NotadedebitoelectronicaexportacionAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNotadedebitoelectronicaexportacion, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoenbaseaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoenbasea, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NuevoenbaseaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoenbasea, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoenbaseaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoenbasea, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoenbaseaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoenbasea, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoenbaseaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoenbasea, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoentregaonlineNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoentregaonline, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NuevoentregaonlineMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoentregaonline, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoentregaonlineListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoentregaonline, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoentregaonlineEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoentregaonline, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NuevoentregaonlineModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNuevoentregaonline, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NumeracionesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadNumeraciones, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function NumeracionesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNumeraciones, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NumeracionesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNumeraciones, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NumeracionesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNumeraciones, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function NumeracionesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadNumeraciones, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperacionecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadOperacionecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function OperacionecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperacionecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperacionecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperacionecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperacionecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperacionecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperacionecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperacionecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperadoradetarjetaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadOperadoradetarjeta, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function OperadoradetarjetaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperadoradetarjeta, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperadoradetarjetaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperadoradetarjeta, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperadoradetarjetaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperadoradetarjeta, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OperadoradetarjetaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOperadoradetarjeta, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendepagoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendepago, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function OrdendepagoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendepago, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendepagoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendepago, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendepagoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendepago, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendepagoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendepago, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendepagoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendepago, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendeservicioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendeservicio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function OrdendeservicioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendeservicio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendeservicioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendeservicio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendeservicioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendeservicio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendeservicioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendeservicio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrdendeservicioAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrdendeservicio, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrigendedatosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadOrigendedatos, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function OrigendedatosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrigendedatos, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrigendedatosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrigendedatos, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrigendedatosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrigendedatos, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function OrigendedatosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadOrigendedatos, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PagoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPago, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PagoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPago, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PagoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPago, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PagoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPago, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PagoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPago, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PagoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPago, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisafipNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPaisafip, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PaisafipMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaisafip, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisafipListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaisafip, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisafipEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaisafip, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisafipModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaisafip, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPaises, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PaisesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaises, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaises, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaises, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaisesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaises, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaletadecoloresNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPaletadecolores, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PaletadecoloresMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaletadecolores, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaletadecoloresListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaletadecolores, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaletadecoloresEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaletadecolores, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PaletadecoloresModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPaletadecolores, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PasajedestockNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPasajedestock, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PasajedestockMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPasajedestock, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PasajedestockListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPasajedestock, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PasajedestockEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPasajedestock, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PasajedestockModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPasajedestock, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPedido, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PedidoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedido, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedido, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedido, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedido, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedido, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidodecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPedidodecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PedidodecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedidodecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidodecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedidodecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidodecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedidodecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidodecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedidodecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PedidodecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPedidodecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PickingMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingConfirmarmercaderia( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionConfirmarmercaderia", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingRechazarmercaderia( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionRechazarmercaderia", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingGenerarremitosincanc( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionGenerarremitosincanc", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingGenerarremitoconcanc( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionGenerarremitoconcanc", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingGenerarfacturasincan( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionGenerarfacturasincan", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingGenerarfacturaconcan( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionGenerarfacturaconcan", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingGenerarpreparacionsincanc( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionGenerarpreparacionsincanc", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PickingGenerarpreparacionconcanc( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPicking, "AccionGenerarpreparacionconcanc", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PlandecuentasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPlandecuentas, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PlandecuentasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPlandecuentas, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PlandecuentasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPlandecuentas, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PlandecuentasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPlandecuentas, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PlandecuentasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPlandecuentas, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPos, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPos, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPos, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPos, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPos, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreciodearticuloNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPreciodearticulo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PreciodearticuloMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreciodearticulo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreciodearticuloListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreciodearticulo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreciodearticuloEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreciodearticulo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreciodearticuloModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreciodearticulo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreparaciondemercaderiaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPreparaciondemercaderia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PreparaciondemercaderiaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreparaciondemercaderia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreparaciondemercaderiaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreparaciondemercaderia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreparaciondemercaderiaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreparaciondemercaderia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreparaciondemercaderiaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreparaciondemercaderia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PreparaciondemercaderiaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPreparaciondemercaderia, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuesto, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PresupuestoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuesto, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuesto, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuesto, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuesto, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuesto, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestodecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuestodecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PresupuestodecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuestodecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestodecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuestodecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestodecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuestodecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestodecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuestodecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PresupuestodecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPresupuestodecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PromocionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPromocion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PromocionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPromocion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PromocionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPromocion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PromocionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPromocion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PromocionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPromocion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PropiedadeslistadosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPropiedadeslistados, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PropiedadeslistadosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPropiedadeslistados, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PropiedadeslistadosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPropiedadeslistados, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PropiedadeslistadosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPropiedadeslistados, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PropiedadeslistadosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPropiedadeslistados, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProveedorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadProveedor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ProveedorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProveedor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProveedorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProveedor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProveedorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProveedor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProveedorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProveedor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProvinciaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadProvincia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ProvinciaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProvincia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProvinciaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProvincia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProvinciaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProvincia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ProvinciaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadProvincia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PuntosdeventaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadPuntosdeventa, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function PuntosdeventaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPuntosdeventa, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PuntosdeventaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPuntosdeventa, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PuntosdeventaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPuntosdeventa, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function PuntosdeventaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadPuntosdeventa, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RazonsocialNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRazonsocial, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RazonsocialMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRazonsocial, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RazonsocialListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRazonsocial, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RazonsocialEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRazonsocial, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RazonsocialModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRazonsocial, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReciboNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRecibo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ReciboMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRecibo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReciboListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRecibo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReciboEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRecibo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReciboModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRecibo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReciboAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRecibo, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RedondeodepreciosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRedondeodeprecios, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RedondeodepreciosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRedondeodeprecios, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RedondeodepreciosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRedondeodeprecios, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RedondeodepreciosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRedondeodeprecios, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RedondeodepreciosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRedondeodeprecios, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegimenimpositivoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRegimenimpositivo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RegimenimpositivoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegimenimpositivo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegimenimpositivoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegimenimpositivo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegimenimpositivoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegimenimpositivo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegimenimpositivoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegimenimpositivo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecostosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecostos, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecostosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecostos, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecostosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecostos, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecostosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecostos, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecostosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecostos, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecuentaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecuenta, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecuentaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecuenta, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecuentaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecuenta, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecuentaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecuenta, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RegistrodecuentaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRegistrodecuenta, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRemito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RemitoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitodecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitodecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RemitodecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitodecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitodecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitodecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitodecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitodecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitodecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitodecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitodecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitodecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoelectronicoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitoelectronico, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RemitoelectronicoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitoelectronico, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoelectronicoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitoelectronico, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoelectronicoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitoelectronico, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RemitoelectronicoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRemitoelectronico, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RenumeraasientosNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRenumeraasientos, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RenumeraasientosMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRenumeraasientos, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RenumeraasientosListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRenumeraasientos, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RenumeraasientosEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRenumeraasientos, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RenumeraasientosModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRenumeraasientos, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteauditoriacierrezNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteauditoriacierrez, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ReporteauditoriacierrezMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteauditoriacierrez, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteauditoriacierrezListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteauditoriacierrez, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteauditoriacierrezEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteauditoriacierrez, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteauditoriacierrezModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteauditoriacierrez, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteelectronicoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteelectronico, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ReporteelectronicoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteelectronico, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteelectronicoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteelectronico, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteelectronicoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteelectronico, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ReporteelectronicoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadReporteelectronico, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RequerimientodecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadRequerimientodecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function RequerimientodecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRequerimientodecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RequerimientodecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRequerimientodecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RequerimientodecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRequerimientodecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RequerimientodecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRequerimientodecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function RequerimientodecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadRequerimientodecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SaltodecampoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSaltodecampo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SaltodecampoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSaltodecampo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SaltodecampoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSaltodecampo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SaltodecampoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSaltodecampo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SaltodecampoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSaltodecampo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionbasesarchivadasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionbasesarchivadas, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SeleccionbasesarchivadasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionbasesarchivadas, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionbasesarchivadasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionbasesarchivadas, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionbasesarchivadasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionbasesarchivadas, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionbasesarchivadasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionbasesarchivadas, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccioncomprobanteasociadoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccioncomprobanteasociado, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SeleccioncomprobanteasociadoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccioncomprobanteasociado, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccioncomprobanteasociadoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccioncomprobanteasociado, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccioncomprobanteasociadoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccioncomprobanteasociado, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccioncomprobanteasociadoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccioncomprobanteasociado, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecciondespachoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecciondespacho, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SelecciondespachoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecciondespacho, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecciondespachoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecciondespacho, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecciondespachoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecciondespacho, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecciondespachoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecciondespacho, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionoperacionecommerceNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionoperacionecommerce, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SeleccionoperacionecommerceMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionoperacionecommerce, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionoperacionecommerceListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionoperacionecommerce, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionoperacionecommerceEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionoperacionecommerce, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionoperacionecommerceModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionoperacionecommerce, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionordendeservicioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionordendeservicio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SeleccionordendeservicioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionordendeservicio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionordendeservicioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionordendeservicio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionordendeservicioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionordendeservicio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeleccionordendeservicioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeleccionordendeservicio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecompainsertarNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecompainsertar, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SelecompainsertarMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecompainsertar, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecompainsertarListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecompainsertar, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecompainsertarEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecompainsertar, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SelecompainsertarModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSelecompainsertar, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSenia, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SeniaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSenia, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSenia, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSenia, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSenia, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSenia, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniapendienteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSeniapendiente, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SeniapendienteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeniapendiente, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniapendienteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeniapendiente, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniapendienteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeniapendiente, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SeniapendienteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSeniapendiente, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SolicituddecompraNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSolicituddecompra, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SolicituddecompraMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSolicituddecompra, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SolicituddecompraListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSolicituddecompra, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SolicituddecompraEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSolicituddecompra, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SolicituddecompraModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSolicituddecompra, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SolicituddecompraAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSolicituddecompra, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SucursalbancariaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadSucursalbancaria, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function SucursalbancariaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSucursalbancaria, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SucursalbancariaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSucursalbancaria, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SucursalbancariaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSucursalbancaria, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function SucursalbancariaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadSucursalbancaria, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalleNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTalle, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TalleMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalle, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalleListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalle, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalleEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalle, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalleModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalle, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalonarioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTalonario, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TalonarioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalonario, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalonarioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalonario, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalonarioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalonario, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TalonarioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTalonario, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TemporadaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTemporada, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TemporadaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTemporada, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TemporadaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTemporada, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TemporadaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTemporada, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TemporadaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTemporada, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketfacturaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketfactura, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TicketfacturaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketfactura, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketfacturaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketfactura, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketfacturaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketfactura, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketfacturaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketfactura, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketfacturaAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketfactura, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadecreditoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadecredito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadecreditoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadecredito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadecreditoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadecredito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadecreditoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadecredito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadecreditoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadecredito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadecreditoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadecredito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadedebitoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadedebito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadedebitoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadedebito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadedebitoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadedebito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadedebitoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadedebito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadedebitoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadedebito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TicketnotadedebitoAnular( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTicketnotadedebito, "Anular", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventarioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventario, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventarioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventario, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventarioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventario, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventarioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventario, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventarioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventario, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventariodetalleNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventariodetalle, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventariodetalleMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventariodetalle, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventariodetalleListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventariodetalle, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventariodetalleEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventariodetalle, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TidiferenciasdeinventariodetalleModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTidiferenciasdeinventariodetalle, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventarioacontNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventarioacont, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TiinventarioacontMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventarioacont, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventarioacontListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventarioacont, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventarioacontEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventarioacont, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventarioacontModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventarioacont, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisico, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisico, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisico, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisico, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisico, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicodetalleNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisicodetalle, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicodetalleMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisicodetalle, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicodetalleListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisicodetalle, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicodetalleEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisicodetalle, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TiinventariofisicodetalleModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTiinventariofisicodetalle, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoclienteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTipocliente, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TipoclienteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipocliente, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoclienteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipocliente, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoclienteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipocliente, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoclienteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipocliente, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodearticuloNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodearticulo, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TipodearticuloMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodearticulo, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodearticuloListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodearticulo, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodearticuloEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodearticulo, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodearticuloModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodearticulo, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodedireccionNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodedireccion, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TipodedireccionMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodedireccion, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodedireccionListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodedireccion, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodedireccionEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodedireccion, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodedireccionModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodedireccion, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodeordenNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodeorden, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TipodeordenMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodeorden, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodeordenListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodeorden, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodeordenEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodeorden, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipodeordenModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipodeorden, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoimpuestoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTipoimpuesto, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TipoimpuestoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipoimpuesto, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoimpuestoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipoimpuesto, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoimpuestoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipoimpuesto, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TipoimpuestoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTipoimpuesto, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransferenciaentrecuentasNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTransferenciaentrecuentas, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TransferenciaentrecuentasMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransferenciaentrecuentas, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransferenciaentrecuentasListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransferenciaentrecuentas, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransferenciaentrecuentasEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransferenciaentrecuentas, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransferenciaentrecuentasModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransferenciaentrecuentas, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransportistaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTransportista, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TransportistaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransportista, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransportistaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransportista, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransportistaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransportista, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TransportistaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTransportista, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TratamientocomprobantesNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadTratamientocomprobantes, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function TratamientocomprobantesMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTratamientocomprobantes, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TratamientocomprobantesListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTratamientocomprobantes, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TratamientocomprobantesEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTratamientocomprobantes, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function TratamientocomprobantesModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadTratamientocomprobantes, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedida, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedida, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedida, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedida, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedida, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaafipNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaafip, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaafipMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaafip, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaafipListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaafip, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaafipEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaafip, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaafipModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaafip, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaarbaNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaarba, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaarbaMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaarba, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaarbaListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaarba, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaarbaEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaarba, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function UnidaddemedidaarbaModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadUnidaddemedidaarba, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValedecambioNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadValedecambio, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ValedecambioMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValedecambio, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValedecambioListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValedecambio, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValedecambioEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValedecambio, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValedecambioModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValedecambio, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadValor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ValorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValoresentransitoNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadValoresentransito, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ValoresentransitoMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValoresentransito, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValoresentransitoListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValoresentransito, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValoresentransitoEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValoresentransito, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function ValoresentransitoModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadValoresentransito, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedor, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function VendedorMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedor, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedor, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedor, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedor, "Modificar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorencomprobanteNuevo( tcRequest as String ) as Object
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedorencomprobante, "Nuevo", tcRequest )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function VendedorencomprobanteMostrar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedorencomprobante, "Mostrar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorencomprobanteListar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedorencomprobante, "Listar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorencomprobanteEliminar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedorencomprobante, "Eliminar", tcRequest )
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	function VendedorencomprobanteModificar( tcRequest as String ) as Void
		return this.EjecutarOperacion( this.oOperacionesEntidadVendedorencomprobante, "Modificar", tcRequest )
	endfunc 
	
	

enddefine