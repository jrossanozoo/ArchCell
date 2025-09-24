
define class Din_EntidadMaquinaria_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Maquinaria"
	cClaseResponse = this.cNamespaceDTOs + ".MaquinariaResponse"
	cClaseModelo = "MaquinariaModelo"
	cEntidad = "Maquinaria"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Codigo" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Codigo = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Codigo = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "MaquinariaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "MaquinariaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MaquinariaListarRequest"
			case "Accion" $ tcOperacion
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			otherwise
				goServicios.Errores.LevantarExcepcionTexto( tcOperacion + " no implementada.")
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseResponse( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "MaquinariaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "MaquinariaModelo"
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerCursorIds( toEntidad as Object, tcFiltro as String, tcOrderBy as String, tnCantidad as Integer, tnPagina as Integer ) as String
		return toEntidad.oAd.ObtenerIdentificadoresPaginado( tcOrderBy, tcFiltro, tnCantidad, tnPagina )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearEntidadConDatosModelo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		with toEntidad
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipomaquinaria", toEntidad, "Tipomaquinaria" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Marca", toEntidad, "Marca" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modelo", toEntidad, "Modelo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serie", toEntidad, "Serie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipificación1", toEntidad, "Tipificación1_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipificación2", toEntidad, "Tipificación2_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Unidaddetiempo", toEntidad, "Unidaddetiempo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadproducida", toEntidad, "Cantidadproducida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Desperdicio", toEntidad, "Desperdicio" )
			this.SetearDetalleConsumos( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleConsumos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Consumos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Consumos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Consumos.LimpiarItem()
			else
				try
					toEntidad.Consumos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Consumos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Consumo", toEntidad.Consumos.oItem, "Consumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.Consumos.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.Consumos.oItem, "Valor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidadmedida", toEntidad.Consumos.oItem, "UnidadMedida" )
			toEntidad.Consumos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "TipoMaquinaria", toEntidad.TipoMaquinaria)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoString( toModeloResponse, "Marca", toEntidad.Marca)
			this.SetearAtributoString( toModeloResponse, "Modelo", toEntidad.Modelo)
			this.SetearAtributoString( toModeloResponse, "Serie", toEntidad.Serie)
			this.SetearAtributoString( toModeloResponse, "Tipificación1", toEntidad.Tipificación1_PK)
			this.SetearAtributoString( toModeloResponse, "Tipificación2", toEntidad.Tipificación2_PK)
			this.SetearAtributoInteger( toModeloResponse, "UnidadDeTiempo", toEntidad.UnidadDeTiempo)
			this.SetearAtributoDecimal( toModeloResponse, "CantidadProducida", toEntidad.CantidadProducida)
			this.SetearAtributoDecimal( toModeloResponse, "Desperdicio", toEntidad.Desperdicio)
			this.CargarColeccionModeloConsumos( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloConsumos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Consumos" ) 
		with toEntidad
			for lnI = 1 to .Consumos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemMaquinariaconsumo" )
				this.SetearAtributoString( loItem, "Codigo", .Consumos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Consumo", .Consumos.Item(lnI).Consumo_PK)
				this.SetearAtributoString( loItem, "Descripcion", .Consumos.Item(lnI).Descripcion)
				this.SetearAtributoDecimal( loItem, "Valor", .Consumos.Item(lnI).Valor)
				this.SetearAtributoString( loItem, "UnidadMedida", .Consumos.Item(lnI).UnidadMedida)
				this.SetearAtributoInteger( loItem, "NroItem", .Consumos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipomaquinaria", "TIPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Marca", "MARCA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modelo", "MODELO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serie", "SERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipificación1", "TIPIFICA1")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipificación2", "TIPIFICA2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Unidaddetiempo", "UNIDAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadproducida", "CANTIDADP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Desperdicio", "DESPERD")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marca LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Modelo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipifica1 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipifica2 LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine