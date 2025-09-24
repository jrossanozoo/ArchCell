
define class Din_ComponenteRETENCIONESIVA as RetencionesBase of RetencionesBase.prg
	oCOMPROBANTEDERETENCIONESIVA = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCOMPROBANTEDERETENCIONESIVA_Access()
		if !this.ldestroy and !vartype( this.oCOMPROBANTEDERETENCIONESIVA ) = 'O'
			this.oCOMPROBANTEDERETENCIONESIVA= _screen.zoo.InstanciarEntidad( 'COMPROBANTEDERETENCIONESIVA' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONESIVA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONESIVA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOMPROBANTEDERETENCIONESIVA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCOMPROBANTEDERETENCIONESIVA' ) = 'O' and !isnull( This.oCOMPROBANTEDERETENCIONESIVA )
			this.oCOMPROBANTEDERETENCIONESIVA.Release()
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