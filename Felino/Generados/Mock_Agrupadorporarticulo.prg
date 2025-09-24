
define class Mock_AGRUPADORPORARTICULO as MockBase of MockBase.prg

	cClase = 'AGRUPADORPORARTICULO'

	
	oCopiadorDeItemsStockAColeccion = null                                                                                                                                                                                                                    
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function inyectarcopiadordeitemsstockacoleccion( tocopiadordeitemsstockacoleccion as object ) as void                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tocopiadordeitemsstockacoleccion

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectarcopiadordeitemsstockacoleccion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function agruparporarticulo( tocolarticulofinal as object, toitemstock as object ) as void                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tocolarticulofinal
		lxParam2 = toitemstock

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Agruparporarticulo', lcParametros )
	EndFunc


enddefine