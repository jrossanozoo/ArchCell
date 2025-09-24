
define class Din_EntidadTIPODECOMPROBANTEDECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIPODECOMPROBANTEDECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TCCPK'
	cTablaPrincipal = 'TIPOCOMPCOM'
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
			local  lxTipocompcomFaltafw, lxTipocompcomFectrans, lxTipocompcomFecimpo, lxTipocompcomFmodifw, lxTipocompcomFecexpo, lxTipocompcomHaltafw, lxTipocompcomHoraexpo, lxTipocompcomHmodifw, lxTipocompcomVmodifw, lxTipocompcomZadsfw, lxTipocompcomValtafw, lxTipocompcomUaltafw, lxTipocompcomUmodifw, lxTipocompcomSaltafw, lxTipocompcomSmodifw, lxTipocompcomHoraimpo, lxTipocompcomBdmodifw, lxTipocompcomEsttrans, lxTipocompcomBdaltafw, lxTipocompcomCodigocor, lxTipocompcomCodigo, lxTipocompcomTipocompor, lxTipocompcomCodope, lxTipocompcomPorliquia, lxTipocompcomIvaliquia, lxTipocompcomDespacho, lxTipocompcomAnodespa, lxTipocompcomCodaduana, lxTipocompcomTipodestin, lxTipocompcomNrodespa, lxTipocompcomDigverif
				lxTipocompcomFaltafw =  .Fechaaltafw			lxTipocompcomFectrans =  .Fechatransferencia			lxTipocompcomFecimpo =  .Fechaimpo			lxTipocompcomFmodifw =  .Fechamodificacionfw			lxTipocompcomFecexpo =  .Fechaexpo			lxTipocompcomHaltafw =  .Horaaltafw			lxTipocompcomHoraexpo =  .Horaexpo			lxTipocompcomHmodifw =  .Horamodificacionfw			lxTipocompcomVmodifw =  .Versionmodificacionfw			lxTipocompcomZadsfw =  .Zadsfw			lxTipocompcomValtafw =  .Versionaltafw			lxTipocompcomUaltafw =  .Usuarioaltafw			lxTipocompcomUmodifw =  .Usuariomodificacionfw			lxTipocompcomSaltafw =  .Seriealtafw			lxTipocompcomSmodifw =  .Seriemodificacionfw			lxTipocompcomHoraimpo =  .Horaimpo			lxTipocompcomBdmodifw =  .Basededatosmodificacionfw			lxTipocompcomEsttrans =  .Estadotransferencia			lxTipocompcomBdaltafw =  .Basededatosaltafw			lxTipocompcomCodigocor =  .Codigocomporigen			lxTipocompcomCodigo =  .Codigo			lxTipocompcomTipocompor =  .Tipocomporigen			lxTipocompcomCodope =  .Codigooperacion			lxTipocompcomPorliquia =  .Porcentajedeivaliqa			lxTipocompcomIvaliquia =  .Montodeivaliqa			lxTipocompcomDespacho =  upper( .Despacho_PK ) 			lxTipocompcomAnodespa =  .Anodespacho			lxTipocompcomCodaduana =  .Codigodeaduana			lxTipocompcomTipodestin =  .Tipodedestino			lxTipocompcomNrodespa =  .Nrodespacho			lxTipocompcomDigverif =  .Digitoverificador
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTipocompcomCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TIPOCOMPCOM ( "Faltafw","Fectrans","Fecimpo","Fmodifw","Fecexpo","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Bdmodifw","Esttrans","Bdaltafw","Codigocor","Codigo","Tipocompor","Codope","Porliquia","Ivaliquia","Despacho","Anodespa","Codaduana","Tipodestin","Nrodespa","Digverif" ) values ( <<"'" + this.ConvertirDateSql( lxTipocompcomFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodigocor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'" >>, <<lxTipocompcomTipocompor >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodope ) + "'" >>, <<lxTipocompcomPorliquia >>, <<lxTipocompcomIvaliquia >>, <<"'" + this.FormatearTextoSql( lxTipocompcomDespacho ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomAnodespa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodaduana ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomTipodestin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomNrodespa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomDigverif ) + "'" >> )
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
			local  lxTipocompcomFaltafw, lxTipocompcomFectrans, lxTipocompcomFecimpo, lxTipocompcomFmodifw, lxTipocompcomFecexpo, lxTipocompcomHaltafw, lxTipocompcomHoraexpo, lxTipocompcomHmodifw, lxTipocompcomVmodifw, lxTipocompcomZadsfw, lxTipocompcomValtafw, lxTipocompcomUaltafw, lxTipocompcomUmodifw, lxTipocompcomSaltafw, lxTipocompcomSmodifw, lxTipocompcomHoraimpo, lxTipocompcomBdmodifw, lxTipocompcomEsttrans, lxTipocompcomBdaltafw, lxTipocompcomCodigocor, lxTipocompcomCodigo, lxTipocompcomTipocompor, lxTipocompcomCodope, lxTipocompcomPorliquia, lxTipocompcomIvaliquia, lxTipocompcomDespacho, lxTipocompcomAnodespa, lxTipocompcomCodaduana, lxTipocompcomTipodestin, lxTipocompcomNrodespa, lxTipocompcomDigverif
				lxTipocompcomFaltafw =  .Fechaaltafw			lxTipocompcomFectrans =  .Fechatransferencia			lxTipocompcomFecimpo =  .Fechaimpo			lxTipocompcomFmodifw =  .Fechamodificacionfw			lxTipocompcomFecexpo =  .Fechaexpo			lxTipocompcomHaltafw =  .Horaaltafw			lxTipocompcomHoraexpo =  .Horaexpo			lxTipocompcomHmodifw =  .Horamodificacionfw			lxTipocompcomVmodifw =  .Versionmodificacionfw			lxTipocompcomZadsfw =  .Zadsfw			lxTipocompcomValtafw =  .Versionaltafw			lxTipocompcomUaltafw =  .Usuarioaltafw			lxTipocompcomUmodifw =  .Usuariomodificacionfw			lxTipocompcomSaltafw =  .Seriealtafw			lxTipocompcomSmodifw =  .Seriemodificacionfw			lxTipocompcomHoraimpo =  .Horaimpo			lxTipocompcomBdmodifw =  .Basededatosmodificacionfw			lxTipocompcomEsttrans =  .Estadotransferencia			lxTipocompcomBdaltafw =  .Basededatosaltafw			lxTipocompcomCodigocor =  .Codigocomporigen			lxTipocompcomCodigo =  .Codigo			lxTipocompcomTipocompor =  .Tipocomporigen			lxTipocompcomCodope =  .Codigooperacion			lxTipocompcomPorliquia =  .Porcentajedeivaliqa			lxTipocompcomIvaliquia =  .Montodeivaliqa			lxTipocompcomDespacho =  upper( .Despacho_PK ) 			lxTipocompcomAnodespa =  .Anodespacho			lxTipocompcomCodaduana =  .Codigodeaduana			lxTipocompcomTipodestin =  .Tipodedestino			lxTipocompcomNrodespa =  .Nrodespacho			lxTipocompcomDigverif =  .Digitoverificador
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TIPOCOMPCOM set "Faltafw" = <<"'" + this.ConvertirDateSql( lxTipocompcomFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTipocompcomFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTipocompcomFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTipocompcomFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTipocompcomFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTipocompcomHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTipocompcomZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTipocompcomHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTipocompcomEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomBdaltafw ) + "'">>,"Codigocor" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigocor ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'">>,"Tipocompor" = <<lxTipocompcomTipocompor>>,"Codope" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodope ) + "'">>,"Porliquia" = <<lxTipocompcomPorliquia>>,"Ivaliquia" = <<lxTipocompcomIvaliquia>>,"Despacho" = <<"'" + this.FormatearTextoSql( lxTipocompcomDespacho ) + "'">>,"Anodespa" = <<"'" + this.FormatearTextoSql( lxTipocompcomAnodespa ) + "'">>,"Codaduana" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodaduana ) + "'">>,"Tipodestin" = <<"'" + this.FormatearTextoSql( lxTipocompcomTipodestin ) + "'">>,"Nrodespa" = <<"'" + this.FormatearTextoSql( lxTipocompcomNrodespa ) + "'">>,"Digverif" = <<"'" + this.FormatearTextoSql( lxTipocompcomDigverif ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'">> and  TIPOCOMPCOM.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.TIPOCOMPCOM where " + this.ConvertirFuncionesSql( " TIPOCOMPCOM.CODIGO != ''" ) )
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
			Local lxTipocompcomCodigo
			lxTipocompcomCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador" from ZooLogic.TIPOCOMPCOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'">> and  TIPOCOMPCOM.CODIGO != ''
			endtext
			use in select('c_TIPODECOMPROBANTEDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPODECOMPROBANTEDECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_TIPODECOMPROBANTEDECOMPRA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTipocompcomCodigo as Variant
		llRetorno = .t.
		lxTipocompcomCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TIPOCOMPCOM where "Codigo" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'">> and  TIPOCOMPCOM.CODIGO != ''
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
				lcOrden =  .LetraCompOrigen + str( .PtoVtaCompOrigen, 4, 0) + str( .NroCompOrigen, 8, 0) + str( .TipoCompOrigen, 3, 0) + .CodigoOperacion + str( .MontoDeIvaLiqA, 15, 2) + str( .PorcentajeDeIVALiqA, 5, 2) + .Despacho_PK + .AnoDespacho + .CodigoDeAduana + .TipoDeDestino + .NroDespacho + .DigitoVerificador + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador" from ZooLogic.TIPOCOMPCOM where  TIPOCOMPCOM.CODIGO != '' order by ,,,TipoCompOr,CodOpe,IvaLiquiA,PorLiquiA,Despacho,AnoDespa,CodAduana,TipoDestin,NroDespa,DigVerif,Codigo
			endtext
			use in select('c_TIPODECOMPROBANTEDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPODECOMPROBANTEDECOMPRA', set( 'Datasession' ) )
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
				lcOrden =  .LetraCompOrigen + str( .PtoVtaCompOrigen, 4, 0) + str( .NroCompOrigen, 8, 0) + str( .TipoCompOrigen, 3, 0) + .CodigoOperacion + str( .MontoDeIvaLiqA, 15, 2) + str( .PorcentajeDeIVALiqA, 5, 2) + .Despacho_PK + .AnoDespacho + .CodigoDeAduana + .TipoDeDestino + .NroDespacho + .DigitoVerificador + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador" from ZooLogic.TIPOCOMPCOM where  funciones.padr( , 1, ' ' ) + str( , 4, 0) + str( , 8, 0) + str( TipoCompOr, 3, 0) + funciones.padr( CodOpe, 1, ' ' ) + str( IvaLiquiA, 15, 2) + str( PorLiquiA, 5, 2) + funciones.padr( Despacho, 16, ' ' ) + funciones.padr( AnoDespa, 4, ' ' ) + funciones.padr( CodAduana, 3, ' ' ) + funciones.padr( TipoDestin, 4, ' ' ) + funciones.padr( NroDespa, 6, ' ' ) + funciones.padr( DigVerif, 1, ' ' ) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIPOCOMPCOM.CODIGO != '' order by ,,,TipoCompOr,CodOpe,IvaLiquiA,PorLiquiA,Despacho,AnoDespa,CodAduana,TipoDestin,NroDespa,DigVerif,Codigo
			endtext
			use in select('c_TIPODECOMPROBANTEDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPODECOMPROBANTEDECOMPRA', set( 'Datasession' ) )
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
				lcOrden =  .LetraCompOrigen + str( .PtoVtaCompOrigen, 4, 0) + str( .NroCompOrigen, 8, 0) + str( .TipoCompOrigen, 3, 0) + .CodigoOperacion + str( .MontoDeIvaLiqA, 15, 2) + str( .PorcentajeDeIVALiqA, 5, 2) + .Despacho_PK + .AnoDespacho + .CodigoDeAduana + .TipoDeDestino + .NroDespacho + .DigitoVerificador + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador" from ZooLogic.TIPOCOMPCOM where  funciones.padr( , 1, ' ' ) + str( , 4, 0) + str( , 8, 0) + str( TipoCompOr, 3, 0) + funciones.padr( CodOpe, 1, ' ' ) + str( IvaLiquiA, 15, 2) + str( PorLiquiA, 5, 2) + funciones.padr( Despacho, 16, ' ' ) + funciones.padr( AnoDespa, 4, ' ' ) + funciones.padr( CodAduana, 3, ' ' ) + funciones.padr( TipoDestin, 4, ' ' ) + funciones.padr( NroDespa, 6, ' ' ) + funciones.padr( DigVerif, 1, ' ' ) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIPOCOMPCOM.CODIGO != '' order by  desc, desc, desc,TipoCompOr desc,CodOpe desc,IvaLiquiA desc,PorLiquiA desc,Despacho desc,AnoDespa desc,CodAduana desc,TipoDestin desc,NroDespa desc,DigVerif desc,Codigo desc
			endtext
			use in select('c_TIPODECOMPROBANTEDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPODECOMPROBANTEDECOMPRA', set( 'Datasession' ) )
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
				lcOrden =  .LetraCompOrigen + str( .PtoVtaCompOrigen, 4, 0) + str( .NroCompOrigen, 8, 0) + str( .TipoCompOrigen, 3, 0) + .CodigoOperacion + str( .MontoDeIvaLiqA, 15, 2) + str( .PorcentajeDeIVALiqA, 5, 2) + .Despacho_PK + .AnoDespacho + .CodigoDeAduana + .TipoDeDestino + .NroDespacho + .DigitoVerificador + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador" from ZooLogic.TIPOCOMPCOM where  TIPOCOMPCOM.CODIGO != '' order by  desc, desc, desc,TipoCompOr desc,CodOpe desc,IvaLiquiA desc,PorLiquiA desc,Despacho desc,AnoDespa desc,CodAduana desc,TipoDestin desc,NroDespa desc,DigVerif desc,Codigo desc
			endtext
			use in select('c_TIPODECOMPROBANTEDECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIPODECOMPROBANTEDECOMPRA', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fecimpo,Fmodifw,Fecexpo,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ual" + ;
"tafw,Umodifw,Saltafw,Smodifw,Horaimpo,Bdmodifw,Esttrans,Bdaltafw,Codigocor,Codigo,Tipocompor,Codope," + ;
"Porliquia,Ivaliquia,Despacho,Anodespa,Codaduana,Tipodestin,Nrodespa,Digverif" + ;
" from ZooLogic.TIPOCOMPCOM where  TIPOCOMPCOM.CODIGO != '' and " + lcFiltro )
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
			local  lxTipocompcomFaltafw, lxTipocompcomFectrans, lxTipocompcomFecimpo, lxTipocompcomFmodifw, lxTipocompcomFecexpo, lxTipocompcomHaltafw, lxTipocompcomHoraexpo, lxTipocompcomHmodifw, lxTipocompcomVmodifw, lxTipocompcomZadsfw, lxTipocompcomValtafw, lxTipocompcomUaltafw, lxTipocompcomUmodifw, lxTipocompcomSaltafw, lxTipocompcomSmodifw, lxTipocompcomHoraimpo, lxTipocompcomBdmodifw, lxTipocompcomEsttrans, lxTipocompcomBdaltafw, lxTipocompcomCodigocor, lxTipocompcomCodigo, lxTipocompcomTipocompor, lxTipocompcomCodope, lxTipocompcomPorliquia, lxTipocompcomIvaliquia, lxTipocompcomDespacho, lxTipocompcomAnodespa, lxTipocompcomCodaduana, lxTipocompcomTipodestin, lxTipocompcomNrodespa, lxTipocompcomDigverif
				lxTipocompcomFaltafw = ctod( '  /  /    ' )			lxTipocompcomFectrans = ctod( '  /  /    ' )			lxTipocompcomFecimpo = ctod( '  /  /    ' )			lxTipocompcomFmodifw = ctod( '  /  /    ' )			lxTipocompcomFecexpo = ctod( '  /  /    ' )			lxTipocompcomHaltafw = []			lxTipocompcomHoraexpo = []			lxTipocompcomHmodifw = []			lxTipocompcomVmodifw = []			lxTipocompcomZadsfw = []			lxTipocompcomValtafw = []			lxTipocompcomUaltafw = []			lxTipocompcomUmodifw = []			lxTipocompcomSaltafw = []			lxTipocompcomSmodifw = []			lxTipocompcomHoraimpo = []			lxTipocompcomBdmodifw = []			lxTipocompcomEsttrans = []			lxTipocompcomBdaltafw = []			lxTipocompcomCodigocor = []			lxTipocompcomCodigo = []			lxTipocompcomTipocompor = 0			lxTipocompcomCodope = []			lxTipocompcomPorliquia = 0			lxTipocompcomIvaliquia = 0			lxTipocompcomDespacho = []			lxTipocompcomAnodespa = []			lxTipocompcomCodaduana = []			lxTipocompcomTipodestin = []			lxTipocompcomNrodespa = []			lxTipocompcomDigverif = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TIPOCOMPCOM where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TIPOCOMPCOM' + '_' + tcCampo
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
		lcWhere = " Where  TIPOCOMPCOM.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TIPOCOMPCOM', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGOCOMPORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOCOR AS CODIGOCOMPORIGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMPOR AS TIPOCOMPORIGEN'
				Case lcAtributo == 'CODIGOOPERACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODOPE AS CODIGOOPERACION'
				Case lcAtributo == 'PORCENTAJEDEIVALIQA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORLIQUIA AS PORCENTAJEDEIVALIQA'
				Case lcAtributo == 'MONTODEIVALIQA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVALIQUIA AS MONTODEIVALIQA'
				Case lcAtributo == 'DESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPACHO AS DESPACHO'
				Case lcAtributo == 'ANODESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANODESPA AS ANODESPACHO'
				Case lcAtributo == 'CODIGODEADUANA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODADUANA AS CODIGODEADUANA'
				Case lcAtributo == 'TIPODEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODESTIN AS TIPODEDESTINO'
				Case lcAtributo == 'NRODESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODESPA AS NRODESPACHO'
				Case lcAtributo == 'DIGITOVERIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIGVERIF AS DIGITOVERIFICADOR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPORIGEN'
				lcCampo = 'CODIGOCOR'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPORIGEN'
				lcCampo = 'TIPOCOMPOR'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOOPERACION'
				lcCampo = 'CODOPE'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDEIVALIQA'
				lcCampo = 'PORLIQUIA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVALIQA'
				lcCampo = 'IVALIQUIA'
			Case upper( alltrim( tcAtributo ) ) == 'DESPACHO'
				lcCampo = 'DESPACHO'
			Case upper( alltrim( tcAtributo ) ) == 'ANODESPACHO'
				lcCampo = 'ANODESPA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODEADUANA'
				lcCampo = 'CODADUANA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEDESTINO'
				lcCampo = 'TIPODESTIN'
			Case upper( alltrim( tcAtributo ) ) == 'NRODESPACHO'
				lcCampo = 'NRODESPA'
			Case upper( alltrim( tcAtributo ) ) == 'DIGITOVERIFICADOR'
				lcCampo = 'DIGVERIF'
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
			local  lxTipocompcomFaltafw, lxTipocompcomFectrans, lxTipocompcomFecimpo, lxTipocompcomFmodifw, lxTipocompcomFecexpo, lxTipocompcomHaltafw, lxTipocompcomHoraexpo, lxTipocompcomHmodifw, lxTipocompcomVmodifw, lxTipocompcomZadsfw, lxTipocompcomValtafw, lxTipocompcomUaltafw, lxTipocompcomUmodifw, lxTipocompcomSaltafw, lxTipocompcomSmodifw, lxTipocompcomHoraimpo, lxTipocompcomBdmodifw, lxTipocompcomEsttrans, lxTipocompcomBdaltafw, lxTipocompcomCodigocor, lxTipocompcomCodigo, lxTipocompcomTipocompor, lxTipocompcomCodope, lxTipocompcomPorliquia, lxTipocompcomIvaliquia, lxTipocompcomDespacho, lxTipocompcomAnodespa, lxTipocompcomCodaduana, lxTipocompcomTipodestin, lxTipocompcomNrodespa, lxTipocompcomDigverif
				lxTipocompcomFaltafw =  .Fechaaltafw			lxTipocompcomFectrans =  .Fechatransferencia			lxTipocompcomFecimpo =  .Fechaimpo			lxTipocompcomFmodifw =  .Fechamodificacionfw			lxTipocompcomFecexpo =  .Fechaexpo			lxTipocompcomHaltafw =  .Horaaltafw			lxTipocompcomHoraexpo =  .Horaexpo			lxTipocompcomHmodifw =  .Horamodificacionfw			lxTipocompcomVmodifw =  .Versionmodificacionfw			lxTipocompcomZadsfw =  .Zadsfw			lxTipocompcomValtafw =  .Versionaltafw			lxTipocompcomUaltafw =  .Usuarioaltafw			lxTipocompcomUmodifw =  .Usuariomodificacionfw			lxTipocompcomSaltafw =  .Seriealtafw			lxTipocompcomSmodifw =  .Seriemodificacionfw			lxTipocompcomHoraimpo =  .Horaimpo			lxTipocompcomBdmodifw =  .Basededatosmodificacionfw			lxTipocompcomEsttrans =  .Estadotransferencia			lxTipocompcomBdaltafw =  .Basededatosaltafw			lxTipocompcomCodigocor =  .Codigocomporigen			lxTipocompcomCodigo =  .Codigo			lxTipocompcomTipocompor =  .Tipocomporigen			lxTipocompcomCodope =  .Codigooperacion			lxTipocompcomPorliquia =  .Porcentajedeivaliqa			lxTipocompcomIvaliquia =  .Montodeivaliqa			lxTipocompcomDespacho =  upper( .Despacho_PK ) 			lxTipocompcomAnodespa =  .Anodespacho			lxTipocompcomCodaduana =  .Codigodeaduana			lxTipocompcomTipodestin =  .Tipodedestino			lxTipocompcomNrodespa =  .Nrodespacho			lxTipocompcomDigverif =  .Digitoverificador
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TIPOCOMPCOM ( "Faltafw","Fectrans","Fecimpo","Fmodifw","Fecexpo","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Bdmodifw","Esttrans","Bdaltafw","Codigocor","Codigo","Tipocompor","Codope","Porliquia","Ivaliquia","Despacho","Anodespa","Codaduana","Tipodestin","Nrodespa","Digverif" ) values ( <<"'" + this.ConvertirDateSql( lxTipocompcomFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTipocompcomFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodigocor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'" >>, <<lxTipocompcomTipocompor >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodope ) + "'" >>, <<lxTipocompcomPorliquia >>, <<lxTipocompcomIvaliquia >>, <<"'" + this.FormatearTextoSql( lxTipocompcomDespacho ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomAnodespa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomCodaduana ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomTipodestin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomNrodespa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTipocompcomDigverif ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TIPOCOMPCOM' 
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
			local  lxTipocompcomFaltafw, lxTipocompcomFectrans, lxTipocompcomFecimpo, lxTipocompcomFmodifw, lxTipocompcomFecexpo, lxTipocompcomHaltafw, lxTipocompcomHoraexpo, lxTipocompcomHmodifw, lxTipocompcomVmodifw, lxTipocompcomZadsfw, lxTipocompcomValtafw, lxTipocompcomUaltafw, lxTipocompcomUmodifw, lxTipocompcomSaltafw, lxTipocompcomSmodifw, lxTipocompcomHoraimpo, lxTipocompcomBdmodifw, lxTipocompcomEsttrans, lxTipocompcomBdaltafw, lxTipocompcomCodigocor, lxTipocompcomCodigo, lxTipocompcomTipocompor, lxTipocompcomCodope, lxTipocompcomPorliquia, lxTipocompcomIvaliquia, lxTipocompcomDespacho, lxTipocompcomAnodespa, lxTipocompcomCodaduana, lxTipocompcomTipodestin, lxTipocompcomNrodespa, lxTipocompcomDigverif
				lxTipocompcomFaltafw =  .Fechaaltafw			lxTipocompcomFectrans =  .Fechatransferencia			lxTipocompcomFecimpo =  .Fechaimpo			lxTipocompcomFmodifw =  .Fechamodificacionfw			lxTipocompcomFecexpo =  .Fechaexpo			lxTipocompcomHaltafw =  .Horaaltafw			lxTipocompcomHoraexpo =  .Horaexpo			lxTipocompcomHmodifw =  .Horamodificacionfw			lxTipocompcomVmodifw =  .Versionmodificacionfw			lxTipocompcomZadsfw =  .Zadsfw			lxTipocompcomValtafw =  .Versionaltafw			lxTipocompcomUaltafw =  .Usuarioaltafw			lxTipocompcomUmodifw =  .Usuariomodificacionfw			lxTipocompcomSaltafw =  .Seriealtafw			lxTipocompcomSmodifw =  .Seriemodificacionfw			lxTipocompcomHoraimpo =  .Horaimpo			lxTipocompcomBdmodifw =  .Basededatosmodificacionfw			lxTipocompcomEsttrans =  .Estadotransferencia			lxTipocompcomBdaltafw =  .Basededatosaltafw			lxTipocompcomCodigocor =  .Codigocomporigen			lxTipocompcomCodigo =  .Codigo			lxTipocompcomTipocompor =  .Tipocomporigen			lxTipocompcomCodope =  .Codigooperacion			lxTipocompcomPorliquia =  .Porcentajedeivaliqa			lxTipocompcomIvaliquia =  .Montodeivaliqa			lxTipocompcomDespacho =  upper( .Despacho_PK ) 			lxTipocompcomAnodespa =  .Anodespacho			lxTipocompcomCodaduana =  .Codigodeaduana			lxTipocompcomTipodestin =  .Tipodedestino			lxTipocompcomNrodespa =  .Nrodespacho			lxTipocompcomDigverif =  .Digitoverificador
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIPOCOMPCOM.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.TIPOCOMPCOM set "Faltafw" = <<"'" + this.ConvertirDateSql( lxTipocompcomFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTipocompcomFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTipocompcomFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTipocompcomFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTipocompcomFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTipocompcomHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTipocompcomZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTipocompcomHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTipocompcomBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTipocompcomEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTipocompcomBdaltafw ) + "'">>, "Codigocor" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigocor ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodigo ) + "'">>, "Tipocompor" = <<lxTipocompcomTipocompor>>, "Codope" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodope ) + "'">>, "Porliquia" = <<lxTipocompcomPorliquia>>, "Ivaliquia" = <<lxTipocompcomIvaliquia>>, "Despacho" = <<"'" + this.FormatearTextoSql( lxTipocompcomDespacho ) + "'">>, "Anodespa" = <<"'" + this.FormatearTextoSql( lxTipocompcomAnodespa ) + "'">>, "Codaduana" = <<"'" + this.FormatearTextoSql( lxTipocompcomCodaduana ) + "'">>, "Tipodestin" = <<"'" + this.FormatearTextoSql( lxTipocompcomTipodestin ) + "'">>, "Nrodespa" = <<"'" + this.FormatearTextoSql( lxTipocompcomNrodespa ) + "'">>, "Digverif" = <<"'" + this.FormatearTextoSql( lxTipocompcomDigverif ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TIPOCOMPCOM' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIPOCOMPCOM.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.TIPOCOMPCOM where ' + lcFiltro )
			loColeccion.cTabla = 'TIPOCOMPCOM' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TIPOCOMPCOM where  TIPOCOMPCOM.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TIPOCOMPCOM where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  TIPOCOMPCOM.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPODECOMPROBANTEDECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TIPOCOMPCOM Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TIPOCOMPCOM set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, CodigoCOr = ] + "'" + this.FormatearTextoSql( &lcCursor..CodigoCOr ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, TipoCompOr = ] + transform( &lcCursor..TipoCompOr )+ [, CodOpe = ] + "'" + this.FormatearTextoSql( &lcCursor..CodOpe ) + "'"+ [, PorLiquiA = ] + transform( &lcCursor..PorLiquiA )+ [, IvaLiquiA = ] + transform( &lcCursor..IvaLiquiA )+ [, Despacho = ] + "'" + this.FormatearTextoSql( &lcCursor..Despacho ) + "'"+ [, AnoDespa = ] + "'" + this.FormatearTextoSql( &lcCursor..AnoDespa ) + "'"+ [, CodAduana = ] + "'" + this.FormatearTextoSql( &lcCursor..CodAduana ) + "'"+ [, TipoDestin = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoDestin ) + "'"+ [, NroDespa = ] + "'" + this.FormatearTextoSql( &lcCursor..NroDespa ) + "'"+ [, DigVerif = ] + "'" + this.FormatearTextoSql( &lcCursor..DigVerif ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECTRANS, FECIMPO, FMODIFW, FECEXPO, HALTAFW, HORAEXPO, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, HORAIMPO, BDMODIFW, ESTTRANS, BDALTAFW, CodigoCOr, Codigo, TipoCompOr, CodOpe, PorLiquiA, IvaLiquiA, Despacho, AnoDespa, CodAduana, TipoDestin, NroDespa, DigVerif
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodigoCOr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TipoCompOr ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodOpe ) + "'" + ',' + transform( &lcCursor..PorLiquiA ) + ',' + transform( &lcCursor..IvaLiquiA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Despacho ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AnoDespa ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodAduana ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoDestin ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroDespa ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DigVerif ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TIPOCOMPCOM ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPODECOMPROBANTEDECOMPRA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - : ' + transform( &tcCursor..Codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TIPODECOMPROBANTEDECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIPODECOMPROBANTEDECOMPRA_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TipoCompCom')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIPODECOMPROBANTEDECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIPODECOMPROBANTEDECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPODECOMPROBANTEDECOMPRA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPODECOMPROBANTEDECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TipoCompCom') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TipoCompCom
Create Table ZooLogic.TablaTrabajo_TipoCompCom ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigocor" char( 38 )  null, 
"codigo" char( 38 )  null, 
"tipocompor" numeric( 3, 0 )  null, 
"codope" char( 1 )  null, 
"porliquia" numeric( 5, 2 )  null, 
"ivaliquia" numeric( 15, 2 )  null, 
"despacho" char( 16 )  null, 
"anodespa" char( 4 )  null, 
"codaduana" char( 3 )  null, 
"tipodestin" char( 4 )  null, 
"nrodespa" char( 6 )  null, 
"digverif" char( 1 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TipoCompCom' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TipoCompCom' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIPODECOMPROBANTEDECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigocor','codigocor')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('tipocompor','tipocompor')
			.AgregarMapeo('codope','codope')
			.AgregarMapeo('porliquia','porliquia')
			.AgregarMapeo('ivaliquia','ivaliquia')
			.AgregarMapeo('despacho','despacho')
			.AgregarMapeo('anodespa','anodespa')
			.AgregarMapeo('codaduana','codaduana')
			.AgregarMapeo('tipodestin','tipodestin')
			.AgregarMapeo('nrodespa','nrodespa')
			.AgregarMapeo('digverif','digverif')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TipoCompCom'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGOCOR = isnull( d.CODIGOCOR, t.CODIGOCOR ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.TIPOCOMPOR = isnull( d.TIPOCOMPOR, t.TIPOCOMPOR ),t.CODOPE = isnull( d.CODOPE, t.CODOPE ),t.PORLIQUIA = isnull( d.PORLIQUIA, t.PORLIQUIA ),t.IVALIQUIA = isnull( d.IVALIQUIA, t.IVALIQUIA ),t.DESPACHO = isnull( d.DESPACHO, t.DESPACHO ),t.ANODESPA = isnull( d.ANODESPA, t.ANODESPA ),t.CODADUANA = isnull( d.CODADUANA, t.CODADUANA ),t.TIPODESTIN = isnull( d.TIPODESTIN, t.TIPODESTIN ),t.NRODESPA = isnull( d.NRODESPA, t.NRODESPA ),t.DIGVERIF = isnull( d.DIGVERIF, t.DIGVERIF )
					from ZooLogic.TIPOCOMPCOM t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.TIPOCOMPCOM(Faltafw,Fectrans,Fecimpo,Fmodifw,Fecexpo,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Saltafw,Smodifw,Horaimpo,Bdmodifw,Esttrans,Bdaltafw,Codigocor,Codigo,Tipocompor,Codope,Porliquia,Ivaliquia,Despacho,Anodespa,Codaduana,Tipodestin,Nrodespa,Digverif)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGOCOR,''),isnull( d.CODIGO,''),isnull( d.TIPOCOMPOR,0),isnull( d.CODOPE,''),isnull( d.PORLIQUIA,0),isnull( d.IVALIQUIA,0),isnull( d.DESPACHO,''),isnull( d.ANODESPA,''),isnull( d.CODADUANA,''),isnull( d.TIPODESTIN,''),isnull( d.NRODESPA,''),isnull( d.DIGVERIF,'')
						From deleted d left join ZooLogic.TIPOCOMPCOM pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TipoCompCom') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TipoCompCom
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIPODECOMPROBANTEDECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPODECOMPROBANTEDECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPODECOMPROBANTEDECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPODECOMPROBANTEDECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPODECOMPROBANTEDECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIPODECOMPROBANTEDECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Horaaltafw, [] )
					.Horaexpo = nvl( c_TIPODECOMPROBANTEDECOMPRA.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_TIPODECOMPROBANTEDECOMPRA.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_TIPODECOMPROBANTEDECOMPRA.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_TIPODECOMPROBANTEDECOMPRA.Basededatosaltafw, [] )
					.Codigocomporigen = nvl( c_TIPODECOMPROBANTEDECOMPRA.Codigocomporigen, [] )
					.Codigo = nvl( c_TIPODECOMPROBANTEDECOMPRA.Codigo, [] )
					.Tipocomporigen = nvl( c_TIPODECOMPROBANTEDECOMPRA.Tipocomporigen, 0 )
					.Codigooperacion = nvl( c_TIPODECOMPROBANTEDECOMPRA.Codigooperacion, [] )
					.Porcentajedeivaliqa = nvl( c_TIPODECOMPROBANTEDECOMPRA.Porcentajedeivaliqa, 0 )
					.Montodeivaliqa = nvl( c_TIPODECOMPROBANTEDECOMPRA.Montodeivaliqa, 0 )
					.Despacho_PK =  nvl( c_TIPODECOMPROBANTEDECOMPRA.Despacho, [] )
					.Anodespacho = nvl( c_TIPODECOMPROBANTEDECOMPRA.Anodespacho, [] )
					.Codigodeaduana = nvl( c_TIPODECOMPROBANTEDECOMPRA.Codigodeaduana, [] )
					.Tipodedestino = nvl( c_TIPODECOMPROBANTEDECOMPRA.Tipodedestino, [] )
					.Nrodespacho = nvl( c_TIPODECOMPROBANTEDECOMPRA.Nrodespacho, [] )
					.Digitoverificador = nvl( c_TIPODECOMPROBANTEDECOMPRA.Digitoverificador, [] )
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
		return c_TIPODECOMPROBANTEDECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TIPOCOMPCOM' )
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
								from ZooLogic.TIPOCOMPCOM 
								Where   TIPOCOMPCOM.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TIPOCOMPCOM", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigocor" as "Codigocomporigen", "Codigo" as "Codigo", "Tipocompor" as "Tipocomporigen", "Codope" as "Codigooperacion", "Porliquia" as "Porcentajedeivaliqa", "Ivaliquia" as "Montodeivaliqa", "Despacho" as "Despacho", "Anodespa" as "Anodespacho", "Codaduana" as "Codigodeaduana", "Tipodestin" as "Tipodedestino", "Nrodespa" as "Nrodespacho", "Digverif" as "Digitoverificador"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TIPOCOMPCOM 
								Where   TIPOCOMPCOM.CODIGO != ''
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
	Tabla = 'TIPOCOMPCOM'
	Filtro = " TIPOCOMPCOM.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TIPOCOMPCOM.CODIGO != ''"
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
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="FECHAALTAFW                             " tabla="TIPOCOMPCOM    " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="FECHATRANSFERENCIA                      " tabla="TIPOCOMPCOM    " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="FECHAIMPO                               " tabla="TIPOCOMPCOM    " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="FECHAMODIFICACIONFW                     " tabla="TIPOCOMPCOM    " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="FECHAEXPO                               " tabla="TIPOCOMPCOM    " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="HORAALTAFW                              " tabla="TIPOCOMPCOM    " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="HORAEXPO                                " tabla="TIPOCOMPCOM    " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="HORAMODIFICACIONFW                      " tabla="TIPOCOMPCOM    " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="VERSIONMODIFICACIONFW                   " tabla="TIPOCOMPCOM    " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="ZADSFW                                  " tabla="TIPOCOMPCOM    " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="VERSIONALTAFW                           " tabla="TIPOCOMPCOM    " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="USUARIOALTAFW                           " tabla="TIPOCOMPCOM    " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="USUARIOMODIFICACIONFW                   " tabla="TIPOCOMPCOM    " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="SERIEALTAFW                             " tabla="TIPOCOMPCOM    " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="SERIEMODIFICACIONFW                     " tabla="TIPOCOMPCOM    " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="HORAIMPO                                " tabla="TIPOCOMPCOM    " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TIPOCOMPCOM    " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="ESTADOTRANSFERENCIA                     " tabla="TIPOCOMPCOM    " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="BASEDEDATOSALTAFW                       " tabla="TIPOCOMPCOM    " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="CODIGOCOMPORIGEN                        " tabla="TIPOCOMPCOM    " campo="CODIGOCOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="CODIGO                                  " tabla="TIPOCOMPCOM    " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="LETRACOMPORIGEN                         " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Número factura                                                                                                                                                  " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="PTOVTAEXTCOMPORIGEN                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="NROCOMPORIGEN                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="                                                                                                                                                                " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="TIPOCOMPORIGEN                          " tabla="TIPOCOMPCOM    " campo="TIPOCOMPOR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="COMBOTIPODECOMPROBANTEDECOMPRA" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="PTOVTACOMPORIGEN                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="                                                                                                                                                                " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="CODIGOOPERACION                         " tabla="TIPOCOMPCOM    " campo="CODOPE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Código de operación                                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="PORCENTAJEDEIVALIQA                     " tabla="TIPOCOMPCOM    " campo="PORLIQUIA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Porcentaje de I.V.A.                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="55" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="MONTODEIVALIQA                          " tabla="TIPOCOMPCOM    " campo="IVALIQUIA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Monto de I.V.A.                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="58" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="DESPACHO                                " tabla="TIPOCOMPCOM    " campo="DESPACHO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESPACHODEIMPORTACION                   " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Despacho de importación                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="ANODESPACHO                             " tabla="TIPOCOMPCOM    " campo="ANODESPA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Año del despacho                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="CODIGODEADUANA                          " tabla="TIPOCOMPCOM    " campo="CODADUANA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Código de aduana                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999                      " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="TIPODEDESTINO                           " tabla="TIPOCOMPCOM    " campo="TIPODESTIN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Tipo de destino                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="XXNN                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="NRODESPACHO                             " tabla="TIPOCOMPCOM    " campo="NRODESPA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Número de despacho                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="100" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODECOMPROBANTEDECOMPRA               " atributo="DIGITOVERIFICADOR                       " tabla="TIPOCOMPCOM    " campo="DIGVERIF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="22" etiqueta="Dígito verificador                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="110" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESPACHODEIMPORTACION                   " atributo="DESPACHO                                " tabla="DESPIMP        " campo="DESPACHO  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Des.                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESPIMP On TIPOCOMPCOM.DESPACHO = DESPIMP.Despacho And  DESPIMP.DESPACHO != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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