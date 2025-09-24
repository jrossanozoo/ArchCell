
define class Din_ItemSELECCIONORDENDESERVICIODetalleordenes as ItemActivo of ItemActivo.prg

	cNombre = 'SELECCIONORDENDESERVICIO'
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Orden_PK = []
	Orden = null
	lHabilitarOrden_PK = .T.
	TipoDeOrden_PK = []
	TipoDeOrden = null
	lHabilitarTipoDeOrden_PK = .T.
	Articulo_PK = []
	Articulo = null
	lHabilitarArticulo_PK = .T.
	Cliente_PK = []
	Cliente = null
	lHabilitarCliente_PK = .T.
	BaseDeDatos = []
	lHabilitarBaseDeDatos = .T.
	Fecha = ctod( '  /  /    ' )
	lHabilitarFecha = .T.
	Color_PK = []
	Color = null
	lHabilitarColor_PK = .T.
	Talle = []
	lHabilitarTalle = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarNROITEM = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarOrden_PK = .T.
		this.lHabilitarTipoDeOrden_PK = .T.
		this.lHabilitarArticulo_PK = .T.
		this.lHabilitarCliente_PK = .T.
		this.lHabilitarBaseDeDatos = .T.
		this.lHabilitarFecha = .T.
		this.lHabilitarColor_PK = .T.
		this.lHabilitarTalle = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'SELECCIONORDENDESERVICIO', 'Detalleordenes')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Orden_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Orden_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Orden.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Orden )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Orden_PK = lxVal

		if this.Validar_Orden( lxVal, lxValOld )
			if ( this.lHabilitarOrden_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Orden_Pk', lxValOld, lxVal  )
				This.Setear_Orden( lxVal )
				this.EventoDespuesDeSetear( This, 'Orden_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Orden_Pk', This )
					Endif
				EndIf
			else
				this.Orden_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Orden)" )
			endif 
		endif
		If lxValOld != lxVal or empty( this.Tipodeorden_PK ) 
			this.Tipodeorden_Pk = This.Orden.TipoDeOrden_PK
		endif
		If lxValOld != lxVal or empty( this.Articulo_PK ) 
			this.Articulo_Pk = This.Orden.Articulo_PK
		endif
		If lxValOld != lxVal or empty( this.Cliente_PK ) 
			this.Cliente_Pk = This.Orden.Cliente_PK
		endif
		If lxValOld != lxVal or empty( this.Basededatos ) 
			this.Basededatos = This.Orden.BaseDeDatosAltaFW
		endif
		If lxValOld != lxVal or empty( this.Fecha ) 
			this.Fecha = This.Orden.Fecha
		endif
		If lxValOld != lxVal or empty( this.Color_PK ) 
			this.Color_Pk = This.Orden.Color_PK
		endif
		If lxValOld != lxVal or empty( this.Talle ) 
			this.Talle = This.Orden.Talle
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodeorden_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodeorden_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Tipodeorden_PK = lxVal

		if this.Validar_Tipodeorden( lxVal, lxValOld )
			if ( this.lHabilitarTipodeorden_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Tipodeorden_Pk', lxValOld, lxVal  )
				This.Setear_Tipodeorden( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodeorden_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipodeorden_Pk', This )
					Endif
				EndIf
			else
				this.Tipodeorden_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Tipodeorden)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 13, padr( lxVal, 13 ), lxVal )
		this.Articulo_PK = lxVal

		if this.Validar_Articulo( lxVal, lxValOld )
			if ( this.lHabilitarArticulo_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Articulo_Pk', lxValOld, lxVal  )
				This.Setear_Articulo( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulo_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulo_Pk', This )
					Endif
				EndIf
			else
				this.Articulo_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Articulo)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Cliente.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Cliente_PK = lxVal

		if this.Validar_Cliente( lxVal, lxValOld )
			if ( this.lHabilitarCliente_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
				This.Setear_Cliente( lxVal )
				this.EventoDespuesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cliente_Pk', This )
					Endif
				EndIf
			else
				this.Cliente_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Cliente)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Color_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Color_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 2, padr( lxVal, 2 ), lxVal )
		this.Color_PK = lxVal

		if this.Validar_Color( lxVal, lxValOld )
			if ( this.lHabilitarColor_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
				This.Setear_Color( lxVal )
				this.EventoDespuesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Color_Pk', This )
					Endif
				EndIf
			else
				this.Color_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Color)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Orden( txVal as variant ) as void

		this.Orden.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodeorden( txVal as variant ) as void

		this.Tipodeorden.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo( txVal as variant ) as void

		this.Articulo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Color( txVal as variant ) as void

		this.Color.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Orden( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodeorden( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatos( lxVal )
				if ( this.lHabilitarBasededatos or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Basededatos', lxValOld, lxVal  )
					this.Setear_Basededatos( lxVal )
				this.EventoDespuesDeSetear( This, 'Basededatos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Basededatos', This )
						Endif
					EndIf
				else
					this.Basededatos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Basededatos)" )
				endif 
			EndIf
		Else
			This.Setear_Basededatos( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Fecha)" )
				endif 
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Talle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Talle( lxVal )
				if ( this.lHabilitarTalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Talle', lxValOld, lxVal  )
					this.Setear_Talle( lxVal )
				this.EventoDespuesDeSetear( This, 'Talle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Talle', This )
						Endif
					EndIf
				else
					this.Talle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seleccion de órdenes de servicio - Atributo: Talle)" )
				endif 
			EndIf
		Else
			This.Setear_Talle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatos( txVal as variant ) as void

		this.Basededatos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Talle( txVal as variant ) as void

		this.Talle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Orden_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Orden ) = 'O' or isnull( this.Orden ) )
					this.Orden = _Screen.zoo.instanciarentidad( 'Ordendeservicio' )
					this.Orden.lEsSubEntidad = .t.
					this.enlazar( 'Orden.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Orden.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Orden.CODIGO # this.Orden_PK
						this.Orden.CODIGO = this.Orden_PK
					endif
				endif
			endif
		endif
		return this.Orden
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodeorden_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Tipodeorden ) = 'O' or isnull( this.Tipodeorden ) )
					this.Tipodeorden = _Screen.zoo.instanciarentidad( 'Tipodeorden' )
					this.Tipodeorden.lEsSubEntidad = .t.
					this.enlazar( 'Tipodeorden.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Tipodeorden.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Tipodeorden.CODIGO # this.Tipodeorden_PK
						this.Tipodeorden.CODIGO = this.Tipodeorden_PK
					endif
				endif
			endif
		endif
		return this.Tipodeorden
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Articulo ) = 'O' or isnull( this.Articulo ) )
					this.Articulo = _Screen.zoo.instanciarentidad( 'Articulo' )
					this.Articulo.lEsSubEntidad = .t.
					this.enlazar( 'Articulo.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Articulo.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Articulo.CODIGO # this.Articulo_PK
						this.Articulo.CODIGO = this.Articulo_PK
					endif
				endif
			endif
		endif
		return this.Articulo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )
					this.Cliente = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Cliente.lEsSubEntidad = .t.
					this.enlazar( 'Cliente.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cliente.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cliente.CODIGO # this.Cliente_PK
						this.Cliente.CODIGO = this.Cliente_PK
					endif
				endif
			endif
		endif
		return this.Cliente
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Color_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Color ) = 'O' or isnull( this.Color ) )
					this.Color = _Screen.zoo.instanciarentidad( 'Color' )
					this.Color.lEsSubEntidad = .t.
					this.enlazar( 'Color.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Color.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Color.CODIGO # this.Color_PK
						this.Color.CODIGO = this.Color_PK
					endif
				endif
			endif
		endif
		return this.Color
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
	Function ValorSugeridoOrden() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONORDENDESERVICIO", "Detalleordenes", "Orden" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Orden_PK' )
						.Orden_PK = lvValorSugeridoDefinidoPorElUsuario
						.Orden.CODIGO = .Orden_PK
					endif
				endif
			Catch to loError
				.Orden_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número de orden para el detalle Ordenes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			.Orden_PK = []
			.Tipodeorden_PK = []
			.Articulo_PK = []
			.Cliente_PK = []
			.Basededatos = []
			.Fecha = ctod( '  /  /    ' )
			.Color_PK = []
			.Talle = []
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

		if  empty( this.Orden_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarOrden_PK = tlHabilitar
		this.lHabilitarTipoDeOrden_PK = tlHabilitar
		this.lHabilitarArticulo_PK = tlHabilitar
		this.lHabilitarCliente_PK = tlHabilitar
		this.lHabilitarBaseDeDatos = tlHabilitar
		this.lHabilitarFecha = tlHabilitar
		this.lHabilitarColor_PK = tlHabilitar
		this.lHabilitarTalle = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMORDENDESERVICIO]
	endfunc

enddefine