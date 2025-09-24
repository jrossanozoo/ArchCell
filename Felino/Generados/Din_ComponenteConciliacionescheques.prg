
define class Din_ComponenteCONCILIACIONESCHEQUES as Componente of Componente.prg
	oCONCILIACIONES = NULL
	oHERRAMIENTACONCILIACION = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCONCILIACIONES_Access()
		if !this.ldestroy and !vartype( this.oCONCILIACIONES ) = 'O'
			this.oCONCILIACIONES= _screen.zoo.InstanciarEntidad( 'CONCILIACIONES' )
			this.enlazar( 'oCONCILIACIONES.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCONCILIACIONES.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCONCILIACIONES
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oHERRAMIENTACONCILIACION_Access()
		if !this.ldestroy and !vartype( this.oHERRAMIENTACONCILIACION ) = 'O'
			this.oHERRAMIENTACONCILIACION= _screen.zoo.InstanciarEntidad( 'HERRAMIENTACONCILIACION' )
			this.enlazar( 'oHERRAMIENTACONCILIACION.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oHERRAMIENTACONCILIACION.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oHERRAMIENTACONCILIACION
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCONCILIACIONES' ) = 'O' and !isnull( This.oCONCILIACIONES )
			this.oCONCILIACIONES.Release()
		endif
		if type( 'This.oHERRAMIENTACONCILIACION' ) = 'O' and !isnull( This.oHERRAMIENTACONCILIACION )
			this.oHERRAMIENTACONCILIACION.Release()
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