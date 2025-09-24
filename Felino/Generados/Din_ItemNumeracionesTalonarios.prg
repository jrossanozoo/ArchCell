
define class Din_ItemNUMERACIONESTalonarios as ItemActivo of ItemActivo.prg

	cNombre = 'NUMERACIONES'
	cAtributoPK = 'Codigo'
	Codigo = 0
	Talonario = []
	DescripcionEntidad = []
	Entidad = []
	Letra = []
	PuntoDeVenta = 0
	Numero = 0
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'NUMERACIONES', 'Talonarios')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Talonario_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talonario
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Talonario( lxVal )
				this.EventoAntesDeSetear( This, 'Talonario', lxValOld, lxVal  )
				this.Setear_Talonario( lxVal )
				this.EventoDespuesDeSetear( This, 'Talonario', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Talonario', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Talonario( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descripcionentidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descripcionentidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descripcionentidad( lxVal )
				this.EventoAntesDeSetear( This, 'Descripcionentidad', lxValOld, lxVal  )
				this.Setear_Descripcionentidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Descripcionentidad', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descripcionentidad', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descripcionentidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entidad( lxVal )
				this.EventoAntesDeSetear( This, 'Entidad', lxValOld, lxVal  )
				this.Setear_Entidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Entidad', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Entidad', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Entidad( lxVal ) 
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
	function Numero_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numero
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numero( lxVal )
				this.EventoAntesDeSetear( This, 'Numero', lxValOld, lxVal  )
				this.Setear_Numero( lxVal )
				this.EventoDespuesDeSetear( This, 'Numero', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numero', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Talonario( txVal as variant ) as void

		this.Talonario = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcionentidad( txVal as variant ) as void

		this.Descripcionentidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidad( txVal as variant ) as void

		this.Entidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talonario( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcionentidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

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

				.Talonario = []
				.Entidad = []
				.Letra = []
				.Puntodeventa = 0
				.Numero = 0
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
	Function ValorSugeridoNumero() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUMERACIONES", "Talonarios", "Numero" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Último Número para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			.Codigo = 0
			.Descripcionentidad = []
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
		return [ITEMTALONARIO]
	endfunc

enddefine