
define class Din_EntidadREQUERIMIENTODECOMPRA as Ent_ComprobanteDeComprasSinValores of Ent_ComprobanteDeComprasSinValores.prg

	cNombre = 'REQUERIMIENTODECOMPRA'
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FechaModificacion = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	CUIT = []
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	PorcentajeDescuento1 = 0
	PorcentajeDescuento2 = 0
	PorcentajeDescuento = 0
	Turno = 0
	COMPAFEC = null
	FechaAltaFW = ctod( '  /  /    ' )
	HoraAltaFW = []
	BASEDEDATOSMODIFICACIONFW = []
	BASEDEDATOSALTAFW = []
	VERSIONALTAFW = []
	USUARIOMODIFICACIONFW = []
	SERIEALTAFW = []
	USUARIOALTAFW = []
	SERIEMODIFICACIONFW = []
	HORAMODIFICACIONFW = []
	VERSIONMODIFICACIONFW = []
	ESTADOTRANSFERENCIA = []
	Hora = []
	DescripcionFW = []
	ZADSFW = []
	HORAIMPO = []
	HORAEXPO = []
	SimboloMonetarioComprobante = []
	TIMESTAMP = 0
	TotalCantidad = 0
	SubTotalSinImpuestosSobreItems = 0
	SubTotalConImpuestosSobreItems = 0
	RecargoMontoConImpuestos2 = 0
	RecargoMontoConImpuestos1 = 0
	CondicionIva = 0
	RecargoMontoSinImpuestos = 0
	signodemovimiento = 0
	SituacionFiscal_PK = 0
	SituacionFiscal = null
	SubtotalNeto = 0
	SubtotalBruto = 0
	RecargoMontoSinImpuestos1 = 0
	TipoComprobante = 0
	MontoDescuentoSinImpuestos2 = 0
	MontoDescuentoSinImpuestos1 = 0
	MontoDescuentoSinImpuestos = 0
	RecargoMontoSinImpuestos2 = 0
	DescuentoAutomatico = .F.
	anulado = .F.
	ComprobanteFiscal = .F.
	TipoComprobanteRG1361 = 0
	FacturaDetalle = null
	ImpuestosDetalle = null
	MonedaSistema_PK = []
	MonedaSistema = null
	cAtributoPK = 'Codigo'
	Codigo = []
	IdVuelto_PK = []
	IdVuelto = null
	MontoDescuentoConImpuestos2 = 0
	MontoDescuentoConImpuestos1 = 0
	Descuento = 0
	Letra = []
	Impuestos = 0
	ImpuestosComprobante = null
	Obs = []
	FechaFactura = ctod( '  /  /    ' )
	PuntoDeVenta = 0
	MontoDescuentoConImpuestos3 = 0
	MontoDescuentoSinImpuestos3 = 0
	RecargoPorcentaje = 0
	Numero = 0
	TotalDescuentosSinImpuestos = 0
	Proveedor_PK = []
	Proveedor = null
	Fecha = ctod( '  /  /    ' )
	RecargoMonto = 0
	CAI = 0
	MonedaComprobante_PK = []
	MonedaComprobante = null
	FechaVtoCAI = ctod( '  /  /    ' )
	Cotizacion = 0
	Remito = []
	RecargoMontoConImpuestos = 0
	Vuelto = 0
	ListaDePrecios_PK = []
	ListaDePrecios = null
	FechaVencimiento = ctod( '  /  /    ' )
	CondicionPagoPreferente_PK = []
	CondicionPagoPreferente = null
	Total = 0
	RecargoMonto1 = 0
	RecargoMonto2 = 0
	Motivo_PK = []
	Motivo = null
	TotalImpuestos = 0
	TotalRecargosSinImpuestos = 0
	TotalRecargos = 0
	TotalDescuentos = 0
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Requerimiento de compra]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .f.
	cAtributoVendedor = ''
	oAtributosCC =  Null
	oCompEnBaseA = null
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCaja_PK = .T.
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
			this.oAD = this.crearobjeto( 'Din_EntidadREQUERIMIENTODECOMPRAAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Compafec_Access() as variant
		if !this.ldestroy and ( !vartype( this.Compafec ) = 'O' or isnull( this.Compafec ) )
			this.Compafec = this.crearobjeto( 'Din_DetalleRequerimientodecompraCompafec' )
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
	function Facturadetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Facturadetalle ) = 'O' or isnull( this.Facturadetalle ) )
			this.Facturadetalle = this.crearobjeto( 'Din_DetalleRequerimientodecompraFacturadetalle' )
			this.Facturadetalle.inicializar()
			this.enlazar( 'Facturadetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Facturadetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Facturadetalle, 'CambioSumarizado', this, 'CambiosDetalleFacturadetalle', 1) 
			this.enlazar( 'Facturadetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Facturadetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Facturadetalle.lVerificarLimitesEnDisenoImpresion = .t.
				this.Facturadetalle.lHabilitaInsertarDetalle = .t.
		endif
		return this.Facturadetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestosdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestosdetalle ) = 'O' or isnull( this.Impuestosdetalle ) )
			this.Impuestosdetalle = this.crearobjeto( 'Din_DetalleRequerimientodecompraImpuestosdetalle' )
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
	function Impuestoscomprobante_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestoscomprobante ) = 'O' or isnull( this.Impuestoscomprobante ) )
			this.Impuestoscomprobante = this.crearobjeto( 'Din_DetalleRequerimientodecompraImpuestoscomprobante' )
			this.Impuestoscomprobante.inicializar()
			this.enlazar( 'Impuestoscomprobante.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Impuestoscomprobante.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Impuestoscomprobante, 'CambioSumarizado', this, 'CambiosDetalleImpuestoscomprobante', 1) 
			this.enlazar( 'Impuestoscomprobante.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Impuestoscomprobante.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Impuestoscomprobante.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Impuestoscomprobante
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.COMPAFEC.oItem.lNuevo = this.lNuevo
		this.FacturaDetalle.oItem.lNuevo = this.lNuevo
		this.ImpuestosDetalle.oItem.lNuevo = this.lNuevo
		this.ImpuestosComprobante.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.COMPAFEC.oItem.lEdicion = this.lEdicion
		this.FacturaDetalle.oItem.lEdicion = this.lEdicion
		this.ImpuestosDetalle.oItem.lEdicion = this.lEdicion
		this.ImpuestosComprobante.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleCompafec() as void
		dodefault()
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
	function CambiosDetalleImpuestoscomprobante() as void
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
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.FechaAltaFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
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
		 
		if ( vartype( this.BASEDEDATOSMODIFICACIONFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.USUARIOMODIFICACIONFW) = 'C' )
			if len( alltrim( this.USUARIOMODIFICACIONFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.USUARIOALTAFW) = 'C' )
			if len( alltrim( this.USUARIOALTAFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOALTAFW no es el correcto.')
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
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.DescripcionFW) = 'C' )
			if len( alltrim( this.DESCRIPCIONFW ) ) > 200
				This.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.HORAEXPO) = 'C' )
			if len( alltrim( this.HORAEXPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAEXPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAEXPO no es el correcto.')
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
		 
		if ( vartype( this.RecargoMontoConImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOCONIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOCONIMPUESTOS2 - int( this.RECARGOMONTOCONIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOCONIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOCONIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoConImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOCONIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOCONIMPUESTOS1 - int( this.RECARGOMONTOCONIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOCONIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOCONIMPUESTOS1 no es el correcto.')
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
		 
		if ( vartype( this.RecargoMontoSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOSINIMPUESTOS - int( this.RECARGOMONTOSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS no es el correcto.')
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
			if lnLargoEntero > 13
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
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTALBRUTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTALBRUTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoSinImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOSINIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOSINIMPUESTOS1 - int( this.RECARGOMONTOSINIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS1 no es el correcto.')
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
		 
		if ( vartype( this.MontoDescuentoSinImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS2 - int( this.MONTODESCUENTOSINIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
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
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS - int( this.MONTODESCUENTOSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
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
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOSINIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOSINIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.DescuentoAutomatico) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCUENTOAUTOMATICO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.anulado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ANULADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ComprobanteFiscal) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo COMPROBANTEFISCAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoComprobanteRG1361) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOCOMPROBANTERG1361 ) ) ) 
			lnValorDelDecimal = this.TIPOCOMPROBANTERG1361 - int( this.TIPOCOMPROBANTERG1361)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOCOMPROBANTERG1361 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTERG1361 no es el correcto.')
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
		 
		if ( vartype( this.MontoDescuentoConImpuestos2) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS2 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS2 - int( this.MONTODESCUENTOCONIMPUESTOS2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoConImpuestos1) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS1 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS1 - int( this.MONTODESCUENTOCONIMPUESTOS1)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS1 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS1 no es el correcto.')
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
		 
		if ( vartype( this.Letra) = 'C' )
			if len( alltrim( this.LETRA ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo LETRA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LETRA no es el correcto.')
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
		 
		if ( vartype( this.Obs) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaFactura) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAFACTURA no es el correcto.')
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
		 
		if ( vartype( this.MontoDescuentoConImpuestos3) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOCONIMPUESTOS3 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOCONIMPUESTOS3 - int( this.MONTODESCUENTOCONIMPUESTOS3)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOCONIMPUESTOS3 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOCONIMPUESTOS3 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MontoDescuentoSinImpuestos3) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTODESCUENTOSINIMPUESTOS3 ) ) ) 
			lnValorDelDecimal = this.MONTODESCUENTOSINIMPUESTOS3 - int( this.MONTODESCUENTOSINIMPUESTOS3)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTODESCUENTOSINIMPUESTOS3 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTODESCUENTOSINIMPUESTOS3 no es el correcto.')
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
		 
		if ( vartype( this.TotalDescuentosSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALDESCUENTOSSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALDESCUENTOSSINIMPUESTOS - int( this.TOTALDESCUENTOSSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
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
		 
		if ( vartype( this.FechaVtoCAI) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVTOCAI no es el correcto.')
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
		 
		if ( vartype( this.Remito) = 'C' )
			if len( alltrim( this.REMITO ) ) > 15
				This.AgregarInformacion( 'La longitud del valor del atributo REMITO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo REMITO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RecargoMontoConImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.RECARGOMONTOCONIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.RECARGOMONTOCONIMPUESTOS - int( this.RECARGOMONTOCONIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RECARGOMONTOCONIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RECARGOMONTOCONIMPUESTOS no es el correcto.')
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
		 
		if ( vartype( this.TotalRecargosSinImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALRECARGOSSINIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.TOTALRECARGOSSINIMPUESTOS - int( this.TOTALRECARGOSSINIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALRECARGOSSINIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALRECARGOSSINIMPUESTOS no es el correcto.')
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

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoNUEVO( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoNUEVO( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoELIMINAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoELIMINAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoMODIFICAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoMODIFICAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoCANCELAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoCANCELAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoGRABAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoGRABAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoANULAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.FacturaDetalle.oItem.oCompPRECIOS.votarCambioEstadoANULAR( tcEstado )
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
			llRetorno = .ValidarMonedasistema() and llRetorno
			llRetorno = .ValidarIdvuelto() and llRetorno
			llRetorno = .ValidarLetra() and llRetorno
			llRetorno = .ValidarPuntodeventa() and llRetorno
			llRetorno = .ValidarNumero() and llRetorno
			llRetorno = .ValidarProveedor() and llRetorno
			llRetorno = .ValidarMonedacomprobante() and llRetorno
			llRetorno = .ValidarCotizacion() and llRetorno
			llRetorno = .ValidarListadeprecios() and llRetorno
			llRetorno = .ValidarCondicionpagopreferente() and llRetorno
			llRetorno = .ValidarMotivo() and llRetorno
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
		llRetorno = This.ValidarUnDetalle( this.COMPAFEC, 'COMPAFEC' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.FacturaDetalle, 'Artículos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ImpuestosDetalle, 'ImpuestosDetalle' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ImpuestosComprobante, 'ImpuestosComprobante' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarLetra() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Letra )
			this.AgregarInformacion( 'Debe cargar el campo Letra', 9005, 'Letra' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPuntoDeVenta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PuntoDeVenta )
			this.AgregarInformacion( 'Debe cargar el campo Punto de venta', 9005, 'PuntoDeVenta' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNumero() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Numero )
			this.AgregarInformacion( 'Debe cargar el campo Número', 9005, 'Numero' )
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
	function ValidarProveedor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Proveedor_PK )
			this.AgregarInformacion( 'Debe cargar el campo Proveedor', 9005, 'Proveedor' )
			llRetorno = .F.
		else
			If this.Proveedor.oAD.ConsultarPorClavePrimaria()
				This.Proveedor.oDesactivador.ValidarEstadoActivacion( this.Proveedor_PK , goLibrerias.Valorvacioseguntipo( vartype(this.Proveedor_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Proveedor_PK ))+ ' de la entidad ' +  upper( this.Proveedor.cDescripcion ) + ' no existe.')
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
	function ValidarCondicionPagoPreferente() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CondicionPagoPreferente_PK )
		else
			If this.CondicionPagoPreferente.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CondicionPagoPreferente_PK ))+ ' de la entidad ' +  upper( this.CondicionPagoPreferente.cDescripcion ) + ' no existe.')
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
		loAtributosObligatorios.add( 'LETRA' )
		loAtributosObligatorios.add( 'PUNTODEVENTA' )
		loAtributosObligatorios.add( 'NUMERO' )
		loAtributosObligatorios.add( 'PROVEEDOR' )
		loAtributosObligatorios.add( 'COTIZACION' )
		loAtributosObligatorios.add( 'LISTADEPRECIOS' )
		return loAtributosObligatorios

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Buscar() As void
		local llRetorno as Boolean, loEx as Exception, lcAtributo as String, lcMensaje as String

		lcAtributo = This.ObtenerAtributoClavePrimaria()
		if empty( This.&lcAtributo )
			llRetorno = this.oAD.ConsultarPorClaveCandidata()
			lcMensaje = 'El dato buscado TIPOCOMPROBANTE ' + transform( This.TipoComprobante ) + ', LETRA ' + transform( This.Letra ) + ', PUNTO DE VENTA ' + transform( This.PuntoDeVenta ) + ', NÚMERO ' + transform( This.Numero ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
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
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.FacturaDetalle.oItem.oCompPRECIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<ANULABLE><COMPRAS><LISTARMODIFICACION>'
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
		this.oProveedorAtributosAnulacion = newobject( "din_entidadREQUERIMIENTODECOMPRAAtributosAnulacion", "din_entidadREQUERIMIENTODECOMPRAAtributosAnulacion.prg" )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechaaltafw()','Fechaaltafw')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWHoraaltafw()','Horaaltafw')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSignodemovimiento()','Signodemovimiento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTipocomprobante()','Tipocomprobante')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWLetra()','Letra')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechafactura()','Fechafactura')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWPuntodeventa()','Puntodeventa')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechavtocai()','Fechavtocai')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWListadeprecios()','Listadeprecios')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechavencimiento()','Fechavencimiento')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'REQUERIMIENTODECOMPRA', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Requerimiento de compra - Atributo: Caja)" )
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
	function Proveedor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proveedor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Proveedor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Proveedor )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Proveedor_PK = lxVal

		if this.Validar_Proveedor( lxVal, lxValOld )
			This.Setear_Proveedor( lxVal )
			If lxValOld != lxVal or empty( this.Cuit ) 
				this.Cuit = This.proveedor.cuit
			endif
			If lxValOld != lxVal or empty( this.Situacionfiscal_PK ) 
				this.Situacionfiscal_Pk = This.proveedor.SituacionFiscal_PK
			endif
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
			This.Setear_Monedacomprobante( lxVal )
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
	function Condicionpagopreferente_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Condicionpagopreferente_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Condicionpagopreferente_PK = lxVal

		if this.Validar_Condicionpagopreferente( lxVal, lxValOld )
			This.Setear_Condicionpagopreferente( lxVal )
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
	function Setear_Proveedor( txVal as variant ) as void

		this.Proveedor.CODIGO = txVal
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
	function Setear_Condicionpagopreferente( txVal as variant ) as void

		this.Condicionpagopreferente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Motivo( txVal as variant ) as void

		this.Motivo.CODIGO = txVal
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
	function Validar_Monedasistema( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idvuelto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proveedor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Proveedor.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

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
	function Validar_Condicionpagopreferente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Motivo( txVal as variant, txValOld as variant ) as Boolean

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
	function Tipocomprobanterg1361_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipocomprobanterg1361
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipocomprobanterg1361( lxVal )
				this.Setear_Tipocomprobanterg1361( lxVal )
			EndIf
		Else
			This.Setear_Tipocomprobanterg1361( lxVal ) 
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
	function Fechafactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechafactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechafactura( lxVal )
				this.ValidarDominio_Fechacomprobante( lxVal )
				this.Setear_Fechafactura( lxVal )
			EndIf
		Else
			This.Setear_Fechafactura( lxVal ) 
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
	function Fechavtocai_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavtocai
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavtocai( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechavtocai( lxVal )
			EndIf
		Else
			This.Setear_Fechavtocai( lxVal ) 
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
	function Remito_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Remito
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Remito( lxVal )
				this.Setear_Remito( lxVal )
			EndIf
		Else
			This.Setear_Remito( lxVal ) 
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
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
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
	function Setear_Porcentajedescuento( txVal as variant ) as void

		this.Porcentajedescuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Turno( txVal as variant ) as void

		this.Turno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
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
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Hora( txVal as variant ) as void

		this.Hora = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcionfw( txVal as variant ) as void

		this.Descripcionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Simbolomonetariocomprobante( txVal as variant ) as void

		this.Simbolomonetariocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalcantidad( txVal as variant ) as void

		this.Totalcantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalsinimpuestossobreitems( txVal as variant ) as void

		this.Subtotalsinimpuestossobreitems = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotalconimpuestossobreitems( txVal as variant ) as void

		this.Subtotalconimpuestossobreitems = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos2( txVal as variant ) as void

		this.Recargomontoconimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos1( txVal as variant ) as void

		this.Recargomontoconimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Condicioniva( txVal as variant ) as void

		this.Condicioniva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos( txVal as variant ) as void

		this.Recargomontosinimpuestos = txVal
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
	function Setear_Subtotalbruto( txVal as variant ) as void

		this.Subtotalbruto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos1( txVal as variant ) as void

		this.Recargomontosinimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
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
	function Setear_Descuentoautomatico( txVal as variant ) as void

		this.Descuentoautomatico = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anulado( txVal as variant ) as void

		this.Anulado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobantefiscal( txVal as variant ) as void

		this.Comprobantefiscal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobanterg1361( txVal as variant ) as void

		this.Tipocomprobanterg1361 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos2( txVal as variant ) as void

		this.Montodescuentoconimpuestos2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos1( txVal as variant ) as void

		this.Montodescuentoconimpuestos1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuento( txVal as variant ) as void

		this.Descuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Impuestos( txVal as variant ) as void

		this.Impuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Obs( txVal as variant ) as void

		this.Obs = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechafactura( txVal as variant ) as void

		this.Fechafactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos3( txVal as variant ) as void

		this.Montodescuentoconimpuestos3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos3( txVal as variant ) as void

		this.Montodescuentosinimpuestos3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargoporcentaje( txVal as variant ) as void

		this.Recargoporcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
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
	function Setear_Recargomonto( txVal as variant ) as void

		this.Recargomonto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cai( txVal as variant ) as void

		this.Cai = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavtocai( txVal as variant ) as void

		this.Fechavtocai = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cotizacion( txVal as variant ) as void

		this.Cotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Remito( txVal as variant ) as void

		this.Remito = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontoconimpuestos( txVal as variant ) as void

		this.Recargomontoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vuelto( txVal as variant ) as void

		this.Vuelto = txVal
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
	function Setear_Totalimpuestos( txVal as variant ) as void

		this.Totalimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalrecargossinimpuestos( txVal as variant ) as void

		this.Totalrecargossinimpuestos = txVal
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
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

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
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuit( txVal as variant ) as Boolean

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
	function Validar_Porcentajedescuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Turno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

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
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Hora( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Simbolomonetariocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalcantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalsinimpuestossobreitems( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotalconimpuestossobreitems( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Condicioniva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos( txVal as variant ) as Boolean

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
	function Validar_Subtotalbruto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

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
	function Validar_Montodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentoautomatico( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anulado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobantefiscal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobanterg1361( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Impuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Obs( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechafactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargoporcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

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
	function Validar_Recargomonto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cai( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavtocai( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Remito( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vuelto( txVal as variant ) as Boolean

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
	function Validar_Recargomonto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalrecargossinimpuestos( txVal as variant ) as Boolean

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
	function Proveedor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Proveedor ) = 'O' or isnull( this.Proveedor ) )
					this.Proveedor = _Screen.zoo.instanciarentidad( 'Proveedor' )
					this.Proveedor.lEsSubEntidad = .t.
					this.enlazar( 'Proveedor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Proveedor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Proveedor.CODIGO # this.Proveedor_PK
						this.Proveedor.CODIGO = this.Proveedor_PK
					endif
				endif
			endif
		endif
		return this.Proveedor
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
	function Condicionpagopreferente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Condicionpagopreferente ) = 'O' or isnull( this.Condicionpagopreferente ) )
					this.Condicionpagopreferente = _Screen.zoo.instanciarentidad( 'Condiciondepago' )
					this.Condicionpagopreferente.lEsSubEntidad = .t.
					this.enlazar( 'Condicionpagopreferente.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Condicionpagopreferente.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Condicionpagopreferente.CODIGO # this.Condicionpagopreferente_PK
						this.Condicionpagopreferente.CODIGO = this.Condicionpagopreferente_PK
					endif
				endif
			endif
		endif
		return this.Condicionpagopreferente
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
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechamodificacion = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Cuit = []
				.Caja_PK = 0
				.Porcentajedescuento1 = 0
				.Porcentajedescuento2 = 0
				.Porcentajedescuento = 0
				.Turno = 0
				.Compafec.Limpiar()
				.Fechaaltafw = ctod( '  /  /    ' )
				.Horaaltafw = []
				.Basededatosmodificacionfw = []
				.Basededatosaltafw = []
				.Versionaltafw = []
				.Usuariomodificacionfw = []
				.Seriealtafw = []
				.Usuarioaltafw = []
				.Seriemodificacionfw = []
				.Horamodificacionfw = []
				.Versionmodificacionfw = []
				.Estadotransferencia = []
				.Hora = []
				.Descripcionfw = []
				.Zadsfw = []
				.Horaimpo = []
				.Horaexpo = []
				.Simbolomonetariocomprobante = []
				.Timestamp = 0
				.Totalcantidad = 0
				.Subtotalsinimpuestossobreitems = 0
				.Subtotalconimpuestossobreitems = 0
				.Recargomontoconimpuestos2 = 0
				.Recargomontoconimpuestos1 = 0
				.Condicioniva = 0
				.Recargomontosinimpuestos = 0
				.Signodemovimiento = 0
				.Situacionfiscal_PK = 0
				.Subtotalneto = 0
				.Subtotalbruto = 0
				.Recargomontosinimpuestos1 = 0
				.Tipocomprobante = 0
				.Montodescuentosinimpuestos2 = 0
				.Montodescuentosinimpuestos1 = 0
				.Montodescuentosinimpuestos = 0
				.Recargomontosinimpuestos2 = 0
				.Descuentoautomatico = .F.
				.Anulado = .F.
				.Comprobantefiscal = .F.
				.Tipocomprobanterg1361 = 0
				.Facturadetalle.Limpiar()
				.Impuestosdetalle.Limpiar()
				.Monedasistema_PK = []
				.Codigo = []
				.Idvuelto_PK = []
				.Montodescuentoconimpuestos2 = 0
				.Montodescuentoconimpuestos1 = 0
				.Descuento = 0
				.Letra = []
				.Impuestos = 0
				.Impuestoscomprobante.Limpiar()
				.Obs = []
				.Fechafactura = ctod( '  /  /    ' )
				.Puntodeventa = 0
				.Montodescuentoconimpuestos3 = 0
				.Montodescuentosinimpuestos3 = 0
				.Recargoporcentaje = 0
				.Numero = 0
				.Totaldescuentossinimpuestos = 0
				.Proveedor_PK = []
				.Fecha = ctod( '  /  /    ' )
				.Recargomonto = 0
				.Cai = 0
				.Monedacomprobante_PK = []
				.Fechavtocai = ctod( '  /  /    ' )
				.Cotizacion = 0
				.Remito = []
				.Recargomontoconimpuestos = 0
				.Vuelto = 0
				.Listadeprecios_PK = []
				.Fechavencimiento = ctod( '  /  /    ' )
				.Condicionpagopreferente_PK = []
				.Total = 0
				.Recargomonto1 = 0
				.Recargomonto2 = 0
				.Motivo_PK = []
				.Totalimpuestos = 0
				.Totalrecargossinimpuestos = 0
				.Totalrecargos = 0
				.Totaldescuentos = 0
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
	Function ValorSugeridoPorcentajedescuento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Porcentajedescuento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Descuento para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
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
	Function ValorSugeridoFWTipocomprobante() as void
		with this
			.Tipocomprobante = 42
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocomprobante() as void
		with this
			.ValorSugeridoFWTipocomprobante()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLetra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Letra" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Letra para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWLetra()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWLetra() as void
		with this
			.Letra = "X"
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObs() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Obs" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechafactura() as void
		with this
			.Fechafactura = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechafactura() as void
		with this
			.ValorSugeridoFWFechafactura()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPuntodeventa() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Puntodeventa" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Punto de venta para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWPuntodeventa()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWPuntodeventa() as void
		with this
			.Puntodeventa = goServicios.Parametros.felino.Numeraciones.BocaDeExpendio
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMontodescuentoconimpuestos3() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Montodescuentoconimpuestos3" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Montodescuentoconimpuestos3' )
						.Montodescuentoconimpuestos3 = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de descuento para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Recargoporcentaje" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Recargo para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Numero" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoProveedor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Proveedor" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Proveedor_PK' )
						.Proveedor_PK = lvValorSugeridoDefinidoPorElUsuario
						.Proveedor.CODIGO = .Proveedor_PK
					endif
				endif
			Catch to loError
				.Proveedor_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Fecha" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
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
			.Fecha = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMonedacomprobante() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Monedacomprobante" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Moneda comprobante para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechavtocai() as void
		with this
			.Fechavtocai = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechavtocai() as void
		with this
			.ValorSugeridoFWFechavtocai()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoListadeprecios() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Listadeprecios" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Lista de precio para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWListadeprecios() as void
		with this
			try
				.Listadeprecios_PK = goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras
				.Listadeprecios.CODIGO = .Listadeprecios_PK
			Catch to loError
				.Listadeprecios_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechavencimiento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Fechavencimiento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vencimiento para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
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
			.Fechavencimiento = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCondicionpagopreferente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Condicionpagopreferente" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Condicionpagopreferente_PK' )
						.Condicionpagopreferente_PK = lvValorSugeridoDefinidoPorElUsuario
						.Condicionpagopreferente.CODIGO = .Condicionpagopreferente_PK
					endif
				endif
			Catch to loError
				.Condicionpagopreferente_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Condición de pago para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRecargomonto2() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Recargomonto2" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de recargo para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMotivo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "REQUERIMIENTODECOMPRA", "", "Motivo" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Motivo para la entidad Requerimiento de compra." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
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
	function ValidarDominio_Fechacomprobante( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechacomprobante( txVal )
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		this.oCompEnBaseA = null
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_REQUERIMIENTODECOMPRA' )

		this.oAtributosCC =  Null
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
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

enddefine