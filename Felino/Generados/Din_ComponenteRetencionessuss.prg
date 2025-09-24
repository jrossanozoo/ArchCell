
define class Din_ComponenteRETENCIONESSUSS as RetencionesBase of RetencionesBase.prg
	oCOMPROBANTEDERETENCIONESSUSS = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCOMPROBANTEDERETENCIONESSUSS_Access()
		if !this.ldestroy and !vartype( this.oCOMPROBANTEDERETENCIONESSUSS ) = 'O'
			this.oCOMPROBANTEDERETENCIONESSUSS= _screen.zoo.InstanciarEntidad( 'COMPROBANTEDERETENCIONESSUSS' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONESSUSS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONESSUSS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOMPROBANTEDERETENCIONESSUSS
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCOMPROBANTEDERETENCIONESSUSS' ) = 'O' and !isnull( This.oCOMPROBANTEDERETENCIONESSUSS )
			this.oCOMPROBANTEDERETENCIONESSUSS.Release()
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