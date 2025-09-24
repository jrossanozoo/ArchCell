
define class Din_ItemECOMMERCEEquivaloresdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'ECOMMERCE'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	ValorEcommerce = []
	TipoValorEcommerce = []
	ValorDragonfish_PK = []
	ValorDragonfish = null
	ValorDescripcion = []
	TipoValorDragon = []
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ECOMMERCE', 'Equivaloresdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valordragonfish_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valordragonfish_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Valordragonfish_PK = lxVal

		if this.Validar_Valordragonfish( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Valordragonfish_Pk', lxValOld, lxVal  )
			This.Setear_Valordragonfish( lxVal )
			this.EventoDespuesDeSetear( This, 'Valordragonfish_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Valordescripcion ) 
				this.Valordescripcion = This.ValorDragonfish.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Valordragonfish_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valordragonfish( txVal as variant ) as void

		this.Valordragonfish.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valordragonfish( txVal as variant, txValOld as variant ) as Boolean

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
	function Valorecommerce_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valorecommerce
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Valorecommerce( lxVal )
				this.EventoAntesDeSetear( This, 'Valorecommerce', lxValOld, lxVal  )
				this.Setear_Valorecommerce( lxVal )
				this.EventoDespuesDeSetear( This, 'Valorecommerce', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Valorecommerce', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Valorecommerce( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipovalorecommerce_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipovalorecommerce
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipovalorecommerce( lxVal )
				this.EventoAntesDeSetear( This, 'Tipovalorecommerce', lxValOld, lxVal  )
				this.Setear_Tipovalorecommerce( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipovalorecommerce', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipovalorecommerce', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipovalorecommerce( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valordescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valordescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Valordescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Valordescripcion', lxValOld, lxVal  )
				this.Setear_Valordescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Valordescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Valordescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Valordescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipovalordragon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipovalordragon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipovalordragon( lxVal )
				this.EventoAntesDeSetear( This, 'Tipovalordragon', lxValOld, lxVal  )
				this.Setear_Tipovalordragon( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipovalordragon', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipovalordragon', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipovalordragon( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valorecommerce( txVal as variant ) as void

		this.Valorecommerce = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipovalorecommerce( txVal as variant ) as void

		this.Tipovalorecommerce = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valordescripcion( txVal as variant ) as void

		this.Valordescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipovalordragon( txVal as variant ) as void

		this.Tipovalordragon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valorecommerce( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipovalorecommerce( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valordescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipovalordragon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valordragonfish_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Valordragonfish ) = 'O' or isnull( this.Valordragonfish ) )
					this.Valordragonfish = _Screen.zoo.instanciarentidad( 'Valor' )
					this.Valordragonfish.lEsSubEntidad = .t.
					this.enlazar( 'Valordragonfish.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Valordragonfish.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Valordragonfish.CODIGO # this.Valordragonfish_PK
						this.Valordragonfish.CODIGO = this.Valordragonfish_PK
					endif
				endif
			endif
		endif
		return this.Valordragonfish
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
				.Valorecommerce = []
				.Tipovalorecommerce = []
				.Valordragonfish_PK = []
				.Valordescripcion = []
				.Tipovalordragon = []
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
	Function ValorSugeridoValorecommerce() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ECOMMERCE", "Equivaloresdetalle", "Valorecommerce" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Valorecommerce' )
						.Valorecommerce = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código de valor ecommerce para el detalle Equivalencias de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoValordragonfish() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ECOMMERCE", "Equivaloresdetalle", "Valordragonfish" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Valordragonfish_PK' )
						.Valordragonfish_PK = lvValorSugeridoDefinidoPorElUsuario
						.Valordragonfish.CODIGO = .Valordragonfish_PK
					endif
				endif
			Catch to loError
				.Valordragonfish_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Valor para el detalle Equivalencias de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
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

		if  empty( this.Valorecommerce ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMEQUIVALORES]
	endfunc

enddefine