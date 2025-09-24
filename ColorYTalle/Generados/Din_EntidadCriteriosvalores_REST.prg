
define class Din_EntidadCriteriosvalores_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Criteriosvalores"
	cClaseResponse = this.cNamespaceDTOs + ".CriteriosvaloresResponse"
	cClaseModelo = "CriteriosvaloresModelo"
	cEntidad = "Criteriosvalores"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numero" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numero = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numero = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "CriteriosvaloresModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CriteriosvaloresModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CriteriosvaloresListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CriteriosvaloresListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CriteriosvaloresModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comportamiento", toEntidad, "Comportamiento" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechamodificacionfw", toEntidad, "Fechamodificacionfw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horamodificacionfw", toEntidad, "Horamodificacionfw" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Vigenciadesde", toEntidad, "Vigenciadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Vigenciahasta", toEntidad, "Vigenciahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horadesde", toEntidad, "Horadesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horahasta", toEntidad, "Horahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dialu", toEntidad, "Dialu" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diama", toEntidad, "Diama" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diami", toEntidad, "Diami" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diaju", toEntidad, "Diaju" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diavi", toEntidad, "Diavi" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diasa", toEntidad, "Diasa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diado", toEntidad, "Diado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipo", toEntidad, "Tipo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valor", toEntidad, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuotas", toEntidad, "Cuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadarticulosdesde", toEntidad, "Cantidadarticulosdesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadarticuloshasta", toEntidad, "Cantidadarticuloshasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totaldesde", toEntidad, "Totaldesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Totalhasta", toEntidad, "Totalhasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodescuentodesde", toEntidad, "Montodescuentodesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodescuentohasta", toEntidad, "Montodescuentohasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuentodesde", toEntidad, "Porcentajedescuentodesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajedescuentohasta", toEntidad, "Porcentajedescuentohasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montorecargodesde", toEntidad, "Montorecargodesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montorecargohasta", toEntidad, "Montorecargohasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajerecargodesde", toEntidad, "Porcentajerecargodesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajerecargohasta", toEntidad, "Porcentajerecargohasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursaldesde", toEntidad, "Sucursaldesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursalhasta", toEntidad, "Sucursalhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecios", toEntidad, "Listadeprecios_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAgrupublidetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Agrupublidetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Agrupublidetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Agrupublidetalle.LimpiarItem()
			else
				try
					toEntidad.Agrupublidetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Agrupublidetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.Agrupublidetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.SetearAtributoString( toModeloResponse, "NUMERO", toEntidad.NUMERO)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "Comportamiento", toEntidad.Comportamiento)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDateTime( toModeloResponse, "FechaModificacionFW", toEntidad.FechaModificacionFW)
			this.SetearAtributoString( toModeloResponse, "HoraModificacionFW", toEntidad.HoraModificacionFW)
			this.SetearAtributoDateTime( toModeloResponse, "VigenciaDesde", toEntidad.VigenciaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "VigenciaHasta", toEntidad.VigenciaHasta)
			this.SetearAtributoString( toModeloResponse, "HoraDesde", toEntidad.HoraDesde)
			this.SetearAtributoString( toModeloResponse, "HoraHasta", toEntidad.HoraHasta)
			this.SetearAtributo( toModeloResponse, "DiaLu", toEntidad.DiaLu)
			this.SetearAtributo( toModeloResponse, "DiaMa", toEntidad.DiaMa)
			this.SetearAtributo( toModeloResponse, "DiaMi", toEntidad.DiaMi)
			this.SetearAtributo( toModeloResponse, "DiaJu", toEntidad.DiaJu)
			this.SetearAtributo( toModeloResponse, "DiaVi", toEntidad.DiaVi)
			this.SetearAtributo( toModeloResponse, "DiaSa", toEntidad.DiaSa)
			this.SetearAtributo( toModeloResponse, "DiaDo", toEntidad.DiaDo)
			this.SetearAtributoInteger( toModeloResponse, "Tipo", toEntidad.Tipo)
			this.SetearAtributoString( toModeloResponse, "Valor", toEntidad.Valor_PK)
			this.SetearAtributoInteger( toModeloResponse, "Cuotas", toEntidad.Cuotas)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoDecimal( toModeloResponse, "CantidadArticulosDesde", toEntidad.CantidadArticulosDesde)
			this.SetearAtributoDecimal( toModeloResponse, "CantidadArticulosHasta", toEntidad.CantidadArticulosHasta)
			this.SetearAtributoDecimal( toModeloResponse, "TotalDesde", toEntidad.TotalDesde)
			this.SetearAtributoDecimal( toModeloResponse, "TotalHasta", toEntidad.TotalHasta)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDescuentoDesde", toEntidad.MontoDescuentoDesde)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDescuentoHasta", toEntidad.MontoDescuentoHasta)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuentoDesde", toEntidad.PorcentajeDescuentoDesde)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeDescuentoHasta", toEntidad.PorcentajeDescuentoHasta)
			this.SetearAtributoDecimal( toModeloResponse, "MontoRecargoDesde", toEntidad.MontoRecargoDesde)
			this.SetearAtributoDecimal( toModeloResponse, "MontoRecargoHasta", toEntidad.MontoRecargoHasta)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeRecargoDesde", toEntidad.PorcentajeRecargoDesde)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeRecargoHasta", toEntidad.PorcentajeRecargoHasta)
			this.SetearAtributoString( toModeloResponse, "SucursalDesde", toEntidad.SucursalDesde_PK)
			this.SetearAtributoString( toModeloResponse, "SucursalHasta", toEntidad.SucursalHasta_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecios", toEntidad.ListaDePrecios_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAgrupublidetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Agrupublidetalle" ) 
		with toEntidad
			for lnI = 1 to .Agrupublidetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAgrupapublic" )
				this.SetearAtributoString( loItem, "Codigo", .Agrupublidetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Agrupamiento", .Agrupublidetalle.Item(lnI).Agrupamiento_PK)
				this.SetearAtributoString( loItem, "AgrupamientoDetalle", .Agrupublidetalle.Item(lnI).AgrupamientoDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Agrupublidetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CDESC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comportamiento", "COMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechamodificacionfw", "FMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horamodificacionfw", "HMODIFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vigenciadesde", "VDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vigenciahasta", "VHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horadesde", "HORADESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horahasta", "HORAHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Dialu", "DIALU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diama", "DIAMA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diami", "DIAMI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diaju", "DIAJU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diavi", "DIAVI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diasa", "DIASA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diado", "DIADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipo", "CLCFI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valor", "JJCO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuotas", "CUOTAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadarticulosdesde", "CANTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadarticuloshasta", "CANTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Totaldesde", "TOTALDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Totalhasta", "TOTALHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodescuentodesde", "DESDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodescuentohasta", "DESHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedescuentodesde", "FPODESD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajedescuentohasta", "FPODESH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montorecargodesde", "RECDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montorecargohasta", "RECHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajerecargodesde", "FPORECD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajerecargohasta", "FPORECH")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sucursaldesde", "SUCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sucursalhasta", "SUCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecios", "CODLISTA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Numero LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cdesc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hmodifw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horadesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horahasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Jjco LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Suchasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codlista LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine