
define class Mock_FACTORIACOMPORTAMIENTOVALIDACIONGTIN as MockBase of MockBase.prg

	cClase = 'FACTORIACOMPORTAMIENTOVALIDACIONGTIN'

	
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function obtenertratamientodevalidaciongtin( tltratarmultiplesitems as boolean, tomensaje as object ) as void                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tltratarmultiplesitems
		lxParam2 = tomensaje

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenertratamientodevalidaciongtin', lcParametros )
	EndFunc


enddefine