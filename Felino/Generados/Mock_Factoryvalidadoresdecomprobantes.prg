
define class Mock_FACTORYVALIDADORESDECOMPROBANTES as MockBase of MockBase.prg

	cClase = 'FACTORYVALIDADORESDECOMPROBANTES'

	
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function obtenercoleccionvalidadores( tocomprobante as object ) as zoocoleccion                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocomprobante

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercoleccionvalidadores', lcParametros )
	EndFunc


enddefine