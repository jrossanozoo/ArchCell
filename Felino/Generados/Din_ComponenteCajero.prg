
define class Din_ComponenteCAJERO as Componente of Componente.prg
	oCAJASALDOS = NULL
	oMOVIMIENTODECAJA = NULL
	oCompCUENTACORRIENTEVALORES = NULL
	oCompVALORES = NULL
	oCompVALESDECAMBIO = NULL
	oCompCHEQUESDETERCEROS = NULL
	oCompTARJETADECREDITO = NULL
	oCompCHEQUESPROPIOS = NULL
	oCompAJUSTEDECUPONES = NULL
	oCompCUENTABANCARIAVALORES = NULL
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
	Function oCompCUENTACORRIENTEVALORES_Access()
		if !this.ldestroy and !vartype( this.oCompCUENTACORRIENTEVALORES ) = 'O'
			this.oCompCUENTACORRIENTEVALORES = _screen.zoo.InstanciarComponente( 'ComponenteCUENTACORRIENTEVALORES' )
			this.enlazar( 'oCompCUENTACORRIENTEVALORES.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompCUENTACORRIENTEVALORES.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompCUENTACORRIENTEVALORES
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompVALORES_Access()
		if !this.ldestroy and !vartype( this.oCompVALORES ) = 'O'
			this.oCompVALORES = _screen.zoo.InstanciarComponente( 'ComponenteVALORES' )
			this.enlazar( 'oCompVALORES.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompVALORES.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompVALORES
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompVALESDECAMBIO_Access()
		if !this.ldestroy and !vartype( this.oCompVALESDECAMBIO ) = 'O'
			this.oCompVALESDECAMBIO = _screen.zoo.InstanciarComponente( 'ComponenteVALESDECAMBIO' )
			this.enlazar( 'oCompVALESDECAMBIO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompVALESDECAMBIO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompVALESDECAMBIO
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompCHEQUESDETERCEROS_Access()
		if !this.ldestroy and !vartype( this.oCompCHEQUESDETERCEROS ) = 'O'
			this.oCompCHEQUESDETERCEROS = _screen.zoo.InstanciarComponente( 'ComponenteCHEQUESDETERCEROS' )
			this.enlazar( 'oCompCHEQUESDETERCEROS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompCHEQUESDETERCEROS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompCHEQUESDETERCEROS
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompTARJETADECREDITO_Access()
		if !this.ldestroy and !vartype( this.oCompTARJETADECREDITO ) = 'O'
			this.oCompTARJETADECREDITO = _screen.zoo.InstanciarComponente( 'ComponenteTARJETADECREDITO' )
			this.enlazar( 'oCompTARJETADECREDITO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompTARJETADECREDITO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompTARJETADECREDITO
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompCHEQUESPROPIOS_Access()
		if !this.ldestroy and !vartype( this.oCompCHEQUESPROPIOS ) = 'O'
			this.oCompCHEQUESPROPIOS = _screen.zoo.InstanciarComponente( 'ComponenteCHEQUESPROPIOS' )
			this.enlazar( 'oCompCHEQUESPROPIOS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompCHEQUESPROPIOS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompCHEQUESPROPIOS
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompAJUSTEDECUPONES_Access()
		if !this.ldestroy and !vartype( this.oCompAJUSTEDECUPONES ) = 'O'
			this.oCompAJUSTEDECUPONES = _screen.zoo.InstanciarComponente( 'ComponenteAJUSTEDECUPONES' )
			this.enlazar( 'oCompAJUSTEDECUPONES.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompAJUSTEDECUPONES.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompAJUSTEDECUPONES
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCompCUENTABANCARIAVALORES_Access()
		if !this.ldestroy and !vartype( this.oCompCUENTABANCARIAVALORES ) = 'O'
			this.oCompCUENTABANCARIAVALORES = _screen.zoo.InstanciarComponente( 'ComponenteCUENTABANCARIAVALORES' )
			this.enlazar( 'oCompCUENTABANCARIAVALORES.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCompCUENTABANCARIAVALORES.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCompCUENTABANCARIAVALORES
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
		if type( 'This.oCompCUENTACORRIENTEVALORES' ) = 'O' and !isnull( This.oCompCUENTACORRIENTEVALORES )
			this.oCompCUENTACORRIENTEVALORES.Release()
		endif
		if type( 'This.oCompVALORES' ) = 'O' and !isnull( This.oCompVALORES )
			this.oCompVALORES.Release()
		endif
		if type( 'This.oCompVALESDECAMBIO' ) = 'O' and !isnull( This.oCompVALESDECAMBIO )
			this.oCompVALESDECAMBIO.Release()
		endif
		if type( 'This.oCompCHEQUESDETERCEROS' ) = 'O' and !isnull( This.oCompCHEQUESDETERCEROS )
			this.oCompCHEQUESDETERCEROS.Release()
		endif
		if type( 'This.oCompTARJETADECREDITO' ) = 'O' and !isnull( This.oCompTARJETADECREDITO )
			this.oCompTARJETADECREDITO.Release()
		endif
		if type( 'This.oCompCHEQUESPROPIOS' ) = 'O' and !isnull( This.oCompCHEQUESPROPIOS )
			this.oCompCHEQUESPROPIOS.Release()
		endif
		if type( 'This.oCompAJUSTEDECUPONES' ) = 'O' and !isnull( This.oCompAJUSTEDECUPONES )
			this.oCompAJUSTEDECUPONES.Release()
		endif
		if type( 'This.oCompCUENTABANCARIAVALORES' ) = 'O' and !isnull( This.oCompCUENTABANCARIAVALORES )
			this.oCompCUENTABANCARIAVALORES.Release()
		endif

		dodefault()
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Grabar() as ZooColeccion of ZooColeccion.prg

		Local loColeccion as ZooColeccion of ZooColeccion.Prg
		loColeccion = dodefault()
		This.AgregarColeccionAColeccion( loColeccion , This.oCompCHEQUESDETERCEROS.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompCHEQUESPROPIOS.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompCUENTABANCARIAVALORES.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompTARJETADECREDITO.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompVALESDECAMBIO.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompVALORES.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompCUENTACORRIENTEVALORES.Grabar() )
		This.AgregarColeccionAColeccion( loColeccion , This.oCompAJUSTEDECUPONES.Grabar() )
		Return loColeccion
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompCUENTACORRIENTEVALORES.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompVALORES.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompVALESDECAMBIO.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompCHEQUESDETERCEROS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompTARJETADECREDITO.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompCHEQUESPROPIOS.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompAJUSTEDECUPONES.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.oCompCUENTABANCARIAVALORES.SetearColeccionSentenciasAnterior_MODIFICAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompCUENTACORRIENTEVALORES.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompVALORES.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompVALESDECAMBIO.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompCHEQUESDETERCEROS.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompTARJETADECREDITO.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompCHEQUESPROPIOS.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompAJUSTEDECUPONES.SetearColeccionSentenciasAnterior_ANULAR()
		this.oCompCUENTABANCARIAVALORES.SetearColeccionSentenciasAnterior_ANULAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompCUENTACORRIENTEVALORES.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompVALORES.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompVALESDECAMBIO.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompCHEQUESDETERCEROS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompTARJETADECREDITO.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompCHEQUESPROPIOS.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompAJUSTEDECUPONES.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.oCompCUENTABANCARIAVALORES.SetearColeccionSentenciasAnterior_ELIMINAR()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recibir( toEntidad as object, tcAtributoDetalle as string, tcCursorDetalle as string, tcCursorCabecera as string ) as void
		dodefault( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompCHEQUESDETERCEROS.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompCHEQUESPROPIOS.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompCUENTABANCARIAVALORES.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompTARJETADECREDITO.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompVALESDECAMBIO.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompVALORES.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompCUENTACORRIENTEVALORES.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
		This.oCompAJUSTEDECUPONES.Recibir( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
	endfunc


enddefine