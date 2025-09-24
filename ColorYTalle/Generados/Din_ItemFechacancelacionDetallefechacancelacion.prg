
define class Din_ItemFECHACANCELACIONDetallefechacancelacion as ItemActivo of ItemActivo.prg

	cNombre = 'FECHACANCELACION'
	CodigoOpeEcommerce = []
	lHabilitarCodigoOpeEcommerce = .T.
	NumeroItemOriginal = 0
	lHabilitarNumeroItemOriginal = .T.
	Comportamiento = 0
	lHabilitarComportamiento = .T.
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	IDPublicacion = []
	lHabilitarIDPublicacion = .T.
	Articulo_PK = []
	Articulo = null
	lHabilitarArticulo_PK = .T.
	ArticuloDetalle = []
	lHabilitarArticuloDetalle = .T.
	Color_PK = []
	Color = null
	lHabilitarColor_PK = .T.
	Talle_PK = []
	Talle = null
	lHabilitarTalle_PK = .T.
	Cantidad = 0
	lHabilitarCantidad = .T.
	Precio = 0
	lHabilitarPrecio = .T.
	Monto = 0
	lHabilitarMonto = .T.
	FechaCancelacion = ctod( '  /  /    ' )
	lHabilitarFechaCancelacion = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCodigoOpeEcommerce = .T.
		this.lHabilitarNumeroItemOriginal = .T.
		this.lHabilitarComportamiento = .T.
		this.lHabilitarNROITEM = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarIDPublicacion = .T.
		this.lHabilitarArticulo_PK = .T.
		this.lHabilitarArticuloDetalle = .T.
		this.lHabilitarColor_PK = .T.
		this.lHabilitarTalle_PK = .T.
		this.lHabilitarCantidad = .T.
		this.lHabilitarPrecio = .T.
		this.lHabilitarMonto = .T.
		this.lHabilitarFechaCancelacion = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'FECHACANCELACION', 'Detallefechacancelacion')
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
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Articulo.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Articulo )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Articulo_PK = lxVal

		if this.Validar_Articulo( lxVal, lxValOld )
			if ( this.lHabilitarArticulo_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Articulo_Pk', lxValOld, lxVal  )
				This.Setear_Articulo( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulo_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Comportamiento ) 
				this.Comportamiento = This.Articulo.Comportamiento
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulo_Pk', This )
					Endif
				EndIf
			else
				this.Articulo_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Articulo)" )
			endif 
		endif
		If lxValOld != lxVal or empty( this.Articulodetalle ) 
			this.Articulodetalle = This.Articulo.Descripcion
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Color)" )
			endif 
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
			if ( this.lHabilitarTalle_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Talle_Pk', lxValOld, lxVal  )
				This.Setear_Talle( lxVal )
				this.EventoDespuesDeSetear( This, 'Talle_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Talle_Pk', This )
					Endif
				EndIf
			else
				this.Talle_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Talle)" )
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
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.ValidaArticuloTipoKit() 

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
	function Codigoopeecommerce_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigoopeecommerce
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigoopeecommerce( lxVal )
				if ( this.lHabilitarCodigoopeecommerce or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Codigoopeecommerce', lxValOld, lxVal  )
					this.Setear_Codigoopeecommerce( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigoopeecommerce', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Codigoopeecommerce', This )
						Endif
					EndIf
				else
					this.Codigoopeecommerce = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Codigoopeecommerce)" )
				endif 
			EndIf
		Else
			This.Setear_Codigoopeecommerce( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numeroitemoriginal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numeroitemoriginal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numeroitemoriginal( lxVal )
				if ( this.lHabilitarNumeroitemoriginal or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Numeroitemoriginal', lxValOld, lxVal  )
					this.Setear_Numeroitemoriginal( lxVal )
				this.EventoDespuesDeSetear( This, 'Numeroitemoriginal', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numeroitemoriginal', This )
						Endif
					EndIf
				else
					this.Numeroitemoriginal = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Numeroitemoriginal)" )
				endif 
			EndIf
		Else
			This.Setear_Numeroitemoriginal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comportamiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comportamiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comportamiento( lxVal )
				if ( this.lHabilitarComportamiento or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
					this.Setear_Comportamiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Comportamiento', This )
						Endif
					EndIf
				else
					this.Comportamiento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Comportamiento)" )
				endif 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idpublicacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idpublicacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idpublicacion( lxVal )
				if ( this.lHabilitarIdpublicacion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Idpublicacion', lxValOld, lxVal  )
					this.Setear_Idpublicacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Idpublicacion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Idpublicacion', This )
						Endif
					EndIf
				else
					this.Idpublicacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Idpublicacion)" )
				endif 
			EndIf
		Else
			This.Setear_Idpublicacion( lxVal ) 
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
				if ( this.lHabilitarArticulodetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
					this.Setear_Articulodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Articulodetalle', This )
						Endif
					EndIf
				else
					this.Articulodetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Articulodetalle)" )
				endif 
			EndIf
		Else
			This.Setear_Articulodetalle( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Cantidad)" )
				endif 
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Precio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Precio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Precio( lxVal )
				if ( this.lHabilitarPrecio or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Precio', lxValOld, lxVal  )
					this.Setear_Precio( lxVal )
				this.EventoDespuesDeSetear( This, 'Precio', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Precio', This )
						Endif
					EndIf
				else
					this.Precio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Precio)" )
				endif 
			EndIf
		Else
			This.Setear_Precio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Monto( lxVal )
				if ( this.lHabilitarMonto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Monto', lxValOld, lxVal  )
					this.Setear_Monto( lxVal )
				this.EventoDespuesDeSetear( This, 'Monto', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Monto', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Monto', This )
						Endif
					EndIf
				else
					this.Monto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechacancelacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechacancelacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechacancelacion( lxVal )
				if ( this.lHabilitarFechacancelacion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fecha( lxVal )
					this.EventoAntesDeSetear( This, 'Fechacancelacion', lxValOld, lxVal  )
					this.Setear_Fechacancelacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechacancelacion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Fechacancelacion', This )
						Endif
					EndIf
				else
					this.Fechacancelacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Fecha de cancelación del artículo - Atributo: Fechacancelacion)" )
				endif 
			EndIf
		Else
			This.Setear_Fechacancelacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoopeecommerce( txVal as variant ) as void

		this.Codigoopeecommerce = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numeroitemoriginal( txVal as variant ) as void

		this.Numeroitemoriginal = txVal
		dodefault( txVal )

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
	function Setear_Idpublicacion( txVal as variant ) as void

		this.Idpublicacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulodetalle( txVal as variant ) as void

		this.Articulodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precio( txVal as variant ) as void

		this.Precio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechacancelacion( txVal as variant ) as void

		this.Fechacancelacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoopeecommerce( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numeroitemoriginal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Validar_Idpublicacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechacancelacion( txVal as variant ) as Boolean

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

				.Comportamiento = 0
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
	Function ValorSugeridoFechacancelacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "FECHACANCELACION", "Detallefechacancelacion", "Fechacancelacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechacancelacion' )
						.Fechacancelacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de cancelación para el detalle Artículos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
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
			.Codigoopeecommerce = []
			.Numeroitemoriginal = 0
			.Idpublicacion = []
			.Articulo_PK = []
			.Articulodetalle = []
			.Color_PK = []
			.Talle_PK = []
			.Cantidad = 0
			.Precio = 0
			.Monto = 0
			.Fechacancelacion = ctod( '  /  /    ' )
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
		this.lHabilitarCodigoOpeEcommerce = tlHabilitar
		this.lHabilitarNumeroItemOriginal = tlHabilitar
		this.lHabilitarComportamiento = tlHabilitar
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarIDPublicacion = tlHabilitar
		this.lHabilitarArticulo_PK = tlHabilitar
		this.lHabilitarArticuloDetalle = tlHabilitar
		this.lHabilitarColor_PK = tlHabilitar
		this.lHabilitarTalle_PK = tlHabilitar
		this.lHabilitarCantidad = tlHabilitar
		this.lHabilitarPrecio = tlHabilitar
		this.lHabilitarMonto = tlHabilitar
		this.lHabilitarFechaCancelacion = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMFECHACANCELACION]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidaArticuloTipoKit() as void
		if this.Articulo.Comportamiento = 4
			goServicios.Errores.LevantarExcepcion( 'No se pueden ingresar artículos de tipo kit.' )
		endif
	endfunc

enddefine