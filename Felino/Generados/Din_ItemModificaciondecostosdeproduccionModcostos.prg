
define class Din_ItemMODIFICACIONDECOSTOSDEPRODUCCIONModcostos as ItemActivo of ItemActivo.prg

	cNombre = 'MODIFICACIONDECOSTOSDEPRODUCCION'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	Semielaborado_PK = []
	Semielaborado = null
	SemielaboradoDetalle = []
	Color_PK = []
	Color = null
	ColorDetalle = []
	Proceso_PK = []
	Proceso = null
	ProcesoDetalle = []
	Taller_PK = []
	Taller = null
	TallerDetalle = []
	DesdeCantidad = 0
	ListaDeCosto_PK = []
	ListaDeCosto = null
	CostoDeLista = 0
	CostoActualizado = 0
	oCompCostosProduccion = null
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'MODIFICACIONDECOSTOSDEPRODUCCION', 'Modcostos')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Semielaborado_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Semielaborado_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 23, padr( lxVal, 23 ), lxVal )
		this.Semielaborado_PK = lxVal

		if this.Validar_Semielaborado( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Semielaborado_Pk', lxValOld, lxVal  )
			This.Setear_Semielaborado( lxVal )
			this.EventoDespuesDeSetear( This, 'Semielaborado_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Semielaboradodetalle ) 
				this.Semielaboradodetalle = This.Semielaborado.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Semielaborado_Pk', This )
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
			this.EventoAntesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
			This.Setear_Color( lxVal )
			this.EventoDespuesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Colordetalle ) 
				this.Colordetalle = This.Color.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Color_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proceso_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proceso_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Proceso_PK = lxVal

		if this.Validar_Proceso( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Proceso_Pk', lxValOld, lxVal  )
			This.Setear_Proceso( lxVal )
			this.EventoDespuesDeSetear( This, 'Proceso_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Procesodetalle ) 
				this.Procesodetalle = This.Proceso.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Proceso_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Taller_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Taller_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Taller_PK = lxVal

		if this.Validar_Taller( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Taller_Pk', lxValOld, lxVal  )
			This.Setear_Taller( lxVal )
			this.EventoDespuesDeSetear( This, 'Taller_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Tallerdetalle ) 
				this.Tallerdetalle = This.Taller.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Taller_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Listadecosto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Listadecosto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Listadecosto_PK = lxVal

		if this.Validar_Listadecosto( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Listadecosto_Pk', lxValOld, lxVal  )
			This.Setear_Listadecosto( lxVal )
			this.EventoDespuesDeSetear( This, 'Listadecosto_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Listadecosto_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Semielaborado( txVal as variant ) as void

		this.Semielaborado.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Color( txVal as variant ) as void

		this.Color.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proceso( txVal as variant ) as void

		this.Proceso.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Taller( txVal as variant ) as void

		this.Taller.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Listadecosto( txVal as variant ) as void

		this.Listadecosto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Semielaborado( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proceso( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Taller( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Listadecosto( txVal as variant, txValOld as variant ) as Boolean

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
	function Semielaboradodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Semielaboradodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Semielaboradodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Semielaboradodetalle', lxValOld, lxVal  )
				this.Setear_Semielaboradodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Semielaboradodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Semielaboradodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Semielaboradodetalle( lxVal ) 
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
	function Procesodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Procesodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Procesodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Procesodetalle', lxValOld, lxVal  )
				this.Setear_Procesodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Procesodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Procesodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Procesodetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tallerdetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tallerdetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tallerdetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Tallerdetalle', lxValOld, lxVal  )
				this.Setear_Tallerdetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Tallerdetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tallerdetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tallerdetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Desdecantidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Desdecantidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Desdecantidad( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Desdecantidad', lxValOld, lxVal  )
				this.Setear_Desdecantidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Desdecantidad', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Desdecantidad', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Desdecantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Costodelista_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Costodelista
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Costodelista( lxVal )
				this.EventoAntesDeSetear( This, 'Costodelista', lxValOld, lxVal  )
				this.Setear_Costodelista( lxVal )
				this.EventoDespuesDeSetear( This, 'Costodelista', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Costodelista', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Costodelista( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Costoactualizado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Costoactualizado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Costoactualizado( lxVal )
				this.ValidarDominio_Preciononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Costoactualizado', lxValOld, lxVal  )
				this.Setear_Costoactualizado( lxVal )
				this.EventoDespuesDeSetear( This, 'Costoactualizado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Costoactualizado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Costoactualizado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Semielaboradodetalle( txVal as variant ) as void

		this.Semielaboradodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Colordetalle( txVal as variant ) as void

		this.Colordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Procesodetalle( txVal as variant ) as void

		this.Procesodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tallerdetalle( txVal as variant ) as void

		this.Tallerdetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Desdecantidad( txVal as variant ) as void

		this.Desdecantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Costodelista( txVal as variant ) as void

		this.Costodelista = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Costoactualizado( txVal as variant ) as void

		this.Costoactualizado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Semielaboradodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Colordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Procesodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tallerdetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Desdecantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Costodelista( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Costoactualizado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Semielaborado_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Semielaborado ) = 'O' or isnull( this.Semielaborado ) )
					this.Semielaborado = _Screen.zoo.instanciarentidad( 'Insumo' )
					this.Semielaborado.lEsSubEntidad = .t.
					this.enlazar( 'Semielaborado.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Semielaborado.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Semielaborado.CODIGO # this.Semielaborado_PK
						this.Semielaborado.CODIGO = this.Semielaborado_PK
					endif
				endif
			endif
		endif
		return this.Semielaborado
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
	function Proceso_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Proceso ) = 'O' or isnull( this.Proceso ) )
					this.Proceso = _Screen.zoo.instanciarentidad( 'Procesoproduccion' )
					this.Proceso.lEsSubEntidad = .t.
					this.enlazar( 'Proceso.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Proceso.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Proceso.CODIGO # this.Proceso_PK
						this.Proceso.CODIGO = this.Proceso_PK
					endif
				endif
			endif
		endif
		return this.Proceso
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Taller_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Taller ) = 'O' or isnull( this.Taller ) )
					this.Taller = _Screen.zoo.instanciarentidad( 'Taller' )
					this.Taller.lEsSubEntidad = .t.
					this.enlazar( 'Taller.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Taller.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Taller.CODIGO # this.Taller_PK
						this.Taller.CODIGO = this.Taller_PK
					endif
				endif
			endif
		endif
		return this.Taller
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Listadecosto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Listadecosto ) = 'O' or isnull( this.Listadecosto ) )
					this.Listadecosto = _Screen.zoo.instanciarentidad( 'Listadecostosdeproduccion' )
					this.Listadecosto.lEsSubEntidad = .t.
					this.enlazar( 'Listadecosto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Listadecosto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Listadecosto.CODIGO # this.Listadecosto_PK
						this.Listadecosto.CODIGO = this.Listadecosto_PK
					endif
				endif
			endif
		endif
		return this.Listadecosto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompCostosproduccion_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompCostosproduccion ) = 'O' or isnull( this.oCompCostosproduccion ) )
			this.oCompCostosproduccion = _Screen.zoo.InstanciarComponente( 'ComponenteCostosproduccion' )
		this.oCompCostosproduccion.Inicializar()
		this.enlazar( 'oCompCostosproduccion.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompCostosproduccion.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompCostosproduccion
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
				.Semielaborado_PK = []
				.Semielaboradodetalle = []
				.Color_PK = []
				.Colordetalle = []
				.Proceso_PK = []
				.Procesodetalle = []
				.Taller_PK = []
				.Tallerdetalle = []
				.Desdecantidad = 0
				.Listadecosto_PK = []
				.Costodelista = 0
				.Costoactualizado = 0
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Preciononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Preciononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		this.oCompCostosProduccion = null
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		If this.oCompCostosProduccion.ValidarAtributo( txVal, tcAtributo )
		else
			llRetorno = .F.
		endif
		
		if llRetorno
		else
			goServicios.Errores.LevantarExcepcion( This.ObtenerInformacion() )
		endif
		
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

		if  empty( this.Semielaborado_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMMODCOSTOPROD]
	endfunc

enddefine