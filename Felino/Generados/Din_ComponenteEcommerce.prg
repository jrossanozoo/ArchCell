
define class Din_ComponenteECOMMERCE as Componente of Componente.prg
	oOPERACIONECOMMERCE = NULL
	oREMITO = NULL
	oPEDIDO = NULL
	oFACTURA = NULL
	oFACTURAELECTRONICA = NULL
	oTICKETFACTURA = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oOPERACIONECOMMERCE_Access()
		if !this.ldestroy and !vartype( this.oOPERACIONECOMMERCE ) = 'O'
			this.oOPERACIONECOMMERCE= _screen.zoo.InstanciarEntidad( 'OPERACIONECOMMERCE' )
			this.enlazar( 'oOPERACIONECOMMERCE.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oOPERACIONECOMMERCE.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oOPERACIONECOMMERCE
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oREMITO_Access()
		if !this.ldestroy and !vartype( this.oREMITO ) = 'O'
			this.oREMITO= _screen.zoo.InstanciarEntidad( 'REMITO' )
			this.enlazar( 'oREMITO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oREMITO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oREMITO
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oPEDIDO_Access()
		if !this.ldestroy and !vartype( this.oPEDIDO ) = 'O'
			this.oPEDIDO= _screen.zoo.InstanciarEntidad( 'PEDIDO' )
			this.enlazar( 'oPEDIDO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oPEDIDO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oPEDIDO
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oFACTURA_Access()
		if !this.ldestroy and !vartype( this.oFACTURA ) = 'O'
			this.oFACTURA= _screen.zoo.InstanciarEntidad( 'FACTURA' )
			this.enlazar( 'oFACTURA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oFACTURA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oFACTURA
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oFACTURAELECTRONICA_Access()
		if !this.ldestroy and !vartype( this.oFACTURAELECTRONICA ) = 'O'
			this.oFACTURAELECTRONICA= _screen.zoo.InstanciarEntidad( 'FACTURAELECTRONICA' )
			this.enlazar( 'oFACTURAELECTRONICA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oFACTURAELECTRONICA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oFACTURAELECTRONICA
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oTICKETFACTURA_Access()
		if !this.ldestroy and !vartype( this.oTICKETFACTURA ) = 'O'
			this.oTICKETFACTURA= _screen.zoo.InstanciarEntidad( 'TICKETFACTURA' )
			this.enlazar( 'oTICKETFACTURA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oTICKETFACTURA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oTICKETFACTURA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oOPERACIONECOMMERCE' ) = 'O' and !isnull( This.oOPERACIONECOMMERCE )
			this.oOPERACIONECOMMERCE.Release()
		endif
		if type( 'This.oREMITO' ) = 'O' and !isnull( This.oREMITO )
			this.oREMITO.Release()
		endif
		if type( 'This.oPEDIDO' ) = 'O' and !isnull( This.oPEDIDO )
			this.oPEDIDO.Release()
		endif
		if type( 'This.oFACTURA' ) = 'O' and !isnull( This.oFACTURA )
			this.oFACTURA.Release()
		endif
		if type( 'This.oFACTURAELECTRONICA' ) = 'O' and !isnull( This.oFACTURAELECTRONICA )
			this.oFACTURAELECTRONICA.Release()
		endif
		if type( 'This.oTICKETFACTURA' ) = 'O' and !isnull( This.oTICKETFACTURA )
			this.oTICKETFACTURA.Release()
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