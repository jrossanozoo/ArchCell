
define class Din_EntidadAsientotipo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Asientotipo"
	cClaseResponse = this.cNamespaceDTOs + ".AsientotipoResponse"
	cClaseModelo = "AsientotipoModelo"
	cEntidad = "Asientotipo"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AsientotipoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "AsientotipoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "AsientotipoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AsientotipoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "AsientotipoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Leyenda", toEntidad, "Leyenda" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Leyendapropia", toEntidad, "Leyendapropia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Asientospor", toEntidad, "Asientospor" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diadelmes", toEntidad, "Diadelmes" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porletra", toEntidad, "Porletra" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Portipocomp", toEntidad, "Portipocomp" )
			this.SetearDetalleAsientotipodetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadecuentas", toEntidad, "Listadecuentas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAsientoTipoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "AsientoTipoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"AsientoTipoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.AsientoTipoDetalle.LimpiarItem()
			else
				try
					toEntidad.AsientoTipoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.AsientoTipoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Concepto", toEntidad.AsientoTipoDetalle.oItem, "Concepto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Plandecuentasdebe", toEntidad.AsientoTipoDetalle.oItem, "PlanDeCuentasDebe_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Plandecuentasdebedetalle", toEntidad.AsientoTipoDetalle.oItem, "PlanDeCuentasDebeDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Plandecuentashaber", toEntidad.AsientoTipoDetalle.oItem, "PlanDeCuentasHaber_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Plandecuentashaberdetalle", toEntidad.AsientoTipoDetalle.oItem, "PlanDeCuentasHaberDetalle" )
			toEntidad.AsientoTipoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "Leyenda", toEntidad.Leyenda)
			this.SetearAtributoString( toModeloResponse, "LeyendaPropia", toEntidad.LeyendaPropia)
			this.SetearAtributoInteger( toModeloResponse, "AsientosPor", toEntidad.AsientosPor)
			this.SetearAtributoInteger( toModeloResponse, "DiaDelMes", toEntidad.DiaDelMes)
			this.SetearAtributo( toModeloResponse, "PorLetra", toEntidad.PorLetra)
			this.SetearAtributo( toModeloResponse, "PorTipoComp", toEntidad.PorTipoComp)
			this.CargarColeccionModeloAsientoTipoDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "ListaDeCuentas", toEntidad.ListaDeCuentas)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAsientoTipoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "AsientoTipoDetalle" ) 
		with toEntidad
			for lnI = 1 to .AsientoTipoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAsientotipo" )
				this.SetearAtributoString( loItem, "Codigo", .AsientoTipoDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Concepto", .AsientoTipoDetalle.Item(lnI).Concepto)
				this.SetearAtributoString( loItem, "PlanDeCuentasDebe", .AsientoTipoDetalle.Item(lnI).PlanDeCuentasDebe_PK)
				this.SetearAtributoString( loItem, "PlanDeCuentasDebeDetalle", .AsientoTipoDetalle.Item(lnI).PlanDeCuentasDebeDetalle)
				this.SetearAtributoString( loItem, "PlanDeCuentasHaber", .AsientoTipoDetalle.Item(lnI).PlanDeCuentasHaber_PK)
				this.SetearAtributoString( loItem, "PlanDeCuentasHaberDetalle", .AsientoTipoDetalle.Item(lnI).PlanDeCuentasHaberDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .AsientoTipoDetalle.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Leyenda", "LEYENDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Leyendapropia", "LEYPROP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Asientospor", "ASIENTOP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diadelmes", "DIADELMES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porletra", "PORLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Portipocomp", "PORTIPOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Leyprop LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine