
define class Din_ItemHERRAMIENTACONCILIACIONDetalleregistros as ItemActivo of ItemActivo.prg

	cNombre = 'HERRAMIENTACONCILIACION'
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Registro_PK = []
	Registro = null
	lHabilitarRegistro_PK = .T.
	Fecha = ctod( '  /  /    ' )
	lHabilitarFecha = .T.
	FechaDeOperacion = ctod( '  /  /    ' )
	lHabilitarFechaDeOperacion = .T.
	TipoValor = 0
	lHabilitarTipoValor = .T.
	Comprobante = []
	lHabilitarComprobante = .T.
	Importe = 0
	lHabilitarImporte = .T.
	Seleccion = .F.
	lHabilitarSeleccion = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarNROITEM = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarRegistro_PK = .T.
		this.lHabilitarFecha = .T.
		this.lHabilitarFechaDeOperacion = .T.
		this.lHabilitarTipoValor = .T.
		this.lHabilitarComprobante = .T.
		this.lHabilitarImporte = .T.
		this.lHabilitarSeleccion = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'HERRAMIENTACONCILIACION', 'Detalleregistros')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Registro_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Registro_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Registro.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Registro )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Registro_PK = lxVal

		if this.Validar_Registro( lxVal, lxValOld )
			if ( this.lHabilitarRegistro_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Registro_Pk', lxValOld, lxVal  )
				This.Setear_Registro( lxVal )
				this.EventoDespuesDeSetear( This, 'Registro_Pk', lxValOld, lxVal  )
				If This.PuedeEjecutarCambioSumarizado()
					this.CambioSumarizado()
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Registro_Pk', This )
					Endif
				EndIf
			else
				this.Registro_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Registro)" )
			endif 
		endif
		If lxValOld != lxVal or empty( this.Fecha ) 
			this.Fecha = This.Registro.Fecha
		endif
		If lxValOld != lxVal or empty( this.Fechadeoperacion ) 
			this.Fechadeoperacion = This.Registro.FechaCargaOperacion
		endif
		If lxValOld != lxVal or empty( this.Tipovalor ) 
			this.Tipovalor = This.Registro.TipoValor
		endif
		If lxValOld != lxVal or empty( this.Comprobante ) 
			this.Comprobante = This.Registro.Comprobante
		endif
		If lxValOld != lxVal or empty( this.Importe ) 
			this.Importe = This.Registro.Importe
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Registro( txVal as variant ) as void

		this.Registro.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Registro( txVal as variant, txValOld as variant ) as Boolean

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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Fecha)" )
				endif 
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechadeoperacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechadeoperacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechadeoperacion( lxVal )
				if ( this.lHabilitarFechadeoperacion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Fecha( lxVal )
					this.EventoAntesDeSetear( This, 'Fechadeoperacion', lxValOld, lxVal  )
					this.Setear_Fechadeoperacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechadeoperacion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Fechadeoperacion', This )
						Endif
					EndIf
				else
					this.Fechadeoperacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Fechadeoperacion)" )
				endif 
			EndIf
		Else
			This.Setear_Fechadeoperacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipovalor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipovalor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipovalor( lxVal )
				if ( this.lHabilitarTipovalor or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Tipovalor', lxValOld, lxVal  )
					this.Setear_Tipovalor( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipovalor', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tipovalor', This )
						Endif
					EndIf
				else
					this.Tipovalor = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Tipovalor)" )
				endif 
			EndIf
		Else
			This.Setear_Tipovalor( lxVal ) 
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
				if ( this.lHabilitarComprobante or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Comprobante', lxValOld, lxVal  )
					this.Setear_Comprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Comprobante', This )
						Endif
					EndIf
				else
					this.Comprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Comprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Comprobante( lxVal ) 
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
				if ( this.lHabilitarImporte or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Importe = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Importe)" )
				endif 
			EndIf
		Else
			This.Setear_Importe( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seleccion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seleccion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seleccion( lxVal )
				if ( this.lHabilitarSeleccion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Seleccion', lxValOld, lxVal  )
					this.Setear_Seleccion( lxVal )
				this.EventoDespuesDeSetear( This, 'Seleccion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Seleccion', This )
						Endif
					EndIf
				else
					this.Seleccion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de conciliación bancaria - Atributo: Seleccion)" )
				endif 
			EndIf
		Else
			This.Setear_Seleccion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechadeoperacion( txVal as variant ) as void

		this.Fechadeoperacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipovalor( txVal as variant ) as void

		this.Tipovalor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobante( txVal as variant ) as void

		this.Comprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Importe( txVal as variant ) as void

		this.Importe = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seleccion( txVal as variant ) as void

		this.Seleccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechadeoperacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipovalor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Importe( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seleccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Registro_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Registro ) = 'O' or isnull( this.Registro ) )
					this.Registro = _Screen.zoo.instanciarentidad( 'Registrodecuenta' )
					this.Registro.lEsSubEntidad = .t.
					this.enlazar( 'Registro.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Registro.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Registro.CODIGO # this.Registro_PK
						this.Registro.CODIGO = this.Registro_PK
					endif
				endif
			endif
		endif
		return this.Registro
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
	Function ValorSugeridoSeleccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "HERRAMIENTACONCILIACION", "Detalleregistros", "Seleccion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Seleccion' )
						.Seleccion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Seleccionada para el detalle Registros conciliables." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
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
			.Registro_PK = []
			.Fecha = ctod( '  /  /    ' )
			.Fechadeoperacion = ctod( '  /  /    ' )
			.Tipovalor = 0
			.Comprobante = []
			.Importe = 0
			.Seleccion = .F.
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

		if  empty( this.Registro_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarRegistro_PK = tlHabilitar
		this.lHabilitarFecha = tlHabilitar
		this.lHabilitarFechaDeOperacion = tlHabilitar
		this.lHabilitarTipoValor = tlHabilitar
		this.lHabilitarComprobante = tlHabilitar
		this.lHabilitarImporte = tlHabilitar
		this.lHabilitarSeleccion = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMREGCONCILIABLESTOOL]
	endfunc

enddefine