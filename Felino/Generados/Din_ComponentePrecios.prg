
define class Din_ComponentePRECIOS as Componente of Componente.prg
	oPRECIODEARTICULO = NULL
	oEntidad = NULL
	
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
			.oCombinacion = _screen.zoo.crearobjeto( 'zooColeccion' )
			.oCombinacion.Add( 'Articulo_Pk' )
			.oCombinacion.Add( 'Color_Pk' )
			.oCombinacion.Add( 'ListaDePrecio_Pk' )
			.oCombinacion.Add( 'Talle' )
			.oCombinacion.Add( 'TimestampAlta' )
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oEntidad_Access()
		if !this.ldestroy and !vartype( this.oEntidad ) = 'O'
			this.oEntidad= _screen.zoo.InstanciarEntidad( 'preciodearticulo' )
			this.enlazar( 'oEntidad.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oEntidad.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oEntidad
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oPRECIODEARTICULO_Access()
		if !this.ldestroy and !vartype( this.oPRECIODEARTICULO ) = 'O'
			this.oPRECIODEARTICULO= _screen.zoo.InstanciarEntidad( 'PRECIODEARTICULO' )
			this.enlazar( 'oPRECIODEARTICULO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oPRECIODEARTICULO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oPRECIODEARTICULO
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oPRECIODEARTICULO' ) = 'O' and !isnull( This.oPRECIODEARTICULO )
			this.oPRECIODEARTICULO.Release()
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