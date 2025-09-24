
define class Din_ItemPICKINGDetallecomprobantes as ItemActivo of ItemActivo.prg

	cNombre = 'PICKING'
	Cliente = []
	CodigoCompAfe = []
	NROITEM = 0
	EntregaPosterior = 0
	TimestampComprobante = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	Numero = []
	Fecha = ctod( '  /  /    ' )
	OrigenDestino_PK = []
	OrigenDestino = null
	Remito = []
	OrigenDestinoDetalle = []
	Cantidad = 0
	IdDeCaja = []
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'PICKING', 'Detallecomprobantes')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Origendestino_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Origendestino_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 8, padr( lxVal, 8 ), lxVal )
		this.Origendestino_PK = lxVal

		if this.Validar_Origendestino( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Origendestino_Pk', lxValOld, lxVal  )
			This.Setear_Origendestino( lxVal )
			this.EventoDespuesDeSetear( This, 'Origendestino_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Origendestino_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Origendestino( txVal as variant ) as void

		this.Origendestino.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Origendestino( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cliente( lxVal )
				this.EventoAntesDeSetear( This, 'Cliente', lxValOld, lxVal  )
				this.Setear_Cliente( lxVal )
				this.EventoDespuesDeSetear( This, 'Cliente', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cliente', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cliente( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigocompafe_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigocompafe
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigocompafe( lxVal )
				this.EventoAntesDeSetear( This, 'Codigocompafe', lxValOld, lxVal  )
				this.Setear_Codigocompafe( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigocompafe', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigocompafe', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigocompafe( lxVal ) 
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
	function Entregaposterior_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entregaposterior
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entregaposterior( lxVal )
				this.EventoAntesDeSetear( This, 'Entregaposterior', lxValOld, lxVal  )
				this.Setear_Entregaposterior( lxVal )
				this.EventoDespuesDeSetear( This, 'Entregaposterior', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Entregaposterior', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Entregaposterior( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Timestampcomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Timestampcomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Timestampcomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Timestampcomprobante', lxValOld, lxVal  )
				this.Setear_Timestampcomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Timestampcomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Timestampcomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Timestampcomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numero_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numero
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numero( lxVal )
				this.EventoAntesDeSetear( This, 'Numero', lxValOld, lxVal  )
				this.Setear_Numero( lxVal )
				this.EventoDespuesDeSetear( This, 'Numero', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numero', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numero( lxVal ) 
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
				this.ValidarDominio_Fechacalendario( lxVal )
				this.EventoAntesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				this.Setear_Fecha( lxVal )
				this.EventoDespuesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fecha', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Remito_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Remito
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Remito( lxVal )
				this.EventoAntesDeSetear( This, 'Remito', lxValOld, lxVal  )
				this.Setear_Remito( lxVal )
				this.EventoDespuesDeSetear( This, 'Remito', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Remito', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Remito( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Origendestinodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Origendestinodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Origendestinodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Origendestinodetalle', lxValOld, lxVal  )
				this.Setear_Origendestinodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Origendestinodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Origendestinodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Origendestinodetalle( lxVal ) 
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
	function Iddecaja_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iddecaja
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iddecaja( lxVal )
				this.EventoAntesDeSetear( This, 'Iddecaja', lxValOld, lxVal  )
				this.Setear_Iddecaja( lxVal )
				this.EventoDespuesDeSetear( This, 'Iddecaja', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iddecaja', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iddecaja( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigocompafe( txVal as variant ) as void

		this.Codigocompafe = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entregaposterior( txVal as variant ) as void

		this.Entregaposterior = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestampcomprobante( txVal as variant ) as void

		this.Timestampcomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Remito( txVal as variant ) as void

		this.Remito = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Origendestinodetalle( txVal as variant ) as void

		this.Origendestinodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iddecaja( txVal as variant ) as void

		this.Iddecaja = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigocompafe( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entregaposterior( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestampcomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Remito( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Origendestinodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iddecaja( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Origendestino_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Origendestino ) = 'O' or isnull( this.Origendestino ) )
					this.Origendestino = _Screen.zoo.instanciarentidad( 'Origendedatos' )
					this.Origendestino.lEsSubEntidad = .t.
					this.enlazar( 'Origendestino.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Origendestino.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Origendestino.CODIGO # this.Origendestino_PK
						this.Origendestino.CODIGO = this.Origendestino_PK
					endif
				endif
			endif
		endif
		return this.Origendestino
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Cliente = []
				.Codigocompafe = []
				.Entregaposterior = 0
				.Timestampcomprobante = 0
				.Codigo = []
				.Numero = []
				.Fecha = ctod( '  /  /    ' )
				.Origendestino_PK = []
				.Remito = []
				.Origendestinodetalle = []
				.Cantidad = 0
				.Iddecaja = []
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
	Function ValorSugeridoNumero() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PICKING", "Detallecomprobantes", "Numero" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numero' )
						.Numero = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Identificador para el detalle Comprobantes a controlar." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIddecaja() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PICKING", "Detallecomprobantes", "Iddecaja" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Iddecaja' )
						.Iddecaja = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observación para el detalle Comprobantes a controlar." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	function ValidarDominio_Fechacalendario( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechacalendario( txVal )
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

		if  empty( this.Numero ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCOMPROBANTESPICKING]
	endfunc

enddefine