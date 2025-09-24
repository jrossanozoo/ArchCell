
define class Din_ComponenteAJUSTESDECAJA as Componente of Componente.prg
	oCAJASALDOS = NULL
	oMOVIMIENTODECAJA = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCAJASALDOS_Access()
		if !this.ldestroy and !vartype( this.oCAJASALDOS ) = 'O'
			this.oCAJASALDOS= _screen.zoo.InstanciarEntidad( 'CAJASALDOS' )
			this.enlazar( 'oCAJASALDOS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCAJASALDOS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCAJASALDOS
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oMOVIMIENTODECAJA_Access()
		if !this.ldestroy and !vartype( this.oMOVIMIENTODECAJA ) = 'O'
			this.oMOVIMIENTODECAJA= _screen.zoo.InstanciarEntidad( 'MOVIMIENTODECAJA' )
			this.enlazar( 'oMOVIMIENTODECAJA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oMOVIMIENTODECAJA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oMOVIMIENTODECAJA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCAJASALDOS' ) = 'O' and !isnull( This.oCAJASALDOS )
			this.oCAJASALDOS.Release()
		endif
		if type( 'This.oMOVIMIENTODECAJA' ) = 'O' and !isnull( This.oMOVIMIENTODECAJA )
			this.oMOVIMIENTODECAJA.Release()
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