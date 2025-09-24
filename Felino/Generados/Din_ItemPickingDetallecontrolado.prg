
define class Din_ItemPICKINGDetallecontrolado as ItemPickingControlados of ItemPickingControlados.prg

	cNombre = 'PICKING'
	Comportamiento = 0
	NROITEM = 0
	Agregado = .F.
	NoProcesarStock = .F.
	CodigoDeBarras = []
	IdItemArticulos = []
	Articulo_PK = []
	Articulo = null
	lHabilitarArticulo_PK = .T.
	Equivalencia_PK = []
	Equivalencia = null
	cAtributoPK = 'Codigo'
	Codigo = []
	ArticuloDetalle = []
	Color_PK = []
	Color = null
	lHabilitarColor_PK = .T.
	ColorDetalle = []
	Talle = []
	lHabilitarTalle = .T.
	Cantidad = 0
	lHabilitarCantidad = .T.
	Afe_saldo = 0
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarArticulo_PK = .T.
		this.lHabilitarColor_PK = .T.
		this.lHabilitarTalle = .T.
		this.lHabilitarCantidad = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIditemarticulos()','Iditemarticulos')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'PICKING', 'Detallecontrolado')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.TotalizarSumarizado()
				EndIf
			If lxValOld != lxVal or empty( this.Comportamiento ) 
				this.Comportamiento = This.Articulo.Comportamiento
			endif
			If lxValOld != lxVal or empty( this.Articulodetalle ) 
				this.Articulodetalle = This.Articulo.Descripcion
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulo_Pk', This )
					Endif
				EndIf
			else
				this.Articulo_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Picking - Atributo: Articulo)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Equivalencia_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Equivalencia_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 14, padr( lxVal, 14 ), lxVal )
		this.Equivalencia_PK = lxVal

		if this.Validar_Equivalencia( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Equivalencia_Pk', lxValOld, lxVal  )
			This.Setear_Equivalencia( lxVal )
			this.EventoDespuesDeSetear( This, 'Equivalencia_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Equivalencia_Pk', This )
				Endif
			EndIf
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Picking - Atributo: Color)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo( txVal as variant ) as void

		this.Articulo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Equivalencia( txVal as variant ) as void

		this.Equivalencia.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Color( txVal as variant ) as void

		this.Color.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.ValidaArticuloTipoKit() 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Equivalencia( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comportamiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comportamiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comportamiento( lxVal )
				this.EventoAntesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
				this.Setear_Comportamiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comportamiento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comportamiento( lxVal ) 
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
	function Agregado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Agregado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Agregado( lxVal )
				this.EventoAntesDeSetear( This, 'Agregado', lxValOld, lxVal  )
				this.Setear_Agregado( lxVal )
				this.EventoDespuesDeSetear( This, 'Agregado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Agregado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Agregado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Noprocesarstock_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Noprocesarstock
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Noprocesarstock( lxVal )
				this.EventoAntesDeSetear( This, 'Noprocesarstock', lxValOld, lxVal  )
				this.Setear_Noprocesarstock( lxVal )
				this.EventoDespuesDeSetear( This, 'Noprocesarstock', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Noprocesarstock', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Noprocesarstock( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigodebarras_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigodebarras
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigodebarras( lxVal )
				this.EventoAntesDeSetear( This, 'Codigodebarras', lxValOld, lxVal  )
				this.Setear_Codigodebarras( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigodebarras', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigodebarras', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigodebarras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditemarticulos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemarticulos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemarticulos( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemarticulos', lxValOld, lxVal  )
				this.Setear_Iditemarticulos( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemarticulos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemarticulos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemarticulos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
				this.Setear_Articulodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Articulodetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Colordetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Colordetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Colordetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Colordetalle', lxValOld, lxVal  )
				this.Setear_Colordetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Colordetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Colordetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Colordetalle( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Picking - Atributo: Talle)" )
				endif 
			EndIf
		Else
			This.Setear_Talle( lxVal ) 
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
				if ( this.lHabilitarCantidad or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Cantidad', lxValOld, lxVal  )
					this.Setear_Cantidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Cantidad', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Cantidad', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cantidad', This )
						Endif
					EndIf
				else
					this.Cantidad = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Picking - Atributo: Cantidad)" )
				endif 
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_saldo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_saldo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_saldo( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_saldo', lxValOld, lxVal  )
				this.Setear_Afe_saldo( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldo', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Afe_saldo', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_saldo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_saldo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comportamiento( txVal as variant ) as void

		this.Comportamiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Agregado( txVal as variant ) as void

		this.Agregado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Noprocesarstock( txVal as variant ) as void

		this.Noprocesarstock = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigodebarras( txVal as variant ) as void

		this.Codigodebarras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemarticulos( txVal as variant ) as void

		this.Iditemarticulos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulodetalle( txVal as variant ) as void

		this.Articulodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Colordetalle( txVal as variant ) as void

		this.Colordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Talle( txVal as variant ) as void

		this.Talle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldo( txVal as variant ) as void

		this.Afe_saldo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comportamiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Agregado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Noprocesarstock( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigodebarras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemarticulos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Colordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Equivalencia_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Equivalencia ) = 'O' or isnull( this.Equivalencia ) )
					this.Equivalencia = _Screen.zoo.instanciarentidad( 'Equivalencia' )
					this.Equivalencia.lEsSubEntidad = .t.
					this.enlazar( 'Equivalencia.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Equivalencia.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Equivalencia.CODIGO # this.Equivalencia_PK
						this.Equivalencia.CODIGO = this.Equivalencia_PK
					endif
				endif
			endif
		endif
		return this.Equivalencia
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

				.Comportamiento = 0
				.Agregado = .F.
				.Noprocesarstock = .F.
				.Articulo_PK = []
				.Equivalencia_PK = []
				.Codigo = []
				.Articulodetalle = []
				.Color_PK = []
				.Colordetalle = []
				.Talle = []
				.Cantidad = 0
				.Afe_saldo = 0
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
	Function ValorSugeridoFWIditemarticulos() as void
		with this
			.Iditemarticulos = goServicios.Librerias.ObtenerGuidPk()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIditemarticulos() as void
		with this
			.ValorSugeridoFWIditemarticulos()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoArticulo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PICKING", "Detallecontrolado", "Articulo" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Articulo_PK' )
						.Articulo_PK = lvValorSugeridoDefinidoPorElUsuario
						.Articulo.CODIGO = .Articulo_PK
					endif
				endif
			Catch to loError
				.Articulo_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo para el detalle Artículos controlados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoColor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PICKING", "Detallecontrolado", "Color" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Color_PK' )
						.Color_PK = lvValorSugeridoDefinidoPorElUsuario
						.Color.CODIGO = .Color_PK
					endif
				endif
			Catch to loError
				.Color_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para el detalle Artículos controlados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PICKING", "Detallecontrolado", "Talle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Talle' )
						.Talle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para el detalle Artículos controlados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCantidad() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PICKING", "Detallecontrolado", "Cantidad" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cantidad' )
						.Cantidad = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad para el detalle Artículos controlados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			.Codigodebarras = []
			.Iditemarticulos = []
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

		if  empty( this.Articulo_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarArticulo_PK = tlHabilitar
		this.lHabilitarColor_PK = tlHabilitar
		this.lHabilitarTalle = tlHabilitar
		this.lHabilitarCantidad = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMOKPICKING]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidaArticuloTipoKit() as void
		if this.Articulo.Comportamiento = 4
			goServicios.Errores.LevantarExcepcion( 'No se pueden ingresar artículos de tipo kit.' )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.ARTICULO_PK) and dodefault()
		return llRetorno
	endfunc

enddefine