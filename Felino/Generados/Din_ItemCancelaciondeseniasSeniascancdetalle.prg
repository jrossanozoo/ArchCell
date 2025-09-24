
define class Din_ItemCANCELACIONDESENIASSeniascancdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'CANCELACIONDESENIAS'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	IdSeniaCancelada = []
	Cliente_PK = []
	Cliente = null
	ClienteDetalle = []
	Comprobante = []
	FechaAlta = ctod( '  /  /    ' )
	FechaVto = ctod( '  /  /    ' )
	Importe = 0
	Seleccionada = .F.
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CANCELACIONDESENIAS', 'Seniascancdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
			this.EventoAntesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
			This.Setear_Cliente( lxVal )
			this.EventoDespuesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
			If This.PuedeEjecutarCambioSumarizado()
				this.CambioSumarizado()
			EndIf
			If lxValOld != lxVal or empty( this.Clientedetalle ) 
				this.Clientedetalle = This.cliente.nombre
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Cliente_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

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
	function Idseniacancelada_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idseniacancelada
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idseniacancelada( lxVal )
				this.EventoAntesDeSetear( This, 'Idseniacancelada', lxValOld, lxVal  )
				this.Setear_Idseniacancelada( lxVal )
				this.EventoDespuesDeSetear( This, 'Idseniacancelada', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idseniacancelada', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idseniacancelada( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Clientedetalle', lxValOld, lxVal  )
				this.Setear_Clientedetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Clientedetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Clientedetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Comprobante', lxValOld, lxVal  )
				this.Setear_Comprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaalta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaalta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaalta( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fechaalta', lxValOld, lxVal  )
				this.Setear_Fechaalta( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechaalta', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechaalta', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechaalta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechavto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavto( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fechavto', lxValOld, lxVal  )
				this.Setear_Fechavto( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechavto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechavto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechavto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Importe_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Importe
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Importe( lxVal )
				this.EventoAntesDeSetear( This, 'Importe', lxValOld, lxVal  )
				this.Setear_Importe( lxVal )
				this.EventoDespuesDeSetear( This, 'Importe', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Importe', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Importe', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Importe( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seleccionada_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seleccionada
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seleccionada( lxVal )
				this.EventoAntesDeSetear( This, 'Seleccionada', lxValOld, lxVal  )
				this.Setear_Seleccionada( lxVal )
				this.EventoDespuesDeSetear( This, 'Seleccionada', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Seleccionada', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Seleccionada( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idseniacancelada( txVal as variant ) as void

		this.Idseniacancelada = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedetalle( txVal as variant ) as void

		this.Clientedetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobante( txVal as variant ) as void

		this.Comprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaalta( txVal as variant ) as void

		this.Fechaalta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavto( txVal as variant ) as void

		this.Fechavto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Importe( txVal as variant ) as void

		this.Importe = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seleccionada( txVal as variant ) as void

		this.Seleccionada = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idseniacancelada( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaalta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Importe( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seleccionada( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.ObtenerNombre()  + " " + This.Letra + " " + transform( This.PuntoDeVenta, "@LZ 9999" ) + "-" + transform( This.Numero, "@LZ 99999999" ) ) )
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

				.Codigo = []
				.Idseniacancelada = []
				.Cliente_PK = []
				.Clientedetalle = []
				.Comprobante = []
				.Fechaalta = ctod( '  /  /    ' )
				.Fechavto = ctod( '  /  /    ' )
				.Importe = 0
				.Seleccionada = .F.
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
	Function ValorSugeridoSeleccionada() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDESENIAS", "Seniascancdetalle", "Seleccionada" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Seleccionada' )
						.Seleccionada = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Seleccionada para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
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

		if  empty( this.Cliente_PK ) or ; 			 empty( this.Clientedetalle ) or ; 			 empty( this.Comprobante ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCANCELACIONDESENIAS]
	endfunc

enddefine