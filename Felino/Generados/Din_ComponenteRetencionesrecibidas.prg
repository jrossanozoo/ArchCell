
define class Din_ComponenteRETENCIONESRECIBIDAS as Componente of Componente.prg
	oCOMPROBANTEDERETENCIONRECIBIDO = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCOMPROBANTEDERETENCIONRECIBIDO_Access()
		if !this.ldestroy and !vartype( this.oCOMPROBANTEDERETENCIONRECIBIDO ) = 'O'
			this.oCOMPROBANTEDERETENCIONRECIBIDO= _screen.zoo.InstanciarEntidad( 'COMPROBANTEDERETENCIONRECIBIDO' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONRECIBIDO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONRECIBIDO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOMPROBANTEDERETENCIONRECIBIDO
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCOMPROBANTEDERETENCIONRECIBIDO' ) = 'O' and !isnull( This.oCOMPROBANTEDERETENCIONRECIBIDO )
			this.oCOMPROBANTEDERETENCIONRECIBIDO.Release()
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