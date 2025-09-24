
define class Din_ItemARQUEODECAJADetalletotalporgrupo as ItemActivo of ItemActivo.prg

	cNombre = 'ARQUEODECAJA'
	Agrupa = []
	lHabilitarAgrupa = .T.
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	AgrupaDesc = []
	lHabilitarAgrupaDesc = .T.
	TotalGrupo = 0
	lHabilitarTotalGrupo = .T.
	Arqueado = 0
	lHabilitarArqueado = .T.
	DifGrupo = 0
	lHabilitarDifGrupo = .T.
	ArqueadoEfec = 0
	lHabilitarArqueadoEfec = .T.
	ArqueadoOtros = 0
	lHabilitarArqueadoOtros = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarAgrupa = .T.
		this.lHabilitarNROITEM = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarAgrupaDesc = .T.
		this.lHabilitarTotalGrupo = .T.
		this.lHabilitarArqueado = .T.
		this.lHabilitarDifGrupo = .T.
		this.lHabilitarArqueadoEfec = .T.
		this.lHabilitarArqueadoOtros = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ARQUEODECAJA', 'Detalletotalporgrupo')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Agrupa_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Agrupa
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Agrupa( lxVal )
				if ( this.lHabilitarAgrupa or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Agrupa', lxValOld, lxVal  )
					this.Setear_Agrupa( lxVal )
				this.EventoDespuesDeSetear( This, 'Agrupa', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Agrupa', This )
						Endif
					EndIf
				else
					this.Agrupa = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Agrupa)" )
				endif 
			EndIf
		Else
			This.Setear_Agrupa( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Agrupadesc_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Agrupadesc
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Agrupadesc( lxVal )
				if ( this.lHabilitarAgrupadesc or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Agrupadesc', lxValOld, lxVal  )
					this.Setear_Agrupadesc( lxVal )
				this.EventoDespuesDeSetear( This, 'Agrupadesc', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Agrupadesc', This )
						Endif
					EndIf
				else
					this.Agrupadesc = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Agrupadesc)" )
				endif 
			EndIf
		Else
			This.Setear_Agrupadesc( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalgrupo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalgrupo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalgrupo( lxVal )
				if ( this.lHabilitarTotalgrupo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Totalgrupo', lxValOld, lxVal  )
					this.Setear_Totalgrupo( lxVal )
				this.EventoDespuesDeSetear( This, 'Totalgrupo', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Totalgrupo', This )
						Endif
					EndIf
				else
					this.Totalgrupo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Totalgrupo)" )
				endif 
			EndIf
		Else
			This.Setear_Totalgrupo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Arqueado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Arqueado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Arqueado( lxVal )
				if ( this.lHabilitarArqueado or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Arqueado', lxValOld, lxVal  )
					this.Setear_Arqueado( lxVal )
				this.EventoDespuesDeSetear( This, 'Arqueado', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Arqueado', This )
						Endif
					EndIf
				else
					this.Arqueado = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Arqueado)" )
				endif 
			EndIf
		Else
			This.Setear_Arqueado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Difgrupo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Difgrupo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Difgrupo( lxVal )
				if ( this.lHabilitarDifgrupo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Difgrupo', lxValOld, lxVal  )
					this.Setear_Difgrupo( lxVal )
				this.EventoDespuesDeSetear( This, 'Difgrupo', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Difgrupo', This )
						Endif
					EndIf
				else
					this.Difgrupo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Difgrupo)" )
				endif 
			EndIf
		Else
			This.Setear_Difgrupo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Arqueadoefec_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Arqueadoefec
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Arqueadoefec( lxVal )
				if ( this.lHabilitarArqueadoefec or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Arqueadoefec', lxValOld, lxVal  )
					this.Setear_Arqueadoefec( lxVal )
				this.EventoDespuesDeSetear( This, 'Arqueadoefec', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Arqueadoefec', This )
						Endif
					EndIf
				else
					this.Arqueadoefec = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Arqueadoefec)" )
				endif 
			EndIf
		Else
			This.Setear_Arqueadoefec( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Arqueadootros_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Arqueadootros
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Arqueadootros( lxVal )
				if ( this.lHabilitarArqueadootros or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Arqueadootros', lxValOld, lxVal  )
					this.Setear_Arqueadootros( lxVal )
				this.EventoDespuesDeSetear( This, 'Arqueadootros', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Arqueadootros', This )
						Endif
					EndIf
				else
					this.Arqueadootros = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Arqueo de caja - Atributo: Arqueadootros)" )
				endif 
			EndIf
		Else
			This.Setear_Arqueadootros( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Agrupa( txVal as variant ) as void

		this.Agrupa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Agrupadesc( txVal as variant ) as void

		this.Agrupadesc = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalgrupo( txVal as variant ) as void

		this.Totalgrupo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Arqueado( txVal as variant ) as void

		this.Arqueado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Difgrupo( txVal as variant ) as void

		this.Difgrupo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Arqueadoefec( txVal as variant ) as void

		this.Arqueadoefec = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Arqueadootros( txVal as variant ) as void

		this.Arqueadootros = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Agrupa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Agrupadesc( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalgrupo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Arqueado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Difgrupo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Arqueadoefec( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Arqueadootros( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Agrupa = []
				.Codigo = []
				.Agrupadesc = []
				.Totalgrupo = 0
				.Arqueado = 0
				.Difgrupo = 0
				.Arqueadoefec = 0
				.Arqueadootros = 0
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

		if  empty( this.Agrupa ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarAgrupa = tlHabilitar
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarAgrupaDesc = tlHabilitar
		this.lHabilitarTotalGrupo = tlHabilitar
		this.lHabilitarArqueado = tlHabilitar
		this.lHabilitarDifGrupo = tlHabilitar
		this.lHabilitarArqueadoEfec = tlHabilitar
		this.lHabilitarArqueadoOtros = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMTOTALPORGRUPO]
	endfunc

enddefine