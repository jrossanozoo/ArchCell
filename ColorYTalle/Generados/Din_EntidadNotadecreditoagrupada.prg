
define class Din_EntidadNOTADECREDITOAGRUPADA as Ent_ComprobanteAgrupado of Ent_ComprobanteAgrupado.prg

	cNombre = 'NOTADECREDITOAGRUPADA'
	FechaModificacion = ctod( '  /  /    ' )
	FueInformadoALaNube = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FechaVToCAI = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	CUIT = []
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	FacturaDetalle = null
	ImpuestosDetalle = null
	COMPAFEC = null
	CodigoAjuste = []
	FechaAltaFW = ctod( '  /  /    ' )
	NroOPEcommerce = []
	HoraAltaFW = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSALTAFW = []
	CodigoBarraAutoImpresor = []
	ZADSFW = []
	Hora = []
	BASEDEDATOSMODIFICACIONFW = []
	VERSIONMODIFICACIONFW = []
	VERSIONALTAFW = []
	DescripcionFW = []
	USUARIOMODIFICACIONFW = []
	SimboloMonetarioComprobante = []
	USUARIOALTAFW = []
	HORAIMPO = []
	HORAMODIFICACIONFW = []
	SERIEALTAFW = []
	SERIEMODIFICACIONFW = []
	HORAEXPO = []
	TIMESTAMP = 0
	CAI = 0
	Secuencia = []
	TotalCantidad = 0
	PorcentajeDescuento2 = 0
	RecargoMontoSinImpuestos = 0
	SubTotalSinImpuestosSobreItems = 0
	SituacionFiscal_PK = 0
	SituacionFiscal = null
	SubtotalBruto = 0
	signodemovimiento = 0
	SubtotalNeto = 0
	SubTotalConImpuestosSobreItems = 0
	CondicionIva = 0
	RecargoMontoSinImpuestos1 = 0
	RecargoMontoSinImpuestos2 = 0
	MontoDescuentoSinImpuestos3 = 0
	MontoDescuentoConImpuestos = 0
	AjustesPorRedondeos = 0
	MontoDescuentoSinImpuestos2 = 0
	MontoDescuentoSinImpuestos = 0
	MontoDescuentoSinImpuestos1 = 0
	anulado = .F.
	DescuentoAutomatico = .F.
	BasadoEnComprobanteOnline = .F.
	ComprobanteFiscal = .F.
	ImpuestosComprobante = null
	CodigoMotivoDescuentoEnSubtotal_PK = []
	CodigoMotivoDescuentoEnSubtotal = null
	MonedaSistema_PK = []
	MonedaSistema = null
	IdVuelto_PK = []
	IdVuelto = null
	Obs = []
	PorcentajeDescuento1 = 0
	Turno = 0
	IDSenia = []
	MontoDescuentoConImpuestos2 = 0
	TipoComprobante = 0
	lHabilitarTipoComprobante = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	MontoDescuento1 = 0
	Cliente_PK = []
	Cliente = null
	lHabilitarCliente_PK = .T.
	MontoDescuentoConImpuestos1 = 0
	Receptor_PK = []
	Receptor = null
	ClienteDescripcion = []
	ArticulosSeniadosDetalle = null
	lHabilitarArticulosSeniadosDetalle = .T.
	CodigoBarraCAE = []
	Vendedor_PK = []
	Vendedor = null
	KitsDetalle = null
	lHabilitarKitsDetalle = .T.
	Letra = []
	FechaVtoSenia = ctod( '  /  /    ' )
	lHabilitarFechaVtoSenia = .T.
	ValoresDetalle = null
	TotalRecargosConImpuestos = 0
	TotalRecargosSinImpuestos = 0
	MonedaComprobante_PK = []
	MonedaComprobante = null
	lHabilitarMonedaComprobante_PK = .T.
	PuntoDeVenta = 0
	ListaDePrecios_PK = []
	ListaDePrecios = null
	Numero = 0
	Email = []
	Total = 0
	TotalDescuentosConImpuestos = 0
	TotalDescuentosSinImpuestos = 0
	Fecha = ctod( '  /  /    ' )
	Cotizacion = 0
	MontoDescuentoConImpuestos3 = 0
	CAE = []
	PorcentajeDescuento = 0
	RecargoMontoConImpuestos2 = 0
	VueltoVirtual = 0
	Vuelto = 0
	FechaVencimientoCae = ctod( '  /  /    ' )
	FechaVencimientoMiPyME = ctod( '  /  /    ' )
	Descuento = 0
	EntregaPosteriorVirtual = []
	EntregaPosterior = 0
	MontoDescuento3 = 0
	Percepciones = 0
	RecargoMontoConImpuestos = 0
	RecargoPorcentaje = 0
	RecargoMonto = 0
	RecargoMonto2 = 0
	MontoDescuento2 = 0
	MontoDescuento2Visual = 0
	RecargoMonto1 = 0
	RecargoMonto1Visual = 0
	RecargoMontoConImpuestos1 = 0
	Subtotalsinimp = 0
	Gravamenes = 0
	Impuestos = 0
	Subtotalconimp = 0
	TotalRecargos = 0
	TotalDescuentos = 0
	ChequeReintegro = []
	TotalImpuestos = 0
	MercaderiaConsignacion = .F.
	AccionCancelatoria = .F.
	IvaDelSistema = 0
	TipoCpteRelacionado = 0
	LetraCpteRelacionado = []
	PuntoDeVentaCpteRelacionado = 0
	NumeroCpteRelacionado = 0
	FechaCpteRelacionado = ctod( '  /  /    ' )
	Deuda = 0
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Nota de crédito]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .t.
	cAtributoVendedor = 'VENDEDOR_PK'
	oAtributosCC =  Null
	cDetalleParticipantes = 'FACTURADETALLE'
	oCompLimitesDeConsumo = null
	oCompDescuentos = null
	oCompFacturacionElectronica = null
	oCompSenias = null
	oCompDatosAdicionalesComprobantesA = null
	oCompRegistroLiquidacionConsignaciones = null
	oCompKitDeArticulos = null
	oCompEnBaseA = null
	lSoportaKits = .t.
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCaja_PK = .T.
		this.lHabilitarTipoComprobante = .T.
		this.lHabilitarCliente_PK = .T.
		this.lHabilitarArticulosSeniadosDetalle = .T.
		this.lHabilitarKitsDetalle = .T.
		this.lHabilitarFechaVtoSenia = .T.
		this.lHabilitarMonedaComprobante_PK = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigo_Assign( txVal as variant ) as void
		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean
		with this
			llEdicion = .EsEdicion()
			if !this.lPermiteMinusculasPK
				try
					txVal = upper( txVal )
				Catch
				Endtry
			endif
			if .lLimpiando or .lCargando
				.Codigo = .TransformarAlAsignar( txVal )
			else
				if llEdicion
				else
					llNuevo = .EsNuevo()
					.Codigo = .TransformarAlAsignar( txVal )
					if empty( txVal ) and !llNuevo
						.Limpiar()
					else
						if llNuevo
							if .ValidarIngreso( txVal, llNuevo )
							else
								goServicios.Errores.LevantarExcepcion( 'Caracter inválido en el código.' )
							endif
						endif
						llConsulta = .oAD.ConsultarPorClavePrimaria()
						do case
							case !llNuevo and llConsulta
								.Cargar()
							case !llNuevo and !llConsulta
								.Limpiar()
								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )
							case llNuevo and llConsulta
								.Codigo = []
								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )
						endcase
					endif
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oAD_Access() as variant
		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )
			this.oAD = this.crearobjeto( 'Din_EntidadNOTADECREDITOAGRUPADAAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturadetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Facturadetalle ) = 'O' or isnull( this.Facturadetalle ) )
			this.Facturadetalle = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaFacturadetalle' )
			this.Facturadetalle.inicializar()
			this.enlazar( 'Facturadetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Facturadetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Facturadetalle, 'CambioSumarizado', this, 'CambiosDetalleFacturadetalle', 1) 
			this.enlazar( 'Facturadetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Facturadetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Facturadetalle.lVerificarLimitesEnDisenoImpresion = .t.
			This.BindearEvento( This.Facturadetalle, 'EventoAgregarKits' , This, 'AgregarKits' )
		endif
		return this.Facturadetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestosdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestosdetalle ) = 'O' or isnull( this.Impuestosdetalle ) )
			this.Impuestosdetalle = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaImpuestosdetalle' )
			this.Impuestosdetalle.inicializar()
			this.enlazar( 'Impuestosdetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Impuestosdetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Impuestosdetalle, 'CambioSumarizado', this, 'CambiosDetalleImpuestosdetalle', 1) 
			this.enlazar( 'Impuestosdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Impuestosdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Impuestosdetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Compafec_Access() as variant
		if !this.ldestroy and ( !vartype( this.Compafec ) = 'O' or isnull( this.Compafec ) )
			this.Compafec = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaCompafec' )
			this.Compafec.inicializar()
			this.enlazar( 'Compafec.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Compafec.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Compafec, 'CambioSumarizado', this, 'CambiosDetalleCompafec', 1) 
			this.enlazar( 'Compafec.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Compafec.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Compafec
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestoscomprobante_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestoscomprobante ) = 'O' or isnull( this.Impuestoscomprobante ) )
			this.Impuestoscomprobante = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaImpuestoscomprobante' )
			this.Impuestoscomprobante.inicializar()
			this.enlazar( 'Impuestoscomprobante.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Impuestoscomprobante.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Impuestoscomprobante, 'CambioSumarizado', this, 'CambiosDetalleImpuestoscomprobante', 1) 
			this.enlazar( 'Impuestoscomprobante.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Impuestoscomprobante.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Impuestoscomprobante
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulosseniadosdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Articulosseniadosdetalle ) = 'O' or isnull( this.Articulosseniadosdetalle ) )
			this.Articulosseniadosdetalle = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaArticulosseniadosdetalle' )
			this.Articulosseniadosdetalle.inicializar()
			this.enlazar( 'Articulosseniadosdetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Articulosseniadosdetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Articulosseniadosdetalle, 'CambioSumarizado', this, 'CambiosDetalleArticulosseniadosdetalle', 1) 
			this.enlazar( 'Articulosseniadosdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Articulosseniadosdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Articulosseniadosdetalle.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Articulosseniadosdetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Kitsdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Kitsdetalle ) = 'O' or isnull( this.Kitsdetalle ) )
			this.Kitsdetalle = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaKitsdetalle' )
			this.Kitsdetalle.inicializar()
			this.enlazar( 'Kitsdetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Kitsdetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Kitsdetalle, 'CambioSumarizado', this, 'CambiosDetalleKitsdetalle', 1) 
			this.enlazar( 'Kitsdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Kitsdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Kitsdetalle.lVerificarLimitesEnDisenoImpresion = .t.
			this.enlazar( 'Kitsdetalle.EventoAgregarKits', 'AgregarParticipantes') 
			this.enlazar( 'Kitsdetalle.EventoErrorParticipante', 'ErrorParticipante') 
		endif
		return this.Kitsdetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valoresdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Valoresdetalle ) = 'O' or isnull( this.Valoresdetalle ) )
			this.Valoresdetalle = this.crearobjeto( 'Din_DetalleNotadecreditoagrupadaValoresdetalle' )
			this.Valoresdetalle.inicializar()
			this.enlazar( 'Valoresdetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Valoresdetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Valoresdetalle, 'CambioSumarizado', this, 'CambiosDetalleValoresdetalle', 1) 
			this.enlazar( 'Valoresdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Valoresdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Valoresdetalle.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Valoresdetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.FacturaDetalle.oItem.lNuevo = this.lNuevo
		this.ImpuestosDetalle.oItem.lNuevo = this.lNuevo
		this.COMPAFEC.oItem.lNuevo = this.lNuevo
		this.ImpuestosComprobante.oItem.lNuevo = this.lNuevo
		this.ArticulosSeniadosDetalle.oItem.lNuevo = this.lNuevo
		this.KitsDetalle.oItem.lNuevo = this.lNuevo
		this.ValoresDetalle.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.FacturaDetalle.oItem.lEdicion = this.lEdicion
		this.ImpuestosDetalle.oItem.lEdicion = this.lEdicion
		this.COMPAFEC.oItem.lEdicion = this.lEdicion
		this.ImpuestosComprobante.oItem.lEdicion = this.lEdicion
		this.ArticulosSeniadosDetalle.oItem.lEdicion = this.lEdicion
		this.KitsDetalle.oItem.lEdicion = this.lEdicion
		this.ValoresDetalle.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleFacturadetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleImpuestosdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleCompafec() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleImpuestoscomprobante() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleArticulosseniadosdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleKitsdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleValoresdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
		if ( vartype( this.FechaModificacion) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FueInformadoALaNube) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FUEINFORMADOALANUBE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAMODIFICACIONFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaVToCAI) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVTOCAI no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAIMPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CUIT) = 'C' )
			if len( alltrim( this.CUIT ) ) > 15
				This.AgregarInformacion( 'La longitud del valor del atributo CUIT es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUIT no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CodigoAjuste) = 'C' )
			if len( alltrim( this.CODIGOAJUSTE ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGOAJUSTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGOAJUSTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaAltaFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NroOPEcommerce) = 'C' )
			if len( alltrim( this.NROOPECOMMERCE ) ) > 254
				This.AgregarInformacion( 'La longitud del valor del atributo NROOPECOMMERCE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NROOPECOMMERCE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HoraAltaFW) = 'C' )
			if len( alltrim( this.HORAALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BASEDEDATOSALTAFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CodigoBarraAutoImpresor) = 'C' )
			if len( alltrim( this.CODIGOBARRAAUTOIMPRESOR ) ) > 40
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGOBARRAAUTOIMPRESOR es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGOBARRAAUTOIMPRESOR no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Hora) = 'C' )
			if len( alltrim( this.HORA ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BASEDEDATOSMODIFICACIONFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VERSIONALTAFW) = 'C' )
			if len( alltrim( this.VERSIONALTAFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.DescripcionFW) = 'C' )
			if len( alltrim( this.DESCRIPCIONFW ) ) > 200
				This.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.USUARIOMODIFICACIONFW) = 'C' )
			if len( alltrim( this.USUARIOMODIFICACIONFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SimboloMonetarioComprobante) = 'C' )
			if len( alltrim( this.SIMBOLOMONETARIOCOMPROBANTE ) ) > 3
				This.AgregarInformacion( 'La longitud del valor del atributo SIMBOLOMONETARIOCOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SIMBOLOMONETARIOCOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.USUARIOALTAFW) = 'C' )
			if len( alltrim( this.USUARIOALTAFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SERIEALTAFW) = 'C' )
			if len( alltrim( this.SERIEALTAFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SERIEMODIFICACIONFW) = 'C' )
			if len( alltrim( this.SERIEMODIFICACIONFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAEXPO) = 'C' )
			if len( alltrim( this.HORAEXPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAEXPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TIMESTAMP) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIMESTAMP ) ) ) 
			lnValorDelDecimal = this.TIMESTAMP - int( this.TIMESTAMP)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 20
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIMESTAMP es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIMESTAMP no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CAI) = 'N' )
			lnLargoEntero  = len( transform( int( this.CAI ) ) ) 
			lnValorDelDecimal = this.CAI - int( this.CAI)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 14
				This.AgregarInformacion( 'La longitud entera del valor del atributo CAI es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CAI no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Secuencia) = 'C' )
			if len( alltrim( this.SECUENCIA ) ) > 2
				This.AgregarInformacion( 'La longitud del valor del atributo SECUENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SECUENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalCantidad) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALCANTIDAD ) ) ) 
			lnValorDelDecimal = this.TOTALCANTIDAD - int( this.TOTALCANTIDAD)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALCANTIDAD es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALCANTIDAD no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PorcentajeDescuento2) = 'N' )
			lnLargoEntero  = len( transform( int( this.PORCENTAJEDESCUENTO2 ) ) ) 
			lnValorDelDecimal = this.PORCENTAJEDESCUENTO2 - int( this.PORCENTAJEDESCUENTO2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDESCUENTO2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDESCUENTO2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOSINIMPUESTOS - int( this.RECARGOMONTOSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SubTotalSinImpuestosSobreItems) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTALSINIMPUESTOSSOBREITEMS ) ) ) 
			lnValorDelDecimal = this.SUBTOTALSINIMPUESTOSSOBREITEMS - int( this.SUBTOTALSINIMPUESTOSSOBREITEMS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALSINIMPUESTOSSOBREITEMS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALSINIMPUESTOSSOBREITEMS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SubtotalBruto) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTALBRUTO ) ) ) 
			lnValorDelDecimal = this.SUBTOTALBRUTO - int( this.SUBTOTALBRUTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALBRUTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALBRUTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.signodemovimiento) = 'N' )
			lnLargoEntero  = len( transform( int( this.SIGNODEMOVIMIENTO ) ) ) 
			lnValorDelDecimal = this.SIGNODEMOVIMIENTO - int( this.SIGNODEMOVIMIENTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo SIGNODEMOVIMIENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SIGNODEMOVIMIENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SubtotalNeto) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTALNETO ) ) ) 
			lnValorDelDecimal = this.SUBTOTALNETO - int( this.SUBTOTALNETO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALNETO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALNETO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SubTotalConImpuestosSobreItems) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTALCONIMPUESTOSSOBREITEMS ) ) ) 
			lnValorDelDecimal = this.SUBTOTALCONIMPUESTOSSOBREITEMS - int( this.SUBTOTALCONIMPUESTOSSOBREITEMS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALCONIMPUESTOSSOBREITEMS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALCONIMPUESTOSSOBREITEMS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CondicionIva) = 'N' )
			lnLargoEntero  = len( transform( int( this.CONDICIONIVA ) ) ) 
			lnValorDelDecimal = this.CONDICIONIVA - int( this.CONDICIONIVA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo CONDICIONIVA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CONDICIONIVA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoSinImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOSINIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOSINIMPUESTOS1 - int( this.RECARGOMONTOSINIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoSinImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOSINIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOSINIMPUESTOS2 - int( this.RECARGOMONTOSINIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoSinImpuestos3) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS3 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS3 - int( this.MONTODESCUENTOSINIMPUESTOS3)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS3 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS3 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoConImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS - int( this.MONTODESCUENTOCONIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.AjustesPorRedondeos) = 'N' )
			lnLargoEntero  = len( transform( int( this.AJUSTESPORREDONDEOS ) ) ) 
			lnValorDelDecimal = this.AJUSTESPORREDONDEOS - int( this.AJUSTESPORREDONDEOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo AJUSTESPORREDONDEOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo AJUSTESPORREDONDEOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoSinImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS2 - int( this.MONTODESCUENTOSINIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS - int( this.MONTODESCUENTOSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoSinImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS1 - int( this.MONTODESCUENTOSINIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.anulado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ANULADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.DescuentoAutomatico) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTOAUTOMATICO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BasadoEnComprobanteOnline) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASADOENCOMPROBANTEONLINE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ComprobanteFiscal) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTEFISCAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Obs) = 'C' )
			if len( alltrim( this.OBS ) ) > 250
				This.AgregarInformacion( 'La longitud del valor del atributo OBS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PorcentajeDescuento1) = 'N' )
			lnLargoEntero  = len( transform( int( this.PORCENTAJEDESCUENTO1 ) ) ) 
			lnValorDelDecimal = this.PORCENTAJEDESCUENTO1 - int( this.PORCENTAJEDESCUENTO1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDESCUENTO1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDESCUENTO1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Turno) = 'N' )
			lnLargoEntero  = len( transform( int( this.TURNO ) ) ) 
			lnValorDelDecimal = this.TURNO - int( this.TURNO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo TURNO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TURNO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IDSenia) = 'C' )
			if len( alltrim( this.IDSENIA ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo IDSENIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IDSENIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoConImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS2 - int( this.MONTODESCUENTOCONIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoComprobante) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOCOMPROBANTE ) ) ) 
			lnValorDelDecimal = this.TIPOCOMPROBANTE - int( this.TIPOCOMPROBANTE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOCOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuento1) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTO1 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTO1 - int( this.MONTODESCUENTO1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoConImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS1 - int( this.MONTODESCUENTOCONIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ClienteDescripcion) = 'C' )
			if len( alltrim( this.CLIENTEDESCRIPCION ) ) > 185
				This.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDESCRIPCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CodigoBarraCAE) = 'C' )
			if len( alltrim( this.CODIGOBARRACAE ) ) > 40
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGOBARRACAE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGOBARRACAE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Letra) = 'C' )
			if len( alltrim( this.LETRA ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo LETRA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LETRA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaVtoSenia) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVTOSENIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalRecargosConImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALRECARGOSCONIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALRECARGOSCONIMPUESTOS - int( this.TOTALRECARGOSCONIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALRECARGOSCONIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALRECARGOSCONIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalRecargosSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALRECARGOSSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALRECARGOSSINIMPUESTOS - int( this.TOTALRECARGOSSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALRECARGOSSINIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALRECARGOSSINIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PuntoDeVenta) = 'N' )
			lnLargoEntero  = len( transform( int( this.PUNTODEVENTA ) ) ) 
			lnValorDelDecimal = this.PUNTODEVENTA - int( this.PUNTODEVENTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Numero) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMERO ) ) ) 
			lnValorDelDecimal = this.NUMERO - int( this.NUMERO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMERO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Email) = 'C' )
			if len( alltrim( this.EMAIL ) ) > 250
				This.AgregarInformacion( 'La longitud del valor del atributo EMAIL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo EMAIL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Total) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTAL ) ) ) 
			lnValorDelDecimal = this.TOTAL - int( this.TOTAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalDescuentosConImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALDESCUENTOSCONIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALDESCUENTOSCONIMPUESTOS - int( this.TOTALDESCUENTOSCONIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALDESCUENTOSCONIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALDESCUENTOSCONIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalDescuentosSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALDESCUENTOSSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALDESCUENTOSSINIMPUESTOS - int( this.TOTALDESCUENTOSSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALDESCUENTOSSINIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALDESCUENTOSSINIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Fecha) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Cotizacion) = 'N' )
			lnLargoEntero  = len( transform( int( this.COTIZACION ) ) ) 
			lnValorDelDecimal = this.COTIZACION - int( this.COTIZACION)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 10
				This.AgregarInformacion( 'La longitud entera del valor del atributo COTIZACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo COTIZACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoConImpuestos3) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS3 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS3 - int( this.MONTODESCUENTOCONIMPUESTOS3)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS3 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS3 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CAE) = 'C' )
			if len( alltrim( this.CAE ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo CAE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CAE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PorcentajeDescuento) = 'N' )
			lnLargoEntero  = len( transform( int( this.PORCENTAJEDESCUENTO ) ) ) 
			lnValorDelDecimal = this.PORCENTAJEDESCUENTO - int( this.PORCENTAJEDESCUENTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEDESCUENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEDESCUENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoConImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOCONIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOCONIMPUESTOS2 - int( this.RECARGOMONTOCONIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOCONIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOCONIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VueltoVirtual) = 'N' )
			lnLargoEntero  = len( transform( int( this.VUELTOVIRTUAL ) ) ) 
			lnValorDelDecimal = this.VUELTOVIRTUAL - int( this.VUELTOVIRTUAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo VUELTOVIRTUAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VUELTOVIRTUAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Vuelto) = 'N' )
			lnLargoEntero  = len( transform( int( this.VUELTO ) ) ) 
			lnValorDelDecimal = this.VUELTO - int( this.VUELTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo VUELTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VUELTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaVencimientoCae) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVENCIMIENTOCAE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaVencimientoMiPyME) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVENCIMIENTOMIPYME no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Descuento) = 'N' )
			lnLargoEntero  = len( transform( int( this.DESCUENTO ) ) ) 
			lnValorDelDecimal = this.DESCUENTO - int( this.DESCUENTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo DESCUENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EntregaPosteriorVirtual) = 'C' )
			if len( alltrim( this.ENTREGAPOSTERIORVIRTUAL ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ENTREGAPOSTERIORVIRTUAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ENTREGAPOSTERIORVIRTUAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EntregaPosterior) = 'N' )
			lnLargoEntero  = len( transform( int( this.ENTREGAPOSTERIOR ) ) ) 
			lnValorDelDecimal = this.ENTREGAPOSTERIOR - int( this.ENTREGAPOSTERIOR)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo ENTREGAPOSTERIOR es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ENTREGAPOSTERIOR no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuento3) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTO3 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTO3 - int( this.MONTODESCUENTO3)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO3 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO3 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Percepciones) = 'N' )
			lnLargoEntero  = len( transform( int( this.PERCEPCIONES ) ) ) 
			lnValorDelDecimal = this.PERCEPCIONES - int( this.PERCEPCIONES)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo PERCEPCIONES es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PERCEPCIONES no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoConImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOCONIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOCONIMPUESTOS - int( this.RECARGOMONTOCONIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOCONIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOCONIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoPorcentaje) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOPORCENTAJE ) ) ) 
			lnValorDelDecimal = this.RECARGOPORCENTAJE - int( this.RECARGOPORCENTAJE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOPORCENTAJE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOPORCENTAJE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMonto) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTO ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTO - int( this.RECARGOMONTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMonto2) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTO2 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTO2 - int( this.RECARGOMONTO2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTO2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTO2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuento2) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTO2 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTO2 - int( this.MONTODESCUENTO2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuento2Visual) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTO2VISUAL ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTO2VISUAL - int( this.MONTODESCUENTO2VISUAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTO2VISUAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTO2VISUAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMonto1) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTO1 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTO1 - int( this.RECARGOMONTO1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTO1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTO1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMonto1Visual) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTO1VISUAL ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTO1VISUAL - int( this.RECARGOMONTO1VISUAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTO1VISUAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTO1VISUAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoConImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOCONIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOCONIMPUESTOS1 - int( this.RECARGOMONTOCONIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOCONIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOCONIMPUESTOS1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Subtotalsinimp) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTALSINIMP ) ) ) 
			lnValorDelDecimal = this.SUBTOTALSINIMP - int( this.SUBTOTALSINIMP)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALSINIMP es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALSINIMP no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Gravamenes) = 'N' )
			lnLargoEntero  = len( transform( int( this.GRAVAMENES ) ) ) 
			lnValorDelDecimal = this.GRAVAMENES - int( this.GRAVAMENES)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo GRAVAMENES es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo GRAVAMENES no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Impuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.IMPUESTOS ) ) ) 
			lnValorDelDecimal = this.IMPUESTOS - int( this.IMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo IMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Subtotalconimp) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTALCONIMP ) ) ) 
			lnValorDelDecimal = this.SUBTOTALCONIMP - int( this.SUBTOTALCONIMP)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALCONIMP es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALCONIMP no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalRecargos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALRECARGOS ) ) ) 
			lnValorDelDecimal = this.TOTALRECARGOS - int( this.TOTALRECARGOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALRECARGOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALRECARGOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalDescuentos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALDESCUENTOS ) ) ) 
			lnValorDelDecimal = this.TOTALDESCUENTOS - int( this.TOTALDESCUENTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALDESCUENTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALDESCUENTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ChequeReintegro) = 'C' )
			if len( alltrim( this.CHEQUEREINTEGRO ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo CHEQUEREINTEGRO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CHEQUEREINTEGRO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALIMPUESTOS - int( this.TOTALIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MercaderiaConsignacion) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MERCADERIACONSIGNACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.AccionCancelatoria) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ACCIONCANCELATORIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IvaDelSistema) = 'N' )
			lnLargoEntero  = len( transform( int( this.IVADELSISTEMA ) ) ) 
			lnValorDelDecimal = this.IVADELSISTEMA - int( this.IVADELSISTEMA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo IVADELSISTEMA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IVADELSISTEMA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoCpteRelacionado) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOCPTERELACIONADO ) ) ) 
			lnValorDelDecimal = this.TIPOCPTERELACIONADO - int( this.TIPOCPTERELACIONADO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOCPTERELACIONADO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOCPTERELACIONADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.LetraCpteRelacionado) = 'C' )
			if len( alltrim( this.LETRACPTERELACIONADO ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo LETRACPTERELACIONADO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LETRACPTERELACIONADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PuntoDeVentaCpteRelacionado) = 'N' )
			lnLargoEntero  = len( transform( int( this.PUNTODEVENTACPTERELACIONADO ) ) ) 
			lnValorDelDecimal = this.PUNTODEVENTACPTERELACIONADO - int( this.PUNTODEVENTACPTERELACIONADO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTACPTERELACIONADO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTACPTERELACIONADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NumeroCpteRelacionado) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMEROCPTERELACIONADO ) ) ) 
			lnValorDelDecimal = this.NUMEROCPTERELACIONADO - int( this.NUMEROCPTERELACIONADO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMEROCPTERELACIONADO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMEROCPTERELACIONADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaCpteRelacionado) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHACPTERELACIONADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Deuda) = 'N' )
			lnLargoEntero  = len( transform( int( this.DEUDA ) ) ) 
			lnValorDelDecimal = this.DEUDA - int( this.DEUDA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo DEUDA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DEUDA no es el correcto.')
			llRetorno = .F.
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoNUEVO( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompLimitesDeConsumo.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompFacturacionElectronica.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompSenias.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompDatosAdicionalesComprobantesA.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompRegistroLiquidacionConsignaciones.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompPRECIOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompSTOCK.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompGIFTCARD.votarCambioEstadoNUEVO( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoELIMINAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompLimitesDeConsumo.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompFacturacionElectronica.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompSenias.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompDatosAdicionalesComprobantesA.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompRegistroLiquidacionConsignaciones.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompPRECIOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompSTOCK.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompGIFTCARD.votarCambioEstadoELIMINAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoMODIFICAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompLimitesDeConsumo.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompFacturacionElectronica.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompSenias.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompDatosAdicionalesComprobantesA.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompRegistroLiquidacionConsignaciones.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompPRECIOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompSTOCK.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompGIFTCARD.votarCambioEstadoMODIFICAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoCANCELAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompLimitesDeConsumo.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompFacturacionElectronica.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompSenias.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompDatosAdicionalesComprobantesA.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompRegistroLiquidacionConsignaciones.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompPRECIOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompSTOCK.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompGIFTCARD.votarCambioEstadoCANCELAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoGRABAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompLimitesDeConsumo.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompFacturacionElectronica.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompSenias.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompDatosAdicionalesComprobantesA.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompRegistroLiquidacionConsignaciones.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompPRECIOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompSTOCK.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompGIFTCARD.votarCambioEstadoGRABAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoANULAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompLimitesDeConsumo.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompFacturacionElectronica.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompSenias.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompDatosAdicionalesComprobantesA.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompRegistroLiquidacionConsignaciones.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompPRECIOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.KitsDetalle.oItem.oCompSTOCK.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompGIFTCARD.votarCambioEstadoANULAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarCaja() and llRetorno
			llRetorno = .ValidarSituacionfiscal() and llRetorno
			llRetorno = .ValidarSignodemovimiento() and llRetorno
			llRetorno = .ValidarCodigomotivodescuentoensubtotal() and llRetorno
			llRetorno = .ValidarMonedasistema() and llRetorno
			llRetorno = .ValidarIdvuelto() and llRetorno
			llRetorno = .ValidarCliente() and llRetorno
			llRetorno = .ValidarReceptor() and llRetorno
			llRetorno = .ValidarVendedor() and llRetorno
			llRetorno = .ValidarMonedacomprobante() and llRetorno
			llRetorno = .ValidarListadeprecios() and llRetorno
			llRetorno = .ValidarFecha() and llRetorno
			llRetorno = .ValidarCotizacion() and llRetorno
			llRetorno = .ValidacionAtributos() and llRetorno
			llRetorno = .ValidacionDetalles() and llRetorno
			llVotacion = .VotacionCambioEstadoGrabar( .ObtenerEstado() )
			if .VerificarContexto( 'CB' )
			else
				llRetorno = .ValidacionTimestamp() and llRetorno
			endif
		EndWith

		If Empty( this.CODIGO )
			llRetorno = .F.
			This.AgregarInformacion( 'No se puede grabar. Código Vacío', 0 )
		Endif
		if This.ValidarIngreso( transform( this.CODIGO ) )
		else
			llRetorno = .F.
			this.AgregarInformacion( 'Caracteres Inválidos en el código', 0 )
		EndIf
			return llRetorno and llVotacion

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionTimestamp() as Boolean
		Local lnTimestampactual as integer, llRetorno as boolean
		llRetorno = .T.
		if !this.EsNuevo() and this.EsEdicion()
			lnTimestampactual = this.oAd.ObtenerTimestampActual()
			if lnTimestampactual = this.Timestamp
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El registro fue modificado, no se pudo actualizar', this.ObtenerCodigoErrorParaValidacionTimestamp() )
			Endif
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionDetalles() as Boolean
		local llRetorno as boolean, llValAux as boolean
		llRetorno = dodefault()
		llRetorno = This.ValidarUnDetalle( this.FacturaDetalle, 'Artículos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ImpuestosDetalle, 'Impuestos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.COMPAFEC, 'COMPAFEC' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ImpuestosComprobante, 'Impuestos del comprobante' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ArticulosSeniadosDetalle, 'Artículos señados' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.KitsDetalle, 'Detalle de kits' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ValoresDetalle, 'Valores' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

		this.oCompLimitesDeConsumo.lNuevo = this.lNuevo
		this.oCompLimitesDeConsumo.lEdicion = this.lEdicion
		this.oCompLimitesDeConsumo.lEliminar = this.lEliminar

		this.oCompDescuentos.lNuevo = this.lNuevo
		this.oCompDescuentos.lEdicion = this.lEdicion
		this.oCompDescuentos.lEliminar = this.lEliminar

		this.oCompFacturacionElectronica.lNuevo = this.lNuevo
		this.oCompFacturacionElectronica.lEdicion = this.lEdicion
		this.oCompFacturacionElectronica.lEliminar = this.lEliminar

		this.oCompSenias.lNuevo = this.lNuevo
		this.oCompSenias.lEdicion = this.lEdicion
		this.oCompSenias.lEliminar = this.lEliminar

		this.oCompDatosAdicionalesComprobantesA.lNuevo = this.lNuevo
		this.oCompDatosAdicionalesComprobantesA.lEdicion = this.lEdicion
		this.oCompDatosAdicionalesComprobantesA.lEliminar = this.lEliminar

		this.oCompRegistroLiquidacionConsignaciones.lNuevo = this.lNuevo
		this.oCompRegistroLiquidacionConsignaciones.lEdicion = this.lEdicion
		this.oCompRegistroLiquidacionConsignaciones.lEliminar = this.lEliminar

		this.oCompKitDeArticulos.lNuevo = this.lNuevo
		this.oCompKitDeArticulos.lEdicion = this.lEdicion
		this.oCompKitDeArticulos.lEliminar = this.lEliminar

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function lHabilitarArticulosSeniadosDetalle_assign( txVal as variant ) as void
		this.lHabilitarArticulosSeniadosDetalle = txVal
		this.ArticulosSeniadosDetalle.habilitarItems( txVal )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function lHabilitarKitsDetalle_assign( txVal as variant ) as void
		this.lHabilitarKitsDetalle = txVal
		this.KitsDetalle.habilitarItems( txVal )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Validarsignodemovimiento() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.signodemovimiento )
			this.AgregarInformacion( 'Debe cargar el campo signodemovimiento', 9005, 'signodemovimiento' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFecha() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Fecha )
			this.AgregarInformacion( 'Debe cargar el campo Fecha', 9005, 'Fecha' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCotizacion() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Cotizacion )
			this.AgregarInformacion( 'Debe cargar el campo Cotización', 9005, 'Cotizacion' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCaja() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Caja_PK )
		else
			If this.Caja.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Caja_PK ))+ ' de la entidad ' +  upper( this.Caja.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarSituacionFiscal() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.SituacionFiscal_PK )
		else
			If this.SituacionFiscal.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.SituacionFiscal_PK ))+ ' de la entidad ' +  upper( this.SituacionFiscal.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCodigoMotivoDescuentoEnSubtotal() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CodigoMotivoDescuentoEnSubtotal_PK )
		else
			If this.CodigoMotivoDescuentoEnSubtotal.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CodigoMotivoDescuentoEnSubtotal_PK ))+ ' de la entidad ' +  upper( this.CodigoMotivoDescuentoEnSubtotal.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMonedaSistema() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MonedaSistema_PK )
		else
			If this.MonedaSistema.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MonedaSistema_PK ))+ ' de la entidad ' +  upper( this.MonedaSistema.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarIdVuelto() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.IdVuelto_PK )
		else
			If this.IdVuelto.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.IdVuelto_PK ))+ ' de la entidad ' +  upper( this.IdVuelto.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCliente() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Cliente_PK )
		else
			If this.Cliente.oAD.ConsultarPorClavePrimaria()
				This.Cliente.oDesactivador.ValidarEstadoActivacion( this.Cliente_PK , goLibrerias.Valorvacioseguntipo( vartype(this.Cliente_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Cliente_PK ))+ ' de la entidad ' +  upper( this.Cliente.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarReceptor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Receptor_PK )
		else
			If this.Receptor.oAD.ConsultarPorClavePrimaria()
				This.Receptor.oDesactivador.ValidarEstadoActivacion( this.Receptor_PK , goLibrerias.Valorvacioseguntipo( vartype(this.Receptor_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Receptor_PK ))+ ' de la entidad ' +  upper( this.Receptor.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarVendedor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Vendedor_PK )
		else
			If this.Vendedor.oAD.ConsultarPorClavePrimaria()
				This.Vendedor.oDesactivador.ValidarEstadoActivacion( this.Vendedor_PK , goLibrerias.Valorvacioseguntipo( vartype(this.Vendedor_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Vendedor_PK ))+ ' de la entidad ' +  upper( this.Vendedor.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMonedaComprobante() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MonedaComprobante_PK )
			this.AgregarInformacion( 'Debe cargar el campo Moneda', 9005, 'MonedaComprobante' )
			llRetorno = .F.
		else
			If this.MonedaComprobante.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MonedaComprobante_PK ))+ ' de la entidad ' +  upper( this.MonedaComprobante.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarListaDePrecios() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.ListaDePrecios_PK )
			this.AgregarInformacion( 'Debe cargar el campo Lista de precio', 9005, 'ListaDePrecios' )
			llRetorno = .F.
		else
			If this.ListaDePrecios.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.ListaDePrecios_PK ))+ ' de la entidad ' +  upper( this.ListaDePrecios.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Grabar() As Void
	Local llRetorno As Boolean, llValidar as boolean, ;
	loEx As Exception, loError As Exception, llNuevo as Boolean, llEdicion as Boolean, llErrorAlValidar as Boolean 

	llValidar = .F.
	This.LimpiarRegistrosDeActividadAlGrabar()
	

	With This
		llNuevo = .EsNuevo()
		llEdicion = .EsEdicion()
		if llNuevo or llEdicion
			try
				.lProcesando = .T.
				this.ActualizarProgressBar( 20 )
				.LimpiarInformacion()
				this.ActualizarProgressBar( 30 )
				local lcAgrupadorDeActividad as String
				lcAgrupadorDeActividad = '<GDA:' + sys( 2015 ) + '>'
				This.IniciarRegistroDeActividad( 'Grabar' )
				goServicios.RegistroDeActividad.HabilitarTrazaExtendidaMensajeria()
				This.IniciarRegistroDeActividadExtendido( 'AntesDeGrabar' )
				If .AntesDeGrabar()
					This.EstablecerTiemposEnRegistroDeActividadExtendido( 'AntesDeGrabar' )
					this.ActualizarProgressBar( 40 )
				try
					This.IniciarRegistroDeActividadExtendido( 'Validar' )
					llValidar = .Validar()
					This.EstablecerTiemposEnRegistroDeActividadExtendido( 'Validar' )
				Catch To loError
					llErrorAlValidar = .t.
					.ErrorAlValidar()
					This.EliminarRegistrosDeActividad()
					goServicios.Errores.LevantarExcepcion( loError )
				finally
					if !llErrorAlValidar and !llValidar
						.ErrorAlValidar()
					endif
				endtry
					this.ActualizarProgressBar( 60 )
					If llValidar
						try
							this.ActualizarProgressBar( 70 )
							.SetearComponentes()
							this.ActualizarProgressBar( 80 )
							if llNuevo
								This.IniciarRegistroDeActividadExtendido( 'oAD_Insertar' )
								this.EventoPorInsertar()
								lxCodigo = .oAD.Insertar()
								This.EstablecerTiemposEnRegistroDeActividadExtendido( 'oAD_Insertar' )
								
							else
								This.IniciarRegistroDeActividadExtendido( 'oAD_Actualizar' )
								.oAD.Actualizar()
								This.EstablecerTiemposEnRegistroDeActividadExtendido( 'oAD_Actualizar' )
							endif
							this.ActualizarProgressBar( 90 )
						Catch To loError
							This.EliminarRegistrosDeActividad()
							.ErrorAlGrabar()
							goServicios.Errores.LevantarExcepcion( loError )
						Finally
						EndTry
						This.IniciarRegistroDeActividadExtendido( 'DespuesDeGrabar' )
						Try
							llValidar = .DespuesDeGrabar()
						Catch to loError
							llValidar = .T.
							loEx = Newobject( 'ZooException', 'ZooException.prg' )
							loEx.Grabar( loError )
							This.oMensaje.Advertir( 'Se ha producido una excepción no controlada durante el proceso posterior a la grabación.Verifique el log de errores para mas detalles.')
						Finally
							.InformarWebHook()
						EndTry
						This.EstablecerTiemposEnRegistroDeActividadExtendido( 'DespuesDeGrabar' )
						Store .F. To .lEdicion , .lNuevo
						.actualizarEstado()
					endif
				endif
			Catch To loError
				This.EliminarRegistrosDeActividad()
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Grabar( loError )
					.Throw()
				EndWith
			finally
				.lProcesando = .F.
			EndTry
		else
			This.EliminarRegistrosDeActividad()
			local loEx as Object
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'Error al intentar Grabar'
				.Details = 'No se puede grabar sin estar en estado NUEVO o EDICION'
				.Grabar()
				.Throw()
			endwith
		endif
		
		If llValidar
			This.EstablecerTiemposEnRegistroDeActividad( 'Grabar' )
			goServicios.RegistroDeActividad.DeshabilitarTrazaExtendidaMensajeria()
			lcAgrupadorDeActividad = lcAgrupadorDeActividad + '<PK:' + transform( This.CODIGO ) + '>'
			This.FinalizarRegistrosDeActividad( lcAgrupadorDeActividad )
		else
			This.EliminarRegistrosDeActividad()
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			loEx.oInformacion = .ObtenerInformacion()
			loEx.Throw()
		Endif
		.RestaurarGenHabilitar()
	Endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _Nuevo() As Boolean

		if this.EsNuevo()
			goServicios.Errores.LevantarExcepcion( "Cancele o grabe antes de intentar hacer 'Nuevo'." )
		else
			With This

				Local llVotacion as boolean
				llVotacion = .VotacionCambioEstadoNuevo( .ObtenerEstado() )

				if llVotacion
				else
					goServicios.Errores.LevantarExcepcion( this.oInformacion )
				Endif

				.lEdicion = .F.
				.lAnular = .F.
				.lNuevo = .T.
				.limpiar()
				.Codigo = goLibrerias.ObtenerGuidPk() 
				.actualizarEstado()
				.SetearColeccionSentenciasAnterior_NUEVO()
			endwith
		endif

		dodefault()
		This.InicializarComponentes( .T. )

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Modificar() As void
		Local llValidacion as boolean, llVotacion as boolean, loEx as exception

		With This
			llValidacion = .ValidarPK()
			If llValidacion
				.Buscar()
				.Cargar()
					.InicializarComponentes()
				llVotacion = .VotacionCambioEstadoModificar( .ObtenerEstado() )
				if llVotacion
				else
					goServicios.Errores.LevantarExcepcion( this.oInformacion )
				Endif
				.SetearColeccionSentenciasAnterior_MODIFICAR()
				.lEdicion = .T.
				.lNuevo = .F.
				.lAnular = .F.
				*****Esta linea se genera solo para entidades anulables
				.Anulado = .F.
				.actualizarEstado()
			else
				loEx = _screen.zoo.crearObjeto( 'zooException' )
				loEx.oInformacion = this.oInformacion
				loEx.Throw()
			Endif
		Endwith

	dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected function _EliminarSinValidaciones() as Void
		Local llValidacion as boolean, llVotacion as boolean, loEx as exception
		llVotacion = .T.
		With This
			if .lEliminar
				llValidacion = .ValidarPK()
				If llValidacion
					.InicializarComponentes()
					llVotacion = .VotacionCambioEstadoEliminar( .ObtenerEstado() )
					if llVotacion
					else
						goServicios.Errores.LevantarExcepcion( this.oInformacion )
					Endif
				.SetearColeccionSentenciasAnterior_Eliminar()
					Store .F. To .lEdicion, .lNuevo
					.oAD.Eliminar()
					.actualizarEstado()
				else
					loEx = _screen.zoo.crearObjeto( 'zooException' )
					loEx.oInformacion = this.oInformacion
					loEx.throw()
				endif
			endif
		Endwith

	dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Cancelar() As void
		local loEx As zooException of zooException.prg 

		With This

			llVotacion = .VotacionCambioEstadoCancelar( .ObtenerEstado() )
			if llVotacion
			else
				goServicios.Errores.LevantarExcepcion( this.oInformacion )
			Endif
			Do Case
				case .lNuevo
					Store .F. To .lEdicion, .lNuevo
					.limpiar()

				case !.lNuevo and !.lEdicion
					loEx = Newobject( 'ZooException', 'ZooException.prg' )
					With loEx
						.Message = 'Error al intentar hacer cancelar'
						.Details = "Para hacer 'Cancelar' debe estar en modo Nuevo o Edicion"
						.Grabar()
						.Throw()
					endwith

				otherwise
					.Buscar()
					.Cargar()
					Store .F. To .lEdicion, .lNuevo

			EndCase
			.RestaurarGenHabilitar()
			.actualizarEstado()
		EndWith

		dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Anular() As void
		with this
			.buscar()
			.Cargar()
			if pemstatus( this, 'oCompEnBaseA', 5 )
				.ValidarComprobantesAfectantes( 'Anular' )
			endif
			.InicializarComponentes()
			if .VotacionCambioEstadoAnular( .ObtenerEstado() )
			else
				goServicios.Errores.LevantarExcepcion( this.oInformacion )
			endif
		endwith
	endfunc
			*-----------------------------------------------------------------------------------------
	function oNumeraciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.oNumeraciones ) = 'O' or isnull( this.oNumeraciones ) )
			this.oNumeraciones = this.CrearObjeto( 'Numeraciones' )
			this.oNumeraciones.Inicializar()
			this.oNumeraciones.SetearEntidad( this )
		endif
		return this.oNumeraciones
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		loAtributosObligatorios.add( 'SIGNODEMOVIMIENTO' )
		loAtributosObligatorios.add( 'CODIGO' )
		loAtributosObligatorios.add( 'MONEDACOMPROBANTE' )
		loAtributosObligatorios.add( 'LISTADEPRECIOS' )
		loAtributosObligatorios.add( 'FECHA' )
		loAtributosObligatorios.add( 'COTIZACION' )
		return loAtributosObligatorios

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Buscar() As void
		local llRetorno as Boolean, loEx as Exception, lcAtributo as String, lcMensaje as String

		lcAtributo = This.ObtenerAtributoClavePrimaria()
		if empty( This.&lcAtributo )
			llRetorno = this.oAD.ConsultarPorClaveCandidata()
			lcMensaje = 'El dato buscado TIPO DE COMPROBANTE ' + transform( This.TipoComprobante ) + ', LETRA DE COMPROBANTE ' + transform( This.Letra ) + ', PTO. VENTA ' + transform( This.PuntoDeVenta ) + ', NÚMERO ' + transform( This.Numero ) + ', SECUENCIA ' + transform( This.Secuencia ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
		else
			llRetorno = this.oAD.ConsultarPorClavePrimaria()
			lcMensaje = 'El dato buscado ' + alltrim( transform( This.CODIGO ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
		endif
		if llRetorno
		else
			goServicios.Errores.LevantarExcepcion( lcMensaje )
		endif
	endfunc	
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_NUEVO() as Void
	
		dodefault()
		this.oCompLimitesDeConsumo.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompFacturacionElectronica.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompSenias.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompDatosAdicionalesComprobantesA.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompRegistroLiquidacionConsignaciones.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_NUEVO()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_NUEVO()
		this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_NUEVO()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompLimitesDeConsumo.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompFacturacionElectronica.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompSenias.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompDatosAdicionalesComprobantesA.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompRegistroLiquidacionConsignaciones.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompLimitesDeConsumo.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompFacturacionElectronica.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompSenias.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompDatosAdicionalesComprobantesA.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompRegistroLiquidacionConsignaciones.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ANULAR()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_ANULAR()
		this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ANULAR()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompLimitesDeConsumo.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompFacturacionElectronica.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompSenias.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompDatosAdicionalesComprobantesA.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompRegistroLiquidacionConsignaciones.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.ArticulosSeniadosDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<ANULABLE><WEBHOOK><CAI><VENTAS><CONVALORES><FISCAL><NOLISTAGENERICO><VALIDACENTRALIZADOR><VALORCIERRE><DESCUENTOAUTOMATICO><ACTUALIZAEMAILCLIENTE><MIPYME:55><AGRUPACOMPROBANTES:3;5;28><MIPYMEORIGINAL:28><CF>'
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		return this.oAd.ObtenerIdPorClaveCandidata()
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .T.
		this.oAtributosCC = _screen.zoo.crearobjeto( 'ZooColeccion' )
		this.oAtributosCC.add( "TipoComprobante" )
		this.oAtributosCC.add( "Letra" )
		this.oAtributosCC.add( "PuntoDeVenta" )
		this.oAtributosCC.add( "Numero" )
		this.oAtributosCC.add( "Secuencia" )
		this.oProveedorAtributosAnulacion = newobject( "din_entidadNOTADECREDITOAGRUPADAAtributosAnulacion", "din_entidadNOTADECREDITOAGRUPADAAtributosAnulacion.prg" )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechaaltafw()','Fechaaltafw')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWHoraaltafw()','Horaaltafw')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSituacionfiscal()','Situacionfiscal')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSignodemovimiento()','Signodemovimiento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIdvuelto()','Idvuelto')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTurno()','Turno')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTipocomprobante()','Tipocomprobante')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWListadeprecios()','Listadeprecios')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechavencimientomipyme()','Fechavencimientomipyme')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIvadelsistema()','Ivadelsistema')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'NOTADECREDITOAGRUPADA', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
		this.lWHIngresar = goServicios.WebHook.TieneQueMandar( 'NOTADECREDITOAGRUPADA', 'INGRESAR' )
		this.lWHModificar = goServicios.WebHook.TieneQueMandar( 'NOTADECREDITOAGRUPADA', 'MODIFICAR' )
		this.lWHEliminar = goServicios.WebHook.TieneQueMandar( 'NOTADECREDITOAGRUPADA', 'ELIMINAR' )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Caja_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Caja_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Caja_PK = lxVal

		if this.Validar_Caja( lxVal, lxValOld )
			if ( this.lHabilitarCaja_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Caja( lxVal )
			else
				this.Caja_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito - Atributo: Caja)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Situacionfiscal_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Situacionfiscal_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Situacionfiscal_PK = lxVal

		if this.Validar_Situacionfiscal( lxVal, lxValOld )
			This.Setear_Situacionfiscal( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigomotivodescuentoensubtotal_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigomotivodescuentoensubtotal_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Codigomotivodescuentoensubtotal_PK = lxVal

		if this.Validar_Codigomotivodescuentoensubtotal( lxVal, lxValOld )
			This.Setear_Codigomotivodescuentoensubtotal( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedasistema_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monedasistema_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Monedasistema_PK = lxVal

		if this.Validar_Monedasistema( lxVal, lxValOld )
			This.Setear_Monedasistema( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idvuelto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idvuelto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Idvuelto_PK = lxVal

		if this.Validar_Idvuelto( lxVal, lxValOld )
			This.Setear_Idvuelto( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Cliente.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Cliente_PK = lxVal

		if this.Validar_Cliente( lxVal, lxValOld )
			if ( this.lHabilitarCliente_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Cliente( lxVal )
				This.Cliente_PK_DespuesDeAsignar()
			If lxValOld != lxVal or empty( this.Cuit ) 
				this.Cuit = This.Cliente.cuit
			endif
			If lxValOld != lxVal or empty( this.Clientedescripcion ) 
				this.Clientedescripcion = This.Cliente.Nombre
			endif
			else
				this.Cliente_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito - Atributo: Cliente)" )
			endif 
			If lxValOld != lxVal and alltrim( lxVal ) != ''
				this.EventoActualizarEmail()
			endif
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Receptor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Receptor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Receptor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Receptor )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Receptor_PK = lxVal

		if this.Validar_Receptor( lxVal, lxValOld )
			This.Setear_Receptor( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Vendedor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Vendedor )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Vendedor_PK = lxVal

		if this.Validar_Vendedor( lxVal, lxValOld )
			this.ValidarDominio_Codigovendedor( lxVal )
			This.Setear_Vendedor( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monedacomprobante_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Monedacomprobante_PK = lxVal

		if this.Validar_Monedacomprobante( lxVal, lxValOld )
			if ( this.lHabilitarMonedacomprobante_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Monedacomprobante( lxVal )
			else
				this.Monedacomprobante_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito - Atributo: Monedacomprobante)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Listadeprecios_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Listadeprecios_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Listadeprecios_PK = lxVal

		if this.Validar_Listadeprecios( lxVal, lxValOld )
			This.Setear_Listadeprecios( lxVal )
			If lxValOld != lxVal or empty( this.Condicioniva ) 
				this.Condicioniva = This.ListaDePrecios.CondicionIva
			endif
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Caja( txVal as variant ) as void

		this.Caja.ID = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Situacionfiscal( txVal as variant ) as void

		this.Situacionfiscal.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigomotivodescuentoensubtotal( txVal as variant ) as void

		this.Codigomotivodescuentoensubtotal.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monedasistema( txVal as variant ) as void

		this.Monedasistema.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idvuelto( txVal as variant ) as void

		this.Idvuelto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Receptor( txVal as variant ) as void

		this.Receptor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monedacomprobante( txVal as variant ) as void

		this.Monedacomprobante.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Listadeprecios( txVal as variant ) as void

		this.Listadeprecios.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Caja( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Situacionfiscal( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigomotivodescuentoensubtotal( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monedasistema( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idvuelto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Receptor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Receptor.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Vendedor.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monedacomprobante( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Listadeprecios( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechamodificacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechamodificacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechamodificacion( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechamodificacion( lxVal )
			EndIf
		Else
			This.Setear_Fechamodificacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fueinformadoalanube_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fueinformadoalanube
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fueinformadoalanube( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fueinformadoalanube( lxVal )
			EndIf
		Else
			This.Setear_Fueinformadoalanube( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechatransferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechatransferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechatransferencia( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechatransferencia( lxVal )
			EndIf
		Else
			This.Setear_Fechatransferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechamodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechamodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechamodificacionfw( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechamodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Fechamodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechavtocai_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavtocai
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavtocai( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechavtocai( lxVal )
			EndIf
		Else
			This.Setear_Fechavtocai( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaimpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaimpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaimpo( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaimpo( lxVal )
			EndIf
		Else
			This.Setear_Fechaimpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaexpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaexpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaexpo( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaexpo( lxVal )
			EndIf
		Else
			This.Setear_Fechaexpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuit_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuit
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuit( lxVal )
				this.Setear_Cuit( lxVal )
			EndIf
		Else
			This.Setear_Cuit( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigoajuste_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigoajuste
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigoajuste( lxVal )
				this.Setear_Codigoajuste( lxVal )
			EndIf
		Else
			This.Setear_Codigoajuste( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaaltafw( lxVal )
				this.Setear_Fechaaltafw( lxVal )
			EndIf
		Else
			This.Setear_Fechaaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nroopecommerce_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nroopecommerce
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nroopecommerce( lxVal )
				this.Setear_Nroopecommerce( lxVal )
			EndIf
		Else
			This.Setear_Nroopecommerce( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaaltafw( lxVal )
				this.Setear_Horaaltafw( lxVal )
			EndIf
		Else
			This.Setear_Horaaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadotransferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadotransferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadotransferencia( lxVal )
				this.Setear_Estadotransferencia( lxVal )
			EndIf
		Else
			This.Setear_Estadotransferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosaltafw( lxVal )
				this.Setear_Basededatosaltafw( lxVal )
			EndIf
		Else
			This.Setear_Basededatosaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigobarraautoimpresor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigobarraautoimpresor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigobarraautoimpresor( lxVal )
				this.Setear_Codigobarraautoimpresor( lxVal )
			EndIf
		Else
			This.Setear_Codigobarraautoimpresor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Zadsfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Zadsfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Zadsfw( lxVal )
				this.Setear_Zadsfw( lxVal )
			EndIf
		Else
			This.Setear_Zadsfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Hora_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Hora
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Hora( lxVal )
				this.Setear_Hora( lxVal )
			EndIf
		Else
			This.Setear_Hora( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosmodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosmodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosmodificacionfw( lxVal )
				this.Setear_Basededatosmodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Basededatosmodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Versionmodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Versionmodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Versionmodificacionfw( lxVal )
				this.Setear_Versionmodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Versionmodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Versionaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Versionaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Versionaltafw( lxVal )
				this.Setear_Versionaltafw( lxVal )
			EndIf
		Else
			This.Setear_Versionaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descripcionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descripcionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descripcionfw( lxVal )
				this.Setear_Descripcionfw( lxVal )
			EndIf
		Else
			This.Setear_Descripcionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuariomodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuariomodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuariomodificacionfw( lxVal )
				this.Setear_Usuariomodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Usuariomodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Simbolomonetariocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Simbolomonetariocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Simbolomonetariocomprobante( lxVal )
				this.Setear_Simbolomonetariocomprobante( lxVal )
			EndIf
		Else
			This.Setear_Simbolomonetariocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuarioaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuarioaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuarioaltafw( lxVal )
				this.Setear_Usuarioaltafw( lxVal )
			EndIf
		Else
			This.Setear_Usuarioaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaimpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaimpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaimpo( lxVal )
				this.Setear_Horaimpo( lxVal )
			EndIf
		Else
			This.Setear_Horaimpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horamodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horamodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horamodificacionfw( lxVal )
				this.Setear_Horamodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Horamodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriealtafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriealtafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriealtafw( lxVal )
				this.Setear_Seriealtafw( lxVal )
			EndIf
		Else
			This.Setear_Seriealtafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriemodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriemodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriemodificacionfw( lxVal )
				this.Setear_Seriemodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Seriemodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaexpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaexpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaexpo( lxVal )
				this.Setear_Horaexpo( lxVal )
			EndIf
		Else
			This.Setear_Horaexpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Timestamp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Timestamp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Timestamp( lxVal )
				this.Setear_Timestamp( lxVal )
			EndIf
		Else
			This.Setear_Timestamp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cai_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cai
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cai( lxVal )
				this.Setear_Cai( lxVal )
			EndIf
		Else
			This.Setear_Cai( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Secuencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Secuencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Secuencia( lxVal )
				this.Setear_Secuencia( lxVal )
			EndIf
		Else
			This.Setear_Secuencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalcantidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalcantidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalcantidad( lxVal )
				this.Setear_Totalcantidad( lxVal )
			EndIf
		Else
			This.Setear_Totalcantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedescuento2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedescuento2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedescuento2( lxVal )
				this.Setear_Porcentajedescuento2( lxVal )
			EndIf
		Else
			This.Setear_Porcentajedescuento2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomontosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontosinimpuestos( lxVal )
				this.Setear_Recargomontosinimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Recargomontosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotalsinimpuestossobreitems_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotalsinimpuestossobreitems
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotalsinimpuestossobreitems( lxVal )
				this.Setear_Subtotalsinimpuestossobreitems( lxVal )
			EndIf
		Else
			This.Setear_Subtotalsinimpuestossobreitems( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotalbruto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotalbruto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotalbruto( lxVal )
				this.Setear_Subtotalbruto( lxVal )
			EndIf
		Else
			This.Setear_Subtotalbruto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Signodemovimiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Signodemovimiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Signodemovimiento( lxVal )
				this.Setear_Signodemovimiento( lxVal )
			EndIf
		Else
			This.Setear_Signodemovimiento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotalneto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotalneto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotalneto( lxVal )
				this.Setear_Subtotalneto( lxVal )
			EndIf
		Else
			This.Setear_Subtotalneto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotalconimpuestossobreitems_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotalconimpuestossobreitems
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotalconimpuestossobreitems( lxVal )
				this.Setear_Subtotalconimpuestossobreitems( lxVal )
			EndIf
		Else
			This.Setear_Subtotalconimpuestossobreitems( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Condicioniva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Condicioniva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Condicioniva( lxVal )
				this.Setear_Condicioniva( lxVal )
			EndIf
		Else
			This.Setear_Condicioniva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomontosinimpuestos1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontosinimpuestos1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontosinimpuestos1( lxVal )
				this.Setear_Recargomontosinimpuestos1( lxVal )
			EndIf
		Else
			This.Setear_Recargomontosinimpuestos1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomontosinimpuestos2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontosinimpuestos2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontosinimpuestos2( lxVal )
				this.Setear_Recargomontosinimpuestos2( lxVal )
			EndIf
		Else
			This.Setear_Recargomontosinimpuestos2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentosinimpuestos3_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentosinimpuestos3
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentosinimpuestos3( lxVal )
				this.Setear_Montodescuentosinimpuestos3( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos3( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentoconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentoconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentoconimpuestos( lxVal )
				this.Setear_Montodescuentoconimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ajustesporredondeos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ajustesporredondeos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ajustesporredondeos( lxVal )
				this.Setear_Ajustesporredondeos( lxVal )
			EndIf
		Else
			This.Setear_Ajustesporredondeos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentosinimpuestos2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentosinimpuestos2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentosinimpuestos2( lxVal )
				this.Setear_Montodescuentosinimpuestos2( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentosinimpuestos( lxVal )
				this.Setear_Montodescuentosinimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentosinimpuestos1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentosinimpuestos1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentosinimpuestos1( lxVal )
				this.Setear_Montodescuentosinimpuestos1( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Anulado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Anulado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Anulado( lxVal )
				this.Setear_Anulado( lxVal )
			EndIf
		Else
			This.Setear_Anulado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentoautomatico_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuentoautomatico
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuentoautomatico( lxVal )
				this.Setear_Descuentoautomatico( lxVal )
			EndIf
		Else
			This.Setear_Descuentoautomatico( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basadoencomprobanteonline_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basadoencomprobanteonline
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basadoencomprobanteonline( lxVal )
				this.Setear_Basadoencomprobanteonline( lxVal )
			EndIf
		Else
			This.Setear_Basadoencomprobanteonline( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobantefiscal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobantefiscal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobantefiscal( lxVal )
				this.Setear_Comprobantefiscal( lxVal )
			EndIf
		Else
			This.Setear_Comprobantefiscal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Obs_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Obs
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Obs( lxVal )
				this.Setear_Obs( lxVal )
			EndIf
		Else
			This.Setear_Obs( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedescuento1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedescuento1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedescuento1( lxVal )
				this.Setear_Porcentajedescuento1( lxVal )
			EndIf
		Else
			This.Setear_Porcentajedescuento1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Turno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Turno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Turno( lxVal )
				this.Setear_Turno( lxVal )
			EndIf
		Else
			This.Setear_Turno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idsenia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idsenia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idsenia( lxVal )
				this.Setear_Idsenia( lxVal )
			EndIf
		Else
			This.Setear_Idsenia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentoconimpuestos2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentoconimpuestos2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentoconimpuestos2( lxVal )
				this.Setear_Montodescuentoconimpuestos2( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipocomprobante( lxVal )
				if ( this.lHabilitarTipocomprobante or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Tipocomprobante( lxVal )
				else
					this.Tipocomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito - Atributo: Tipocomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Tipocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuento1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuento1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuento1( lxVal )
				this.Setear_Montodescuento1( lxVal )
			EndIf
		Else
			This.Setear_Montodescuento1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentoconimpuestos1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentoconimpuestos1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentoconimpuestos1( lxVal )
				this.Setear_Montodescuentoconimpuestos1( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedescripcion( lxVal )
				this.Setear_Clientedescripcion( lxVal )
			EndIf
		Else
			This.Setear_Clientedescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigobarracae_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigobarracae
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigobarracae( lxVal )
				this.Setear_Codigobarracae( lxVal )
			EndIf
		Else
			This.Setear_Codigobarracae( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Letra_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letra
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letra( lxVal )
				this.Setear_Letra( lxVal )
				if !empty( lxVal ) and this.esNuevo()
					if this.VerificarContexto( 'CB' )
					else
						this.lCargando = .t.

						local loError as exception
						try
							this.NUMERO = this.oNumeraciones.ObtenerNumero('NUMERO')
						catch to loError
							local loEx as Object
							loEx = Newobject( 'ZooException', 'ZooException.prg' )
							With loEx
								.Grabar( loError )
								.Throw()
							endwith
						finally
							this.lCargando = .f.
						endtry
					endif
				endif
			EndIf
		Else
			This.Setear_Letra( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechavtosenia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavtosenia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavtosenia( lxVal )
				if ( this.lHabilitarFechavtosenia or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fechacalendario( lxVal )
					this.Setear_Fechavtosenia( lxVal )
				else
					this.Fechavtosenia = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito - Atributo: Fechavtosenia)" )
				endif 
			EndIf
		Else
			This.Setear_Fechavtosenia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalrecargosconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalrecargosconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalrecargosconimpuestos( lxVal )
				this.Setear_Totalrecargosconimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Totalrecargosconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalrecargossinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalrecargossinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalrecargossinimpuestos( lxVal )
				this.Setear_Totalrecargossinimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Totalrecargossinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Puntodeventa_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventa
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventa( lxVal )
				this.Setear_Puntodeventa( lxVal )
				if !empty( lxVal ) and this.esNuevo()
					if this.VerificarContexto( 'CB' )
					else
						this.lCargando = .t.

						local loError as exception
						try
							this.NUMERO = this.oNumeraciones.ObtenerNumero('NUMERO')
						catch to loError
							local loEx as Object
							loEx = Newobject( 'ZooException', 'ZooException.prg' )
							With loEx
								.Grabar( loError )
								.Throw()
							endwith
						finally
							this.lCargando = .f.
						endtry
					endif
				endif
			EndIf
		Else
			This.Setear_Puntodeventa( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numero_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numero
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numero( lxVal )
				this.Setear_Numero( lxVal )
			EndIf
		Else
			This.Setear_Numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Email_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Email
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Email( lxVal )
				this.ValidarDominio_Mail( lxVal )
				this.Setear_Email( lxVal )
			EndIf
		Else
			This.Setear_Email( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Total_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Total
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Total( lxVal )
				this.Setear_Total( lxVal )
			EndIf
		Else
			This.Setear_Total( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totaldescuentosconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totaldescuentosconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totaldescuentosconimpuestos( lxVal )
				this.Setear_Totaldescuentosconimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Totaldescuentosconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totaldescuentossinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totaldescuentossinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totaldescuentossinimpuestos( lxVal )
				this.Setear_Totaldescuentossinimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Totaldescuentossinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha( lxVal )
				this.ValidarDominio_Fechasaldo( lxVal )
				this.Setear_Fecha( lxVal )
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cotizacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cotizacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cotizacion( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.Setear_Cotizacion( lxVal )
			EndIf
		Else
			This.Setear_Cotizacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentoconimpuestos3_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentoconimpuestos3
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentoconimpuestos3( lxVal )
				this.Setear_Montodescuentoconimpuestos3( lxVal )
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos3( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cae_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cae
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cae( lxVal )
				this.Setear_Cae( lxVal )
			EndIf
		Else
			This.Setear_Cae( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedescuento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedescuento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedescuento( lxVal )
				this.Setear_Porcentajedescuento( lxVal )
			EndIf
		Else
			This.Setear_Porcentajedescuento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomontoconimpuestos2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontoconimpuestos2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontoconimpuestos2( lxVal )
				this.Setear_Recargomontoconimpuestos2( lxVal )
			EndIf
		Else
			This.Setear_Recargomontoconimpuestos2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vueltovirtual_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vueltovirtual
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vueltovirtual( lxVal )
				this.Setear_Vueltovirtual( lxVal )
			EndIf
		Else
			This.Setear_Vueltovirtual( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vuelto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vuelto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vuelto( lxVal )
				this.Setear_Vuelto( lxVal )
			EndIf
		Else
			This.Setear_Vuelto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechavencimientocae_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavencimientocae
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavencimientocae( lxVal )
				this.Setear_Fechavencimientocae( lxVal )
			EndIf
		Else
			This.Setear_Fechavencimientocae( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechavencimientomipyme_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavencimientomipyme
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavencimientomipyme( lxVal )
				this.Setear_Fechavencimientomipyme( lxVal )
			EndIf
		Else
			This.Setear_Fechavencimientomipyme( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuento( lxVal )
				this.Setear_Descuento( lxVal )
			EndIf
		Else
			This.Setear_Descuento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entregaposteriorvirtual_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entregaposteriorvirtual
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entregaposteriorvirtual( lxVal )
				this.Setear_Entregaposteriorvirtual( lxVal )
			EndIf
		Else
			This.Setear_Entregaposteriorvirtual( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entregaposterior_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entregaposterior
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entregaposterior( lxVal )
				this.Setear_Entregaposterior( lxVal )
			EndIf
		Else
			This.Setear_Entregaposterior( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuento3_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuento3
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuento3( lxVal )
				this.Setear_Montodescuento3( lxVal )
			EndIf
		Else
			This.Setear_Montodescuento3( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Percepciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Percepciones( lxVal )
				this.Setear_Percepciones( lxVal )
			EndIf
		Else
			This.Setear_Percepciones( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomontoconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontoconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontoconimpuestos( lxVal )
				this.Setear_Recargomontoconimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Recargomontoconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargoporcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargoporcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargoporcentaje( lxVal )
				this.Setear_Recargoporcentaje( lxVal )
			EndIf
		Else
			This.Setear_Recargoporcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomonto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomonto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomonto( lxVal )
				this.Setear_Recargomonto( lxVal )
			EndIf
		Else
			This.Setear_Recargomonto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomonto2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomonto2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomonto2( lxVal )
				this.Setear_Recargomonto2( lxVal )
			EndIf
		Else
			This.Setear_Recargomonto2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuento2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuento2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuento2( lxVal )
				this.Setear_Montodescuento2( lxVal )
			EndIf
		Else
			This.Setear_Montodescuento2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuento2visual_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuento2visual
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuento2visual( lxVal )
				this.Setear_Montodescuento2visual( lxVal )
			EndIf
		Else
			This.Setear_Montodescuento2visual( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomonto1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomonto1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomonto1( lxVal )
				this.Setear_Recargomonto1( lxVal )
			EndIf
		Else
			This.Setear_Recargomonto1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomonto1visual_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomonto1visual
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomonto1visual( lxVal )
				this.Setear_Recargomonto1visual( lxVal )
			EndIf
		Else
			This.Setear_Recargomonto1visual( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomontoconimpuestos1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontoconimpuestos1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontoconimpuestos1( lxVal )
				this.Setear_Recargomontoconimpuestos1( lxVal )
			EndIf
		Else
			This.Setear_Recargomontoconimpuestos1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotalsinimp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotalsinimp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotalsinimp( lxVal )
				this.Setear_Subtotalsinimp( lxVal )
			EndIf
		Else
			This.Setear_Subtotalsinimp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Gravamenes_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Gravamenes
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Gravamenes( lxVal )
				this.Setear_Gravamenes( lxVal )
			EndIf
		Else
			This.Setear_Gravamenes( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Impuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Impuestos( lxVal )
				this.Setear_Impuestos( lxVal )
			EndIf
		Else
			This.Setear_Impuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotalconimp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotalconimp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotalconimp( lxVal )
				this.Setear_Subtotalconimp( lxVal )
			EndIf
		Else
			This.Setear_Subtotalconimp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalrecargos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalrecargos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalrecargos( lxVal )
				this.Setear_Totalrecargos( lxVal )
			EndIf
		Else
			This.Setear_Totalrecargos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totaldescuentos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totaldescuentos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totaldescuentos( lxVal )
				this.Setear_Totaldescuentos( lxVal )
			EndIf
		Else
			This.Setear_Totaldescuentos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Chequereintegro_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Chequereintegro
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Chequereintegro( lxVal )
				this.Setear_Chequereintegro( lxVal )
			EndIf
		Else
			This.Setear_Chequereintegro( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalimpuestos( lxVal )
				this.Setear_Totalimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Totalimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Mercaderiaconsignacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Mercaderiaconsignacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Mercaderiaconsignacion( lxVal )
				this.Setear_Mercaderiaconsignacion( lxVal )
			EndIf
		Else
			This.Setear_Mercaderiaconsignacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Accioncancelatoria_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Accioncancelatoria
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Accioncancelatoria( lxVal )
				this.Setear_Accioncancelatoria( lxVal )
			EndIf
		Else
			This.Setear_Accioncancelatoria( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ivadelsistema_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ivadelsistema
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ivadelsistema( lxVal )
				this.Setear_Ivadelsistema( lxVal )
			EndIf
		Else
			This.Setear_Ivadelsistema( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipocpterelacionado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipocpterelacionado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipocpterelacionado( lxVal )
				this.Setear_Tipocpterelacionado( lxVal )
			EndIf
		Else
			This.Setear_Tipocpterelacionado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Letracpterelacionado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letracpterelacionado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letracpterelacionado( lxVal )
				this.Setear_Letracpterelacionado( lxVal )
			EndIf
		Else
			This.Setear_Letracpterelacionado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Puntodeventacpterelacionado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventacpterelacionado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventacpterelacionado( lxVal )
				this.Setear_Puntodeventacpterelacionado( lxVal )
			EndIf
		Else
			This.Setear_Puntodeventacpterelacionado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerocpterelacionado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerocpterelacionado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerocpterelacionado( lxVal )
				this.Setear_Numerocpterelacionado( lxVal )
			EndIf
		Else
			This.Setear_Numerocpterelacionado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechacpterelacionado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechacpterelacionado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechacpterelacionado( lxVal )
				this.Setear_Fechacpterelacionado( lxVal )
			EndIf
		Else
			This.Setear_Fechacpterelacionado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Deuda_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Deuda
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Deuda( lxVal )
				this.ValidarDominio_Fechasaldo( lxVal )
				this.Setear_Deuda( lxVal )
			EndIf
		Else
			This.Setear_Deuda( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacion( txVal as variant ) as void

		this.Fechamodificacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fueinformadoalanube( txVal as variant ) as void

		this.Fueinformadoalanube = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavtocai( txVal as variant ) as void

		this.Fechavtocai = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaimpo( txVal as variant ) as void

		this.Fechaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuit( txVal as variant ) as void

		this.Cuit = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoajuste( txVal as variant ) as void

		this.Codigoajuste = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroopecommerce( txVal as variant ) as void

		this.Nroopecommerce = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigobarraautoimpresor( txVal as variant ) as void

		this.Codigobarraautoimpresor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Hora( txVal as variant ) as void

		this.Hora = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionaltafw( txVal as variant ) as void

		this.Versionaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcionfw( txVal as variant ) as void

		this.Descripcionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Simbolomonetariocomprobante( txVal as variant ) as void

		this.Simbolomonetariocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cai( txVal as variant ) as void

		this.Cai = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Secuencia( txVal as variant ) as void

		this.Secuencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalcantidad( txVal as variant ) as void

		this.Totalcantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedescuento2( txVal as variant ) as void

		this.Porcentajedescuento2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos( txVal as variant ) as void

		this.Recargomontosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalsinimpuestossobreitems( txVal as variant ) as void

		this.Subtotalsinimpuestossobreitems = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalbruto( txVal as variant ) as void

		this.Subtotalbruto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Signodemovimiento( txVal as variant ) as void

		this.Signodemovimiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalneto( txVal as variant ) as void

		this.Subtotalneto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalconimpuestossobreitems( txVal as variant ) as void

		this.Subtotalconimpuestossobreitems = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Condicioniva( txVal as variant ) as void

		this.Condicioniva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos1( txVal as variant ) as void

		this.Recargomontosinimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos2( txVal as variant ) as void

		this.Recargomontosinimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos3( txVal as variant ) as void

		this.Montodescuentosinimpuestos3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos( txVal as variant ) as void

		this.Montodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajustesporredondeos( txVal as variant ) as void

		this.Ajustesporredondeos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos2( txVal as variant ) as void

		this.Montodescuentosinimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos( txVal as variant ) as void

		this.Montodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos1( txVal as variant ) as void

		this.Montodescuentosinimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anulado( txVal as variant ) as void

		this.Anulado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuentoautomatico( txVal as variant ) as void

		this.Descuentoautomatico = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basadoencomprobanteonline( txVal as variant ) as void

		this.Basadoencomprobanteonline = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobantefiscal( txVal as variant ) as void

		this.Comprobantefiscal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Obs( txVal as variant ) as void

		this.Obs = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedescuento1( txVal as variant ) as void

		this.Porcentajedescuento1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Turno( txVal as variant ) as void

		this.Turno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idsenia( txVal as variant ) as void

		this.Idsenia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos2( txVal as variant ) as void

		this.Montodescuentoconimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento1( txVal as variant ) as void

		this.Montodescuento1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos1( txVal as variant ) as void

		this.Montodescuentoconimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigobarracae( txVal as variant ) as void

		this.Codigobarracae = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavtosenia( txVal as variant ) as void

		this.Fechavtosenia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalrecargosconimpuestos( txVal as variant ) as void

		this.Totalrecargosconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalrecargossinimpuestos( txVal as variant ) as void

		this.Totalrecargossinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Email( txVal as variant ) as void

		this.Email = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totaldescuentosconimpuestos( txVal as variant ) as void

		this.Totaldescuentosconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totaldescuentossinimpuestos( txVal as variant ) as void

		this.Totaldescuentossinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cotizacion( txVal as variant ) as void

		this.Cotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos3( txVal as variant ) as void

		this.Montodescuentoconimpuestos3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cae( txVal as variant ) as void

		this.Cae = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedescuento( txVal as variant ) as void

		this.Porcentajedescuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos2( txVal as variant ) as void

		this.Recargomontoconimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vueltovirtual( txVal as variant ) as void

		this.Vueltovirtual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vuelto( txVal as variant ) as void

		this.Vuelto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavencimientocae( txVal as variant ) as void

		this.Fechavencimientocae = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavencimientomipyme( txVal as variant ) as void

		this.Fechavencimientomipyme = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuento( txVal as variant ) as void

		this.Descuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entregaposteriorvirtual( txVal as variant ) as void

		this.Entregaposteriorvirtual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entregaposterior( txVal as variant ) as void

		this.Entregaposterior = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento3( txVal as variant ) as void

		this.Montodescuento3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Percepciones( txVal as variant ) as void

		this.Percepciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos( txVal as variant ) as void

		this.Recargomontoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargoporcentaje( txVal as variant ) as void

		this.Recargoporcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomonto( txVal as variant ) as void

		this.Recargomonto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomonto2( txVal as variant ) as void

		this.Recargomonto2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento2( txVal as variant ) as void

		this.Montodescuento2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento2visual( txVal as variant ) as void

		this.Montodescuento2visual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomonto1( txVal as variant ) as void

		this.Recargomonto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomonto1visual( txVal as variant ) as void

		this.Recargomonto1visual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos1( txVal as variant ) as void

		this.Recargomontoconimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalsinimp( txVal as variant ) as void

		this.Subtotalsinimp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Gravamenes( txVal as variant ) as void

		this.Gravamenes = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Impuestos( txVal as variant ) as void

		this.Impuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalconimp( txVal as variant ) as void

		this.Subtotalconimp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalrecargos( txVal as variant ) as void

		this.Totalrecargos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totaldescuentos( txVal as variant ) as void

		this.Totaldescuentos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Chequereintegro( txVal as variant ) as void

		this.Chequereintegro = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalimpuestos( txVal as variant ) as void

		this.Totalimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Mercaderiaconsignacion( txVal as variant ) as void

		this.Mercaderiaconsignacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Accioncancelatoria( txVal as variant ) as void

		this.Accioncancelatoria = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ivadelsistema( txVal as variant ) as void

		this.Ivadelsistema = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocpterelacionado( txVal as variant ) as void

		this.Tipocpterelacionado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letracpterelacionado( txVal as variant ) as void

		this.Letracpterelacionado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventacpterelacionado( txVal as variant ) as void

		this.Puntodeventacpterelacionado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocpterelacionado( txVal as variant ) as void

		this.Numerocpterelacionado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechacpterelacionado( txVal as variant ) as void

		this.Fechacpterelacionado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Deuda( txVal as variant ) as void

		this.Deuda = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fueinformadoalanube( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavtocai( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuit( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoajuste( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroopecommerce( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigobarraautoimpresor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Hora( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Simbolomonetariocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cai( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Secuencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalcantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedescuento2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalsinimpuestossobreitems( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalbruto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Signodemovimiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalneto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalconimpuestossobreitems( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Condicioniva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajustesporredondeos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anulado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentoautomatico( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basadoencomprobanteonline( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobantefiscal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Obs( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedescuento1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Turno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idsenia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigobarracae( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavtosenia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalrecargosconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalrecargossinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Email( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totaldescuentosconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totaldescuentossinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cae( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedescuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vueltovirtual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vuelto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavencimientocae( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavencimientomipyme( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entregaposteriorvirtual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entregaposterior( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Percepciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargoporcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento2visual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto1visual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalsinimp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Gravamenes( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Impuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalconimp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalrecargos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totaldescuentos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Chequereintegro( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Mercaderiaconsignacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Accioncancelatoria( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ivadelsistema( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocpterelacionado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letracpterelacionado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventacpterelacionado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocpterelacionado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechacpterelacionado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Deuda( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Caja_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Caja ) = 'O' or isnull( this.Caja ) )
					this.Caja = _Screen.zoo.instanciarentidad( 'Cajaestado' )
					this.Caja.lEsSubEntidad = .t.
					this.enlazar( 'Caja.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Caja.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Caja.ID # this.Caja_PK
						this.Caja.ID = this.Caja_PK
					endif
				endif
			endif
		endif
		return this.Caja
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Situacionfiscal_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Situacionfiscal ) = 'O' or isnull( this.Situacionfiscal ) )
					this.Situacionfiscal = _Screen.zoo.instanciarentidad( 'Situacionfiscal' )
					this.Situacionfiscal.lEsSubEntidad = .t.
					this.enlazar( 'Situacionfiscal.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Situacionfiscal.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Situacionfiscal.CODIGO # this.Situacionfiscal_PK
						this.Situacionfiscal.CODIGO = this.Situacionfiscal_PK
					endif
				endif
			endif
		endif
		return this.Situacionfiscal
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigomotivodescuentoensubtotal_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Codigomotivodescuentoensubtotal ) = 'O' or isnull( this.Codigomotivodescuentoensubtotal ) )
					this.Codigomotivodescuentoensubtotal = _Screen.zoo.instanciarentidad( 'Motivodescuentoydevolucion' )
					this.Codigomotivodescuentoensubtotal.lEsSubEntidad = .t.
					this.enlazar( 'Codigomotivodescuentoensubtotal.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Codigomotivodescuentoensubtotal.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Codigomotivodescuentoensubtotal.CODIGO # this.Codigomotivodescuentoensubtotal_PK
						this.Codigomotivodescuentoensubtotal.CODIGO = this.Codigomotivodescuentoensubtotal_PK
					endif
				endif
			endif
		endif
		return this.Codigomotivodescuentoensubtotal
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedasistema_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Monedasistema ) = 'O' or isnull( this.Monedasistema ) )
					this.Monedasistema = _Screen.zoo.instanciarentidad( 'Moneda' )
					this.Monedasistema.lEsSubEntidad = .t.
					this.enlazar( 'Monedasistema.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Monedasistema.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Monedasistema.CODIGO # this.Monedasistema_PK
						this.Monedasistema.CODIGO = this.Monedasistema_PK
					endif
				endif
			endif
		endif
		return this.Monedasistema
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idvuelto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Idvuelto ) = 'O' or isnull( this.Idvuelto ) )
					this.Idvuelto = _Screen.zoo.instanciarentidad( 'Valor' )
					this.Idvuelto.lEsSubEntidad = .t.
					this.enlazar( 'Idvuelto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Idvuelto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Idvuelto.CODIGO # this.Idvuelto_PK
						this.Idvuelto.CODIGO = this.Idvuelto_PK
					endif
				endif
			endif
		endif
		return this.Idvuelto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )
					this.Cliente = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Cliente.lEsSubEntidad = .t.
					this.enlazar( 'Cliente.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cliente.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cliente.CODIGO # this.Cliente_PK
						this.Cliente.CODIGO = this.Cliente_PK
					endif
				endif
			endif
		endif
		return this.Cliente
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Receptor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Receptor ) = 'O' or isnull( this.Receptor ) )
					this.Receptor = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Receptor.lEsSubEntidad = .t.
					this.enlazar( 'Receptor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Receptor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Receptor.CODIGO # this.Receptor_PK
						this.Receptor.CODIGO = this.Receptor_PK
					endif
				endif
			endif
		endif
		return this.Receptor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Vendedor ) = 'O' or isnull( this.Vendedor ) )
					this.Vendedor = _Screen.zoo.instanciarentidad( 'Vendedor' )
					this.Vendedor.lEsSubEntidad = .t.
					this.enlazar( 'Vendedor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Vendedor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Vendedor.CODIGO # this.Vendedor_PK
						this.Vendedor.CODIGO = this.Vendedor_PK
					endif
				endif
			endif
		endif
		return this.Vendedor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Monedacomprobante ) = 'O' or isnull( this.Monedacomprobante ) )
					this.Monedacomprobante = _Screen.zoo.instanciarentidad( 'Moneda' )
					this.Monedacomprobante.lEsSubEntidad = .t.
					this.enlazar( 'Monedacomprobante.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Monedacomprobante.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Monedacomprobante.CODIGO # this.Monedacomprobante_PK
						this.Monedacomprobante.CODIGO = this.Monedacomprobante_PK
					endif
				endif
			endif
		endif
		return this.Monedacomprobante
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Listadeprecios_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Listadeprecios ) = 'O' or isnull( this.Listadeprecios ) )
					this.Listadeprecios = _Screen.zoo.instanciarentidad( 'Listadeprecios' )
					this.Listadeprecios.lEsSubEntidad = .t.
					this.enlazar( 'Listadeprecios.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Listadeprecios.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Listadeprecios.CODIGO # this.Listadeprecios_PK
						this.Listadeprecios.CODIGO = this.Listadeprecios_PK
					endif
				endif
			endif
		endif
		return this.Listadeprecios
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompLimitesdeconsumo_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompLimitesdeconsumo ) = 'O' or isnull( this.oCompLimitesdeconsumo ) )
			this.oCompLimitesdeconsumo = _Screen.zoo.InstanciarComponente( 'ComponenteLimitesdeconsumo' )
		this.oCompLimitesdeconsumo.Inicializar()
		this.enlazar( 'oCompLimitesdeconsumo.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompLimitesdeconsumo.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompLimitesdeconsumo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompDescuentos_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompDescuentos ) = 'O' or isnull( this.oCompDescuentos ) )
			this.oCompDescuentos = _Screen.zoo.InstanciarComponente( 'ComponenteDescuentos' )
		this.oCompDescuentos.Inicializar()
		this.enlazar( 'oCompDescuentos.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompDescuentos.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompDescuentos
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompFacturacionelectronica_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompFacturacionelectronica ) = 'O' or isnull( this.oCompFacturacionelectronica ) )
			if this.lEsCAEUruguay 
				this.oCompFacturacionelectronica = _Screen.zoo.InstanciarComponente( 'ComponenteFacturacionelectronicaUruguay' )
				if goServicios.Parametros.Felino.GestiondeVentas.FacturacionElectronica.Uruguay.ENVIARUNIDADDEMEDIDACONFIGURADAENELARTICULO 
					bindevent( this.facturadetalle, 'EventoCargarUnidadDeMedida', this.oCompFacturacionelectronica, 'CargarUnidadDeMedidaPorArticulo') 
					bindevent( this, 'Limpiar', this.oCompFacturacionelectronica, 'LimpiarColecciondeUnidades') 
				endif 
			else
				this.oCompFacturacionelectronica = _Screen.zoo.InstanciarComponente( 'ComponenteFacturacionelectronica' )
			endif
		this.oCompFacturacionelectronica.Inicializar()
		this.enlazar( 'oCompFacturacionelectronica.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompFacturacionelectronica.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompFacturacionelectronica
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompSenias_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompSenias ) = 'O' or isnull( this.oCompSenias ) )
			this.oCompSenias = _Screen.zoo.InstanciarComponente( 'ComponenteSenias' )
		this.oCompSenias.Inicializar()
		this.enlazar( 'oCompSenias.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompSenias.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompSenias
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompDatosadicionalescomprobantesa_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompDatosadicionalescomprobantesa ) = 'O' or isnull( this.oCompDatosadicionalescomprobantesa ) )
			this.oCompDatosadicionalescomprobantesa = _Screen.zoo.InstanciarComponente( 'ComponenteDatosadicionalescomprobantesa' )
		this.oCompDatosadicionalescomprobantesa.Inicializar()
		this.enlazar( 'oCompDatosadicionalescomprobantesa.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompDatosadicionalescomprobantesa.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompDatosadicionalescomprobantesa
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompRegistroliquidacionconsignaciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompRegistroliquidacionconsignaciones ) = 'O' or isnull( this.oCompRegistroliquidacionconsignaciones ) )
			this.oCompRegistroliquidacionconsignaciones = _Screen.zoo.InstanciarComponente( 'ComponenteRegistroliquidacionconsignaciones' )
		this.oCompRegistroliquidacionconsignaciones.Inicializar()
		this.enlazar( 'oCompRegistroliquidacionconsignaciones.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompRegistroliquidacionconsignaciones.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompRegistroliquidacionconsignaciones
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompKitdearticulos_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompKitdearticulos ) = 'O' or isnull( this.oCompKitdearticulos ) )
			this.oCompKitdearticulos = _Screen.zoo.InstanciarComponente( 'ComponenteKitdearticulos' )
		this.oCompKitdearticulos.Inicializar()
		this.enlazar( 'oCompKitdearticulos.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompKitdearticulos.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompKitdearticulos
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompEnBaseA_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompEnBaseA ) = 'O' or isnull( this.oCompEnBaseA ) )
			this.oCompEnBaseA = _Screen.zoo.InstanciarComponente( 'ComponenteEnBaseA' )
		this.oCompEnBaseA.Inicializar()
		this.enlazar( 'oCompEnBaseA.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompEnBaseA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompEnBaseA
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.cComprobante + " " + This.Letra + " " + transform( This.PuntoDeVenta, "@LZ 9999" ) + "-" + transform( This.Numero, "@LZ 99999999" ) ) )
		Endif
		return this.DescripcionFW
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechamodificacion = ctod( '  /  /    ' )
				.Fueinformadoalanube = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechavtocai = ctod( '  /  /    ' )
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Cuit = []
				.Caja_PK = 0
				.Facturadetalle.Limpiar()
				.Impuestosdetalle.Limpiar()
				.Compafec.Limpiar()
				.Codigoajuste = []
				.Fechaaltafw = ctod( '  /  /    ' )
				.Nroopecommerce = []
				.Horaaltafw = []
				.Estadotransferencia = []
				.Basededatosaltafw = []
				.Codigobarraautoimpresor = []
				.Zadsfw = []
				.Hora = []
				.Basededatosmodificacionfw = []
				.Versionmodificacionfw = []
				.Versionaltafw = []
				.Descripcionfw = []
				.Usuariomodificacionfw = []
				.Simbolomonetariocomprobante = []
				.Usuarioaltafw = []
				.Horaimpo = []
				.Horamodificacionfw = []
				.Seriealtafw = []
				.Seriemodificacionfw = []
				.Horaexpo = []
				.Timestamp = 0
				.Cai = 0
				.Secuencia = []
				.Totalcantidad = 0
				.Porcentajedescuento2 = 0
				.Recargomontosinimpuestos = 0
				.Subtotalsinimpuestossobreitems = 0
				.Situacionfiscal_PK = 0
				.Subtotalbruto = 0
				.Signodemovimiento = 0
				.Subtotalneto = 0
				.Subtotalconimpuestossobreitems = 0
				.Condicioniva = 0
				.Recargomontosinimpuestos1 = 0
				.Recargomontosinimpuestos2 = 0
				.Montodescuentosinimpuestos3 = 0
				.Montodescuentoconimpuestos = 0
				.Ajustesporredondeos = 0
				.Montodescuentosinimpuestos2 = 0
				.Montodescuentosinimpuestos = 0
				.Montodescuentosinimpuestos1 = 0
				.Anulado = .F.
				.Descuentoautomatico = .F.
				.Basadoencomprobanteonline = .F.
				.Comprobantefiscal = .F.
				.Impuestoscomprobante.Limpiar()
				.Codigomotivodescuentoensubtotal_PK = []
				.Monedasistema_PK = []
				.Idvuelto_PK = []
				.Obs = []
				.Porcentajedescuento1 = 0
				.Turno = 0
				.Idsenia = []
				.Montodescuentoconimpuestos2 = 0
				.Tipocomprobante = 0
				.Codigo = []
				.Montodescuento1 = 0
				.Cliente_PK = []
				.Montodescuentoconimpuestos1 = 0
				.Receptor_PK = []
				.Clientedescripcion = []
				.Articulosseniadosdetalle.Limpiar()
				.Vendedor_PK = []
				.Kitsdetalle.Limpiar()
				.Letra = []
				.Fechavtosenia = ctod( '  /  /    ' )
				.Valoresdetalle.Limpiar()
				.Totalrecargosconimpuestos = 0
				.Totalrecargossinimpuestos = 0
				.Monedacomprobante_PK = []
				.Puntodeventa = 0
				.Listadeprecios_PK = []
				.Numero = 0
				.Email = []
				.Total = 0
				.Totaldescuentosconimpuestos = 0
				.Totaldescuentossinimpuestos = 0
				.Fecha = ctod( '  /  /    ' )
				.Cotizacion = 0
				.Montodescuentoconimpuestos3 = 0
				.Porcentajedescuento = 0
				.Recargomontoconimpuestos2 = 0
				.Vuelto = 0
				.Descuento = 0
				.Entregaposterior = 0
				.Montodescuento3 = 0
				.Percepciones = 0
				.Recargomontoconimpuestos = 0
				.Recargoporcentaje = 0
				.Recargomonto = 0
				.Recargomonto2 = 0
				.Montodescuento2 = 0
				.Recargomonto1 = 0
				.Recargomontoconimpuestos1 = 0
				.Gravamenes = 0
				.Impuestos = 0
				.Totalrecargos = 0
				.Totaldescuentos = 0
				.Chequereintegro = []
				.Totalimpuestos = 0
				.Mercaderiaconsignacion = .F.
				.Accioncancelatoria = .F.
				.Ivadelsistema = 0
				.Tipocpterelacionado = 0
				.Letracpterelacionado = []
				.Puntodeventacpterelacionado = 0
				.Numerocpterelacionado = 0
				.Fechacpterelacionado = ctod( '  /  /    ' )
				.Deuda = 0
				.LimpiarAtributosVirtuales()
				.oAD.Limpiar()
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				.lLimpiando = .f.
				if tlForzar
				else
					.SetearValoresSugeridos()
				endif
				.CambioSumarizado()
			EndTry
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function SetearValoresSugeridos() as Void
		With This
			.lEstaSeteandoValorSugerido = .T.
			If .EsNuevo()
				if !this.lEsSubEntidad
				if this.oColeccionVSFW.Buscar( "Fecha" )
					lcValorSugeridoFecha = this.oColeccionVSFW.Item[ "Fecha" ]
					&lcValorSugeridoFecha
				endif
				if this.oColeccionVSFW.Buscar( "Listadeprecios" )
					lcValorSugeridoListaDePrecios = this.oColeccionVSFW.Item[ "Listadeprecios" ]
					&lcValorSugeridoListaDePrecios
				endif
				for each ValorSugeridoPorEntidadSaltoDeCampo in this.oColeccionVS
					&ValorSugeridoPorEntidadSaltoDeCampo
				endfor
				for each ValorSugeridoDeFramework in this.oColeccionVSFW
					if ( upper( alltrim( ValorSugeridoDeFramework ) ) == ".VALORSUGERIDOFWLISTADEPRECIOS()" and !empty( this.ListaDePrecios_PK )) or ;
					   ( upper( alltrim( ValorSugeridoDeFramework ) ) == ".VALORSUGERIDOFWFECHA()" and !empty( this.Fecha ))
					else
						&ValorSugeridoDeFramework
					endif
				endfor
			EndIf
				endif
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechaaltafw() as void
		with this
			.Fechaaltafw = goservicios.librerias.obtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechaaltafw() as void
		with this
			.ValorSugeridoFWFechaaltafw()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWHoraaltafw() as void
		with this
			.Horaaltafw = goservicios.librerias.obtenerHora()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoHoraaltafw() as void
		with this
			.ValorSugeridoFWHoraaltafw()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWSituacionfiscal() as void
		with this
			try
				.Situacionfiscal_PK = 3
				.Situacionfiscal.CODIGO = .Situacionfiscal_PK
			Catch to loError
				.Situacionfiscal_PK=0
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSituacionfiscal() as void
		with this
			.ValorSugeridoFWSituacionfiscal()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWSignodemovimiento() as void
		with this
			.Signodemovimiento = -1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSignodemovimiento() as void
		with this
			.ValorSugeridoFWSignodemovimiento()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWIdvuelto() as void
		with this
			try
				.Idvuelto_PK = goParametros.Felino.Sugerencias.CodigoDeValorSugeridoParaVuelto
				.Idvuelto.CODIGO = .Idvuelto_PK
			Catch to loError
				.Idvuelto_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIdvuelto() as void
		with this
			.ValorSugeridoFWIdvuelto()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObs() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Obs" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Obs' )
						.Obs = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWTurno() as void
		with this
			.Turno = this.ObtenerTurno()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTurno() as void
		with this
			.ValorSugeridoFWTurno()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocomprobante() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Tipocomprobante" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipocomprobante' )
						.Tipocomprobante = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo de comprobante para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWTipocomprobante()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWTipocomprobante() as void
		with this
			.Tipocomprobante = this.ObtenerSugeridoTipoComprobante("NOTADECREDITO")
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Cliente" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cliente_PK' )
						.Cliente_PK = lvValorSugeridoDefinidoPorElUsuario
						.Cliente.CODIGO = .Cliente_PK
					endif
				endif
			Catch to loError
				.Cliente_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClientedescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Clientedescripcion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Clientedescripcion' )
						.Clientedescripcion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente descripción para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Vendedor" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vendedor_PK' )
						.Vendedor_PK = lvValorSugeridoDefinidoPorElUsuario
						.Vendedor.CODIGO = .Vendedor_PK
					endif
				endif
			Catch to loError
				.Vendedor_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vendedor para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLetra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Letra" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Letra' )
						.Letra = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Letra de comprobante para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechavtosenia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Fechavtosenia" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechavtosenia' )
						.Fechavtosenia = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vencimiento de la seña para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPuntodeventa() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Puntodeventa" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Puntodeventa' )
						.Puntodeventa = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pto. venta para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoListadeprecios() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Listadeprecios" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Listadeprecios_PK' )
						.Listadeprecios_PK = lvValorSugeridoDefinidoPorElUsuario
						.Listadeprecios.CODIGO = .Listadeprecios_PK
					endif
				else
					.ValorSugeridoFWListadeprecios()
				endif
			Catch to loError
				.Listadeprecios_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Lista de precio para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWListadeprecios() as void
		with this
			try
				.Listadeprecios_PK = goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferente
				.Listadeprecios.CODIGO = .Listadeprecios_PK
			Catch to loError
				.Listadeprecios_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumero() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Numero" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numero' )
						.Numero = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEmail() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Email" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Email' )
						.Email = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Email para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Fecha" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fecha' )
						.Fecha = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFecha()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFecha() as void
		with this
			.Fecha = goServicios.librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPorcentajedescuento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Porcentajedescuento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Porcentajedescuento' )
						.Porcentajedescuento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Descuento para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechavencimientomipyme() as void
		with this
			.Fechavencimientomipyme = goservicios.librerias.obtenerFecha() + goparametros.felino.gestionDEVENTAS.facTURACIONELECTRONICA.fechaDEVENCIMIENTOSUGERIDAPARALOSCOMPROBANTESDECREDITOENDIAS
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechavencimientomipyme() as void
		with this
			.ValorSugeridoFWFechavencimientomipyme()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMontodescuento3() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Montodescuento3" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Montodescuento3' )
						.Montodescuento3 = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de descuento para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRecargoporcentaje() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Recargoporcentaje" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Recargoporcentaje' )
						.Recargoporcentaje = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Recargo para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRecargomonto2() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Recargomonto2" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Recargomonto2' )
						.Recargomonto2 = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de recargo para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWIvadelsistema() as void
		with this
			.Ivadelsistema = goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIvadelsistema() as void
		with this
			.ValorSugeridoFWIvadelsistema()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocpterelacionado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Tipocpterelacionado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipocpterelacionado' )
						.Tipocpterelacionado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo  para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLetracpterelacionado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Letracpterelacionado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Letracpterelacionado' )
						.Letracpterelacionado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Comprobante asociado para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPuntodeventacpterelacionado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Puntodeventacpterelacionado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Puntodeventacpterelacionado' )
						.Puntodeventacpterelacionado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pto. de venta comprobante asociado para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumerocpterelacionado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Numerocpterelacionado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numerocpterelacionado' )
						.Numerocpterelacionado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo  para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechacpterelacionado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOAGRUPADA", "", "Fechacpterelacionado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechacpterelacionado' )
						.Fechacpterelacionado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha comprobante asociado para la entidad Nota de crédito." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_PK_DespuesDeAsignar() as void
		this.AsignarSituacionFiscal()                                                                       
	endfunc

	*-----------------------------------------------------------------------------------------
	function CargaManual() as Boolean
		return !this.lLimpiando and !this.lCargando and !this.lDestroy
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Fecha( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fecha( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Codigovendedor( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Codigovendedor( txVal, This )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Fechacalendario( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechacalendario( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Mail( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Mail( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Fechasaldo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechasaldo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		this.oCompLimitesDeConsumo = null
		this.oCompDescuentos = null
		this.oCompFacturacionElectronica = null
		this.oCompSenias = null
		this.oCompDatosAdicionalesComprobantesA = null
		this.oCompRegistroLiquidacionConsignaciones = null
		this.oCompKitDeArticulos = null
		this.oCompEnBaseA = null
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_NOTADECREDITOAGRUPADA' )

		this.oAtributosCC =  Null
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Codigobarracae = []
			.Cae = []
			.Vueltovirtual = 0
			.Fechavencimientocae = ctod( '  /  /    ' )
			.Fechavencimientomipyme = ctod( '  /  /    ' )
			.Entregaposteriorvirtual = []
			.Montodescuento2visual = 0
			.Recargomonto1visual = 0
			.Subtotalsinimp = 0
			.Subtotalconimp = 0
		endwith
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributosCombinacion() as object
		local loColRetorno as object
		
		loColRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		return loColRetorno
	endfunc
	*-----------------------------------------------------------------------------------------
	function EventoActualizarEmail() as Void
		*
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerDetalleaInsertar() as detalle of detalle.prg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributoDetalleaInsertar() as detalle of detalle.prg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function TieneDetallesConPrePantalla() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombreDetallesConPrePantalla() as ZooColeccion of ZooColeccion.prg
		local loRetorno as ZooColeccion OF ZooColeccion.prg
		loRetorno = _screen.zoo.CrearObjeto("ZooColeccion")
		loRetorno.Agregar("FacturaDetalle")
		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveCandidataNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveDeBusquedaNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCodigoErrorParaValidacionTimestamp() as Integer
		return goServicios.Errores.ObtenerCodigoErrorParaValidacionTimestamp()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearTipoComprobanteMiPyME( tlOriginal as Boolean ) as Integer
		local lnRetorno as Number

		if tlOriginal
			this.TipoComprobante = 28
		else
			this.TipoComprobante = 55
		endif

		return lnRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombreMiPyME( tlOriginal as Boolean ) as Integer
		local lcRetorno as String

		lcRetorno = 'NOTADECREDITOELECTRONICA'
	
		if !tlOriginal
			lcRetorno = 'NOTADECREDITOELECTRONICADECREDITO'
		endif

		return lcRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombreOriginal() as String

		return 'NOTADECREDITOAGRUPADA'
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function InicializarGeneradoSegunEntidades() as Void
	
	do case
		case this.Tipocomprobante = 3
			this.lClienteObligatorio = .F.
			this.cComprobante = "NOTADECREDITO"
			this.lInvertirSigno = .T.
			this.lImprimir = .F.
			this.lUtilizaSecuenciaFiscal = .F.
			this.lObtenerCodigoGTIN = .F.
			this.lAnularConUsuarioRestringido = .F.
			dodefault()
			this.ValoresDetalle.oItem.oCompCajero.oCompCUENTACORRIENTEVALORES.SetearSignoDelMovimiento( -1 )
			if vartype( this.oComponenteFiscal ) != "O"
			this.oComponenteFiscal = _screen.Zoo.CrearObjeto( "ComponenteFiscalManualArgentina", "ComponenteFiscalManualArgentina.prg", this.cComprobante )
			endif
		case this.Tipocomprobante = 5
			this.lClienteObligatorio = .F.
			this.lInvertirSigno = .T.
			this.cComprobante = "TICKETNOTADECREDITO"
			this.lImprimir = .T.
			this.lInvertirSigno = .T.
			this.lUtilizaSecuenciaFiscal = .T.
			this.lObtenerCodigoGTIN = .t.
			this.lAnularConUsuarioRestringido = .t.
			dodefault()
			this.ValoresDetalle.oItem.oCompCajero.oCompCUENTACORRIENTEVALORES.SetearSignoDelMovimiento( -1 )		
			if vartype( this.oComponenteFiscal ) != "O"
			this.oComponenteFiscal = _screen.Zoo.CrearObjeto( "ComponenteFiscalTicketArgentina", "ComponenteFiscalTicketArgentina.prg", this.cComprobante )
			endif	
			if empty( This.lcSecuencia )
			This.lcSecuencia = alltrim( goServicios.Parametros.Felino.ControladoresFiscales.SecuenciaParaReinicioDeLaMemoriaFiscal )
			endif
		case this.Tipocomprobante = 28
			this.lClienteObligatorio = .F.
			this.cComprobante = "NOTADECREDITOELECTRONICA"
			this.lInvertirSigno = .T.
			this.lImprimir = .F.
			this.lUtilizaSecuenciaFiscal = .F.
			this.lObtenerCodigoGTIN = .t.
			this.lAnularConUsuarioRestringido = .F.
			dodefault()
			this.ValoresDetalle.oItem.oCompCajero.oCompCUENTACORRIENTEVALORES.SetearSignoDelMovimiento( -1 )
			if vartype( this.oComponenteFiscal ) != "O"
			this.oComponenteFiscal = _screen.Zoo.CrearObjeto( "ComponenteFiscalManualArgentinaElectronico", "ComponenteFiscalManualArgentinaElectronico.prg", this.cComprobante )
			endif
		otherwise
			dodefault()
	EndCase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function DespuesDeGrabar() as 
	
	do case
		case this.Tipocomprobante = 3
			Local llRetorno As Boolean
			llRetorno = DoDefault()
			If llRetorno and ( this.EsNuevo() or ( this.EsEdicion() and this.lAnuladoAntesDeModificar ) )
			This.ImprimirOrdenDeCompra()
			Endif
		case this.Tipocomprobante = 5
			local llRetorno as Boolean
					
			llRetorno = dodefault()
			If this.EsNuevo()
			endif
		otherwise
			llRetorno = dodefault()
	EndCase
	return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function Cancelar() as Void
	
	do case
		case this.Tipocomprobante = 3
			if this.ExistenCuponesHuerfanosEnGrillaDeValores()
			this.EventoCancelarYAdvertir( "No puede cancelar el comprobante porque existen valores que tienen asociados cupones integrados." )
			else
			dodefault()
			endif
		otherwise
			dodefault()
	EndCase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function ExistenCuponesHuerfanosEnGrillaDeValores() as 
	
	do case
		case this.Tipocomprobante = 3
			Local llRetorno As boolean, lcDetalle as String, lnItem as Integer, ;
			loItem as Object
			llRetorno = .f.
			if type( "this." + This.cValoresDetalle ) = "O"
			lcDetalle = this.cValoresDetalle
			loDetalle = this.&lcDetalle
			for lnItem = 1 to loDetalle.Count
			if loDetalle.oItem.NroItem = lnItem
			loItem = loDetalle.oItem
			else
			loItem = loDetalle.Item[ lnItem ]
			endif
			if loDetalle.TieneCuponHuerfano( loItem )
			llRetorno = .t.
			endif
			endfor
			EndIf
			
		otherwise
			llRetorno = dodefault()
	EndCase
	return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function TipoDeComprobanteAdmiteLetraA() as Boolean
	
	do case
		case this.Tipocomprobante = 3
			local llRetorno as Boolean
			llRetorno = .t.
		case this.Tipocomprobante = 5
			local llRetorno as Boolean
			llRetorno = .t.
		case this.Tipocomprobante = 28
			local llRetorno as Boolean
			llRetorno = .t.
		otherwise
			llRetorno = dodefault()
	EndCase
	return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function InicializarColaboradorEquivalenciaCodigoGTIN() as void
	
	do case
		case this.Tipocomprobante = 5
			this.lObtenerCodigoGTIN = this.lObtenerCodigoGTIN and goServicios.Parametros.Felino.ControladoresFiscales.ObtenerCodigoGTIN
			dodefault()
		otherwise
			dodefault()
	EndCase
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function Imprimir() as boolean
	
	do case
		case this.Tipocomprobante = 5
			local llRetorno as Boolean
			
			llRetorno = dodefault()
			
			if !llRetorno and this.FueGeneradoPorPromocionBancaria()
			this.oMensaje.informar("Se produjo un error al imprimir el ticket nota de crédito por promoción bancaria. " + chr(10) + chr(13) + ;
			"El comprobante pendiente se generará en el próximo cierre de caja." )
			this.EjecutarSolucion( 3 )
			endif
					
			If this.EsNuevo()
			if goParametros.Felino.ControladoresFiscales.OrdenDeCompra.HabilitaLaImpresionDeOrdenesDeCompra
			this.ImprimirOrdenDeCompra()
			endif
			endif
			
				
		otherwise
			llRetorno = dodefault()
	EndCase
	return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function CompletarCampoSecuencia() as Boolean
	
	do case
		case this.Tipocomprobante = 5
			local llRetorno as boolean
			llRetorno = .t.
			if !this.lUsoBuscador
			this.Secuencia = This.lcSecuencia
			endif
		otherwise
			llRetorno = dodefault()
	EndCase
	return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	 function ValidarCliente() as Boolean
	
	do case
		case this.Tipocomprobante = 5
			local llRetorno as Boolean
					
			llRetorno = dodefault()
					
			if llRetorno
			if empty( this.Cliente_pk ) and vartype("goControladorFiscal")=="O" and !goControladorFiscal.oCaracteristicas.lTicketBNumeracionIndependiente
			this.AgregarInformacion( 'Debe cargar el campo Cliente', 9005, 'Cliente' )
			llRetorno = .F.
			else
			if !empty( this.Cliente_pk ) and empty( this.Letra )
			this.AgregarInformacion( 'Debe cargar el campo Letra', 9005, 'Letra' )
			llRetorno = .F.			
			endif
			endif
			endif
		otherwise
			llRetorno = dodefault()
	EndCase
	return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function AgregarParametrosInicializar()
		this.AddProperty( 'lcSecuencia', "")
		this.AddProperty( 'lInvertirSigno', .T.)
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protect function InformarWebHook()
		if this.lWHIngresar and this.lNuevo
			goServicios.WebHook.Enviar( this, 'INGRESAR')
		else
			if this.lWHModificar and this.lEdicion
				goServicios.WebHook.Enviar( this, 'MODIFICAR')
			endif
		endif
	endfunc

enddefine