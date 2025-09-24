
define class Mock_FACTORIAVALIDACIONGTIN as MockBase of MockBase.prg

	cClase = 'FACTORIAVALIDACIONGTIN'

	
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function obtenervalidador( toobservador as object ) as object                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toobservador

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenervalidador', lcParametros )
	EndFunc


enddefine