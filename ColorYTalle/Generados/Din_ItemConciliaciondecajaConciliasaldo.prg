
define class Din_ItemCONCILIACIONDECAJAConciliasaldo as ItemActivo of ItemActivo.prg

	cNombre = 'CONCILIACIONDECAJA'
	NROITEM = 0
	cAtributoPK = 'codigo'
	codigo = []
	TipoComprobante = []
	DescTipoComprobante = []
	Valor_PK = []
	Valor = null
	ValorDetalle = []
	SaldoAct = 0
	SaldoProy = 0
	Ajuste = 0
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CONCILIACIONDECAJA', 'Conciliasaldo')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Valor_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valor( txVal as variant ) as void

		this.Valor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Desctipocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Desctipocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Desctipocomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Desctipocomprobante', lxValOld, lxVal  )
				this.Setear_Desctipocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Desctipocomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Desctipocomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Desctipocomprobante( lxVal ) 
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
	function Saldoact_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Saldoact
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Saldoact( lxVal )
				this.EventoAntesDeSetear( This, 'Saldoact', lxValOld, lxVal  )
				this.Setear_Saldoact( lxVal )
				this.EventoDespuesDeSetear( This, 'Saldoact', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Saldoact', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Saldoact( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Saldoproy_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Saldoproy
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Saldoproy( lxVal )
				this.EventoAntesDeSetear( This, 'Saldoproy', lxValOld, lxVal  )
				this.Setear_Saldoproy( lxVal )
				this.EventoDespuesDeSetear( This, 'Saldoproy', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Saldoproy', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Saldoproy( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ajuste_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ajuste
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ajuste( lxVal )
				this.EventoAntesDeSetear( This, 'Ajuste', lxValOld, lxVal  )
				this.Setear_Ajuste( lxVal )
				this.EventoDespuesDeSetear( This, 'Ajuste', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ajuste', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ajuste( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Desctipocomprobante( txVal as variant ) as void

		this.Desctipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valordetalle( txVal as variant ) as void

		this.Valordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Saldoact( txVal as variant ) as void

		this.Saldoact = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Saldoproy( txVal as variant ) as void

		this.Saldoproy = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajuste( txVal as variant ) as void

		this.Ajuste = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Desctipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Saldoact( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Saldoproy( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajuste( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Codigo = []
				.Tipocomprobante = []
				.Desctipocomprobante = []
				.Valor_PK = []
				.Valordetalle = []
				.Saldoact = 0
				.Saldoproy = 0
				.Ajuste = 0
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
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*-----------------------------------------------------------------------------------------
	function CargaManual() as Boolean
		return !this.lLimpiando and !this.lCargando and !this.lDestroy
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
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCONCILIASALDO]
	endfunc

enddefine