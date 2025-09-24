define class _ControlDeObjetosInstanciados as Custom
	
	#if .f.
		local this as _ControlDeObjetosInstanciados of _ControlDeObjetosInstanciados.prg
	#endif
	
	protected _nCantidadDeEmptysAntesDeIniciarControl, _oInstanciasAntesDeIniciarControl, _lControlAvanzado as Boolean
	
	_nCantidadDeInstanciasAntesDeIniciarControl = 0
	_nCantidadDeEmptysAntesDeIniciarControl = 0
	_oInstanciasAntesDeIniciarControl = null
	_lControlAvanzado = .f.

	*-----------------------------------------------------------------------------------------
	function IniciarControl( tlControlAvanzado as Boolean ) as Void
		this._nCantidadDeInstanciasAntesDeIniciarControl = _Vfp.Objects.count
		this._lControlAvanzado = tlControlAvanzado 
		if this._lControlAvanzado
			this.SetearObjetosInstanciados()
		endif
	endfunc 

	*-----------------------------------------------------------------------------------------
	function FinalizarControl() as String
		local lcMensajeDeErrores as String, loProblemas as Collection, lcProblema as string

		lcMensajeDeErrores = ""

		if this._lControlAvanzado
			loProblemas = this.ControlarObjetosInstanciados()
			for each lcProblema in loProblemas foxobject
				lcMensajeDeErrores = lcMensajeDeErrores + lcProblema + chr(13)+chr(10)
			endfor
			loProblemas.Remove(-1)
			loProblemas = null
		endif
		
		if this._nCantidadDeInstanciasAntesDeIniciarControl != _Vfp.Objects.count
			lcMensajeDeErrores = "La cantidad de objetos instanciados ha variado, antes: " + ;
								transform( this._nCantidadDeInstanciasAntesDeIniciarControl ) + " " + ;
								"ahora: " + transform( _Vfp.Objects.count ) + ;
								" " + chr(13) + chr(10) + lcMensajeDeErrores 
		endif		
		return lcMensajeDeErrores
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function SetearObjetosInstanciados() as Void
		local loObjectoVFP as Object, loVfpObject as Collection, lcDescripcion as string
		
		this._oInstanciasAntesDeIniciarControl = newobject( "collection" )
		loVfpObject = _vfp.Objects
		
		for each loObjectoVFP in loVfpObject foxobject
			if pemstatus( loObjectoVFP, "AddProperty", 5 )
				&& Si no tiene el método AddProperty se lo va a 'catalogar' como Empty, categoria la cual no incluye objetos .Net
				
				if !pemstatus( loObjectoVFP, "_zTestControlHandler", 5 )
					&& Firmamos la instancia, esto nos ayuda a identificar los objetos que ya existian al iniciar el control,
					&& de los nuevos al finalizar el control.
					loObjectoVFP.AddProperty( "_zTestControlHandler", this.ObtenerGuid() )
				endif
				this._oInstanciasAntesDeIniciarControl.Add( this.ObtenerItemDefinicion( loObjectoVFP ), loObjectoVFP._zTestControlHandler )
			else
				&& Es un empty de VFP o algo que no se basa en el Custom de Fox.
				&& Es muy posible que empty que provenga de un 'Scatter name loVariable'
				&& Los objetos de .Net no se aparecen en la colección de -> _vfp.Objects
				this._nCantidadDeEmptysAntesDeIniciarControl = this._nCantidadDeEmptysAntesDeIniciarControl + 1 
			endif
		endfor
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ControlarObjetosInstanciados() as Collection	
		local loProblemas as Collection, loInstanciaVFP as Object, loVfpObject as Collection, lnCantidadDeEmptys as Integer
		
		loProblemas = newobject( "collection" )
		loProblemas.Name = "_zTestControlHandlerOmitir"
		lnCantidadDeEmptys = 0
		loVfpObject = _vfp.Objects

		&& (1) control de Instancias nuevas no cerraras *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- 
		for each loInstanciaVFP in loVfpObject foxobject
			if pemstatus( loInstanciaVFP, "AddProperty", 5 )
				if pemstatus( loInstanciaVFP, "_zTestControlHandler", 5 )
					this._oInstanciasAntesDeIniciarControl.item[loInstanciaVFP._zTestControlHandler].lEliminado = .f. && Existe en _vfp.Objects
				else
					if upper( loProblemas.Name ) != upper( loInstanciaVFP.Name )
						loProblemas.add( "Nueva instancia detectada (" + this.ObtenerDescripcionDeInstancia( loInstanciaVFP )+ ")" ) 
					endif
				endif
			else
				lnCantidadDeEmptys = lnCantidadDeEmptys + 1 
			endif
			
		endfor
		
		&& (2) Control de cantidad de EMPTY *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- 
		if lnCantidadDeEmptys # this._nCantidadDeEmptysAntesDeIniciarControl 
			loProblemas.Add( "Cambio la cantidad de objectos empty, antes: "  + transform( this._nCantidadDeEmptysAntesDeIniciarControl  ) + " ahora: " + transform( lnCantidadDeEmptys ) )
		endif
		
		&& (3) control de Instancias viejas cerraras *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *- *-
		for each loItemDefinicion in this._oInstanciasAntesDeIniciarControl
			if loItemDefinicion.lEliminado
				loProblemas.Add( "Se elimino una instancia (" + loItemDefinicion.cDescripcion + ")")
			endif
		endfor
		loItemDefinicion = null
		loInstanciaVFP = null
		loVfpObject = null
		
		
		this._oInstanciasAntesDeIniciarControl.remove(-1)
		this._oInstanciasAntesDeIniciarControl = null
		
		return loProblemas
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerDescripcionDeInstancia( toInstancia as Object ) as string
		local lcDescripcion as String
		if pemstatus( toInstancia, "BaseClass", 5 )
			lcDescripcion = "BC: " + toInstancia.BaseClass + ", C:" + toInstancia.Class + ", N:" + toInstancia.Name
		else
			dimension laDatos[1]
			local i as integer, lnLargo as Integer 
			amembers( laDatos, toInstancia, 0 )
			lnLargo = alen( laDatos, 1 )
			lcDescripcion = "Definición: "
			for i = 1 to lnLargo
				lcDescripcion = lcDescripcion + laDatos[i,1] + ","
			endfor
			lcDescripcion = left( lcDescripcion, len(lcDescripcion)-1 )
			release laDatos
		endif
		return lcDescripcion
	endfunc 

	*-----------------------------------------------------------------------------------------
	protected function ObtenerItemDefinicion( toObjeto as Variant ) as ItemDefinicion
		local loRetorno as empty
		loRetorno = newobject( "ItemDefinicion" )
		loRetorno.cDescripcion = this.ObtenerDescripcionDeInstancia( toObjeto  ) 
		return loRetorno 
	endfunc 
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerGuid() as String
		if type( 'goServicios.Librerias' ) == "O"
			return goServicios.Librerias.ObtenerGuidPk()
		else
			return strtran( sys(2015) + sys(2015), "-", "" )
		endif
	endfunc 		
enddefine

*-----------------------------------------------------------------------------------------
*-----------------------------------------------------------------------------------------
*-----------------------------------------------------------------------------------------
*-----------------------------------------------------------------------------------------
*-----------------------------------------------------------------------------------------
define class ItemDefinicion as custom
	name = "_zTestControlHandlerOmitir"
	cDescripcion = ""
	lEliminado = .t.
enddefine
