
define class Din_ItemHERRAMIENTACONCILIACIONDetallemovimientos as ItemActivo of ItemActivo.prg

	cNombre = 'HERRAMIENTACONCILIACION'
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Movimiento_PK = []
	Movimiento = null
	lHabilitarMovimiento_PK = .T.
	Fecha = ctod( '  /  /    ' )
	lHabilitarFecha = .T.
	ConceptoCodigo = []
	lHabilitarConceptoCodigo = .T.
	Concepto = []
	lHabilitarConcepto = .T.
	ConceptoDetalle = []
	lHabilitarConceptoDetalle = .T.
	Numero = 0
	lHabilitarNumero = .T.
	Importe = 0
	lHabilitarImporte = .T.
	Seleccion = .F.
	lHabilitarSeleccion = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarNROITEM = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarMovimiento_PK = .T.
		this.lHabilitarFecha = .T.
		this.lHabilitarConceptoCodigo = .T.
		this.lHabilitarConcepto = .T.
		this.lHabilitarConceptoDetalle = .T.
		this.lHabilitarNumero = .T.
		this.lHabilitarImporte = .T.
		this.lHabilitarSeleccion = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'HERRAMIENTACONCILIACION', 'Detallemovimientos')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimiento_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Movimiento_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Movimiento.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Movimiento )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Movimiento_PK = lxVal

		if this.Validar_Movimiento( lxVal, lxValOld )
			if ( this.lHabilitarMovimiento_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Movimiento_Pk', lxValOld, lxVal  )
				This.Setear_Movimiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Movimiento_Pk', lxValOld, lxVal  )
				If This.PuedeEjecutarCambioSumarizado()
					this.CambioSumarizado()
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Movimiento_Pk', This )
					Endif
				EndIf
			else
				this.Movimiento_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Movimiento)" )
			endif 
		endif
		If lxValOld != lxVal or empty( this.Fecha ) 
			this.Fecha = This.Movimiento.Fecha
		endif
		If lxValOld != lxVal or empty( this.Numero ) 
			this.Numero = This.Movimiento.Numero
		endif
		If lxValOld != lxVal or empty( this.Importe ) 
			this.Importe = This.Movimiento.Importe
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Movimiento( txVal as variant ) as void

		this.Movimiento.IDENTIFICADOR = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Movimiento( txVal as variant, txValOld as variant ) as Boolean

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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Fecha)" )
				endif 
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conceptocodigo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conceptocodigo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conceptocodigo( lxVal )
				if ( this.lHabilitarConceptocodigo or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Conceptocodigo', lxValOld, lxVal  )
					this.Setear_Conceptocodigo( lxVal )
				this.EventoDespuesDeSetear( This, 'Conceptocodigo', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Conceptocodigo', This )
						Endif
					EndIf
				else
					this.Conceptocodigo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Conceptocodigo)" )
				endif 
			EndIf
		Else
			This.Setear_Conceptocodigo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Concepto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Concepto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Concepto( lxVal )
				if ( this.lHabilitarConcepto or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Concepto', lxValOld, lxVal  )
					this.Setear_Concepto( lxVal )
				this.EventoDespuesDeSetear( This, 'Concepto', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Concepto', This )
						Endif
					EndIf
				else
					this.Concepto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Concepto)" )
				endif 
			EndIf
		Else
			This.Setear_Concepto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conceptodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conceptodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conceptodetalle( lxVal )
				if ( this.lHabilitarConceptodetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Conceptodetalle', lxValOld, lxVal  )
					this.Setear_Conceptodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Conceptodetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Conceptodetalle', This )
						Endif
					EndIf
				else
					this.Conceptodetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Conceptodetalle)" )
				endif 
			EndIf
		Else
			This.Setear_Conceptodetalle( lxVal ) 
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
				if ( this.lHabilitarNumero or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Numero', lxValOld, lxVal  )
					this.Setear_Numero( lxVal )
				this.EventoDespuesDeSetear( This, 'Numero', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numero', This )
						Endif
					EndIf
				else
					this.Numero = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Numero)" )
				endif 
			EndIf
		Else
			This.Setear_Numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Importe_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Importe
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Importe( lxVal )
				if ( this.lHabilitarImporte or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Importe', lxValOld, lxVal  )
					this.Setear_Importe( lxVal )
				this.EventoDespuesDeSetear( This, 'Importe', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Importe', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Importe', This )
						Endif
					EndIf
				else
					this.Importe = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Importe)" )
				endif 
			EndIf
		Else
			This.Setear_Importe( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seleccion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seleccion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seleccion( lxVal )
				if ( this.lHabilitarSeleccion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Seleccion', lxValOld, lxVal  )
					this.Setear_Seleccion( lxVal )
				this.EventoDespuesDeSetear( This, 'Seleccion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Seleccion', This )
						Endif
					EndIf
				else
					this.Seleccion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Seleccion)" )
				endif 
			EndIf
		Else
			This.Setear_Seleccion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conceptocodigo( txVal as variant ) as void

		this.Conceptocodigo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Concepto( txVal as variant ) as void

		this.Concepto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conceptodetalle( txVal as variant ) as void

		this.Conceptodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Importe( txVal as variant ) as void

		this.Importe = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seleccion( txVal as variant ) as void

		this.Seleccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conceptocodigo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Concepto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conceptodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Importe( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seleccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimiento_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Movimiento ) = 'O' or isnull( this.Movimiento ) )
					this.Movimiento = _Screen.zoo.instanciarentidad( 'Movimientobancario' )
					this.Movimiento.lEsSubEntidad = .t.
					this.enlazar( 'Movimiento.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Movimiento.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Movimiento.IDENTIFICADOR # this.Movimiento_PK
						this.Movimiento.IDENTIFICADOR = this.Movimiento_PK
					endif
				endif
			endif
		endif
		return this.Movimiento
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
	Function ValorSugeridoSeleccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "HERRAMIENTACONCILIACION", "Detallemovimientos", "Seleccion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Seleccion' )
						.Seleccion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Seleccionada para el detalle Movimientos bancarios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
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
			.Movimiento_PK = []
			.Fecha = ctod( '  /  /    ' )
			.Conceptocodigo = []
			.Concepto = []
			.Conceptodetalle = []
			.Numero = 0
			.Importe = 0
			.Seleccion = .F.
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

		if  empty( this.Movimiento_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarMovimiento_PK = tlHabilitar
		this.lHabilitarFecha = tlHabilitar
		this.lHabilitarConceptoCodigo = tlHabilitar
		this.lHabilitarConcepto = tlHabilitar
		this.lHabilitarConceptoDetalle = tlHabilitar
		this.lHabilitarNumero = tlHabilitar
		this.lHabilitarImporte = tlHabilitar
		this.lHabilitarSeleccion = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMMOVBANCARIOSTOOL]
	endfunc

enddefine