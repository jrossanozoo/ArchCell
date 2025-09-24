
	#INCLUDE CONSTANTESDIBUJANTE.H
define class Mock_COMBOATRIBUTOSCONSALTODECAMPO as MockBase of MockBase.prg

	cClase = 'COMBOATRIBUTOSCONSALTODECAMPO'

	
	DataSession = 1                                                                                                                                                                                                                                           
	EsAjustable = .F.                                                                                                                                                                                                                                         
	IntegralHeight = .T.                                                                                                                                                                                                                                      
	Margin = 0                                                                                                                                                                                                                                                
	Style = 2                                                                                                                                                                                                                                                 
	cAtributo = ""                                                                                                                                                                                                                                            
	cAtributoPadre = ""                                                                                                                                                                                                                                       
	cAyuda = ""                                                                                                                                                                                                                                               
	cClaveForanea = ""                                                                                                                                                                                                                                        
	cCursorAtributos = ''                                                                                                                                                                                                                                     
	cCursorCombo = ""                                                                                                                                                                                                                                         
	cEntidad = ""                                                                                                                                                                                                                                             
	cEntidadFiltro = ""                                                                                                                                                                                                                                       
	cEstado = ""                                                                                                                                                                                                                                              
	cEtiquetaTodos = "Todos"                                                                                                                                                                                                                                  
	cTipoDato = ""                                                                                                                                                                                                                                            
	cToolTip = ""                                                                                                                                                                                                                                             
	lClavePrimaria = .F.                                                                                                                                                                                                                                      
	lClickForzado = .f.                                                                                                                                                                                                                                       
	lCodigoUpper = .t.                                                                                                                                                                                                                                        
	lDesplegarLista = .T.                                                                                                                                                                                                                                     
	lDetalle = .F.                                                                                                                                                                                                                                            
	lDropDown = .f.                                                                                                                                                                                                                                           
	lEjecutarArmar = .t.                                                                                                                                                                                                                                      
	lEnterForzado = .F.                                                                                                                                                                                                                                       
	lEsControlConSaltoDeCampoDefiniblePorElUsuario = .T.                                                                                                                                                                                                      
	lEsObligatorio = .f.                                                                                                                                                                                                                                      
	lEsSeteable = .T.                                                                                                                                                                                                                                         
	lEsSubEntidad = .F.                                                                                                                                                                                                                                       
	lEsTraducible = .T.                                                                                                                                                                                                                                       
	lEstoyEnUnListado = .f.                                                                                                                                                                                                                                   
	lPrimerGotFocus = .f.                                                                                                                                                                                                                                     
	lPuedeUtilizarseEnListados = .f.                                                                                                                                                                                                                          
	lSaltoCampo = .F.                                                                                                                                                                                                                                         
	lSePuedeOrdenar = .T.                                                                                                                                                                                                                                     
	lSeSuperpone = .F.                                                                                                                                                                                                                                        
	lTabForzado = .F.                                                                                                                                                                                                                                         
	lValidaSoloSiModifico = .F.                                                                                                                                                                                                                               
	nBackColorConFoco = 0                                                                                                                                                                                                                                     
	nBackColorObligSinFoco = 0                                                                                                                                                                                                                                
	nBackColorSinFoco = 0                                                                                                                                                                                                                                     
	nColumna = 0                                                                                                                                                                                                                                              
	nFila = 0                                                                                                                                                                                                                                                 
	nForeColorConFoco = 0                                                                                                                                                                                                                                     
	nForeColorObligSinFoco = 0                                                                                                                                                                                                                                
	nForeColorSinFoco = 0                                                                                                                                                                                                                                     
	nIndex = 1                                                                                                                                                                                                                                                
	nTipoDeOrdenIzquierdo = NO_ACOMODAR                                                                                                                                                                                                                       
	nTipoDeOrdenSuperior = NO_ACOMODAR                                                                                                                                                                                                                        
	oEntidad = Null                                                                                                                                                                                                                                           
	oItem = Null                                                                                                                                                                                                                                              
	oMouse = null                                                                                                                                                                                                                                             
	oSerializador = null                                                                                                                                                                                                                                      
	xValorAnterior = Null                                                                                                                                                                                                                                     
	xValorInicial = null                                                                                                                                                                                                                                      
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function activarcomportamientoportecla( nkeycode, nshiftaltctrl ) as void                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = nkeycode
		lxParam2 = nshiftaltctrl

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Activarcomportamientoportecla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function actualizar() as void                                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Actualizar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function antesdeaplicarestilos( toestilos as object ) as void                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toestilos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Antesdeaplicarestilos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function aplicarestilo( toestilos as object ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toestilos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Aplicarestilo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function armar() as void                                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Armar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function completarcombo() as string                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Completarcombo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function desplegar() as void                                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Desplegar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdeaplicarestilos( toestilos as object ) as void                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toestilos

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Despuesdeaplicarestilos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdelvalid( tnretorno as integer ) as boolean                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tnretorno

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Despuesdelvalid', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function despuesdeserializar() as string                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Despuesdeserializar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function dropdown() as void                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Dropdown', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function enabled_assign( tlvalue as boolean ) as void                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tlvalue

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Enabled_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esatributoobligatorio() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esatributoobligatorio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function esformulariocondetalledevalores() as booloean                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Esformulariocondetalledevalores', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function estaenformulariodeparametros() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Estaenformulariodeparametros', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function gotfocus()                                                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Gotfocus', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function init( toitem as object )                                                                                                                                                                                                                         
	EndFunc

	*-----------------------------------------------------------------------------------------
	function keypress( nkeycode, nshiftaltctrl )                                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = nkeycode
		lxParam2 = nshiftaltctrl

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Keypress', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function lostfocus()                                                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Lostfocus', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mousedown( tnbutton as integer, tnshift as integer, tnxcoord as integer, tnycoord as integer ) as void                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tnbutton
		lxParam2 = tnshift
		lxParam3 = tnxcoord
		lxParam4 = tnycoord

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Mousedown', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mouseenter( nbutton, nshift, nxcoord, nycoord ) as void                                                                                                                                                                                          
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = nbutton
		lxParam2 = nshift
		lxParam3 = nxcoord
		lxParam4 = nycoord

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Mouseenter', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function mouseup( tnbutton as integer, tnshift as integer, tnxcoord as integer, tnycoord as integer ) as void                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2, lxParam3, lxParam4

		lnParametros = pcount()
		lxParam1 = tnbutton
		lxParam2 = tnshift
		lxParam3 = tnxcoord
		lxParam4 = tnycoord

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Mouseup', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneranchomaximoprimercolumna( tccadena as string ) as integer                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccadena

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obteneranchomaximoprimercolumna', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obteneratributoseleccionado() as void                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributoseleccionado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerayuda() as string                                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerayuda', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerayudacomportamientoportecla() as string                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerayudacomportamientoportecla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdescripcion() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdescripcion', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerdetalleasociado() as void                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerdetalleasociado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerposicionmouse() as void                                                                                                                                                                                                                   
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerposicionmouse', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenerproximocontrol() as integer                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenerproximocontrol', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervalordelatributo() as variant                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenervalordelatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervalorescombo( toparametros as zoocoleccion of zoocoleccion.prg ) as zoocoleccion of zoocoleccion.prg                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toparametros

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenervalorescombo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ordenar() as void                                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ordenar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearcontrol( toitem ) as void                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toitem

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearcontrol', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearestado( tcestado as string ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tcestado

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearestado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearluegodeordenar( toacomodadorcontroles as object ) as void                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = toacomodadorcontroles

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearluegodeordenar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function setearvalorenelatributo( txvalor as variant ) as void                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txvalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Setearvalorenelatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function seteraposicionmouse() as void                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Seteraposicionmouse', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienecomportamientoportecla( nkeycode, nshiftaltctrl ) as boolean                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1, lxParam2

		lnParametros = pcount()
		lxParam1 = nkeycode
		lxParam2 = nshiftaltctrl

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Tienecomportamientoportecla', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function tienevalorsugeridoporsistema() as void                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Tienevalorsugeridoporsistema', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function transformarvalorparaobtener( txvalor as variant ) as variant                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txvalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Transformarvalorparaobtener', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function transformarvalorparasetear( txvalor as variant ) as variant                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txvalor

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Transformarvalorparasetear', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function valid() as integer                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Valid', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validarantesdesetearatributo() as boolean                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarantesdesetearatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validardespuesdesetearatributo() as boolean                                                                                                                                                                                                      
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validardespuesdesetearatributo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function value_assign( txvalue as variant ) as void                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = txvalue

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Value_assign', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function when() as boolean                                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'When', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obteneratributorelacionado() as string                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obteneratributorelacionado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenernombretablacombo() as string                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenernombretablacombo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenervalordelcursor( tccampo as string ) as void                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer
		local lxParam1

		lnParametros = pcount()
		lxParam1 = tccampo

		lcParametros = ''
		for lni = 1 to lnParametros
			lcParam = 'lxParam' + alltrim(str(lni))
			lcParametros = lcParametros + iif( !empty(lcParametros),',','') + iif( vartype( &lcParam ) = 'O' or isnull(&lcParam), "'*OBJETO'", goLibrerias.ValorAString( &lcParam ) )
		endfor

		return this.ObtenerResultado( 'Obtenervalordelcursor', lcParametros )
	EndFunc


enddefine