
define class Din_ItemFACTURAELECTRONICAPromocionesdetalle as ItemPromociones of ItemPromociones.prg

	cNombre = 'FACTURAELECTRONICA'
	PromocionTipo = 0
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	Promocion_PK = []
	Promocion = null
	PromocionDetalle = []
	Cantidad = 0
	Beneficio = 0
	IdItemPromocion = []
	oCompEnBaseA = null
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIditempromocion()','Iditempromocion')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'FACTURAELECTRONICA', 'Promocionesdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Promocion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Promocion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Promocion_PK = lxVal

		if this.Validar_Promocion( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Promocion_Pk', lxValOld, lxVal  )
			This.Setear_Promocion( lxVal )
			this.EventoDespuesDeSetear( This, 'Promocion_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Promociontipo ) 
				this.Promociontipo = This.Promocion.Tipo
			endif
			If lxValOld != lxVal or empty( this.Promociondetalle ) 
				this.Promociondetalle = This.Promocion.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Promocion_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Promocion( txVal as variant ) as void

		this.Promocion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Promocion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Promociontipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Promociontipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Promociontipo( lxVal )
				this.EventoAntesDeSetear( This, 'Promociontipo', lxValOld, lxVal  )
				this.Setear_Promociontipo( lxVal )
				this.EventoDespuesDeSetear( This, 'Promociontipo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Promociontipo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Promociontipo( lxVal ) 
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
	function Promociondetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Promociondetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Promociondetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Promociondetalle', lxValOld, lxVal  )
				this.Setear_Promociondetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Promociondetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Promociondetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Promociondetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cantidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cantidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cantidad( lxVal )
				this.EventoAntesDeSetear( This, 'Cantidad', lxValOld, lxVal  )
				this.Setear_Cantidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Cantidad', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cantidad', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Beneficio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Beneficio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Beneficio( lxVal )
				this.EventoAntesDeSetear( This, 'Beneficio', lxValOld, lxVal  )
				this.Setear_Beneficio( lxVal )
				this.EventoDespuesDeSetear( This, 'Beneficio', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Beneficio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Beneficio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditempromocion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditempromocion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditempromocion( lxVal )
				this.EventoAntesDeSetear( This, 'Iditempromocion', lxValOld, lxVal  )
				this.Setear_Iditempromocion( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditempromocion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditempromocion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditempromocion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Promociontipo( txVal as variant ) as void

		this.Promociontipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Promociondetalle( txVal as variant ) as void

		this.Promociondetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Beneficio( txVal as variant ) as void

		this.Beneficio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditempromocion( txVal as variant ) as void

		this.Iditempromocion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Promociontipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Promociondetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Beneficio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditempromocion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Promocion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Promocion ) = 'O' or isnull( this.Promocion ) )
					this.Promocion = _Screen.zoo.instanciarentidad( 'Promocion' )
					this.Promocion.lEsSubEntidad = .t.
					this.enlazar( 'Promocion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Promocion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Promocion.CODIGO # this.Promocion_PK
						this.Promocion.CODIGO = this.Promocion_PK
					endif
				endif
			endif
		endif
		return this.Promocion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompEnBaseA_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompEnBaseA ) = 'O' or isnull( this.oCompEnBaseA ) )
			this.oCompEnBaseA = _Screen.zoo.InstanciarComponente( 'ComponenteEnBaseA' )
		this.oCompEnBaseA.Inicializar()
		this.enlazar( 'oCompEnBaseA.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompEnBaseA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompEnBaseA
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.cComprobante +" "+This.Letra + " " + transform(This.PuntoDeVenta,"@LZ 9999") + "-" + transform( This.Numero, "@LZ 99999999" ) ) )
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

				.Promociontipo = 0
				.Codigo = []
				.Promocion_PK = []
				.Promociondetalle = []
				.Cantidad = 0
				.Beneficio = 0
				.Iditempromocion = []
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
	Function ValorSugeridoPromocion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "FACTURAELECTRONICA", "Promocionesdetalle", "Promocion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Promocion_PK' )
						.Promocion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Promocion.CODIGO = .Promocion_PK
					endif
				endif
			Catch to loError
				.Promocion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Promoción para el detalle Promociones." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWIditempromocion() as void
		with this
			.Iditempromocion = goServicios.Librerias.ObtenerGuidPk()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIditempromocion() as void
		with this
			.ValorSugeridoFWIditempromocion()
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
	*-----------------------------------------------------------------------------------------
	function EventoActualizarEmail() as Void
		*
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijos() as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.Promocion_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMPROMOCIONES]
	endfunc

enddefine