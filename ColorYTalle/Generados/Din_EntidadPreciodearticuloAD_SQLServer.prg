
define class Din_EntidadPRECIODEARTICULOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_PRECIODEARTICULO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TimestampAlta, 14, 0) + ListaDePrecio + Articulo + Color + Talle]
	cExpresionCCPorCampos = [str( #tabla#.TimestampA, 14, 0) + #tabla#.LISTAPRE + #tabla#.ARTICULO + #tabla#.cColor + #tabla#.Talle]
	cTagClaveCandidata = '_018CC'
	cTagClavePk = '_018PK'
	cTablaPrincipal = 'PRECIOAR'
	lRecibePorBulkCopy = .t.
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = ''
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ZooLogic'
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Destroy() as boolean

		with this
		endwith

		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Insertar() as boolean

		local loError as Exception, loEx as Exception, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxPrecioarFmodifw, lxPrecioarDescfw, lxPrecioarHmodifw, lxPrecioarEntori, lxPrecioarCodori, lxPrecioarAgregapre, lxPrecioarTimestamp, lxPrecioarPdirori, lxPrecioarSobrepre, lxPrecioarCodigo, lxPrecioarArticulo, lxPrecioarCcolor, lxPrecioarTalle, lxPrecioarListapre, lxPrecioarPdirecto, lxPrecioarBloqueo, lxPrecioarObs, lxPrecioarFechavig, lxPrecioarTimestampa
				lxPrecioarFmodifw =  .Fechamodificacionfw			lxPrecioarDescfw =  .Descripcionfw			lxPrecioarHmodifw =  .Horamodificacionfw			lxPrecioarEntori =  .Entidadorigen			lxPrecioarCodori =  .Codigoorigen			lxPrecioarAgregapre =  .Agregadoalprecio			lxPrecioarTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecioarPdirori =  .Preciodirectooriginal			lxPrecioarSobrepre =  .Sobreprecio			lxPrecioarCodigo =  .Codigo			lxPrecioarArticulo =  upper( .Articulo_PK ) 			lxPrecioarCcolor =  upper( .Color_PK ) 			lxPrecioarTalle =  upper( .Talle_PK ) 			lxPrecioarListapre =  upper( .ListaDePrecio_PK ) 			lxPrecioarPdirecto =  .Preciodirecto			lxPrecioarBloqueo =  .Bloqueo			lxPrecioarObs =  .Obs			lxPrecioarFechavig =  .Fechavigencia			lxPrecioarTimestampa =  .Timestampalta
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxPrecioarCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.PRECIOAR ( "Fmodifw","Descfw","Hmodifw","Entori","Codori","Agregapre","Timestamp","Pdirori","Sobrepre","Codigo","Articulo","Ccolor","Talle","Listapre","Pdirecto","Bloqueo","Obs","Fechavig","Timestampa" ) values ( <<"'" + this.ConvertirDateSql( lxPrecioarFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarEntori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarCodori ) + "'" >>, <<lxPrecioarAgregapre >>, <<lxPrecioarTimestamp >>, <<lxPrecioarPdirori >>, <<lxPrecioarSobrepre >>, <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarArticulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarListapre ) + "'" >>, <<lxPrecioarPdirecto >>, <<iif( lxPrecioarBloqueo, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPrecioarObs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecioarFechavig ) + "'" >>, <<lxPrecioarTimestampa >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			dodefault()
			this.AntesEndTransaction()
			this.VerificarInsercionUnicidadAntesDelCommit( lxValorClavePrimaria )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			this.FinalDeTransaction()
		
			lnI = this.nReintentos
		
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar grabar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar grabar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar grabar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxPrecioarTimestamp
		endwith

		endfor
		
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarUnicidad() as void
		local lcError as string
		lcError = ''
		If this.ConsultarPorClavePrimaria()
			lcError = this.oEntidad.ReasignarValorSugeridoEnCasoDeConcurrencia()
		else
			If this.ConsultarPorClaveCandidata()
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxPrecioarFmodifw, lxPrecioarDescfw, lxPrecioarHmodifw, lxPrecioarEntori, lxPrecioarCodori, lxPrecioarAgregapre, lxPrecioarTimestamp, lxPrecioarPdirori, lxPrecioarSobrepre, lxPrecioarCodigo, lxPrecioarArticulo, lxPrecioarCcolor, lxPrecioarTalle, lxPrecioarListapre, lxPrecioarPdirecto, lxPrecioarBloqueo, lxPrecioarObs, lxPrecioarFechavig, lxPrecioarTimestampa
				lxPrecioarFmodifw =  .Fechamodificacionfw			lxPrecioarDescfw =  .Descripcionfw			lxPrecioarHmodifw =  .Horamodificacionfw			lxPrecioarEntori =  .Entidadorigen			lxPrecioarCodori =  .Codigoorigen			lxPrecioarAgregapre =  .Agregadoalprecio			lxPrecioarTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecioarPdirori =  .Preciodirectooriginal			lxPrecioarSobrepre =  .Sobreprecio			lxPrecioarCodigo =  .Codigo			lxPrecioarArticulo =  upper( .Articulo_PK ) 			lxPrecioarCcolor =  upper( .Color_PK ) 			lxPrecioarTalle =  upper( .Talle_PK ) 			lxPrecioarListapre =  upper( .ListaDePrecio_PK ) 			lxPrecioarPdirecto =  .Preciodirecto			lxPrecioarBloqueo =  .Bloqueo			lxPrecioarObs =  .Obs			lxPrecioarFechavig =  .Fechavigencia			lxPrecioarTimestampa =  .Timestampalta
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.EntidadOrigen != .oEntidad.EntidadOrigen or  .oEntidad.oAtributosAuditoria.CodigoOrigen != .oEntidad.CodigoOrigen or  .oEntidad.oAtributosAuditoria.PrecioDirectoOriginal != .oEntidad.PrecioDirectoOriginal or  .oEntidad.oAtributosAuditoria.PrecioDirecto != .oEntidad.PrecioDirecto or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaVigencia) != this.ConvertirDateSql( .oEntidad.FechaVigencia) )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.PRECIOAR set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPrecioarFmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxPrecioarDescfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxPrecioarHmodifw ) + "'">>,"Entori" = <<"'" + this.FormatearTextoSql( lxPrecioarEntori ) + "'">>,"Codori" = <<"'" + this.FormatearTextoSql( lxPrecioarCodori ) + "'">>,"Agregapre" = <<lxPrecioarAgregapre>>,"Timestamp" = <<lxPrecioarTimestamp>>,"Pdirori" = <<lxPrecioarPdirori>>,"Sobrepre" = <<lxPrecioarSobrepre>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'">>,"Articulo" = <<"'" + this.FormatearTextoSql( lxPrecioarArticulo ) + "'">>,"Ccolor" = <<"'" + this.FormatearTextoSql( lxPrecioarCcolor ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxPrecioarTalle ) + "'">>,"Listapre" = <<"'" + this.FormatearTextoSql( lxPrecioarListapre ) + "'">>,"Pdirecto" = <<lxPrecioarPdirecto>>,"Bloqueo" = <<iif( lxPrecioarBloqueo, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxPrecioarObs ) + "'">>,"Fechavig" = <<"'" + this.ConvertirDateSql( lxPrecioarFechavig ) + "'">>,"Timestampa" = <<lxPrecioarTimestampa>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'">> and  PRECIOAR.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
			dodefault()
			this.AntesEndTransaction()
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			lnI = this.nReintentos
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar actualizar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar actualizar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar actualizar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Modificacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Modificacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxPrecioarTimestamp
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValidarTimestamp() as void
		Local lnTimestamp as integer
		if !this.oEntidad.lEsSubentidad
			lnTimestamp = this.ObtenerTimestampActual()
			if this.oEntidad.Timestamp = lnTimestamp 
			else 
				local loEx as Object
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Message = 'Error al intentar Grabar'
					.Details = 'No se puede grabar, el registro ha cambiado'
					.Grabar()
					.Throw()
				endwith
			endif
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.PRECIOAR where " + this.ConvertirFuncionesSql( " PRECIOAR.CODIGO != ''" ) )
			this.xmlacursor( lcXml, 'c_HayDatos' )
			llHayDatos = reccount( 'c_HayDatos' ) > 0 
			use in select('c_HayDatos')
		return llHayDatos
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClavePrimaria( tlLlenarAtributos as Boolean ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxPrecioarCodigo
			lxPrecioarCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta" from ZooLogic.PRECIOAR where "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'">> and  PRECIOAR.CODIGO != ''
			endtext
			use in select('c_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRECIODEARTICULO', set( 'Datasession' ) )

			if reccount( 'c_PRECIODEARTICULO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxPRECIOARTimestampA As Variant, lxPRECIOARLISTAPRE As Variant, lxPRECIOARARTICULO As Variant, lxPRECIOARcColor As Variant, lxPRECIOARTalle As Variant
			lxPRECIOARTimestampA = .TimestampAlta
			lxPRECIOARLISTAPRE = .ListaDePrecio_Pk
			lxPRECIOARARTICULO = .Articulo_Pk
			lxPRECIOARcColor = .Color_Pk
			lxPRECIOARTalle = .Talle_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta" from ZooLogic.PRECIOAR where  PRECIOAR.CODIGO != '' And TimestampA = <<lxPRECIOARTimestampA>> and LISTAPRE = <<"'" + this.FormatearTextoSql( lxPRECIOARLISTAPRE ) + "'">> and ARTICULO = <<"'" + this.FormatearTextoSql( lxPRECIOARARTICULO ) + "'">> and cColor = <<"'" + this.FormatearTextoSql( lxPRECIOARcColor ) + "'">> and Talle = <<"'" + this.FormatearTextoSql( lxPRECIOARTalle ) + "'">>
			endtext
			use in select('c_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRECIODEARTICULO', set( 'Datasession' ) )
			if reccount( 'c_PRECIODEARTICULO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxPrecioarCodigo as Variant
		llRetorno = .t.
		lxPrecioarCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.PRECIOAR where "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'">> and  PRECIOAR.CODIGO != ''
			endtext
			use in select('c_VerificarExistencia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VerificarExistencia', set( 'Datasession' ) )

			if c_VerificarExistencia.CantidadDeRegistros = 0
				llRetorno = .f.
			endif
			use in select( 'c_VerificarExistencia' )
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Primero() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .TimestampAlta, 14, 0) + .ListaDePrecio_PK + .Articulo_PK + .Color_PK + .Talle_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta" from ZooLogic.PRECIOAR where  PRECIOAR.CODIGO != '' order by TimestampA,LISTAPRE,ARTICULO,cColor,Talle
			endtext
			use in select('c_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRECIODEARTICULO', set( 'Datasession' ) )
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Siguiente() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .TimestampAlta, 14, 0) + .ListaDePrecio_PK + .Articulo_PK + .Color_PK + .Talle_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta" from ZooLogic.PRECIOAR where  str( TimestampA, 14, 0) + funciones.padr( LISTAPRE, 6, ' ' ) + funciones.padr( ARTICULO, 15, ' ' ) + funciones.padr( cColor, 6, ' ' ) + funciones.padr( Talle, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PRECIOAR.CODIGO != '' order by TimestampA,LISTAPRE,ARTICULO,cColor,Talle
			endtext
			use in select('c_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRECIODEARTICULO', set( 'Datasession' ) )
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Anterior() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .TimestampAlta, 14, 0) + .ListaDePrecio_PK + .Articulo_PK + .Color_PK + .Talle_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta" from ZooLogic.PRECIOAR where  str( TimestampA, 14, 0) + funciones.padr( LISTAPRE, 6, ' ' ) + funciones.padr( ARTICULO, 15, ' ' ) + funciones.padr( cColor, 6, ' ' ) + funciones.padr( Talle, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  PRECIOAR.CODIGO != '' order by TimestampA desc,LISTAPRE desc,ARTICULO desc,cColor desc,Talle desc
			endtext
			use in select('c_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRECIODEARTICULO', set( 'Datasession' ) )
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Ultimo() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .TimestampAlta, 14, 0) + .ListaDePrecio_PK + .Articulo_PK + .Color_PK + .Talle_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta" from ZooLogic.PRECIOAR where  PRECIOAR.CODIGO != '' order by TimestampA desc,LISTAPRE desc,ARTICULO desc,cColor desc,Talle desc
			endtext
			use in select('c_PRECIODEARTICULO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PRECIODEARTICULO', set( 'Datasession' ) )
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorAtributoSecundario( tcAtributo ) as Boolean
		local lxValor as variant, llRetorno as boolean, lcXml as string , lcNombreCursor as string, lcAtributo as String, lcatributoPK as string
		lcNombreCursor = 'c_' + sys( 2015 )
		llRetorno = .t.
		lcAtributo = upper( tcAtributo )
		with this
			lcCampo = .ObtenerCampoEntidad( lcAtributo )
			lxValor = .oEntidad.&lcAtributo
			lcFiltroCodigo = ''
			if !.oentidad.EsNuevo() and .oEntidad.EsEdicion()
				lcatributoPK = .oEntidad.cAtributoPK
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Descfw,Hmodifw,Entori,Codori,Agregapre,Timestamp,Pdirori,Sobrepre,Codigo,Articulo,Cc" + ;
"olor,Talle,Listapre,Pdirecto,Bloqueo,Obs,Fechavig,Timestampa" + ;
" from ZooLogic.PRECIOAR where  PRECIOAR.CODIGO != '' and " + lcFiltro )
			this.xmlacursor( lcXml, lcNombreCursor )
			if reccount( lcNombreCursor ) = 0
				llRetorno = .f.
			endif
			use in select( lcNombreCursor )
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Eliminar() As Boolean
		local loError as Exception, loEx as Exception, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg
		with this.oEntidad
			local  lxPrecioarFmodifw, lxPrecioarDescfw, lxPrecioarHmodifw, lxPrecioarEntori, lxPrecioarCodori, lxPrecioarAgregapre, lxPrecioarTimestamp, lxPrecioarPdirori, lxPrecioarSobrepre, lxPrecioarCodigo, lxPrecioarArticulo, lxPrecioarCcolor, lxPrecioarTalle, lxPrecioarListapre, lxPrecioarPdirecto, lxPrecioarBloqueo, lxPrecioarObs, lxPrecioarFechavig, lxPrecioarTimestampa
				lxPrecioarFmodifw = ctod( '  /  /    ' )			lxPrecioarDescfw = []			lxPrecioarHmodifw = []			lxPrecioarEntori = []			lxPrecioarCodori = []			lxPrecioarAgregapre = 0			lxPrecioarTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecioarPdirori = 0			lxPrecioarSobrepre = 0			lxPrecioarCodigo = []			lxPrecioarArticulo = []			lxPrecioarCcolor = []			lxPrecioarTalle = []			lxPrecioarListapre = []			lxPrecioarPdirecto = 0			lxPrecioarBloqueo = .F.			lxPrecioarObs = []			lxPrecioarFechavig = ctod( '  /  /    ' )			lxPrecioarTimestampa = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.PRECIOAR where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			lnI = this.nReintentos
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar eliminar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar eliminar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar eliminar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Eliminacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Eliminacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		Finally
			this.SetearConexionGlobal()
		EndTry

		endwith
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function LlenarArrayMemo( tcCampo as String, tcAtributo as String, txValorClavePrimaria as variant ) as void 
		local lcMemos as String, lxCodigo as variant, lcCodigo as string, lnTotalMemos as integer, lcAtributo as string, lcTabla as string, lcValor as string, lnElemento as string, i as integer, lnCortar as integer, lnIndice as Integer

		lcAtributo = alltrim(tcAtributo)
		with this
			lcValor = rtrim( .oEntidad.&lcAtributo )
			lcTabla = 'PRECIOAR' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PRECIOAR.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PRECIOAR', '', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoEntidad( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ENTIDADORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTORI AS ENTIDADORIGEN'
				Case lcAtributo == 'CODIGOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODORI AS CODIGOORIGEN'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'AGREGADOALPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGREGAPRE AS AGREGADOALPRECIO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'PRECIODIRECTOORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDIRORI AS PRECIODIRECTOORIGINAL'
				Case lcAtributo == 'SOBREPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SOBREPRE AS SOBREPRECIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTICULO AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'LISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTAPRE AS LISTADEPRECIO'
				Case lcAtributo == 'PRECIODIRECTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PDIRECTO AS PRECIODIRECTO'
				Case lcAtributo == 'BLOQUEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQUEO AS BLOQUEO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'FECHAVIGENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVIG AS FECHAVIGENCIA'
				Case lcAtributo == 'TIMESTAMPALTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMPA AS TIMESTAMPALTA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADORIGEN'
				lcCampo = 'ENTORI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORIGEN'
				lcCampo = 'CODORI'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'AGREGADOALPRECIO'
				lcCampo = 'AGREGAPRE'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIODIRECTOORIGINAL'
				lcCampo = 'PDIRORI'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREPRECIO'
				lcCampo = 'SOBREPRE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIO'
				lcCampo = 'LISTAPRE'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIODIRECTO'
				lcCampo = 'PDIRECTO'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEO'
				lcCampo = 'BLOQUEO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVIGENCIA'
				lcCampo = 'FECHAVIG'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMPALTA'
				lcCampo = 'TIMESTAMPA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPrecioarFmodifw, lxPrecioarDescfw, lxPrecioarHmodifw, lxPrecioarEntori, lxPrecioarCodori, lxPrecioarAgregapre, lxPrecioarTimestamp, lxPrecioarPdirori, lxPrecioarSobrepre, lxPrecioarCodigo, lxPrecioarArticulo, lxPrecioarCcolor, lxPrecioarTalle, lxPrecioarListapre, lxPrecioarPdirecto, lxPrecioarBloqueo, lxPrecioarObs, lxPrecioarFechavig, lxPrecioarTimestampa
				lxPrecioarFmodifw =  .Fechamodificacionfw			lxPrecioarDescfw =  .Descripcionfw			lxPrecioarHmodifw =  .Horamodificacionfw			lxPrecioarEntori =  .Entidadorigen			lxPrecioarCodori =  .Codigoorigen			lxPrecioarAgregapre =  .Agregadoalprecio			lxPrecioarTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecioarPdirori =  .Preciodirectooriginal			lxPrecioarSobrepre =  .Sobreprecio			lxPrecioarCodigo =  .Codigo			lxPrecioarArticulo =  upper( .Articulo_PK ) 			lxPrecioarCcolor =  upper( .Color_PK ) 			lxPrecioarTalle =  upper( .Talle_PK ) 			lxPrecioarListapre =  upper( .ListaDePrecio_PK ) 			lxPrecioarPdirecto =  .Preciodirecto			lxPrecioarBloqueo =  .Bloqueo			lxPrecioarObs =  .Obs			lxPrecioarFechavig =  .Fechavigencia			lxPrecioarTimestampa =  .Timestampalta
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.PRECIOAR ( "Fmodifw","Descfw","Hmodifw","Entori","Codori","Agregapre","Timestamp","Pdirori","Sobrepre","Codigo","Articulo","Ccolor","Talle","Listapre","Pdirecto","Bloqueo","Obs","Fechavig","Timestampa" ) values ( <<"'" + this.ConvertirDateSql( lxPrecioarFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarEntori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarCodori ) + "'" >>, <<lxPrecioarAgregapre >>, <<lxPrecioarTimestamp >>, <<lxPrecioarPdirori >>, <<lxPrecioarSobrepre >>, <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarArticulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarCcolor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxPrecioarListapre ) + "'" >>, <<lxPrecioarPdirecto >>, <<iif( lxPrecioarBloqueo, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxPrecioarObs ) + "'" >>, <<"'" + this.ConvertirDateSql( lxPrecioarFechavig ) + "'" >>, <<lxPrecioarTimestampa >> )
		endtext
		loColeccion.cTabla = 'PRECIOAR' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxPrecioarFmodifw, lxPrecioarDescfw, lxPrecioarHmodifw, lxPrecioarEntori, lxPrecioarCodori, lxPrecioarAgregapre, lxPrecioarTimestamp, lxPrecioarPdirori, lxPrecioarSobrepre, lxPrecioarCodigo, lxPrecioarArticulo, lxPrecioarCcolor, lxPrecioarTalle, lxPrecioarListapre, lxPrecioarPdirecto, lxPrecioarBloqueo, lxPrecioarObs, lxPrecioarFechavig, lxPrecioarTimestampa
				lxPrecioarFmodifw =  .Fechamodificacionfw			lxPrecioarDescfw =  .Descripcionfw			lxPrecioarHmodifw =  .Horamodificacionfw			lxPrecioarEntori =  .Entidadorigen			lxPrecioarCodori =  .Codigoorigen			lxPrecioarAgregapre =  .Agregadoalprecio			lxPrecioarTimestamp = goLibrerias.ObtenerTimestamp()			lxPrecioarPdirori =  .Preciodirectooriginal			lxPrecioarSobrepre =  .Sobreprecio			lxPrecioarCodigo =  .Codigo			lxPrecioarArticulo =  upper( .Articulo_PK ) 			lxPrecioarCcolor =  upper( .Color_PK ) 			lxPrecioarTalle =  upper( .Talle_PK ) 			lxPrecioarListapre =  upper( .ListaDePrecio_PK ) 			lxPrecioarPdirecto =  .Preciodirecto			lxPrecioarBloqueo =  .Bloqueo			lxPrecioarObs =  .Obs			lxPrecioarFechavig =  .Fechavigencia			lxPrecioarTimestampa =  .Timestampalta
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.EntidadOrigen != .oEntidad.EntidadOrigen or  .oEntidad.oAtributosAuditoria.CodigoOrigen != .oEntidad.CodigoOrigen or  .oEntidad.oAtributosAuditoria.PrecioDirectoOriginal != .oEntidad.PrecioDirectoOriginal or  .oEntidad.oAtributosAuditoria.PrecioDirecto != .oEntidad.PrecioDirecto or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaVigencia) != this.ConvertirDateSql( .oEntidad.FechaVigencia) )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PRECIOAR.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.PRECIOAR set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxPrecioarFmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxPrecioarDescfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxPrecioarHmodifw ) + "'">>, "Entori" = <<"'" + this.FormatearTextoSql( lxPrecioarEntori ) + "'">>, "Codori" = <<"'" + this.FormatearTextoSql( lxPrecioarCodori ) + "'">>, "Agregapre" = <<lxPrecioarAgregapre>>, "Timestamp" = <<lxPrecioarTimestamp>>, "Pdirori" = <<lxPrecioarPdirori>>, "Sobrepre" = <<lxPrecioarSobrepre>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxPrecioarCodigo ) + "'">>, "Articulo" = <<"'" + this.FormatearTextoSql( lxPrecioarArticulo ) + "'">>, "Ccolor" = <<"'" + this.FormatearTextoSql( lxPrecioarCcolor ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxPrecioarTalle ) + "'">>, "Listapre" = <<"'" + this.FormatearTextoSql( lxPrecioarListapre ) + "'">>, "Pdirecto" = <<lxPrecioarPdirecto>>, "Bloqueo" = <<iif( lxPrecioarBloqueo, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxPrecioarObs ) + "'">>, "Fechavig" = <<"'" + this.ConvertirDateSql( lxPrecioarFechavig ) + "'">>, "Timestampa" = <<lxPrecioarTimestampa>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'PRECIOAR' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasDelete() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		local llInsertarAuditoria as Boolean
		llInsertarAuditoria = .t.
		If llInsertarAuditoria

	*--------------------------------------------------------------------------------------------------------
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  PRECIOAR.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.PRECIOAR where ' + lcFiltro )
			loColeccion.cTabla = 'PRECIOAR' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.PRECIOAR where  PRECIOAR.CODIGO != ''" )
			this.xmlacursor( lcXml, 'c_CantReg' )
		lnCantReg = c_CantReg.Total
		use in select('c_CantReg')
		return lnCantReg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTimestampActual() as integer
		local lnTimeStamp as integer, lcCursor as string
		lnTimeStamp = 0
		lcCursor = sys(2015)

			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.PRECIOAR where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  PRECIOAR.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxPRECIOAREntori as variant, lxPRECIOARCodori as variant, lxPRECIOARPDIRORI as variant, lxPRECIOARARTICULO as variant, lxPRECIOARcColor as variant, lxPRECIOARTalle as variant, lxPRECIOARLISTAPRE as variant, lxPRECIOARPDIRECTO as variant, lxPRECIOARFECHAVIG as variant, lxPRECIOARTimestampA as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PRECIODEARTICULO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.PRECIOAR Where  TimestampA = ] + transform( &lcCursor..TimestampA ) + [ and LISTAPRE = ] + "'" + this.FormatearTextoSql( &lcCursor..LISTAPRE   ) + "'" + [ and ARTICULO = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTICULO   ) + "'" + [ and cColor = ] + "'" + this.FormatearTextoSql( &lcCursor..cColor     ) + "'" + [ and Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle      ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						local llInsertarAuditoria as boolean
						llInsertarAuditoria = (  iif( isnull( curSeek.Entori != &lcCursor..Entori ), .F., curSeek.Entori != &lcCursor..Entori ) or  iif( isnull( curSeek.Codori != &lcCursor..Codori ), .F., curSeek.Codori != &lcCursor..Codori ) or  iif( isnull( curSeek.PDIRORI != &lcCursor..PDIRORI ), .F., curSeek.PDIRORI != &lcCursor..PDIRORI ) or  iif( isnull( curSeek.PDIRECTO != &lcCursor..PDIRECTO ), .F., curSeek.PDIRECTO != &lcCursor..PDIRECTO ) or  iif( isnull( ( curSeek.FECHAVIG != &lcCursor..FECHAVIG ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FECHAVIG ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FECHAVIG ) ) ) ), .F., ( curSeek.FECHAVIG != &lcCursor..FECHAVIG ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FECHAVIG ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FECHAVIG ) ) ) ) )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.PRECIOAR set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Entori = ] + "'" + this.FormatearTextoSql( &lcCursor..Entori ) + "'"+ [, Codori = ] + "'" + this.FormatearTextoSql( &lcCursor..Codori ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, AGREGAPRE = ] + transform( &lcCursor..AGREGAPRE )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, PDIRORI = ] + transform( &lcCursor..PDIRORI )+ [, SOBREPRE = ] + transform( &lcCursor..SOBREPRE )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, ARTICULO = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTICULO ) + "'"+ [, cColor = ] + "'" + this.FormatearTextoSql( &lcCursor..cColor ) + "'"+ [, Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'"+ [, LISTAPRE = ] + "'" + this.FormatearTextoSql( &lcCursor..LISTAPRE ) + "'"+ [, PDIRECTO = ] + transform( &lcCursor..PDIRECTO )+ [, BLOQUEO = ] + Transform( iif( &lcCursor..BLOQUEO, 1, 0 ))+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, FECHAVIG = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'"+ [, TimestampA = ] + transform( &lcCursor..TimestampA ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
						if llInsertarAuditoria
							lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
							this.oConexion.EjecutarSql( lcSentencia )
						EndIf
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.PRECIOAR Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FALTAFW, FECTRANS, FECIMPO, FECEXPO, HALTAFW, HORAEXPO, HORAIMPO, SALTAFW, ZADSFW, DescFW, VMODIFW, UMODIFW, VALTAFW, SMODIFW, UALTAFW, HMODIFW, ESTTRANS, Entori, Codori, BDALTAFW, BDMODIFW, AGREGAPRE, TIMESTAMP, PDIRORI, SOBREPRE, CODIGO, ARTICULO, cColor, Talle, LISTAPRE, PDIRECTO, BLOQUEO, Obs, FECHAVIG, TimestampA
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Entori ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codori ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..AGREGAPRE ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..PDIRORI ) + ',' + transform( &lcCursor..SOBREPRE ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTICULO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cColor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LISTAPRE ) + "'" + ',' + transform( &lcCursor..PDIRECTO ) + ',' + Transform( iif( &lcCursor..BLOQUEO, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAVIG ) + "'" + ',' + transform( &lcCursor..TimestampA )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.PRECIOAR ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
					this.oConexion.EjecutarSql( lcSentencia )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'PRECIODEARTICULO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (46) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Lista de precio: ' + transform( &tcCursor..LISTAPRE   )
		lcRetorno = lcRetorno + ' - Artículo: ' + transform( &tcCursor..ARTICULO   )
		lcRetorno = lcRetorno + ' - Color: ' + transform( &tcCursor..cColor     )
		lcRetorno = lcRetorno + ' - Talle: ' + transform( &tcCursor..Talle      )
		Return lcRetorno
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteTransferencia( tcTablaTrabajo ) as String
		local lcCadena as String, lcTabla as String, lcEntidad as String, loLogueo as Object, lcDescripcionFW as string
		lcTabla = alltrim( Upper( tcTablaTrabajo ) )
		loLogueo = this.oLogueo.oInfoLog
		lcEntidad = alltrim( Upper( This.oEntidad.ObtenerNombre() ) )
		lcDescripcionFW = ""
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin

		endtext
	if This.ActualizaEnRecepcion()
		Text to lcCadena noshow textmerge additive
				insert into ZooLogic.ADT_PRECIOAR ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CODIGO","ARTICULO","cColor","Talle","LISTAPRE","TimestampA","Entori","Codori","Pdirori","Pdirecto","Fechavig" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then '' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codigo,d.Articulo,d.Ccolor,d.Talle,d.Listapre,d.Timestampa,Isnull( d.Entori,t.Entori),Isnull( d.Codori,t.Codori),Isnull( t.PDIRECTO,t.Pdirori),Isnull( d.Pdirecto,t.Pdirecto),Isnull( d.Fechavig,t.Fechavig)
						from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and ( ( d.FMODIFW > t.FMODIFW ) or ( d.FMODIFW = t.FMODIFW and d.HMODIFW>t.HMODIFW )  )
					where ( d.Entori is not null and d.Entori <> t.Entori ) or ( d.Codori is not null and d.Codori <> t.Codori ) or ( d.PDIRORI is not null and d.PDIRORI <> t.PDIRORI ) or ( d.PDIRECTO is not null and d.PDIRECTO <> t.PDIRECTO ) or ( d.FECHAVIG is not null and d.FECHAVIG <> t.FECHAVIG )
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ENTORI = isnull( d.ENTORI, t.ENTORI ),t.CODORI = isnull( d.CODORI, t.CODORI ),t.AGREGAPRE = isnull( d.AGREGAPRE, t.AGREGAPRE ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.PDIRORI = isnull( d.PDIRORI, t.PDIRORI ),t.SOBREPRE = isnull( d.SOBREPRE, t.SOBREPRE ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.ARTICULO = isnull( d.ARTICULO, t.ARTICULO ),t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.LISTAPRE = isnull( d.LISTAPRE, t.LISTAPRE ),t.PDIRECTO = isnull( d.PDIRECTO, t.PDIRECTO ),t.BLOQUEO = isnull( d.BLOQUEO, t.BLOQUEO ),t.OBS = isnull( d.OBS, t.OBS ),t.FECHAVIG = isnull( d.FECHAVIG, t.FECHAVIG ),t.TIMESTAMPA = isnull( d.TIMESTAMPA, t.TIMESTAMPA )
					from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and ( ( d.FMODIFW > t.FMODIFW ) or ( d.FMODIFW = t.FMODIFW and d.HMODIFW>t.HMODIFW )  )
				-- Fin Updates

		endtext
	else
		Text to lcCadena noshow textmerge additive
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Recepción <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>', '<<loLogueo.OrigenLogueo>>','<<lcEntidad>> -  TIMESTAMP ' + cast( d.TimestampA as Varchar(14) ) + ' -  LISTA DE PRECIO ' + cast( d.LISTAPRE as Varchar(6) ) + ' -  ARTÍCULO ' + cast( d.ARTICULO as Varchar(15) ) + ' -  COLOR ' + cast( d.cColor as Varchar(6) ) + ' -  TALLE ' + cast( d.Talle as Varchar(5) ) + ' no se pudo recibir porque ya existe y el mismo no actualiza en recepción.', ''
					from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.TimestampA = d.TimestampA
							 and  t.LISTAPRE = d.LISTAPRE
							 and  t.ARTICULO = d.ARTICULO
							 and  t.cColor = d.cColor
							 and  t.Talle = d.Talle

		endtext
	endif
		Text to lcCadena noshow textmerge additive
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Recepción <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>', '<<loLogueo.OrigenLogueo>>','<<lcEntidad>> -  TIMESTAMP ' + cast( d.TimestampA as Varchar(14) ) + ' -  LISTA DE PRECIO ' + cast( d.LISTAPRE as Varchar(6) ) + ' -  ARTÍCULO ' + cast( d.ARTICULO as Varchar(15) ) + ' -  COLOR ' + cast( d.cColor as Varchar(6) ) + ' -  TALLE ' + cast( d.Talle as Varchar(5) ) + ' recibido ( alta ).', ''
						From deleted d left join ZooLogic.PRECIOAR pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PRECIOAR cc 
							 on  d.TimestampA = cc.TimestampA
							 and  d.LISTAPRE = cc.LISTAPRE
							 and  d.ARTICULO = cc.ARTICULO
							 and  d.cColor = cc.cColor
							 and  d.Talle = cc.Talle
						Where pk.CODIGO Is Null 
							 and cc.TimestampA Is Null 
							 and cc.LISTAPRE Is Null 
							 and cc.ARTICULO Is Null 
							 and cc.cColor Is Null 
							 and cc.Talle Is Null 
				insert into ZooLogic.PRECIOAR(Fmodifw,Descfw,Hmodifw,Entori,Codori,Agregapre,Timestamp,Pdirori,Sobrepre,Codigo,Articulo,Ccolor,Talle,Listapre,Pdirecto,Bloqueo,Obs,Fechavig,Timestampa)
					Select isnull( d.FMODIFW,''),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),isnull( d.ENTORI,''),isnull( d.CODORI,''),isnull( d.AGREGAPRE,0),isnull( d.TIMESTAMP,0),isnull( d.PDIRORI,0),isnull( d.SOBREPRE,0),isnull( d.CODIGO,''),isnull( d.ARTICULO,''),isnull( d.CCOLOR,''),isnull( d.TALLE,''),isnull( d.LISTAPRE,''),isnull( d.PDIRECTO,0),isnull( d.BLOQUEO,0),isnull( d.OBS,''),isnull( d.FECHAVIG,''),[funciones].ObtenerTimestamp() + row_number() OVER (ORDER BY d.CODIGO)
						From deleted d left join ZooLogic.PRECIOAR pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PRECIOAR cc 
							 on  d.TimestampA = cc.TimestampA
							 and  d.LISTAPRE = cc.LISTAPRE
							 and  d.ARTICULO = cc.ARTICULO
							 and  d.cColor = cc.cColor
							 and  d.Talle = cc.Talle
						Where pk.CODIGO Is Null 
							 and cc.TimestampA Is Null 
							 and cc.LISTAPRE Is Null 
							 and cc.ARTICULO Is Null 
							 and cc.cColor Is Null 
							 and cc.Talle Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIMESTAMP ' + cast( d.TimestampA as Varchar(14) ) + ', LISTA DE PRECIO ' + cast( d.LISTAPRE as Varchar(6) ) + ', ARTÍCULO ' + cast( d.ARTICULO as Varchar(15) ) + ', COLOR ' + cast( d.cColor as Varchar(6) ) + ', TALLE ' + cast( d.Talle as Varchar(5) ) + '','La clave principal no es la esperada'
					from ZooLogic.PRECIOAR t inner join deleted d 
							on   t.TimestampA = d.TimestampA
							 and  t.LISTAPRE = d.LISTAPRE
							 and  t.ARTICULO = d.ARTICULO
							 and  t.cColor = d.cColor
							 and  t.Talle = d.Talle
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIMESTAMP ' + cast( d.TimestampA as Varchar(14) ) + ', LISTA DE PRECIO ' + cast( d.LISTAPRE as Varchar(6) ) + ', ARTÍCULO ' + cast( d.ARTICULO as Varchar(15) ) + ', COLOR ' + cast( d.cColor as Varchar(6) ) + ', TALLE ' + cast( d.Talle as Varchar(5) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.TimestampA = h.TimestampA
							 and   t.LISTAPRE = h.LISTAPRE
							 and   t.ARTICULO = h.ARTICULO
							 and   t.cColor = h.cColor
							 and   t.Talle = h.Talle
							where   h.TimestampA is null 
							 and   h.LISTAPRE is null 
							 and   h.ARTICULO is null 
							 and   h.cColor is null 
							 and   h.Talle is null 
			End
		EndText
		Return lcCadena
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'PRECIODEARTICULO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'PRECIODEARTICULO_OBS'
				llRetorno = .T.
		EndCase
		Return llRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function ImportarTablaDeTrabajo( toConexion as Object ) As Void
		local llEjecutarRollback as Boolean
		llEjecutarRollback = .F.
		try
			do While this.nCantVeces > 0
				this.nCantVeces = this.nCantVeces - 1

				this.InicializarMensajesConexion()

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_PRECIOAR')

				if this.oMensajesConexion.Count>0
					goServicios.Errores.LevantarExcepcion( this.ObtenerMensajesConexion() )
				endif

			enddo
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplicarReglaDeNegocioTablaDeTrabajo( toConexion as Object ) As Void
		local llEjecutarRollback as Boolean, lcCursor as String, llNoVienePorDiseño as Boolean
		llEjecutarRollback = .F.
		try
			
			toConexion.EjecutarNonQuery( 'DISABLE TRIGGER ALL ON ZooLogic.TablaTrabajo_PRECIOAR' )
			
			lcCursor = this.oentidad.cprefijoimportar + this.oentidad.cnombre
			this.AbrirCursores( PcXmlDatos, this.oEntidad.cPrefijoImportar )
			select (lcCursor)
			
			*** Valor sugerido PrecioDirecto
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRECIODEARTICULO", "", "PrecioDirecto" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_PRECIOAR SET PDIRECTO = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( PDIRECTO ) = 1" )
			endif
			
			*** Valor sugerido Obs
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRECIODEARTICULO", "", "Obs" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_PRECIOAR SET Obs = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( Obs ) = 1" )
			endif
			
			*** Valor sugerido FechaVigencia
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PRECIODEARTICULO", "", "FechaVigencia" )
			if !empty( NVL( lcExpresionValorSugeridoDefinidoPorElUsuario, "" ) )
				lvValor = &lcExpresionValorSugeridoDefinidoPorElUsuario
				toConexion.EjecutarNonQuery( "UPDATE ZooLogic.TablaTrabajo_PRECIOAR SET FECHAVIG = " + golibrerias.ValorAStringSegunTipoBase( lvValor  ) + " WHERE Funciones.Empty( FECHAVIG ) = 1" )
			endif
			
			use in ( lcCursor )
			
			lcInsertBaseLogueo = [INSERT INTO ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, EstadoDelSistema, Aplicacion, Version, Serie, Usuario, NombrePc, UsuarioPc, OrigenLogueo, Mensaje, Excepcion ) ]
			lcCamposLogueo = [Fecha, Nivel, Logger, Accion, BaseDeDatos, EstadoDelSistema, Aplicacion, Version, Serie, Usuario, NombrePc, UsuarioPc, OrigenLogueo, Excepcion, Mensaje]
			lcBD = goServicios.Seguridad.cBaseDeDatosSeleccionada
			lcApp = _Screen.Zoo.App.Nombre
			lcVersion = _Screen.Zoo.App.ObtenerVersion()
			lcSerie = _Screen.Zoo.App.cSerie
			lcUsuario = goServicios.Seguridad.cUsuarioLogueado
			lcValuesLogueoComunes = [SELECT GetDate(), 'INFO', '', 'Validacion IMPO','] + lcBD + [',0,'] + lcApp + [','] + lcVersion + [','] + lcSerie  + [','] + lcUsuario +[','NOMBREPC','USUARIOPC','ORIGENLOGUEO','',]
			
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_PRECIOAR','ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR', 'FMODIFW', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_PRECIOAR','ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR', 'FALTAFW', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_PRECIOAR','ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR', 'FECTRANS', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_PRECIOAR','ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR', 'FECIMPO', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fecha( 'ZooLogic.TablaTrabajo_PRECIOAR','ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR', 'FECEXPO', toConexion )
			this.oEntidad.oValidacionDominios.ValidarDominioBloqueImportacion_Fechacalendario( 'ZooLogic.TablaTrabajo_PRECIOAR','ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR', 'FECHAVIG', toConexion )

			* Articulo obligatorio y FK 
			lcWhere = 'WHERE Funciones.Empty( ARTICULO ) = 1 or ARTICULO NOT IN ( SELECT ARTCOD from ZooLogic.ART )'
			lcExpresionMensaje  = [CASE WHEN Funciones.Empty( ARTICULO ) = 1 THEN 'Debe cargar el campo Articulo.' ELSE 'El dato buscado ' + RTRIM( CAST( ARTICULO AS VARCHAR(255) ) ) + ' de la entidad Articulo no existe.' END]
			this.ValidacionBasicaObligatorioFKArticulo( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) 

			* ListaDePrecio obligatorio y FK 
			lcWhere = 'WHERE Funciones.Empty( LISTAPRE ) = 1 or LISTAPRE NOT IN ( SELECT LPR_NUMERO from ZooLogic.LPRECIO )'
			lcExpresionMensaje  = [CASE WHEN Funciones.Empty( LISTAPRE ) = 1 THEN 'Debe cargar el campo ListaDePrecio.' ELSE 'El dato buscado ' + RTRIM( CAST( LISTAPRE AS VARCHAR(255) ) ) + ' de la entidad ListaDePrecios no existe.' END]
			this.ValidacionBasicaObligatorioFKListaDePrecio( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) 

			* FechaVigencia obligatorio
			lcWhere = 'WHERE Funciones.Empty( FECHAVIG ) = 1 '
			lcExpresionMensaje  = [CASE WHEN Funciones.Empty( FECHAVIG ) = 1 THEN 'Debe cargar el campo FechaVigencia.' ELSE 'El dato buscado ' + RTRIM( CAST( FECHAVIG AS VARCHAR(255) ) ) + ' de la entidad  no existe.' END]
			this.ValidacionBasicaObligatorioFKFechaVigencia( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) 

			* Color FK 
			lcWhere = 'WHERE Funciones.Empty( cColor ) = 0 AND  cColor NOT IN ( SELECT COLCOD FROM ZooLogic.COL )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( cColor AS VARCHAR(255) ) ) + ' de la entidad COLOR no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
			
			* Talle FK 
			lcWhere = 'WHERE Funciones.Empty( Talle ) = 0 AND  Talle NOT IN ( SELECT Codigo FROM ZooLogic.Talle )'
			lcExpresionMensaje  = ['El dato buscado ' + RTRIM( CAST( Talle AS VARCHAR(255) ) ) + ' de la entidad TALLE no existe.']
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
			toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje  + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
			toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
			
			this.oEntidad.EjecutarReglaDeNegocioPersonalizadaImportacion( toConexion )
			toConexion.EjecutarNonQuery( 'ENABLE TRIGGER ALL ON ZooLogic.TablaTrabajo_PRECIOAR' )
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasicaObligatorioFKArticulo( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) as void
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
		toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasicaObligatorioFKListaDePrecio( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) as void
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
		toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasicaObligatorioFKFechaVigencia( toConexion, lcExpresionMensaje, lcWhere, lcCamposLogueo, lcValuesLogueoComunes ) as void
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.TablaTrabajoErroresValidacion_PRECIOAR ( NroLinea, Motivo ) SELECT NroLinea, ] + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
		toConexion.EjecutarNonQuery( [INSERT INTO ZooLogic.Logueos ( ] + lcCamposLogueo + [ ) ] + lcValuesLogueoComunes + lcExpresionMensaje + [ FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
		toConexion.EjecutarNonQuery( [DELETE FROM ZooLogic.TablaTrabajo_PRECIOAR ] + lcWhere )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	*--------------------------------------------------------------------------------------------------------
	protected function ValidarDatosAImportar() as boolean
		local lcCursor as String, llRetorno as boolean, lxVar as Variant, llCondicion as boolean
		lcCursor = This.oEntidad.cPrefijoImportar + 'PRECIODEARTICULO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..TimestampA ) or isnull( &lcCursor..LISTAPRE ) or isnull( &lcCursor..ARTICULO ) or isnull( &lcCursor..cColor ) or isnull( &lcCursor..Talle )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad PRECIODEARTICULO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		Locate for Pdirecto < 0
		if found()
			loInformacion = _screen.zoo.CrearObjeto( 'zooInformacion' )
			loInformacion.AgregarInformacion( 'No está permitido importar precios en negativo.' )
			llRetorno = .F.
			goservicios.Importaciones.oInformacionDeErroresEnImportacion = loInformacion
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PRECIODEARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( TimestampA, 14, 0) + LISTAPRE + ARTICULO + cColor + Talle as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( TimestampA, 14, 0) + LISTAPRE + ARTICULO + cColor + Talle, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PRECIODEARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECHAVIG  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PRECIOAR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PRECIOAR
Create Table ZooLogic.TablaTrabajo_PRECIOAR ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"entori" char( 40 )  null, 
"codori" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"agregapre" numeric( 15, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"pdirori" numeric( 15, 2 )  null, 
"sobrepre" numeric( 15, 2 )  null, 
"codigo" char( 46 )  null, 
"articulo" char( 15 )  null, 
"ccolor" char( 6 )  null, 
"talle" char( 5 )  null, 
"listapre" char( 6 )  null, 
"pdirecto" numeric( 15, 2 )  null, 
"bloqueo" bit  null, 
"obs" varchar(max)  null, 
"fechavig" datetime  null, 
"timestampa" numeric( 14, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_PRECIOAR' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_PRECIOAR' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearTablaDeTrabajoDetalles( toConexion as Object ) as void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'PRECIODEARTICULO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('entori','entori')
			.AgregarMapeo('codori','codori')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('agregapre','agregapre')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('pdirori','pdirori')
			.AgregarMapeo('sobrepre','sobrepre')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('articulo','articulo')
			.AgregarMapeo('ccolor','ccolor')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('listapre','listapre')
			.AgregarMapeo('pdirecto','pdirecto')
			.AgregarMapeo('bloqueo','bloqueo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fechavig','fechavig')
			.AgregarMapeo('timestampa','timestampa')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_PRECIOAR'
			.ConsultaOrigen = 'select * from ' + lcCursor
			Select( lcCursor )
			Count to This.nCantVeces
			This.nCantVeces = ceiling( This.nCantVeces / This.nCantABorrar )
			if !this.oEntidad.VerificarContexto( 'CB' )
				use in ( lcCursor )
			endif
			.ImportarMasivamente( toConexion )
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajoDetalles( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion( tcTablaTrabajo ) as String
		local lcCadena as String, lcTabla as String, lcEntidad as String, loLogueo as Object, lcDescripcionFW as string
		lcTabla = alltrim( Upper( tcTablaTrabajo ) )
		loLogueo = this.oLogueo.oInfoLog
		lcEntidad = alltrim( Upper( This.oEntidad.ObtenerNombre() ) )
		lcDescripcionFW = "IMPORTACION"
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_PRECIOAR ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CODIGO","ARTICULO","cColor","Talle","LISTAPRE","TimestampA","Entori","Codori","Pdirori","Pdirecto","Fechavig" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codigo,d.Articulo,d.Ccolor,d.Talle,d.Listapre,d.Timestampa,Isnull( d.Entori,t.Entori),Isnull( d.Codori,t.Codori),Isnull( t.PDIRECTO,t.Pdirori),Isnull( d.Pdirecto,t.Pdirecto),Isnull( d.Fechavig,t.Fechavig)
						from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.TimestampA = d.TimestampA
							 and  t.LISTAPRE = d.LISTAPRE
							 and  t.ARTICULO = d.ARTICULO
							 and  t.cColor = d.cColor
							 and  t.Talle = d.Talle
					where ( d.Entori is not null and d.Entori <> t.Entori ) or ( d.Codori is not null and d.Codori <> t.Codori ) or ( d.PDIRORI is not null and d.PDIRORI <> t.PDIRORI ) or ( d.PDIRECTO is not null and d.PDIRECTO <> t.PDIRECTO ) or ( d.FECHAVIG is not null and d.FECHAVIG <> t.FECHAVIG )
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ENTORI = isnull( d.ENTORI, t.ENTORI ),t.CODORI = isnull( d.CODORI, t.CODORI ),t.AGREGAPRE = isnull( d.AGREGAPRE, t.AGREGAPRE ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.PDIRORI = isnull( d.PDIRORI, t.PDIRORI ),t.SOBREPRE = isnull( d.SOBREPRE, t.SOBREPRE ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.ARTICULO = isnull( d.ARTICULO, t.ARTICULO ),t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.LISTAPRE = isnull( d.LISTAPRE, t.LISTAPRE ),t.PDIRECTO = isnull( d.PDIRECTO, t.PDIRECTO ),t.BLOQUEO = isnull( d.BLOQUEO, t.BLOQUEO ),t.OBS = isnull( d.OBS, t.OBS ),t.FECHAVIG = isnull( d.FECHAVIG, t.FECHAVIG ),t.TIMESTAMPA = isnull( d.TIMESTAMPA, t.TIMESTAMPA )
					from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.TimestampA = d.TimestampA
							 and  t.LISTAPRE = d.LISTAPRE
							 and  t.ARTICULO = d.ARTICULO
							 and  t.cColor = d.cColor
							 and  t.Talle = d.Talle
				-- Fin Updates
				insert into ZooLogic.ADT_PRECIOAR ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CODIGO","ARTICULO","cColor","Talle","LISTAPRE","TimestampA","Entori","Codori","Pdirori","Pdirecto","Fechavig" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Codigo,d.Articulo,d.Ccolor,d.Talle,d.Listapre,d.Timestampa,isnull( d.ENTORI,''),isnull( d.CODORI,''),isnull( d.PDIRORI,0),isnull( d.PDIRECTO,0),isnull( d.FECHAVIG,'')
						From deleted d left join ZooLogic.PRECIOAR pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PRECIOAR cc 
							 on  d.TimestampA = cc.TimestampA
							 and  d.LISTAPRE = cc.LISTAPRE
							 and  d.ARTICULO = cc.ARTICULO
							 and  d.cColor = cc.cColor
							 and  d.Talle = cc.Talle
						Where pk.CODIGO Is Null 
							 and cc.TimestampA Is Null 
							 and cc.LISTAPRE Is Null 
							 and cc.ARTICULO Is Null 
							 and cc.cColor Is Null 
							 and cc.Talle Is Null 
				insert into ZooLogic.PRECIOAR(Fmodifw,Descfw,Hmodifw,Entori,Codori,Agregapre,Timestamp,Pdirori,Sobrepre,Codigo,Articulo,Ccolor,Talle,Listapre,Pdirecto,Bloqueo,Obs,Fechavig,Timestampa)
					Select isnull( d.FMODIFW,''),isnull( d.DESCFW,''),isnull( d.HMODIFW,''),isnull( d.ENTORI,''),isnull( d.CODORI,''),isnull( d.AGREGAPRE,0),isnull( d.TIMESTAMP,0),isnull( d.PDIRORI,0),isnull( d.SOBREPRE,0),isnull( d.CODIGO,''),isnull( d.ARTICULO,''),isnull( d.CCOLOR,''),isnull( d.TALLE,''),isnull( d.LISTAPRE,''),isnull( d.PDIRECTO,0),isnull( d.BLOQUEO,0),isnull( d.OBS,''),isnull( d.FECHAVIG,''),[funciones].ObtenerTimestamp() + row_number() OVER (ORDER BY d.CODIGO)
						From deleted d left join ZooLogic.PRECIOAR pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.PRECIOAR cc 
							 on  d.TimestampA = cc.TimestampA
							 and  d.LISTAPRE = cc.LISTAPRE
							 and  d.ARTICULO = cc.ARTICULO
							 and  d.cColor = cc.cColor
							 and  d.Talle = cc.Talle
						Where pk.CODIGO Is Null 
							 and cc.TimestampA Is Null 
							 and cc.LISTAPRE Is Null 
							 and cc.ARTICULO Is Null 
							 and cc.cColor Is Null 
							 and cc.Talle Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIMESTAMP ' + cast( d.TimestampA as Varchar(14) ) + ', LISTA DE PRECIO ' + cast( d.LISTAPRE as Varchar(6) ) + ', ARTÍCULO ' + cast( d.ARTICULO as Varchar(15) ) + ', COLOR ' + cast( d.cColor as Varchar(6) ) + ', TALLE ' + cast( d.Talle as Varchar(5) ) + '','La clave principal no es la esperada'
					from ZooLogic.PRECIOAR t inner join deleted d 
							on   t.TimestampA = d.TimestampA
							 and  t.LISTAPRE = d.LISTAPRE
							 and  t.ARTICULO = d.ARTICULO
							 and  t.cColor = d.cColor
							 and  t.Talle = d.Talle
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIMESTAMP ' + cast( d.TimestampA as Varchar(14) ) + ', LISTA DE PRECIO ' + cast( d.LISTAPRE as Varchar(6) ) + ', ARTÍCULO ' + cast( d.ARTICULO as Varchar(15) ) + ', COLOR ' + cast( d.cColor as Varchar(6) ) + ', TALLE ' + cast( d.Talle as Varchar(5) ) + '','La clave principal a importar ya existe'
					from ZooLogic.PRECIOAR t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.TimestampA = h.TimestampA
							 and   t.LISTAPRE = h.LISTAPRE
							 and   t.ARTICULO = h.ARTICULO
							 and   t.cColor = h.cColor
							 and   t.Talle = h.Talle
							where   h.TimestampA is null 
							 and   h.LISTAPRE is null 
							 and   h.ARTICULO is null 
							 and   h.cColor is null 
							 and   h.Talle is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_PRECIOAR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_PRECIOAR
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_PRECIODEARTICULO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRECIODEARTICULO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRECIODEARTICULO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRECIODEARTICULO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRECIODEARTICULO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRECIODEARTICULO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_PRECIODEARTICULO.Horaaltafw, [] )
					.Horaexpo = nvl( c_PRECIODEARTICULO.Horaexpo, [] )
					.Horaimpo = nvl( c_PRECIODEARTICULO.Horaimpo, [] )
					.Seriealtafw = nvl( c_PRECIODEARTICULO.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_PRECIODEARTICULO.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_PRECIODEARTICULO.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_PRECIODEARTICULO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_PRECIODEARTICULO.Versionaltafw, [] )
					.Seriemodificacionfw = nvl( c_PRECIODEARTICULO.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_PRECIODEARTICULO.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_PRECIODEARTICULO.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_PRECIODEARTICULO.Estadotransferencia, [] )
					.Entidadorigen = nvl( c_PRECIODEARTICULO.Entidadorigen, [] )
					.Codigoorigen = nvl( c_PRECIODEARTICULO.Codigoorigen, [] )
					.Basededatosaltafw = nvl( c_PRECIODEARTICULO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_PRECIODEARTICULO.Basededatosmodificacionfw, [] )
					.Agregadoalprecio = nvl( c_PRECIODEARTICULO.Agregadoalprecio, 0 )
					.Timestamp = nvl( c_PRECIODEARTICULO.Timestamp, 0 )
					.Preciodirectooriginal = nvl( c_PRECIODEARTICULO.Preciodirectooriginal, 0 )
					.Sobreprecio = nvl( c_PRECIODEARTICULO.Sobreprecio, 0 )
					.Codigo = nvl( c_PRECIODEARTICULO.Codigo, [] )
					.Articulo_PK =  nvl( c_PRECIODEARTICULO.Articulo, [] )
					.Color_PK =  nvl( c_PRECIODEARTICULO.Color, [] )
					.Talle_PK =  nvl( c_PRECIODEARTICULO.Talle, [] )
					.Listadeprecio_PK =  nvl( c_PRECIODEARTICULO.Listadeprecio, [] )
					.Preciodirecto = nvl( c_PRECIODEARTICULO.Preciodirecto, 0 )
					.Bloqueo = nvl( c_PRECIODEARTICULO.Bloqueo, .F. )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Fechavigencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_PRECIODEARTICULO.Fechavigencia, ctod( '  /  /    ' ) ) )
					.Timestampalta = nvl( c_PRECIODEARTICULO.Timestampalta, 0 )
					Select c_PRECIODEARTICULO
					scatter name This.oEntidad.oAtributosAuditoria
				Catch To loError
					goServicios.Errores.LevantarExcepcion( loError )
				Finally
					.lCargando = .f.
				EndTry
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DespuesBeginTransaction() as Void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function AntesEndTransaction() as Void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function FinalDeTransaction() as Void
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string;
			, lcEntidad11 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( this.oEntidad.Articulo_pk ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( this.oEntidad.Color_pk ) + "'"
			lcEntidad4 = "'" + this.FormatearTextoSql( this.oEntidad.Talle_pk ) + "'"
			lcEntidad5 = "'" + this.FormatearTextoSql( this.oEntidad.Listadeprecio_pk ) + "'"
			lcEntidad6 = transform( this.oEntidad.Timestampalta )
			lcEntidad7 = "'" + this.FormatearTextoSql( this.oEntidad.Entidadorigen ) + "'"
			lcEntidad8 = "'" + this.FormatearTextoSql( this.oEntidad.Codigoorigen ) + "'"
			lcEntidad9 = transform( this.oEntidad.Preciodirectooriginal )
			lcEntidad10 = transform( this.oEntidad.Preciodirecto )
			lcEntidad11 = "'" + this.ConvertirDateSql( this.oEntidad.Fechavigencia ) + "'"
			
		else
			lxValorClavePrimaria = &tcCursor..CODIGO
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string, lcEntidad8 as string, lcEntidad9 as string, lcEntidad10 as string;
			, lcEntidad11 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = "'" + this.FormatearTextoSql( &tcCursor..Articulo ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( &tcCursor..Ccolor ) + "'"
			lcEntidad4 = "'" + this.FormatearTextoSql( &tcCursor..Talle ) + "'"
			lcEntidad5 = "'" + this.FormatearTextoSql( &tcCursor..Listapre ) + "'"
			lcEntidad6 = transform( &tcCursor..Timestampa )
			lcEntidad7 = "'" + this.FormatearTextoSql( &tcCursor..Entori ) + "'"
			lcEntidad8 = "'" + this.FormatearTextoSql( &tcCursor..Codori ) + "'"
			lcEntidad9 = transform( &tcCursor..Pdirori )
			lcEntidad10 = transform( &tcCursor..Pdirecto )
			lcEntidad11 = "'" + this.ConvertirDateSql( &tcCursor..Fechavig ) + "'"
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_PRECIOAR ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","CODIGO","ARTICULO","cColor","Talle","LISTAPRE","TimestampA","Entori","Codori","Pdirori","Pdirecto","Fechavig" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>>, <<lcEntidad7>>, <<lcEntidad8>>, <<lcEntidad9>>, <<lcEntidad10>>, <<lcEntidad11>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_PRECIODEARTICULO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_PRECIODEARTICULO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.PRECIOAR' )
		endtext
		this.oConexion.EjecutarSql( lcSentencia, 'c_last_user_update', set( 'Datasession' ) )
		ldRetorno = {^0001-01-01 00:00:00}
		if reccount( 'c_last_user_update' ) > 0 and !isnull( c_last_user_update.last_update )
			ldRetorno = c_last_user_update.last_update
		endif
		return ldRetorno
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerIdentificadoresPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.PRECIOAR 
								Where   PRECIOAR.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "PRECIOAR", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Entori" as "Entidadorigen", "Codori" as "Codigoorigen", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Agregapre" as "Agregadoalprecio", "Timestamp" as "Timestamp", "Pdirori" as "Preciodirectooriginal", "Sobrepre" as "Sobreprecio", "Codigo" as "Codigo", "Articulo" as "Articulo", "Ccolor" as "Color", "Talle" as "Talle", "Listapre" as "Listadeprecio", "Pdirecto" as "Preciodirecto", "Bloqueo" as "Bloqueo", "Obs" as "Obs", "Fechavig" as "Fechavigencia", "Timestampa" as "Timestampalta"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.PRECIOAR 
								Where   PRECIOAR.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSql( lcSQL, lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc

enddefine

define class ObjetoBusqueda as custom
	Tabla = 'PRECIOAR'
	Filtro = " PRECIOAR.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " PRECIOAR.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = ""
	FiltroSubEntidad = ''

	*--------------------------------------------------------------------------------------------------------
	function init( toEntidad as object ) as boolean
		with this
			text to .cEstructura noshow 
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData xml:space="preserve">
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="entidad" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tabla" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="15"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="campo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="claveprimaria" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="muestrarelacion" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="permitemodificar" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="esentidad" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="claveforanea" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tipodato" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="longitud" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="decimales" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="valorsugerido" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="obligatorio" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="admitebusqueda" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiqueta" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="160"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="dominio" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="30"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="detalle" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="tipo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributoforaneo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="clavecandidata" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="mascara" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="25"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="ofuncionalidad" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="relaciones" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="filtrobuscador" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="grupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="subgrupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="orden" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="alta" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluiratrib" type="xsd:boolean" use="required"/>
							<xsd:attribute name="excluiratrib" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluirbussubent" type="xsd:boolean" use="required"/>
							<xsd:attribute name="utilizamismarelacion" type="xsd:boolean" use="required"/>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row entidad="PRECIODEARTICULO                        " atributo="FECHAMODIFICACIONFW                     " tabla="PRECIOAR       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="FECHAALTAFW                             " tabla="PRECIOAR       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="FECHATRANSFERENCIA                      " tabla="PRECIOAR       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="FECHAIMPO                               " tabla="PRECIOAR       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="FECHAEXPO                               " tabla="PRECIOAR       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="HORAALTAFW                              " tabla="PRECIOAR       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="HORAEXPO                                " tabla="PRECIOAR       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="HORAIMPO                                " tabla="PRECIOAR       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="SERIEALTAFW                             " tabla="PRECIOAR       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="ZADSFW                                  " tabla="PRECIOAR       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="DESCRIPCIONFW                           " tabla="PRECIOAR       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="VERSIONMODIFICACIONFW                   " tabla="PRECIOAR       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="USUARIOMODIFICACIONFW                   " tabla="PRECIOAR       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="VERSIONALTAFW                           " tabla="PRECIOAR       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="SERIEMODIFICACIONFW                     " tabla="PRECIOAR       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="USUARIOALTAFW                           " tabla="PRECIOAR       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="HORAMODIFICACIONFW                      " tabla="PRECIOAR       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="ESTADOTRANSFERENCIA                     " tabla="PRECIOAR       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="ENTIDADORIGEN                           " tabla="PRECIOAR       " campo="ENTORI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entidad de origen                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="CODIGOORIGEN                            " tabla="PRECIOAR       " campo="CODORI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código origen                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="BASEDEDATOSALTAFW                       " tabla="PRECIOAR       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="PRECIOAR       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="AGREGADOALPRECIO                        " tabla="PRECIOAR       " campo="AGREGAPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agregado al precio                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="TIMESTAMP                               " tabla="PRECIOAR       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="PRECIODIRECTOORIGINAL                   " tabla="PRECIOAR       " campo="PDIRORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Precio anterior                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="SOBREPRECIO                             " tabla="PRECIOAR       " campo="SOBREPRE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sobreprecio                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="CODIGO                                  " tabla="PRECIOAR       " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="46" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código interno                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="ARTICULO                                " tabla="PRECIOAR       " campo="ARTICULO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="Articulo                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="COLOR                                   " tabla="PRECIOAR       " campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="TALLE                                   " tabla="PRECIOAR       " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="LISTADEPRECIO                           " tabla="PRECIOAR       " campo="LISTAPRE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ListaDePrecios                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="PRECIODIRECTO                           " tabla="PRECIOAR       " campo="PDIRECTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Precio nuevo                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="BLOQUEO                                 " tabla="PRECIOAR       " campo="BLOQUEO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Bloqueo                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="OBS                                     " tabla="PRECIOAR       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="FECHAVIGENCIA                           " tabla="PRECIOAR       " campo="FECHAVIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha() +1                                                                                                                                                                                                                      " obligatorio="true" admitebusqueda="402" etiqueta="Fecha de vigencia                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PRECIODEARTICULO                        " atributo="TIMESTAMPALTA                           " tabla="PRECIOAR       " campo="TIMESTAMPA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Timestamp                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On PRECIOAR.ARTICULO = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On PRECIOAR.CCOLOR = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On PRECIOAR.TALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On PRECIOAR.LISTAPRE = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext


			.listadecampos = .cEstructura
			.cEstructuraSinDetalle = .cEstructura
			.oEntidad = toEntidad
			.Indice = .Indice
			.Filtro = .Filtro
		endwith
	endfunc

enddefine