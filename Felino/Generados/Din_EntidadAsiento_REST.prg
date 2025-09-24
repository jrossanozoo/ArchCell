
define class Din_EntidadAsiento_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Asiento"
	cClaseResponse = this.cNamespaceDTOs + ".AsientoResponse"
	cClaseModelo = "AsientoModelo"
	cEntidad = "Asiento"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AsientoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "AsientoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "AsientoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "AsientoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "AsientoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fuente", toEntidad, "Fuente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ejercicio", toEntidad, "Ejercicio_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Razonsocial", toEntidad, "Razonsocial_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipo", toEntidad, "Tipo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clase", toEntidad, "Clase" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Referencia", toEntidad, "Referencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Centrodecostovirtual", toEntidad, "Centrodecostovirtual_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearDetalleAsientodetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diferencia", toEntidad, "Diferencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAsientoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "AsientoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"AsientoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.AsientoDetalle.LimpiarItem()
			else
				try
					toEntidad.AsientoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.AsientoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Plandecuentas", toEntidad.AsientoDetalle.oItem, "PlanDeCuentas_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Plandecuentasdetalle", toEntidad.AsientoDetalle.oItem, "PlanDeCuentasDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Leyenda", toEntidad.AsientoDetalle.oItem, "Leyenda" )
			this.SetearAtributoModeloEnEntidad( loItem, "Centrodecosto", toEntidad.AsientoDetalle.oItem, "CENTRODECOSTO_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Debe", toEntidad.AsientoDetalle.oItem, "Debe" )
			this.SetearAtributoModeloEnEntidad( loItem, "Haber", toEntidad.AsientoDetalle.oItem, "Haber" )
			toEntidad.AsientoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Fuente", toEntidad.Fuente)
			this.SetearAtributoInteger( toModeloResponse, "Ejercicio", toEntidad.Ejercicio_PK)
			this.SetearAtributoString( toModeloResponse, "RazonSocial", toEntidad.RazonSocial_PK)
			this.SetearAtributoInteger( toModeloResponse, "Tipo", toEntidad.Tipo)
			this.SetearAtributoInteger( toModeloResponse, "Clase", toEntidad.Clase)
			this.SetearAtributoString( toModeloResponse, "Referencia", toEntidad.Referencia)
			this.SetearAtributoString( toModeloResponse, "CentroDeCostoVirtual", toEntidad.CentroDeCostoVirtual_PK)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.CargarColeccionModeloAsientoDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "Diferencia", toEntidad.Diferencia)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAsientoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "AsientoDetalle" ) 
		with toEntidad
			for lnI = 1 to .AsientoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAsiento" )
				this.SetearAtributoString( loItem, "Codigo", .AsientoDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "PlanDeCuentas", .AsientoDetalle.Item(lnI).PlanDeCuentas_PK)
				this.SetearAtributoString( loItem, "PlanDeCuentasDetalle", .AsientoDetalle.Item(lnI).PlanDeCuentasDetalle)
				this.SetearAtributoString( loItem, "Leyenda", .AsientoDetalle.Item(lnI).Leyenda)
				this.SetearAtributoString( loItem, "CENTRODECOSTO", .AsientoDetalle.Item(lnI).CENTRODECOSTO_PK)
				this.SetearAtributoDecimal( loItem, "Debe", .AsientoDetalle.Item(lnI).Debe)
				this.SetearAtributoDecimal( loItem, "Haber", .AsientoDetalle.Item(lnI).Haber)
				this.SetearAtributoInteger( loItem, "NroItem", .AsientoDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fuente", "FUENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ejercicio", "EJERCICIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Razonsocial", "RSOCIAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipo", "TIPOASIENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clase", "CLASE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Referencia", "REFEREN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Acod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fuente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rsocial LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Referen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine