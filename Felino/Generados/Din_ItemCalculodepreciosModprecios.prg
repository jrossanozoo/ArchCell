
define class Din_ItemCALCULODEPRECIOSModprecios as ItemCALCULODEPRECIOS of ItemCALCULODEPRECIOS.prg

	cNombre = 'CALCULODEPRECIOS'
	cAtributoPK = 'Codigo'
	Codigo = 0
	NROITEM = 0
	LPrecio_PK = []
	LPrecio = null
	LPrecioDetalle = []
	Accion = []
	LPrecioA_PK = []
	LPrecioA = null
	Valor = 0
	Formula_PK = []
	Formula = null
	Redondeo_PK = []
	Redondeo = null
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWAccion()','Accion')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CALCULODEPRECIOS', 'Modprecios')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Lprecio_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Lprecio_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Lprecio_PK = lxVal

		if this.Validar_Lprecio( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Lprecio_Pk', lxValOld, lxVal  )
			This.Setear_Lprecio( lxVal )
			this.EventoDespuesDeSetear( This, 'Lprecio_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Lpreciodetalle ) 
				this.Lpreciodetalle = This.LPrecio.Nombre
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Lprecio_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Lprecioa_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Lprecioa_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Lprecioa_PK = lxVal

		if this.Validar_Lprecioa( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Lprecioa_Pk', lxValOld, lxVal  )
			This.Setear_Lprecioa( lxVal )
			this.EventoDespuesDeSetear( This, 'Lprecioa_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Lprecioa_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Formula_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Formula_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Formula.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Formula )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Formula_PK = lxVal

		if this.Validar_Formula( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Formula_Pk', lxValOld, lxVal  )
			This.Setear_Formula( lxVal )
			this.EventoDespuesDeSetear( This, 'Formula_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Formula_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Redondeo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Redondeo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Redondeo_PK = lxVal

		if this.Validar_Redondeo( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Redondeo_Pk', lxValOld, lxVal  )
			This.Setear_Redondeo( lxVal )
			this.EventoDespuesDeSetear( This, 'Redondeo_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Redondeo_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Lprecio( txVal as variant ) as void

		this.Lprecio.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Lprecioa( txVal as variant ) as void

		this.Lprecioa.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Formula( txVal as variant ) as void

		this.Formula.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Redondeo( txVal as variant ) as void

		this.Redondeo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Lprecio( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Lprecioa( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Formula( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Redondeo( txVal as variant, txValOld as variant ) as Boolean

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
	function Lpreciodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Lpreciodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Lpreciodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Lpreciodetalle', lxValOld, lxVal  )
				this.Setear_Lpreciodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Lpreciodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Lpreciodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Lpreciodetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Accion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Accion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Accion( lxVal )
				this.EventoAntesDeSetear( This, 'Accion', lxValOld, lxVal  )
				this.Setear_Accion( lxVal )
				this.EventoDespuesDeSetear( This, 'Accion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Accion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Accion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Valor( lxVal )
				this.EventoAntesDeSetear( This, 'Valor', lxValOld, lxVal  )
				this.Setear_Valor( lxVal )
				this.EventoDespuesDeSetear( This, 'Valor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Valor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Valor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Lpreciodetalle( txVal as variant ) as void

		this.Lpreciodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Accion( txVal as variant ) as void

		this.Accion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valor( txVal as variant ) as void

		this.Valor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Lpreciodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Accion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Lprecio_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Lprecio ) = 'O' or isnull( this.Lprecio ) )
					this.Lprecio = _Screen.zoo.instanciarentidad( 'Listadeprecios' )
					this.Lprecio.lEsSubEntidad = .t.
					this.enlazar( 'Lprecio.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Lprecio.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Lprecio.CODIGO # this.Lprecio_PK
						this.Lprecio.CODIGO = this.Lprecio_PK
					endif
				endif
			endif
		endif
		return this.Lprecio
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Lprecioa_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Lprecioa ) = 'O' or isnull( this.Lprecioa ) )
					this.Lprecioa = _Screen.zoo.instanciarentidad( 'Listadeprecios' )
					this.Lprecioa.lEsSubEntidad = .t.
					this.enlazar( 'Lprecioa.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Lprecioa.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Lprecioa.CODIGO # this.Lprecioa_PK
						this.Lprecioa.CODIGO = this.Lprecioa_PK
					endif
				endif
			endif
		endif
		return this.Lprecioa
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Formula_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Formula ) = 'O' or isnull( this.Formula ) )
					this.Formula = _Screen.zoo.instanciarentidad( 'Formula' )
					this.Formula.lEsSubEntidad = .t.
					this.enlazar( 'Formula.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Formula.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Formula.CODIGO # this.Formula_PK
						this.Formula.CODIGO = this.Formula_PK
					endif
				endif
			endif
		endif
		return this.Formula
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Redondeo_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Redondeo ) = 'O' or isnull( this.Redondeo ) )
					this.Redondeo = _Screen.zoo.instanciarentidad( 'Redondeodeprecios' )
					this.Redondeo.lEsSubEntidad = .t.
					this.enlazar( 'Redondeo.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Redondeo.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Redondeo.CODIGO # this.Redondeo_PK
						this.Redondeo.CODIGO = this.Redondeo_PK
					endif
				endif
			endif
		endif
		return this.Redondeo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.ObtenerNombre() + " - " + transform( This.Codigo, "@LZ 99999999" ) ) )
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

				.Codigo = 0
				.Lprecio_PK = []
				.Lpreciodetalle = []
				.Accion = []
				.Lprecioa_PK = []
				.Valor = 0
				.Formula_PK = []
				.Redondeo_PK = []
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
	Function ValorSugeridoLprecio() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Lprecio" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Lprecio_PK' )
						.Lprecio_PK = lvValorSugeridoDefinidoPorElUsuario
						.Lprecio.CODIGO = .Lprecio_PK
					endif
				endif
			Catch to loError
				.Lprecio_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo L. precio para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLpreciodetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Lpreciodetalle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Lpreciodetalle' )
						.Lpreciodetalle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoAccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Accion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Accion' )
						.Accion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Acción para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWAccion()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWAccion() as void
		with this
			.Accion = "1"
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLprecioa() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Lprecioa" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Lprecioa_PK' )
						.Lprecioa_PK = lvValorSugeridoDefinidoPorElUsuario
						.Lprecioa.CODIGO = .Lprecioa_PK
					endif
				endif
			Catch to loError
				.Lprecioa_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Aplic.L.Precio para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoValor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Valor" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Valor' )
						.Valor = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Valor para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFormula() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Formula" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Formula_PK' )
						.Formula_PK = lvValorSugeridoDefinidoPorElUsuario
						.Formula.CODIGO = .Formula_PK
					endif
				endif
			Catch to loError
				.Formula_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fórmula para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRedondeo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "Modprecios", "Redondeo" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Redondeo_PK' )
						.Redondeo_PK = lvValorSugeridoDefinidoPorElUsuario
						.Redondeo.CODIGO = .Redondeo_PK
					endif
				endif
			Catch to loError
				.Redondeo_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Redondeo para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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

		if  empty( this.Lprecio_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCALCULODEPRECIOS]
	endfunc

enddefine