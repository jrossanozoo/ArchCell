
define class Din_ComponenteRETENCIONESIIBB as RetencionesBase of RetencionesBase.prg
	oCOMPROBANTEDERETENCIONES = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCOMPROBANTEDERETENCIONES_Access()
		if !this.ldestroy and !vartype( this.oCOMPROBANTEDERETENCIONES ) = 'O'
			this.oCOMPROBANTEDERETENCIONES= _screen.zoo.InstanciarEntidad( 'COMPROBANTEDERETENCIONES' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONES.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONES.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOMPROBANTEDERETENCIONES
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCOMPROBANTEDERETENCIONES' ) = 'O' and !isnull( This.oCOMPROBANTEDERETENCIONES )
			this.oCOMPROBANTEDERETENCIONES.Release()
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