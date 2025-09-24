
define class Din_EntidadDATOSADICIONALESSIREAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DATOSADICIONALESSIRE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_DSIPK'
	cTablaPrincipal = 'AFIP4523'
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
			local  lxAfip4523Fecexpo, lxAfip4523Fectrans, lxAfip4523Fmodifw, lxAfip4523Faltafw, lxAfip4523Fecimpo, lxAfip4523Saltafw, lxAfip4523Hmodifw, lxAfip4523Smodifw, lxAfip4523Umodifw, lxAfip4523Ualtafw, lxAfip4523Zadsfw, lxAfip4523Valtafw, lxAfip4523Vmodifw, lxAfip4523Horaimpo, lxAfip4523Haltafw, lxAfip4523Horaexpo, lxAfip4523Bdmodifw, lxAfip4523Bdaltafw, lxAfip4523Esttrans, lxAfip4523Codigo, lxAfip4523Motivo, lxAfip4523Fecha, lxAfip4523Nrocerti, lxAfip4523Importe, lxAfip4523Motivoanul, lxAfip4523Codcomp
				lxAfip4523Fecexpo =  .Fechaexpo			lxAfip4523Fectrans =  .Fechatransferencia			lxAfip4523Fmodifw =  .Fechamodificacionfw			lxAfip4523Faltafw =  .Fechaaltafw			lxAfip4523Fecimpo =  .Fechaimpo			lxAfip4523Saltafw =  .Seriealtafw			lxAfip4523Hmodifw =  .Horamodificacionfw			lxAfip4523Smodifw =  .Seriemodificacionfw			lxAfip4523Umodifw =  .Usuariomodificacionfw			lxAfip4523Ualtafw =  .Usuarioaltafw			lxAfip4523Zadsfw =  .Zadsfw			lxAfip4523Valtafw =  .Versionaltafw			lxAfip4523Vmodifw =  .Versionmodificacionfw			lxAfip4523Horaimpo =  .Horaimpo			lxAfip4523Haltafw =  .Horaaltafw			lxAfip4523Horaexpo =  .Horaexpo			lxAfip4523Bdmodifw =  .Basededatosmodificacionfw			lxAfip4523Bdaltafw =  .Basededatosaltafw			lxAfip4523Esttrans =  .Estadotransferencia			lxAfip4523Codigo =  .Codigo			lxAfip4523Motivo =  .Motivo			lxAfip4523Fecha =  .Fecha			lxAfip4523Nrocerti =  .Certificado			lxAfip4523Importe =  .Importe			lxAfip4523Motivoanul =  .Motivoanulacion			lxAfip4523Codcomp =  .Codigocomprobanteorigen
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAfip4523Codigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.AFIP4523 ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Codigo","Motivo","Fecha","Nrocerti","Importe","Motivoanul","Codcomp" ) values ( <<"'" + this.ConvertirDateSql( lxAfip4523Fecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Faltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Saltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Hmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Smodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Umodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Ualtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Zadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Valtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Vmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Horaimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Haltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Horaexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Bdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Bdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Esttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Motivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Nrocerti ) + "'" >>, <<lxAfip4523Importe >>, <<lxAfip4523Motivoanul >>, <<"'" + this.FormatearTextoSql( lxAfip4523Codcomp ) + "'" >> )
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
			local  lxAfip4523Fecexpo, lxAfip4523Fectrans, lxAfip4523Fmodifw, lxAfip4523Faltafw, lxAfip4523Fecimpo, lxAfip4523Saltafw, lxAfip4523Hmodifw, lxAfip4523Smodifw, lxAfip4523Umodifw, lxAfip4523Ualtafw, lxAfip4523Zadsfw, lxAfip4523Valtafw, lxAfip4523Vmodifw, lxAfip4523Horaimpo, lxAfip4523Haltafw, lxAfip4523Horaexpo, lxAfip4523Bdmodifw, lxAfip4523Bdaltafw, lxAfip4523Esttrans, lxAfip4523Codigo, lxAfip4523Motivo, lxAfip4523Fecha, lxAfip4523Nrocerti, lxAfip4523Importe, lxAfip4523Motivoanul, lxAfip4523Codcomp
				lxAfip4523Fecexpo =  .Fechaexpo			lxAfip4523Fectrans =  .Fechatransferencia			lxAfip4523Fmodifw =  .Fechamodificacionfw			lxAfip4523Faltafw =  .Fechaaltafw			lxAfip4523Fecimpo =  .Fechaimpo			lxAfip4523Saltafw =  .Seriealtafw			lxAfip4523Hmodifw =  .Horamodificacionfw			lxAfip4523Smodifw =  .Seriemodificacionfw			lxAfip4523Umodifw =  .Usuariomodificacionfw			lxAfip4523Ualtafw =  .Usuarioaltafw			lxAfip4523Zadsfw =  .Zadsfw			lxAfip4523Valtafw =  .Versionaltafw			lxAfip4523Vmodifw =  .Versionmodificacionfw			lxAfip4523Horaimpo =  .Horaimpo			lxAfip4523Haltafw =  .Horaaltafw			lxAfip4523Horaexpo =  .Horaexpo			lxAfip4523Bdmodifw =  .Basededatosmodificacionfw			lxAfip4523Bdaltafw =  .Basededatosaltafw			lxAfip4523Esttrans =  .Estadotransferencia			lxAfip4523Codigo =  .Codigo			lxAfip4523Motivo =  .Motivo			lxAfip4523Fecha =  .Fecha			lxAfip4523Nrocerti =  .Certificado			lxAfip4523Importe =  .Importe			lxAfip4523Motivoanul =  .Motivoanulacion			lxAfip4523Codcomp =  .Codigocomprobanteorigen
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.AFIP4523 set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAfip4523Fecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAfip4523Fectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAfip4523Fmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAfip4523Faltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAfip4523Fecimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Saltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Hmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Smodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Umodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Ualtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAfip4523Zadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Valtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Vmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAfip4523Horaimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Haltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAfip4523Horaexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Bdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Bdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAfip4523Esttrans ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'">>,"Motivo" = <<"'" + this.FormatearTextoSql( lxAfip4523Motivo ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxAfip4523Fecha ) + "'">>,"Nrocerti" = <<"'" + this.FormatearTextoSql( lxAfip4523Nrocerti ) + "'">>,"Importe" = <<lxAfip4523Importe>>,"Motivoanul" = <<lxAfip4523Motivoanul>>,"Codcomp" = <<"'" + this.FormatearTextoSql( lxAfip4523Codcomp ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'">> and  AFIP4523.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.AFIP4523 where " + this.ConvertirFuncionesSql( " AFIP4523.CODIGO != ''" ) )
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
			Local lxAfip4523Codigo
			lxAfip4523Codigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen" from ZooLogic.AFIP4523 where "Codigo" = <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'">> and  AFIP4523.CODIGO != ''
			endtext
			use in select('c_DATOSADICIONALESSIRE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIRE', set( 'Datasession' ) )

			if reccount( 'c_DATOSADICIONALESSIRE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAfip4523Codigo as Variant
		llRetorno = .t.
		lxAfip4523Codigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.AFIP4523 where "Codigo" = <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'">> and  AFIP4523.CODIGO != ''
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
				lcOrden =  .Motivo +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Certificado + str( .Importe, 11, 2) + str( .MotivoAnulacion, 1, 0) + .CodigoComprobanteOrigen + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen" from ZooLogic.AFIP4523 where  AFIP4523.CODIGO != '' order by Motivo,Fecha,NroCerti,Importe,MotivoAnul,CodComp,Codigo
			endtext
			use in select('c_DATOSADICIONALESSIRE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIRE', set( 'Datasession' ) )
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
				lcOrden =  .Motivo +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Certificado + str( .Importe, 11, 2) + str( .MotivoAnulacion, 1, 0) + .CodigoComprobanteOrigen + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen" from ZooLogic.AFIP4523 where  funciones.padr( Motivo, 30, ' ' ) + funciones.dtos( Fecha ) + funciones.padr( NroCerti, 25, ' ' ) + str( Importe, 11, 2) + str( MotivoAnul, 1, 0) + funciones.padr( CodComp, 38, ' ' ) + funciones.padr( Codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AFIP4523.CODIGO != '' order by Motivo,Fecha,NroCerti,Importe,MotivoAnul,CodComp,Codigo
			endtext
			use in select('c_DATOSADICIONALESSIRE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIRE', set( 'Datasession' ) )
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
				lcOrden =  .Motivo +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Certificado + str( .Importe, 11, 2) + str( .MotivoAnulacion, 1, 0) + .CodigoComprobanteOrigen + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen" from ZooLogic.AFIP4523 where  funciones.padr( Motivo, 30, ' ' ) + funciones.dtos( Fecha ) + funciones.padr( NroCerti, 25, ' ' ) + str( Importe, 11, 2) + str( MotivoAnul, 1, 0) + funciones.padr( CodComp, 38, ' ' ) + funciones.padr( Codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  AFIP4523.CODIGO != '' order by Motivo desc,Fecha desc,NroCerti desc,Importe desc,MotivoAnul desc,CodComp desc,Codigo desc
			endtext
			use in select('c_DATOSADICIONALESSIRE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIRE', set( 'Datasession' ) )
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
				lcOrden =  .Motivo +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Certificado + str( .Importe, 11, 2) + str( .MotivoAnulacion, 1, 0) + .CodigoComprobanteOrigen + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen" from ZooLogic.AFIP4523 where  AFIP4523.CODIGO != '' order by Motivo desc,Fecha desc,NroCerti desc,Importe desc,MotivoAnul desc,CodComp desc,Codigo desc
			endtext
			use in select('c_DATOSADICIONALESSIRE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DATOSADICIONALESSIRE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valt" + ;
"afw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Codigo,Motivo,Fecha,Nrocerti,Import" + ;
"e,Motivoanul,Codcomp" + ;
" from ZooLogic.AFIP4523 where  AFIP4523.CODIGO != '' and " + lcFiltro )
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
			local  lxAfip4523Fecexpo, lxAfip4523Fectrans, lxAfip4523Fmodifw, lxAfip4523Faltafw, lxAfip4523Fecimpo, lxAfip4523Saltafw, lxAfip4523Hmodifw, lxAfip4523Smodifw, lxAfip4523Umodifw, lxAfip4523Ualtafw, lxAfip4523Zadsfw, lxAfip4523Valtafw, lxAfip4523Vmodifw, lxAfip4523Horaimpo, lxAfip4523Haltafw, lxAfip4523Horaexpo, lxAfip4523Bdmodifw, lxAfip4523Bdaltafw, lxAfip4523Esttrans, lxAfip4523Codigo, lxAfip4523Motivo, lxAfip4523Fecha, lxAfip4523Nrocerti, lxAfip4523Importe, lxAfip4523Motivoanul, lxAfip4523Codcomp
				lxAfip4523Fecexpo = ctod( '  /  /    ' )			lxAfip4523Fectrans = ctod( '  /  /    ' )			lxAfip4523Fmodifw = ctod( '  /  /    ' )			lxAfip4523Faltafw = ctod( '  /  /    ' )			lxAfip4523Fecimpo = ctod( '  /  /    ' )			lxAfip4523Saltafw = []			lxAfip4523Hmodifw = []			lxAfip4523Smodifw = []			lxAfip4523Umodifw = []			lxAfip4523Ualtafw = []			lxAfip4523Zadsfw = []			lxAfip4523Valtafw = []			lxAfip4523Vmodifw = []			lxAfip4523Horaimpo = []			lxAfip4523Haltafw = []			lxAfip4523Horaexpo = []			lxAfip4523Bdmodifw = []			lxAfip4523Bdaltafw = []			lxAfip4523Esttrans = []			lxAfip4523Codigo = []			lxAfip4523Motivo = []			lxAfip4523Fecha = ctod( '  /  /    ' )			lxAfip4523Nrocerti = []			lxAfip4523Importe = 0			lxAfip4523Motivoanul = 0			lxAfip4523Codcomp = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.AFIP4523 where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'AFIP4523' + '_' + tcCampo
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
		lcWhere = " Where  AFIP4523.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AFIP4523', '', tnTope )
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
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MOTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVO AS MOTIVO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'CERTIFICADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCERTI AS CERTIFICADO'
				Case lcAtributo == 'IMPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPORTE AS IMPORTE'
				Case lcAtributo == 'MOTIVOANULACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTIVOANUL AS MOTIVOANULACION'
				Case lcAtributo == 'CODIGOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTEORIGEN'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVO'
				lcCampo = 'MOTIVO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CERTIFICADO'
				lcCampo = 'NROCERTI'
			Case upper( alltrim( tcAtributo ) ) == 'IMPORTE'
				lcCampo = 'IMPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'MOTIVOANULACION'
				lcCampo = 'MOTIVOANUL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEORIGEN'
				lcCampo = 'CODCOMP'
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
			local  lxAfip4523Fecexpo, lxAfip4523Fectrans, lxAfip4523Fmodifw, lxAfip4523Faltafw, lxAfip4523Fecimpo, lxAfip4523Saltafw, lxAfip4523Hmodifw, lxAfip4523Smodifw, lxAfip4523Umodifw, lxAfip4523Ualtafw, lxAfip4523Zadsfw, lxAfip4523Valtafw, lxAfip4523Vmodifw, lxAfip4523Horaimpo, lxAfip4523Haltafw, lxAfip4523Horaexpo, lxAfip4523Bdmodifw, lxAfip4523Bdaltafw, lxAfip4523Esttrans, lxAfip4523Codigo, lxAfip4523Motivo, lxAfip4523Fecha, lxAfip4523Nrocerti, lxAfip4523Importe, lxAfip4523Motivoanul, lxAfip4523Codcomp
				lxAfip4523Fecexpo =  .Fechaexpo			lxAfip4523Fectrans =  .Fechatransferencia			lxAfip4523Fmodifw =  .Fechamodificacionfw			lxAfip4523Faltafw =  .Fechaaltafw			lxAfip4523Fecimpo =  .Fechaimpo			lxAfip4523Saltafw =  .Seriealtafw			lxAfip4523Hmodifw =  .Horamodificacionfw			lxAfip4523Smodifw =  .Seriemodificacionfw			lxAfip4523Umodifw =  .Usuariomodificacionfw			lxAfip4523Ualtafw =  .Usuarioaltafw			lxAfip4523Zadsfw =  .Zadsfw			lxAfip4523Valtafw =  .Versionaltafw			lxAfip4523Vmodifw =  .Versionmodificacionfw			lxAfip4523Horaimpo =  .Horaimpo			lxAfip4523Haltafw =  .Horaaltafw			lxAfip4523Horaexpo =  .Horaexpo			lxAfip4523Bdmodifw =  .Basededatosmodificacionfw			lxAfip4523Bdaltafw =  .Basededatosaltafw			lxAfip4523Esttrans =  .Estadotransferencia			lxAfip4523Codigo =  .Codigo			lxAfip4523Motivo =  .Motivo			lxAfip4523Fecha =  .Fecha			lxAfip4523Nrocerti =  .Certificado			lxAfip4523Importe =  .Importe			lxAfip4523Motivoanul =  .Motivoanulacion			lxAfip4523Codcomp =  .Codigocomprobanteorigen
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.AFIP4523 ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Saltafw","Hmodifw","Smodifw","Umodifw","Ualtafw","Zadsfw","Valtafw","Vmodifw","Horaimpo","Haltafw","Horaexpo","Bdmodifw","Bdaltafw","Esttrans","Codigo","Motivo","Fecha","Nrocerti","Importe","Motivoanul","Codcomp" ) values ( <<"'" + this.ConvertirDateSql( lxAfip4523Fecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Faltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Saltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Hmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Smodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Umodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Ualtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Zadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Valtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Vmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Horaimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Haltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Horaexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Bdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Bdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Esttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Motivo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAfip4523Fecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAfip4523Nrocerti ) + "'" >>, <<lxAfip4523Importe >>, <<lxAfip4523Motivoanul >>, <<"'" + this.FormatearTextoSql( lxAfip4523Codcomp ) + "'" >> )
		endtext
		loColeccion.cTabla = 'AFIP4523' 
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
			local  lxAfip4523Fecexpo, lxAfip4523Fectrans, lxAfip4523Fmodifw, lxAfip4523Faltafw, lxAfip4523Fecimpo, lxAfip4523Saltafw, lxAfip4523Hmodifw, lxAfip4523Smodifw, lxAfip4523Umodifw, lxAfip4523Ualtafw, lxAfip4523Zadsfw, lxAfip4523Valtafw, lxAfip4523Vmodifw, lxAfip4523Horaimpo, lxAfip4523Haltafw, lxAfip4523Horaexpo, lxAfip4523Bdmodifw, lxAfip4523Bdaltafw, lxAfip4523Esttrans, lxAfip4523Codigo, lxAfip4523Motivo, lxAfip4523Fecha, lxAfip4523Nrocerti, lxAfip4523Importe, lxAfip4523Motivoanul, lxAfip4523Codcomp
				lxAfip4523Fecexpo =  .Fechaexpo			lxAfip4523Fectrans =  .Fechatransferencia			lxAfip4523Fmodifw =  .Fechamodificacionfw			lxAfip4523Faltafw =  .Fechaaltafw			lxAfip4523Fecimpo =  .Fechaimpo			lxAfip4523Saltafw =  .Seriealtafw			lxAfip4523Hmodifw =  .Horamodificacionfw			lxAfip4523Smodifw =  .Seriemodificacionfw			lxAfip4523Umodifw =  .Usuariomodificacionfw			lxAfip4523Ualtafw =  .Usuarioaltafw			lxAfip4523Zadsfw =  .Zadsfw			lxAfip4523Valtafw =  .Versionaltafw			lxAfip4523Vmodifw =  .Versionmodificacionfw			lxAfip4523Horaimpo =  .Horaimpo			lxAfip4523Haltafw =  .Horaaltafw			lxAfip4523Horaexpo =  .Horaexpo			lxAfip4523Bdmodifw =  .Basededatosmodificacionfw			lxAfip4523Bdaltafw =  .Basededatosaltafw			lxAfip4523Esttrans =  .Estadotransferencia			lxAfip4523Codigo =  .Codigo			lxAfip4523Motivo =  .Motivo			lxAfip4523Fecha =  .Fecha			lxAfip4523Nrocerti =  .Certificado			lxAfip4523Importe =  .Importe			lxAfip4523Motivoanul =  .Motivoanulacion			lxAfip4523Codcomp =  .Codigocomprobanteorigen
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AFIP4523.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.AFIP4523 set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAfip4523Fecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAfip4523Fectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAfip4523Fmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAfip4523Faltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAfip4523Fecimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Saltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Hmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Smodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Umodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Ualtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAfip4523Zadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Valtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Vmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAfip4523Horaimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Haltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAfip4523Horaexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAfip4523Bdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAfip4523Bdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAfip4523Esttrans ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAfip4523Codigo ) + "'">>, "Motivo" = <<"'" + this.FormatearTextoSql( lxAfip4523Motivo ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxAfip4523Fecha ) + "'">>, "Nrocerti" = <<"'" + this.FormatearTextoSql( lxAfip4523Nrocerti ) + "'">>, "Importe" = <<lxAfip4523Importe>>, "Motivoanul" = <<lxAfip4523Motivoanul>>, "Codcomp" = <<"'" + this.FormatearTextoSql( lxAfip4523Codcomp ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'AFIP4523' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  AFIP4523.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.AFIP4523 where ' + lcFiltro )
			loColeccion.cTabla = 'AFIP4523' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.AFIP4523 where  AFIP4523.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.AFIP4523 where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  AFIP4523.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIRE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.AFIP4523 Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.AFIP4523 set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Motivo = ] + "'" + this.FormatearTextoSql( &lcCursor..Motivo ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, NroCerti = ] + "'" + this.FormatearTextoSql( &lcCursor..NroCerti ) + "'"+ [, Importe = ] + transform( &lcCursor..Importe )+ [, MotivoAnul = ] + transform( &lcCursor..MotivoAnul )+ [, CodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, SALTAFW, HMODIFW, SMODIFW, UMODIFW, UALTAFW, ZADSFW, VALTAFW, VMODIFW, HORAIMPO, HALTAFW, HORAEXPO, BDMODIFW, BDALTAFW, ESTTRANS, Codigo, Motivo, Fecha, NroCerti, Importe, MotivoAnul, CodComp
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Motivo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroCerti ) + "'" + ',' + transform( &lcCursor..Importe ) + ',' + transform( &lcCursor..MotivoAnul ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodComp ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.AFIP4523 ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIRE'
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
			Case  lcAlias == lcPrefijo + 'DATOSADICIONALESSIRE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DATOSADICIONALESSIRE_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_AFIP4523')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DATOSADICIONALESSIRE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DATOSADICIONALESSIRE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIRE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIRE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_AFIP4523') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_AFIP4523
Create Table ZooLogic.TablaTrabajo_AFIP4523 ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"codigo" char( 38 )  null, 
"motivo" char( 30 )  null, 
"fecha" datetime  null, 
"nrocerti" char( 25 )  null, 
"importe" numeric( 11, 2 )  null, 
"motivoanul" numeric( 1, 0 )  null, 
"codcomp" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_AFIP4523' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_AFIP4523' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DATOSADICIONALESSIRE'
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
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('motivo','motivo')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('nrocerti','nrocerti')
			.AgregarMapeo('importe','importe')
			.AgregarMapeo('motivoanul','motivoanul')
			.AgregarMapeo('codcomp','codcomp')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_AFIP4523'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MOTIVO = isnull( d.MOTIVO, t.MOTIVO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.NROCERTI = isnull( d.NROCERTI, t.NROCERTI ),t.IMPORTE = isnull( d.IMPORTE, t.IMPORTE ),t.MOTIVOANUL = isnull( d.MOTIVOANUL, t.MOTIVOANUL ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP )
					from ZooLogic.AFIP4523 t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.AFIP4523(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Saltafw,Hmodifw,Smodifw,Umodifw,Ualtafw,Zadsfw,Valtafw,Vmodifw,Horaimpo,Haltafw,Horaexpo,Bdmodifw,Bdaltafw,Esttrans,Codigo,Motivo,Fecha,Nrocerti,Importe,Motivoanul,Codcomp)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.CODIGO,''),isnull( d.MOTIVO,''),isnull( d.FECHA,''),isnull( d.NROCERTI,''),isnull( d.IMPORTE,0),isnull( d.MOTIVOANUL,0),isnull( d.CODCOMP,'')
						From deleted d left join ZooLogic.AFIP4523 pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_AFIP4523') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_AFIP4523
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DATOSADICIONALESSIRE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIRE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIRE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIRE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIRE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIRE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_DATOSADICIONALESSIRE.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_DATOSADICIONALESSIRE.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_DATOSADICIONALESSIRE.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_DATOSADICIONALESSIRE.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_DATOSADICIONALESSIRE.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_DATOSADICIONALESSIRE.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_DATOSADICIONALESSIRE.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_DATOSADICIONALESSIRE.Horaimpo, [] )
					.Horaaltafw = nvl( c_DATOSADICIONALESSIRE.Horaaltafw, [] )
					.Horaexpo = nvl( c_DATOSADICIONALESSIRE.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_DATOSADICIONALESSIRE.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_DATOSADICIONALESSIRE.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_DATOSADICIONALESSIRE.Estadotransferencia, [] )
					.Codigo = nvl( c_DATOSADICIONALESSIRE.Codigo, [] )
					.Motivo = nvl( c_DATOSADICIONALESSIRE.Motivo, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_DATOSADICIONALESSIRE.Fecha, ctod( '  /  /    ' ) ) )
					.Certificado = nvl( c_DATOSADICIONALESSIRE.Certificado, [] )
					.Importe = nvl( c_DATOSADICIONALESSIRE.Importe, 0 )
					.Motivoanulacion = nvl( c_DATOSADICIONALESSIRE.Motivoanulacion, 0 )
					.Codigocomprobanteorigen = nvl( c_DATOSADICIONALESSIRE.Codigocomprobanteorigen, [] )
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
		return c_DATOSADICIONALESSIRE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.AFIP4523' )
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
								from ZooLogic.AFIP4523 
								Where   AFIP4523.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "AFIP4523", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Codigo" as "Codigo", "Motivo" as "Motivo", "Fecha" as "Fecha", "Nrocerti" as "Certificado", "Importe" as "Importe", "Motivoanul" as "Motivoanulacion", "Codcomp" as "Codigocomprobanteorigen"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.AFIP4523 
								Where   AFIP4523.CODIGO != ''
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
	Tabla = 'AFIP4523'
	Filtro = " AFIP4523.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " AFIP4523.CODIGO != ''"
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
	<row entidad="DATOSADICIONALESSIRE                    " atributo="FECHAEXPO                               " tabla="AFIP4523       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="FECHATRANSFERENCIA                      " tabla="AFIP4523       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="FECHAMODIFICACIONFW                     " tabla="AFIP4523       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="FECHAALTAFW                             " tabla="AFIP4523       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="FECHAIMPO                               " tabla="AFIP4523       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="SERIEALTAFW                             " tabla="AFIP4523       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="HORAMODIFICACIONFW                      " tabla="AFIP4523       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="SERIEMODIFICACIONFW                     " tabla="AFIP4523       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="USUARIOMODIFICACIONFW                   " tabla="AFIP4523       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="USUARIOALTAFW                           " tabla="AFIP4523       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="ZADSFW                                  " tabla="AFIP4523       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="VERSIONALTAFW                           " tabla="AFIP4523       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="VERSIONMODIFICACIONFW                   " tabla="AFIP4523       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="HORAIMPO                                " tabla="AFIP4523       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="HORAALTAFW                              " tabla="AFIP4523       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="HORAEXPO                                " tabla="AFIP4523       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="AFIP4523       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="BASEDEDATOSALTAFW                       " tabla="AFIP4523       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="ESTADOTRANSFERENCIA                     " tabla="AFIP4523       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="CODIGO                                  " tabla="AFIP4523       " campo="CODIGO    " claveprimaria="true" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="MOTIVO                                  " tabla="AFIP4523       " campo="MOTIVO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="200" etiqueta="Motivo de emisión                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="FECHA                                   " tabla="AFIP4523       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="201" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="CERTIFICADO                             " tabla="AFIP4523       " campo="NROCERTI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Número de certificado                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="IMPORTE                                 " tabla="AFIP4523       " campo="IMPORTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="11" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="202" etiqueta="Importe                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="MOTIVOANULACION                         " tabla="AFIP4523       " campo="MOTIVOANUL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="203" etiqueta="Motivo de anulación                                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DATOSADICIONALESSIRE                    " atributo="CODIGOCOMPROBANTEORIGEN                 " tabla="AFIP4523       " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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