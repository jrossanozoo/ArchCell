
define class Din_ComponenteCUENTACORRIENTEVALORES as Componente of Componente.prg
	oCTACTE = NULL
	oCompCUENTACORRIENTEVALORESVENTAS = NULL
	oCompCUENTACORRIENTEVALORESCOMPRAS = NULL
	oEntidad = NULL
	
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
			.oCombinacion = _screen.zoo.crearobjeto( 'zooColeccion' )
			.oCombinacion.Add( 'Cliente_Pk' )
			.oCombinacion.Add( 'Letra' )
			.oCombinacion.Add( 'PuntoDeVenta' )
			.oCombinacion.Add( 'Numero' )
			.oCombinacion.Add( 'FechaVencimiento' )
			.oCombinacion.Add( 'TipoDeComprobante' )
			.oCombinacion.Add( 'Valor_Pk' )
			.oCombinacion.Add( 'Secuencia' )
			.oCombinacion.Add( 'BaseDeDatosAltaFW' )
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oEntidad_Access()
		if !this.ldestroy and !vartype( this.oEntidad ) = 'O'
			this.oEntidad= _screen.zoo.InstanciarEntidad( 'CtaCte' )
			this.enlazar( 'oEntidad.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oEntidad.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oEntidad
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCTACTE_Access()
		if !this.ldestroy and !vartype( this.oCTACTE ) = 'O'
			this.oCTACTE= _screen.zoo.InstanciarEntidad( 'CTACTE' )
			this.enlazar( 'oCTACTE.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCTACTE.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCTACTE
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompCUENTACORRIENTEVALORESVENTAS_Access()
		if !this.ldestroy and !vartype( this.oCompCUENTACORRIENTEVALORESVENTAS ) = 'O'
			this.oCompCUENTACORRIENTEVALORESVENTAS = _screen.zoo.InstanciarComponente( 'ComponenteCUENTACORRIENTEVALORESVENTAS' )
			this.enlazar( 'oCompCUENTACORRIENTEVALORESVENTAS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompCUENTACORRIENTEVALORESVENTAS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompCUENTACORRIENTEVALORESVENTAS
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompCUENTACORRIENTEVALORESCOMPRAS_Access()
		if !this.ldestroy and !vartype( this.oCompCUENTACORRIENTEVALORESCOMPRAS ) = 'O'
			this.oCompCUENTACORRIENTEVALORESCOMPRAS = _screen.zoo.InstanciarComponente( 'ComponenteCUENTACORRIENTEVALORESCOMPRAS' )
			this.enlazar( 'oCompCUENTACORRIENTEVALORESCOMPRAS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompCUENTACORRIENTEVALORESCOMPRAS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompCUENTACORRIENTEVALORESCOMPRAS
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCTACTE' ) = 'O' and !isnull( This.oCTACTE )
			this.oCTACTE.Release()
		endif
		if type( 'This.oCompCUENTACORRIENTEVALORESVENTAS' ) = 'O' and !isnull( This.oCompCUENTACORRIENTEVALORESVENTAS )
			this.oCompCUENTACORRIENTEVALORESVENTAS.Release()
		endif
		if type( 'This.oCompCUENTACORRIENTEVALORESCOMPRAS' ) = 'O' and !isnull( This.oCompCUENTACORRIENTEVALORESCOMPRAS )
			this.oCompCUENTACORRIENTEVALORESCOMPRAS.Release()
		endif

		dodefault()
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Grabar() as ZooColeccion of ZooColeccion.prg

		Local loColeccion as ZooColeccion of ZooColeccion.Prg
		loColeccion = dodefault()
		This.AgregarColeccionAColeccion( loColeccion , This.oCompCUENTACORRIENTEVALORESCOMPRAS.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompCUENTACORRIENTEVALORESVENTAS.Grabar() )
		Return loColeccion
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompCUENTACORRIENTEVALORESVENTAS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompCUENTACORRIENTEVALORESCOMPRAS.SetearColeccionSentenciasAnterior_MODIFICAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompCUENTACORRIENTEVALORESVENTAS.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompCUENTACORRIENTEVALORESCOMPRAS.SetearColeccionSentenciasAnterior_ANULAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompCUENTACORRIENTEVALORESVENTAS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompCUENTACORRIENTEVALORESCOMPRAS.SetearColeccionSentenciasAnterior_ELIMINAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recibir( toEntidad as object, tcAtributoDetalle as string, tcCursorDetalle as string, tcCursorCabecera as string ) as void
		dodefault( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompCUENTACORRIENTEVALORESCOMPRAS.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompCUENTACORRIENTEVALORESVENTAS.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
	endfunc


enddefine