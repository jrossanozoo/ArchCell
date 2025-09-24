
define class Din_EntidadInformacionadicionalcompvtas_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Informacionadicionalcompvtas"
	cClaseResponse = this.cNamespaceDTOs + ".InformacionadicionalcompvtasResponse"
	cClaseModelo = "InformacionadicionalcompvtasModelo"
	cEntidad = "Informacionadicionalcompvtas"
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
				lcRetorno = this.cNamespaceDTOs + "." + "InformacionadicionalcompvtasModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "InformacionadicionalcompvtasModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "InformacionadicionalcompvtasListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "InformacionadicionalcompvtasListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "InformacionadicionalcompvtasModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Zadsfw", toEntidad, "Zadsfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Referencia", toEntidad, "Referencia" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaaltafw", toEntidad, "Fechaaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horaaltafw", toEntidad, "Horaaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuarioaltafw", toEntidad, "Usuarioaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seriealtafw", toEntidad, "Seriealtafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosaltafw", toEntidad, "Basededatosaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Versionaltafw", toEntidad, "Versionaltafw" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechamodificacionfw", toEntidad, "Fechamodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horamodificacionfw", toEntidad, "Horamodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuariomodificacionfw", toEntidad, "Usuariomodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seriemodificacionfw", toEntidad, "Seriemodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosmodificacionfw", toEntidad, "Basededatosmodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Versionmodificacionfw", toEntidad, "Versionmodificacionfw" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaimpo", toEntidad, "Fechaimpo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horaimpo", toEntidad, "Horaimpo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaexpo", toEntidad, "Fechaexpo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horaexpo", toEntidad, "Horaexpo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estadotransferencia", toEntidad, "Estadotransferencia" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechatransferencia", toEntidad, "Fechatransferencia" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nroopecommerce", toEntidad, "Nroopecommerce" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Referenciavirtual", toEntidad, "Referenciavirtual" )
			this.SetearDetalleComprobantes( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleComprobantes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Comprobantes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Comprobantes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Comprobantes.LimpiarItem()
			else
				try
					toEntidad.Comprobantes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Comprobantes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Tipocompcaracter", toEntidad.Comprobantes.oItem, "TipoCompCaracter" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.Comprobantes.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Total", toEntidad.Comprobantes.oItem, "Total" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.Comprobantes.oItem, "Tipo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Interviniente", toEntidad.Comprobantes.oItem, "Interviniente" )
			this.SetearAtributoModeloEnEntidad( loItem, "Origen", toEntidad.Comprobantes.oItem, "Origen" )
			toEntidad.Comprobantes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributo( toModeloResponse, "ZADSFW", toEntidad.ZADSFW)
			this.SetearAtributoString( toModeloResponse, "Referencia", toEntidad.Referencia)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAltaFW", toEntidad.FechaAltaFW)
			this.SetearAtributoString( toModeloResponse, "HoraAltaFW", toEntidad.HoraAltaFW)
			this.SetearAtributoString( toModeloResponse, "UsuarioAltaFW", toEntidad.UsuarioAltaFW)
			this.SetearAtributoString( toModeloResponse, "SerieAltaFW", toEntidad.SerieAltaFW)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatosAltaFW", toEntidad.BaseDeDatosAltaFW)
			this.SetearAtributoString( toModeloResponse, "VersionAltaFW", toEntidad.VersionAltaFW)
			this.SetearAtributoDateTime( toModeloResponse, "FechaModificacionFW", toEntidad.FechaModificacionFW)
			this.SetearAtributoString( toModeloResponse, "HoraModificacionFW", toEntidad.HoraModificacionFW)
			this.SetearAtributoString( toModeloResponse, "UsuarioModificacionFW", toEntidad.UsuarioModificacionFW)
			this.SetearAtributoString( toModeloResponse, "SerieModificacionFW", toEntidad.SerieModificacionFW)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatosModificacionFW", toEntidad.BaseDeDatosModificacionFW)
			this.SetearAtributoString( toModeloResponse, "VersionModificacionFW", toEntidad.VersionModificacionFW)
			this.SetearAtributoDateTime( toModeloResponse, "FechaImpo", toEntidad.FechaImpo)
			this.SetearAtributoString( toModeloResponse, "HoraImpo", toEntidad.HoraImpo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaExpo", toEntidad.FechaExpo)
			this.SetearAtributoString( toModeloResponse, "HoraExpo", toEntidad.HoraExpo)
			this.SetearAtributoString( toModeloResponse, "EstadoTransferencia", toEntidad.EstadoTransferencia)
			this.SetearAtributoDateTime( toModeloResponse, "FechaTransferencia", toEntidad.FechaTransferencia)
			this.SetearAtributoString( toModeloResponse, "NroOpEcommerce", toEntidad.NroOpEcommerce)
			this.SetearAtributoString( toModeloResponse, "ReferenciaVirtual", toEntidad.ReferenciaVirtual)
			this.CargarColeccionModeloComprobantes( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloComprobantes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Comprobantes" ) 
		with toEntidad
			for lnI = 1 to .Comprobantes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemComprobante" )
				this.SetearAtributoString( loItem, "Codigo", .Comprobantes.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "TipoCompCaracter", .Comprobantes.Item(lnI).TipoCompCaracter)
				this.SetearAtributoDatetime( loItem, "Fecha", .Comprobantes.Item(lnI).Fecha)
				this.SetearAtributoDecimal( loItem, "Total", .Comprobantes.Item(lnI).Total)
				this.SetearAtributoString( loItem, "Tipo", .Comprobantes.Item(lnI).Tipo)
				this.SetearAtributoString( loItem, "Interviniente", .Comprobantes.Item(lnI).Interviniente)
				this.SetearAtributoString( loItem, "Origen", .Comprobantes.Item(lnI).Origen)
				this.SetearAtributoInteger( loItem, "NroItem", .Comprobantes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Zadsfw", "CONVERT( VARCHAR(MAX), ZADSFW)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Referencia", "REFERENCIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaaltafw", "FALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horaaltafw", "HALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuarioaltafw", "UALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seriealtafw", "SALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatosaltafw", "BDALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Versionaltafw", "VALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechamodificacionfw", "FMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horamodificacionfw", "HMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuariomodificacionfw", "UMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seriemodificacionfw", "SMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatosmodificacionfw", "BDMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Versionmodificacionfw", "VMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaimpo", "FECIMPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horaimpo", "HORAIMPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaexpo", "FECEXPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horaexpo", "HORAEXPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estadotransferencia", "ESTTRANS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechatransferencia", "FECTRANS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Zadsfw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Referencia LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Haltafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ualtafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Saltafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bdaltafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Valtafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hmodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Umodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Smodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bdmodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vmodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horaimpo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horaexpo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Esttrans LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine