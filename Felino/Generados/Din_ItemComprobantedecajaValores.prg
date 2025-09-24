
define class Din_ItemCOMPROBANTEDECAJAValores as ItemValoresFondos of ItemValoresFondos.prg

	cNombre = 'COMPROBANTEDECAJA'
	FechaComp = ctod( '  /  /    ' )
	Caja_PK = 0
	Caja = null
	lHabilitarCaja_PK = .T.
	RecargoSinPercepciones = 0
	CajaValor = 0
	NROITEM = 0
	Cuotas = 0
	RecargoMontoSinImpuestos = 0
	RecargoPorcentaje = 0
	Tipo = 0
	Total = 0
	RecargoMonto = 0
	ChequeElectronico = .F.
	lHabilitarChequeElectronico = .T.
	NumeroChequePropio_PK = []
	NumeroChequePropio = null
	NumeroCheque_PK = []
	NumeroCheque = null
	cAtributoPK = 'Numero'
	Numero = []
	Valor_PK = []
	Valor = null
	ValorDetalle = []
	Fecha = ctod( '  /  /    ' )
	NumeroInterno = []
	lHabilitarNumeroInterno = .T.
	Monto = 0
	lHabilitarMonto = .T.
	Cotiza = 0
	MontoAMonedaSistema = 0
	IdItemComponente = []
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'COMPROBANTEDECAJA', 'Valores')
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Comprobante de movimientos de caja - Atributo: Caja)" )
			endif 
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
			If lxValOld != lxVal or empty( this.Cajavalor ) 
				this.Cajavalor = This.Valor.Caja_pk
			endif
			If lxValOld != lxVal or empty( this.Tipo ) 
				this.Tipo = This.Valor.Tipo
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
	function Setear_Caja( txVal as variant ) as void

		this.Caja.ID = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerochequepropio( txVal as variant ) as void

		this.Numerochequepropio.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocheque( txVal as variant ) as void

		this.Numerocheque.CODIGO = txVal
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
	function Validar_Numerochequepropio( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocheque( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valor( txVal as variant, txValOld as variant ) as Boolean

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
	function Cajavalor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cajavalor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cajavalor( lxVal )
				this.EventoAntesDeSetear( This, 'Cajavalor', lxValOld, lxVal  )
				this.Setear_Cajavalor( lxVal )
				this.EventoDespuesDeSetear( This, 'Cajavalor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cajavalor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cajavalor( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Comprobante de movimientos de caja - Atributo: Chequeelectronico)" )
				endif 
			EndIf
		Else
			This.Setear_Chequeelectronico( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Comprobante de movimientos de caja - Atributo: Numerointerno)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Comprobante de movimientos de caja - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
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
	function Setear_Recargosinpercepciones( txVal as variant ) as void

		this.Recargosinpercepciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cajavalor( txVal as variant ) as void

		this.Cajavalor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuotas( txVal as variant ) as void

		this.Cuotas = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomontosinimpuestos( txVal as variant ) as void

		this.Recargomontosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargoporcentaje( txVal as variant ) as void

		this.Recargoporcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recargomonto( txVal as variant ) as void

		this.Recargomonto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Chequeelectronico( txVal as variant ) as void

		this.Chequeelectronico = txVal
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
	function Setear_Cotiza( txVal as variant ) as void

		this.Cotiza = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoamonedasistema( txVal as variant ) as void

		this.Montoamonedasistema = txVal
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
	function Validar_Recargosinpercepciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cajavalor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuotas( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomontosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargoporcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recargomonto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Chequeelectronico( txVal as variant ) as Boolean

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
	function Validar_Cotiza( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoamonedasistema( txVal as variant ) as Boolean

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

				.Fechacomp = ctod( '  /  /    ' )
				.Caja_PK = 0
				.Cajavalor = 0
				.Tipo = 0
				.Total = 0
				.Chequeelectronico = .F.
				.Numerochequepropio_PK = []
				.Numerocheque_PK = []
				.Numero = []
				.Valor_PK = []
				.Valordetalle = []
				.Fecha = ctod( '  /  /    ' )
				.Numerointerno = []
				.Monto = 0
				.Cotiza = 0
				.Montoamonedasistema = 0
				.Iditemcomponente = []
				.LimpiarAtributosVirtuales()
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				.lLimpiando = .f.
				if tlForzar
				else
					.SetearValoresSugeridos()
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
	Function ValorSugeridoValor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDECAJA", "Valores", "Valor" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Valor para el detalle Detalle de Valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoValordetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDECAJA", "Valores", "Valordetalle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Valordetalle' )
						.Valordetalle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripcion para el detalle Detalle de Valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumerointerno() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDECAJA", "Valores", "Numerointerno" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. int. para el detalle Detalle de Valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDECAJA", "Valores", "Monto" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto para el detalle Detalle de Valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
		This.ProcesarDespuesDeSetearValorFondos()                                                           
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerointerno_DespuesDeAsignar() as void
		this.ProcesarDespuesDeSetearNumeroInterno()                                                         
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
			.Recargosinpercepciones = 0
			.Cuotas = 0
			.Recargomontosinimpuestos = 0
			.Recargoporcentaje = 0
			.Recargomonto = 0
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
		return [ITEMVALORESCAJA]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.VALOR_PK) and dodefault()
		return llRetorno
	endfunc

enddefine