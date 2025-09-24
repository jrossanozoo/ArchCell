
define class Din_EntidadESTADOCONTROLADORFISCALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ESTADOCONTROLADORFISCAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_140PK'
	cTablaPrincipal = 'ERRORCF'
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
			local  lxErrorcfFecexpo, lxErrorcfFectrans, lxErrorcfFmodifw, lxErrorcfFaltafw, lxErrorcfFecimpo, lxErrorcfSaltafw, lxErrorcfSmodifw, lxErrorcfHmodifw, lxErrorcfUaltafw, lxErrorcfHoraimpo, lxErrorcfUmodifw, lxErrorcfZadsfw, lxErrorcfDescfw, lxErrorcfVmodifw, lxErrorcfHoraexpo, lxErrorcfValtafw, lxErrorcfHaltafw, lxErrorcfBdmodifw, lxErrorcfEsttrans, lxErrorcfBdaltafw, lxErrorcfDescripci, lxErrorcfCod, lxErrorcfObs, lxErrorcfFptoven, lxErrorcfComp, lxErrorcfTieneerr, lxErrorcfCodcomp, lxErrorcfGuicomp
				lxErrorcfFecexpo =  .Fechaexpo			lxErrorcfFectrans =  .Fechatransferencia			lxErrorcfFmodifw =  .Fechamodificacionfw			lxErrorcfFaltafw =  .Fechaaltafw			lxErrorcfFecimpo =  .Fechaimpo			lxErrorcfSaltafw =  .Seriealtafw			lxErrorcfSmodifw =  .Seriemodificacionfw			lxErrorcfHmodifw =  .Horamodificacionfw			lxErrorcfUaltafw =  .Usuarioaltafw			lxErrorcfHoraimpo =  .Horaimpo			lxErrorcfUmodifw =  .Usuariomodificacionfw			lxErrorcfZadsfw =  .Zadsfw			lxErrorcfDescfw =  .Descripcionfw			lxErrorcfVmodifw =  .Versionmodificacionfw			lxErrorcfHoraexpo =  .Horaexpo			lxErrorcfValtafw =  .Versionaltafw			lxErrorcfHaltafw =  .Horaaltafw			lxErrorcfBdmodifw =  .Basededatosmodificacionfw			lxErrorcfEsttrans =  .Estadotransferencia			lxErrorcfBdaltafw =  .Basededatosaltafw			lxErrorcfDescripci =  .Descrip			lxErrorcfCod =  .Codigo			lxErrorcfObs =  .Obs			lxErrorcfFptoven =  .Puntodeventa			lxErrorcfComp =  .Comprobante			lxErrorcfTieneerr =  .Tieneerror			lxErrorcfCodcomp =  .Idcomprobante			lxErrorcfGuicomp =  .Codigocomprobante
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxErrorcfCod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ERRORCF ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Smodifw","Hmodifw","Ualtafw","Horaimpo","Umodifw","Zadsfw","Descfw","Vmodifw","Horaexpo","Valtafw","Haltafw","Bdmodifw","Esttrans","Bdaltafw","Descripci","Cod","Obs","Fptoven","Comp","Tieneerr","Codcomp","Guicomp" ) values ( <<"'" + this.ConvertirDateSql( lxErrorcfFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfDescripci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfObs ) + "'" >>, <<lxErrorcfFptoven >>, <<lxErrorcfComp >>, <<iif( lxErrorcfTieneerr, 1, 0 ) >>, <<lxErrorcfCodcomp >>, <<"'" + this.FormatearTextoSql( lxErrorcfGuicomp ) + "'" >> )
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
			local  lxErrorcfFecexpo, lxErrorcfFectrans, lxErrorcfFmodifw, lxErrorcfFaltafw, lxErrorcfFecimpo, lxErrorcfSaltafw, lxErrorcfSmodifw, lxErrorcfHmodifw, lxErrorcfUaltafw, lxErrorcfHoraimpo, lxErrorcfUmodifw, lxErrorcfZadsfw, lxErrorcfDescfw, lxErrorcfVmodifw, lxErrorcfHoraexpo, lxErrorcfValtafw, lxErrorcfHaltafw, lxErrorcfBdmodifw, lxErrorcfEsttrans, lxErrorcfBdaltafw, lxErrorcfDescripci, lxErrorcfCod, lxErrorcfObs, lxErrorcfFptoven, lxErrorcfComp, lxErrorcfTieneerr, lxErrorcfCodcomp, lxErrorcfGuicomp
				lxErrorcfFecexpo =  .Fechaexpo			lxErrorcfFectrans =  .Fechatransferencia			lxErrorcfFmodifw =  .Fechamodificacionfw			lxErrorcfFaltafw =  .Fechaaltafw			lxErrorcfFecimpo =  .Fechaimpo			lxErrorcfSaltafw =  .Seriealtafw			lxErrorcfSmodifw =  .Seriemodificacionfw			lxErrorcfHmodifw =  .Horamodificacionfw			lxErrorcfUaltafw =  .Usuarioaltafw			lxErrorcfHoraimpo =  .Horaimpo			lxErrorcfUmodifw =  .Usuariomodificacionfw			lxErrorcfZadsfw =  .Zadsfw			lxErrorcfDescfw =  .Descripcionfw			lxErrorcfVmodifw =  .Versionmodificacionfw			lxErrorcfHoraexpo =  .Horaexpo			lxErrorcfValtafw =  .Versionaltafw			lxErrorcfHaltafw =  .Horaaltafw			lxErrorcfBdmodifw =  .Basededatosmodificacionfw			lxErrorcfEsttrans =  .Estadotransferencia			lxErrorcfBdaltafw =  .Basededatosaltafw			lxErrorcfDescripci =  .Descrip			lxErrorcfCod =  .Codigo			lxErrorcfObs =  .Obs			lxErrorcfFptoven =  .Puntodeventa			lxErrorcfComp =  .Comprobante			lxErrorcfTieneerr =  .Tieneerror			lxErrorcfCodcomp =  .Idcomprobante			lxErrorcfGuicomp =  .Codigocomprobante
		endwith
		
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.PuntoDeVenta != .oEntidad.PuntoDeVenta or  .oEntidad.oAtributosAuditoria.Comprobante != .oEntidad.Comprobante )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ERRORCF set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxErrorcfFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxErrorcfFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxErrorcfFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxErrorcfFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxErrorcfFecimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxErrorcfSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxErrorcfUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxErrorcfHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxErrorcfZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxErrorcfDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfVmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxErrorcfHoraexpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxErrorcfValtafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxErrorcfHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxErrorcfEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxErrorcfBdaltafw ) + "'">>,"Descripci" = <<"'" + this.FormatearTextoSql( lxErrorcfDescripci ) + "'">>,"Cod" = <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxErrorcfObs ) + "'">>,"Fptoven" = <<lxErrorcfFptoven>>,"Comp" = <<lxErrorcfComp>>,"Tieneerr" = <<iif( lxErrorcfTieneerr, 1, 0 )>>,"Codcomp" = <<lxErrorcfCodcomp>>,"Guicomp" = <<"'" + this.FormatearTextoSql( lxErrorcfGuicomp ) + "'">> where "Cod" = <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'">> and  ERRORCF.COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Cod from ZooLogic.ERRORCF where " + this.ConvertirFuncionesSql( " ERRORCF.COD != ''" ) )
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
			Local lxErrorcfCod
			lxErrorcfCod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante" from ZooLogic.ERRORCF where "Cod" = <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'">> and  ERRORCF.COD != ''
			endtext
			use in select('c_ESTADOCONTROLADORFISCAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOCONTROLADORFISCAL', set( 'Datasession' ) )

			if reccount( 'c_ESTADOCONTROLADORFISCAL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxErrorcfCod as Variant
		llRetorno = .t.
		lxErrorcfCod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ERRORCF where "Cod" = <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'">> and  ERRORCF.COD != ''
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante" from ZooLogic.ERRORCF where  ERRORCF.COD != '' order by Cod
			endtext
			use in select('c_ESTADOCONTROLADORFISCAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOCONTROLADORFISCAL', set( 'Datasession' ) )
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante" from ZooLogic.ERRORCF where  funciones.padr( Cod, 6, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ERRORCF.COD != '' order by Cod
			endtext
			use in select('c_ESTADOCONTROLADORFISCAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOCONTROLADORFISCAL', set( 'Datasession' ) )
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante" from ZooLogic.ERRORCF where  funciones.padr( Cod, 6, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ERRORCF.COD != '' order by Cod desc
			endtext
			use in select('c_ESTADOCONTROLADORFISCAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOCONTROLADORFISCAL', set( 'Datasession' ) )
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
				lcOrden =  .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante" from ZooLogic.ERRORCF where  ERRORCF.COD != '' order by Cod desc
			endtext
			use in select('c_ESTADOCONTROLADORFISCAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ESTADOCONTROLADORFISCAL', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Smodifw,Hmodifw,Ualtafw,Horaimpo,Umodifw,Za" + ;
"dsfw,Descfw,Vmodifw,Horaexpo,Valtafw,Haltafw,Bdmodifw,Esttrans,Bdaltafw,Descripci,Cod,Obs,Fptoven,Co" + ;
"mp,Tieneerr,Codcomp,Guicomp" + ;
" from ZooLogic.ERRORCF where  ERRORCF.COD != '' and " + lcFiltro )
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
			local  lxErrorcfFecexpo, lxErrorcfFectrans, lxErrorcfFmodifw, lxErrorcfFaltafw, lxErrorcfFecimpo, lxErrorcfSaltafw, lxErrorcfSmodifw, lxErrorcfHmodifw, lxErrorcfUaltafw, lxErrorcfHoraimpo, lxErrorcfUmodifw, lxErrorcfZadsfw, lxErrorcfDescfw, lxErrorcfVmodifw, lxErrorcfHoraexpo, lxErrorcfValtafw, lxErrorcfHaltafw, lxErrorcfBdmodifw, lxErrorcfEsttrans, lxErrorcfBdaltafw, lxErrorcfDescripci, lxErrorcfCod, lxErrorcfObs, lxErrorcfFptoven, lxErrorcfComp, lxErrorcfTieneerr, lxErrorcfCodcomp, lxErrorcfGuicomp
				lxErrorcfFecexpo = ctod( '  /  /    ' )			lxErrorcfFectrans = ctod( '  /  /    ' )			lxErrorcfFmodifw = ctod( '  /  /    ' )			lxErrorcfFaltafw = ctod( '  /  /    ' )			lxErrorcfFecimpo = ctod( '  /  /    ' )			lxErrorcfSaltafw = []			lxErrorcfSmodifw = []			lxErrorcfHmodifw = []			lxErrorcfUaltafw = []			lxErrorcfHoraimpo = []			lxErrorcfUmodifw = []			lxErrorcfZadsfw = []			lxErrorcfDescfw = []			lxErrorcfVmodifw = []			lxErrorcfHoraexpo = []			lxErrorcfValtafw = []			lxErrorcfHaltafw = []			lxErrorcfBdmodifw = []			lxErrorcfEsttrans = []			lxErrorcfBdaltafw = []			lxErrorcfDescripci = []			lxErrorcfCod = []			lxErrorcfObs = []			lxErrorcfFptoven = 0			lxErrorcfComp = 0			lxErrorcfTieneerr = .F.			lxErrorcfCodcomp = 0			lxErrorcfGuicomp = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ERRORCF where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ERRORCF' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Cod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Cod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ERRORCF.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ERRORCF', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'DESCRIP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPCI AS DESCRIP'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPROBANTE'
				Case lcAtributo == 'TIENEERROR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIENEERR AS TIENEERROR'
				Case lcAtributo == 'IDCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS IDCOMPROBANTE'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUICOMP AS CODIGOCOMPROBANTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIP'
				lcCampo = 'DESCRIPCI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIENEERROR'
				lcCampo = 'TIENEERR'
			Case upper( alltrim( tcAtributo ) ) == 'IDCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'GUICOMP'
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
			local  lxErrorcfFecexpo, lxErrorcfFectrans, lxErrorcfFmodifw, lxErrorcfFaltafw, lxErrorcfFecimpo, lxErrorcfSaltafw, lxErrorcfSmodifw, lxErrorcfHmodifw, lxErrorcfUaltafw, lxErrorcfHoraimpo, lxErrorcfUmodifw, lxErrorcfZadsfw, lxErrorcfDescfw, lxErrorcfVmodifw, lxErrorcfHoraexpo, lxErrorcfValtafw, lxErrorcfHaltafw, lxErrorcfBdmodifw, lxErrorcfEsttrans, lxErrorcfBdaltafw, lxErrorcfDescripci, lxErrorcfCod, lxErrorcfObs, lxErrorcfFptoven, lxErrorcfComp, lxErrorcfTieneerr, lxErrorcfCodcomp, lxErrorcfGuicomp
				lxErrorcfFecexpo =  .Fechaexpo			lxErrorcfFectrans =  .Fechatransferencia			lxErrorcfFmodifw =  .Fechamodificacionfw			lxErrorcfFaltafw =  .Fechaaltafw			lxErrorcfFecimpo =  .Fechaimpo			lxErrorcfSaltafw =  .Seriealtafw			lxErrorcfSmodifw =  .Seriemodificacionfw			lxErrorcfHmodifw =  .Horamodificacionfw			lxErrorcfUaltafw =  .Usuarioaltafw			lxErrorcfHoraimpo =  .Horaimpo			lxErrorcfUmodifw =  .Usuariomodificacionfw			lxErrorcfZadsfw =  .Zadsfw			lxErrorcfDescfw =  .Descripcionfw			lxErrorcfVmodifw =  .Versionmodificacionfw			lxErrorcfHoraexpo =  .Horaexpo			lxErrorcfValtafw =  .Versionaltafw			lxErrorcfHaltafw =  .Horaaltafw			lxErrorcfBdmodifw =  .Basededatosmodificacionfw			lxErrorcfEsttrans =  .Estadotransferencia			lxErrorcfBdaltafw =  .Basededatosaltafw			lxErrorcfDescripci =  .Descrip			lxErrorcfCod =  .Codigo			lxErrorcfObs =  .Obs			lxErrorcfFptoven =  .Puntodeventa			lxErrorcfComp =  .Comprobante			lxErrorcfTieneerr =  .Tieneerror			lxErrorcfCodcomp =  .Idcomprobante			lxErrorcfGuicomp =  .Codigocomprobante
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ERRORCF ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Smodifw","Hmodifw","Ualtafw","Horaimpo","Umodifw","Zadsfw","Descfw","Vmodifw","Horaexpo","Valtafw","Haltafw","Bdmodifw","Esttrans","Bdaltafw","Descripci","Cod","Obs","Fptoven","Comp","Tieneerr","Codcomp","Guicomp" ) values ( <<"'" + this.ConvertirDateSql( lxErrorcfFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxErrorcfFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfDescripci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxErrorcfObs ) + "'" >>, <<lxErrorcfFptoven >>, <<lxErrorcfComp >>, <<iif( lxErrorcfTieneerr, 1, 0 ) >>, <<lxErrorcfCodcomp >>, <<"'" + this.FormatearTextoSql( lxErrorcfGuicomp ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ERRORCF' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxErrorcfFecexpo, lxErrorcfFectrans, lxErrorcfFmodifw, lxErrorcfFaltafw, lxErrorcfFecimpo, lxErrorcfSaltafw, lxErrorcfSmodifw, lxErrorcfHmodifw, lxErrorcfUaltafw, lxErrorcfHoraimpo, lxErrorcfUmodifw, lxErrorcfZadsfw, lxErrorcfDescfw, lxErrorcfVmodifw, lxErrorcfHoraexpo, lxErrorcfValtafw, lxErrorcfHaltafw, lxErrorcfBdmodifw, lxErrorcfEsttrans, lxErrorcfBdaltafw, lxErrorcfDescripci, lxErrorcfCod, lxErrorcfObs, lxErrorcfFptoven, lxErrorcfComp, lxErrorcfTieneerr, lxErrorcfCodcomp, lxErrorcfGuicomp
				lxErrorcfFecexpo =  .Fechaexpo			lxErrorcfFectrans =  .Fechatransferencia			lxErrorcfFmodifw =  .Fechamodificacionfw			lxErrorcfFaltafw =  .Fechaaltafw			lxErrorcfFecimpo =  .Fechaimpo			lxErrorcfSaltafw =  .Seriealtafw			lxErrorcfSmodifw =  .Seriemodificacionfw			lxErrorcfHmodifw =  .Horamodificacionfw			lxErrorcfUaltafw =  .Usuarioaltafw			lxErrorcfHoraimpo =  .Horaimpo			lxErrorcfUmodifw =  .Usuariomodificacionfw			lxErrorcfZadsfw =  .Zadsfw			lxErrorcfDescfw =  .Descripcionfw			lxErrorcfVmodifw =  .Versionmodificacionfw			lxErrorcfHoraexpo =  .Horaexpo			lxErrorcfValtafw =  .Versionaltafw			lxErrorcfHaltafw =  .Horaaltafw			lxErrorcfBdmodifw =  .Basededatosmodificacionfw			lxErrorcfEsttrans =  .Estadotransferencia			lxErrorcfBdaltafw =  .Basededatosaltafw			lxErrorcfDescripci =  .Descrip			lxErrorcfCod =  .Codigo			lxErrorcfObs =  .Obs			lxErrorcfFptoven =  .Puntodeventa			lxErrorcfComp =  .Comprobante			lxErrorcfTieneerr =  .Tieneerror			lxErrorcfCodcomp =  .Idcomprobante			lxErrorcfGuicomp =  .Codigocomprobante
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.PuntoDeVenta != .oEntidad.PuntoDeVenta or  .oEntidad.oAtributosAuditoria.Comprobante != .oEntidad.Comprobante )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cod" = ] + lcValorClavePrimariaString  + [ and  ERRORCF.COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ERRORCF set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxErrorcfFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxErrorcfFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxErrorcfFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxErrorcfFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxErrorcfFecimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxErrorcfSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxErrorcfUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxErrorcfHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxErrorcfZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxErrorcfDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfVmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxErrorcfHoraexpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxErrorcfValtafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxErrorcfHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxErrorcfBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxErrorcfEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxErrorcfBdaltafw ) + "'">>, "Descripci" = <<"'" + this.FormatearTextoSql( lxErrorcfDescripci ) + "'">>, "Cod" = <<"'" + this.FormatearTextoSql( lxErrorcfCod ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxErrorcfObs ) + "'">>, "Fptoven" = <<lxErrorcfFptoven>>, "Comp" = <<lxErrorcfComp>>, "Tieneerr" = <<iif( lxErrorcfTieneerr, 1, 0 )>>, "Codcomp" = <<lxErrorcfCodcomp>>, "Guicomp" = <<"'" + this.FormatearTextoSql( lxErrorcfGuicomp ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ERRORCF' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasDelete() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Cod" = ] + lcValorClavePrimariaString  + [ and  ERRORCF.COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ERRORCF where ' + lcFiltro )
			loColeccion.cTabla = 'ERRORCF' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ERRORCF where  ERRORCF.COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ERRORCF where Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ERRORCF.COD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxErrorCFFPTOVEN as variant, lxErrorCFComp as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOCONTROLADORFISCAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ERRORCF Where Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					local llInsertarAuditoria as boolean
					llInsertarAuditoria = (  iif( isnull( curSeek.FPTOVEN != &lcCursor..FPTOVEN ), .F., curSeek.FPTOVEN != &lcCursor..FPTOVEN ) or  iif( isnull( curSeek.Comp != &lcCursor..Comp ), .F., curSeek.Comp != &lcCursor..Comp ) )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ERRORCF set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Descripci = ] + "'" + this.FormatearTextoSql( &lcCursor..Descripci ) + "'"+ [, Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'"+ [, OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, Comp = ] + transform( &lcCursor..Comp )+ [, Tieneerr = ] + Transform( iif( &lcCursor..Tieneerr, 1, 0 ))+ [, CodComp = ] + transform( &lcCursor..CodComp )+ [, GUIComp = ] + "'" + this.FormatearTextoSql( &lcCursor..GUIComp ) + "'" + [ Where Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					if llInsertarAuditoria
						lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
						this.oConexion.EjecutarSql( lcSentencia )
					EndIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SALTAFW, SMODIFW, HMODIFW, UALTAFW, HORAIMPO, UMODIFW, ZADSFW, DescFW, VMODIFW, HORAEXPO, VALTAFW, HALTAFW, BDMODIFW, ESTTRANS, BDALTAFW, Descripci, Cod, OBS, FPTOVEN, Comp, Tieneerr, CodComp, GUIComp
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descripci ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OBS ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..Comp ) + ',' + Transform( iif( &lcCursor..Tieneerr, 1, 0 )) + ',' + transform( &lcCursor..CodComp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..GUIComp ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ERRORCF ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
				this.oConexion.EjecutarSql( lcSentencia )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOCONTROLADORFISCAL'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Cod C (6) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Cod        )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ESTADOCONTROLADORFISCAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ESTADOCONTROLADORFISCAL_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ErrorCF')

				if this.oMensajesConexion.Count>0
					goServicios.Errores.LevantarExcepcion( this.ObtenerMensajesConexion() )
				endif

			enddo
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	protected function ValidarDatosAImportar() as boolean
		local lcCursor as String, llRetorno as boolean, lxVar as Variant, llCondicion as boolean
		lcCursor = This.oEntidad.cPrefijoImportar + 'ESTADOCONTROLADORFISCAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ESTADOCONTROLADORFISCAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOCONTROLADORFISCAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Cod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Cod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOCONTROLADORFISCAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ErrorCF') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ErrorCF
Create Table ZooLogic.TablaTrabajo_ErrorCF ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"descripci" char( 50 )  null, 
"cod" char( 6 )  null, 
"obs" char( 100 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"comp" numeric( 2, 0 )  null, 
"tieneerr" bit  null, 
"codcomp" numeric( 10, 0 )  null, 
"guicomp" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ErrorCF' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ErrorCF' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ESTADOCONTROLADORFISCAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('descripci','descripci')
			.AgregarMapeo('cod','cod')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('tieneerr','tieneerr')
			.AgregarMapeo('codcomp','codcomp')
			.AgregarMapeo('guicomp','guicomp')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ErrorCF'
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
				insert into ZooLogic.ADT_ERRORCF ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","Cod","Fptoven","Comp" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Cod,Isnull( d.Fptoven,t.Fptoven),Isnull( d.Comp,t.Comp)
						from ZooLogic.ERRORCF t inner join deleted d 
							 on t.Cod = d.Cod
					where ( d.FPTOVEN is not null and d.FPTOVEN <> t.FPTOVEN ) or ( d.Comp is not null and d.Comp <> t.Comp )
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.DESCRIPCI = isnull( d.DESCRIPCI, t.DESCRIPCI ),t.COD = isnull( d.COD, t.COD ),t.OBS = isnull( d.OBS, t.OBS ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.COMP = isnull( d.COMP, t.COMP ),t.TIENEERR = isnull( d.TIENEERR, t.TIENEERR ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),t.GUICOMP = isnull( d.GUICOMP, t.GUICOMP )
					from ZooLogic.ERRORCF t inner join deleted d 
							 on t.Cod = d.Cod
				-- Fin Updates
				insert into ZooLogic.ADT_ERRORCF ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","Cod","Fptoven","Comp" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Cod,isnull( d.FPTOVEN,0),isnull( d.COMP,0)
						From deleted d left join ZooLogic.ERRORCF pk 
							 on d.Cod = pk.Cod
						Where pk.Cod Is Null 
				insert into ZooLogic.ERRORCF(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Smodifw,Hmodifw,Ualtafw,Horaimpo,Umodifw,Zadsfw,Descfw,Vmodifw,Horaexpo,Valtafw,Haltafw,Bdmodifw,Esttrans,Bdaltafw,Descripci,Cod,Obs,Fptoven,Comp,Tieneerr,Codcomp,Guicomp)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.VALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.DESCRIPCI,''),isnull( d.COD,''),isnull( d.OBS,''),isnull( d.FPTOVEN,0),isnull( d.COMP,0),isnull( d.TIENEERR,0),isnull( d.CODCOMP,0),isnull( d.GUICOMP,'')
						From deleted d left join ZooLogic.ERRORCF pk 
							 on d.Cod = pk.Cod
						Where pk.Cod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ErrorCF') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ErrorCF
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ESTADOCONTROLADORFISCAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOCONTROLADORFISCAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOCONTROLADORFISCAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOCONTROLADORFISCAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOCONTROLADORFISCAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ESTADOCONTROLADORFISCAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_ESTADOCONTROLADORFISCAL.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_ESTADOCONTROLADORFISCAL.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ESTADOCONTROLADORFISCAL.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ESTADOCONTROLADORFISCAL.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_ESTADOCONTROLADORFISCAL.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_ESTADOCONTROLADORFISCAL.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_ESTADOCONTROLADORFISCAL.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_ESTADOCONTROLADORFISCAL.Versionmodificacionfw, [] )
					.Horaexpo = nvl( c_ESTADOCONTROLADORFISCAL.Horaexpo, [] )
					.Versionaltafw = nvl( c_ESTADOCONTROLADORFISCAL.Versionaltafw, [] )
					.Horaaltafw = nvl( c_ESTADOCONTROLADORFISCAL.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ESTADOCONTROLADORFISCAL.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_ESTADOCONTROLADORFISCAL.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_ESTADOCONTROLADORFISCAL.Basededatosaltafw, [] )
					.Descrip = nvl( c_ESTADOCONTROLADORFISCAL.Descrip, [] )
					.Codigo = nvl( c_ESTADOCONTROLADORFISCAL.Codigo, [] )
					.Obs = nvl( c_ESTADOCONTROLADORFISCAL.Obs, [] )
					.Puntodeventa = nvl( c_ESTADOCONTROLADORFISCAL.Puntodeventa, 0 )
					.Comprobante = nvl( c_ESTADOCONTROLADORFISCAL.Comprobante, 0 )
					.Tieneerror = nvl( c_ESTADOCONTROLADORFISCAL.Tieneerror, .F. )
					.Idcomprobante = nvl( c_ESTADOCONTROLADORFISCAL.Idcomprobante, 0 )
					.Codigocomprobante = nvl( c_ESTADOCONTROLADORFISCAL.Codigocomprobante, [] )
					Select c_ESTADOCONTROLADORFISCAL
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
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = transform( this.oEntidad.Puntodeventa )
			lcEntidad3 = transform( this.oEntidad.Comprobante )
			
		else
			lxValorClavePrimaria = &tcCursor..Cod
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string
			lcEntidad1 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad2 = transform( &tcCursor..Fptoven )
			lcEntidad3 = transform( &tcCursor..Comp )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_ERRORCF ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","Cod","Fptoven","Comp" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_ESTADOCONTROLADORFISCAL.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ERRORCF' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Cod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Cod from (
							select * 
								from ZooLogic.ERRORCF 
								Where   ERRORCF.COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ERRORCF", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaexpo" as "Horaexpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Descripci" as "Descrip", "Cod" as "Codigo", "Obs" as "Obs", "Fptoven" as "Puntodeventa", "Comp" as "Comprobante", "Tieneerr" as "Tieneerror", "Codcomp" as "Idcomprobante", "Guicomp" as "Codigocomprobante"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ERRORCF 
								Where   ERRORCF.COD != ''
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
	Tabla = 'ERRORCF'
	Filtro = " ERRORCF.COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ERRORCF.COD != ''"
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
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="FECHAEXPO                               " tabla="ERRORCF        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="FECHATRANSFERENCIA                      " tabla="ERRORCF        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="FECHAMODIFICACIONFW                     " tabla="ERRORCF        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="FECHAALTAFW                             " tabla="ERRORCF        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="FECHAIMPO                               " tabla="ERRORCF        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="SERIEALTAFW                             " tabla="ERRORCF        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="SERIEMODIFICACIONFW                     " tabla="ERRORCF        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="HORAMODIFICACIONFW                      " tabla="ERRORCF        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="USUARIOALTAFW                           " tabla="ERRORCF        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="HORAIMPO                                " tabla="ERRORCF        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="USUARIOMODIFICACIONFW                   " tabla="ERRORCF        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="ZADSFW                                  " tabla="ERRORCF        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="DESCRIPCIONFW                           " tabla="ERRORCF        " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="VERSIONMODIFICACIONFW                   " tabla="ERRORCF        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="HORAEXPO                                " tabla="ERRORCF        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="VERSIONALTAFW                           " tabla="ERRORCF        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="HORAALTAFW                              " tabla="ERRORCF        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ERRORCF        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="ESTADOTRANSFERENCIA                     " tabla="ERRORCF        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="BASEDEDATOSALTAFW                       " tabla="ERRORCF        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="DESCRIP                                 " tabla="ERRORCF        " campo="DESCRIPCI " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="CODIGO                                  " tabla="ERRORCF        " campo="COD       " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="OBS                                     " tabla="ERRORCF        " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="PUNTODEVENTA                            " tabla="ERRORCF        " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Número punto de venta                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="COMPROBANTE                             " tabla="ERRORCF        " campo="COMP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Tipo de comprobante.                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="TIENEERROR                              " tabla="ERRORCF        " campo="TIENEERR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante con error.                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="IDCOMPROBANTE                           " tabla="ERRORCF        " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número de comprobante                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTADOCONTROLADORFISCAL                 " atributo="CODIGOCOMPROBANTE                       " tabla="ERRORCF        " campo="GUICOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo de comprobante                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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