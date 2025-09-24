define class TaskBarWrapper as custom
	oTaskBar = null
	oEstados = null
	oDlls = null

	function init( tcRutaInicial as string, toEstados as collection, toDlls as object )
		local lcRuta as string

		this.oEstados = toEstados
		this.oDlls = toDlls

		lcRuta = addbs( tcRutaInicial ) + "..\taspein\foxunit"
		if this.ExistenDlls( lcRuta )
			this.CopiarDlls( lcRuta, addbs( tcRutaInicial ) + "bin" )
			if this.ExistenDlls( addbs( tcRutaInicial ) + "bin" )
				_screen.Zoo.AgregarReferencia( "TaskBarWrapper.dll" )
				this.oTaskBar = _screen.zoo.CrearObjeto( "TaskBarWrapper.TaskBarWrapper" )
			endif
		endif
	endfunc

	*-----------------------------------------------------------------------------------------
	hidden function ExistenDlls( tcRuta as string ) as Boolean
		local llExisten as Boolean, lcDll as string
		llExisten = .t.

		for each lcDll in this.oDlls
			llExisten = llExisten and file( addbs( tcRuta ) + lcDll )
		endfor

		return llExisten
	endfunc

	*-----------------------------------------------------------------------------------------
	hidden function CopiarDlls( tcRutaOrigen, tcRutaDestino ) as void
		local lcDll as string, loError as object

		for each lcDll in this.oDlls
			local loError as exception, loEx as exception
			try
				copy file ( addbs( tcRutaOrigen ) + lcDll ) to ( addbs( tcRutaDestino ) + lcDll )
			catch to loError
			finally
			endtry
		endfor
	endfunc

	*-----------------------------------------------------------------------------------------
	function PlataformaSoportada() as Boolean
		local llRetorno as Boolean
		llRetorno = .f.
		if vartype( this.oTaskBar ) = "O" and !isnull( this.oTaskBar )
			llRetorno = this.oTaskBar.PlataformaSoportada
		endif

		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	*!*	NOPROGRESS 0
	*!*	INDETERMINATE 1
	*!*	NORMAL 2
	*!*	ERROR 4
	*!*	PAUSED 8
	function EstablecerEstado( tcEstado as string ) as Void
		local lnEstado as integer

		if vartype( this.oTaskBar ) = "O" and !isnull( this.oTaskBar ) and this.oTaskBar.PlataformaSoportada
			lnEstado = this.oEstados[ upper( tcEstado ) ]
			this.oTaskBar.EstablecerEstado( lnEstado )
		endif
	endfunc

	*-----------------------------------------------------------------------------------------
	function EstablecerProgreso( tnPorcentaje as integer, tnTotal as integer ) as Void
		if vartype( this.oTaskBar ) = "O" and !isnull( this.oTaskBar ) and this.oTaskBar.PlataformaSoportada
			this.oTaskBar.EstablecerProgreso( tnPorcentaje, tnTotal )
		endif
	endfunc
enddefine
