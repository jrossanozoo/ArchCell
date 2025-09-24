
define class Mock_ARMADORESTRUCTURALINCEVALIDADOR as MockBase of MockBase.prg

	cClase = 'ARMADORESTRUCTURALINCEVALIDADOR'

	
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncolor( tosentencias, tcprefijocursor ) as object                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncolor', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalle( tosentencias, tcprefijocursor ) as object                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalleitemtalle( tosentencias, tcprefijocursor ) as object                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalleitemtalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticulo( tosentencias, tcprefijocursor ) as object                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncliente( tosentencias, tcprefijocursor ) as object                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncliente', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticuloequivalencia( tosentencias, tcprefijocursor ) as object                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticuloequivalencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncolorequivalencia( tosentencias, tcprefijocursor ) as object                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncolorequivalencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalleequivalencia( tosentencias, tcprefijocursor ) as object                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalleequivalencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionparametrosprecios( tosentencias ) as object                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tosentencias

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionparametrosprecios', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticuloprecio( tosentencias, tcprefijocursor ) as object                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticuloprecio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncolorprecio( tosentencias, tcprefijocursor ) as object                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncolorprecio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalleprecio( tosentencias, tcprefijocursor ) as object                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalleprecio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionorigendestino( tosentencias, tcprefijocursor ) as object                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionorigendestino', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionparametroorigenparapaquetes( tosentencias ) as object                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tosentencias

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionparametroorigenparapaquetes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionorigendestinomovstock( tosentencias, tcprefijocursor ) as object                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionorigendestinomovstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticuloitemmertransitodesderemito( tosentencias, tcprefijocursor ) as object                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticuloitemmertransitodesderemito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticuloitemmovstock( tosentencias, tcprefijocursor ) as object                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticuloitemmovstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncoloritemmertransitodesderemito( tosentencias, tcprefijocursor ) as object                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncoloritemmertransitodesderemito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncoloritemmovstock( tosentencias, tcprefijocursor ) as object                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncoloritemmovstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalleitemmertransitodesderemito( tosentencias, tcprefijocursor ) as object                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalleitemmertransitodesderemito', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalleitemmovstock( tosentencias, tcprefijocursor ) as object                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalleitemmovstock', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionvalorequivalenciadevalores( tosentencias, tcprefijocursor ) as object                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionvalorequivalenciadevalores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionnumerocomprobantedeventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionnumerocomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionvendedorcomprobantedeventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionvendedorcomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionclientecomprobantedeventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionclientecomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionequivalencialistacomprobantedeventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionequivalencialistacomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticuloitemarticulosventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticuloitemarticulosventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncoloritemarticulosventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncoloritemarticulosventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontalleitemarticulosventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontalleitemarticulosventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontipovaloritemvalores( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontipovaloritemvalores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciontipodocumentodatosadicionalescomprobantesa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciontipodocumentodatosadicionalescomprobantesa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncodigoimpuestoitemimpuestoventas( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncodigoimpuestoitemimpuestoventas', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncajacomprobantedeventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncajacomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacioncodigoesquemafiscal( tosentencias as object, tcprefijocursor as string ) as object                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacioncodigoesquemafiscal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciondescuentoorecargofinanciero(tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciondescuentoorecargofinanciero', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidaciondescuentosorecargoscomprobantedeventa(tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidaciondescuentosorecargoscomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionproveedorarticulo( tosentencias, tcprefijocursor ) as object                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionproveedorarticulo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionproveedorarticuloitemarticulosventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionproveedorarticuloitemarticulosventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionpuntodeventacomprobantedeventa( tosentencias as object, tcprefijocursor as string, tcentidad as string, tcentidaddesc as string ) as object                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad
		lxParam4 = tcentidaddesc

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionpuntodeventacomprobantedeventa', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionmoneda(tosentencias as object, tcprefijocursor as string, tcentidad as string ) as object                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor
		lxParam3 = tcentidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionmoneda', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentenciasvalidacionarticuloitemautorizaciondjcp( tosentencias, tcprefijocursor ) as object                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = tosentencias
		lxParam2 = tcprefijocursor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenersentenciasvalidacionarticuloitemautorizaciondjcp', lcParametros )
	EndFunc


enddefine