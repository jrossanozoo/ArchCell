
define class Din_EntidadLINKQRENETIQUETAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LINKQRENETIQUETA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_LQRPK'
	cTablaPrincipal = 'LINKQRETI'
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
			local  lxLinkqretiFecexpo, lxLinkqretiFectrans, lxLinkqretiFmodifw, lxLinkqretiFaltafw, lxLinkqretiFecimpo, lxLinkqretiTimestamp, lxLinkqretiSaltafw, lxLinkqretiZadsfw, lxLinkqretiSmodifw, lxLinkqretiUmodifw, lxLinkqretiUaltafw, lxLinkqretiValtafw, lxLinkqretiHmodifw, lxLinkqretiVmodifw, lxLinkqretiHaltafw, lxLinkqretiBdmodifw, lxLinkqretiHoraimpo, lxLinkqretiBdaltafw, lxLinkqretiEsttrans, lxLinkqretiHoraexpo, lxLinkqretiLqrcod, lxLinkqretiArtcod, lxLinkqretiCodcol, lxLinkqretiCodtall, lxLinkqretiQrlink1, lxLinkqretiQrlink2, lxLinkqretiQrlink3, lxLinkqretiObs
				lxLinkqretiFecexpo =  .Fechaexpo			lxLinkqretiFectrans =  .Fechatransferencia			lxLinkqretiFmodifw =  .Fechamodificacionfw			lxLinkqretiFaltafw =  .Fechaaltafw			lxLinkqretiFecimpo =  .Fechaimpo			lxLinkqretiTimestamp = goLibrerias.ObtenerTimestamp()			lxLinkqretiSaltafw =  .Seriealtafw			lxLinkqretiZadsfw =  .Zadsfw			lxLinkqretiSmodifw =  .Seriemodificacionfw			lxLinkqretiUmodifw =  .Usuariomodificacionfw			lxLinkqretiUaltafw =  .Usuarioaltafw			lxLinkqretiValtafw =  .Versionaltafw			lxLinkqretiHmodifw =  .Horamodificacionfw			lxLinkqretiVmodifw =  .Versionmodificacionfw			lxLinkqretiHaltafw =  .Horaaltafw			lxLinkqretiBdmodifw =  .Basededatosmodificacionfw			lxLinkqretiHoraimpo =  .Horaimpo			lxLinkqretiBdaltafw =  .Basededatosaltafw			lxLinkqretiEsttrans =  .Estadotransferencia			lxLinkqretiHoraexpo =  .Horaexpo			lxLinkqretiLqrcod =  .Codigo			lxLinkqretiArtcod =  upper( .Articulo_PK ) 			lxLinkqretiCodcol =  upper( .Color_PK ) 			lxLinkqretiCodtall =  .Talle			lxLinkqretiQrlink1 =  .Qrlink1			lxLinkqretiQrlink2 =  .Qrlink2			lxLinkqretiQrlink3 =  .Qrlink3			lxLinkqretiObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLinkqretiLqrcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LINKQRETI ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Timestamp","Saltafw","Zadsfw","Smodifw","Umodifw","Ualtafw","Valtafw","Hmodifw","Vmodifw","Haltafw","Bdmodifw","Horaimpo","Bdaltafw","Esttrans","Horaexpo","Lqrcod","Artcod","Codcol","Codtall","Qrlink1","Qrlink2","Qrlink3","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxLinkqretiFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFecimpo ) + "'" >>, <<lxLinkqretiTimestamp >>, <<"'" + this.FormatearTextoSql( lxLinkqretiSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiArtcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiCodcol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiCodtall ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink3 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiObs ) + "'" >> )
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
		this.oEntidad.Timestamp = lxLinkqretiTimestamp
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
			local  lxLinkqretiFecexpo, lxLinkqretiFectrans, lxLinkqretiFmodifw, lxLinkqretiFaltafw, lxLinkqretiFecimpo, lxLinkqretiTimestamp, lxLinkqretiSaltafw, lxLinkqretiZadsfw, lxLinkqretiSmodifw, lxLinkqretiUmodifw, lxLinkqretiUaltafw, lxLinkqretiValtafw, lxLinkqretiHmodifw, lxLinkqretiVmodifw, lxLinkqretiHaltafw, lxLinkqretiBdmodifw, lxLinkqretiHoraimpo, lxLinkqretiBdaltafw, lxLinkqretiEsttrans, lxLinkqretiHoraexpo, lxLinkqretiLqrcod, lxLinkqretiArtcod, lxLinkqretiCodcol, lxLinkqretiCodtall, lxLinkqretiQrlink1, lxLinkqretiQrlink2, lxLinkqretiQrlink3, lxLinkqretiObs
				lxLinkqretiFecexpo =  .Fechaexpo			lxLinkqretiFectrans =  .Fechatransferencia			lxLinkqretiFmodifw =  .Fechamodificacionfw			lxLinkqretiFaltafw =  .Fechaaltafw			lxLinkqretiFecimpo =  .Fechaimpo			lxLinkqretiTimestamp = goLibrerias.ObtenerTimestamp()			lxLinkqretiSaltafw =  .Seriealtafw			lxLinkqretiZadsfw =  .Zadsfw			lxLinkqretiSmodifw =  .Seriemodificacionfw			lxLinkqretiUmodifw =  .Usuariomodificacionfw			lxLinkqretiUaltafw =  .Usuarioaltafw			lxLinkqretiValtafw =  .Versionaltafw			lxLinkqretiHmodifw =  .Horamodificacionfw			lxLinkqretiVmodifw =  .Versionmodificacionfw			lxLinkqretiHaltafw =  .Horaaltafw			lxLinkqretiBdmodifw =  .Basededatosmodificacionfw			lxLinkqretiHoraimpo =  .Horaimpo			lxLinkqretiBdaltafw =  .Basededatosaltafw			lxLinkqretiEsttrans =  .Estadotransferencia			lxLinkqretiHoraexpo =  .Horaexpo			lxLinkqretiLqrcod =  .Codigo			lxLinkqretiArtcod =  upper( .Articulo_PK ) 			lxLinkqretiCodcol =  upper( .Color_PK ) 			lxLinkqretiCodtall =  .Talle			lxLinkqretiQrlink1 =  .Qrlink1			lxLinkqretiQrlink2 =  .Qrlink2			lxLinkqretiQrlink3 =  .Qrlink3			lxLinkqretiObs =  .Observacion
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.LINKQRETI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLinkqretiFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLinkqretiFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLinkqretiFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLinkqretiFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLinkqretiFecimpo ) + "'">>,"Timestamp" = <<lxLinkqretiTimestamp>>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLinkqretiZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiUaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiValtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLinkqretiHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLinkqretiEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLinkqretiHoraexpo ) + "'">>,"Lqrcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'">>,"Artcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiArtcod ) + "'">>,"Codcol" = <<"'" + this.FormatearTextoSql( lxLinkqretiCodcol ) + "'">>,"Codtall" = <<"'" + this.FormatearTextoSql( lxLinkqretiCodtall ) + "'">>,"Qrlink1" = <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink1 ) + "'">>,"Qrlink2" = <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink2 ) + "'">>,"Qrlink3" = <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink3 ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxLinkqretiObs ) + "'">> where "Lqrcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'">> and  LINKQRETI.LQRCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxLinkqretiTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 LQrCod from ZooLogic.LINKQRETI where " + this.ConvertirFuncionesSql( " LINKQRETI.LQRCOD != ''" ) )
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
			Local lxLinkqretiLqrcod
			lxLinkqretiLqrcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion" from ZooLogic.LINKQRETI where "Lqrcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'">> and  LINKQRETI.LQRCOD != ''
			endtext
			use in select('c_LINKQRENETIQUETA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LINKQRENETIQUETA', set( 'Datasession' ) )

			if reccount( 'c_LINKQRENETIQUETA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLinkqretiLqrcod as Variant
		llRetorno = .t.
		lxLinkqretiLqrcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LINKQRETI where "Lqrcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'">> and  LINKQRETI.LQRCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion" from ZooLogic.LINKQRETI where  LINKQRETI.LQRCOD != '' order by LQrCod
			endtext
			use in select('c_LINKQRENETIQUETA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LINKQRENETIQUETA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion" from ZooLogic.LINKQRETI where  funciones.padr( LQrCod, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LINKQRETI.LQRCOD != '' order by LQrCod
			endtext
			use in select('c_LINKQRENETIQUETA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LINKQRENETIQUETA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion" from ZooLogic.LINKQRETI where  funciones.padr( LQrCod, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LINKQRETI.LQRCOD != '' order by LQrCod desc
			endtext
			use in select('c_LINKQRENETIQUETA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LINKQRENETIQUETA', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion" from ZooLogic.LINKQRETI where  LINKQRETI.LQRCOD != '' order by LQrCod desc
			endtext
			use in select('c_LINKQRENETIQUETA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LINKQRENETIQUETA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Timestamp,Saltafw,Zadsfw,Smodifw,Umodifw,Ualtafw,Va" + ;
"ltafw,Hmodifw,Vmodifw,Haltafw,Bdmodifw,Horaimpo,Bdaltafw,Esttrans,Horaexpo,Lqrcod,Artcod,Codcol,Codt" + ;
"all,Qrlink1,Qrlink2,Qrlink3,Obs" + ;
" from ZooLogic.LINKQRETI where  LINKQRETI.LQRCOD != '' and " + lcFiltro )
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
			local  lxLinkqretiFecexpo, lxLinkqretiFectrans, lxLinkqretiFmodifw, lxLinkqretiFaltafw, lxLinkqretiFecimpo, lxLinkqretiTimestamp, lxLinkqretiSaltafw, lxLinkqretiZadsfw, lxLinkqretiSmodifw, lxLinkqretiUmodifw, lxLinkqretiUaltafw, lxLinkqretiValtafw, lxLinkqretiHmodifw, lxLinkqretiVmodifw, lxLinkqretiHaltafw, lxLinkqretiBdmodifw, lxLinkqretiHoraimpo, lxLinkqretiBdaltafw, lxLinkqretiEsttrans, lxLinkqretiHoraexpo, lxLinkqretiLqrcod, lxLinkqretiArtcod, lxLinkqretiCodcol, lxLinkqretiCodtall, lxLinkqretiQrlink1, lxLinkqretiQrlink2, lxLinkqretiQrlink3, lxLinkqretiObs
				lxLinkqretiFecexpo = ctod( '  /  /    ' )			lxLinkqretiFectrans = ctod( '  /  /    ' )			lxLinkqretiFmodifw = ctod( '  /  /    ' )			lxLinkqretiFaltafw = ctod( '  /  /    ' )			lxLinkqretiFecimpo = ctod( '  /  /    ' )			lxLinkqretiTimestamp = goLibrerias.ObtenerTimestamp()			lxLinkqretiSaltafw = []			lxLinkqretiZadsfw = []			lxLinkqretiSmodifw = []			lxLinkqretiUmodifw = []			lxLinkqretiUaltafw = []			lxLinkqretiValtafw = []			lxLinkqretiHmodifw = []			lxLinkqretiVmodifw = []			lxLinkqretiHaltafw = []			lxLinkqretiBdmodifw = []			lxLinkqretiHoraimpo = []			lxLinkqretiBdaltafw = []			lxLinkqretiEsttrans = []			lxLinkqretiHoraexpo = []			lxLinkqretiLqrcod = []			lxLinkqretiArtcod = []			lxLinkqretiCodcol = []			lxLinkqretiCodtall = []			lxLinkqretiQrlink1 = []			lxLinkqretiQrlink2 = []			lxLinkqretiQrlink3 = []			lxLinkqretiObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LINKQRETI where "LQrCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LINKQRETI' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where LQrCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(LQrCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LINKQRETI.LQRCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LINKQRETI', '', tnTope )
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LQRCOD AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCOD AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOL AS COLOR'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALL AS TALLE'
				Case lcAtributo == 'QRLINK1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'QRLINK1 AS QRLINK1'
				Case lcAtributo == 'QRLINK2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'QRLINK2 AS QRLINK2'
				Case lcAtributo == 'QRLINK3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'QRLINK3 AS QRLINK3'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'LQRCOD'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTCOD'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOL'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALL'
			Case upper( alltrim( tcAtributo ) ) == 'QRLINK1'
				lcCampo = 'QRLINK1'
			Case upper( alltrim( tcAtributo ) ) == 'QRLINK2'
				lcCampo = 'QRLINK2'
			Case upper( alltrim( tcAtributo ) ) == 'QRLINK3'
				lcCampo = 'QRLINK3'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
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
			local  lxLinkqretiFecexpo, lxLinkqretiFectrans, lxLinkqretiFmodifw, lxLinkqretiFaltafw, lxLinkqretiFecimpo, lxLinkqretiTimestamp, lxLinkqretiSaltafw, lxLinkqretiZadsfw, lxLinkqretiSmodifw, lxLinkqretiUmodifw, lxLinkqretiUaltafw, lxLinkqretiValtafw, lxLinkqretiHmodifw, lxLinkqretiVmodifw, lxLinkqretiHaltafw, lxLinkqretiBdmodifw, lxLinkqretiHoraimpo, lxLinkqretiBdaltafw, lxLinkqretiEsttrans, lxLinkqretiHoraexpo, lxLinkqretiLqrcod, lxLinkqretiArtcod, lxLinkqretiCodcol, lxLinkqretiCodtall, lxLinkqretiQrlink1, lxLinkqretiQrlink2, lxLinkqretiQrlink3, lxLinkqretiObs
				lxLinkqretiFecexpo =  .Fechaexpo			lxLinkqretiFectrans =  .Fechatransferencia			lxLinkqretiFmodifw =  .Fechamodificacionfw			lxLinkqretiFaltafw =  .Fechaaltafw			lxLinkqretiFecimpo =  .Fechaimpo			lxLinkqretiTimestamp = goLibrerias.ObtenerTimestamp()			lxLinkqretiSaltafw =  .Seriealtafw			lxLinkqretiZadsfw =  .Zadsfw			lxLinkqretiSmodifw =  .Seriemodificacionfw			lxLinkqretiUmodifw =  .Usuariomodificacionfw			lxLinkqretiUaltafw =  .Usuarioaltafw			lxLinkqretiValtafw =  .Versionaltafw			lxLinkqretiHmodifw =  .Horamodificacionfw			lxLinkqretiVmodifw =  .Versionmodificacionfw			lxLinkqretiHaltafw =  .Horaaltafw			lxLinkqretiBdmodifw =  .Basededatosmodificacionfw			lxLinkqretiHoraimpo =  .Horaimpo			lxLinkqretiBdaltafw =  .Basededatosaltafw			lxLinkqretiEsttrans =  .Estadotransferencia			lxLinkqretiHoraexpo =  .Horaexpo			lxLinkqretiLqrcod =  .Codigo			lxLinkqretiArtcod =  upper( .Articulo_PK ) 			lxLinkqretiCodcol =  upper( .Color_PK ) 			lxLinkqretiCodtall =  .Talle			lxLinkqretiQrlink1 =  .Qrlink1			lxLinkqretiQrlink2 =  .Qrlink2			lxLinkqretiQrlink3 =  .Qrlink3			lxLinkqretiObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LINKQRETI ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Timestamp","Saltafw","Zadsfw","Smodifw","Umodifw","Ualtafw","Valtafw","Hmodifw","Vmodifw","Haltafw","Bdmodifw","Horaimpo","Bdaltafw","Esttrans","Horaexpo","Lqrcod","Artcod","Codcol","Codtall","Qrlink1","Qrlink2","Qrlink3","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxLinkqretiFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLinkqretiFecimpo ) + "'" >>, <<lxLinkqretiTimestamp >>, <<"'" + this.FormatearTextoSql( lxLinkqretiSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiArtcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiCodcol ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiCodtall ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink1 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink3 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLinkqretiObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'LINKQRETI' 
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
			local  lxLinkqretiFecexpo, lxLinkqretiFectrans, lxLinkqretiFmodifw, lxLinkqretiFaltafw, lxLinkqretiFecimpo, lxLinkqretiTimestamp, lxLinkqretiSaltafw, lxLinkqretiZadsfw, lxLinkqretiSmodifw, lxLinkqretiUmodifw, lxLinkqretiUaltafw, lxLinkqretiValtafw, lxLinkqretiHmodifw, lxLinkqretiVmodifw, lxLinkqretiHaltafw, lxLinkqretiBdmodifw, lxLinkqretiHoraimpo, lxLinkqretiBdaltafw, lxLinkqretiEsttrans, lxLinkqretiHoraexpo, lxLinkqretiLqrcod, lxLinkqretiArtcod, lxLinkqretiCodcol, lxLinkqretiCodtall, lxLinkqretiQrlink1, lxLinkqretiQrlink2, lxLinkqretiQrlink3, lxLinkqretiObs
				lxLinkqretiFecexpo =  .Fechaexpo			lxLinkqretiFectrans =  .Fechatransferencia			lxLinkqretiFmodifw =  .Fechamodificacionfw			lxLinkqretiFaltafw =  .Fechaaltafw			lxLinkqretiFecimpo =  .Fechaimpo			lxLinkqretiTimestamp = goLibrerias.ObtenerTimestamp()			lxLinkqretiSaltafw =  .Seriealtafw			lxLinkqretiZadsfw =  .Zadsfw			lxLinkqretiSmodifw =  .Seriemodificacionfw			lxLinkqretiUmodifw =  .Usuariomodificacionfw			lxLinkqretiUaltafw =  .Usuarioaltafw			lxLinkqretiValtafw =  .Versionaltafw			lxLinkqretiHmodifw =  .Horamodificacionfw			lxLinkqretiVmodifw =  .Versionmodificacionfw			lxLinkqretiHaltafw =  .Horaaltafw			lxLinkqretiBdmodifw =  .Basededatosmodificacionfw			lxLinkqretiHoraimpo =  .Horaimpo			lxLinkqretiBdaltafw =  .Basededatosaltafw			lxLinkqretiEsttrans =  .Estadotransferencia			lxLinkqretiHoraexpo =  .Horaexpo			lxLinkqretiLqrcod =  .Codigo			lxLinkqretiArtcod =  upper( .Articulo_PK ) 			lxLinkqretiCodcol =  upper( .Color_PK ) 			lxLinkqretiCodtall =  .Talle			lxLinkqretiQrlink1 =  .Qrlink1			lxLinkqretiQrlink2 =  .Qrlink2			lxLinkqretiQrlink3 =  .Qrlink3			lxLinkqretiObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Lqrcod" = ] + lcValorClavePrimariaString  + [ and  LINKQRETI.LQRCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.LINKQRETI set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLinkqretiFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLinkqretiFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLinkqretiFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLinkqretiFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLinkqretiFecimpo ) + "'">>, "Timestamp" = <<lxLinkqretiTimestamp>>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLinkqretiZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiUaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiValtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLinkqretiBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLinkqretiHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLinkqretiBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLinkqretiEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLinkqretiHoraexpo ) + "'">>, "Lqrcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiLqrcod ) + "'">>, "Artcod" = <<"'" + this.FormatearTextoSql( lxLinkqretiArtcod ) + "'">>, "Codcol" = <<"'" + this.FormatearTextoSql( lxLinkqretiCodcol ) + "'">>, "Codtall" = <<"'" + this.FormatearTextoSql( lxLinkqretiCodtall ) + "'">>, "Qrlink1" = <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink1 ) + "'">>, "Qrlink2" = <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink2 ) + "'">>, "Qrlink3" = <<"'" + this.FormatearTextoSql( lxLinkqretiQrlink3 ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxLinkqretiObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LINKQRETI' 
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
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Lqrcod" = ] + lcValorClavePrimariaString  + [ and  LINKQRETI.LQRCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.LINKQRETI where ' + lcFiltro )
			loColeccion.cTabla = 'LINKQRETI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LINKQRETI where  LINKQRETI.LQRCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LINKQRETI where LQrCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  LINKQRETI.LQRCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LINKQRENETIQUETA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LINKQRETI Where LQrCod = ] + "'" + this.FormatearTextoSql( &lcCursor..LQrCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.LINKQRETI set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, LQrCod = ] + "'" + this.FormatearTextoSql( &lcCursor..LQrCod ) + "'"+ [, ArtCod = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtCod ) + "'"+ [, CodCol = ] + "'" + this.FormatearTextoSql( &lcCursor..CodCol ) + "'"+ [, CodTall = ] + "'" + this.FormatearTextoSql( &lcCursor..CodTall ) + "'"+ [, QRLink1 = ] + "'" + this.FormatearTextoSql( &lcCursor..QRLink1 ) + "'"+ [, QRLink2 = ] + "'" + this.FormatearTextoSql( &lcCursor..QRLink2 ) + "'"+ [, QRLink3 = ] + "'" + this.FormatearTextoSql( &lcCursor..QRLink3 ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where LQrCod = ] + "'" + this.FormatearTextoSql( &lcCursor..LQrCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, TIMESTAMP, SALTAFW, ZADSFW, SMODIFW, UMODIFW, UALTAFW, VALTAFW, HMODIFW, VMODIFW, HALTAFW, BDMODIFW, HORAIMPO, BDALTAFW, ESTTRANS, HORAEXPO, LQrCod, ArtCod, CodCol, CodTall, QRLink1, QRLink2, QRLink3, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LQrCod ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodCol ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodTall ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..QRLink1 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..QRLink2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..QRLink3 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.LINKQRETI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LINKQRENETIQUETA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( LQrCod C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..LQrCod     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LINKQRENETIQUETA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LINKQRENETIQUETA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LINKQRENETIQUETA_QRLINK1'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LINKQRENETIQUETA_QRLINK2'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LINKQRENETIQUETA_QRLINK3'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LINKQRENETIQUETA_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_LINKQRETI')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LINKQRENETIQUETA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..LQrCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LINKQRENETIQUETA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LINKQRENETIQUETA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,LQrCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( LQrCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LINKQRENETIQUETA'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LINKQRETI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LINKQRETI
Create Table ZooLogic.TablaTrabajo_LINKQRETI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"lqrcod" char( 20 )  null, 
"artcod" char( 13 )  null, 
"codcol" char( 2 )  null, 
"codtall" char( 3 )  null, 
"qrlink1" varchar(max)  null, 
"qrlink2" varchar(max)  null, 
"qrlink3" varchar(max)  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_LINKQRETI' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_LINKQRETI' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LINKQRENETIQUETA'
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
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('lqrcod','lqrcod')
			.AgregarMapeo('artcod','artcod')
			.AgregarMapeo('codcol','codcol')
			.AgregarMapeo('codtall','codtall')
			.AgregarMapeo('qrlink1','qrlink1')
			.AgregarMapeo('qrlink2','qrlink2')
			.AgregarMapeo('qrlink3','qrlink3')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_LINKQRETI'
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
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.LQRCOD = isnull( d.LQRCOD, t.LQRCOD ),t.ARTCOD = isnull( d.ARTCOD, t.ARTCOD ),t.CODCOL = isnull( d.CODCOL, t.CODCOL ),t.CODTALL = isnull( d.CODTALL, t.CODTALL ),t.QRLINK1 = isnull( d.QRLINK1, t.QRLINK1 ),t.QRLINK2 = isnull( d.QRLINK2, t.QRLINK2 ),t.QRLINK3 = isnull( d.QRLINK3, t.QRLINK3 ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.LINKQRETI t inner join deleted d 
							 on t.LQrCod = d.LQrCod
				-- Fin Updates
				insert into ZooLogic.LINKQRETI(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Timestamp,Saltafw,Zadsfw,Smodifw,Umodifw,Ualtafw,Valtafw,Hmodifw,Vmodifw,Haltafw,Bdmodifw,Horaimpo,Bdaltafw,Esttrans,Horaexpo,Lqrcod,Artcod,Codcol,Codtall,Qrlink1,Qrlink2,Qrlink3,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.TIMESTAMP,0),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.LQRCOD,''),isnull( d.ARTCOD,''),isnull( d.CODCOL,''),isnull( d.CODTALL,''),isnull( d.QRLINK1,''),isnull( d.QRLINK2,''),isnull( d.QRLINK3,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.LINKQRETI pk 
							 on d.LQrCod = pk.LQrCod
						Where pk.LQrCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LINKQRETI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LINKQRETI
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LINKQRENETIQUETA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LINKQRENETIQUETA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LINKQRENETIQUETA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LINKQRENETIQUETA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LINKQRENETIQUETA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LINKQRENETIQUETA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_LINKQRENETIQUETA.Timestamp, 0 )
					.Seriealtafw = nvl( c_LINKQRENETIQUETA.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_LINKQRENETIQUETA.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_LINKQRENETIQUETA.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_LINKQRENETIQUETA.Usuarioaltafw, [] )
					.Versionaltafw = nvl( c_LINKQRENETIQUETA.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_LINKQRENETIQUETA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_LINKQRENETIQUETA.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_LINKQRENETIQUETA.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_LINKQRENETIQUETA.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_LINKQRENETIQUETA.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_LINKQRENETIQUETA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_LINKQRENETIQUETA.Estadotransferencia, [] )
					.Horaexpo = nvl( c_LINKQRENETIQUETA.Horaexpo, [] )
					.Codigo = nvl( c_LINKQRENETIQUETA.Codigo, [] )
					.Articulo_PK =  nvl( c_LINKQRENETIQUETA.Articulo, [] )
					.Color_PK =  nvl( c_LINKQRENETIQUETA.Color, [] )
					.Talle = nvl( c_LINKQRENETIQUETA.Talle, [] )
					lcValor = This.ObtenerMemo( 'c_Qrlink1')
					.Qrlink1 = lcValor 
					lcValor = This.ObtenerMemo( 'c_Qrlink2')
					.Qrlink2 = lcValor 
					lcValor = This.ObtenerMemo( 'c_Qrlink3')
					.Qrlink3 = lcValor 
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
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
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_LINKQRENETIQUETA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LINKQRETI' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "LQrCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,LQrCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    LQrCod from (
							select * 
								from ZooLogic.LINKQRETI 
								Where   LINKQRETI.LQRCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LINKQRETI", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "LQrCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Timestamp" as "Timestamp", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Lqrcod" as "Codigo", "Artcod" as "Articulo", "Codcol" as "Color", "Codtall" as "Talle", "Qrlink1" as "Qrlink1", "Qrlink2" as "Qrlink2", "Qrlink3" as "Qrlink3", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LINKQRETI 
								Where   LINKQRETI.LQRCOD != ''
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
	Tabla = 'LINKQRETI'
	Filtro = " LINKQRETI.LQRCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LINKQRETI.LQRCOD != ''"
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
	<row entidad="LINKQRENETIQUETA                        " atributo="FECHAEXPO                               " tabla="LINKQRETI      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="FECHATRANSFERENCIA                      " tabla="LINKQRETI      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="FECHAMODIFICACIONFW                     " tabla="LINKQRETI      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="FECHAALTAFW                             " tabla="LINKQRETI      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="FECHAIMPO                               " tabla="LINKQRETI      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="TIMESTAMP                               " tabla="LINKQRETI      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="SERIEALTAFW                             " tabla="LINKQRETI      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="ZADSFW                                  " tabla="LINKQRETI      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="SERIEMODIFICACIONFW                     " tabla="LINKQRETI      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="USUARIOMODIFICACIONFW                   " tabla="LINKQRETI      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="USUARIOALTAFW                           " tabla="LINKQRETI      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="VERSIONALTAFW                           " tabla="LINKQRETI      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="HORAMODIFICACIONFW                      " tabla="LINKQRETI      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="VERSIONMODIFICACIONFW                   " tabla="LINKQRETI      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="HORAALTAFW                              " tabla="LINKQRETI      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LINKQRETI      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="HORAIMPO                                " tabla="LINKQRETI      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="BASEDEDATOSALTAFW                       " tabla="LINKQRETI      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="ESTADOTRANSFERENCIA                     " tabla="LINKQRETI      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="HORAEXPO                                " tabla="LINKQRETI      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="CODIGO                                  " tabla="LINKQRETI      " campo="LQRCOD    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGOSKU                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="ARTICULO                                " tabla="LINKQRETI      " campo="ARTCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="COLOR                                   " tabla="LINKQRETI      " campo="CODCOL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="TALLE                                   " tabla="LINKQRETI      " campo="CODTALL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Talle                                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="QRLINK1                                 " tabla="LINKQRETI      " campo="QRLINK1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Link para código QR 1                                                                                                                                           " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="QRLINK2                                 " tabla="LINKQRETI      " campo="QRLINK2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Link para código QR 2                                                                                                                                           " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="QRLINK3                                 " tabla="LINKQRETI      " campo="QRLINK3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Link para código QR 3                                                                                                                                           " dominio="OBSERVACION4R                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINKQRENETIQUETA                        " atributo="OBSERVACION                             " tabla="LINKQRETI      " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On LINKQRETI.ARTCOD = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On LINKQRETI.CODCOL = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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