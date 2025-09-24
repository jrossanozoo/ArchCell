define class fxuTestCaseListados as FxuTestCase OF FxuTestCase.prg

	#If .F.
		Local This As fxuTestCaseListados Of fxuTestCaseListados.prg
	#Endif
	
	*-----------------------------------------------------------------------------------------
	function ProbarCombinacionesListado( tnListado as Integer, tcTablaFit as String )	

		local loConsulta as Object, loObjeto as Object, lcNombreObjeto as String, lcNombreConsulta as String ,;
				llDuro as Boolean, lnOrd as Integer, lnAtrib as Integer 
		
		llDuro = .F.
		
		lcNombreConsulta = this.ObtenerNombreConsulta( tnListado )
		lcNombreObjeto = this.ObtenerNombreObjeto( tnListado )
		
		if left( lcNombreConsulta, 4 ) = "lis_" or left( lcNombreObjeto, 4 ) = "lis_"
			llDuro = .T.		
		endif
				
		this.assertTrue("No se deben probar las combinaciones en listados NO duros", llDuro)

		loConsulta = _screen.zoo.crearobjeto( lcNombreConsulta )
		loObjeto = _screen.zoo.crearobjeto( lcNombreObjeto )		
		loObjeto.inicializar()

		use ( tcTablaFit ) in 0 shared 

		for lnOrd = 1 to loObjeto.oOrdenamientos.count
			for lnAtrib = 0 to loObjeto.oAtributosSubTotal.count
				select ( tcTablaFit )
				locate for ordenadoPor = lnOrd and subtotalizaPor = lnAtrib
				if found()
				else
					this.asserttrue( "Falta un test fit para el listado " + transform( tnListado ) + " en la tabla " + alltrim( tcTablaFit ) + ;
					" con el ordenamiento " + transform( lnOrd ) + " y el subtotaliza " + transform( lnAtrib ) )
				endif
				
			endfor
		endfor
		
		use in select( tcTablaFit )
		
		loConsulta.release()
		loObjeto.release()
	endfunc

	*-----------------------------------------------------------------------------------------
	function cargarFiltros( toObjeto as object ) as Void
		
		local loFiltros as Object, loCampos as Object 
		
		loFiltros = toObjeto.oFiltros
		loCampos = toObjeto.oCampos
		
		for each loItem in loFiltros
			for each loItemCampo in loCampos
				
				if loItem.idCampo = loItemCampo.idCampo
					
					do case
					case loItemCampo.TipoDato = "C"
						loItem.valor1 = replicate( "e", loItemCampo.longitud )
						loItem.valor2 = replicate( "f", loItemCampo.longitud )
						
					case loItemCampo.TipoDato = "N"					
						loItem.valor1 = val( replicate( "4", loItemCampo.longitud ) )
						loItem.valor2 = val( replicate( "5", loItemCampo.longitud ) )
										
					case loItemCampo.TipoDato = "D"					
						loItem.valor1 = date() - 10
						loItem.valor2 = date()

					otherwise
					endcase

					if empty( loItem.valor1 )
					else
						exit
					endif 
				endif 
			endfor
			if empty( loItem.valor1 )
				this.asserttrue( "El filtro del campo " + allt( str( loItem.idCampo ) ) + " sin llenar.", .F.  )
			endif
		endfor

	endfunc 


	*-----------------------------------------------------------------------------------------
	function ObtenerNombreConsulta( tnListado as Integer ) as string
		return this.ObtenerNombre( tnListado, "Consulta" )
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ObtenerNombreObjeto( tnListado as Integer ) as string
		return this.ObtenerNombre( tnListado, "Objeto" )
	endfunc 

	*-----------------------------------------------------------------------------------------
	function ObtenerNombre( tnListado as Integer, tcTipo as String ) as string
		local lcNombre as String 
		
		if file( "lis_listado" + transform( tnListado ) + alltrim( tcTipo ) + ".prg" )
			lcNombre = "lis_listado" + transform( tnListado ) + alltrim( tcTipo )
		else
			lcNombre = "din_listado" + transform( tnListado ) + alltrim( tcTipo )
		endif 

		return lcNombre
		
	endfunc 

enddefine
