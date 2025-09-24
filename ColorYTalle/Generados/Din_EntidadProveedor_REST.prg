
define class Din_EntidadProveedor_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Proveedor"
	cClaseResponse = this.cNamespaceDTOs + ".ProveedorResponse"
	cClaseModelo = "ProveedorModelo"
	cEntidad = "Proveedor"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ProveedorModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ProveedorModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ProveedorListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ProveedorListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ProveedorModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Inactivofw", toEntidad, "Inactivofw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionfiscal", toEntidad, "Situacionfiscal_PK" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sitfiscaluruguay", toEntidad, "Sitfiscaluruguay" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rut", toEntidad, "Rut" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodocumento", toEntidad, "Tipodocumento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrodocumento", toEntidad, "Nrodocumento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombre", toEntidad, "Nombre" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Calle", toEntidad, "Calle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Piso", toEntidad, "Piso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Departamento", toEntidad, "Departamento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Localidad", toEntidad, "Localidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigopostal", toEntidad, "Codigopostal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Provincia", toEntidad, "Provincia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pais", toEntidad, "Pais_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Email", toEntidad, "Email" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefono", toEntidad, "Telefono" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movil", toEntidad, "Movil" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fax", toEntidad, "Fax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Paginaweb", toEntidad, "Paginaweb" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechanacimiento", toEntidad, "Fechanacimiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condiciondepago", toEntidad, "Condiciondepago_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecio", toEntidad, "Listadeprecio_PK" )
			this.SetearDetalleContacto( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Empleador", toEntidad, "Empleador" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sujetovinculado", toEntidad, "Sujetovinculado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoconvenio", toEntidad, "Tipoconvenio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nroiibb", toEntidad, "Nroiibb" )
			this.SetearDetalleRetenciones( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigosiprib", toEntidad, "Codigosiprib_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tasaceroporcen", toEntidad, "Tasaceroporcen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tasaceroaplica", toEntidad, "Tasaceroaplica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Excluidoretencionganancias", toEntidad, "Excluidoretencionganancias" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Vigenciahastagan", toEntidad, "Vigenciahastagan" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionganancias", toEntidad, "Situacionganancias" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Retencionganancias", toEntidad, "Retencionganancias_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Excluidoretencioniva", toEntidad, "Excluidoretencioniva" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Vigenciahastaiva", toEntidad, "Vigenciahastaiva" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Objetoiva", toEntidad, "Objetoiva" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Retencioniva", toEntidad, "Retencioniva_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Excluidoretencionsuss", toEntidad, "Excluidoretencionsuss" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Retencionsuss", toEntidad, "Retencionsuss_PK" )
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
	protected function SetearDetalleContacto( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Contacto" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Contacto[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Contacto.LimpiarItem()
			else
				try
					toEntidad.Contacto.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Contacto.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Nombre", toEntidad.Contacto.oItem, "Nombre" )
			this.SetearAtributoModeloEnEntidad( loItem, "Telefonos", toEntidad.Contacto.oItem, "Telefonos" )
			this.SetearAtributoModeloEnEntidad( loItem, "Email", toEntidad.Contacto.oItem, "Email" )
			this.SetearAtributoModeloEnEntidad( loItem, "Notas", toEntidad.Contacto.oItem, "Notas" )
			toEntidad.Contacto.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleRetenciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Retenciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Retenciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Retenciones.LimpiarItem()
			else
				try
					toEntidad.Retenciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Retenciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdiccion", toEntidad.Retenciones.oItem, "Jurisdiccion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdicciondetalle", toEntidad.Retenciones.oItem, "JurisdiccionDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Resolucion", toEntidad.Retenciones.oItem, "Resolucion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentaje", toEntidad.Retenciones.oItem, "Porcentaje" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaexpiracion", toEntidad.Retenciones.oItem, "FechaExpiracion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Excluido", toEntidad.Retenciones.oItem, "Excluido" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sedeextrajuris", toEntidad.Retenciones.oItem, "SedeExtraJuris" )
			toEntidad.Retenciones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributo( toModeloResponse, "INACTIVOFW", toEntidad.INACTIVOFW)
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.SetearAtributoInteger( toModeloResponse, "SituacionFiscal", toEntidad.SituacionFiscal_PK)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "SitFiscalUruguay", toEntidad.SitFiscalUruguay)
			this.SetearAtributoString( toModeloResponse, "CUIT", toEntidad.CUIT)
			this.SetearAtributoString( toModeloResponse, "RUT", toEntidad.RUT)
			this.SetearAtributoString( toModeloResponse, "TipoDocumento", toEntidad.TipoDocumento)
			this.SetearAtributoString( toModeloResponse, "NroDocumento", toEntidad.NroDocumento)
			this.SetearAtributoString( toModeloResponse, "Nombre", toEntidad.Nombre)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Calle", toEntidad.Calle)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Piso", toEntidad.Piso)
			this.SetearAtributoString( toModeloResponse, "Departamento", toEntidad.Departamento)
			this.SetearAtributoString( toModeloResponse, "Localidad", toEntidad.Localidad)
			this.SetearAtributoString( toModeloResponse, "CodigoPostal", toEntidad.CodigoPostal)
			this.SetearAtributoString( toModeloResponse, "Provincia", toEntidad.Provincia_PK)
			this.SetearAtributoString( toModeloResponse, "Pais", toEntidad.Pais_PK)
			this.SetearAtributoString( toModeloResponse, "EMail", toEntidad.EMail)
			this.SetearAtributoString( toModeloResponse, "Telefono", toEntidad.Telefono)
			this.SetearAtributoString( toModeloResponse, "Movil", toEntidad.Movil)
			this.SetearAtributoString( toModeloResponse, "Fax", toEntidad.Fax)
			this.SetearAtributoString( toModeloResponse, "PaginaWeb", toEntidad.PaginaWeb)
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
			this.SetearAtributoDateTime( toModeloResponse, "FechaNacimiento", toEntidad.FechaNacimiento)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion_PK)
			this.SetearAtributoString( toModeloResponse, "CondicionDePago", toEntidad.CondicionDePago_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecio", toEntidad.ListaDePrecio_PK)
			this.CargarColeccionModeloContacto( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Empleador", toEntidad.Empleador)
			this.SetearAtributo( toModeloResponse, "SujetoVinculado", toEntidad.SujetoVinculado)
			this.SetearAtributoInteger( toModeloResponse, "TipoConvenio", toEntidad.TipoConvenio)
			this.SetearAtributoLong( toModeloResponse, "NroIIBB", toEntidad.NroIIBB)
			this.CargarColeccionModeloRetenciones( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "CodigoSiprib", toEntidad.CodigoSiprib_PK)
			this.SetearAtributoDecimal( toModeloResponse, "TasaCeroPorcen", toEntidad.TasaCeroPorcen)
			this.SetearAtributo( toModeloResponse, "TasaCeroAplica", toEntidad.TasaCeroAplica)
			this.SetearAtributo( toModeloResponse, "ExcluidoRetencionGanancias", toEntidad.ExcluidoRetencionGanancias)
			this.SetearAtributoDateTime( toModeloResponse, "VigenciaHastaGan", toEntidad.VigenciaHastaGan)
			this.SetearAtributoInteger( toModeloResponse, "SituacionGanancias", toEntidad.SituacionGanancias)
			this.SetearAtributoString( toModeloResponse, "RetencionGanancias", toEntidad.RetencionGanancias_PK)
			this.SetearAtributo( toModeloResponse, "ExcluidoRetencionIVA", toEntidad.ExcluidoRetencionIVA)
			this.SetearAtributoDateTime( toModeloResponse, "VigenciaHastaIva", toEntidad.VigenciaHastaIva)
			this.SetearAtributoInteger( toModeloResponse, "ObjetoIva", toEntidad.ObjetoIva)
			this.SetearAtributoString( toModeloResponse, "RetencionIva", toEntidad.RetencionIva_PK)
			this.SetearAtributo( toModeloResponse, "ExcluidoRetencionSUSS", toEntidad.ExcluidoRetencionSUSS)
			this.SetearAtributoString( toModeloResponse, "RetencionSuss", toEntidad.RetencionSuss_PK)
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
	protected function CargarColeccionModeloContacto( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Contacto" ) 
		with toEntidad
			for lnI = 1 to .Contacto.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemContactoprov" )
				this.SetearAtributoString( loItem, "Codigo", .Contacto.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Nombre", .Contacto.Item(lnI).Nombre)
				this.SetearAtributoString( loItem, "Telefonos", .Contacto.Item(lnI).Telefonos)
				this.SetearAtributoString( loItem, "Email", .Contacto.Item(lnI).Email)
				this.SetearAtributoString( loItem, "Notas", .Contacto.Item(lnI).Notas)
				this.SetearAtributoInteger( loItem, "NroItem", .Contacto.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloRetenciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Retenciones" ) 
		with toEntidad
			for lnI = 1 to .Retenciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemRetenciones" )
				this.SetearAtributoString( loItem, "codigo", .Retenciones.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Jurisdiccion", .Retenciones.Item(lnI).Jurisdiccion_PK)
				this.SetearAtributoString( loItem, "JurisdiccionDetalle", .Retenciones.Item(lnI).JurisdiccionDetalle)
				this.SetearAtributoString( loItem, "Resolucion", .Retenciones.Item(lnI).Resolucion)
				this.SetearAtributoDecimal( loItem, "Porcentaje", .Retenciones.Item(lnI).Porcentaje)
				this.SetearAtributoDatetime( loItem, "FechaExpiracion", .Retenciones.Item(lnI).FechaExpiracion)
				this.SetearAtributo( loItem, "Excluido", .Retenciones.Item(lnI).Excluido)
				this.SetearAtributo( loItem, "SedeExtraJuris", .Retenciones.Item(lnI).SedeExtraJuris)
				this.SetearAtributoInteger( loItem, "NroItem", .Retenciones.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionfiscal", "CLIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuit", "CLCUIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rut", "RUT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodocumento", "CLTIPODOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nrodocumento", "CLNRODOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombre", "CLNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Calle", "PCALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "PNUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Piso", "PPISO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Departamento", "PDEPTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Localidad", "CLLOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigopostal", "CLCP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Provincia", "CLPRV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pais", "PPAIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Email", "CLEMAIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefono", "CLTLF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Movil", "TLFM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fax", "CLFAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Paginaweb", "CLPAGEWEB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "CIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechanacimiento", "CLFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condiciondepago", "CLCONDPAG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecio", "CLLISTPRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Empleador", "CLEMPLEAD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sujetovinculado", "CLSUJVINC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoconvenio", "CLTIPCONV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nroiibb", "CLNROIIBB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigosiprib", "CLSIPRIB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tasaceroporcen", "PORCENTC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tasaceroaplica", "APLICATC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Excluidoretencionganancias", "EXRETGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vigenciahastagan", "PVHASTAGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionganancias", "CLSITGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Retencionganancias", "CLRETGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Excluidoretencioniva", "EXRETIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vigenciahastaiva", "PVHASTAIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Objetoiva", "CLOBJIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Retencioniva", "CLRETIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Excluidoretencionsuss", "EXRETSUSS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Retencionsuss", "CLRETSUSS")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcuit LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rut LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltipodoc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnrodoc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pcalle LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ppiso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pdepto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clloc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clprv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ppais LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clemail LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltlf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tlfm LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clfax LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpageweb LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cimagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clas LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcondpag LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cllistpre LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clsiprib LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clretgan LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clretiva LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clretsuss LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function EsEntidadDesactivable() as Boolean
		return .t.
	endfunc

enddefine