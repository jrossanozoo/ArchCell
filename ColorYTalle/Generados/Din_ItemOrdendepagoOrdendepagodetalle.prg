
define class Din_ItemORDENDEPAGOOrdendepagodetalle as ItemActivo of ItemActivo.prg

	cNombre = 'ORDENDEPAGO'
	Fecha = ctod( '  /  /    ' )
	lHabilitarFecha = .T.
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	CodigoComprobante = []
	lHabilitarCodigoComprobante = .T.
	TipoDeComprobante = []
	lHabilitarTipoDeComprobante = .T.
	Letra = []
	lHabilitarLetra = .T.
	NROITEM = 0
	lHabilitarNROITEM = .T.
	TotalComprobanteConImpuestos = 0
	lHabilitarTotalComprobanteConImpuestos = .T.
	CuentaParaImpresion = 0
	lHabilitarCuentaParaImpresion = .T.
	TotalComprobanteSinImpuestos = 0
	lHabilitarTotalComprobanteSinImpuestos = .T.
	TotalComprobanteIva = 0
	lHabilitarTotalComprobanteIva = .T.
	TotalComprobanteGravado = 0
	lHabilitarTotalComprobanteGravado = .T.
	Tipo = 0
	lHabilitarTipo = .T.
	RecargoSinPercepciones = 0
	lHabilitarRecargoSinPercepciones = .T.
	PuntoDeVenta = 0
	lHabilitarPuntoDeVenta = .T.
	NumeroDeComprobante = 0
	lHabilitarNumeroDeComprobante = .T.
	EsPagoACuenta = .F.
	lHabilitarEsPagoACuenta = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Valor_PK = []
	Valor = null
	lHabilitarValor_PK = .T.
	Emision = ctod( '  /  /    ' )
	lHabilitarEmision = .T.
	Vencimiento = ctod( '  /  /    ' )
	lHabilitarVencimiento = .T.
	Descripcion = []
	lHabilitarDescripcion = .T.
	Anotacion = []
	lHabilitarAnotacion = .T.
	SaldoAux = 0
	lHabilitarSaldoAux = .T.
	Monto = 0
	lHabilitarMonto = .T.
	oCompCuentaCorrienteOrdenDePagoCompras = null
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarFecha = .T.
		this.lHabilitarCaja_PK = .T.
		this.lHabilitarCodigoComprobante = .T.
		this.lHabilitarTipoDeComprobante = .T.
		this.lHabilitarLetra = .T.
		this.lHabilitarNROITEM = .T.
		this.lHabilitarTotalComprobanteConImpuestos = .T.
		this.lHabilitarCuentaParaImpresion = .T.
		this.lHabilitarTotalComprobanteSinImpuestos = .T.
		this.lHabilitarTotalComprobanteIva = .T.
		this.lHabilitarTotalComprobanteGravado = .T.
		this.lHabilitarTipo = .T.
		this.lHabilitarRecargoSinPercepciones = .T.
		this.lHabilitarPuntoDeVenta = .T.
		this.lHabilitarNumeroDeComprobante = .T.
		this.lHabilitarEsPagoACuenta = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarValor_PK = .T.
		this.lHabilitarEmision = .T.
		this.lHabilitarVencimiento = .T.
		this.lHabilitarDescripcion = .T.
		this.lHabilitarAnotacion = .T.
		this.lHabilitarSaldoAux = .T.
		this.lHabilitarMonto = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ORDENDEPAGO', 'Ordendepagodetalle')
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Caja)" )
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
			if ( this.lHabilitarValor_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Valor_Pk', lxValOld, lxVal  )
				This.Setear_Valor( lxVal )
				this.EventoDespuesDeSetear( This, 'Valor_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Tipo ) 
				this.Tipo = This.Valor.Tipo
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Valor_Pk', This )
					Endif
				EndIf
			else
				this.Valor_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Valor)" )
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
	function Setear_Valor( txVal as variant ) as void

		this.Valor.CODIGO = txVal
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
	function Fecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha( lxVal )
				if ( this.lHabilitarFecha or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fecha( lxVal )
					this.EventoAntesDeSetear( This, 'Fecha', lxValOld, lxVal  )
					this.Setear_Fecha( lxVal )
				this.EventoDespuesDeSetear( This, 'Fecha', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Fecha', This )
						Endif
					EndIf
				else
					this.Fecha = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Fecha)" )
				endif 
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigocomprobante( lxVal )
				if ( this.lHabilitarCodigocomprobante or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Codigocomprobante', lxValOld, lxVal  )
					this.Setear_Codigocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigocomprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Codigocomprobante', This )
						Endif
					EndIf
				else
					this.Codigocomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Codigocomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Codigocomprobante( lxVal ) 
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
				if ( this.lHabilitarTipodecomprobante or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Tipodecomprobante', lxValOld, lxVal  )
					this.Setear_Tipodecomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodecomprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tipodecomprobante', This )
						Endif
					EndIf
				else
					this.Tipodecomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Tipodecomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Tipodecomprobante( lxVal ) 
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
				if ( this.lHabilitarLetra or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Letra', lxValOld, lxVal  )
					this.Setear_Letra( lxVal )
				this.EventoDespuesDeSetear( This, 'Letra', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Letra', This )
						Endif
					EndIf
				else
					this.Letra = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Letra)" )
				endif 
			EndIf
		Else
			This.Setear_Letra( lxVal ) 
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
				if ( this.lHabilitarNroitem or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
					this.Setear_Nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Nroitem', This )
						Endif
					EndIf
				else
					this.Nroitem = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalcomprobanteconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalcomprobanteconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalcomprobanteconimpuestos( lxVal )
				if ( this.lHabilitarTotalcomprobanteconimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Totalcomprobanteconimpuestos', lxValOld, lxVal  )
					this.Setear_Totalcomprobanteconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Totalcomprobanteconimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Totalcomprobanteconimpuestos', This )
						Endif
					EndIf
				else
					this.Totalcomprobanteconimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Totalcomprobanteconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Totalcomprobanteconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuentaparaimpresion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuentaparaimpresion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuentaparaimpresion( lxVal )
				if ( this.lHabilitarCuentaparaimpresion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Cuentaparaimpresion', lxValOld, lxVal  )
					this.Setear_Cuentaparaimpresion( lxVal )
				this.EventoDespuesDeSetear( This, 'Cuentaparaimpresion', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Cuentaparaimpresion', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cuentaparaimpresion', This )
						Endif
					EndIf
				else
					this.Cuentaparaimpresion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Cuentaparaimpresion)" )
				endif 
			EndIf
		Else
			This.Setear_Cuentaparaimpresion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalcomprobantesinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalcomprobantesinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalcomprobantesinimpuestos( lxVal )
				if ( this.lHabilitarTotalcomprobantesinimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Totalcomprobantesinimpuestos', lxValOld, lxVal  )
					this.Setear_Totalcomprobantesinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Totalcomprobantesinimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Totalcomprobantesinimpuestos', This )
						Endif
					EndIf
				else
					this.Totalcomprobantesinimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Totalcomprobantesinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Totalcomprobantesinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalcomprobanteiva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalcomprobanteiva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalcomprobanteiva( lxVal )
				if ( this.lHabilitarTotalcomprobanteiva or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Totalcomprobanteiva', lxValOld, lxVal  )
					this.Setear_Totalcomprobanteiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Totalcomprobanteiva', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Totalcomprobanteiva', This )
						Endif
					EndIf
				else
					this.Totalcomprobanteiva = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Totalcomprobanteiva)" )
				endif 
			EndIf
		Else
			This.Setear_Totalcomprobanteiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalcomprobantegravado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalcomprobantegravado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalcomprobantegravado( lxVal )
				if ( this.lHabilitarTotalcomprobantegravado or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Totalcomprobantegravado', lxValOld, lxVal  )
					this.Setear_Totalcomprobantegravado( lxVal )
				this.EventoDespuesDeSetear( This, 'Totalcomprobantegravado', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Totalcomprobantegravado', This )
						Endif
					EndIf
				else
					this.Totalcomprobantegravado = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Totalcomprobantegravado)" )
				endif 
			EndIf
		Else
			This.Setear_Totalcomprobantegravado( lxVal ) 
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
				if ( this.lHabilitarTipo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Tipo', lxValOld, lxVal  )
					this.Setear_Tipo( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipo', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tipo', This )
						Endif
					EndIf
				else
					this.Tipo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Tipo)" )
				endif 
			EndIf
		Else
			This.Setear_Tipo( lxVal ) 
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
				if ( this.lHabilitarRecargosinpercepciones or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Recargosinpercepciones = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Recargosinpercepciones)" )
				endif 
			EndIf
		Else
			This.Setear_Recargosinpercepciones( lxVal ) 
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
				if ( this.lHabilitarPuntodeventa or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Puntodeventa', lxValOld, lxVal  )
					this.Setear_Puntodeventa( lxVal )
				this.EventoDespuesDeSetear( This, 'Puntodeventa', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Puntodeventa', This )
						Endif
					EndIf
				else
					this.Puntodeventa = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Puntodeventa)" )
				endif 
			EndIf
		Else
			This.Setear_Puntodeventa( lxVal ) 
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
				if ( this.lHabilitarNumerodecomprobante or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Numerodecomprobante', lxValOld, lxVal  )
					this.Setear_Numerodecomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerodecomprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numerodecomprobante', This )
						Endif
					EndIf
				else
					this.Numerodecomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Numerodecomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Numerodecomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Espagoacuenta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Espagoacuenta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Espagoacuenta( lxVal )
				if ( this.lHabilitarEspagoacuenta or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Espagoacuenta', lxValOld, lxVal  )
					this.Setear_Espagoacuenta( lxVal )
				this.EventoDespuesDeSetear( This, 'Espagoacuenta', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Espagoacuenta', This )
						Endif
					EndIf
				else
					this.Espagoacuenta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Espagoacuenta)" )
				endif 
			EndIf
		Else
			This.Setear_Espagoacuenta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Emision_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Emision
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Emision( lxVal )
				if ( this.lHabilitarEmision or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fecha( lxVal )
					this.EventoAntesDeSetear( This, 'Emision', lxValOld, lxVal  )
					this.Setear_Emision( lxVal )
				this.EventoDespuesDeSetear( This, 'Emision', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Emision', This )
						Endif
					EndIf
				else
					this.Emision = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Emision)" )
				endif 
			EndIf
		Else
			This.Setear_Emision( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vencimiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vencimiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vencimiento( lxVal )
				if ( this.lHabilitarVencimiento or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fecha( lxVal )
					this.EventoAntesDeSetear( This, 'Vencimiento', lxValOld, lxVal  )
					this.Setear_Vencimiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Vencimiento', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Vencimiento', This )
						Endif
					EndIf
				else
					this.Vencimiento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Vencimiento)" )
				endif 
			EndIf
		Else
			This.Setear_Vencimiento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descripcion( lxVal )
				if ( this.lHabilitarDescripcion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Descripcion', lxValOld, lxVal  )
					this.Setear_Descripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Descripcion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Descripcion', This )
						Endif
					EndIf
				else
					this.Descripcion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Descripcion)" )
				endif 
			EndIf
		Else
			This.Setear_Descripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Anotacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Anotacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Anotacion( lxVal )
				if ( this.lHabilitarAnotacion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Anotacion', lxValOld, lxVal  )
					this.Setear_Anotacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Anotacion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Anotacion', This )
						Endif
					EndIf
				else
					this.Anotacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Anotacion)" )
				endif 
			EndIf
		Else
			This.Setear_Anotacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Saldoaux_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Saldoaux
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Saldoaux( lxVal )
				if ( this.lHabilitarSaldoaux or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Saldoaux', lxValOld, lxVal  )
					this.Setear_Saldoaux( lxVal )
				this.EventoDespuesDeSetear( This, 'Saldoaux', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Saldoaux', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Saldoaux', This )
						Endif
					EndIf
				else
					this.Saldoaux = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Saldoaux)" )
				endif 
			EndIf
		Else
			This.Setear_Saldoaux( lxVal ) 
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
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Monto', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Monto', This )
						Endif
					EndIf
				else
					this.Monto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de pago - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigocomprobante( txVal as variant ) as void

		this.Codigocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodecomprobante( txVal as variant ) as void

		this.Tipodecomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalcomprobanteconimpuestos( txVal as variant ) as void

		this.Totalcomprobanteconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuentaparaimpresion( txVal as variant ) as void

		this.Cuentaparaimpresion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalcomprobantesinimpuestos( txVal as variant ) as void

		this.Totalcomprobantesinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalcomprobanteiva( txVal as variant ) as void

		this.Totalcomprobanteiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalcomprobantegravado( txVal as variant ) as void

		this.Totalcomprobantegravado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargosinpercepciones( txVal as variant ) as void

		this.Recargosinpercepciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerodecomprobante( txVal as variant ) as void

		this.Numerodecomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Espagoacuenta( txVal as variant ) as void

		this.Espagoacuenta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Emision( txVal as variant ) as void

		this.Emision = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vencimiento( txVal as variant ) as void

		this.Vencimiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anotacion( txVal as variant ) as void

		this.Anotacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Saldoaux( txVal as variant ) as void

		this.Saldoaux = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodecomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalcomprobanteconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuentaparaimpresion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalcomprobantesinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalcomprobanteiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalcomprobantegravado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargosinpercepciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerodecomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Espagoacuenta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Emision( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vencimiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anotacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Saldoaux( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

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
	function oCompCuentacorrienteordendepagocompras_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompCuentacorrienteordendepagocompras ) = 'O' or isnull( this.oCompCuentacorrienteordendepagocompras ) )
			this.oCompCuentacorrienteordendepagocompras = _Screen.zoo.InstanciarComponente( 'ComponenteCuentacorrienteordendepagocompras' )
		this.oCompCuentacorrienteordendepagocompras.Inicializar()
		this.enlazar( 'oCompCuentacorrienteordendepagocompras.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompCuentacorrienteordendepagocompras.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompCuentacorrienteordendepagocompras
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fecha = ctod( '  /  /    ' )
				.Caja_PK = 0
				.Codigocomprobante = []
				.Tipodecomprobante = []
				.Letra = []
				.Totalcomprobanteconimpuestos = 0
				.Totalcomprobantesinimpuestos = 0
				.Totalcomprobanteiva = 0
				.Totalcomprobantegravado = 0
				.Tipo = 0
				.Puntodeventa = 0
				.Numerodecomprobante = 0
				.Espagoacuenta = .F.
				.Codigo = []
				.Valor_PK = []
				.Emision = ctod( '  /  /    ' )
				.Vencimiento = ctod( '  /  /    ' )
				.Descripcion = []
				.Anotacion = []
				.Saldoaux = 0
				.Monto = 0
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
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoAnotacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDEPAGO", "Ordendepagodetalle", "Anotacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Anotacion' )
						.Anotacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Anotación para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDEPAGO", "Ordendepagodetalle", "Monto" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
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
		this.oCompCuentaCorrienteOrdenDePagoCompras = null
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		If this.oCompCuentaCorrienteOrdenDePagoCompras.ValidarAtributo( txVal, tcAtributo )
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
			.Cuentaparaimpresion = 0
			.Recargosinpercepciones = 0
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

		if  empty( this.Tipodecomprobante ) or ; 			 empty( this.Puntodeventa ) or ; 			 empty( this.Numerodecomprobante ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarFecha = tlHabilitar
		this.lHabilitarCaja_PK = tlHabilitar
		this.lHabilitarCodigoComprobante = tlHabilitar
		this.lHabilitarTipoDeComprobante = tlHabilitar
		this.lHabilitarLetra = tlHabilitar
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarTotalComprobanteConImpuestos = tlHabilitar
		this.lHabilitarCuentaParaImpresion = tlHabilitar
		this.lHabilitarTotalComprobanteSinImpuestos = tlHabilitar
		this.lHabilitarTotalComprobanteIva = tlHabilitar
		this.lHabilitarTotalComprobanteGravado = tlHabilitar
		this.lHabilitarTipo = tlHabilitar
		this.lHabilitarRecargoSinPercepciones = tlHabilitar
		this.lHabilitarPuntoDeVenta = tlHabilitar
		this.lHabilitarNumeroDeComprobante = tlHabilitar
		this.lHabilitarEsPagoACuenta = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarValor_PK = tlHabilitar
		this.lHabilitarEmision = tlHabilitar
		this.lHabilitarVencimiento = tlHabilitar
		this.lHabilitarDescripcion = tlHabilitar
		this.lHabilitarAnotacion = tlHabilitar
		this.lHabilitarSaldoAux = tlHabilitar
		this.lHabilitarMonto = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMORDENDEPAGO]
	endfunc

enddefine