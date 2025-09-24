
define class Din_ComponenteVALESDECAMBIO as ComponenteValores of ComponenteValores.prg
	oVALEDECAMBIO = NULL
	oEntidad = NULL
	
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oEntidad_Access()
		if !this.ldestroy and !vartype( this.oEntidad ) = 'O'
			this.oEntidad= _screen.zoo.InstanciarEntidad( 'ValeDeCambio' )
			this.enlazar( 'oEntidad.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oEntidad.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oEntidad
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oVALEDECAMBIO_Access()
		if !this.ldestroy and !vartype( this.oVALEDECAMBIO ) = 'O'
			this.oVALEDECAMBIO= _screen.zoo.InstanciarEntidad( 'VALEDECAMBIO' )
			this.enlazar( 'oVALEDECAMBIO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oVALEDECAMBIO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oVALEDECAMBIO
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oVALEDECAMBIO' ) = 'O' and !isnull( This.oVALEDECAMBIO )
			this.oVALEDECAMBIO.Release()
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