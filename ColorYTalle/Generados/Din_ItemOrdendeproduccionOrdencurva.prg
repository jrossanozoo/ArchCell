
define class Din_ItemORDENDEPRODUCCIONOrdencurva as ItemBaseProduccion of ItemBaseProduccion.prg

	cNombre = 'ORDENDEPRODUCCION'
	NROITEM = 0
	cAtributoPK = 'CodigoOrden'
	CodigoOrden = []
	Producto_PK = []
	Producto = null
	ProductoDetalle = []
	Color_PK = []
	Color = null
	ColorDetalle = []
	Talle_PK = []
	Talle = null
	TalleDetalle = []
	Cantidad = 0
	Total = 0
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWCantidad()','Cantidad')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ORDENDEPRODUCCION', 'Ordencurva')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Producto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Producto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Producto.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Producto )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Producto_PK = lxVal

		if this.Validar_Producto( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Producto_Pk', lxValOld, lxVal  )
			This.Setear_Producto( lxVal )
			this.EventoDespuesDeSetear( This, 'Producto_Pk', lxValOld, lxVal  )
			If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
				this.TotalizarSumarizado()
			EndIf
			If lxValOld != lxVal or empty( this.Productodetalle ) 
				this.Productodetalle = This.Producto.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Producto_Pk', This )
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
	function Setear_Producto( txVal as variant ) as void

		this.Producto.CODIGO = txVal
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
	function Validar_Producto( txVal as variant, txValOld as variant ) as Boolean

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
	function Productodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Productodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Productodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Productodetalle', lxValOld, lxVal  )
				this.Setear_Productodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Productodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Productodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Productodetalle( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
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
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Total_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Total
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Total( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Total', lxValOld, lxVal  )
				this.Setear_Total( lxVal )
				this.EventoDespuesDeSetear( This, 'Total', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Total', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Total', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Total( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Productodetalle( txVal as variant ) as void

		this.Productodetalle = txVal
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
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Productodetalle( txVal as variant ) as Boolean

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
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Producto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Producto ) = 'O' or isnull( this.Producto ) )
					this.Producto = _Screen.zoo.instanciarentidad( 'Articulo' )
					this.Producto.lEsSubEntidad = .t.
					this.enlazar( 'Producto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Producto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Producto.CODIGO # this.Producto_PK
						this.Producto.CODIGO = this.Producto_PK
					endif
				endif
			endif
		endif
		return this.Producto
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

				.Codigoorden = []
				.Producto_PK = []
				.Productodetalle = []
				.Color_PK = []
				.Colordetalle = []
				.Talle_PK = []
				.Talledetalle = []
				.Cantidad = 0
				.Total = 0
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
	Function ValorSugeridoProducto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDEPRODUCCION", "Ordencurva", "Producto" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Producto_PK' )
						.Producto_PK = lvValorSugeridoDefinidoPorElUsuario
						.Producto.CODIGO = .Producto_PK
					endif
				endif
			Catch to loError
				.Producto_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Producto final para el detalle Producción." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoProductodetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDEPRODUCCION", "Ordencurva", "Productodetalle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Productodetalle' )
						.Productodetalle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción del producto para el detalle Producción." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
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
	Function ValorSugeridoCantidad() as void
		with this
			.ValorSugeridoFWCantidad()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTotal() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDEPRODUCCION", "Ordencurva", "Total" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Total' )
						.Total = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Total para el detalle Producción." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
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

		if  empty( this.Producto_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMORDENCURVA]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.PRODUCTO_PK) and dodefault()
		return llRetorno
	endfunc

enddefine