
define class Din_EntidadValedecambio_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Valedecambio"
	cClaseResponse = this.cNamespaceDTOs + ".ValedecambioResponse"
	cClaseModelo = "ValedecambioModelo"
	cEntidad = "Valedecambio"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ValedecambioModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ValedecambioModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ValedecambioListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ValedecambioListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ValedecambioModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipo", toEntidad, "Tipo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavencimiento", toEntidad, "Fechavencimiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clienteorigen", toEntidad, "Clienteorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comprobanteorigen", toEntidad, "Comprobanteorigen" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaorigen", toEntidad, "Fechaorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Email", toEntidad, "Email" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serieorigen", toEntidad, "Serieorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuarioorigen", toEntidad, "Usuarioorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bdorigen", toEntidad, "Bdorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seriedestino", toEntidad, "Seriedestino" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuariodestino", toEntidad, "Usuariodestino" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bddestino", toEntidad, "Bddestino" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clientedestino", toEntidad, "Clientedestino" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comprobantedestino", toEntidad, "Comprobantedestino" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadestino", toEntidad, "Fechadestino" )
			this.SetearDetalleComprobantedetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleComprobanteDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ComprobanteDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ComprobanteDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ComprobanteDetalle.LimpiarItem()
			else
				try
					toEntidad.ComprobanteDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ComprobanteDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobantedestino", toEntidad.ComprobanteDetalle.oItem, "ComprobanteDestino" )
			this.SetearAtributoModeloEnEntidad( loItem, "Clientedestino", toEntidad.ComprobanteDetalle.oItem, "ClienteDestino" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechadestino", toEntidad.ComprobanteDetalle.oItem, "FechaDestino" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ComprobanteDetalle.oItem, "Monto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Seriedestino", toEntidad.ComprobanteDetalle.oItem, "SerieDestino" )
			this.SetearAtributoModeloEnEntidad( loItem, "Usuariodestino", toEntidad.ComprobanteDetalle.oItem, "UsuarioDestino" )
			this.SetearAtributoModeloEnEntidad( loItem, "Bddestino", toEntidad.ComprobanteDetalle.oItem, "BDDestino" )
			toEntidad.ComprobanteDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributoString( toModeloResponse, "Tipo", toEntidad.Tipo)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVencimiento", toEntidad.FechaVencimiento)
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoString( toModeloResponse, "ClienteOrigen", toEntidad.ClienteOrigen)
			this.SetearAtributoString( toModeloResponse, "ComprobanteOrigen", toEntidad.ComprobanteOrigen)
			this.SetearAtributoDateTime( toModeloResponse, "FechaOrigen", toEntidad.FechaOrigen)
			this.SetearAtributoString( toModeloResponse, "Email", toEntidad.Email)
			this.SetearAtributoString( toModeloResponse, "SerieOrigen", toEntidad.SerieOrigen)
			this.SetearAtributoString( toModeloResponse, "UsuarioOrigen", toEntidad.UsuarioOrigen)
			this.SetearAtributoString( toModeloResponse, "BDOrigen", toEntidad.BDOrigen)
			this.SetearAtributoString( toModeloResponse, "SerieDestino", toEntidad.SerieDestino)
			this.SetearAtributoString( toModeloResponse, "UsuarioDestino", toEntidad.UsuarioDestino)
			this.SetearAtributoString( toModeloResponse, "BDDestino", toEntidad.BDDestino)
			this.SetearAtributoString( toModeloResponse, "ClienteDestino", toEntidad.ClienteDestino)
			this.SetearAtributoString( toModeloResponse, "ComprobanteDestino", toEntidad.ComprobanteDestino)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDestino", toEntidad.FechaDestino)
			this.CargarColeccionModeloComprobanteDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloComprobanteDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ComprobanteDetalle" ) 
		with toEntidad
			for lnI = 1 to .ComprobanteDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemValedecambio" )
				this.SetearAtributoString( loItem, "Codigo", .ComprobanteDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ComprobanteDestino", .ComprobanteDetalle.Item(lnI).ComprobanteDestino)
				this.SetearAtributoString( loItem, "ClienteDestino", .ComprobanteDetalle.Item(lnI).ClienteDestino)
				this.SetearAtributoDatetime( loItem, "FechaDestino", .ComprobanteDetalle.Item(lnI).FechaDestino)
				this.SetearAtributoDecimal( loItem, "Monto", .ComprobanteDetalle.Item(lnI).Monto)
				this.SetearAtributoString( loItem, "SerieDestino", .ComprobanteDetalle.Item(lnI).SerieDestino)
				this.SetearAtributoString( loItem, "UsuarioDestino", .ComprobanteDetalle.Item(lnI).UsuarioDestino)
				this.SetearAtributoString( loItem, "BDDestino", .ComprobanteDetalle.Item(lnI).BDDestino)
				this.SetearAtributoInteger( loItem, "NroItem", .ComprobanteDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monto", "CMONTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipo", "TIPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "CFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavencimiento", "CFECHAVENC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), COBSS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clienteorigen", "CCLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comprobanteorigen", "CCOMPORI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaorigen", "CFCHORIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Email", "EMAIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serieorigen", "CSERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuarioorigen", "CUSUARIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bdorigen", "CBDORIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seriedestino", "CSERIED")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuariodestino", "CUSUARIOD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bddestino", "CBDDEST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clientedestino", "CCLIENTED")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comprobantedestino", "CCOMPDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadestino", "CFCHDEST")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cobss LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccompori LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Email LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cserie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cusuario LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cbdorig LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cseried LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cusuariod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cbddest LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccliented LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ccompdes LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine