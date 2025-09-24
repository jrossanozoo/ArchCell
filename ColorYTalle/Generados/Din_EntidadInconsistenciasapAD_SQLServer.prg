
define class Din_EntidadINCONSISTENCIASAPAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_INCONSISTENCIASAP'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_INSPK'
	cTablaPrincipal = 'INCONSAP'
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
			local  lxInconsapFecimpo, lxInconsapFecexpo, lxInconsapFmodifw, lxInconsapFectrans, lxInconsapFaltafw, lxInconsapSaltafw, lxInconsapHoraimpo, lxInconsapHmodifw, lxInconsapSmodifw, lxInconsapUmodifw, lxInconsapVmodifw, lxInconsapZadsfw, lxInconsapValtafw, lxInconsapUaltafw, lxInconsapHoraexpo, lxInconsapEsttrans, lxInconsapBdmodifw, lxInconsapHaltafw, lxInconsapBdaltafw, lxInconsapCoddet, lxInconsapBasedatos, lxInconsapHora, lxInconsapFecha, lxInconsapComp, lxInconsapHoracomp, lxInconsapFechacomp, lxInconsapCoderror, lxInconsapProblema, lxInconsapExplica, lxInconsapObs
				lxInconsapFecimpo =  .Fechaimpo			lxInconsapFecexpo =  .Fechaexpo			lxInconsapFmodifw =  .Fechamodificacionfw			lxInconsapFectrans =  .Fechatransferencia			lxInconsapFaltafw =  .Fechaaltafw			lxInconsapSaltafw =  .Seriealtafw			lxInconsapHoraimpo =  .Horaimpo			lxInconsapHmodifw =  .Horamodificacionfw			lxInconsapSmodifw =  .Seriemodificacionfw			lxInconsapUmodifw =  .Usuariomodificacionfw			lxInconsapVmodifw =  .Versionmodificacionfw			lxInconsapZadsfw =  .Zadsfw			lxInconsapValtafw =  .Versionaltafw			lxInconsapUaltafw =  .Usuarioaltafw			lxInconsapHoraexpo =  .Horaexpo			lxInconsapEsttrans =  .Estadotransferencia			lxInconsapBdmodifw =  .Basededatosmodificacionfw			lxInconsapHaltafw =  .Horaaltafw			lxInconsapBdaltafw =  .Basededatosaltafw			lxInconsapCoddet =  .Codigo			lxInconsapBasedatos =  .Basededatos			lxInconsapHora =  .Hora			lxInconsapFecha =  .Fecha			lxInconsapComp =  .Comprobante			lxInconsapHoracomp =  .Horacomprobante			lxInconsapFechacomp =  .Fechacomprobante			lxInconsapCoderror =  upper( .CodigoError_PK ) 			lxInconsapProblema =  .Errorinformado			lxInconsapExplica =  .Errorexplicacion			lxInconsapObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxInconsapCoddet = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.INCONSAP ( "Fecimpo","Fecexpo","Fmodifw","Fectrans","Faltafw","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Horaexpo","Esttrans","Bdmodifw","Haltafw","Bdaltafw","Coddet","Basedatos","Hora","Fecha","Comp","Horacomp","Fechacomp","Coderror","Problema","Explica","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxInconsapFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapBasedatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHora ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHoracomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFechacomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapCoderror ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapProblema ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapExplica ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapObs ) + "'" >> )
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
			local  lxInconsapFecimpo, lxInconsapFecexpo, lxInconsapFmodifw, lxInconsapFectrans, lxInconsapFaltafw, lxInconsapSaltafw, lxInconsapHoraimpo, lxInconsapHmodifw, lxInconsapSmodifw, lxInconsapUmodifw, lxInconsapVmodifw, lxInconsapZadsfw, lxInconsapValtafw, lxInconsapUaltafw, lxInconsapHoraexpo, lxInconsapEsttrans, lxInconsapBdmodifw, lxInconsapHaltafw, lxInconsapBdaltafw, lxInconsapCoddet, lxInconsapBasedatos, lxInconsapHora, lxInconsapFecha, lxInconsapComp, lxInconsapHoracomp, lxInconsapFechacomp, lxInconsapCoderror, lxInconsapProblema, lxInconsapExplica, lxInconsapObs
				lxInconsapFecimpo =  .Fechaimpo			lxInconsapFecexpo =  .Fechaexpo			lxInconsapFmodifw =  .Fechamodificacionfw			lxInconsapFectrans =  .Fechatransferencia			lxInconsapFaltafw =  .Fechaaltafw			lxInconsapSaltafw =  .Seriealtafw			lxInconsapHoraimpo =  .Horaimpo			lxInconsapHmodifw =  .Horamodificacionfw			lxInconsapSmodifw =  .Seriemodificacionfw			lxInconsapUmodifw =  .Usuariomodificacionfw			lxInconsapVmodifw =  .Versionmodificacionfw			lxInconsapZadsfw =  .Zadsfw			lxInconsapValtafw =  .Versionaltafw			lxInconsapUaltafw =  .Usuarioaltafw			lxInconsapHoraexpo =  .Horaexpo			lxInconsapEsttrans =  .Estadotransferencia			lxInconsapBdmodifw =  .Basededatosmodificacionfw			lxInconsapHaltafw =  .Horaaltafw			lxInconsapBdaltafw =  .Basededatosaltafw			lxInconsapCoddet =  .Codigo			lxInconsapBasedatos =  .Basededatos			lxInconsapHora =  .Hora			lxInconsapFecha =  .Fecha			lxInconsapComp =  .Comprobante			lxInconsapHoracomp =  .Horacomprobante			lxInconsapFechacomp =  .Fechacomprobante			lxInconsapCoderror =  upper( .CodigoError_PK ) 			lxInconsapProblema =  .Errorinformado			lxInconsapExplica =  .Errorexplicacion			lxInconsapObs =  .Observacion
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.INCONSAP set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxInconsapFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxInconsapFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxInconsapFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxInconsapFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxInconsapFaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxInconsapSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxInconsapHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxInconsapHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxInconsapSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxInconsapUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxInconsapVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxInconsapZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxInconsapValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxInconsapUaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxInconsapHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxInconsapEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxInconsapBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxInconsapHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxInconsapBdaltafw ) + "'">>,"Coddet" = <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'">>,"Basedatos" = <<"'" + this.FormatearTextoSql( lxInconsapBasedatos ) + "'">>,"Hora" = <<"'" + this.FormatearTextoSql( lxInconsapHora ) + "'">>,"Fecha" = <<"'" + this.ConvertirDateSql( lxInconsapFecha ) + "'">>,"Comp" = <<"'" + this.FormatearTextoSql( lxInconsapComp ) + "'">>,"Horacomp" = <<"'" + this.FormatearTextoSql( lxInconsapHoracomp ) + "'">>,"Fechacomp" = <<"'" + this.ConvertirDateSql( lxInconsapFechacomp ) + "'">>,"Coderror" = <<"'" + this.FormatearTextoSql( lxInconsapCoderror ) + "'">>,"Problema" = <<"'" + this.FormatearTextoSql( lxInconsapProblema ) + "'">>,"Explica" = <<"'" + this.FormatearTextoSql( lxInconsapExplica ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxInconsapObs ) + "'">> where "Coddet" = <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'">> and  INCONSAP.CODDET != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CodDet from ZooLogic.INCONSAP where " + this.ConvertirFuncionesSql( " INCONSAP.CODDET != ''" ) )
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
			Local lxInconsapCoddet
			lxInconsapCoddet = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion" from ZooLogic.INCONSAP where "Coddet" = <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'">> and  INCONSAP.CODDET != ''
			endtext
			use in select('c_INCONSISTENCIASAP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INCONSISTENCIASAP', set( 'Datasession' ) )

			if reccount( 'c_INCONSISTENCIASAP' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxInconsapCoddet as Variant
		llRetorno = .t.
		lxInconsapCoddet = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.INCONSAP where "Coddet" = <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'">> and  INCONSAP.CODDET != ''
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
				lcOrden =  .BaseDeDatos + .Hora +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Comprobante +  iif( empty( .FechaComprobante ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaComprobante ) ) + .HoraComprobante + .CodigoError_PK + .ErrorInformado + .ErrorExplicacion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion" from ZooLogic.INCONSAP where  INCONSAP.CODDET != '' order by BaseDatos,Hora,Fecha,Comp,FechaComp,HoraComp,CodError,Problema,Explica,CodDet
			endtext
			use in select('c_INCONSISTENCIASAP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INCONSISTENCIASAP', set( 'Datasession' ) )
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
				lcOrden =  .BaseDeDatos + .Hora +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Comprobante +  iif( empty( .FechaComprobante ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaComprobante ) ) + .HoraComprobante + .CodigoError_PK + .ErrorInformado + .ErrorExplicacion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion" from ZooLogic.INCONSAP where  funciones.padr( BaseDatos, 8, ' ' ) + funciones.padr( Hora, 10, ' ' ) + funciones.dtos( Fecha ) + funciones.padr( Comp, 25, ' ' ) + funciones.dtos( FechaComp ) + funciones.padr( HoraComp, 10, ' ' ) + funciones.padr( CodError, 10, ' ' ) + funciones.padr( Problema, 200, ' ' ) + funciones.padr( Explica, 200, ' ' ) + funciones.padr( CodDet, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INCONSAP.CODDET != '' order by BaseDatos,Hora,Fecha,Comp,FechaComp,HoraComp,CodError,Problema,Explica,CodDet
			endtext
			use in select('c_INCONSISTENCIASAP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INCONSISTENCIASAP', set( 'Datasession' ) )
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
				lcOrden =  .BaseDeDatos + .Hora +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Comprobante +  iif( empty( .FechaComprobante ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaComprobante ) ) + .HoraComprobante + .CodigoError_PK + .ErrorInformado + .ErrorExplicacion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion" from ZooLogic.INCONSAP where  funciones.padr( BaseDatos, 8, ' ' ) + funciones.padr( Hora, 10, ' ' ) + funciones.dtos( Fecha ) + funciones.padr( Comp, 25, ' ' ) + funciones.dtos( FechaComp ) + funciones.padr( HoraComp, 10, ' ' ) + funciones.padr( CodError, 10, ' ' ) + funciones.padr( Problema, 200, ' ' ) + funciones.padr( Explica, 200, ' ' ) + funciones.padr( CodDet, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  INCONSAP.CODDET != '' order by BaseDatos desc,Hora desc,Fecha desc,Comp desc,FechaComp desc,HoraComp desc,CodError desc,Problema desc,Explica desc,CodDet desc
			endtext
			use in select('c_INCONSISTENCIASAP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INCONSISTENCIASAP', set( 'Datasession' ) )
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
				lcOrden =  .BaseDeDatos + .Hora +  iif( empty( .Fecha ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .Fecha ) ) + .Comprobante +  iif( empty( .FechaComprobante ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaComprobante ) ) + .HoraComprobante + .CodigoError_PK + .ErrorInformado + .ErrorExplicacion + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion" from ZooLogic.INCONSAP where  INCONSAP.CODDET != '' order by BaseDatos desc,Hora desc,Fecha desc,Comp desc,FechaComp desc,HoraComp desc,CodError desc,Problema desc,Explica desc,CodDet desc
			endtext
			use in select('c_INCONSISTENCIASAP')
			this.oConexion.EjecutarSql( lcSentencia, 'c_INCONSISTENCIASAP', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fmodifw,Fectrans,Faltafw,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Vmodifw,Za" + ;
"dsfw,Valtafw,Ualtafw,Horaexpo,Esttrans,Bdmodifw,Haltafw,Bdaltafw,Coddet,Basedatos,Hora,Fecha,Comp,Ho" + ;
"racomp,Fechacomp,Coderror,Problema,Explica,Obs" + ;
" from ZooLogic.INCONSAP where  INCONSAP.CODDET != '' and " + lcFiltro )
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
			local  lxInconsapFecimpo, lxInconsapFecexpo, lxInconsapFmodifw, lxInconsapFectrans, lxInconsapFaltafw, lxInconsapSaltafw, lxInconsapHoraimpo, lxInconsapHmodifw, lxInconsapSmodifw, lxInconsapUmodifw, lxInconsapVmodifw, lxInconsapZadsfw, lxInconsapValtafw, lxInconsapUaltafw, lxInconsapHoraexpo, lxInconsapEsttrans, lxInconsapBdmodifw, lxInconsapHaltafw, lxInconsapBdaltafw, lxInconsapCoddet, lxInconsapBasedatos, lxInconsapHora, lxInconsapFecha, lxInconsapComp, lxInconsapHoracomp, lxInconsapFechacomp, lxInconsapCoderror, lxInconsapProblema, lxInconsapExplica, lxInconsapObs
				lxInconsapFecimpo = ctod( '  /  /    ' )			lxInconsapFecexpo = ctod( '  /  /    ' )			lxInconsapFmodifw = ctod( '  /  /    ' )			lxInconsapFectrans = ctod( '  /  /    ' )			lxInconsapFaltafw = ctod( '  /  /    ' )			lxInconsapSaltafw = []			lxInconsapHoraimpo = []			lxInconsapHmodifw = []			lxInconsapSmodifw = []			lxInconsapUmodifw = []			lxInconsapVmodifw = []			lxInconsapZadsfw = []			lxInconsapValtafw = []			lxInconsapUaltafw = []			lxInconsapHoraexpo = []			lxInconsapEsttrans = []			lxInconsapBdmodifw = []			lxInconsapHaltafw = []			lxInconsapBdaltafw = []			lxInconsapCoddet = []			lxInconsapBasedatos = []			lxInconsapHora = []			lxInconsapFecha = ctod( '  /  /    ' )			lxInconsapComp = []			lxInconsapHoracomp = []			lxInconsapFechacomp = ctod( '  /  /    ' )			lxInconsapCoderror = []			lxInconsapProblema = []			lxInconsapExplica = []			lxInconsapObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.INCONSAP where "CodDet" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'INCONSAP' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CodDet = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CodDet, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  INCONSAP.CODDET != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'INCONSAP', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODDET AS CODIGO'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEDATOS AS BASEDEDATOS'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPROBANTE'
				Case lcAtributo == 'HORACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORACOMP AS HORACOMPROBANTE'
				Case lcAtributo == 'FECHACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHACOMP AS FECHACOMPROBANTE'
				Case lcAtributo == 'CODIGOERROR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODERROR AS CODIGOERROR'
				Case lcAtributo == 'ERRORINFORMADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROBLEMA AS ERRORINFORMADO'
				Case lcAtributo == 'ERROREXPLICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPLICA AS ERROREXPLICACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODDET'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'BASEDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORACOMPROBANTE'
				lcCampo = 'HORACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMPROBANTE'
				lcCampo = 'FECHACOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOERROR'
				lcCampo = 'CODERROR'
			Case upper( alltrim( tcAtributo ) ) == 'ERRORINFORMADO'
				lcCampo = 'PROBLEMA'
			Case upper( alltrim( tcAtributo ) ) == 'ERROREXPLICACION'
				lcCampo = 'EXPLICA'
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
			local  lxInconsapFecimpo, lxInconsapFecexpo, lxInconsapFmodifw, lxInconsapFectrans, lxInconsapFaltafw, lxInconsapSaltafw, lxInconsapHoraimpo, lxInconsapHmodifw, lxInconsapSmodifw, lxInconsapUmodifw, lxInconsapVmodifw, lxInconsapZadsfw, lxInconsapValtafw, lxInconsapUaltafw, lxInconsapHoraexpo, lxInconsapEsttrans, lxInconsapBdmodifw, lxInconsapHaltafw, lxInconsapBdaltafw, lxInconsapCoddet, lxInconsapBasedatos, lxInconsapHora, lxInconsapFecha, lxInconsapComp, lxInconsapHoracomp, lxInconsapFechacomp, lxInconsapCoderror, lxInconsapProblema, lxInconsapExplica, lxInconsapObs
				lxInconsapFecimpo =  .Fechaimpo			lxInconsapFecexpo =  .Fechaexpo			lxInconsapFmodifw =  .Fechamodificacionfw			lxInconsapFectrans =  .Fechatransferencia			lxInconsapFaltafw =  .Fechaaltafw			lxInconsapSaltafw =  .Seriealtafw			lxInconsapHoraimpo =  .Horaimpo			lxInconsapHmodifw =  .Horamodificacionfw			lxInconsapSmodifw =  .Seriemodificacionfw			lxInconsapUmodifw =  .Usuariomodificacionfw			lxInconsapVmodifw =  .Versionmodificacionfw			lxInconsapZadsfw =  .Zadsfw			lxInconsapValtafw =  .Versionaltafw			lxInconsapUaltafw =  .Usuarioaltafw			lxInconsapHoraexpo =  .Horaexpo			lxInconsapEsttrans =  .Estadotransferencia			lxInconsapBdmodifw =  .Basededatosmodificacionfw			lxInconsapHaltafw =  .Horaaltafw			lxInconsapBdaltafw =  .Basededatosaltafw			lxInconsapCoddet =  .Codigo			lxInconsapBasedatos =  .Basededatos			lxInconsapHora =  .Hora			lxInconsapFecha =  .Fecha			lxInconsapComp =  .Comprobante			lxInconsapHoracomp =  .Horacomprobante			lxInconsapFechacomp =  .Fechacomprobante			lxInconsapCoderror =  upper( .CodigoError_PK ) 			lxInconsapProblema =  .Errorinformado			lxInconsapExplica =  .Errorexplicacion			lxInconsapObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.INCONSAP ( "Fecimpo","Fecexpo","Fmodifw","Fectrans","Faltafw","Saltafw","Horaimpo","Hmodifw","Smodifw","Umodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Horaexpo","Esttrans","Bdmodifw","Haltafw","Bdaltafw","Coddet","Basedatos","Hora","Fecha","Comp","Horacomp","Fechacomp","Coderror","Problema","Explica","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxInconsapFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapBasedatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHora ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapComp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapHoracomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxInconsapFechacomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapCoderror ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapProblema ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapExplica ) + "'" >>, <<"'" + this.FormatearTextoSql( lxInconsapObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'INCONSAP' 
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
			local  lxInconsapFecimpo, lxInconsapFecexpo, lxInconsapFmodifw, lxInconsapFectrans, lxInconsapFaltafw, lxInconsapSaltafw, lxInconsapHoraimpo, lxInconsapHmodifw, lxInconsapSmodifw, lxInconsapUmodifw, lxInconsapVmodifw, lxInconsapZadsfw, lxInconsapValtafw, lxInconsapUaltafw, lxInconsapHoraexpo, lxInconsapEsttrans, lxInconsapBdmodifw, lxInconsapHaltafw, lxInconsapBdaltafw, lxInconsapCoddet, lxInconsapBasedatos, lxInconsapHora, lxInconsapFecha, lxInconsapComp, lxInconsapHoracomp, lxInconsapFechacomp, lxInconsapCoderror, lxInconsapProblema, lxInconsapExplica, lxInconsapObs
				lxInconsapFecimpo =  .Fechaimpo			lxInconsapFecexpo =  .Fechaexpo			lxInconsapFmodifw =  .Fechamodificacionfw			lxInconsapFectrans =  .Fechatransferencia			lxInconsapFaltafw =  .Fechaaltafw			lxInconsapSaltafw =  .Seriealtafw			lxInconsapHoraimpo =  .Horaimpo			lxInconsapHmodifw =  .Horamodificacionfw			lxInconsapSmodifw =  .Seriemodificacionfw			lxInconsapUmodifw =  .Usuariomodificacionfw			lxInconsapVmodifw =  .Versionmodificacionfw			lxInconsapZadsfw =  .Zadsfw			lxInconsapValtafw =  .Versionaltafw			lxInconsapUaltafw =  .Usuarioaltafw			lxInconsapHoraexpo =  .Horaexpo			lxInconsapEsttrans =  .Estadotransferencia			lxInconsapBdmodifw =  .Basededatosmodificacionfw			lxInconsapHaltafw =  .Horaaltafw			lxInconsapBdaltafw =  .Basededatosaltafw			lxInconsapCoddet =  .Codigo			lxInconsapBasedatos =  .Basededatos			lxInconsapHora =  .Hora			lxInconsapFecha =  .Fecha			lxInconsapComp =  .Comprobante			lxInconsapHoracomp =  .Horacomprobante			lxInconsapFechacomp =  .Fechacomprobante			lxInconsapCoderror =  upper( .CodigoError_PK ) 			lxInconsapProblema =  .Errorinformado			lxInconsapExplica =  .Errorexplicacion			lxInconsapObs =  .Observacion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Coddet" = ] + lcValorClavePrimariaString  + [ and  INCONSAP.CODDET != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.INCONSAP set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxInconsapFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxInconsapFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxInconsapFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxInconsapFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxInconsapFaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxInconsapSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxInconsapHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxInconsapHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxInconsapSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxInconsapUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxInconsapVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxInconsapZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxInconsapValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxInconsapUaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxInconsapHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxInconsapEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxInconsapBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxInconsapHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxInconsapBdaltafw ) + "'">>, "Coddet" = <<"'" + this.FormatearTextoSql( lxInconsapCoddet ) + "'">>, "Basedatos" = <<"'" + this.FormatearTextoSql( lxInconsapBasedatos ) + "'">>, "Hora" = <<"'" + this.FormatearTextoSql( lxInconsapHora ) + "'">>, "Fecha" = <<"'" + this.ConvertirDateSql( lxInconsapFecha ) + "'">>, "Comp" = <<"'" + this.FormatearTextoSql( lxInconsapComp ) + "'">>, "Horacomp" = <<"'" + this.FormatearTextoSql( lxInconsapHoracomp ) + "'">>, "Fechacomp" = <<"'" + this.ConvertirDateSql( lxInconsapFechacomp ) + "'">>, "Coderror" = <<"'" + this.FormatearTextoSql( lxInconsapCoderror ) + "'">>, "Problema" = <<"'" + this.FormatearTextoSql( lxInconsapProblema ) + "'">>, "Explica" = <<"'" + this.FormatearTextoSql( lxInconsapExplica ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxInconsapObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'INCONSAP' 
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

			lcFiltro = ["Coddet" = ] + lcValorClavePrimariaString  + [ and  INCONSAP.CODDET != '']
		loColeccion.Agregar( 'delete from ZooLogic.INCONSAP where ' + lcFiltro )
			loColeccion.cTabla = 'INCONSAP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.INCONSAP where  INCONSAP.CODDET != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.INCONSAP where CodDet = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  INCONSAP.CODDET != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INCONSISTENCIASAP'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.INCONSAP Where CodDet = ] + "'" + this.FormatearTextoSql( &lcCursor..CodDet ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.INCONSAP set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CodDet = ] + "'" + this.FormatearTextoSql( &lcCursor..CodDet ) + "'"+ [, BaseDatos = ] + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'"+ [, Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'"+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'"+ [, HoraComp = ] + "'" + this.FormatearTextoSql( &lcCursor..HoraComp ) + "'"+ [, FechaComp = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'"+ [, CodError = ] + "'" + this.FormatearTextoSql( &lcCursor..CodError ) + "'"+ [, Problema = ] + "'" + this.FormatearTextoSql( &lcCursor..Problema ) + "'"+ [, Explica = ] + "'" + this.FormatearTextoSql( &lcCursor..Explica ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where CodDet = ] + "'" + this.FormatearTextoSql( &lcCursor..CodDet ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECEXPO, FMODIFW, FECTRANS, FALTAFW, SALTAFW, HORAIMPO, HMODIFW, SMODIFW, UMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, HORAEXPO, ESTTRANS, BDMODIFW, HALTAFW, BDALTAFW, CodDet, BaseDatos, Hora, Fecha, Comp, HoraComp, FechaComp, CodError, Problema, Explica, Obs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodDet ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BaseDatos ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Hora ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HoraComp ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodError ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Problema ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Explica ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.INCONSAP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'INCONSISTENCIASAP'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CodDet C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CodDet     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'INCONSISTENCIASAP'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INCONSISTENCIASAP_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'INCONSISTENCIASAP_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_INCONSAP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'INCONSISTENCIASAP'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CodDet
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad INCONSISTENCIASAP. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INCONSISTENCIASAP'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CodDet as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CodDet, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INCONSISTENCIASAP'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  Fecha     
		* Validar ANTERIORES A 1/1/1753  FechaComp 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_INCONSAP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_INCONSAP
Create Table ZooLogic.TablaTrabajo_INCONSAP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"coddet" char( 38 )  null, 
"basedatos" char( 8 )  null, 
"hora" char( 10 )  null, 
"fecha" datetime  null, 
"comp" char( 25 )  null, 
"horacomp" char( 10 )  null, 
"fechacomp" datetime  null, 
"coderror" char( 10 )  null, 
"problema" char( 200 )  null, 
"explica" char( 200 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_INCONSAP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_INCONSAP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'INCONSISTENCIASAP'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('coddet','coddet')
			.AgregarMapeo('basedatos','basedatos')
			.AgregarMapeo('hora','hora')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('comp','comp')
			.AgregarMapeo('horacomp','horacomp')
			.AgregarMapeo('fechacomp','fechacomp')
			.AgregarMapeo('coderror','coderror')
			.AgregarMapeo('problema','problema')
			.AgregarMapeo('explica','explica')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_INCONSAP'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODDET = isnull( d.CODDET, t.CODDET ),t.BASEDATOS = isnull( d.BASEDATOS, t.BASEDATOS ),t.HORA = isnull( d.HORA, t.HORA ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.COMP = isnull( d.COMP, t.COMP ),t.HORACOMP = isnull( d.HORACOMP, t.HORACOMP ),t.FECHACOMP = isnull( d.FECHACOMP, t.FECHACOMP ),t.CODERROR = isnull( d.CODERROR, t.CODERROR ),t.PROBLEMA = isnull( d.PROBLEMA, t.PROBLEMA ),t.EXPLICA = isnull( d.EXPLICA, t.EXPLICA ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.INCONSAP t inner join deleted d 
							 on t.CodDet = d.CodDet
				-- Fin Updates
				insert into ZooLogic.INCONSAP(Fecimpo,Fecexpo,Fmodifw,Fectrans,Faltafw,Saltafw,Horaimpo,Hmodifw,Smodifw,Umodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Horaexpo,Esttrans,Bdmodifw,Haltafw,Bdaltafw,Coddet,Basedatos,Hora,Fecha,Comp,Horacomp,Fechacomp,Coderror,Problema,Explica,Obs)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.CODDET,''),isnull( d.BASEDATOS,''),isnull( d.HORA,''),isnull( d.FECHA,''),isnull( d.COMP,''),isnull( d.HORACOMP,''),isnull( d.FECHACOMP,''),isnull( d.CODERROR,''),isnull( d.PROBLEMA,''),isnull( d.EXPLICA,''),isnull( d.OBS,'')
						From deleted d left join ZooLogic.INCONSAP pk 
							 on d.CodDet = pk.CodDet
						Where pk.CodDet Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_INCONSAP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_INCONSAP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_INCONSISTENCIASAP' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Seriealtafw = nvl( c_INCONSISTENCIASAP.Seriealtafw, [] )
					.Horaimpo = nvl( c_INCONSISTENCIASAP.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_INCONSISTENCIASAP.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_INCONSISTENCIASAP.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_INCONSISTENCIASAP.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_INCONSISTENCIASAP.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_INCONSISTENCIASAP.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_INCONSISTENCIASAP.Usuarioaltafw, [] )
					.Horaexpo = nvl( c_INCONSISTENCIASAP.Horaexpo, [] )
					.Estadotransferencia = nvl( c_INCONSISTENCIASAP.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_INCONSISTENCIASAP.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_INCONSISTENCIASAP.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_INCONSISTENCIASAP.Basededatosaltafw, [] )
					.Codigo = nvl( c_INCONSISTENCIASAP.Codigo, [] )
					.Basededatos = nvl( c_INCONSISTENCIASAP.Basededatos, [] )
					.Hora = nvl( c_INCONSISTENCIASAP.Hora, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fecha, ctod( '  /  /    ' ) ) )
					.Comprobante = nvl( c_INCONSISTENCIASAP.Comprobante, [] )
					.Horacomprobante = nvl( c_INCONSISTENCIASAP.Horacomprobante, [] )
					.Fechacomprobante = GoLibrerias.ObtenerFechaFormateada( nvl( c_INCONSISTENCIASAP.Fechacomprobante, ctod( '  /  /    ' ) ) )
					.Codigoerror_PK =  nvl( c_INCONSISTENCIASAP.Codigoerror, [] )
					.Errorinformado = nvl( c_INCONSISTENCIASAP.Errorinformado, [] )
					.Errorexplicacion = nvl( c_INCONSISTENCIASAP.Errorexplicacion, [] )
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
		return c_INCONSISTENCIASAP.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.INCONSAP' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodDet"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CodDet as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CodDet from (
							select * 
								from ZooLogic.INCONSAP 
								Where   INCONSAP.CODDET != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "INCONSAP", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodDet"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Coddet" as "Codigo", "Basedatos" as "Basededatos", "Hora" as "Hora", "Fecha" as "Fecha", "Comp" as "Comprobante", "Horacomp" as "Horacomprobante", "Fechacomp" as "Fechacomprobante", "Coderror" as "Codigoerror", "Problema" as "Errorinformado", "Explica" as "Errorexplicacion", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.INCONSAP 
								Where   INCONSAP.CODDET != ''
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
	Tabla = 'INCONSAP'
	Filtro = " INCONSAP.CODDET != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " INCONSAP.CODDET != ''"
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
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHAIMPO                               " tabla="INCONSAP       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHAEXPO                               " tabla="INCONSAP       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHAMODIFICACIONFW                     " tabla="INCONSAP       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHATRANSFERENCIA                      " tabla="INCONSAP       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHAALTAFW                             " tabla="INCONSAP       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="SERIEALTAFW                             " tabla="INCONSAP       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="HORAIMPO                                " tabla="INCONSAP       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="HORAMODIFICACIONFW                      " tabla="INCONSAP       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="SERIEMODIFICACIONFW                     " tabla="INCONSAP       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="USUARIOMODIFICACIONFW                   " tabla="INCONSAP       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="VERSIONMODIFICACIONFW                   " tabla="INCONSAP       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="ZADSFW                                  " tabla="INCONSAP       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="VERSIONALTAFW                           " tabla="INCONSAP       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="USUARIOALTAFW                           " tabla="INCONSAP       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="HORAEXPO                                " tabla="INCONSAP       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="ESTADOTRANSFERENCIA                     " tabla="INCONSAP       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="INCONSAP       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="HORAALTAFW                              " tabla="INCONSAP       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="BASEDEDATOSALTAFW                       " tabla="INCONSAP       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="CODIGO                                  " tabla="INCONSAP       " campo="CODDET    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="BASEDEDATOS                             " tabla="INCONSAP       " campo="BASEDATOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="HORA                                    " tabla="INCONSAP       " campo="HORA      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHA                                   " tabla="INCONSAP       " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="COMPROBANTE                             " tabla="INCONSAP       " campo="COMP      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="HORACOMPROBANTE                         " tabla="INCONSAP       " campo="HORACOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Hora comprobante                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="FECHACOMPROBANTE                        " tabla="INCONSAP       " campo="FECHACOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Fecha comprobante                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="CODIGOERROR                             " tabla="INCONSAP       " campo="CODERROR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ERRORSAP                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Código de error                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="ERRORINFORMADO                          " tabla="INCONSAP       " campo="PROBLEMA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Error informado por SAP                                                                                                                                         " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="CodigoError.ProblemaInformado                                                                                                                                                                                                                                 " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="ERROREXPLICACION                        " tabla="INCONSAP       " campo="EXPLICA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Explicación de error conocido                                                                                                                                   " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="CodigoError.Explicacion                                                                                                                                                                                                                                       " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INCONSISTENCIASAP                       " atributo="OBSERVACION                             " tabla="INCONSAP       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ERRORSAP                                " atributo="PROBLEMAINFORMADO                       " tabla="ERRORSAP       " campo="PROBLEMA  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="15" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ERRORSAP On INCONSAP.CODERROR = ERRORSAP.Codigo And  ERRORSAP.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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