
define class Din_EntidadZUDESCARGALANAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ZUDESCARGALAN'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [version]
	cExpresionCCPorCampos = [#tabla#.CVERSION]
	cTagClaveCandidata = '_LANCC'
	cTagClavePk = '_LANPK'
	cTablaPrincipal = 'RUTALAN'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'ORGANIZACION'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ORGANIZACION'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxRutalanFecexpo, lxRutalanFmodifw, lxRutalanFaltafw, lxRutalanFectrans, lxRutalanFecimpo, lxRutalanCodigo, lxRutalanSmodifw, lxRutalanHmodifw, lxRutalanSaltafw, lxRutalanUaltafw, lxRutalanVmodifw, lxRutalanZadsfw, lxRutalanValtafw, lxRutalanHoraimpo, lxRutalanUmodifw, lxRutalanHaltafw, lxRutalanBdmodifw, lxRutalanBdaltafw, lxRutalanEsttrans, lxRutalanHoraexpo, lxRutalanClobs, lxRutalanCversion, lxRutalanUsuario, lxRutalanFecha, lxRutalanSerie, lxRutalanArchivo, lxRutalanPublicada
				lxRutalanFecexpo =  .Fechaexpo			lxRutalanFmodifw =  .Fechamodificacionfw			lxRutalanFaltafw =  .Fechaaltafw			lxRutalanFectrans =  .Fechatransferencia			lxRutalanFecimpo =  .Fechaimpo			lxRutalanCodigo =  .Codigo			lxRutalanSmodifw =  .Seriemodificacionfw			lxRutalanHmodifw =  .Horamodificacionfw			lxRutalanSaltafw =  .Seriealtafw			lxRutalanUaltafw =  .Usuarioaltafw			lxRutalanVmodifw =  .Versionmodificacionfw			lxRutalanZadsfw =  .Zadsfw			lxRutalanValtafw =  .Versionaltafw			lxRutalanHoraimpo =  .Horaimpo			lxRutalanUmodifw =  .Usuariomodificacionfw			lxRutalanHaltafw =  .Horaaltafw			lxRutalanBdmodifw =  .Basededatosmodificacionfw			lxRutalanBdaltafw =  .Basededatosaltafw			lxRutalanEsttrans =  .Estadotransferencia			lxRutalanHoraexpo =  .Horaexpo			lxRutalanClobs =  .Observacion			lxRutalanCversion =  .Version			lxRutalanUsuario =  .Usuario			lxRutalanFecha =  .Fecha			lxRutalanSerie =  .Serie			lxRutalanArchivo =  .Archivoentrada			lxRutalanPublicada =  .Publicada
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxRutalanCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.RUTALAN ( "Fecexpo","Fmodifw","Faltafw","Fectrans","Fecimpo","Codigo","Smodifw","Hmodifw","Saltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Horaimpo","Umodifw","Haltafw","Bdmodifw","Bdaltafw","Esttrans","Horaexpo","Clobs","Cversion","Usuario","Fecha","Serie","Archivo","Publicada" ) values ( <<"'" + this.ConvertirDateSql( lxRutalanFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFecimpo ) + "'" >>, <<lxRutalanCodigo >>, <<"'" + this.FormatearTextoSql( lxRutalanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanCversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanUsuario ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanArchivo ) + "'" >>, <<iif( lxRutalanPublicada, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

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
			.ActualizarNumeraciones()
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
			.ActualizarNumeraciones()
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
			local  lxRutalanFecexpo, lxRutalanFmodifw, lxRutalanFaltafw, lxRutalanFectrans, lxRutalanFecimpo, lxRutalanCodigo, lxRutalanSmodifw, lxRutalanHmodifw, lxRutalanSaltafw, lxRutalanUaltafw, lxRutalanVmodifw, lxRutalanZadsfw, lxRutalanValtafw, lxRutalanHoraimpo, lxRutalanUmodifw, lxRutalanHaltafw, lxRutalanBdmodifw, lxRutalanBdaltafw, lxRutalanEsttrans, lxRutalanHoraexpo, lxRutalanClobs, lxRutalanCversion, lxRutalanUsuario, lxRutalanFecha, lxRutalanSerie, lxRutalanArchivo, lxRutalanPublicada
				lxRutalanFecexpo =  .Fechaexpo			lxRutalanFmodifw =  .Fechamodificacionfw			lxRutalanFaltafw =  .Fechaaltafw			lxRutalanFectrans =  .Fechatransferencia			lxRutalanFecimpo =  .Fechaimpo			lxRutalanCodigo =  .Codigo			lxRutalanSmodifw =  .Seriemodificacionfw			lxRutalanHmodifw =  .Horamodificacionfw			lxRutalanSaltafw =  .Seriealtafw			lxRutalanUaltafw =  .Usuarioaltafw			lxRutalanVmodifw =  .Versionmodificacionfw			lxRutalanZadsfw =  .Zadsfw			lxRutalanValtafw =  .Versionaltafw			lxRutalanHoraimpo =  .Horaimpo			lxRutalanUmodifw =  .Usuariomodificacionfw			lxRutalanHaltafw =  .Horaaltafw			lxRutalanBdmodifw =  .Basededatosmodificacionfw			lxRutalanBdaltafw =  .Basededatosaltafw			lxRutalanEsttrans =  .Estadotransferencia			lxRutalanHoraexpo =  .Horaexpo			lxRutalanClobs =  .Observacion			lxRutalanCversion =  .Version			lxRutalanUsuario =  .Usuario			lxRutalanFecha =  .Fecha			lxRutalanSerie =  .Serie			lxRutalanArchivo =  .Archivoentrada			lxRutalanPublicada =  .Publicada
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.RUTALAN set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRutalanFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxRutalanFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxRutalanFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxRutalanFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxRutalanFecimpo ) + "'">>,"Codigo" = <<lxRutalanCodigo>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxRutalanSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxRutalanHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxRutalanSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxRutalanUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxRutalanVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxRutalanZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxRutalanValtafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxRutalanHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxRutalanUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxRutalanHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRutalanBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRutalanBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxRutalanEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxRutalanHoraexpo ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxRutalanClobs ) + "'">>,"Cversion" = <<"'" + this.FormatearTextoSql( lxRutalanCversion ) + "'">>,"Usuario" = <<"'" + this.FormatearTextoSql( lxRutalanUsuario ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxRutalanFecha ) + "'">>,"Serie" = <<"'" + this.FormatearTextoSql( lxRutalanSerie ) + "'">>,"Archivo" = <<"'" + this.FormatearTextoSql( lxRutalanArchivo ) + "'">>,"Publicada" = <<iif( lxRutalanPublicada, 1, 0 )>> where "Codigo" = <<lxRutalanCodigo>> and  RUTALAN.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ORGANIZACION.RUTALAN where " + this.ConvertirFuncionesSql( " RUTALAN.CODIGO != 0" ) )
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
			Local lxRutalanCodigo
			lxRutalanCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada" from ORGANIZACION.RUTALAN where "Codigo" = <<lxRutalanCodigo>> and  RUTALAN.CODIGO != 0
			endtext
			use in select('c_ZUDESCARGALAN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ZUDESCARGALAN', set( 'Datasession' ) )

			if reccount( 'c_ZUDESCARGALAN' ) = 0
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
			Local lxrutalanCVERSION As Variant
			lxrutalanCVERSION = .version
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada" from ORGANIZACION.RUTALAN where  RUTALAN.CODIGO != 0 And CVERSION = <<"'" + this.FormatearTextoSql( lxrutalanCVERSION ) + "'">>
			endtext
			use in select('c_ZUDESCARGALAN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ZUDESCARGALAN', set( 'Datasession' ) )
			if reccount( 'c_ZUDESCARGALAN' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxRutalanCodigo as Variant
		llRetorno = .t.
		lxRutalanCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.RUTALAN where "Codigo" = <<lxRutalanCodigo>> and  RUTALAN.CODIGO != 0
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
				lcOrden =  .version
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada" from ORGANIZACION.RUTALAN where  RUTALAN.CODIGO != 0 order by CVERSION
			endtext
			use in select('c_ZUDESCARGALAN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ZUDESCARGALAN', set( 'Datasession' ) )
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
				lcOrden =  .version
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada" from ORGANIZACION.RUTALAN where  funciones.padr( CVERSION, 13, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  RUTALAN.CODIGO != 0 order by CVERSION
			endtext
			use in select('c_ZUDESCARGALAN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ZUDESCARGALAN', set( 'Datasession' ) )
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
				lcOrden =  .version
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada" from ORGANIZACION.RUTALAN where  funciones.padr( CVERSION, 13, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  RUTALAN.CODIGO != 0 order by CVERSION desc
			endtext
			use in select('c_ZUDESCARGALAN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ZUDESCARGALAN', set( 'Datasession' ) )
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
				lcOrden =  .version
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada" from ORGANIZACION.RUTALAN where  RUTALAN.CODIGO != 0 order by CVERSION desc
			endtext
			use in select('c_ZUDESCARGALAN')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ZUDESCARGALAN', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.CODIGO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Faltafw,Fectrans,Fecimpo,Codigo,Smodifw,Hmodifw,Saltafw,Ualtafw,Vmodifw,Zads" + ;
"fw,Valtafw,Horaimpo,Umodifw,Haltafw,Bdmodifw,Bdaltafw,Esttrans,Horaexpo,Clobs,Cversion,Usuario,Fecha" + ;
",Serie,Archivo,Publicada" + ;
" from ORGANIZACION.RUTALAN where  RUTALAN.CODIGO != 0 and " + lcFiltro )
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
			local  lxRutalanFecexpo, lxRutalanFmodifw, lxRutalanFaltafw, lxRutalanFectrans, lxRutalanFecimpo, lxRutalanCodigo, lxRutalanSmodifw, lxRutalanHmodifw, lxRutalanSaltafw, lxRutalanUaltafw, lxRutalanVmodifw, lxRutalanZadsfw, lxRutalanValtafw, lxRutalanHoraimpo, lxRutalanUmodifw, lxRutalanHaltafw, lxRutalanBdmodifw, lxRutalanBdaltafw, lxRutalanEsttrans, lxRutalanHoraexpo, lxRutalanClobs, lxRutalanCversion, lxRutalanUsuario, lxRutalanFecha, lxRutalanSerie, lxRutalanArchivo, lxRutalanPublicada
				lxRutalanFecexpo = ctod( '  /  /    ' )			lxRutalanFmodifw = ctod( '  /  /    ' )			lxRutalanFaltafw = ctod( '  /  /    ' )			lxRutalanFectrans = ctod( '  /  /    ' )			lxRutalanFecimpo = ctod( '  /  /    ' )			lxRutalanCodigo = 0			lxRutalanSmodifw = []			lxRutalanHmodifw = []			lxRutalanSaltafw = []			lxRutalanUaltafw = []			lxRutalanVmodifw = []			lxRutalanZadsfw = []			lxRutalanValtafw = []			lxRutalanHoraimpo = []			lxRutalanUmodifw = []			lxRutalanHaltafw = []			lxRutalanBdmodifw = []			lxRutalanBdaltafw = []			lxRutalanEsttrans = []			lxRutalanHoraexpo = []			lxRutalanClobs = []			lxRutalanCversion = []			lxRutalanUsuario = []			lxRutalanFecha = ctod( '  /  /    ' )			lxRutalanSerie = []			lxRutalanArchivo = []			lxRutalanPublicada = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.RUTALAN where "Codigo" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			.ActualizarNumeraciones()
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
			lcTabla = 'RUTALAN' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where Codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(Codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  RUTALAN.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'RUTALAN', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'VERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSION AS VERSION'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USUARIO AS USUARIO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIE'
				Case lcAtributo == 'ARCHIVOENTRADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARCHIVO AS ARCHIVOENTRADA'
				Case lcAtributo == 'PUBLICADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUBLICADA AS PUBLICADA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSION'
				lcCampo = 'CVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'USUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ARCHIVOENTRADA'
				lcCampo = 'ARCHIVO'
			Case upper( alltrim( tcAtributo ) ) == 'PUBLICADA'
				lcCampo = 'PUBLICADA'
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
			local  lxRutalanFecexpo, lxRutalanFmodifw, lxRutalanFaltafw, lxRutalanFectrans, lxRutalanFecimpo, lxRutalanCodigo, lxRutalanSmodifw, lxRutalanHmodifw, lxRutalanSaltafw, lxRutalanUaltafw, lxRutalanVmodifw, lxRutalanZadsfw, lxRutalanValtafw, lxRutalanHoraimpo, lxRutalanUmodifw, lxRutalanHaltafw, lxRutalanBdmodifw, lxRutalanBdaltafw, lxRutalanEsttrans, lxRutalanHoraexpo, lxRutalanClobs, lxRutalanCversion, lxRutalanUsuario, lxRutalanFecha, lxRutalanSerie, lxRutalanArchivo, lxRutalanPublicada
				lxRutalanFecexpo =  .Fechaexpo			lxRutalanFmodifw =  .Fechamodificacionfw			lxRutalanFaltafw =  .Fechaaltafw			lxRutalanFectrans =  .Fechatransferencia			lxRutalanFecimpo =  .Fechaimpo			lxRutalanCodigo =  .Codigo			lxRutalanSmodifw =  .Seriemodificacionfw			lxRutalanHmodifw =  .Horamodificacionfw			lxRutalanSaltafw =  .Seriealtafw			lxRutalanUaltafw =  .Usuarioaltafw			lxRutalanVmodifw =  .Versionmodificacionfw			lxRutalanZadsfw =  .Zadsfw			lxRutalanValtafw =  .Versionaltafw			lxRutalanHoraimpo =  .Horaimpo			lxRutalanUmodifw =  .Usuariomodificacionfw			lxRutalanHaltafw =  .Horaaltafw			lxRutalanBdmodifw =  .Basededatosmodificacionfw			lxRutalanBdaltafw =  .Basededatosaltafw			lxRutalanEsttrans =  .Estadotransferencia			lxRutalanHoraexpo =  .Horaexpo			lxRutalanClobs =  .Observacion			lxRutalanCversion =  .Version			lxRutalanUsuario =  .Usuario			lxRutalanFecha =  .Fecha			lxRutalanSerie =  .Serie			lxRutalanArchivo =  .Archivoentrada			lxRutalanPublicada =  .Publicada
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.RUTALAN ( "Fecexpo","Fmodifw","Faltafw","Fectrans","Fecimpo","Codigo","Smodifw","Hmodifw","Saltafw","Ualtafw","Vmodifw","Zadsfw","Valtafw","Horaimpo","Umodifw","Haltafw","Bdmodifw","Bdaltafw","Esttrans","Horaexpo","Clobs","Cversion","Usuario","Fecha","Serie","Archivo","Publicada" ) values ( <<"'" + this.ConvertirDateSql( lxRutalanFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFecimpo ) + "'" >>, <<lxRutalanCodigo >>, <<"'" + this.FormatearTextoSql( lxRutalanSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanCversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanUsuario ) + "'" >>, <<"'" + this.ConvertirDateSql( lxRutalanFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxRutalanArchivo ) + "'" >>, <<iif( lxRutalanPublicada, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'RUTALAN' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxRutalanFecexpo, lxRutalanFmodifw, lxRutalanFaltafw, lxRutalanFectrans, lxRutalanFecimpo, lxRutalanCodigo, lxRutalanSmodifw, lxRutalanHmodifw, lxRutalanSaltafw, lxRutalanUaltafw, lxRutalanVmodifw, lxRutalanZadsfw, lxRutalanValtafw, lxRutalanHoraimpo, lxRutalanUmodifw, lxRutalanHaltafw, lxRutalanBdmodifw, lxRutalanBdaltafw, lxRutalanEsttrans, lxRutalanHoraexpo, lxRutalanClobs, lxRutalanCversion, lxRutalanUsuario, lxRutalanFecha, lxRutalanSerie, lxRutalanArchivo, lxRutalanPublicada
				lxRutalanFecexpo =  .Fechaexpo			lxRutalanFmodifw =  .Fechamodificacionfw			lxRutalanFaltafw =  .Fechaaltafw			lxRutalanFectrans =  .Fechatransferencia			lxRutalanFecimpo =  .Fechaimpo			lxRutalanCodigo =  .Codigo			lxRutalanSmodifw =  .Seriemodificacionfw			lxRutalanHmodifw =  .Horamodificacionfw			lxRutalanSaltafw =  .Seriealtafw			lxRutalanUaltafw =  .Usuarioaltafw			lxRutalanVmodifw =  .Versionmodificacionfw			lxRutalanZadsfw =  .Zadsfw			lxRutalanValtafw =  .Versionaltafw			lxRutalanHoraimpo =  .Horaimpo			lxRutalanUmodifw =  .Usuariomodificacionfw			lxRutalanHaltafw =  .Horaaltafw			lxRutalanBdmodifw =  .Basededatosmodificacionfw			lxRutalanBdaltafw =  .Basededatosaltafw			lxRutalanEsttrans =  .Estadotransferencia			lxRutalanHoraexpo =  .Horaexpo			lxRutalanClobs =  .Observacion			lxRutalanCversion =  .Version			lxRutalanUsuario =  .Usuario			lxRutalanFecha =  .Fecha			lxRutalanSerie =  .Serie			lxRutalanArchivo =  .Archivoentrada			lxRutalanPublicada =  .Publicada
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  RUTALAN.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ORGANIZACION.RUTALAN set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxRutalanFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxRutalanFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxRutalanFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxRutalanFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxRutalanFecimpo ) + "'">>, "Codigo" = <<lxRutalanCodigo>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxRutalanSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxRutalanHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxRutalanSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxRutalanUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxRutalanVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxRutalanZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxRutalanValtafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxRutalanHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxRutalanUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxRutalanHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxRutalanBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxRutalanBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxRutalanEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxRutalanHoraexpo ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxRutalanClobs ) + "'">>, "Cversion" = <<"'" + this.FormatearTextoSql( lxRutalanCversion ) + "'">>, "Usuario" = <<"'" + this.FormatearTextoSql( lxRutalanUsuario ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxRutalanFecha ) + "'">>, "Serie" = <<"'" + this.FormatearTextoSql( lxRutalanSerie ) + "'">>, "Archivo" = <<"'" + this.FormatearTextoSql( lxRutalanArchivo ) + "'">>, "Publicada" = <<iif( lxRutalanPublicada, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'RUTALAN' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
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
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  RUTALAN.CODIGO != 0]
		loColeccion.Agregar( 'delete from ORGANIZACION.RUTALAN where ' + lcFiltro )
			loColeccion.cTabla = 'RUTALAN' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.RUTALAN where  RUTALAN.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.RUTALAN where Codigo = " + transform( this.oEntidad.CODIGO )+ " and  RUTALAN.CODIGO != 0" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarNumeraciones() as void
		local loError as exception
		dodefault()

		with this.oEntidad
			if .VerificarContexto( 'C' )
			else
				.lCargando = .t.
				try
					if empty( .oNumeraciones.ObtenerServicio('CODIGO') ) and iif( type( '.CODIGO' ) = 'C', int( val( .CODIGO ) ),.CODIGO ) = .oNumeraciones.UltimoNumero( 'CODIGO' )
						.oNumeraciones.Actualizar( 'CODIGO' )
					endif
				catch to loError
					goServicios.Errores.LevantarExcepcion( loError ) 
				finally
					.lCargando = .f.
				endtry
			endif
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function GrabarNumeraciones() as void

		dodefault()

		with this.oEntidad
			.lCargando = .t.
			Try
				If .VerificarContexto( 'C' )
				Else
					.CODIGO = .oNumeraciones.grabar( 'CODIGO' )
				EndIf
			Catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			Finally
				.lCargando = .f.
			EndTry
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxrutalanCVERSION as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ZUDESCARGALAN'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.RUTALAN Where  CVERSION = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSION   ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.RUTALAN set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, Codigo = ] + transform( &lcCursor..Codigo )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CVERSION = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'"+ [, usuario = ] + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"+ [, fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..fecha ) + "'"+ [, Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'"+ [, Archivo = ] + "'" + this.FormatearTextoSql( &lcCursor..Archivo ) + "'"+ [, publicada = ] + Transform( iif( &lcCursor..publicada, 1, 0 )) + [ Where Codigo = ] + transform( lcValorABuscar ) )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.RUTALAN Where Codigo = ] + transform( &lcCursor..Codigo ), 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FMODIFW, FALTAFW, FECTRANS, FECIMPO, Codigo, SMODIFW, HMODIFW, SALTAFW, UALTAFW, VMODIFW, ZADSFW, VALTAFW, HORAIMPO, UMODIFW, HALTAFW, BDMODIFW, BDALTAFW, ESTTRANS, HORAEXPO, CLOBS, CVERSION, usuario, fecha, Serie, Archivo, publicada
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..Codigo ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Archivo ) + "'" + ',' + Transform( iif( &lcCursor..publicada, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.RUTALAN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ZUDESCARGALAN'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo N (9) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Versión: ' + transform( &tcCursor..CVERSION   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ZUDESCARGALAN'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ZUDESCARGALAN_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ZUDESCARGALAN_CLOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_rutalan')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ZUDESCARGALAN'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..CVERSION )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ZUDESCARGALAN. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ZUDESCARGALAN'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,CVERSION as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CVERSION, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ZUDESCARGALAN'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_rutalan') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_rutalan
Create Table ORGANIZACION.TablaTrabajo_rutalan ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"codigo" numeric( 9, 0 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"clobs" varchar(max)  null, 
"cversion" char( 13 )  null, 
"usuario" char( 100 )  null, 
"fecha" datetime  null, 
"serie" char( 7 )  null, 
"archivo" char( 254 )  null, 
"publicada" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_rutalan' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_rutalan' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ZUDESCARGALAN'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('cversion','cversion')
			.AgregarMapeo('usuario','usuario')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('archivo','archivo')
			.AgregarMapeo('publicada','publicada')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_rutalan'
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
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ORGANIZACION.DELETE_<<lcTabla>>
				ON ORGANIZACION.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CVERSION = isnull( d.CVERSION, t.CVERSION ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.ARCHIVO = isnull( d.ARCHIVO, t.ARCHIVO ),t.PUBLICADA = isnull( d.PUBLICADA, t.PUBLICADA )
					from ORGANIZACION.RUTALAN t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.CVERSION = d.CVERSION
				-- Fin Updates
				insert into ORGANIZACION.RUTALAN(Fecexpo,Fmodifw,Faltafw,Fectrans,Fecimpo,Codigo,Smodifw,Hmodifw,Saltafw,Ualtafw,Vmodifw,Zadsfw,Valtafw,Horaimpo,Umodifw,Haltafw,Bdmodifw,Bdaltafw,Esttrans,Horaexpo,Clobs,Cversion,Usuario,Fecha,Serie,Archivo,Publicada)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.CODIGO,0),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.CLOBS,''),isnull( d.CVERSION,''),isnull( d.USUARIO,''),isnull( d.FECHA,''),isnull( d.SERIE,''),isnull( d.ARCHIVO,''),isnull( d.PUBLICADA,0)
						From deleted d left join ORGANIZACION.RUTALAN pk 
							 on d.Codigo = pk.Codigo
						 left join ORGANIZACION.RUTALAN cc 
							 on  d.CVERSION = cc.CVERSION
						Where pk.Codigo Is Null 
							 and cc.CVERSION Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: VERSIÓN ' + cast( d.CVERSION as Varchar(13) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.RUTALAN t inner join deleted d 
							on   t.CVERSION = d.CVERSION
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: VERSIÓN ' + cast( d.CVERSION as Varchar(13) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.RUTALAN t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.CVERSION = h.CVERSION
							where   h.CVERSION is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_rutalan') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_rutalan
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ZUDESCARGALAN' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ZUDESCARGALAN.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ZUDESCARGALAN.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ZUDESCARGALAN.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ZUDESCARGALAN.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ZUDESCARGALAN.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_ZUDESCARGALAN.Codigo, 0 )
					.Seriemodificacionfw = nvl( c_ZUDESCARGALAN.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ZUDESCARGALAN.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_ZUDESCARGALAN.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_ZUDESCARGALAN.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_ZUDESCARGALAN.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ZUDESCARGALAN.Versionaltafw, [] )
					.Horaimpo = nvl( c_ZUDESCARGALAN.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_ZUDESCARGALAN.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_ZUDESCARGALAN.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ZUDESCARGALAN.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_ZUDESCARGALAN.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_ZUDESCARGALAN.Estadotransferencia, [] )
					.Horaexpo = nvl( c_ZUDESCARGALAN.Horaexpo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Version = nvl( c_ZUDESCARGALAN.Version, [] )
					.Usuario = nvl( c_ZUDESCARGALAN.Usuario, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ZUDESCARGALAN.Fecha, ctod( '  /  /    ' ) ) )
					.Serie = nvl( c_ZUDESCARGALAN.Serie, [] )
					.Archivoentrada = nvl( c_ZUDESCARGALAN.Archivoentrada, [] )
					.Publicada = nvl( c_ZUDESCARGALAN.Publicada, .F. )
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
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_ZUDESCARGALAN.CODIGO
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
		return c_ZUDESCARGALAN.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		local lcNombreBD as String 
		lcNombreBD = ''
		lcNombreBD = this.oConexion.ObtenerNombreBD( 'ZOOLOGICMASTER' )
		lcNombreBD = goLibrerias.EscapeCaracteresSqlServer( lcNombreBD )

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.RUTALAN' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,Codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    Codigo from (
							select * 
								from ORGANIZACION.RUTALAN 
								Where   RUTALAN.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "RUTALAN", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "Codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Codigo" as "Codigo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Clobs" as "Observacion", "Cversion" as "Version", "Usuario" as "Usuario", "Fecha" as "Fecha", "Serie" as "Serie", "Archivo" as "Archivoentrada", "Publicada" as "Publicada"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.RUTALAN 
								Where   RUTALAN.CODIGO != 0
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
	Tabla = 'RUTALAN'
	Filtro = " RUTALAN.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " RUTALAN.CODIGO != 0"
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
	<row entidad="ZUDESCARGALAN                           " atributo="FECHAEXPO                               " tabla="RUTALAN        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="FECHAMODIFICACIONFW                     " tabla="RUTALAN        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="FECHAALTAFW                             " tabla="RUTALAN        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="FECHATRANSFERENCIA                      " tabla="RUTALAN        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="FECHAIMPO                               " tabla="RUTALAN        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="CODIGO                                  " tabla="RUTALAN        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="@ObtenerSiguienteNumerico()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="SERIEMODIFICACIONFW                     " tabla="RUTALAN        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="HORAMODIFICACIONFW                      " tabla="RUTALAN        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="SERIEALTAFW                             " tabla="RUTALAN        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="USUARIOALTAFW                           " tabla="RUTALAN        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="VERSIONMODIFICACIONFW                   " tabla="RUTALAN        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="ZADSFW                                  " tabla="RUTALAN        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="VERSIONALTAFW                           " tabla="RUTALAN        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="HORAIMPO                                " tabla="RUTALAN        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="USUARIOMODIFICACIONFW                   " tabla="RUTALAN        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="HORAALTAFW                              " tabla="RUTALAN        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="RUTALAN        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="BASEDEDATOSALTAFW                       " tabla="RUTALAN        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="ESTADOTRANSFERENCIA                     " tabla="RUTALAN        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="HORAEXPO                                " tabla="RUTALAN        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="OBSERVACION                             " tabla="RUTALAN        " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="VERSION                                 " tabla="RUTALAN        " campo="CVERSION  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="=_screen.zoo.app.ObtenerVersion()                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="2" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="USUARIO                                 " tabla="RUTALAN        " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="4" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="FECHA                                   " tabla="RUTALAN        " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="3" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="SERIE                                   " tabla="RUTALAN        " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="=_Screen.Zoo.App.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="3" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="ARCHIVOENTRADA                          " tabla="RUTALAN        " campo="ARCHIVO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="Archivo                                                                                                                                                         " dominio="ARCHIVO                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ZUDESCARGALAN                           " atributo="PUBLICADA                               " tabla="RUTALAN        " campo="PUBLICADA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Publicada                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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