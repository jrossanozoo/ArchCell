
define class Din_ItemVALEDECAMBIOComprobantedetalle as ItemActivo of ItemActivo.prg

	cNombre = 'VALEDECAMBIO'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	CodigoComprobanteDestino = []
	TipoDeComprobanteDestino = 0
	LetraDestino = []
	PuntoDeVentaDestino = 0
	NumeroDestino = 0
	ComprobanteDestino = []
	ClienteDestino = []
	FechaDestino = ctod( '  /  /    ' )
	Monto = 0
	SerieDestino = []
	UsuarioDestino = []
	BDDestino = []
	SignoDeMovimientoDestino = 0
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'VALEDECAMBIO', 'Comprobantedetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
	function Codigocomprobantedestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigocomprobantedestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigocomprobantedestino( lxVal )
				this.EventoAntesDeSetear( This, 'Codigocomprobantedestino', lxValOld, lxVal  )
				this.Setear_Codigocomprobantedestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigocomprobantedestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigocomprobantedestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigocomprobantedestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodecomprobantedestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodecomprobantedestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipodecomprobantedestino( lxVal )
				this.EventoAntesDeSetear( This, 'Tipodecomprobantedestino', lxValOld, lxVal  )
				this.Setear_Tipodecomprobantedestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodecomprobantedestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipodecomprobantedestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipodecomprobantedestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Letradestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letradestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letradestino( lxVal )
				this.EventoAntesDeSetear( This, 'Letradestino', lxValOld, lxVal  )
				this.Setear_Letradestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Letradestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Letradestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Letradestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Puntodeventadestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventadestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventadestino( lxVal )
				this.EventoAntesDeSetear( This, 'Puntodeventadestino', lxValOld, lxVal  )
				this.Setear_Puntodeventadestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Puntodeventadestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Puntodeventadestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Puntodeventadestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerodestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerodestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerodestino( lxVal )
				this.EventoAntesDeSetear( This, 'Numerodestino', lxValOld, lxVal  )
				this.Setear_Numerodestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerodestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerodestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numerodestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobantedestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobantedestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobantedestino( lxVal )
				this.EventoAntesDeSetear( This, 'Comprobantedestino', lxValOld, lxVal  )
				this.Setear_Comprobantedestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobantedestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comprobantedestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comprobantedestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedestino( lxVal )
				this.EventoAntesDeSetear( This, 'Clientedestino', lxValOld, lxVal  )
				this.Setear_Clientedestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Clientedestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Clientedestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechadestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechadestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechadestino( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.EventoAntesDeSetear( This, 'Fechadestino', lxValOld, lxVal  )
				this.Setear_Fechadestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechadestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechadestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechadestino( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Monto', lxValOld, lxVal  )
				this.Setear_Monto( lxVal )
				this.EventoDespuesDeSetear( This, 'Monto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Monto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriedestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriedestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriedestino( lxVal )
				this.EventoAntesDeSetear( This, 'Seriedestino', lxValOld, lxVal  )
				this.Setear_Seriedestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Seriedestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Seriedestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Seriedestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuariodestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuariodestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuariodestino( lxVal )
				this.EventoAntesDeSetear( This, 'Usuariodestino', lxValOld, lxVal  )
				this.Setear_Usuariodestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Usuariodestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Usuariodestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Usuariodestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Bddestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bddestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Bddestino( lxVal )
				this.EventoAntesDeSetear( This, 'Bddestino', lxValOld, lxVal  )
				this.Setear_Bddestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Bddestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Bddestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Bddestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Signodemovimientodestino_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Signodemovimientodestino
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Signodemovimientodestino( lxVal )
				this.EventoAntesDeSetear( This, 'Signodemovimientodestino', lxValOld, lxVal  )
				this.Setear_Signodemovimientodestino( lxVal )
				this.EventoDespuesDeSetear( This, 'Signodemovimientodestino', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Signodemovimientodestino', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Signodemovimientodestino( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigocomprobantedestino( txVal as variant ) as void

		this.Codigocomprobantedestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodecomprobantedestino( txVal as variant ) as void

		this.Tipodecomprobantedestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letradestino( txVal as variant ) as void

		this.Letradestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventadestino( txVal as variant ) as void

		this.Puntodeventadestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerodestino( txVal as variant ) as void

		this.Numerodestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobantedestino( txVal as variant ) as void

		this.Comprobantedestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedestino( txVal as variant ) as void

		this.Clientedestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechadestino( txVal as variant ) as void

		this.Fechadestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriedestino( txVal as variant ) as void

		this.Seriedestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariodestino( txVal as variant ) as void

		this.Usuariodestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bddestino( txVal as variant ) as void

		this.Bddestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Signodemovimientodestino( txVal as variant ) as void

		this.Signodemovimientodestino = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigocomprobantedestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodecomprobantedestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letradestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventadestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerodestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobantedestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechadestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriedestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariodestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bddestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Signodemovimientodestino( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
				.Codigocomprobantedestino = []
				.Tipodecomprobantedestino = 0
				.Letradestino = []
				.Puntodeventadestino = 0
				.Numerodestino = 0
				.Comprobantedestino = []
				.Clientedestino = []
				.Fechadestino = ctod( '  /  /    ' )
				.Monto = 0
				.Seriedestino = []
				.Usuariodestino = []
				.Bddestino = []
				.Signodemovimientodestino = 0
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

		if  empty( this.Codigo ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMVALEDECAMBIO]
	endfunc

enddefine