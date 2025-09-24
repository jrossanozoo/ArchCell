
define class Din_ItemCANJEDECUPONESValoresaent as ItemValoresAEnt of ItemValoresAEnt.prg

	cNombre = 'CANJEDECUPONES'
	FechaComp = ctod( '  /  /    ' )
	FechaUltCotizacion = ctod( '  /  /    ' )
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	NumeroTarjeta = []
	Cotiza = 0
	SignodeMovimiento = 0
	NROITEM = 0
	Tipo = 0
	NumeroCupon = 0
	UltimaCotizacion = 0
	VisualizarEnEstadoDeCaja = .F.
	AutorizacionPOS = .F.
	ChequeElectronico = .F.
	lHabilitarChequeElectronico = .T.
	Valor_PK = []
	Valor = null
	NumeroCheque_PK = []
	NumeroCheque = null
	NumeroChequePropio_PK = []
	NumeroChequePropio = null
	cAtributoPK = 'Codigo'
	Codigo = []
	LetraComprobante = []
	ValorDetalle = []
	Fecha = ctod( '  /  /    ' )
	PuntoDeVentaComprobante = 0
	NroComprobante = 0
	NumeroInterno = []
	lHabilitarNumeroInterno = .T.
	CuponTipo = []
	FechaComprobante = ctod( '  /  /    ' )
	ComprobanteOrigen = []
	TipoComprobante = []
	BaseDeDatosOrigen = []
	Hora = []
	SerieOrigen = []
	Total = 0
	Monto = 0
	lHabilitarMonto = .T.
	PesosAlCambio = 0
	MontoAMonedaSistema = 0
	MontoCupon = 0
	CodigoDeCupon = []
	IdItemComponente = []
	Cupon_PK = []
	Cupon = null
	lTieneImporteEnRecibido = .f.
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSignodemovimiento()','Signodemovimiento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CANJEDECUPONES', 'Valoresaent')
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Caja)" )
			endif 
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
			This.Valor_PK_DespuesDeAsignar()
			If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
				this.TotalizarSumarizado()
			EndIf
			If lxValOld != lxVal or empty( this.Tipo ) 
				this.Tipo = This.Valor.Tipo
			endif
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
	function Cupon_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cupon_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Cupon_PK = lxVal

		if this.Validar_Cupon( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Cupon_Pk', lxValOld, lxVal  )
			This.Setear_Cupon( lxVal )
			this.EventoDespuesDeSetear( This, 'Cupon_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Letracomprobante ) 
				this.Letracomprobante = This.Cupon.LetraComprobante
			endif
			If lxValOld != lxVal or empty( this.Puntodeventacomprobante ) 
				this.Puntodeventacomprobante = This.Cupon.PuntoDeVentaComprobante
			endif
			If lxValOld != lxVal or empty( this.Cupontipo ) 
				this.Cupontipo = This.Cupon.TipoCupon
			endif
			If lxValOld != lxVal or empty( this.Fechacomprobante ) 
				this.Fechacomprobante = This.Cupon.FechaComprobante
			endif
			If lxValOld != lxVal or empty( this.Basededatosorigen ) 
				this.Basededatosorigen = This.Cupon.BaseDeDatos
			endif
			If lxValOld != lxVal or empty( this.Hora ) 
				this.Hora = This.Cupon.HoraCupon
			endif
			If lxValOld != lxVal or empty( this.Serieorigen ) 
				this.Serieorigen = This.Cupon.SerieOrigen
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Cupon_Pk', This )
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
	function Setear_Valor( txVal as variant ) as void

		this.Valor.CODIGO = txVal
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
	function Setear_Cupon( txVal as variant ) as void

		this.Cupon.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Caja( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valor( txVal as variant, txValOld as variant ) as Boolean

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
	function Validar_Cupon( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Signodemovimiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Signodemovimiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Signodemovimiento( lxVal )
				this.EventoAntesDeSetear( This, 'Signodemovimiento', lxValOld, lxVal  )
				this.Setear_Signodemovimiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Signodemovimiento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Signodemovimiento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Signodemovimiento( lxVal ) 
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
	function Autorizacionpos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Autorizacionpos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Autorizacionpos( lxVal )
				this.EventoAntesDeSetear( This, 'Autorizacionpos', lxValOld, lxVal  )
				this.Setear_Autorizacionpos( lxVal )
				this.EventoDespuesDeSetear( This, 'Autorizacionpos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Autorizacionpos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Autorizacionpos( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Chequeelectronico)" )
				endif 
			EndIf
		Else
			This.Setear_Chequeelectronico( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Letracomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letracomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letracomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Letracomprobante', lxValOld, lxVal  )
				this.Setear_Letracomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Letracomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Letracomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Letracomprobante( lxVal ) 
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
	function Puntodeventacomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventacomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventacomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Puntodeventacomprobante', lxValOld, lxVal  )
				this.Setear_Puntodeventacomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Puntodeventacomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Puntodeventacomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Puntodeventacomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nrocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nrocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nrocomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Nrocomprobante', lxValOld, lxVal  )
				this.Setear_Nrocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Nrocomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nrocomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nrocomprobante( lxVal ) 
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
					 This.Numerointerno_DespuesDeAsignar()
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numerointerno', This )
						Endif
					EndIf
				else
					this.Numerointerno = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Numerointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Numerointerno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cupontipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cupontipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cupontipo( lxVal )
				this.EventoAntesDeSetear( This, 'Cupontipo', lxValOld, lxVal  )
				this.Setear_Cupontipo( lxVal )
				this.EventoDespuesDeSetear( This, 'Cupontipo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cupontipo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cupontipo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechacomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechacomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechacomprobante( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fechacomprobante', lxValOld, lxVal  )
				this.Setear_Fechacomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechacomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechacomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechacomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobanteorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobanteorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobanteorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Comprobanteorigen', lxValOld, lxVal  )
				this.Setear_Comprobanteorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobanteorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comprobanteorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comprobanteorigen( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Tipocomprobante', lxValOld, lxVal  )
				this.Setear_Tipocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipocomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipocomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Basededatosorigen', lxValOld, lxVal  )
				this.Setear_Basededatosorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Basededatosorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Basededatosorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Basededatosorigen( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Hora', lxValOld, lxVal  )
				this.Setear_Hora( lxVal )
				this.EventoDespuesDeSetear( This, 'Hora', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Hora', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Hora( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Serieorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Serieorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Serieorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Serieorigen', lxValOld, lxVal  )
				this.Setear_Serieorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Serieorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Serieorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Serieorigen( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
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
	function Montoamonedasistema_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoamonedasistema
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoamonedasistema( lxVal )
				this.EventoAntesDeSetear( This, 'Montoamonedasistema', lxValOld, lxVal  )
				this.Setear_Montoamonedasistema( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoamonedasistema', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoamonedasistema', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoamonedasistema( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montocupon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montocupon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montocupon( lxVal )
				this.EventoAntesDeSetear( This, 'Montocupon', lxValOld, lxVal  )
				this.Setear_Montocupon( lxVal )
				this.EventoDespuesDeSetear( This, 'Montocupon', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montocupon', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montocupon( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigodecupon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigodecupon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigodecupon( lxVal )
				this.EventoAntesDeSetear( This, 'Codigodecupon', lxValOld, lxVal  )
				this.Setear_Codigodecupon( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigodecupon', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigodecupon', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigodecupon( lxVal ) 
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
	function Setear_Fechacomp( txVal as variant ) as void

		this.Fechacomp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaultcotizacion( txVal as variant ) as void

		this.Fechaultcotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerotarjeta( txVal as variant ) as void

		this.Numerotarjeta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cotiza( txVal as variant ) as void

		this.Cotiza = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Signodemovimiento( txVal as variant ) as void

		this.Signodemovimiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocupon( txVal as variant ) as void

		this.Numerocupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ultimacotizacion( txVal as variant ) as void

		this.Ultimacotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Visualizarenestadodecaja( txVal as variant ) as void

		this.Visualizarenestadodecaja = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Autorizacionpos( txVal as variant ) as void

		this.Autorizacionpos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Chequeelectronico( txVal as variant ) as void

		this.Chequeelectronico = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letracomprobante( txVal as variant ) as void

		this.Letracomprobante = txVal
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
	function Setear_Puntodeventacomprobante( txVal as variant ) as void

		this.Puntodeventacomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nrocomprobante( txVal as variant ) as void

		this.Nrocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerointerno( txVal as variant ) as void

		this.Numerointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cupontipo( txVal as variant ) as void

		this.Cupontipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechacomprobante( txVal as variant ) as void

		this.Fechacomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobanteorigen( txVal as variant ) as void

		this.Comprobanteorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosorigen( txVal as variant ) as void

		this.Basededatosorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Hora( txVal as variant ) as void

		this.Hora = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Serieorigen( txVal as variant ) as void

		this.Serieorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pesosalcambio( txVal as variant ) as void

		this.Pesosalcambio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoamonedasistema( txVal as variant ) as void

		this.Montoamonedasistema = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montocupon( txVal as variant ) as void

		this.Montocupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigodecupon( txVal as variant ) as void

		this.Codigodecupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemcomponente( txVal as variant ) as void

		this.Iditemcomponente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechacomp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaultcotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerotarjeta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cotiza( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Signodemovimiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocupon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ultimacotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Visualizarenestadodecaja( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Autorizacionpos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Chequeelectronico( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letracomprobante( txVal as variant ) as Boolean

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
	function Validar_Puntodeventacomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nrocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cupontipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechacomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobanteorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Hora( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Serieorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pesosalcambio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoamonedasistema( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montocupon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigodecupon( txVal as variant ) as Boolean

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
	function Cupon_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cupon ) = 'O' or isnull( this.Cupon ) )
					this.Cupon = _Screen.zoo.instanciarentidad( 'Cupon' )
					this.Cupon.lEsSubEntidad = .t.
					this.enlazar( 'Cupon.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cupon.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cupon.CODIGO # this.Cupon_PK
						this.Cupon.CODIGO = this.Cupon_PK
					endif
				endif
			endif
		endif
		return this.Cupon
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
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( transform( This.Numero, "@LZ 99999999" ) ) )
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

				.Fechacomp = ctod( '  /  /    ' )
				.Fechaultcotizacion = ctod( '  /  /    ' )
				.Caja_PK = 0
				.Numerotarjeta = []
				.Cotiza = 0
				.Signodemovimiento = 0
				.Tipo = 0
				.Numerocupon = 0
				.Ultimacotizacion = 0
				.Visualizarenestadodecaja = .F.
				.Autorizacionpos = .F.
				.Chequeelectronico = .F.
				.Valor_PK = []
				.Numerocheque_PK = []
				.Numerochequepropio_PK = []
				.Codigo = []
				.Letracomprobante = []
				.Valordetalle = []
				.Fecha = ctod( '  /  /    ' )
				.Puntodeventacomprobante = 0
				.Nrocomprobante = 0
				.Numerointerno = []
				.Cupontipo = []
				.Fechacomprobante = ctod( '  /  /    ' )
				.Tipocomprobante = []
				.Basededatosorigen = []
				.Hora = []
				.Serieorigen = []
				.Total = 0
				.Monto = 0
				.Pesosalcambio = 0
				.Montoamonedasistema = 0
				.Montocupon = 0
				.Codigodecupon = []
				.Iditemcomponente = []
				.Cupon_PK = []
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
	Function ValorSugeridoValor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "Valoresaent", "Valor" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Valor_PK' )
						.Valor_PK = lvValorSugeridoDefinidoPorElUsuario
						.Valor.CODIGO = .Valor_PK
					endif
				endif
			Catch to loError
				.Valor_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Valor para el detalle Valores a entregar." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFecha() as void
		with this
			.Fecha = This.oEntidad.Fecha
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha() as void
		with this
			.ValorSugeridoFWFecha()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumerointerno() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "Valoresaent", "Numerointerno" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numerointerno' )
						.Numerointerno = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. int. para el detalle Valores a entregar." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMonto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "Valoresaent", "Monto" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Monto' )
						.Monto = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto para el detalle Valores a entregar." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function Valor_PK_DespuesDeAsignar() as void
		This.ProcesarDespuesDeSetearValor()                                                                 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerointerno_DespuesDeAsignar() as void
		This.ProcesarDespuesDeSetearValorConNumeroInterno()                                                 
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
			.Comprobanteorigen = []
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

		if  empty( this.Valor_PK ) 
			llRetorno = .F.
		endif 
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
		return [ITEMVALORESAENT]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.VALOR_PK) and dodefault()
		return llRetorno
	endfunc

enddefine