
define class Mock_GENERADORSENTENCIACOMBINACION_STOCKCOMBINACION as MockBase of MockBase.prg

	cClase = 'GENERADORSENTENCIACOMBINACION_STOCKCOMBINACION'

	
	cCadenaExcepcion = "and PRECIOAR.TimestampA >= ' + transform( This.f_TIMESTAMPALTA_Desde ) + ' and PRECIOAR.TimestampA <= ' + transform( This.f_TIMESTAMPALTA_Hasta ) + '"                                                                                
	cCampoCantidad = ''                                                                                                                                                                                                                                       
	cEntidadConsulta = ""                                                                                                                                                                                                                                     
	cEntidadConsulta = "StockCombinacion"                                                                                                                                                                                                                     
	oEntidadConsulta = null                                                                                                                                                                                                                                   
	oEntidadOrigen = null                                                                                                                                                                                                                                     
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init() as boolean                                                                                                                                                                                                                                
	EndFunc

	*-----------------------------------------------------------------------------------------
	function inyectarentidad( toentidad ) as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toentidad

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Inyectarentidad', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenersentencia() as string                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenersentencia', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenertablasconsultacombinaciones() as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertablasconsultacombinaciones', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerwhereprincipal() as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerwhereprincipal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function oentidadconsulta_access() as variant                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Oentidadconsulta_access', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerbasededatos() as string                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerbasededatos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercampoentidadsegunatributo( tcatributosinpk as string ) as string                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcatributosinpk

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenercampoentidadsegunatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenercamposcombinacionconcatenados() as string                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercamposcombinacionconcatenados', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerjointabladetalle() as string                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerjointabladetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenernombredecamposcombinacion() as string                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombredecamposcombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenernombredetablaprincipal() as string                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombredetablaprincipal', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerorigendecombinacion() as string                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerorigendecombinacion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertablaconbase( tctabla as string ) as void                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tctabla

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenertablaconbase', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertabladedetalle() as string                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertabladedetalle', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertablasjoin() as string                                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertablasjoin', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerwhere() as string                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerwhere', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerwhereconsultaprecios() as string                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerwhereconsultaprecios', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenerwheretabladeprecioscambiadaporentidadconsulta() as string                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerwheretabladeprecioscambiadaporentidadconsulta', lcParametros )
	EndFunc


enddefine