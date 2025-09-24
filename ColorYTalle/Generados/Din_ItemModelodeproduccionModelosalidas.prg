
define class Din_ItemMODELODEPRODUCCIONModelosalidas as ItemProduccionColorYTalle of ItemProduccionColorYTalle.prg

	cNombre = 'MODELODEPRODUCCION'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Proceso_PK = []
	Proceso = null
	lHabilitarProceso_PK = .T.
	ColorM_PK = []
	ColorM = null
	ColorMDetalle = []
	TalleM_PK = []
	TalleM = null
	TalleMDetalle = []
	Semielaborado_PK = []
	Semielaborado = null
	lHabilitarSemielaborado_PK = .T.
	SemielaboradoDetalle = []
	lHabilitarSemielaboradoDetalle = .T.
	Color_PK = []
	Color = null
	ColorDetalle = []
	Talle_PK = []
	Talle = null
	TalleDetalle = []
	Cantidad = 0
	lHabilitarCantidad = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCodigo = .T.
		this.lHabilitarProceso_PK = .T.
		this.lHabilitarSemielaborado_PK = .T.
		this.lHabilitarSemielaboradoDetalle = .T.
		this.lHabilitarCantidad = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWCantidad()','Cantidad')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'MODELODEPRODUCCION', 'Modelosalidas')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proceso_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proceso_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Proceso_PK = lxVal

		if this.Validar_Proceso( lxVal, lxValOld )
			if ( this.lHabilitarProceso_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Proceso_Pk', lxValOld, lxVal  )
				This.Setear_Proceso( lxVal )
				this.EventoDespuesDeSetear( This, 'Proceso_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Proceso_Pk', This )
					Endif
				EndIf
			else
				this.Proceso_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modelo de producción - Atributo: Proceso)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Colorm_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Colorm_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Colorm.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Colorm )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Colorm_PK = lxVal

		if this.Validar_Colorm( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Colorm_Pk', lxValOld, lxVal  )
			This.Setear_Colorm( lxVal )
			this.EventoDespuesDeSetear( This, 'Colorm_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Colormdetalle ) 
				this.Colormdetalle = This.ColorM.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Colorm_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tallem_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tallem_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Tallem.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Tallem )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Tallem_PK = lxVal

		if this.Validar_Tallem( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Tallem_Pk', lxValOld, lxVal  )
			This.Setear_Tallem( lxVal )
			this.EventoDespuesDeSetear( This, 'Tallem_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Tallemdetalle ) 
				this.Tallemdetalle = This.TalleM.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Tallem_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Semielaborado_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Semielaborado_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 25, padr( lxVal, 25 ), lxVal )
		this.Semielaborado_PK = lxVal

		if this.Validar_Semielaborado( lxVal, lxValOld )
			if ( this.lHabilitarSemielaborado_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
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
			else
				this.Semielaborado_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modelo de producción - Atributo: Semielaborado)" )
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
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Color.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Color )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
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
	function Talle_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talle_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Talle.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Talle )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Talle_PK = lxVal

		if this.Validar_Talle( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Talle_Pk', lxValOld, lxVal  )
			This.Setear_Talle( lxVal )
			this.EventoDespuesDeSetear( This, 'Talle_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Talledetalle ) 
				this.Talledetalle = This.Talle.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Talle_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proceso( txVal as variant ) as void

		this.Proceso.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Colorm( txVal as variant ) as void

		this.Colorm.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tallem( txVal as variant ) as void

		this.Tallem.CODIGO = txVal
		dodefault( txVal )

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
	function Setear_Talle( txVal as variant ) as void

		this.Talle.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proceso( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Colorm( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tallem( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Validar_Talle( txVal as variant, txValOld as variant ) as Boolean

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
	function Colormdetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Colormdetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Colormdetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Colormdetalle', lxValOld, lxVal  )
				this.Setear_Colormdetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Colormdetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Colormdetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Colormdetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tallemdetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tallemdetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tallemdetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Tallemdetalle', lxValOld, lxVal  )
				this.Setear_Tallemdetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Tallemdetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tallemdetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tallemdetalle( lxVal ) 
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
				if ( this.lHabilitarSemielaboradodetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Semielaboradodetalle', lxValOld, lxVal  )
					this.Setear_Semielaboradodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Semielaboradodetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Semielaboradodetalle', This )
						Endif
					EndIf
				else
					this.Semielaboradodetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modelo de producción - Atributo: Semielaboradodetalle)" )
				endif 
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
	function Talledetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talledetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Talledetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Talledetalle', lxValOld, lxVal  )
				this.Setear_Talledetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Talledetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Talledetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Talledetalle( lxVal ) 
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
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cantidad', This )
						Endif
					EndIf
				else
					this.Cantidad = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modelo de producción - Atributo: Cantidad)" )
				endif 
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Colormdetalle( txVal as variant ) as void

		this.Colormdetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tallemdetalle( txVal as variant ) as void

		this.Tallemdetalle = txVal
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
	function Setear_Talledetalle( txVal as variant ) as void

		this.Talledetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Colormdetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tallemdetalle( txVal as variant ) as Boolean

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
	function Validar_Talledetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Colorm_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Colorm ) = 'O' or isnull( this.Colorm ) )
					this.Colorm = _Screen.zoo.instanciarentidad( 'Color' )
					this.Colorm.lEsSubEntidad = .t.
					this.enlazar( 'Colorm.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Colorm.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Colorm.CODIGO # this.Colorm_PK
						this.Colorm.CODIGO = this.Colorm_PK
					endif
				endif
			endif
		endif
		return this.Colorm
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tallem_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Tallem ) = 'O' or isnull( this.Tallem ) )
					this.Tallem = _Screen.zoo.instanciarentidad( 'Talle' )
					this.Tallem.lEsSubEntidad = .t.
					this.enlazar( 'Tallem.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Tallem.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Tallem.CODIGO # this.Tallem_PK
						this.Tallem.CODIGO = this.Tallem_PK
					endif
				endif
			endif
		endif
		return this.Tallem
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
	function Talle_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Talle ) = 'O' or isnull( this.Talle ) )
					this.Talle = _Screen.zoo.instanciarentidad( 'Talle' )
					this.Talle.lEsSubEntidad = .t.
					this.enlazar( 'Talle.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Talle.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Talle.CODIGO # this.Talle_PK
						this.Talle.CODIGO = this.Talle_PK
					endif
				endif
			endif
		endif
		return this.Talle
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
				.Proceso_PK = []
				.Colorm_PK = []
				.Colormdetalle = []
				.Tallem_PK = []
				.Tallemdetalle = []
				.Semielaborado_PK = []
				.Semielaboradodetalle = []
				.Color_PK = []
				.Colordetalle = []
				.Talle_PK = []
				.Talledetalle = []
				.Cantidad = 0
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
	Function ValorSugeridoProceso() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MODELODEPRODUCCION", "Modelosalidas", "Proceso" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Proceso_PK' )
						.Proceso_PK = lvValorSugeridoDefinidoPorElUsuario
						.Proceso.CODIGO = .Proceso_PK
					endif
				endif
			Catch to loError
				.Proceso_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proceso para el detalle Salidas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSemielaborado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MODELODEPRODUCCION", "Modelosalidas", "Semielaborado" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Semielaborado_PK' )
						.Semielaborado_PK = lvValorSugeridoDefinidoPorElUsuario
						.Semielaborado.CODIGO = .Semielaborado_PK
					endif
				endif
			Catch to loError
				.Semielaborado_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Semielaborado para el detalle Salidas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSemielaboradodetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MODELODEPRODUCCION", "Modelosalidas", "Semielaboradodetalle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Semielaboradodetalle' )
						.Semielaboradodetalle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción para el detalle Salidas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "MODELODEPRODUCCION", "Modelosalidas", "Cantidad" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad para el detalle Salidas." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWCantidad()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWCantidad() as void
		with this
			.Cantidad = 1
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

		if  empty( this.Proceso_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarProceso_PK = tlHabilitar
		this.lHabilitarSemielaborado_PK = tlHabilitar
		this.lHabilitarSemielaboradoDetalle = tlHabilitar
		this.lHabilitarCantidad = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMMODELOSALIDA]
	endfunc

enddefine