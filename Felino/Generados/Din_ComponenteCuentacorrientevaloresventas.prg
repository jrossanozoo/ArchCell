
define class Din_ComponenteCUENTACORRIENTEVALORESVENTAS as CuentaCorrienteVentasBase of CuentaCorrienteVentasBase.prg
	oCTACTE = NULL
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
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCTACTE' ) = 'O' and !isnull( This.oCTACTE )
			this.oCTACTE.Release()
		endif

		dodefault()
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Grabar() as ZooColeccion of ZooColeccion.prg

		Local loColeccion as ZooColeccion of ZooColeccion.Prg
		loColeccion = dodefault()
		Return loColeccion
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recibir( toEntidad as object, tcAtributoDetalle as string, tcCursorDetalle as string, tcCursorCabecera as string ) as void
		dodefault( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
	endfunc


enddefine