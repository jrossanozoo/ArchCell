
define class Din_ComponenteRETENCIONES as Componente of Componente.prg
	oCompRETENCIONESIIBB = NULL
	oCompRETENCIONESIVA = NULL
	oCompRETENCIONESGANANCIAS = NULL
	oCompRETENCIONESSUSS = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCompRETENCIONESIIBB_Access()
		if !this.ldestroy and !vartype( this.oCompRETENCIONESIIBB ) = 'O'
			this.oCompRETENCIONESIIBB = _screen.zoo.InstanciarComponente( 'ComponenteRETENCIONESIIBB' )
			this.enlazar( 'oCompRETENCIONESIIBB.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompRETENCIONESIIBB.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompRETENCIONESIIBB
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompRETENCIONESIVA_Access()
		if !this.ldestroy and !vartype( this.oCompRETENCIONESIVA ) = 'O'
			this.oCompRETENCIONESIVA = _screen.zoo.InstanciarComponente( 'ComponenteRETENCIONESIVA' )
			this.enlazar( 'oCompRETENCIONESIVA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompRETENCIONESIVA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompRETENCIONESIVA
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompRETENCIONESGANANCIAS_Access()
		if !this.ldestroy and !vartype( this.oCompRETENCIONESGANANCIAS ) = 'O'
			this.oCompRETENCIONESGANANCIAS = _screen.zoo.InstanciarComponente( 'ComponenteRETENCIONESGANANCIAS' )
			this.enlazar( 'oCompRETENCIONESGANANCIAS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompRETENCIONESGANANCIAS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompRETENCIONESGANANCIAS
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompRETENCIONESSUSS_Access()
		if !this.ldestroy and !vartype( this.oCompRETENCIONESSUSS ) = 'O'
			this.oCompRETENCIONESSUSS = _screen.zoo.InstanciarComponente( 'ComponenteRETENCIONESSUSS' )
			this.enlazar( 'oCompRETENCIONESSUSS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompRETENCIONESSUSS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompRETENCIONESSUSS
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCompRETENCIONESIIBB' ) = 'O' and !isnull( This.oCompRETENCIONESIIBB )
			this.oCompRETENCIONESIIBB.Release()
		endif
		if type( 'This.oCompRETENCIONESIVA' ) = 'O' and !isnull( This.oCompRETENCIONESIVA )
			this.oCompRETENCIONESIVA.Release()
		endif
		if type( 'This.oCompRETENCIONESGANANCIAS' ) = 'O' and !isnull( This.oCompRETENCIONESGANANCIAS )
			this.oCompRETENCIONESGANANCIAS.Release()
		endif
		if type( 'This.oCompRETENCIONESSUSS' ) = 'O' and !isnull( This.oCompRETENCIONESSUSS )
			this.oCompRETENCIONESSUSS.Release()
		endif

		dodefault()
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Grabar() as ZooColeccion of ZooColeccion.prg

		Local loColeccion as ZooColeccion of ZooColeccion.Prg
		loColeccion = dodefault()
		This.AgregarColeccionAColeccion( loColeccion , This.oCompRETENCIONESGANANCIAS.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompRETENCIONESIIBB.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompRETENCIONESIVA.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompRETENCIONESSUSS.Grabar() )
		Return loColeccion
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompRETENCIONESIIBB.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompRETENCIONESIVA.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompRETENCIONESGANANCIAS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompRETENCIONESSUSS.SetearColeccionSentenciasAnterior_MODIFICAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompRETENCIONESIIBB.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompRETENCIONESIVA.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompRETENCIONESGANANCIAS.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompRETENCIONESSUSS.SetearColeccionSentenciasAnterior_ANULAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompRETENCIONESIIBB.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompRETENCIONESIVA.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompRETENCIONESGANANCIAS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompRETENCIONESSUSS.SetearColeccionSentenciasAnterior_ELIMINAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recibir( toEntidad as object, tcAtributoDetalle as string, tcCursorDetalle as string, tcCursorCabecera as string ) as void
		dodefault( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompRETENCIONESGANANCIAS.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompRETENCIONESIIBB.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompRETENCIONESIVA.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompRETENCIONESSUSS.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
	endfunc


enddefine