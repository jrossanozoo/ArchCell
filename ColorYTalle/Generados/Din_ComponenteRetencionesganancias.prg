
define class Din_ComponenteRETENCIONESGANANCIAS as RetencionesBase of RetencionesBase.prg
	oCOMPROBANTEDERETENCIONESGANANCIAS = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCOMPROBANTEDERETENCIONESGANANCIAS_Access()
		if !this.ldestroy and !vartype( this.oCOMPROBANTEDERETENCIONESGANANCIAS ) = 'O'
			this.oCOMPROBANTEDERETENCIONESGANANCIAS= _screen.zoo.InstanciarEntidad( 'COMPROBANTEDERETENCIONESGANANCIAS' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONESGANANCIAS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOMPROBANTEDERETENCIONESGANANCIAS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOMPROBANTEDERETENCIONESGANANCIAS
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCOMPROBANTEDERETENCIONESGANANCIAS' ) = 'O' and !isnull( This.oCOMPROBANTEDERETENCIONESGANANCIAS )
			this.oCOMPROBANTEDERETENCIONESGANANCIAS.Release()
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