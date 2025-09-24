
define class Din_ItemASIENTOAsientodetalle as ItemActivo of ItemActivo.prg

	cNombre = 'ASIENTO'
	FechaDelAjuste = ctod( '  /  /    ' )
	lHabilitarFechaDelAjuste = .T.
	CuentaALaQueAjusta = []
	lHabilitarCuentaALaQueAjusta = .T.
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	PlanDeCuentas_PK = []
	PlanDeCuentas = null
	lHabilitarPlanDeCuentas_PK = .T.
	PlanDeCuentasDetalle = []
	lHabilitarPlanDeCuentasDetalle = .T.
	Leyenda = []
	lHabilitarLeyenda = .T.
	CENTRODECOSTO_PK = []
	CENTRODECOSTO = null
	lHabilitarCENTRODECOSTO_PK = .T.
	Debe = 0
	lHabilitarDebe = .T.
	Haber = 0
	lHabilitarHaber = .T.
	Saldo = 0
	lHabilitarSaldo = .T.
	RequiereCC = .F.
	lHabilitarRequiereCC = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarFechaDelAjuste = .T.
		this.lHabilitarCuentaALaQueAjusta = .T.
		this.lHabilitarNROITEM = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarPlanDeCuentas_PK = .T.
		this.lHabilitarPlanDeCuentasDetalle = .T.
		this.lHabilitarLeyenda = .T.
		this.lHabilitarCENTRODECOSTO_PK = .T.
		this.lHabilitarDebe = .T.
		this.lHabilitarHaber = .T.
		this.lHabilitarSaldo = .T.
		this.lHabilitarRequiereCC = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ASIENTO', 'Asientodetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentas_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentas_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.Plandecuentas_PK = lxVal

		if this.Validar_Plandecuentas( lxVal, lxValOld )
			if ( this.lHabilitarPlandecuentas_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Plandecuentas_Pk', lxValOld, lxVal  )
				This.Setear_Plandecuentas( lxVal )
				this.EventoDespuesDeSetear( This, 'Plandecuentas_Pk', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.TotalizarSumarizado()
				EndIf
			If lxValOld != lxVal or empty( this.Plandecuentasdetalle ) 
				this.Plandecuentasdetalle = This.PLANDECUENTAS.DESCRIPCION
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Plandecuentas_Pk', This )
					Endif
				EndIf
			else
				this.Plandecuentas_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Plandecuentas)" )
			endif 
		endif
		If lxValOld != lxVal or empty( this.Requierecc ) 
			this.Requierecc = This.PLANDECUENTAS.REQUIERECDC
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Centrodecosto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Centrodecosto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Centrodecosto_PK = lxVal

		if this.Validar_Centrodecosto( lxVal, lxValOld )
			if ( this.lHabilitarCentrodecosto_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Centrodecosto_Pk', lxValOld, lxVal  )
				This.Setear_Centrodecosto( lxVal )
				this.EventoDespuesDeSetear( This, 'Centrodecosto_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Centrodecosto_Pk', This )
					Endif
				EndIf
			else
				this.Centrodecosto_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Centrodecosto)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentas( txVal as variant ) as void

		this.Plandecuentas.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Centrodecosto( txVal as variant ) as void

		this.Centrodecosto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentas( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Centrodecosto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechadelajuste_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechadelajuste
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechadelajuste( lxVal )
				if ( this.lHabilitarFechadelajuste or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fecha( lxVal )
					this.EventoAntesDeSetear( This, 'Fechadelajuste', lxValOld, lxVal  )
					this.Setear_Fechadelajuste( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechadelajuste', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Fechadelajuste', This )
						Endif
					EndIf
				else
					this.Fechadelajuste = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Fechadelajuste)" )
				endif 
			EndIf
		Else
			This.Setear_Fechadelajuste( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuentaalaqueajusta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuentaalaqueajusta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuentaalaqueajusta( lxVal )
				if ( this.lHabilitarCuentaalaqueajusta or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Cuentaalaqueajusta', lxValOld, lxVal  )
					this.Setear_Cuentaalaqueajusta( lxVal )
				this.EventoDespuesDeSetear( This, 'Cuentaalaqueajusta', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cuentaalaqueajusta', This )
						Endif
					EndIf
				else
					this.Cuentaalaqueajusta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Cuentaalaqueajusta)" )
				endif 
			EndIf
		Else
			This.Setear_Cuentaalaqueajusta( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentasdetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentasdetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Plandecuentasdetalle( lxVal )
				if ( this.lHabilitarPlandecuentasdetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Plandecuentasdetalle', lxValOld, lxVal  )
					this.Setear_Plandecuentasdetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Plandecuentasdetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Plandecuentasdetalle', This )
						Endif
					EndIf
				else
					this.Plandecuentasdetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Plandecuentasdetalle)" )
				endif 
			EndIf
		Else
			This.Setear_Plandecuentasdetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Leyenda_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Leyenda
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Leyenda( lxVal )
				if ( this.lHabilitarLeyenda or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Leyenda', lxValOld, lxVal  )
					this.Setear_Leyenda( lxVal )
				this.EventoDespuesDeSetear( This, 'Leyenda', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Leyenda', This )
						Endif
					EndIf
				else
					this.Leyenda = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Leyenda)" )
				endif 
			EndIf
		Else
			This.Setear_Leyenda( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Debe_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Debe
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Debe( lxVal )
				if ( this.lHabilitarDebe or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.EventoAntesDeSetear( This, 'Debe', lxValOld, lxVal  )
					this.Setear_Debe( lxVal )
				this.EventoDespuesDeSetear( This, 'Debe', lxValOld, lxVal  )
					 This.Debe_DespuesDeAsignar()
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Debe', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Debe', This )
						Endif
					EndIf
				else
					this.Debe = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Debe)" )
				endif 
			EndIf
		Else
			This.Setear_Debe( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Haber_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Haber
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Haber( lxVal )
				if ( this.lHabilitarHaber or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.EventoAntesDeSetear( This, 'Haber', lxValOld, lxVal  )
					this.Setear_Haber( lxVal )
				this.EventoDespuesDeSetear( This, 'Haber', lxValOld, lxVal  )
					 This.Haber_DespuesDeAsignar()
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Haber', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Haber', This )
						Endif
					EndIf
				else
					this.Haber = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Haber)" )
				endif 
			EndIf
		Else
			This.Setear_Haber( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Saldo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Saldo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Saldo( lxVal )
				if ( this.lHabilitarSaldo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.EventoAntesDeSetear( This, 'Saldo', lxValOld, lxVal  )
					this.Setear_Saldo( lxVal )
				this.EventoDespuesDeSetear( This, 'Saldo', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Saldo', This )
						Endif
					EndIf
				else
					this.Saldo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Saldo)" )
				endif 
			EndIf
		Else
			This.Setear_Saldo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Requierecc_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Requierecc
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Requierecc( lxVal )
				if ( this.lHabilitarRequierecc or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Requierecc', lxValOld, lxVal  )
					this.Setear_Requierecc( lxVal )
				this.EventoDespuesDeSetear( This, 'Requierecc', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Requierecc', This )
						Endif
					EndIf
				else
					this.Requierecc = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asientos - Atributo: Requierecc)" )
				endif 
			EndIf
		Else
			This.Setear_Requierecc( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechadelajuste( txVal as variant ) as void

		this.Fechadelajuste = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuentaalaqueajusta( txVal as variant ) as void

		this.Cuentaalaqueajusta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentasdetalle( txVal as variant ) as void

		this.Plandecuentasdetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Leyenda( txVal as variant ) as void

		this.Leyenda = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Debe( txVal as variant ) as void

		this.Debe = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Haber( txVal as variant ) as void

		this.Haber = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Saldo( txVal as variant ) as void

		this.Saldo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Requierecc( txVal as variant ) as void

		this.Requierecc = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechadelajuste( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuentaalaqueajusta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentasdetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Leyenda( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Debe( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Haber( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Saldo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Requierecc( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentas_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Plandecuentas ) = 'O' or isnull( this.Plandecuentas ) )
					this.Plandecuentas = _Screen.zoo.instanciarentidad( 'Plandecuentas' )
					this.Plandecuentas.lEsSubEntidad = .t.
					this.enlazar( 'Plandecuentas.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Plandecuentas.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Plandecuentas.CODIGO # this.Plandecuentas_PK
						this.Plandecuentas.CODIGO = this.Plandecuentas_PK
					endif
				endif
			endif
		endif
		return this.Plandecuentas
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Centrodecosto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Centrodecosto ) = 'O' or isnull( this.Centrodecosto ) )
					this.Centrodecosto = _Screen.zoo.instanciarentidad( 'Centrodecosto' )
					this.Centrodecosto.lEsSubEntidad = .t.
					this.enlazar( 'Centrodecosto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Centrodecosto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Centrodecosto.CODIGO # this.Centrodecosto_PK
						this.Centrodecosto.CODIGO = this.Centrodecosto_PK
					endif
				endif
			endif
		endif
		return this.Centrodecosto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechadelajuste = ctod( '  /  /    ' )
				.Cuentaalaqueajusta = []
				.Codigo = []
				.Plandecuentas_PK = []
				.Plandecuentasdetalle = []
				.Leyenda = []
				.Centrodecosto_PK = []
				.Debe = 0
				.Haber = 0
				.Saldo = 0
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
	Function ValorSugeridoPlandecuentas() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTO", "Asientodetalle", "Plandecuentas" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Plandecuentas_PK' )
						.Plandecuentas_PK = lvValorSugeridoDefinidoPorElUsuario
						.Plandecuentas.CODIGO = .Plandecuentas_PK
					endif
				endif
			Catch to loError
				.Plandecuentas_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cuenta para el detalle Cuentas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLeyenda() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTO", "Asientodetalle", "Leyenda" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Leyenda' )
						.Leyenda = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Leyenda para el detalle Cuentas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCentrodecosto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTO", "Asientodetalle", "Centrodecosto" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Centrodecosto_PK' )
						.Centrodecosto_PK = lvValorSugeridoDefinidoPorElUsuario
						.Centrodecosto.CODIGO = .Centrodecosto_PK
					endif
				endif
			Catch to loError
				.Centrodecosto_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Centro de costos para el detalle Cuentas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDebe() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTO", "Asientodetalle", "Debe" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Debe' )
						.Debe = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Debe para el detalle Cuentas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoHaber() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTO", "Asientodetalle", "Haber" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Haber' )
						.Haber = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Haber para el detalle Cuentas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function Debe_DespuesDeAsignar() as void
		this.Saldo = this.Debe + this.Haber                                                                 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Haber_DespuesDeAsignar() as void
		this.Saldo = this.Debe + this.Haber                                                                 
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		
		Return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Requierecc = .F.
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

		if  empty( this.Plandecuentas_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarFechaDelAjuste = tlHabilitar
		this.lHabilitarCuentaALaQueAjusta = tlHabilitar
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarPlanDeCuentas_PK = tlHabilitar
		this.lHabilitarPlanDeCuentasDetalle = tlHabilitar
		this.lHabilitarLeyenda = tlHabilitar
		this.lHabilitarCENTRODECOSTO_PK = tlHabilitar
		this.lHabilitarDebe = tlHabilitar
		this.lHabilitarHaber = tlHabilitar
		this.lHabilitarSaldo = tlHabilitar
		this.lHabilitarRequiereCC = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMASIENTO]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.PLANDECUENTAS_PK) and dodefault()
		return llRetorno
	endfunc

enddefine