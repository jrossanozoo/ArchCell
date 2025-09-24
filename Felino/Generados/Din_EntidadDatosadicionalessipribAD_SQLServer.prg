
define class Din_EntidadDATOSADICIONALESSIPRIBAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DATOSADICIONALESSIPRIB'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_DASPK'
	cTablaPrincipal = 'SIPRIBDATADIC'
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
			local  lxSipribdatadicFecimpo, lxSipribdatadicFectrans, lxSipribdatadicFmodifw, lxSipribdatadicFaltafw, lxSipribdatadicFecexpo, lxSipribdatadicHoraimpo, lxSipribdatadicHmodifw, lxSipribdatadicSmodifw, lxSipribdatadicUmodifw, lxSipribdatadicHoraexpo, lxSipribdatadicUaltafw, lxSipribdatadicSaltafw, lxSipribdatadicVmodifw, lxSipribdatadicBdaltafw, lxSipribdatadicBdmodifw, lxSipribdatadicEsttrans, lxSipribdatadicValtafw, lxSipribdatadicZadsfw, lxSipribdatadicHaltafw, lxSipribdatadicCodigo, lxSipribdatadicDescrip, lxSipribdatadicCondiibb, lxSipribdatadicArticuloin, lxSipribdatadicTipoexenc, lxSipribdatadicAnio, lxSipribdatadicCertific, lxSipribdatadicOtrosgrav, lxSipribdatadicRegistro
				lxSipribdatadicFecimpo =  .Fechaimpo			lxSipribdatadicFectrans =  .Fechatransferencia			lxSipribdatadicFmodifw =  .Fechamodificacionfw			lxSipribdatadicFaltafw =  .Fechaaltafw			lxSipribdatadicFecexpo =  .Fechaexpo			lxSipribdatadicHoraimpo =  .Horaimpo			lxSipribdatadicHmodifw =  .Horamodificacionfw			lxSipribdatadicSmodifw =  .Seriemodificacionfw			lxSipribdatadicUmodifw =  .Usuariomodificacionfw			lxSipribdatadicHoraexpo =  .Horaexpo			lxSipribdatadicUaltafw =  .Usuarioaltafw			lxSipribdatadicSaltafw =  .Seriealtafw			lxSipribdatadicVmodifw =  .Versionmodificacionfw			lxSipribdatadicBdaltafw =  .Basededatosaltafw			lxSipribdatadicBdmodifw =  .Basededatosmodificacionfw			lxSipribdatadicEsttrans =  .Estadotransferencia			lxSipribdatadicValtafw =  .Versionaltafw			lxSipribdatadicZadsfw =  .Zadsfw			lxSipribdatadicHaltafw =  .Horaaltafw			lxSipribdatadicCodigo =  .Codigo			lxSipribdatadicDescrip =  .Descripcion			lxSipribdatadicCondiibb =  .Condiibb			lxSipribdatadicArticuloin =  .Articuloinciso_PK 			lxSipribdatadicTipoexenc =  .Tipoexencion			lxSipribdatadicAnio =  .Ano			lxSipribdatadicCertific =  .Certificado			lxSipribdatadicOtrosgrav =  .Otrosgravamenes			lxSipribdatadicRegistro =  .Registroeinspeccion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxSipribdatadicCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.SIPRIBDATADIC ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaimpo","Hmodifw","Smodifw","Umodifw","Horaexpo","Ualtafw","Saltafw","Vmodifw","Bdaltafw","Bdmodifw","Esttrans","Valtafw","Zadsfw","Haltafw","Codigo","Descrip","Condiibb","Articuloin","Tipoexenc","Anio","Certific","Otrosgrav","Registro" ) values ( <<"'" + this.ConvertirDateSql( lxSipribdatadicFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicDescrip ) + "'" >>, <<lxSipribdatadicCondiibb >>, <<lxSipribdatadicArticuloin >>, <<lxSipribdatadicTipoexenc >>, <<lxSipribdatadicAnio >>, <<lxSipribdatadicCertific >>, <<iif( lxSipribdatadicOtrosgrav, 1, 0 ) >>, <<iif( lxSipribdatadicRegistro, 1, 0 ) >> )
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
			local  lxSipribdatadicFecimpo, lxSipribdatadicFectrans, lxSipribdatadicFmodifw, lxSipribdatadicFaltafw, lxSipribdatadicFecexpo, lxSipribdatadicHoraimpo, lxSipribdatadicHmodifw, lxSipribdatadicSmodifw, lxSipribdatadicUmodifw, lxSipribdatadicHoraexpo, lxSipribdatadicUaltafw, lxSipribdatadicSaltafw, lxSipribdatadicVmodifw, lxSipribdatadicBdaltafw, lxSipribdatadicBdmodifw, lxSipribdatadicEsttrans, lxSipribdatadicValtafw, lxSipribdatadicZadsfw, lxSipribdatadicHaltafw, lxSipribdatadicCodigo, lxSipribdatadicDescrip, lxSipribdatadicCondiibb, lxSipribdatadicArticuloin, lxSipribdatadicTipoexenc, lxSipribdatadicAnio, lxSipribdatadicCertific, lxSipribdatadicOtrosgrav, lxSipribdatadicRegistro
				lxSipribdatadicFecimpo =  .Fechaimpo			lxSipribdatadicFectrans =  .Fechatransferencia			lxSipribdatadicFmodifw =  .Fechamodificacionfw			lxSipribdatadicFaltafw =  .Fechaaltafw			lxSipribdatadicFecexpo =  .Fechaexpo			lxSipribdatadicHoraimpo =  .Horaimpo			lxSipribdatadicHmodifw =  .Horamodificacionfw			lxSipribdatadicSmodifw =  .Seriemodificacionfw			lxSipribdatadicUmodifw =  .Usuariomodificacionfw			lxSipribdatadicHoraexpo =  .Horaexpo			lxSipribdatadicUaltafw =  .Usuarioaltafw			lxSipribdatadicSaltafw =  .Seriealtafw			lxSipribdatadicVmodifw =  .Versionmodificacionfw			lxSipribdatadicBdaltafw =  .Basededatosaltafw			lxSipribdatadicBdmodifw =  .Basededatosmodificacionfw			lxSipribdatadicEsttrans =  .Estadotransferencia			lxSipribdatadicValtafw =  .Versionaltafw			lxSipribdatadicZadsfw =  .Zadsfw			lxSipribdatadicHaltafw =  .Horaaltafw			lxSipribdatadicCodigo =  .Codigo			lxSipribdatadicDescrip =  .Descripcion			lxSipribdatadicCondiibb =  .Condiibb			lxSipribdatadicArticuloin =  .Articuloinciso_PK 			lxSipribdatadicTipoexenc =  .Tipoexencion			lxSipribdatadicAnio =  .Ano			lxSipribdatadicCertific =  .Certificado			lxSipribdatadicOtrosgrav =  .Otrosgravamenes			lxSipribdatadicRegistro =  .Registroeinspeccion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.SIPRIBDATADIC set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFecexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicUmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraexpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicVmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxSipribdatadicEsttrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicZadsfw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxSipribdatadicDescrip ) + "'">>,"Condiibb" = <<lxSipribdatadicCondiibb>>,"Articuloin" = <<lxSipribdatadicArticuloin>>,"Tipoexenc" = <<lxSipribdatadicTipoexenc>>,"Anio" = <<lxSipribdatadicAnio>>,"Certific" = <<lxSipribdatadicCertific>>,"Otrosgrav" = <<iif( lxSipribdatadicOtrosgrav, 1, 0 )>>,"Registro" = <<iif( lxSipribdatadicRegistro, 1, 0 )>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'">> and  SIPRIBDATADIC.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.SIPRIBDATADIC where " + this.ConvertirFuncionesSql( " SIPRIBDATADIC.CODIGO != ''" ) )
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
			Local lxSipribdatadicCodigo
			lxSipribdatadicCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion" from ZooLogic.SIPRIBDATADIC where "Codigo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'">> and  SIPRIBDATADIC.CODIGO != ''
			endtext
			use in select('c_DATOSADICIONALESSIPRIB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIPRIB', set( 'Datasession' ) )

			if reccount( 'c_DATOSADICIONALESSIPRIB' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxSipribdatadicCodigo as Variant
		llRetorno = .t.
		lxSipribdatadicCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.SIPRIBDATADIC where "Codigo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'">> and  SIPRIBDATADIC.CODIGO != ''
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
				lcOrden =  .Descripcion + str( .CondIIBB, 2, 0) + str( .ArticuloInciso_PK, 3, 0) + str( .TipoExencion, 2, 0) + str( .Ano, 4, 0) + str( .Certificado, 6, 0) + iif( .OtrosGravamenes , '1', '0' ) + iif( .RegistroeInspeccion , '1', '0' ) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion" from ZooLogic.SIPRIBDATADIC where  SIPRIBDATADIC.CODIGO != '' order by Descrip,CondIIBB,ArticuloIn,TipoExenc,Anio,Certific,OtrosGrav,Registro,Codigo
			endtext
			use in select('c_DATOSADICIONALESSIPRIB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIPRIB', set( 'Datasession' ) )
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
				lcOrden =  .Descripcion + str( .CondIIBB, 2, 0) + str( .ArticuloInciso_PK, 3, 0) + str( .TipoExencion, 2, 0) + str( .Ano, 4, 0) + str( .Certificado, 6, 0) + iif( .OtrosGravamenes , '1', '0' ) + iif( .RegistroeInspeccion , '1', '0' ) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion" from ZooLogic.SIPRIBDATADIC where  funciones.padr( Descrip, 15, ' ' ) + str( CondIIBB, 2, 0) + str( ArticuloIn, 3, 0) + str( TipoExenc, 2, 0) + str( Anio, 4, 0) + str( Certific, 6, 0) + str( OtrosGrav, 1 ) + str( Registro, 1 ) + funciones.padr( Codigo, 20, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SIPRIBDATADIC.CODIGO != '' order by Descrip,CondIIBB,ArticuloIn,TipoExenc,Anio,Certific,OtrosGrav,Registro,Codigo
			endtext
			use in select('c_DATOSADICIONALESSIPRIB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIPRIB', set( 'Datasession' ) )
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
				lcOrden =  .Descripcion + str( .CondIIBB, 2, 0) + str( .ArticuloInciso_PK, 3, 0) + str( .TipoExencion, 2, 0) + str( .Ano, 4, 0) + str( .Certificado, 6, 0) + iif( .OtrosGravamenes , '1', '0' ) + iif( .RegistroeInspeccion , '1', '0' ) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion" from ZooLogic.SIPRIBDATADIC where  funciones.padr( Descrip, 15, ' ' ) + str( CondIIBB, 2, 0) + str( ArticuloIn, 3, 0) + str( TipoExenc, 2, 0) + str( Anio, 4, 0) + str( Certific, 6, 0) + str( OtrosGrav, 1 ) + str( Registro, 1 ) + funciones.padr( Codigo, 20, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  SIPRIBDATADIC.CODIGO != '' order by Descrip desc,CondIIBB desc,ArticuloIn desc,TipoExenc desc,Anio desc,Certific desc,OtrosGrav desc,Registro desc,Codigo desc
			endtext
			use in select('c_DATOSADICIONALESSIPRIB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIPRIB', set( 'Datasession' ) )
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
				lcOrden =  .Descripcion + str( .CondIIBB, 2, 0) + str( .ArticuloInciso_PK, 3, 0) + str( .TipoExencion, 2, 0) + str( .Ano, 4, 0) + str( .Certificado, 6, 0) + iif( .OtrosGravamenes , '1', '0' ) + iif( .RegistroeInspeccion , '1', '0' ) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion" from ZooLogic.SIPRIBDATADIC where  SIPRIBDATADIC.CODIGO != '' order by Descrip desc,CondIIBB desc,ArticuloIn desc,TipoExenc desc,Anio desc,Certific desc,OtrosGrav desc,Registro desc,Codigo desc
			endtext
			use in select('c_DATOSADICIONALESSIPRIB')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIPRIB', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaimpo,Hmodifw,Smodifw,Umodifw,Horaexpo,Ualtafw,S" + ;
"altafw,Vmodifw,Bdaltafw,Bdmodifw,Esttrans,Valtafw,Zadsfw,Haltafw,Codigo,Descrip,Condiibb,Articuloin," + ;
"Tipoexenc,Anio,Certific,Otrosgrav,Registro" + ;
" from ZooLogic.SIPRIBDATADIC where  SIPRIBDATADIC.CODIGO != '' and " + lcFiltro )
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
			local  lxSipribdatadicFecimpo, lxSipribdatadicFectrans, lxSipribdatadicFmodifw, lxSipribdatadicFaltafw, lxSipribdatadicFecexpo, lxSipribdatadicHoraimpo, lxSipribdatadicHmodifw, lxSipribdatadicSmodifw, lxSipribdatadicUmodifw, lxSipribdatadicHoraexpo, lxSipribdatadicUaltafw, lxSipribdatadicSaltafw, lxSipribdatadicVmodifw, lxSipribdatadicBdaltafw, lxSipribdatadicBdmodifw, lxSipribdatadicEsttrans, lxSipribdatadicValtafw, lxSipribdatadicZadsfw, lxSipribdatadicHaltafw, lxSipribdatadicCodigo, lxSipribdatadicDescrip, lxSipribdatadicCondiibb, lxSipribdatadicArticuloin, lxSipribdatadicTipoexenc, lxSipribdatadicAnio, lxSipribdatadicCertific, lxSipribdatadicOtrosgrav, lxSipribdatadicRegistro
				lxSipribdatadicFecimpo = ctod( '  /  /    ' )			lxSipribdatadicFectrans = ctod( '  /  /    ' )			lxSipribdatadicFmodifw = ctod( '  /  /    ' )			lxSipribdatadicFaltafw = ctod( '  /  /    ' )			lxSipribdatadicFecexpo = ctod( '  /  /    ' )			lxSipribdatadicHoraimpo = []			lxSipribdatadicHmodifw = []			lxSipribdatadicSmodifw = []			lxSipribdatadicUmodifw = []			lxSipribdatadicHoraexpo = []			lxSipribdatadicUaltafw = []			lxSipribdatadicSaltafw = []			lxSipribdatadicVmodifw = []			lxSipribdatadicBdaltafw = []			lxSipribdatadicBdmodifw = []			lxSipribdatadicEsttrans = []			lxSipribdatadicValtafw = []			lxSipribdatadicZadsfw = []			lxSipribdatadicHaltafw = []			lxSipribdatadicCodigo = []			lxSipribdatadicDescrip = []			lxSipribdatadicCondiibb = 0			lxSipribdatadicArticuloin = 0			lxSipribdatadicTipoexenc = 0			lxSipribdatadicAnio = 0			lxSipribdatadicCertific = 0			lxSipribdatadicOtrosgrav = .F.			lxSipribdatadicRegistro = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.SIPRIBDATADIC where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'SIPRIBDATADIC' + '_' + tcCampo
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
		lcWhere = " Where  SIPRIBDATADIC.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SIPRIBDATADIC', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'CONDIIBB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIIBB AS CONDIIBB'
				Case lcAtributo == 'ARTICULOINCISO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTICULOIN AS ARTICULOINCISO'
				Case lcAtributo == 'TIPOEXENCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOEXENC AS TIPOEXENCION'
				Case lcAtributo == 'ANO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANIO AS ANO'
				Case lcAtributo == 'CERTIFICADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CERTIFIC AS CERTIFICADO'
				Case lcAtributo == 'OTROSGRAVAMENES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OTROSGRAV AS OTROSGRAVAMENES'
				Case lcAtributo == 'REGISTROEINSPECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGISTRO AS REGISTROEINSPECCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'CONDIIBB'
				lcCampo = 'CONDIIBB'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULOINCISO'
				lcCampo = 'ARTICULOIN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOEXENCION'
				lcCampo = 'TIPOEXENC'
			Case upper( alltrim( tcAtributo ) ) == 'ANO'
				lcCampo = 'ANIO'
			Case upper( alltrim( tcAtributo ) ) == 'CERTIFICADO'
				lcCampo = 'CERTIFIC'
			Case upper( alltrim( tcAtributo ) ) == 'OTROSGRAVAMENES'
				lcCampo = 'OTROSGRAV'
			Case upper( alltrim( tcAtributo ) ) == 'REGISTROEINSPECCION'
				lcCampo = 'REGISTRO'
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
			local  lxSipribdatadicFecimpo, lxSipribdatadicFectrans, lxSipribdatadicFmodifw, lxSipribdatadicFaltafw, lxSipribdatadicFecexpo, lxSipribdatadicHoraimpo, lxSipribdatadicHmodifw, lxSipribdatadicSmodifw, lxSipribdatadicUmodifw, lxSipribdatadicHoraexpo, lxSipribdatadicUaltafw, lxSipribdatadicSaltafw, lxSipribdatadicVmodifw, lxSipribdatadicBdaltafw, lxSipribdatadicBdmodifw, lxSipribdatadicEsttrans, lxSipribdatadicValtafw, lxSipribdatadicZadsfw, lxSipribdatadicHaltafw, lxSipribdatadicCodigo, lxSipribdatadicDescrip, lxSipribdatadicCondiibb, lxSipribdatadicArticuloin, lxSipribdatadicTipoexenc, lxSipribdatadicAnio, lxSipribdatadicCertific, lxSipribdatadicOtrosgrav, lxSipribdatadicRegistro
				lxSipribdatadicFecimpo =  .Fechaimpo			lxSipribdatadicFectrans =  .Fechatransferencia			lxSipribdatadicFmodifw =  .Fechamodificacionfw			lxSipribdatadicFaltafw =  .Fechaaltafw			lxSipribdatadicFecexpo =  .Fechaexpo			lxSipribdatadicHoraimpo =  .Horaimpo			lxSipribdatadicHmodifw =  .Horamodificacionfw			lxSipribdatadicSmodifw =  .Seriemodificacionfw			lxSipribdatadicUmodifw =  .Usuariomodificacionfw			lxSipribdatadicHoraexpo =  .Horaexpo			lxSipribdatadicUaltafw =  .Usuarioaltafw			lxSipribdatadicSaltafw =  .Seriealtafw			lxSipribdatadicVmodifw =  .Versionmodificacionfw			lxSipribdatadicBdaltafw =  .Basededatosaltafw			lxSipribdatadicBdmodifw =  .Basededatosmodificacionfw			lxSipribdatadicEsttrans =  .Estadotransferencia			lxSipribdatadicValtafw =  .Versionaltafw			lxSipribdatadicZadsfw =  .Zadsfw			lxSipribdatadicHaltafw =  .Horaaltafw			lxSipribdatadicCodigo =  .Codigo			lxSipribdatadicDescrip =  .Descripcion			lxSipribdatadicCondiibb =  .Condiibb			lxSipribdatadicArticuloin =  .Articuloinciso_PK 			lxSipribdatadicTipoexenc =  .Tipoexencion			lxSipribdatadicAnio =  .Ano			lxSipribdatadicCertific =  .Certificado			lxSipribdatadicOtrosgrav =  .Otrosgravamenes			lxSipribdatadicRegistro =  .Registroeinspeccion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.SIPRIBDATADIC ( "Fecimpo","Fectrans","Fmodifw","Faltafw","Fecexpo","Horaimpo","Hmodifw","Smodifw","Umodifw","Horaexpo","Ualtafw","Saltafw","Vmodifw","Bdaltafw","Bdmodifw","Esttrans","Valtafw","Zadsfw","Haltafw","Codigo","Descrip","Condiibb","Articuloin","Tipoexenc","Anio","Certific","Otrosgrav","Registro" ) values ( <<"'" + this.ConvertirDateSql( lxSipribdatadicFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxSipribdatadicFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxSipribdatadicDescrip ) + "'" >>, <<lxSipribdatadicCondiibb >>, <<lxSipribdatadicArticuloin >>, <<lxSipribdatadicTipoexenc >>, <<lxSipribdatadicAnio >>, <<lxSipribdatadicCertific >>, <<iif( lxSipribdatadicOtrosgrav, 1, 0 ) >>, <<iif( lxSipribdatadicRegistro, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'SIPRIBDATADIC' 
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
			local  lxSipribdatadicFecimpo, lxSipribdatadicFectrans, lxSipribdatadicFmodifw, lxSipribdatadicFaltafw, lxSipribdatadicFecexpo, lxSipribdatadicHoraimpo, lxSipribdatadicHmodifw, lxSipribdatadicSmodifw, lxSipribdatadicUmodifw, lxSipribdatadicHoraexpo, lxSipribdatadicUaltafw, lxSipribdatadicSaltafw, lxSipribdatadicVmodifw, lxSipribdatadicBdaltafw, lxSipribdatadicBdmodifw, lxSipribdatadicEsttrans, lxSipribdatadicValtafw, lxSipribdatadicZadsfw, lxSipribdatadicHaltafw, lxSipribdatadicCodigo, lxSipribdatadicDescrip, lxSipribdatadicCondiibb, lxSipribdatadicArticuloin, lxSipribdatadicTipoexenc, lxSipribdatadicAnio, lxSipribdatadicCertific, lxSipribdatadicOtrosgrav, lxSipribdatadicRegistro
				lxSipribdatadicFecimpo =  .Fechaimpo			lxSipribdatadicFectrans =  .Fechatransferencia			lxSipribdatadicFmodifw =  .Fechamodificacionfw			lxSipribdatadicFaltafw =  .Fechaaltafw			lxSipribdatadicFecexpo =  .Fechaexpo			lxSipribdatadicHoraimpo =  .Horaimpo			lxSipribdatadicHmodifw =  .Horamodificacionfw			lxSipribdatadicSmodifw =  .Seriemodificacionfw			lxSipribdatadicUmodifw =  .Usuariomodificacionfw			lxSipribdatadicHoraexpo =  .Horaexpo			lxSipribdatadicUaltafw =  .Usuarioaltafw			lxSipribdatadicSaltafw =  .Seriealtafw			lxSipribdatadicVmodifw =  .Versionmodificacionfw			lxSipribdatadicBdaltafw =  .Basededatosaltafw			lxSipribdatadicBdmodifw =  .Basededatosmodificacionfw			lxSipribdatadicEsttrans =  .Estadotransferencia			lxSipribdatadicValtafw =  .Versionaltafw			lxSipribdatadicZadsfw =  .Zadsfw			lxSipribdatadicHaltafw =  .Horaaltafw			lxSipribdatadicCodigo =  .Codigo			lxSipribdatadicDescrip =  .Descripcion			lxSipribdatadicCondiibb =  .Condiibb			lxSipribdatadicArticuloin =  .Articuloinciso_PK 			lxSipribdatadicTipoexenc =  .Tipoexencion			lxSipribdatadicAnio =  .Ano			lxSipribdatadicCertific =  .Certificado			lxSipribdatadicOtrosgrav =  .Otrosgravamenes			lxSipribdatadicRegistro =  .Registroeinspeccion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SIPRIBDATADIC.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.SIPRIBDATADIC set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxSipribdatadicFecexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicUmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHoraexpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicVmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxSipribdatadicEsttrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicZadsfw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxSipribdatadicHaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxSipribdatadicCodigo ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxSipribdatadicDescrip ) + "'">>, "Condiibb" = <<lxSipribdatadicCondiibb>>, "Articuloin" = <<lxSipribdatadicArticuloin>>, "Tipoexenc" = <<lxSipribdatadicTipoexenc>>, "Anio" = <<lxSipribdatadicAnio>>, "Certific" = <<lxSipribdatadicCertific>>, "Otrosgrav" = <<iif( lxSipribdatadicOtrosgrav, 1, 0 )>>, "Registro" = <<iif( lxSipribdatadicRegistro, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'SIPRIBDATADIC' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  SIPRIBDATADIC.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.SIPRIBDATADIC where ' + lcFiltro )
			loColeccion.cTabla = 'SIPRIBDATADIC' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.SIPRIBDATADIC where  SIPRIBDATADIC.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.SIPRIBDATADIC where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  SIPRIBDATADIC.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIPRIB'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.SIPRIBDATADIC Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.SIPRIBDATADIC set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, CondIIBB = ] + transform( &lcCursor..CondIIBB )+ [, ArticuloIn = ] + transform( &lcCursor..ArticuloIn )+ [, TipoExenc = ] + transform( &lcCursor..TipoExenc )+ [, Anio = ] + transform( &lcCursor..Anio )+ [, Certific = ] + transform( &lcCursor..Certific )+ [, OtrosGrav = ] + Transform( iif( &lcCursor..OtrosGrav, 1, 0 ))+ [, Registro = ] + Transform( iif( &lcCursor..Registro, 1, 0 )) + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FALTAFW, FECEXPO, HORAIMPO, HMODIFW, SMODIFW, UMODIFW, HORAEXPO, UALTAFW, SALTAFW, VMODIFW, BDALTAFW, BDMODIFW, ESTTRANS, VALTAFW, ZADSFW, HALTAFW, Codigo, Descrip, CondIIBB, ArticuloIn, TipoExenc, Anio, Certific, OtrosGrav, Registro
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CondIIBB ) + ',' + transform( &lcCursor..ArticuloIn ) + ',' + transform( &lcCursor..TipoExenc ) + ',' + transform( &lcCursor..Anio ) + ',' + transform( &lcCursor..Certific ) + ',' + Transform( iif( &lcCursor..OtrosGrav, 1, 0 )) + ',' + Transform( iif( &lcCursor..Registro, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.SIPRIBDATADIC ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIPRIB'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (20) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DATOSADICIONALESSIPRIB'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DATOSADICIONALESSIPRIB_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_SIPRIBdatadic')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DATOSADICIONALESSIPRIB'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DATOSADICIONALESSIPRIB. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIPRIB'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIPRIB'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SIPRIBdatadic') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SIPRIBdatadic
Create Table ZooLogic.TablaTrabajo_SIPRIBdatadic ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"haltafw" char( 8 )  null, 
"codigo" char( 20 )  null, 
"descrip" char( 15 )  null, 
"condiibb" numeric( 2, 0 )  null, 
"articuloin" numeric( 3, 0 )  null, 
"tipoexenc" numeric( 2, 0 )  null, 
"anio" numeric( 4, 0 )  null, 
"certific" numeric( 6, 0 )  null, 
"otrosgrav" bit  null, 
"registro" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_SIPRIBdatadic' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_SIPRIBdatadic' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIPRIB'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('condiibb','condiibb')
			.AgregarMapeo('articuloin','articuloin')
			.AgregarMapeo('tipoexenc','tipoexenc')
			.AgregarMapeo('anio','anio')
			.AgregarMapeo('certific','certific')
			.AgregarMapeo('otrosgrav','otrosgrav')
			.AgregarMapeo('registro','registro')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_SIPRIBdatadic'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.CONDIIBB = isnull( d.CONDIIBB, t.CONDIIBB ),t.ARTICULOIN = isnull( d.ARTICULOIN, t.ARTICULOIN ),t.TIPOEXENC = isnull( d.TIPOEXENC, t.TIPOEXENC ),t.ANIO = isnull( d.ANIO, t.ANIO ),t.CERTIFIC = isnull( d.CERTIFIC, t.CERTIFIC ),t.OTROSGRAV = isnull( d.OTROSGRAV, t.OTROSGRAV ),t.REGISTRO = isnull( d.REGISTRO, t.REGISTRO )
					from ZooLogic.SIPRIBDATADIC t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.SIPRIBDATADIC(Fecimpo,Fectrans,Fmodifw,Faltafw,Fecexpo,Horaimpo,Hmodifw,Smodifw,Umodifw,Horaexpo,Ualtafw,Saltafw,Vmodifw,Bdaltafw,Bdmodifw,Esttrans,Valtafw,Zadsfw,Haltafw,Codigo,Descrip,Condiibb,Articuloin,Tipoexenc,Anio,Certific,Otrosgrav,Registro)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),convert( char(8), getdate(), 108 ),isnull( d.CODIGO,''),isnull( d.DESCRIP,''),isnull( d.CONDIIBB,0),isnull( d.ARTICULOIN,0),isnull( d.TIPOEXENC,0),isnull( d.ANIO,0),isnull( d.CERTIFIC,0),isnull( d.OTROSGRAV,0),isnull( d.REGISTRO,0)
						From deleted d left join ZooLogic.SIPRIBDATADIC pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_SIPRIBdatadic') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_SIPRIBdatadic
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DATOSADICIONALESSIPRIB' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIPRIB.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIPRIB.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIPRIB.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIPRIB.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIPRIB.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_DATOSADICIONALESSIPRIB.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_DATOSADICIONALESSIPRIB.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_DATOSADICIONALESSIPRIB.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_DATOSADICIONALESSIPRIB.Usuariomodificacionfw, [] )
					.Horaexpo = nvl( c_DATOSADICIONALESSIPRIB.Horaexpo, [] )
					.Usuarioaltafw = nvl( c_DATOSADICIONALESSIPRIB.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_DATOSADICIONALESSIPRIB.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_DATOSADICIONALESSIPRIB.Versionmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_DATOSADICIONALESSIPRIB.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_DATOSADICIONALESSIPRIB.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_DATOSADICIONALESSIPRIB.Estadotransferencia, [] )
					.Versionaltafw = nvl( c_DATOSADICIONALESSIPRIB.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaaltafw = nvl( c_DATOSADICIONALESSIPRIB.Horaaltafw, [] )
					.Codigo = nvl( c_DATOSADICIONALESSIPRIB.Codigo, [] )
					.Descripcion = nvl( c_DATOSADICIONALESSIPRIB.Descripcion, [] )
					.Condiibb = nvl( c_DATOSADICIONALESSIPRIB.Condiibb, 0 )
					.Articuloinciso_PK =  nvl( c_DATOSADICIONALESSIPRIB.Articuloinciso, 0 )
					.Tipoexencion = nvl( c_DATOSADICIONALESSIPRIB.Tipoexencion, 0 )
					.Ano = nvl( c_DATOSADICIONALESSIPRIB.Ano, 0 )
					.Certificado = nvl( c_DATOSADICIONALESSIPRIB.Certificado, 0 )
					.Otrosgravamenes = nvl( c_DATOSADICIONALESSIPRIB.Otrosgravamenes, .F. )
					.Registroeinspeccion = nvl( c_DATOSADICIONALESSIPRIB.Registroeinspeccion, .F. )
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
		return c_DATOSADICIONALESSIPRIB.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.SIPRIBDATADIC' )
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
								from ZooLogic.SIPRIBDATADIC 
								Where   SIPRIBDATADIC.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "SIPRIBDATADIC", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Codigo" as "Codigo", "Descrip" as "Descripcion", "Condiibb" as "Condiibb", "Articuloin" as "Articuloinciso", "Tipoexenc" as "Tipoexencion", "Anio" as "Ano", "Certific" as "Certificado", "Otrosgrav" as "Otrosgravamenes", "Registro" as "Registroeinspeccion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.SIPRIBDATADIC 
								Where   SIPRIBDATADIC.CODIGO != ''
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
	Tabla = 'SIPRIBDATADIC'
	Filtro = " SIPRIBDATADIC.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " SIPRIBDATADIC.CODIGO != ''"
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
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="FECHAIMPO                               " tabla="SIPRIBDATADIC  " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="FECHATRANSFERENCIA                      " tabla="SIPRIBDATADIC  " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="FECHAMODIFICACIONFW                     " tabla="SIPRIBDATADIC  " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="FECHAALTAFW                             " tabla="SIPRIBDATADIC  " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="FECHAEXPO                               " tabla="SIPRIBDATADIC  " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="HORAIMPO                                " tabla="SIPRIBDATADIC  " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="HORAMODIFICACIONFW                      " tabla="SIPRIBDATADIC  " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="SERIEMODIFICACIONFW                     " tabla="SIPRIBDATADIC  " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="USUARIOMODIFICACIONFW                   " tabla="SIPRIBDATADIC  " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="HORAEXPO                                " tabla="SIPRIBDATADIC  " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="USUARIOALTAFW                           " tabla="SIPRIBDATADIC  " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="SERIEALTAFW                             " tabla="SIPRIBDATADIC  " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="VERSIONMODIFICACIONFW                   " tabla="SIPRIBDATADIC  " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="BASEDEDATOSALTAFW                       " tabla="SIPRIBDATADIC  " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="SIPRIBDATADIC  " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="ESTADOTRANSFERENCIA                     " tabla="SIPRIBDATADIC  " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="VERSIONALTAFW                           " tabla="SIPRIBDATADIC  " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="ZADSFW                                  " tabla="SIPRIBDATADIC  " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="HORAALTAFW                              " tabla="SIPRIBDATADIC  " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="CODIGO                                  " tabla="SIPRIBDATADIC  " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="DESCRIPCION                             " tabla="SIPRIBDATADIC  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="Código SIPRIB                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="400" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="CONDIIBB                                " tabla="SIPRIBDATADIC  " campo="CONDIIBB  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Condición de ingresos brutos                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="ARTICULOINCISO                          " tabla="SIPRIBDATADIC  " campo="ARTICULOIN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULOINCISODATOSADICIONALESSIPRIB    " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Artículo/Inciso para el cálculo                                                                                                                                 " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="TIPOEXENCION                            " tabla="SIPRIBDATADIC  " campo="TIPOEXENC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="2" etiqueta="Tipo exención                                                                                                                                                   " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="ANO                                     " tabla="SIPRIBDATADIC  " campo="ANIO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Año de exención                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="CERTIFICADO                             " tabla="SIPRIBDATADIC  " campo="CERTIFIC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Certificado                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="OTROSGRAVAMENES                         " tabla="SIPRIBDATADIC  " campo="OTROSGRAV " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Resp. Insc. en otros grav. ( art. 138 CF )                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIPRIB                  " atributo="REGISTROEINSPECCION                     " tabla="SIPRIBDATADIC  " campo="REGISTRO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Resp. Insc. en Derecho Registro e Inspec.                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULOINCISODATOSADICIONALESSIPRIB    " atributo="DESCRIPCION                             " tabla="ARTINDASIPRIB  " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ARTINDASIPRIB On SIPRIBDATADIC.ARTICULOIN = ARTINDASIPRIB.Codigo And  ARTINDASIPRIB.CODIGO != 0                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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