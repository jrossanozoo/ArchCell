
define class Din_EntidadCliente_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Cliente"
	cClaseResponse = this.cNamespaceDTOs + ".ClienteResponse"
	cClaseModelo = "ClienteModelo"
	cEntidad = "Cliente"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ClienteModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ClienteModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ClienteListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ClienteListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ClienteModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionfiscal", toEntidad, "Situacionfiscal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sitfiscaluruguay", toEntidad, "Sitfiscaluruguay" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rut", toEntidad, "Rut" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodocumento", toEntidad, "Tipodocumento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrodocumento", toEntidad, "Nrodocumento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sexo", toEntidad, "Sexo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Primernombre", toEntidad, "Primernombre" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Segundonombre", toEntidad, "Segundonombre" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Apellido", toEntidad, "Apellido" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombre", toEntidad, "Nombre" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Email", toEntidad, "Email" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idglobal", toEntidad, "Idglobal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Calle", toEntidad, "Calle" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Piso", toEntidad, "Piso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Departamento", toEntidad, "Departamento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Localidad", toEntidad, "Localidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigopostal", toEntidad, "Codigopostal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Provincia", toEntidad, "Provincia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pais", toEntidad, "Pais_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefono", toEntidad, "Telefono" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Movil", toEntidad, "Movil" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fax", toEntidad, "Fax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Paginaweb", toEntidad, "Paginaweb" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Transportista", toEntidad, "Transportista_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Listadeprecio", toEntidad, "Listadeprecio_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuentopreferente", toEntidad, "Descuentopreferente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Topectacte", toEntidad, "Topectacte" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condiciondepago", toEntidad, "Condiciondepago_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocli", toEntidad, "Tipocli_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categcli", toEntidad, "Categcli_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Recomendadopor", toEntidad, "Recomendadopor_PK" )
			this.SetearDetalleOtrasdirecciones( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechanacimiento", toEntidad, "Fechanacimiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estadocivil", toEntidad, "Estadocivil" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hijos", toEntidad, "Hijos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codnombrefantasia", toEntidad, "Codnombrefantasia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sujetovinculado", toEntidad, "Sujetovinculado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuitpais", toEntidad, "Cuitpais" )
			this.SetearDetalleExcluidootrapercep( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Excluidopercepcioniva", toEntidad, "Excluidopercepcioniva" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Vigenciahastaiva", toEntidad, "Vigenciahastaiva" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Percepcioniva", toEntidad, "Percepcioniva_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Excluidopercepcionganancias", toEntidad, "Excluidopercepcionganancias" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Vigenciahastagan", toEntidad, "Vigenciahastagan" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Situacionganancias", toEntidad, "Situacionganancias" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Percepcionganancias", toEntidad, "Percepcionganancias_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoconvenio", toEntidad, "Tipoconvenio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nroiibb", toEntidad, "Nroiibb" )
			this.SetearDetallePercepciones( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigosiprib", toEntidad, "Codigosiprib_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tasaceroporcen", toEntidad, "Tasaceroporcen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tasaceroaplica", toEntidad, "Tasaceroaplica" )
			this.SetearDetalleContacto( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleOtrasDirecciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "OtrasDirecciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"OtrasDirecciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.OtrasDirecciones.LimpiarItem()
			else
				try
					toEntidad.OtrasDirecciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.OtrasDirecciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Calle", toEntidad.OtrasDirecciones.oItem, "Calle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.OtrasDirecciones.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Piso", toEntidad.OtrasDirecciones.oItem, "Piso" )
			this.SetearAtributoModeloEnEntidad( loItem, "Departamento", toEntidad.OtrasDirecciones.oItem, "Departamento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Localidad", toEntidad.OtrasDirecciones.oItem, "Localidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Codigopostal", toEntidad.OtrasDirecciones.oItem, "CodigoPostal" )
			this.SetearAtributoModeloEnEntidad( loItem, "Provincia", toEntidad.OtrasDirecciones.oItem, "Provincia_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Provinciadetalle", toEntidad.OtrasDirecciones.oItem, "ProvinciaDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Pais", toEntidad.OtrasDirecciones.oItem, "Pais_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Paisdetalle", toEntidad.OtrasDirecciones.oItem, "PaisDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Telefono", toEntidad.OtrasDirecciones.oItem, "Telefono" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodireccion", toEntidad.OtrasDirecciones.oItem, "TipoDireccion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Notas", toEntidad.OtrasDirecciones.oItem, "Notas" )
			this.SetearAtributoModeloEnEntidad( loItem, "Preferente", toEntidad.OtrasDirecciones.oItem, "Preferente" )
			toEntidad.OtrasDirecciones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleExcluidoOtraPercep( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ExcluidoOtraPercep" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ExcluidoOtraPercep[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ExcluidoOtraPercep.LimpiarItem()
			else
				try
					toEntidad.ExcluidoOtraPercep.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ExcluidoOtraPercep.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.ExcluidoOtraPercep.oItem, "Codigo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Aplicacion", toEntidad.ExcluidoOtraPercep.oItem, "Aplicacion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipo", toEntidad.ExcluidoOtraPercep.oItem, "Tipo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentaje", toEntidad.ExcluidoOtraPercep.oItem, "Porcentaje" )
			toEntidad.ExcluidoOtraPercep.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePercepciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Percepciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Percepciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Percepciones.LimpiarItem()
			else
				try
					toEntidad.Percepciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Percepciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdiccion", toEntidad.Percepciones.oItem, "Jurisdiccion_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Jurisdicciondetalle", toEntidad.Percepciones.oItem, "JurisdiccionDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Resolucion", toEntidad.Percepciones.oItem, "Resolucion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Porcentaje", toEntidad.Percepciones.oItem, "Porcentaje" )
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fechaexpiracion", toEntidad.Percepciones.oItem, "FechaExpiracion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Excluido", toEntidad.Percepciones.oItem, "Excluido" )
			toEntidad.Percepciones.Actualizar()
			
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
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributo( toModeloResponse, "INACTIVOFW", toEntidad.INACTIVOFW)
			this.SetearAtributoInteger( toModeloResponse, "SituacionFiscal", toEntidad.SituacionFiscal_PK)
			this.SetearAtributoInteger( toModeloResponse, "SitFiscalUruguay", toEntidad.SitFiscalUruguay)
			this.SetearAtributoString( toModeloResponse, "CUIT", toEntidad.CUIT)
			this.SetearAtributoString( toModeloResponse, "RUT", toEntidad.RUT)
			this.SetearAtributoString( toModeloResponse, "TipoDocumento", toEntidad.TipoDocumento)
			this.SetearAtributoString( toModeloResponse, "NroDocumento", toEntidad.NroDocumento)
			this.SetearAtributoString( toModeloResponse, "Sexo", toEntidad.Sexo)
			this.SetearAtributoString( toModeloResponse, "PrimerNombre", toEntidad.PrimerNombre)
			this.SetearAtributoString( toModeloResponse, "SegundoNombre", toEntidad.SegundoNombre)
			this.SetearAtributoString( toModeloResponse, "Apellido", toEntidad.Apellido)
			this.SetearAtributoString( toModeloResponse, "Nombre", toEntidad.Nombre)
			this.SetearAtributoString( toModeloResponse, "EMail", toEntidad.EMail)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "idglobal", toEntidad.idglobal)
			this.SetearAtributoString( toModeloResponse, "Calle", toEntidad.Calle)
			this.SetearAtributoInteger( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Piso", toEntidad.Piso)
			this.SetearAtributoString( toModeloResponse, "Departamento", toEntidad.Departamento)
			this.SetearAtributoString( toModeloResponse, "Localidad", toEntidad.Localidad)
			this.SetearAtributoString( toModeloResponse, "CodigoPostal", toEntidad.CodigoPostal)
			this.SetearAtributoString( toModeloResponse, "Provincia", toEntidad.Provincia_PK)
			this.SetearAtributoString( toModeloResponse, "Pais", toEntidad.Pais_PK)
			this.SetearAtributoString( toModeloResponse, "Telefono", toEntidad.Telefono)
			this.SetearAtributoString( toModeloResponse, "Movil", toEntidad.Movil)
			this.SetearAtributoString( toModeloResponse, "Fax", toEntidad.Fax)
			this.SetearAtributoString( toModeloResponse, "PaginaWeb", toEntidad.PaginaWeb)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "Transportista", toEntidad.Transportista_PK)
			this.SetearAtributoString( toModeloResponse, "ListaDePrecio", toEntidad.ListaDePrecio_PK)
			this.SetearAtributoString( toModeloResponse, "DescuentoPreferente", toEntidad.DescuentoPreferente_PK)
			this.SetearAtributoDecimal( toModeloResponse, "TopeCtaCte", toEntidad.TopeCtaCte)
			this.SetearAtributoString( toModeloResponse, "CondicionDePago", toEntidad.CondicionDePago_PK)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion_PK)
			this.SetearAtributoString( toModeloResponse, "TipoCli", toEntidad.TipoCli_PK)
			this.SetearAtributoString( toModeloResponse, "CategCli", toEntidad.CategCli_PK)
			this.SetearAtributoString( toModeloResponse, "RecomendadoPor", toEntidad.RecomendadoPor_PK)
			this.CargarColeccionModeloOtrasDirecciones( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
			this.SetearAtributoDateTime( toModeloResponse, "FechaNacimiento", toEntidad.FechaNacimiento)
			this.SetearAtributoString( toModeloResponse, "EstadoCivil", toEntidad.EstadoCivil)
			this.SetearAtributoInteger( toModeloResponse, "Hijos", toEntidad.Hijos)
			this.SetearAtributoString( toModeloResponse, "CodNombreFantasia", toEntidad.CodNombreFantasia_PK)
			this.SetearAtributo( toModeloResponse, "SujetoVinculado", toEntidad.SujetoVinculado)
			this.SetearAtributoString( toModeloResponse, "CuitPais", toEntidad.CuitPais)
			this.CargarColeccionModeloExcluidoOtraPercep( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "ExcluidoPercepcionIVA", toEntidad.ExcluidoPercepcionIVA)
			this.SetearAtributoDateTime( toModeloResponse, "VigenciaHastaIva", toEntidad.VigenciaHastaIva)
			this.SetearAtributoString( toModeloResponse, "PercepcionIva", toEntidad.PercepcionIva_PK)
			this.SetearAtributo( toModeloResponse, "ExcluidoPercepcionGanancias", toEntidad.ExcluidoPercepcionGanancias)
			this.SetearAtributoDateTime( toModeloResponse, "VigenciaHastaGan", toEntidad.VigenciaHastaGan)
			this.SetearAtributoInteger( toModeloResponse, "SituacionGanancias", toEntidad.SituacionGanancias)
			this.SetearAtributoString( toModeloResponse, "PercepcionGanancias", toEntidad.PercepcionGanancias_PK)
			this.SetearAtributoInteger( toModeloResponse, "TipoConvenio", toEntidad.TipoConvenio)
			this.SetearAtributoLong( toModeloResponse, "NroIIBB", toEntidad.NroIIBB)
			this.CargarColeccionModeloPercepciones( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "CodigoSiprib", toEntidad.CodigoSiprib_PK)
			this.SetearAtributoDecimal( toModeloResponse, "TasaCeroPorcen", toEntidad.TasaCeroPorcen)
			this.SetearAtributo( toModeloResponse, "TasaCeroAplica", toEntidad.TasaCeroAplica)
			this.CargarColeccionModeloContacto( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloOtrasDirecciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "OtrasDirecciones" ) 
		with toEntidad
			for lnI = 1 to .OtrasDirecciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemOtrasdirecciones" )
				this.SetearAtributoString( loItem, "Codigo", .OtrasDirecciones.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Calle", .OtrasDirecciones.Item(lnI).Calle)
				this.SetearAtributoInteger( loItem, "Numero", .OtrasDirecciones.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "Piso", .OtrasDirecciones.Item(lnI).Piso)
				this.SetearAtributoString( loItem, "Departamento", .OtrasDirecciones.Item(lnI).Departamento)
				this.SetearAtributoString( loItem, "Localidad", .OtrasDirecciones.Item(lnI).Localidad)
				this.SetearAtributoString( loItem, "CodigoPostal", .OtrasDirecciones.Item(lnI).CodigoPostal)
				this.SetearAtributoString( loItem, "Provincia", .OtrasDirecciones.Item(lnI).Provincia_PK)
				this.SetearAtributoString( loItem, "ProvinciaDetalle", .OtrasDirecciones.Item(lnI).ProvinciaDetalle)
				this.SetearAtributoString( loItem, "Pais", .OtrasDirecciones.Item(lnI).Pais_PK)
				this.SetearAtributoString( loItem, "PaisDetalle", .OtrasDirecciones.Item(lnI).PaisDetalle)
				this.SetearAtributoString( loItem, "Telefono", .OtrasDirecciones.Item(lnI).Telefono)
				this.SetearAtributoString( loItem, "TipoDireccion", .OtrasDirecciones.Item(lnI).TipoDireccion_PK)
				this.SetearAtributoString( loItem, "Notas", .OtrasDirecciones.Item(lnI).Notas)
				this.SetearAtributo( loItem, "Preferente", .OtrasDirecciones.Item(lnI).Preferente)
				this.SetearAtributoInteger( loItem, "NroItem", .OtrasDirecciones.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloExcluidoOtraPercep( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ExcluidoOtraPercep" ) 
		with toEntidad
			for lnI = 1 to .ExcluidoOtraPercep.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemExcluidootrapercep" )
				this.SetearAtributoString( loItem, "CodigoCliente", .ExcluidoOtraPercep.Item(lnI).CodigoCliente)
				this.SetearAtributoString( loItem, "Codigo", .ExcluidoOtraPercep.Item(lnI).Codigo_PK)
				this.SetearAtributoString( loItem, "Aplicacion", .ExcluidoOtraPercep.Item(lnI).Aplicacion)
				this.SetearAtributoString( loItem, "Tipo", .ExcluidoOtraPercep.Item(lnI).Tipo_PK)
				this.SetearAtributoDecimal( loItem, "Porcentaje", .ExcluidoOtraPercep.Item(lnI).Porcentaje)
				this.SetearAtributoInteger( loItem, "NroItem", .ExcluidoOtraPercep.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPercepciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Percepciones" ) 
		with toEntidad
			for lnI = 1 to .Percepciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPercepciones" )
				this.SetearAtributoString( loItem, "codigo", .Percepciones.Item(lnI).codigo)
				this.SetearAtributoString( loItem, "Jurisdiccion", .Percepciones.Item(lnI).Jurisdiccion_PK)
				this.SetearAtributoString( loItem, "JurisdiccionDetalle", .Percepciones.Item(lnI).JurisdiccionDetalle)
				this.SetearAtributoString( loItem, "Resolucion", .Percepciones.Item(lnI).Resolucion)
				this.SetearAtributoDecimal( loItem, "Porcentaje", .Percepciones.Item(lnI).Porcentaje)
				this.SetearAtributoDatetime( loItem, "FechaExpiracion", .Percepciones.Item(lnI).FechaExpiracion)
				this.SetearAtributo( loItem, "Excluido", .Percepciones.Item(lnI).Excluido)
				this.SetearAtributoInteger( loItem, "NroItem", .Percepciones.Item(lnI).NroItem )
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
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemContacto" )
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
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Inactivofw", "INACTIVOFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionfiscal", "CLIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuit", "CLCUIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rut", "RUT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodocumento", "CLTIPODOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nrodocumento", "CLNRODOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sexo", "SEXO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Primernombre", "CLPRINOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Segundonombre", "CLSEGNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Apellido", "CLAPELL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombre", "CLNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Email", "CLEMAIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idglobal", "GLOBALID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Calle", "CLCALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numero", "CLNRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Piso", "CLPISO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Departamento", "CLDEPTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Localidad", "CLLOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigopostal", "CLCP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Provincia", "CLPRV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pais", "CLPAIS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefono", "CLTLF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Movil", "CLMOVIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fax", "CLFAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Paginaweb", "CLPAGEWEB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "CLVEND")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Transportista", "CLTRANS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Listadeprecio", "CLLISPREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuentopreferente", "CLCO_DTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Topectacte", "CLTOPECCTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condiciondepago", "CLCONDPAG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLCLAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocli", "CLTIPOCLI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categcli", "CLCATEGCLI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "CIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechanacimiento", "CLFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estadocivil", "ESTADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hijos", "HIJOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codnombrefantasia", "CLCODFANT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sujetovinculado", "CLSUJVINC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuitpais", "PCUIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Excluidopercepcioniva", "EXPERIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vigenciahastaiva", "VHASTAIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Percepcioniva", "CLPERTIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Excluidopercepcionganancias", "EXPERGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vigenciahastagan", "VHASTAGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Situacionganancias", "CLSITGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Percepcionganancias", "CLPERGAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoconvenio", "CLTIPCONV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nroiibb", "CLNROIIBB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigosiprib", "CLSIPRIB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tasaceroporcen", "PORCENTC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tasaceroaplica", "APLICATC")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sexo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clprinom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clsegnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clapell LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clemail LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Globalid LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcalle LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpiso LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cldepto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clloc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clprv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpais LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltlf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clmovil LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clfax LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpageweb LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clvend LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltrans LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cllisprec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clco_dto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcondpag LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clclas LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltipocli LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcategcli LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cimagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Estado LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcodfant LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pcuit LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpertiva LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clpergan LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clsiprib LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function EsEntidadDesactivable() as Boolean
		return .t.
	endfunc

enddefine