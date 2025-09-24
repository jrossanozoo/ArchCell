
define class Din_ComponenteCUENTACORRIENTEPAGOCOMPRAS as CuentaCorrienteComprasBase of CuentaCorrienteComprasBase.prg
	oCTACTECOMPRA = NULL
	oEntidad = NULL
	
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
			.oCombinacion = _screen.zoo.crearobjeto( 'zooColeccion' )
			.oCombinacion.Add( 'Proveedor_Pk' )
			.oCombinacion.Add( 'Letra' )
			.oCombinacion.Add( 'PuntoDeVenta' )
			.oCombinacion.Add( 'Numero' )
			.oCombinacion.Add( 'FechaVencimiento' )
			.oCombinacion.Add( 'TipoDeComprobante' )
			.oCombinacion.Add( 'Valor_Pk' )
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oEntidad_Access()
		if !this.ldestroy and !vartype( this.oEntidad ) = 'O'
			this.oEntidad= _screen.zoo.InstanciarEntidad( 'CtaCteCompra' )
			this.enlazar( 'oEntidad.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oEntidad.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oEntidad
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCTACTECOMPRA_Access()
		if !this.ldestroy and !vartype( this.oCTACTECOMPRA ) = 'O'
			this.oCTACTECOMPRA= _screen.zoo.InstanciarEntidad( 'CTACTECOMPRA' )
			this.enlazar( 'oCTACTECOMPRA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCTACTECOMPRA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCTACTECOMPRA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCTACTECOMPRA' ) = 'O' and !isnull( This.oCTACTECOMPRA )
			this.oCTACTECOMPRA.Release()
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