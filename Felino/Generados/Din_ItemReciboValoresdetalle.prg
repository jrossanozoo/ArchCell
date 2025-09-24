
define class Din_ItemRECIBOValoresdetalle as ItemVALORESVENTA of ItemVALORESVENTA.prg

	cNombre = 'RECIBO'
	FechaUltCotizacion = ctod( '  /  /    ' )
	FechaComp = ctod( '  /  /    ' )
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	RecargoMontoEnPesos = 0
	DescuentoMontoEnPesos = 0
	DescuentoMontoSinImpuestos = 0
	MontoDesRecPesos = 0
	DescuentoPorcentaje = 0
	Cuotas = 0
	DescuentoMonto = 0
	nDiferenciaRedondeo = 0
	DiferenciaPorRedondeoDelRecibido = 0
	PorcentajeDiferenciaRedondeoRecibido = 0
	CantTipoValoresAcumulados = 0
	nCoeficienteImpuestos = 0
	CondicionRecargo = 0
	Signo = 0
	PuntoDeVenta = 0
	PesosAlCambio = 0
	NumerodeComprobante = 0
	Cotiza = 0
	NroItem = 0
	Turno = 0
	NumeroCupon = 0
	Tipo = 0
	UltimaCotizacion = 0
	EsAnulacion = .F.
	EsVuelto = .F.
	PersonalizarComprobante = .F.
	ChequeElectronico = .F.
	lHabilitarChequeElectronico = .T.
	VisualizarEnEstadoDeCaja = .F.
	EsRetiroEfectivo = .F.
	AutorizacionPOS = .F.
	NroDocumento = []
	Letra = []
	IdItemRetiroEnEfectivo = []
	NumeroTarjeta = []
	TipodeComprobante = []
	TipoDocumento = []
	IdItemValores = []
	Vendedor = []
	Redondeo = []
	NumeroCheque_PK = []
	NumeroCheque = null
	cAtributoPK = 'Codigo'
	Codigo = []
	NumeroChequePropio_PK = []
	NumeroChequePropio = null
	CondicionDePago_PK = []
	CondicionDePago = null
	Valor_PK = []
	Valor = null
	ValorDetalle = []
	Fecha = ctod( '  /  /    ' )
	NumeroInterno = []
	lHabilitarNumeroInterno = .T.
	MontoOri = 0
	AplicableParaVuelto = 0
	MontoAlCambio = 0
	Monto = 0
	lHabilitarMonto = .T.
	EsCuponHuerfano = .F.
	PorcentajeDesRec = 0
	RecargoPorcentaje = 0
	MontoDesRec = 0
	RecargoMonto = 0
	Total = 0
	RecibidoSugerido = 0
	Recibido = 0
	lHabilitarRecibido = .T.
	MontoAMonedaSistema = 0
	RecibidoAlCambio = 0
	RecargoMontoSinImpuestos = 0
	MontoCupon = 0
	RecargoSinPercepciones = 0
	PermiteVuelto = .F.
	IdItemComponente = []
	CodigoDeCupon = []
	NumeroValeDeCambio_PK = []
	NumeroValeDeCambio = null
	Cupon_PK = []
	Cupon = null
	lTieneImporteEnRecibido = .t.
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
		this.lHabilitarRecibido = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWCondicionrecargo()','Condicionrecargo')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWEsretiroefectivo()','Esretiroefectivo')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIditemvalores()','Iditemvalores')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'RECIBO', 'Valoresdetalle')
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Recibo - Atributo: Caja)" )
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
	function Condiciondepago_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Condiciondepago_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Condiciondepago_PK = lxVal

		if this.Validar_Condiciondepago( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Condiciondepago_Pk', lxValOld, lxVal  )
			This.Setear_Condiciondepago( lxVal )
			this.EventoDespuesDeSetear( This, 'Condiciondepago_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Condiciondepago_Pk', This )
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
			This.Valor_PK_DespuesDeAsignar()
			If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
				this.TotalizarSumarizado()
			EndIf
			If lxValOld != lxVal or empty( this.Tipo ) 
				this.Tipo = This.Valor.Tipo
			endif
			If lxValOld != lxVal or empty( this.Personalizarcomprobante ) 
				this.Personalizarcomprobante = This.Valor.PersonalizarComprobante
			endif
			If lxValOld != lxVal or empty( this.Chequeelectronico ) 
				this.Chequeelectronico = This.Valor.chequeelectronico
			endif
			If lxValOld != lxVal or empty( this.Visualizarenestadodecaja ) 
				this.Visualizarenestadodecaja = This.Valor.VisualizarEnCaja
			endif
			If lxValOld != lxVal or empty( this.Redondeo ) 
				this.Redondeo = This.Valor.Redondeo_PK
			endif
			If lxValOld != lxVal or empty( this.Permitevuelto ) 
				this.Permitevuelto = This.Valor.PermiteVuelto
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
	function Setear_Condiciondepago( txVal as variant ) as void

		this.Condiciondepago.CODIGO = txVal
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
	function Setear_Cupon( txVal as variant ) as void

		this.Cupon.CODIGO = txVal
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
	function Validar_Condiciondepago( txVal as variant, txValOld as variant ) as Boolean

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
	function Validar_Cupon( txVal as variant, txValOld as variant ) as Boolean

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
	function Recargomontoenpesos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recargomontoenpesos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recargomontoenpesos( lxVal )
				this.EventoAntesDeSetear( This, 'Recargomontoenpesos', lxValOld, lxVal  )
				this.Setear_Recargomontoenpesos( lxVal )
				this.EventoDespuesDeSetear( This, 'Recargomontoenpesos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Recargomontoenpesos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recargomontoenpesos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Recargomontoenpesos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentomontoenpesos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuentomontoenpesos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuentomontoenpesos( lxVal )
				this.EventoAntesDeSetear( This, 'Descuentomontoenpesos', lxValOld, lxVal  )
				this.Setear_Descuentomontoenpesos( lxVal )
				this.EventoDespuesDeSetear( This, 'Descuentomontoenpesos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Descuentomontoenpesos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descuentomontoenpesos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descuentomontoenpesos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentomontosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuentomontosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuentomontosinimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Descuentomontosinimpuestos', lxValOld, lxVal  )
				this.Setear_Descuentomontosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Descuentomontosinimpuestos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Descuentomontosinimpuestos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descuentomontosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descuentomontosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodesrecpesos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodesrecpesos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodesrecpesos( lxVal )
				this.EventoAntesDeSetear( This, 'Montodesrecpesos', lxValOld, lxVal  )
				this.Setear_Montodesrecpesos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodesrecpesos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montodesrecpesos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montodesrecpesos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montodesrecpesos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentoporcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuentoporcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuentoporcentaje( lxVal )
				this.EventoAntesDeSetear( This, 'Descuentoporcentaje', lxValOld, lxVal  )
				this.Setear_Descuentoporcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Descuentoporcentaje', lxValOld, lxVal  )
				 This.Descuentoporcentaje_DespuesDeAsignar()
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descuentoporcentaje', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descuentoporcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuotas_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuotas
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuotas( lxVal )
				this.EventoAntesDeSetear( This, 'Cuotas', lxValOld, lxVal  )
				this.Setear_Cuotas( lxVal )
				this.EventoDespuesDeSetear( This, 'Cuotas', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cuotas', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cuotas( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentomonto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuentomonto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuentomonto( lxVal )
				this.EventoAntesDeSetear( This, 'Descuentomonto', lxValOld, lxVal  )
				this.Setear_Descuentomonto( lxVal )
				this.EventoDespuesDeSetear( This, 'Descuentomonto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Descuentomonto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descuentomonto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descuentomonto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ndiferenciaredondeo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ndiferenciaredondeo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ndiferenciaredondeo( lxVal )
				this.EventoAntesDeSetear( This, 'Ndiferenciaredondeo', lxValOld, lxVal  )
				this.Setear_Ndiferenciaredondeo( lxVal )
				this.EventoDespuesDeSetear( This, 'Ndiferenciaredondeo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ndiferenciaredondeo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ndiferenciaredondeo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Diferenciaporredondeodelrecibido_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Diferenciaporredondeodelrecibido
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Diferenciaporredondeodelrecibido( lxVal )
				this.EventoAntesDeSetear( This, 'Diferenciaporredondeodelrecibido', lxValOld, lxVal  )
				this.Setear_Diferenciaporredondeodelrecibido( lxVal )
				this.EventoDespuesDeSetear( This, 'Diferenciaporredondeodelrecibido', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Diferenciaporredondeodelrecibido', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Diferenciaporredondeodelrecibido( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajediferenciaredondeorecibido_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajediferenciaredondeorecibido
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajediferenciaredondeorecibido( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajediferenciaredondeorecibido', lxValOld, lxVal  )
				this.Setear_Porcentajediferenciaredondeorecibido( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajediferenciaredondeorecibido', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajediferenciaredondeorecibido', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajediferenciaredondeorecibido( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Canttipovaloresacumulados_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Canttipovaloresacumulados
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Canttipovaloresacumulados( lxVal )
				this.EventoAntesDeSetear( This, 'Canttipovaloresacumulados', lxValOld, lxVal  )
				this.Setear_Canttipovaloresacumulados( lxVal )
				this.EventoDespuesDeSetear( This, 'Canttipovaloresacumulados', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Canttipovaloresacumulados', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Canttipovaloresacumulados( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ncoeficienteimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ncoeficienteimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ncoeficienteimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Ncoeficienteimpuestos', lxValOld, lxVal  )
				this.Setear_Ncoeficienteimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Ncoeficienteimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ncoeficienteimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ncoeficienteimpuestos( lxVal ) 
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
	function Esanulacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Esanulacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Esanulacion( lxVal )
				this.EventoAntesDeSetear( This, 'Esanulacion', lxValOld, lxVal  )
				this.Setear_Esanulacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Esanulacion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Esanulacion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Esanulacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Esvuelto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Esvuelto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Esvuelto( lxVal )
				this.EventoAntesDeSetear( This, 'Esvuelto', lxValOld, lxVal  )
				this.Setear_Esvuelto( lxVal )
				this.EventoDespuesDeSetear( This, 'Esvuelto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Esvuelto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Esvuelto( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Recibo - Atributo: Chequeelectronico)" )
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
	function Esretiroefectivo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Esretiroefectivo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Esretiroefectivo( lxVal )
				this.EventoAntesDeSetear( This, 'Esretiroefectivo', lxValOld, lxVal  )
				this.Setear_Esretiroefectivo( lxVal )
				this.EventoDespuesDeSetear( This, 'Esretiroefectivo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Esretiroefectivo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Esretiroefectivo( lxVal ) 
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
	function Iditemretiroenefectivo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemretiroenefectivo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemretiroenefectivo( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemretiroenefectivo', lxValOld, lxVal  )
				this.Setear_Iditemretiroenefectivo( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemretiroenefectivo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemretiroenefectivo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemretiroenefectivo( lxVal ) 
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
	function Iditemvalores_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemvalores
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemvalores( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemvalores', lxValOld, lxVal  )
				this.Setear_Iditemvalores( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemvalores', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemvalores', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemvalores( lxVal ) 
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
	function Redondeo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Redondeo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Redondeo( lxVal )
				this.EventoAntesDeSetear( This, 'Redondeo', lxValOld, lxVal  )
				this.Setear_Redondeo( lxVal )
				this.EventoDespuesDeSetear( This, 'Redondeo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Redondeo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Redondeo( lxVal ) 
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
					 This.Numerointerno_DespuesDeAsignar()
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numerointerno', This )
						Endif
					EndIf
				else
					this.Numerointerno = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Recibo - Atributo: Numerointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Numerointerno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoori_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoori
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoori( lxVal )
				this.EventoAntesDeSetear( This, 'Montoori', lxValOld, lxVal  )
				this.Setear_Montoori( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoori', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoori', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoori( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Aplicableparavuelto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Aplicableparavuelto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Aplicableparavuelto( lxVal )
				this.EventoAntesDeSetear( This, 'Aplicableparavuelto', lxValOld, lxVal  )
				this.Setear_Aplicableparavuelto( lxVal )
				this.EventoDespuesDeSetear( This, 'Aplicableparavuelto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Aplicableparavuelto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Aplicableparavuelto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Aplicableparavuelto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoalcambio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoalcambio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoalcambio( lxVal )
				this.EventoAntesDeSetear( This, 'Montoalcambio', lxValOld, lxVal  )
				this.Setear_Montoalcambio( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoalcambio', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montoalcambio', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoalcambio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoalcambio( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Recibo - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escuponhuerfano_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Escuponhuerfano
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Escuponhuerfano( lxVal )
				this.EventoAntesDeSetear( This, 'Escuponhuerfano', lxValOld, lxVal  )
				this.Setear_Escuponhuerfano( lxVal )
				this.EventoDespuesDeSetear( This, 'Escuponhuerfano', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Escuponhuerfano', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Escuponhuerfano( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedesrec_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedesrec
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedesrec( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajedesrec', lxValOld, lxVal  )
				this.Setear_Porcentajedesrec( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajedesrec', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajedesrec', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajedesrec( lxVal ) 
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
	function Montodesrec_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodesrec
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodesrec( lxVal )
				this.EventoAntesDeSetear( This, 'Montodesrec', lxValOld, lxVal  )
				this.Setear_Montodesrec( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodesrec', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montodesrec', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montodesrec', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montodesrec( lxVal ) 
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
				 This.Recargomonto_DespuesDeAsignar()
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
	function Recibidosugerido_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recibidosugerido
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recibidosugerido( lxVal )
				this.EventoAntesDeSetear( This, 'Recibidosugerido', lxValOld, lxVal  )
				this.Setear_Recibidosugerido( lxVal )
				this.EventoDespuesDeSetear( This, 'Recibidosugerido', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recibidosugerido', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Recibidosugerido( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recibido_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recibido
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recibido( lxVal )
				if ( this.lHabilitarRecibido or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Recibido', lxValOld, lxVal  )
					this.Setear_Recibido( lxVal )
				this.EventoDespuesDeSetear( This, 'Recibido', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Recibido', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Recibido', This )
						Endif
					EndIf
				else
					this.Recibido = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Recibo - Atributo: Recibido)" )
				endif 
			EndIf
		Else
			This.Setear_Recibido( lxVal ) 
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
	function Recibidoalcambio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recibidoalcambio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Recibidoalcambio( lxVal )
				this.EventoAntesDeSetear( This, 'Recibidoalcambio', lxValOld, lxVal  )
				this.Setear_Recibidoalcambio( lxVal )
				this.EventoDespuesDeSetear( This, 'Recibidoalcambio', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Recibidoalcambio', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Recibidoalcambio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Recibidoalcambio( lxVal ) 
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
	function Setear_Recargomontoenpesos( txVal as variant ) as void

		this.Recargomontoenpesos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuentomontoenpesos( txVal as variant ) as void

		this.Descuentomontoenpesos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuentomontosinimpuestos( txVal as variant ) as void

		this.Descuentomontosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodesrecpesos( txVal as variant ) as void

		this.Montodesrecpesos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuentoporcentaje( txVal as variant ) as void

		this.Descuentoporcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuotas( txVal as variant ) as void

		this.Cuotas = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuentomonto( txVal as variant ) as void

		this.Descuentomonto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ndiferenciaredondeo( txVal as variant ) as void

		this.Ndiferenciaredondeo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Diferenciaporredondeodelrecibido( txVal as variant ) as void

		this.Diferenciaporredondeodelrecibido = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajediferenciaredondeorecibido( txVal as variant ) as void

		this.Porcentajediferenciaredondeorecibido = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Canttipovaloresacumulados( txVal as variant ) as void

		this.Canttipovaloresacumulados = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ncoeficienteimpuestos( txVal as variant ) as void

		this.Ncoeficienteimpuestos = txVal
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
	function Setear_Pesosalcambio( txVal as variant ) as void

		this.Pesosalcambio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerodecomprobante( txVal as variant ) as void

		this.Numerodecomprobante = txVal
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
	function Setear_Turno( txVal as variant ) as void

		this.Turno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocupon( txVal as variant ) as void

		this.Numerocupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ultimacotizacion( txVal as variant ) as void

		this.Ultimacotizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Esanulacion( txVal as variant ) as void

		this.Esanulacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Esvuelto( txVal as variant ) as void

		this.Esvuelto = txVal
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
	function Setear_Esretiroefectivo( txVal as variant ) as void

		this.Esretiroefectivo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Autorizacionpos( txVal as variant ) as void

		this.Autorizacionpos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nrodocumento( txVal as variant ) as void

		this.Nrodocumento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemretiroenefectivo( txVal as variant ) as void

		this.Iditemretiroenefectivo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerotarjeta( txVal as variant ) as void

		this.Numerotarjeta = txVal
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
	function Setear_Iditemvalores( txVal as variant ) as void

		this.Iditemvalores = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Redondeo( txVal as variant ) as void

		this.Redondeo = txVal
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
	function Setear_Montoori( txVal as variant ) as void

		this.Montoori = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Aplicableparavuelto( txVal as variant ) as void

		this.Aplicableparavuelto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoalcambio( txVal as variant ) as void

		this.Montoalcambio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escuponhuerfano( txVal as variant ) as void

		this.Escuponhuerfano = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedesrec( txVal as variant ) as void

		this.Porcentajedesrec = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargoporcentaje( txVal as variant ) as void

		this.Recargoporcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodesrec( txVal as variant ) as void

		this.Montodesrec = txVal
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
	function Setear_Recibidosugerido( txVal as variant ) as void

		this.Recibidosugerido = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recibido( txVal as variant ) as void

		this.Recibido = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoamonedasistema( txVal as variant ) as void

		this.Montoamonedasistema = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recibidoalcambio( txVal as variant ) as void

		this.Recibidoalcambio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos( txVal as variant ) as void

		this.Recargomontosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montocupon( txVal as variant ) as void

		this.Montocupon = txVal
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
	function Setear_Codigodecupon( txVal as variant ) as void

		this.Codigodecupon = txVal
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
	function Validar_Recargomontoenpesos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentomontoenpesos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentomontosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodesrecpesos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentoporcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuotas( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentomonto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ndiferenciaredondeo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Diferenciaporredondeodelrecibido( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajediferenciaredondeorecibido( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Canttipovaloresacumulados( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ncoeficienteimpuestos( txVal as variant ) as Boolean

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
	function Validar_Pesosalcambio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerodecomprobante( txVal as variant ) as Boolean

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
	function Validar_Turno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocupon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ultimacotizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Esanulacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Esvuelto( txVal as variant ) as Boolean

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
	function Validar_Esretiroefectivo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Autorizacionpos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nrodocumento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemretiroenefectivo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerotarjeta( txVal as variant ) as Boolean

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
	function Validar_Iditemvalores( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Redondeo( txVal as variant ) as Boolean

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
	function Validar_Montoori( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Aplicableparavuelto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoalcambio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escuponhuerfano( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedesrec( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargoporcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodesrec( txVal as variant ) as Boolean

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
	function Validar_Recibidosugerido( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recibido( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoamonedasistema( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recibidoalcambio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montocupon( txVal as variant ) as Boolean

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
	function Validar_Codigodecupon( txVal as variant ) as Boolean

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
	function Condiciondepago_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Condiciondepago ) = 'O' or isnull( this.Condiciondepago ) )
					this.Condiciondepago = _Screen.zoo.instanciarentidad( 'Condiciondepago' )
					this.Condiciondepago.lEsSubEntidad = .t.
					this.enlazar( 'Condiciondepago.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Condiciondepago.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Condiciondepago.CODIGO # this.Condiciondepago_PK
						this.Condiciondepago.CODIGO = this.Condiciondepago_PK
					endif
				endif
			endif
		endif
		return this.Condiciondepago
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

				.Fechaultcotizacion = ctod( '  /  /    ' )
				.Fechacomp = ctod( '  /  /    ' )
				.Caja_PK = 0
				.Recargomontoenpesos = 0
				.Descuentomontoenpesos = 0
				.Descuentomontosinimpuestos = 0
				.Montodesrecpesos = 0
				.Descuentoporcentaje = 0
				.Descuentomonto = 0
				.Signo = 0
				.Puntodeventa = 0
				.Pesosalcambio = 0
				.Numerodecomprobante = 0
				.Cotiza = 0
				.Turno = 0
				.Numerocupon = 0
				.Tipo = 0
				.Ultimacotizacion = 0
				.Esvuelto = .F.
				.Personalizarcomprobante = .F.
				.Chequeelectronico = .F.
				.Visualizarenestadodecaja = .F.
				.Esretiroefectivo = .F.
				.Autorizacionpos = .F.
				.Nrodocumento = []
				.Letra = []
				.Iditemretiroenefectivo = []
				.Numerotarjeta = []
				.Tipodecomprobante = []
				.Tipodocumento = []
				.Iditemvalores = []
				.Vendedor = []
				.Redondeo = []
				.Numerocheque_PK = []
				.Codigo = []
				.Numerochequepropio_PK = []
				.Condiciondepago_PK = []
				.Valor_PK = []
				.Valordetalle = []
				.Fecha = ctod( '  /  /    ' )
				.Numerointerno = []
				.Monto = 0
				.Porcentajedesrec = 0
				.Recargoporcentaje = 0
				.Montodesrec = 0
				.Recargomonto = 0
				.Total = 0
				.Recibido = 0
				.Montoamonedasistema = 0
				.Recibidoalcambio = 0
				.Recargomontosinimpuestos = 0
				.Montocupon = 0
				.Recargosinpercepciones = 0
				.Permitevuelto = .F.
				.Iditemcomponente = []
				.Codigodecupon = []
				.Numerovaledecambio_PK = []
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
	Function ValorSugeridoFWEsretiroefectivo() as void
		with this
			.Esretiroefectivo = .F.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEsretiroefectivo() as void
		with this
			.ValorSugeridoFWEsretiroefectivo()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWIditemvalores() as void
		with this
			.Iditemvalores = goServicios.Librerias.ObtenerGuidPk()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIditemvalores() as void
		with this
			.ValorSugeridoFWIditemvalores()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoValor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "RECIBO", "Valoresdetalle", "Valor" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Valor para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumerointerno() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "RECIBO", "Valoresdetalle", "Numerointerno" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo N.Int para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRecibido() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "RECIBO", "Valoresdetalle", "Recibido" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Recibido' )
						.Recibido = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Recibido para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function Descuentoporcentaje_DespuesDeAsignar() as void
		This.ProcesarDespuesDeSetearPorcentajeDeDescuento()                                                 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerointerno_DespuesDeAsignar() as void
		this.ProcesarDespuesDeSetearValorCheque()                                                           
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recargomonto_DespuesDeAsignar() as void
		this.ProcesarDespuesDeSetearPorcentajeDeRecargo()                                                   
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
			.Cuotas = 0
			.Ndiferenciaredondeo = 0
			.Diferenciaporredondeodelrecibido = 0
			.Porcentajediferenciaredondeorecibido = 0
			.Canttipovaloresacumulados = 0
			.Ncoeficienteimpuestos = 0
			.Condicionrecargo = 0
			.Esanulacion = .F.
			.Montoori = 0
			.Aplicableparavuelto = 0
			.Montoalcambio = 0
			.Escuponhuerfano = .F.
			.Recibidosugerido = 0
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
		this.lHabilitarRecibido = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMVALORES]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.VALOR_PK) and dodefault()
		return llRetorno
	endfunc

enddefine