
define class Din_ItemPAGOOrdendepago_valoresdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'PAGO'
	FechaUltCotizacion = ctod( '  /  /    ' )
	FechaComp = ctod( '  /  /    ' )
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	Tipo = 0
	Turno = 0
	UltimaCotizacion = 0
	CondicionRecargo = 0
	Signo = 0
	PuntoDeVenta = 0
	Cotiza = 0
	NroItem = 0
	PesosAlCambio = 0
	NumeroCupon = 0
	NumerodeComprobante = 0
	PersonalizarComprobante = .F.
	ChequeElectronico = .F.
	lHabilitarChequeElectronico = .T.
	VisualizarEnEstadoDeCaja = .F.
	Letra = []
	NroDocumento = []
	TipodeComprobante = []
	TipoDocumento = []
	NumeroTarjeta = []
	Vendedor = []
	NumeroCheque_PK = []
	NumeroCheque = null
	NumeroChequePropio_PK = []
	NumeroChequePropio = null
	cAtributoPK = 'Codigo'
	Codigo = []
	Valor_PK = []
	Valor = null
	ValorDetalle = []
	Fecha = ctod( '  /  /    ' )
	NumeroInterno = []
	lHabilitarNumeroInterno = .T.
	Monto = 0
	lHabilitarMonto = .T.
	RecargoPorcentaje = 0
	RecargoMonto = 0
	Total = 0
	RecargoMontoSinImpuestos = 0
	RecargoSinPercepciones = 0
	PermiteVuelto = .F.
	IdItemComponente = []
	NumeroValeDeCambio_PK = []
	NumeroValeDeCambio = null
	oCompCajero = null
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCaja_PK = .T.
		this.lHabilitarChequeElectronico = .T.
		this.lHabilitarNumeroInterno = .T.
		this.lHabilitarMonto = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWCondicionrecargo()','Condicionrecargo')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'PAGO', 'Ordendepago_valoresdetalle')
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
				this.EventoAntesDeSetear( This, 'Caja_Pk', lxValOld, lxVal  )
				This.Setear_Caja( lxVal )
				this.EventoDespuesDeSetear( This, 'Caja_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Caja_Pk', This )
					Endif
				EndIf
			else
				this.Caja_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Pago - Atributo: Caja)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerocheque_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerocheque_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Numerocheque_PK = lxVal

		if this.Validar_Numerocheque( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Numerocheque_Pk', lxValOld, lxVal  )
			This.Setear_Numerocheque( lxVal )
			this.EventoDespuesDeSetear( This, 'Numerocheque_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Numerocheque_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerochequepropio_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerochequepropio_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Numerochequepropio_PK = lxVal

		if this.Validar_Numerochequepropio( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Numerochequepropio_Pk', lxValOld, lxVal  )
			This.Setear_Numerochequepropio( lxVal )
			this.EventoDespuesDeSetear( This, 'Numerochequepropio_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Numerochequepropio_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Valor_PK = lxVal

		if this.Validar_Valor( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Valor_Pk', lxValOld, lxVal  )
			This.Setear_Valor( lxVal )
			this.EventoDespuesDeSetear( This, 'Valor_Pk', lxValOld, lxVal  )
			If This.PuedeEjecutarCambioSumarizado()
				this.CambioSumarizado()
			EndIf
			If lxValOld != lxVal or empty( this.Visualizarenestadodecaja ) 
				this.Visualizarenestadodecaja = This.Valor.VisualizarEnCaja
			endif
			If lxValOld != lxVal or empty( this.Valordetalle ) 
				this.Valordetalle = This.Valor.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Valor_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerovaledecambio_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerovaledecambio_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Numerovaledecambio.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Numerovaledecambio )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Numerovaledecambio_PK = lxVal

		if this.Validar_Numerovaledecambio( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Numerovaledecambio_Pk', lxValOld, lxVal  )
			This.Setear_Numerovaledecambio( lxVal )
			this.EventoDespuesDeSetear( This, 'Numerovaledecambio_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Numerovaledecambio_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Caja( txVal as variant ) as void

		this.Caja.ID = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocheque( txVal as variant ) as void

		this.Numerocheque.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerochequepropio( txVal as variant ) as void

		this.Numerochequepropio.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valor( txVal as variant ) as void

		this.Valor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerovaledecambio( txVal as variant ) as void

		this.Numerovaledecambio.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Caja( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocheque( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerochequepropio( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerovaledecambio( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaultcotizacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaultcotizacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaultcotizacion( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fechaultcotizacion', lxValOld, lxVal  )
				this.Setear_Fechaultcotizacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechaultcotizacion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechaultcotizacion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechaultcotizacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechacomp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechacomp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechacomp( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fechacomp', lxValOld, lxVal  )
				this.Setear_Fechacomp( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechacomp', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechacomp', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechacomp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipo( lxVal )
				this.EventoAntesDeSetear( This, 'Tipo', lxValOld, lxVal  )
				this.Setear_Tipo( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipo( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Turno', lxValOld, lxVal  )
				this.Setear_Turno( lxVal )
				this.EventoDespuesDeSetear( This, 'Turno', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Turno', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Turno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ultimacotizacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ultimacotizacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ultimacotizacion( lxVal )
				this.EventoAntesDeSetear( This, 'Ultimacotizacion', lxValOld, lxVal  )
				this.Setear_Ultimacotizacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Ultimacotizacion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ultimacotizacion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ultimacotizacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Condicionrecargo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Condicionrecargo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Condicionrecargo( lxVal )
				this.EventoAntesDeSetear( This, 'Condicionrecargo', lxValOld, lxVal  )
				this.Setear_Condicionrecargo( lxVal )
				this.EventoDespuesDeSetear( This, 'Condicionrecargo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Condicionrecargo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Condicionrecargo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Signo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Signo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Signo( lxVal )
				this.EventoAntesDeSetear( This, 'Signo', lxValOld, lxVal  )
				this.Setear_Signo( lxVal )
				this.EventoDespuesDeSetear( This, 'Signo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Signo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Signo( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Puntodeventa', lxValOld, lxVal  )
				this.Setear_Puntodeventa( lxVal )
				this.EventoDespuesDeSetear( This, 'Puntodeventa', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Puntodeventa', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Puntodeventa( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cotiza_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cotiza
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cotiza( lxVal )
				this.EventoAntesDeSetear( This, 'Cotiza', lxValOld, lxVal  )
				this.Setear_Cotiza( lxVal )
				this.EventoDespuesDeSetear( This, 'Cotiza', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cotiza', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cotiza( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nroitem_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nroitem
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nroitem( lxVal )
				this.EventoAntesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
				this.Setear_Nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nroitem', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pesosalcambio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pesosalcambio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Pesosalcambio( lxVal )
				this.EventoAntesDeSetear( This, 'Pesosalcambio', lxValOld, lxVal  )
				this.Setear_Pesosalcambio( lxVal )
				this.EventoDespuesDeSetear( This, 'Pesosalcambio', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Pesosalcambio', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Pesosalcambio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Pesosalcambio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerocupon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerocupon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerocupon( lxVal )
				this.EventoAntesDeSetear( This, 'Numerocupon', lxValOld, lxVal  )
				this.Setear_Numerocupon( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerocupon', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerocupon', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numerocupon( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerodecomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerodecomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerodecomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Numerodecomprobante', lxValOld, lxVal  )
				this.Setear_Numerodecomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerodecomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerodecomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numerodecomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Personalizarcomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Personalizarcomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Personalizarcomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Personalizarcomprobante', lxValOld, lxVal  )
				this.Setear_Personalizarcomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Personalizarcomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Personalizarcomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Personalizarcomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Chequeelectronico_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Chequeelectronico
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Chequeelectronico( lxVal )
				if ( this.lHabilitarChequeelectronico or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Chequeelectronico', lxValOld, lxVal  )
					this.Setear_Chequeelectronico( lxVal )
				this.EventoDespuesDeSetear( This, 'Chequeelectronico', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Chequeelectronico', This )
						Endif
					EndIf
				else
					this.Chequeelectronico = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Pago - Atributo: Chequeelectronico)" )
				endif 
			EndIf
		Else
			This.Setear_Chequeelectronico( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Visualizarenestadodecaja_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Visualizarenestadodecaja
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Visualizarenestadodecaja( lxVal )
				this.EventoAntesDeSetear( This, 'Visualizarenestadodecaja', lxValOld, lxVal  )
				this.Setear_Visualizarenestadodecaja( lxVal )
				this.EventoDespuesDeSetear( This, 'Visualizarenestadodecaja', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Visualizarenestadodecaja', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Visualizarenestadodecaja( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Letra', lxValOld, lxVal  )
				this.Setear_Letra( lxVal )
				this.EventoDespuesDeSetear( This, 'Letra', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Letra', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Letra( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nrodocumento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nrodocumento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nrodocumento( lxVal )
				this.EventoAntesDeSetear( This, 'Nrodocumento', lxValOld, lxVal  )
				this.Setear_Nrodocumento( lxVal )
				this.EventoDespuesDeSetear( This, 'Nrodocumento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nrodocumento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nrodocumento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodecomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodecomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipodecomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Tipodecomprobante', lxValOld, lxVal  )
				this.Setear_Tipodecomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodecomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipodecomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipodecomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodocumento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodocumento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipodocumento( lxVal )
				this.EventoAntesDeSetear( This, 'Tipodocumento', lxValOld, lxVal  )
				this.Setear_Tipodocumento( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodocumento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipodocumento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipodocumento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerotarjeta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerotarjeta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerotarjeta( lxVal )
				this.EventoAntesDeSetear( This, 'Numerotarjeta', lxValOld, lxVal  )
				this.Setear_Numerotarjeta( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerotarjeta', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerotarjeta', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numerotarjeta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vendedor( lxVal )
				this.EventoAntesDeSetear( This, 'Vendedor', lxValOld, lxVal  )
				this.Setear_Vendedor( lxVal )
				this.EventoDespuesDeSetear( This, 'Vendedor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Vendedor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Vendedor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valordetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valordetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Valordetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Valordetalle', lxValOld, lxVal  )
				this.Setear_Valordetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Valordetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Valordetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Valordetalle( lxVal ) 
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
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				this.Setear_Fecha( lxVal )
				this.EventoDespuesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fecha', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerointerno( lxVal )
				if ( this.lHabilitarNumerointerno or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Numerointerno', lxValOld, lxVal  )
					this.Setear_Numerointerno( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerointerno', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numerointerno', This )
						Endif
					EndIf
				else
					this.Numerointerno = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Pago - Atributo: Numerointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Numerointerno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Monto( lxVal )
				if ( this.lHabilitarMonto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Monto', lxValOld, lxVal  )
					this.Setear_Monto( lxVal )
				this.EventoDespuesDeSetear( This, 'Monto', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Monto', This )
						Endif
					EndIf
				else
					this.Monto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Pago - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Recargoporcentaje', lxValOld, lxVal  )
				this.Setear_Recargoporcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Recargoporcentaje', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recargoporcentaje', This )
					Endif
				EndIf
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
				this.EventoAntesDeSetear( This, 'Recargomonto', lxValOld, lxVal  )
				this.Setear_Recargomonto( lxVal )
				this.EventoDespuesDeSetear( This, 'Recargomonto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Recargomonto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recargomonto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Recargomonto( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Total', lxValOld, lxVal  )
				this.Setear_Total( lxVal )
				this.EventoDespuesDeSetear( This, 'Total', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Total', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Total', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Total( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Recargomontosinimpuestos', lxValOld, lxVal  )
				this.Setear_Recargomontosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Recargomontosinimpuestos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Recargomontosinimpuestos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recargomontosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Recargomontosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargosinpercepciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargosinpercepciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargosinpercepciones( lxVal )
				this.EventoAntesDeSetear( This, 'Recargosinpercepciones', lxValOld, lxVal  )
				this.Setear_Recargosinpercepciones( lxVal )
				this.EventoDespuesDeSetear( This, 'Recargosinpercepciones', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Recargosinpercepciones', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recargosinpercepciones', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Recargosinpercepciones( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Permitevuelto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Permitevuelto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Permitevuelto( lxVal )
				this.EventoAntesDeSetear( This, 'Permitevuelto', lxValOld, lxVal  )
				this.Setear_Permitevuelto( lxVal )
				this.EventoDespuesDeSetear( This, 'Permitevuelto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Permitevuelto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Permitevuelto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditemcomponente_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemcomponente
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemcomponente( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemcomponente', lxValOld, lxVal  )
				this.Setear_Iditemcomponente( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemcomponente', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemcomponente', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemcomponente( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaultcotizacion( txVal as variant ) as void

		this.Fechaultcotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechacomp( txVal as variant ) as void

		this.Fechacomp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Turno( txVal as variant ) as void

		this.Turno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ultimacotizacion( txVal as variant ) as void

		this.Ultimacotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Condicionrecargo( txVal as variant ) as void

		this.Condicionrecargo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Signo( txVal as variant ) as void

		this.Signo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cotiza( txVal as variant ) as void

		this.Cotiza = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pesosalcambio( txVal as variant ) as void

		this.Pesosalcambio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocupon( txVal as variant ) as void

		this.Numerocupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerodecomprobante( txVal as variant ) as void

		this.Numerodecomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Personalizarcomprobante( txVal as variant ) as void

		this.Personalizarcomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Chequeelectronico( txVal as variant ) as void

		this.Chequeelectronico = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Visualizarenestadodecaja( txVal as variant ) as void

		this.Visualizarenestadodecaja = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nrodocumento( txVal as variant ) as void

		this.Nrodocumento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodecomprobante( txVal as variant ) as void

		this.Tipodecomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodocumento( txVal as variant ) as void

		this.Tipodocumento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerotarjeta( txVal as variant ) as void

		this.Numerotarjeta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valordetalle( txVal as variant ) as void

		this.Valordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerointerno( txVal as variant ) as void

		this.Numerointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
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
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos( txVal as variant ) as void

		this.Recargomontosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargosinpercepciones( txVal as variant ) as void

		this.Recargosinpercepciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Permitevuelto( txVal as variant ) as void

		this.Permitevuelto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemcomponente( txVal as variant ) as void

		this.Iditemcomponente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaultcotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechacomp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Turno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ultimacotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Condicionrecargo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Signo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cotiza( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pesosalcambio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocupon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerodecomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Personalizarcomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Chequeelectronico( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Visualizarenestadodecaja( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nrodocumento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodecomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodocumento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerotarjeta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

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
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargosinpercepciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Permitevuelto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemcomponente( txVal as variant ) as Boolean

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
	function Numerocheque_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Numerocheque ) = 'O' or isnull( this.Numerocheque ) )
					this.Numerocheque = _Screen.zoo.instanciarentidad( 'Cheque' )
					this.Numerocheque.lEsSubEntidad = .t.
					this.enlazar( 'Numerocheque.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Numerocheque.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Numerocheque.CODIGO # this.Numerocheque_PK
						this.Numerocheque.CODIGO = this.Numerocheque_PK
					endif
				endif
			endif
		endif
		return this.Numerocheque
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerochequepropio_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Numerochequepropio ) = 'O' or isnull( this.Numerochequepropio ) )
					this.Numerochequepropio = _Screen.zoo.instanciarentidad( 'Chequepropio' )
					this.Numerochequepropio.lEsSubEntidad = .t.
					this.enlazar( 'Numerochequepropio.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Numerochequepropio.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Numerochequepropio.CODIGO # this.Numerochequepropio_PK
						this.Numerochequepropio.CODIGO = this.Numerochequepropio_PK
					endif
				endif
			endif
		endif
		return this.Numerochequepropio
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Valor ) = 'O' or isnull( this.Valor ) )
					this.Valor = _Screen.zoo.instanciarentidad( 'Valor' )
					this.Valor.lEsSubEntidad = .t.
					this.enlazar( 'Valor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Valor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Valor.CODIGO # this.Valor_PK
						this.Valor.CODIGO = this.Valor_PK
					endif
				endif
			endif
		endif
		return this.Valor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerovaledecambio_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Numerovaledecambio ) = 'O' or isnull( this.Numerovaledecambio ) )
					this.Numerovaledecambio = _Screen.zoo.instanciarentidad( 'Valedecambio' )
					this.Numerovaledecambio.lEsSubEntidad = .t.
					this.enlazar( 'Numerovaledecambio.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Numerovaledecambio.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Numerovaledecambio.CODIGO # this.Numerovaledecambio_PK
						this.Numerovaledecambio.CODIGO = this.Numerovaledecambio_PK
					endif
				endif
			endif
		endif
		return this.Numerovaledecambio
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompCajero_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompCajero ) = 'O' or isnull( this.oCompCajero ) )
			this.oCompCajero = _Screen.zoo.InstanciarComponente( 'ComponenteCajero' )
		this.oCompCajero.Inicializar()
		this.enlazar( 'oCompCajero.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompCajero.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompCajero
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechaultcotizacion = ctod( '  /  /    ' )
				.Fechacomp = ctod( '  /  /    ' )
				.Caja_PK = 0
				.Tipo = 0
				.Turno = 0
				.Ultimacotizacion = 0
				.Condicionrecargo = 0
				.Signo = 0
				.Puntodeventa = 0
				.Cotiza = 0
				.Pesosalcambio = 0
				.Numerocupon = 0
				.Numerodecomprobante = 0
				.Personalizarcomprobante = .F.
				.Chequeelectronico = .F.
				.Visualizarenestadodecaja = .F.
				.Letra = []
				.Nrodocumento = []
				.Tipodecomprobante = []
				.Tipodocumento = []
				.Numerotarjeta = []
				.Vendedor = []
				.Numerocheque_PK = []
				.Numerochequepropio_PK = []
				.Codigo = []
				.Valor_PK = []
				.Valordetalle = []
				.Fecha = ctod( '  /  /    ' )
				.Numerointerno = []
				.Monto = 0
				.Recargoporcentaje = 0
				.Recargomonto = 0
				.Total = 0
				.Recargomontosinimpuestos = 0
				.Recargosinpercepciones = 0
				.Permitevuelto = .F.
				.Iditemcomponente = []
				.Numerovaledecambio_PK = []
				.LimpiarAtributosVirtuales()
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				.lLimpiando = .f.
				if tlForzar
				else
					.SetearValoresSugeridos()
				endif
				if tlForzar
					.CambioSumarizado()
				endif
			EndTry
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function SetearValoresSugeridos() as Void
		With This
			.lEstaSeteandoValorSugerido = .T.
			If .EsNuevo() or .EsEdicion()
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
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWCondicionrecargo() as void
		with this
			.Condicionrecargo = 2
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCondicionrecargo() as void
		with this
			.ValorSugeridoFWCondicionrecargo()
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
	function Destroy()

		this.lDestroy = .t.
		this.oCompCajero = null
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		If this.oCompCajero.ValidarAtributo( txVal, tcAtributo )
		else
			llRetorno = .F.
		endif
		
		if llRetorno
		else
			goServicios.Errores.LevantarExcepcion( This.ObtenerInformacion() )
		endif
		
		Return llRetorno
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
	function ValidarExistenciaCamposFijos() as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarCaja_PK = tlHabilitar
		this.lHabilitarChequeElectronico = tlHabilitar
		this.lHabilitarNumeroInterno = tlHabilitar
		this.lHabilitarMonto = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMPAGOVALORES]
	endfunc

enddefine