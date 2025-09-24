
define class Din_EntidadDescuento_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Descuento"
	cClaseResponse = this.cNamespaceDTOs + ".DescuentoResponse"
	cClaseModelo = "DescuentoModelo"
	cEntidad = "Descuento"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DescuentoModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "DescuentoModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "DescuentoListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "DescuentoListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "DescuentoModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Inactivofw", toEntidad, "Inactivofw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Interaccion", toEntidad, "Interaccion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Espacioblanco", toEntidad, "Espacioblanco" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Orden", toEntidad, "Orden" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modofuncionamiento", toEntidad, "Modofuncionamiento" )
			this.SetearDetalleDescuentodetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentaje", toEntidad, "Porcentaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montomax", toEntidad, "Montomax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajemax", toEntidad, "Porcentajemax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horadesde", toEntidad, "Horadesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horahasta", toEntidad, "Horahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montodesde", toEntidad, "Montodesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montohasta", toEntidad, "Montohasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidaddesde", toEntidad, "Cantidaddesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cantidadhasta", toEntidad, "Cantidadhasta" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadesde", toEntidad, "Fechadesde" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechahasta", toEntidad, "Fechahasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dialu", toEntidad, "Dialu" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diama", toEntidad, "Diama" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diami", toEntidad, "Diami" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diaju", toEntidad, "Diaju" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diavi", toEntidad, "Diavi" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diasa", toEntidad, "Diasa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Diado", toEntidad, "Diado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Perfildesde", toEntidad, "Perfildesde" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Perfilhasta", toEntidad, "Perfilhasta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadesde", toEntidad, "Listadesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listahasta", toEntidad, "Listahasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Venddesde", toEntidad, "Venddesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendhasta", toEntidad, "Vendhasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_clasificacioncdesde", toEntidad, "Cliente_clasificacioncdesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_clasificacionchasta", toEntidad, "Cliente_clasificacionchasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_tipocdesde", toEntidad, "Cliente_tipocdesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_tipochasta", toEntidad, "Cliente_tipochasta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_categoriacdesde", toEntidad, "Cliente_categoriacdesde_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente_categoriachasta", toEntidad, "Cliente_categoriachasta_PK" )
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
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDescuentoDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DescuentoDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DescuentoDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DescuentoDetalle.LimpiarItem()
			else
				try
					toEntidad.DescuentoDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DescuentoDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Comprobante", toEntidad.DescuentoDetalle.oItem, "Comprobante" )
			toEntidad.DescuentoDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "INACTIVOFW", toEntidad.INACTIVOFW)
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "Interaccion", toEntidad.Interaccion)
			this.SetearAtributoString( toModeloResponse, "EspacioBlanco", toEntidad.EspacioBlanco)
			this.SetearAtributoInteger( toModeloResponse, "Orden", toEntidad.Orden)
			this.SetearAtributoInteger( toModeloResponse, "ModoFuncionamiento", toEntidad.ModoFuncionamiento)
			this.CargarColeccionModeloDescuentoDetalle( toModeloResponse, toEntidad )
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributoDecimal( toModeloResponse, "Porcentaje", toEntidad.Porcentaje)
			this.SetearAtributoDecimal( toModeloResponse, "MontoMax", toEntidad.MontoMax)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeMax", toEntidad.PorcentajeMax)
			this.SetearAtributoString( toModeloResponse, "HoraDesde", toEntidad.HoraDesde)
			this.SetearAtributoString( toModeloResponse, "HoraHasta", toEntidad.HoraHasta)
			this.SetearAtributoDecimal( toModeloResponse, "MontoDesde", toEntidad.MontoDesde)
			this.SetearAtributoDecimal( toModeloResponse, "MontoHasta", toEntidad.MontoHasta)
			this.SetearAtributoLong( toModeloResponse, "CantidadDesde", toEntidad.CantidadDesde)
			this.SetearAtributoLong( toModeloResponse, "CantidadHasta", toEntidad.CantidadHasta)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDesde", toEntidad.FechaDesde)
			this.SetearAtributoDateTime( toModeloResponse, "FechaHasta", toEntidad.FechaHasta)
			this.SetearAtributo( toModeloResponse, "DiaLu", toEntidad.DiaLu)
			this.SetearAtributo( toModeloResponse, "DiaMa", toEntidad.DiaMa)
			this.SetearAtributo( toModeloResponse, "DiaMi", toEntidad.DiaMi)
			this.SetearAtributo( toModeloResponse, "DiaJu", toEntidad.DiaJu)
			this.SetearAtributo( toModeloResponse, "DiaVi", toEntidad.DiaVi)
			this.SetearAtributo( toModeloResponse, "DiaSa", toEntidad.DiaSa)
			this.SetearAtributo( toModeloResponse, "DiaDo", toEntidad.DiaDo)
			this.SetearAtributoString( toModeloResponse, "PerfilDesde", toEntidad.PerfilDesde)
			this.SetearAtributoString( toModeloResponse, "PerfilHasta", toEntidad.PerfilHasta)
			this.SetearAtributoString( toModeloResponse, "ListaDesde", toEntidad.ListaDesde_PK)
			this.SetearAtributoString( toModeloResponse, "ListaHasta", toEntidad.ListaHasta_PK)
			this.SetearAtributoString( toModeloResponse, "VendDesde", toEntidad.VendDesde_PK)
			this.SetearAtributoString( toModeloResponse, "VendHasta", toEntidad.VendHasta_PK)
			this.SetearAtributoString( toModeloResponse, "Cliente_ClasificacionCDesde", toEntidad.Cliente_ClasificacionCDesde_PK)
			this.SetearAtributoString( toModeloResponse, "Cliente_ClasificacionCHasta", toEntidad.Cliente_ClasificacionCHasta_PK)
			this.SetearAtributoString( toModeloResponse, "Cliente_TipoCDesde", toEntidad.Cliente_TipoCDesde_PK)
			this.SetearAtributoString( toModeloResponse, "Cliente_TipoCHasta", toEntidad.Cliente_TipoCHasta_PK)
			this.SetearAtributoString( toModeloResponse, "Cliente_CategoriaCDesde", toEntidad.Cliente_CategoriaCDesde_PK)
			this.SetearAtributoString( toModeloResponse, "Cliente_CategoriaCHasta", toEntidad.Cliente_CategoriaCHasta_PK)
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
	protected function CargarColeccionModeloDescuentoDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DescuentoDetalle" ) 
		with toEntidad
			for lnI = 1 to .DescuentoDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDescuento" )
				this.SetearAtributoString( loItem, "Codigo", .DescuentoDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Comprobante", .DescuentoDetalle.Item(lnI).Comprobante)
				this.SetearAtributoInteger( loItem, "NroItem", .DescuentoDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Inactivofw", "INACTIVOFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), TOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Interaccion", "INTERA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Orden", "ORDEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modofuncionamiento", "FUNC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monto", "MONTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentaje", "PORCDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montomax", "MONTOMAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajemax", "PORCMAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horadesde", "HORDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horahasta", "HORHAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montodesde", "MONDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montohasta", "MONHAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidaddesde", "CANTDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cantidadhasta", "CANTHAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadesde", "FECDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechahasta", "FECHAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Dialu", "DIALU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diama", "DIAMA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diami", "DIAMI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diaju", "DIAJU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diavi", "DIAVI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diasa", "DIASA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Diado", "DIADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Perfildesde", "PERFDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Perfilhasta", "PERFHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadesde", "LISTDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listahasta", "LISTHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Venddesde", "VENDDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendhasta", "VENDHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente_clasificacioncdesde", "CLASCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente_clasificacionchasta", "CLASCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente_tipocdesde", "TIPOCDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente_tipochasta", "TIPOCHASTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente_categoriacdesde", "CATECDESDE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente_categoriachasta", "CATECHASTA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Des LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hordes LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Horhas LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Perfdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Perfhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Listdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Listhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Venddesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendhasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clascdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Claschasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipocdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipochasta LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catecdesde LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catechasta LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function EsEntidadDesactivable() as Boolean
		return .t.
	endfunc

enddefine