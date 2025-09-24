
define class Din_ComponenteCOSTOMERCADERIAVENDIDA as Componente of Componente.prg
	oAPERTURAEJERCICIO = NULL
	oCIERREEJERCICIO = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oAPERTURAEJERCICIO_Access()
		if !this.ldestroy and !vartype( this.oAPERTURAEJERCICIO ) = 'O'
			this.oAPERTURAEJERCICIO= _screen.zoo.InstanciarEntidad( 'APERTURAEJERCICIO' )
			this.enlazar( 'oAPERTURAEJERCICIO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oAPERTURAEJERCICIO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oAPERTURAEJERCICIO
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCIERREEJERCICIO_Access()
		if !this.ldestroy and !vartype( this.oCIERREEJERCICIO ) = 'O'
			this.oCIERREEJERCICIO= _screen.zoo.InstanciarEntidad( 'CIERREEJERCICIO' )
			this.enlazar( 'oCIERREEJERCICIO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCIERREEJERCICIO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCIERREEJERCICIO
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oAPERTURAEJERCICIO' ) = 'O' and !isnull( This.oAPERTURAEJERCICIO )
			this.oAPERTURAEJERCICIO.Release()
		endif
		if type( 'This.oCIERREEJERCICIO' ) = 'O' and !isnull( This.oCIERREEJERCICIO )
			this.oCIERREEJERCICIO.Release()
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