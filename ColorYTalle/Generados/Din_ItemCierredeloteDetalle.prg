
define class Din_ItemCIERREDELOTEDetalle as ItemActivo of ItemActivo.prg

	cNombre = 'CIERREDELOTE'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	NroLote = 0
	Tarjeta_PK = []
	Tarjeta = null
	TarjetaDetalle = []
	MontoTotalCompras = 0
	MontoTotalAnulacionCompras = 0
	MontoTotalDevoluciones = 0
	MontoTotalAnulacionDevoluciones = 0
	MontoTotal = 0
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CIERREDELOTE', 'Detalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tarjeta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tarjeta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Tarjeta_PK = lxVal

		if this.Validar_Tarjeta( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Tarjeta_Pk', lxValOld, lxVal  )
			This.Setear_Tarjeta( lxVal )
			this.EventoDespuesDeSetear( This, 'Tarjeta_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Tarjetadetalle ) 
				this.Tarjetadetalle = This.Tarjeta.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Tarjeta_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tarjeta( txVal as variant ) as void

		this.Tarjeta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tarjeta( txVal as variant, txValOld as variant ) as Boolean

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
	function Nrolote_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nrolote
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nrolote( lxVal )
				this.EventoAntesDeSetear( This, 'Nrolote', lxValOld, lxVal  )
				this.Setear_Nrolote( lxVal )
				this.EventoDespuesDeSetear( This, 'Nrolote', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nrolote', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nrolote( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tarjetadetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tarjetadetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tarjetadetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Tarjetadetalle', lxValOld, lxVal  )
				this.Setear_Tarjetadetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Tarjetadetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tarjetadetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tarjetadetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montototalcompras_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montototalcompras
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montototalcompras( lxVal )
				this.EventoAntesDeSetear( This, 'Montototalcompras', lxValOld, lxVal  )
				this.Setear_Montototalcompras( lxVal )
				this.EventoDespuesDeSetear( This, 'Montototalcompras', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montototalcompras', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montototalcompras', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montototalcompras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montototalanulacioncompras_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montototalanulacioncompras
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montototalanulacioncompras( lxVal )
				this.EventoAntesDeSetear( This, 'Montototalanulacioncompras', lxValOld, lxVal  )
				this.Setear_Montototalanulacioncompras( lxVal )
				this.EventoDespuesDeSetear( This, 'Montototalanulacioncompras', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montototalanulacioncompras', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montototalanulacioncompras', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montototalanulacioncompras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montototaldevoluciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montototaldevoluciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montototaldevoluciones( lxVal )
				this.EventoAntesDeSetear( This, 'Montototaldevoluciones', lxValOld, lxVal  )
				this.Setear_Montototaldevoluciones( lxVal )
				this.EventoDespuesDeSetear( This, 'Montototaldevoluciones', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montototaldevoluciones', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montototaldevoluciones', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montototaldevoluciones( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montototalanulaciondevoluciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montototalanulaciondevoluciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montototalanulaciondevoluciones( lxVal )
				this.EventoAntesDeSetear( This, 'Montototalanulaciondevoluciones', lxValOld, lxVal  )
				this.Setear_Montototalanulaciondevoluciones( lxVal )
				this.EventoDespuesDeSetear( This, 'Montototalanulaciondevoluciones', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montototalanulaciondevoluciones', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montototalanulaciondevoluciones', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montototalanulaciondevoluciones( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montototal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montototal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montototal( lxVal )
				this.EventoAntesDeSetear( This, 'Montototal', lxValOld, lxVal  )
				this.Setear_Montototal( lxVal )
				this.EventoDespuesDeSetear( This, 'Montototal', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montototal', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montototal', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montototal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nrolote( txVal as variant ) as void

		this.Nrolote = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tarjetadetalle( txVal as variant ) as void

		this.Tarjetadetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montototalcompras( txVal as variant ) as void

		this.Montototalcompras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montototalanulacioncompras( txVal as variant ) as void

		this.Montototalanulacioncompras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montototaldevoluciones( txVal as variant ) as void

		this.Montototaldevoluciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montototalanulaciondevoluciones( txVal as variant ) as void

		this.Montototalanulaciondevoluciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montototal( txVal as variant ) as void

		this.Montototal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nrolote( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tarjetadetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montototalcompras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montototalanulacioncompras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montototaldevoluciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montototalanulaciondevoluciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montototal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tarjeta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Tarjeta ) = 'O' or isnull( this.Tarjeta ) )
					this.Tarjeta = _Screen.zoo.instanciarentidad( 'Valor' )
					this.Tarjeta.lEsSubEntidad = .t.
					this.enlazar( 'Tarjeta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Tarjeta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Tarjeta.CODIGO # this.Tarjeta_PK
						this.Tarjeta.CODIGO = this.Tarjeta_PK
					endif
				endif
			endif
		endif
		return this.Tarjeta
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
				.Nrolote = 0
				.Tarjeta_PK = []
				.Tarjetadetalle = []
				.Montototalcompras = 0
				.Montototalanulacioncompras = 0
				.Montototaldevoluciones = 0
				.Montototalanulaciondevoluciones = 0
				.Montototal = 0
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
	Function ValorSugeridoNrolote() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CIERREDELOTE", "Detalle", "Nrolote" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Nrolote' )
						.Nrolote = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Lote para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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

		if  empty( this.Tarjeta_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMLOTE]
	endfunc

enddefine