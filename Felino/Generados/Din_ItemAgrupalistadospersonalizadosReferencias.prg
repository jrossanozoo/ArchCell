
define class Din_ItemAGRUPALISTADOSPERSONALIZADOSReferencias as ItemActivo of ItemActivo.prg

	cNombre = 'AGRUPALISTADOSPERSONALIZADOS'
	NROITEM = 0
	EsDefault = .F.
	IDListado = []
	NombreDelAccesoDirecto = []
	Personalizacion_PK = []
	Personalizacion = null
	cAtributoPK = 'Nombre'
	Nombre = []
	OrdenVisual = 0
	AccesoDirecto = []
	NombreListado = []
	NombrePersonalizacion = []
	AtributoFecha = []
	lHabilitarAtributoFecha = .T.
	Activado = .F.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarAtributoFecha = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWActivado()','Activado')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'AGRUPALISTADOSPERSONALIZADOS', 'Referencias')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Personalizacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Personalizacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Personalizacion_PK = lxVal

		if this.Validar_Personalizacion( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Personalizacion_Pk', lxValOld, lxVal  )
			This.Setear_Personalizacion( lxVal )
			this.EventoDespuesDeSetear( This, 'Personalizacion_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Personalizacion_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Personalizacion( txVal as variant ) as void

		this.Personalizacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Personalizacion( txVal as variant, txValOld as variant ) as Boolean

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
	function Esdefault_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Esdefault
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Esdefault( lxVal )
				this.EventoAntesDeSetear( This, 'Esdefault', lxValOld, lxVal  )
				this.Setear_Esdefault( lxVal )
				this.EventoDespuesDeSetear( This, 'Esdefault', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Esdefault', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Esdefault( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idlistado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idlistado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idlistado( lxVal )
				this.EventoAntesDeSetear( This, 'Idlistado', lxValOld, lxVal  )
				this.Setear_Idlistado( lxVal )
				this.EventoDespuesDeSetear( This, 'Idlistado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idlistado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idlistado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nombredelaccesodirecto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nombredelaccesodirecto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nombredelaccesodirecto( lxVal )
				this.EventoAntesDeSetear( This, 'Nombredelaccesodirecto', lxValOld, lxVal  )
				this.Setear_Nombredelaccesodirecto( lxVal )
				this.EventoDespuesDeSetear( This, 'Nombredelaccesodirecto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nombredelaccesodirecto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nombredelaccesodirecto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ordenvisual_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ordenvisual
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ordenvisual( lxVal )
				this.EventoAntesDeSetear( This, 'Ordenvisual', lxValOld, lxVal  )
				this.Setear_Ordenvisual( lxVal )
				this.EventoDespuesDeSetear( This, 'Ordenvisual', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ordenvisual', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ordenvisual( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Accesodirecto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Accesodirecto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Accesodirecto( lxVal )
				this.EventoAntesDeSetear( This, 'Accesodirecto', lxValOld, lxVal  )
				this.Setear_Accesodirecto( lxVal )
				this.EventoDespuesDeSetear( This, 'Accesodirecto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Accesodirecto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Accesodirecto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nombrelistado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nombrelistado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nombrelistado( lxVal )
				this.EventoAntesDeSetear( This, 'Nombrelistado', lxValOld, lxVal  )
				this.Setear_Nombrelistado( lxVal )
				this.EventoDespuesDeSetear( This, 'Nombrelistado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nombrelistado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nombrelistado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nombrepersonalizacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nombrepersonalizacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nombrepersonalizacion( lxVal )
				this.EventoAntesDeSetear( This, 'Nombrepersonalizacion', lxValOld, lxVal  )
				this.Setear_Nombrepersonalizacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Nombrepersonalizacion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nombrepersonalizacion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nombrepersonalizacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Atributofecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Atributofecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Atributofecha( lxVal )
				if ( this.lHabilitarAtributofecha or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Atributofecha', lxValOld, lxVal  )
					this.Setear_Atributofecha( lxVal )
				this.EventoDespuesDeSetear( This, 'Atributofecha', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Atributofecha', This )
						Endif
					EndIf
				else
					this.Atributofecha = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Agrupamiento de listados personalizados - Atributo: Atributofecha)" )
				endif 
			EndIf
		Else
			This.Setear_Atributofecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Activado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Activado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Activado( lxVal )
				this.EventoAntesDeSetear( This, 'Activado', lxValOld, lxVal  )
				this.Setear_Activado( lxVal )
				this.EventoDespuesDeSetear( This, 'Activado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Activado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Activado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Esdefault( txVal as variant ) as void

		this.Esdefault = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idlistado( txVal as variant ) as void

		this.Idlistado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nombredelaccesodirecto( txVal as variant ) as void

		this.Nombredelaccesodirecto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ordenvisual( txVal as variant ) as void

		this.Ordenvisual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Accesodirecto( txVal as variant ) as void

		this.Accesodirecto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nombrelistado( txVal as variant ) as void

		this.Nombrelistado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nombrepersonalizacion( txVal as variant ) as void

		this.Nombrepersonalizacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Atributofecha( txVal as variant ) as void

		this.Atributofecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Activado( txVal as variant ) as void

		this.Activado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Esdefault( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idlistado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nombredelaccesodirecto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ordenvisual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Accesodirecto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nombrelistado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nombrepersonalizacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Atributofecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Activado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Personalizacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Personalizacion ) = 'O' or isnull( this.Personalizacion ) )
					this.Personalizacion = _Screen.zoo.instanciarentidad( 'Listadospersonalizados' )
					this.Personalizacion.lEsSubEntidad = .t.
					this.enlazar( 'Personalizacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Personalizacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Personalizacion.CODIGO # this.Personalizacion_PK
						this.Personalizacion.CODIGO = this.Personalizacion_PK
					endif
				endif
			endif
		endif
		return this.Personalizacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Esdefault = .F.
				.Idlistado = []
				.Nombredelaccesodirecto = []
				.Personalizacion_PK = []
				.Nombre = []
				.Ordenvisual = 0
				.Accesodirecto = []
				.Nombrelistado = []
				.Nombrepersonalizacion = []
				.Atributofecha = []
				.Activado = .F.
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
	Function ValorSugeridoOrdenvisual() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "AGRUPALISTADOSPERSONALIZADOS", "Referencias", "Ordenvisual" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Ordenvisual' )
						.Ordenvisual = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Orden para el detalle Referencias." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoAccesodirecto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "AGRUPALISTADOSPERSONALIZADOS", "Referencias", "Accesodirecto" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Accesodirecto' )
						.Accesodirecto = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Acceso directo para el detalle Referencias." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoAtributofecha() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "AGRUPALISTADOSPERSONALIZADOS", "Referencias", "Atributofecha" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Atributofecha' )
						.Atributofecha = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha a filtrar para el detalle Referencias." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWActivado() as void
		with this
			.Activado = .T.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoActivado() as void
		with this
			.ValorSugeridoFWActivado()
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

		if  empty( this.Ordenvisual ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarAtributoFecha = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMREFERENCIAALISTADO]
	endfunc

enddefine