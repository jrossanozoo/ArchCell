
define class Din_EntidadPRESUPUESTO as EntColoryTalle_ComprobanteDeVentasSinValores of EntColoryTalle_ComprobanteDeVentasSinValores.prg

	cNombre = 'PRESUPUESTO'
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FechaModificacion = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	PorcentajeDescuento1 = 0
	PorcentajeDescuento2 = 0
	Letra = []
	Cliente_PK = []
	Cliente = null
	Turno = 0
	FacturaDetalle = null
	ImpuestosDetalle = null
	COMPAFEC = null
	BASEDEDATOSALTAFW = []
	VERSIONALTAFW = []
	HoraAltaFW = []
	Hora = []
	ZADSFW = []
	FechaAltaFW = ctod( '  /  /    ' )
	BASEDEDATOSMODIFICACIONFW = []
	ESTADOTRANSFERENCIA = []
	SimboloMonetarioComprobante = []
	VERSIONMODIFICACIONFW = []
	SERIEALTAFW = []
	HORAEXPO = []
	DescripcionFW = []
	HORAMODIFICACIONFW = []
	USUARIOMODIFICACIONFW = []
	USUARIOALTAFW = []
	HORAIMPO = []
	SERIEMODIFICACIONFW = []
	TIMESTAMP = 0
	Secuencia = []
	TotalCantidad = 0
	MontoDescuentoConImpuestos = 0
	TipoComprobante = 0
	AjustesPorRedondeos = 0
	RecargoMontoSinImpuestos = 0
	SubTotalConImpuestosSobreItems = 0
	CondicionIva = 0
	SubTotalSinImpuestosSobreItems = 0
	RecargoMontoSinImpuestos1 = 0
	MontoDescuentoSinImpuestos = 0
	RecargoMontoSinImpuestos2 = 0
	SituacionFiscal_PK = 0
	SituacionFiscal = null
	signodemovimiento = 0
	MontoDescuentoSinImpuestos2 = 0
	MontoDescuentoSinImpuestos1 = 0
	MontoDescuentoSinImpuestos3 = 0
	SubtotalNeto = 0
	SubtotalBruto = 0
	ComprobanteFiscal = .F.
	anulado = .F.
	ImpuestosComprobante = null
	MonedaSistema_PK = []
	MonedaSistema = null
	CUIT = []
	MontoDescuento1 = 0
	MontoDescuento2 = 0
	PuntoDeVenta = 0
	ClienteDescripcion = []
	MontoDescuentoConImpuestos1 = 0
	MontoDescuentoConImpuestos2 = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	Obs = []
	Numero = 0
	MontoDescuentoConImpuestos3 = 0
	Vendedor_PK = []
	Vendedor = null
	TotalDescuentosConImpuestos = 0
	TotalDescuentosSinImpuestos = 0
	MonedaComprobante_PK = []
	MonedaComprobante = null
	lHabilitarMonedaComprobante_PK = .T.
	ListaDePrecios_PK = []
	ListaDePrecios = null
	KitsDetalle = null
	lHabilitarKitsDetalle = .T.
	Fecha = ctod( '  /  /    ' )
	TotalRecargosConImpuestos = 0
	TotalRecargosSinImpuestos = 0
	ForPago_PK = []
	ForPago = null
	FechaVencimiento = ctod( '  /  /    ' )
	Motivo_PK = []
	Motivo = null
	Total = 0
	Transportista_PK = []
	Transportista = null
	PorcentajeDescuento = 0
	Cotizacion = 0
	RecargoMontoConImpuestos2 = 0
	MercaderiaConsignacion = .F.
	lHabilitarMercaderiaConsignacion = .T.
	Descuento = 0
	MontoDescuento3 = 0
	Percepciones = 0
	RecargoMontoConImpuestos = 0
	RecargoPorcentaje = 0
	RecargoMonto = 0
	RecargoMonto1 = 0
	RecargoMonto2 = 0
	RecargoMontoConImpuestos1 = 0
	Subtotalsinimp = 0
	Gravamenes = 0
	Impuestos = 0
	Subtotalconimp = 0
	TotalRecargos = 0
	TotalDescuentos = 0
	TotalImpuestos = 0
	IvaDelSistema = 0
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Presupuesto de venta]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .t.
	cAtributoVendedor = 'VENDEDOR_PK'
	oAtributosCC =  Null
	cDetalleParticipantes = 'FACTURADETALLE'
	oCompDescuentos = null
	oCompKitDeArticulos = null
	oCompEnBaseA = null
	lSoportaKits = .t.
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarMonedaComprobante_PK = .T.
		this.lHabilitarKitsDetalle = .T.
		this.lHabilitarMercaderiaConsignacion = .T.
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
			this.oAD = this.crearobjeto( 'Din_EntidadPRESUPUESTOAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturadetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Facturadetalle ) = 'O' or isnull( this.Facturadetalle ) )
			this.Facturadetalle = this.crearobjeto( 'Din_DetallePresupuestoFacturadetalle' )
			this.Facturadetalle.inicializar()
			this.enlazar( 'Facturadetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Facturadetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Facturadetalle, 'CambioSumarizado', this, 'CambiosDetalleFacturadetalle', 1) 
			this.enlazar( 'Facturadetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Facturadetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Facturadetalle.lVerificarLimitesEnDisenoImpresion = .t.
				this.Facturadetalle.lHabilitaInsertarDetalle = .t.
			This.BindearEvento( This.Facturadetalle, 'EventoAgregarKits' , This, 'AgregarKits' )
		endif
		return this.Facturadetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestosdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestosdetalle ) = 'O' or isnull( this.Impuestosdetalle ) )
			this.Impuestosdetalle = this.crearobjeto( 'Din_DetallePresupuestoImpuestosdetalle' )
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
			this.Compafec = this.crearobjeto( 'Din_DetallePresupuestoCompafec' )
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
			this.Impuestoscomprobante = this.crearobjeto( 'Din_DetallePresupuestoImpuestoscomprobante' )
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
	function Kitsdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Kitsdetalle ) = 'O' or isnull( this.Kitsdetalle ) )
			this.Kitsdetalle = this.crearobjeto( 'Din_DetallePresupuestoKitsdetalle' )
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
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.FacturaDetalle.oItem.lNuevo = this.lNuevo
		this.ImpuestosDetalle.oItem.lNuevo = this.lNuevo
		this.COMPAFEC.oItem.lNuevo = this.lNuevo
		this.ImpuestosComprobante.oItem.lNuevo = this.lNuevo
		this.KitsDetalle.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.FacturaDetalle.oItem.lEdicion = this.lEdicion
		this.ImpuestosDetalle.oItem.lEdicion = this.lEdicion
		this.COMPAFEC.oItem.lEdicion = this.lEdicion
		this.ImpuestosComprobante.oItem.lEdicion = this.lEdicion
		this.KitsDetalle.oItem.lEdicion = this.lEdicion
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
	function CambiosDetalleKitsdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
		if ( vartype( this.FECHAMODIFICACIONFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAIMPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaModificacion) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.Letra) = 'C' )
			if len( alltrim( this.LETRA ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo LETRA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LETRA no es el correcto.')
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
		 
		if ( vartype( this.BASEDEDATOSALTAFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
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
		 
		if ( vartype( this.HoraAltaFW) = 'C' )
			if len( alltrim( this.HORAALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAALTAFW no es el correcto.')
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
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaAltaFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
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
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.HORAEXPO) = 'C' )
			if len( alltrim( this.HORAEXPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAEXPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAEXPO no es el correcto.')
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
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.SERIEMODIFICACIONFW) = 'C' )
			if len( alltrim( this.SERIEMODIFICACIONFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.ComprobanteFiscal) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTEFISCAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.anulado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ANULADO no es el correcto.')
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
		 
		if ( vartype( this.ClienteDescripcion) = 'C' )
			if len( alltrim( this.CLIENTEDESCRIPCION ) ) > 185
				This.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDESCRIPCION no es el correcto.')
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
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
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
		 
		if ( vartype( this.FechaVencimiento) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVENCIMIENTO no es el correcto.')
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
		 
		if ( vartype( this.MercaderiaConsignacion) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MERCADERIACONSIGNACION no es el correcto.')
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

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoNUEVO( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoNUEVO( tcEstado )
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
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoELIMINAR( tcEstado )
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
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoMODIFICAR( tcEstado )
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
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoCANCELAR( tcEstado )
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
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoGRABAR( tcEstado )
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
		llVotacion = llVotacion and this.oCompDESCUENTOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.oCompKITDEARTICULOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompSTOCK.votarCambioEstadoANULAR( tcEstado )
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
			llRetorno = .ValidarCliente() and llRetorno
			llRetorno = .ValidarSituacionfiscal() and llRetorno
			llRetorno = .ValidarSignodemovimiento() and llRetorno
			llRetorno = .ValidarMonedasistema() and llRetorno
			llRetorno = .ValidarVendedor() and llRetorno
			llRetorno = .ValidarMonedacomprobante() and llRetorno
			llRetorno = .ValidarListadeprecios() and llRetorno
			llRetorno = .ValidarFecha() and llRetorno
			llRetorno = .ValidarForpago() and llRetorno
			llRetorno = .ValidarMotivo() and llRetorno
			llRetorno = .ValidarTransportista() and llRetorno
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
		llRetorno = This.ValidarUnDetalle( this.KitsDetalle, 'Detalle de kits' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

		this.oCompDescuentos.lNuevo = this.lNuevo
		this.oCompDescuentos.lEdicion = this.lEdicion
		this.oCompDescuentos.lEliminar = this.lEliminar

		this.oCompKitDeArticulos.lNuevo = this.lNuevo
		this.oCompKitDeArticulos.lEdicion = this.lEdicion
		this.oCompKitDeArticulos.lEliminar = this.lEliminar

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
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
	function ValidarCliente() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Cliente_PK )
			this.AgregarInformacion( 'Debe cargar el campo Cliente', 9005, 'Cliente' )
			llRetorno = .F.
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
			this.AgregarInformacion( 'Debe cargar el campo Moneda comprobante', 9005, 'MonedaComprobante' )
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
	function ValidarForPago() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.ForPago_PK )
		else
			If this.ForPago.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.ForPago_PK ))+ ' de la entidad ' +  upper( this.ForPago.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMotivo() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Motivo_PK )
		else
			If this.Motivo.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Motivo_PK ))+ ' de la entidad ' +  upper( this.Motivo.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTransportista() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Transportista_PK )
		else
			If this.Transportista.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Transportista_PK ))+ ' de la entidad ' +  upper( this.Transportista.cDescripcion ) + ' no existe.')
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
		loAtributosObligatorios.add( 'CLIENTE' )
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
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_NUEVO()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_NUEVO()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_NUEVO()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ANULAR()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ANULAR()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompDESCUENTOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompKITDEARTICULOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.FacturaDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.KitsDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.KitsDetalle.oItem.oCompSTOCK.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.FacturaDetalle.oItem.oCompGIFTCARD.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<ANULABLE><VENTAS><DESCUENTOAUTOMATICO><LISTARMODIFICACION><WEBHOOK>'
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
		this.oProveedorAtributosAnulacion = newobject( "din_entidadPRESUPUESTOAtributosAnulacion", "din_entidadPRESUPUESTOAtributosAnulacion.prg" )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTurno()','Turno')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWHoraaltafw()','Horaaltafw')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechaaltafw()','Fechaaltafw')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTipocomprobante()','Tipocomprobante')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSituacionfiscal()','Situacionfiscal')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSignodemovimiento()','Signodemovimiento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWListadeprecios()','Listadeprecios')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechavencimiento()','Fechavencimiento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIvadelsistema()','Ivadelsistema')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'PRESUPUESTO', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
		this.lWHIngresar = goServicios.WebHook.TieneQueMandar( 'PRESUPUESTO', 'INGRESAR' )
		this.lWHModificar = goServicios.WebHook.TieneQueMandar( 'PRESUPUESTO', 'MODIFICAR' )
		this.lWHEliminar = goServicios.WebHook.TieneQueMandar( 'PRESUPUESTO', 'ELIMINAR' )
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
			This.Setear_Cliente( lxVal )
			This.Cliente_PK_DespuesDeAsignar()
			If lxValOld != lxVal or empty( this.Cuit ) 
				this.Cuit = This.Cliente.cuit
			endif
			If lxValOld != lxVal or empty( this.Clientedescripcion ) 
				this.Clientedescripcion = This.Cliente.Nombre
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Presupuesto de venta - Atributo: Monedacomprobante)" )
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
	function Forpago_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Forpago_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Forpago_PK = lxVal

		if this.Validar_Forpago( lxVal, lxValOld )
			This.Setear_Forpago( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Motivo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Motivo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 3, padr( lxVal, 3 ), lxVal )
		this.Motivo_PK = lxVal

		if this.Validar_Motivo( lxVal, lxValOld )
			This.Setear_Motivo( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Transportista_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Transportista_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Transportista.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Transportista )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Transportista_PK = lxVal

		if this.Validar_Transportista( lxVal, lxValOld )
			This.Setear_Transportista( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Situacionfiscal( txVal as variant ) as void

		this.Situacionfiscal.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monedasistema( txVal as variant ) as void

		this.Monedasistema.CODIGO = txVal
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
	function Setear_Forpago( txVal as variant ) as void

		this.Forpago.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Motivo( txVal as variant ) as void

		this.Motivo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Transportista( txVal as variant ) as void

		this.Transportista.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Situacionfiscal( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monedasistema( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Validar_Forpago( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Motivo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Transportista( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Tipocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipocomprobante( lxVal )
				this.Setear_Tipocomprobante( lxVal )
			EndIf
		Else
			This.Setear_Tipocomprobante( lxVal ) 
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
				this.ValidarDominio_Fechacomprobante( lxVal )
				this.Setear_Fecha( lxVal )
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
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
	function Fechavencimiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavencimiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavencimiento( lxVal )
				this.ValidarDominio_Fechacomprobante( lxVal )
				this.Setear_Fechavencimiento( lxVal )
			EndIf
		Else
			This.Setear_Fechavencimiento( lxVal ) 
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
	function Mercaderiaconsignacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Mercaderiaconsignacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Mercaderiaconsignacion( lxVal )
				if ( this.lHabilitarMercaderiaconsignacion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Mercaderiaconsignacion( lxVal )
				else
					this.Mercaderiaconsignacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Presupuesto de venta - Atributo: Mercaderiaconsignacion)" )
				endif 
			EndIf
		Else
			This.Setear_Mercaderiaconsignacion( lxVal ) 
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
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaimpo( txVal as variant ) as void

		this.Fechaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacion( txVal as variant ) as void

		this.Fechamodificacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedescuento1( txVal as variant ) as void

		this.Porcentajedescuento1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedescuento2( txVal as variant ) as void

		this.Porcentajedescuento2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Turno( txVal as variant ) as void

		this.Turno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionaltafw( txVal as variant ) as void

		this.Versionaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Hora( txVal as variant ) as void

		this.Hora = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Simbolomonetariocomprobante( txVal as variant ) as void

		this.Simbolomonetariocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcionfw( txVal as variant ) as void

		this.Descripcionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
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
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
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
	function Setear_Montodescuentoconimpuestos( txVal as variant ) as void

		this.Montodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajustesporredondeos( txVal as variant ) as void

		this.Ajustesporredondeos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos( txVal as variant ) as void

		this.Recargomontosinimpuestos = txVal
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
	function Setear_Subtotalsinimpuestossobreitems( txVal as variant ) as void

		this.Subtotalsinimpuestossobreitems = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos1( txVal as variant ) as void

		this.Recargomontosinimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos( txVal as variant ) as void

		this.Montodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos2( txVal as variant ) as void

		this.Recargomontosinimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Signodemovimiento( txVal as variant ) as void

		this.Signodemovimiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos2( txVal as variant ) as void

		this.Montodescuentosinimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos1( txVal as variant ) as void

		this.Montodescuentosinimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos3( txVal as variant ) as void

		this.Montodescuentosinimpuestos3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalneto( txVal as variant ) as void

		this.Subtotalneto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalbruto( txVal as variant ) as void

		this.Subtotalbruto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobantefiscal( txVal as variant ) as void

		this.Comprobantefiscal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anulado( txVal as variant ) as void

		this.Anulado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuit( txVal as variant ) as void

		this.Cuit = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento1( txVal as variant ) as void

		this.Montodescuento1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento2( txVal as variant ) as void

		this.Montodescuento2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos1( txVal as variant ) as void

		this.Montodescuentoconimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos2( txVal as variant ) as void

		this.Montodescuentoconimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Obs( txVal as variant ) as void

		this.Obs = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos3( txVal as variant ) as void

		this.Montodescuentoconimpuestos3 = txVal
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
	function Setear_Fechavencimiento( txVal as variant ) as void

		this.Fechavencimiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedescuento( txVal as variant ) as void

		this.Porcentajedescuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cotizacion( txVal as variant ) as void

		this.Cotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos2( txVal as variant ) as void

		this.Recargomontoconimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Mercaderiaconsignacion( txVal as variant ) as void

		this.Mercaderiaconsignacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuento( txVal as variant ) as void

		this.Descuento = txVal
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
	function Setear_Recargomonto1( txVal as variant ) as void

		this.Recargomonto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomonto2( txVal as variant ) as void

		this.Recargomonto2 = txVal
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
	function Setear_Totalimpuestos( txVal as variant ) as void

		this.Totalimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ivadelsistema( txVal as variant ) as void

		this.Ivadelsistema = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedescuento1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedescuento2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Turno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Hora( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Simbolomonetariocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

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
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestamp( txVal as variant ) as Boolean

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
	function Validar_Montodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajustesporredondeos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos( txVal as variant ) as Boolean

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
	function Validar_Subtotalsinimpuestossobreitems( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Signodemovimiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalneto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalbruto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobantefiscal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anulado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuit( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Obs( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos3( txVal as variant ) as Boolean

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
	function Validar_Totalrecargosconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalrecargossinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavencimiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedescuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Mercaderiaconsignacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuento( txVal as variant ) as Boolean

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
	function Validar_Recargomonto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto2( txVal as variant ) as Boolean

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
	function Validar_Totalimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ivadelsistema( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Forpago_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Forpago ) = 'O' or isnull( this.Forpago ) )
					this.Forpago = _Screen.zoo.instanciarentidad( 'Condiciondepago' )
					this.Forpago.lEsSubEntidad = .t.
					this.enlazar( 'Forpago.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Forpago.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Forpago.CODIGO # this.Forpago_PK
						this.Forpago.CODIGO = this.Forpago_PK
					endif
				endif
			endif
		endif
		return this.Forpago
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Motivo_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Motivo ) = 'O' or isnull( this.Motivo ) )
					this.Motivo = _Screen.zoo.instanciarentidad( 'Motivo' )
					this.Motivo.lEsSubEntidad = .t.
					this.enlazar( 'Motivo.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Motivo.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Motivo.CODIGO # this.Motivo_PK
						this.Motivo.CODIGO = this.Motivo_PK
					endif
				endif
			endif
		endif
		return this.Motivo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Transportista_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Transportista ) = 'O' or isnull( this.Transportista ) )
					this.Transportista = _Screen.zoo.instanciarentidad( 'Transportista' )
					this.Transportista.lEsSubEntidad = .t.
					this.enlazar( 'Transportista.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Transportista.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Transportista.CODIGO # this.Transportista_PK
						this.Transportista.CODIGO = this.Transportista_PK
					endif
				endif
			endif
		endif
		return this.Transportista
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

				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechamodificacion = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Porcentajedescuento1 = 0
				.Porcentajedescuento2 = 0
				.Letra = []
				.Cliente_PK = []
				.Turno = 0
				.Facturadetalle.Limpiar()
				.Impuestosdetalle.Limpiar()
				.Compafec.Limpiar()
				.Basededatosaltafw = []
				.Versionaltafw = []
				.Horaaltafw = []
				.Hora = []
				.Zadsfw = []
				.Fechaaltafw = ctod( '  /  /    ' )
				.Basededatosmodificacionfw = []
				.Estadotransferencia = []
				.Simbolomonetariocomprobante = []
				.Versionmodificacionfw = []
				.Seriealtafw = []
				.Horaexpo = []
				.Descripcionfw = []
				.Horamodificacionfw = []
				.Usuariomodificacionfw = []
				.Usuarioaltafw = []
				.Horaimpo = []
				.Seriemodificacionfw = []
				.Timestamp = 0
				.Secuencia = []
				.Totalcantidad = 0
				.Montodescuentoconimpuestos = 0
				.Tipocomprobante = 0
				.Ajustesporredondeos = 0
				.Recargomontosinimpuestos = 0
				.Subtotalconimpuestossobreitems = 0
				.Condicioniva = 0
				.Subtotalsinimpuestossobreitems = 0
				.Recargomontosinimpuestos1 = 0
				.Montodescuentosinimpuestos = 0
				.Recargomontosinimpuestos2 = 0
				.Situacionfiscal_PK = 0
				.Signodemovimiento = 0
				.Montodescuentosinimpuestos2 = 0
				.Montodescuentosinimpuestos1 = 0
				.Montodescuentosinimpuestos3 = 0
				.Subtotalneto = 0
				.Subtotalbruto = 0
				.Comprobantefiscal = .F.
				.Anulado = .F.
				.Impuestoscomprobante.Limpiar()
				.Monedasistema_PK = []
				.Cuit = []
				.Montodescuento1 = 0
				.Montodescuento2 = 0
				.Puntodeventa = 0
				.Clientedescripcion = []
				.Montodescuentoconimpuestos1 = 0
				.Montodescuentoconimpuestos2 = 0
				.Codigo = []
				.Obs = []
				.Numero = 0
				.Montodescuentoconimpuestos3 = 0
				.Vendedor_PK = []
				.Totaldescuentosconimpuestos = 0
				.Totaldescuentossinimpuestos = 0
				.Monedacomprobante_PK = []
				.Listadeprecios_PK = []
				.Kitsdetalle.Limpiar()
				.Fecha = ctod( '  /  /    ' )
				.Totalrecargosconimpuestos = 0
				.Totalrecargossinimpuestos = 0
				.Forpago_PK = []
				.Fechavencimiento = ctod( '  /  /    ' )
				.Motivo_PK = []
				.Total = 0
				.Transportista_PK = []
				.Porcentajedescuento = 0
				.Cotizacion = 0
				.Recargomontoconimpuestos2 = 0
				.Mercaderiaconsignacion = .F.
				.Descuento = 0
				.Montodescuento3 = 0
				.Percepciones = 0
				.Recargomontoconimpuestos = 0
				.Recargoporcentaje = 0
				.Recargomonto = 0
				.Recargomonto1 = 0
				.Recargomonto2 = 0
				.Recargomontoconimpuestos1 = 0
				.Gravamenes = 0
				.Impuestos = 0
				.Totalrecargos = 0
				.Totaldescuentos = 0
				.Totalimpuestos = 0
				.Ivadelsistema = 0
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
	Function ValorSugeridoLetra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Letra" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Letra de comprobante para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Cliente" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
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
	Function ValorSugeridoFWTipocomprobante() as void
		with this
			.Tipocomprobante = 25
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocomprobante() as void
		with this
			.ValorSugeridoFWTipocomprobante()
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
			.Signodemovimiento = 1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSignodemovimiento() as void
		with this
			.ValorSugeridoFWSignodemovimiento()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPuntodeventa() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Puntodeventa" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pto. venta para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClientedescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Clientedescripcion" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente descripción para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObs() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Obs" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumero() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Numero" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Vendedor" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vendedor para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMonedacomprobante() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Monedacomprobante" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Monedacomprobante_PK' )
						.Monedacomprobante_PK = lvValorSugeridoDefinidoPorElUsuario
						.Monedacomprobante.CODIGO = .Monedacomprobante_PK
					endif
				endif
			Catch to loError
				.Monedacomprobante_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Moneda comprobante para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoListadeprecios() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Listadeprecios" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Lista de precio para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	Function ValorSugeridoFecha() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Fecha" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
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
	Function ValorSugeridoForpago() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Forpago" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Forpago_PK' )
						.Forpago_PK = lvValorSugeridoDefinidoPorElUsuario
						.Forpago.CODIGO = .Forpago_PK
					endif
				endif
			Catch to loError
				.Forpago_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Condición de pago para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechavencimiento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Fechavencimiento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechavencimiento' )
						.Fechavencimiento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de vencimiento para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechavencimiento()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechavencimiento() as void
		with this
			.Fechavencimiento = goServicios.librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMotivo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Motivo" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Motivo_PK' )
						.Motivo_PK = lvValorSugeridoDefinidoPorElUsuario
						.Motivo.CODIGO = .Motivo_PK
					endif
				endif
			Catch to loError
				.Motivo_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Motivo para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTransportista() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Transportista" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Transportista_PK' )
						.Transportista_PK = lvValorSugeridoDefinidoPorElUsuario
						.Transportista.CODIGO = .Transportista_PK
					endif
				endif
			Catch to loError
				.Transportista_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Transportista para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPorcentajedescuento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Porcentajedescuento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Descuento para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMercaderiaconsignacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Mercaderiaconsignacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Mercaderiaconsignacion' )
						.Mercaderiaconsignacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Mercadería en consignación para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMontodescuento3() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Montodescuento3" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de descuento para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Recargoporcentaje" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Recargo para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRESUPUESTO", "", "Recargomonto2" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto recargo para la entidad Presupuesto de venta." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_PK_DespuesDeAsignar() as void
		this.AsignarDatosCliente()
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
	function ValidarDominio_Fechacomprobante( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechacomprobante( txVal )
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
		this.oCompDescuentos = null
		this.oCompKitDeArticulos = null
		this.oCompEnBaseA = null
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_PRESUPUESTO' )

		this.oAtributosCC =  Null
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
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

	*--------------------------------------------------------------------------------------------------------
	function ObtenerDetalleaInsertar() as detalle of detalle.prg
		return this.FacturaDetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributoDetalleaInsertar() as detalle of detalle.prg
		return 'FacturaDetalle'
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
		This.ValorSugeridoTipoComprobante()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveDeBusquedaNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCodigoErrorParaValidacionTimestamp() as Integer
		return goServicios.Errores.ObtenerCodigoErrorParaValidacionTimestamp()
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