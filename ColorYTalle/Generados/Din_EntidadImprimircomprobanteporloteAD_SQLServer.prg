
define class Din_EntidadIMPRIMIRCOMPROBANTEPORLOTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPRIMIRCOMPROBANTEPORLOTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IPLPK'
	cTablaPrincipal = 'COMPPL'
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
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxCompplFectrans, lxCompplFecimpo, lxCompplFmodifw, lxCompplFecexpo, lxCompplCodigo, lxCompplHoraimpo, lxCompplHaltafw, lxCompplHoraexpo, lxCompplSaltafw, lxCompplVmodifw, lxCompplZadsfw, lxCompplValtafw, lxCompplUmodifw, lxCompplSmodifw, lxCompplUaltafw, lxCompplHmodifw, lxCompplEsttrans, lxCompplBdmodifw, lxCompplBdaltafw, lxCompplTimestamp, lxCompplFaltafw, lxCompplTipocomp, lxCompplComprob, lxCompplLetra, lxCompplPtovta, lxCompplNumdesde, lxCompplNumhasta, lxCompplSerie, lxCompplVrsn, lxCompplDb, lxCompplUsuario, lxCompplObservacio
				lxCompplFectrans =  .Fechatransferencia			lxCompplFecimpo =  .Fechaimpo			lxCompplFmodifw =  .Fechamodificacionfw			lxCompplFecexpo =  .Fechaexpo			lxCompplCodigo =  .Codigo			lxCompplHoraimpo =  .Horaimpo			lxCompplHaltafw =  .Horaaltafw			lxCompplHoraexpo =  .Horaexpo			lxCompplSaltafw =  .Seriealtafw			lxCompplVmodifw =  .Versionmodificacionfw			lxCompplZadsfw =  .Zadsfw			lxCompplValtafw =  .Versionaltafw			lxCompplUmodifw =  .Usuariomodificacionfw			lxCompplSmodifw =  .Seriemodificacionfw			lxCompplUaltafw =  .Usuarioaltafw			lxCompplHmodifw =  .Horamodificacionfw			lxCompplEsttrans =  .Estadotransferencia			lxCompplBdmodifw =  .Basededatosmodificacionfw			lxCompplBdaltafw =  .Basededatosaltafw			lxCompplTimestamp = goLibrerias.ObtenerTimestamp()			lxCompplFaltafw =  .Fechaaltafw			lxCompplTipocomp =  .Tipocomprobante			lxCompplComprob =  .Entidad			lxCompplLetra =  .Letra			lxCompplPtovta =  .Puntodeventa			lxCompplNumdesde =  .Numerodesde			lxCompplNumhasta =  .Numerohasta			lxCompplSerie =  .Serie			lxCompplVrsn =  .Version			lxCompplDb =  .Db			lxCompplUsuario =  .Usuario			lxCompplObservacio =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompplCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPPL ( "Fectrans","Fecimpo","Fmodifw","Fecexpo","Codigo","Horaimpo","Haltafw","Horaexpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Bdaltafw","Timestamp","Faltafw","Tipocomp","Comprob","Letra","Ptovta","Numdesde","Numhasta","Serie","Vrsn","Db","Usuario","Observacio" ) values ( <<"'" + this.ConvertirDateSql( lxCompplFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompplFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompplFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompplFecexpo ) + "'" >>, <<lxCompplCodigo >>, <<"'" + this.FormatearTextoSql( lxCompplHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplBdaltafw ) + "'" >>, <<lxCompplTimestamp >>, <<"'" + this.ConvertirDateSql( lxCompplFaltafw ) + "'" >>, <<lxCompplTipocomp >>, <<"'" + this.FormatearTextoSql( lxCompplComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplLetra ) + "'" >>, <<lxCompplPtovta >>, <<lxCompplNumdesde >>, <<lxCompplNumhasta >>, <<"'" + this.FormatearTextoSql( lxCompplSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplVrsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplObservacio ) + "'" >> )
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
		this.oEntidad.Timestamp = lxCompplTimestamp
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
			local  lxCompplFectrans, lxCompplFecimpo, lxCompplFmodifw, lxCompplFecexpo, lxCompplCodigo, lxCompplHoraimpo, lxCompplHaltafw, lxCompplHoraexpo, lxCompplSaltafw, lxCompplVmodifw, lxCompplZadsfw, lxCompplValtafw, lxCompplUmodifw, lxCompplSmodifw, lxCompplUaltafw, lxCompplHmodifw, lxCompplEsttrans, lxCompplBdmodifw, lxCompplBdaltafw, lxCompplTimestamp, lxCompplFaltafw, lxCompplTipocomp, lxCompplComprob, lxCompplLetra, lxCompplPtovta, lxCompplNumdesde, lxCompplNumhasta, lxCompplSerie, lxCompplVrsn, lxCompplDb, lxCompplUsuario, lxCompplObservacio
				lxCompplFectrans =  .Fechatransferencia			lxCompplFecimpo =  .Fechaimpo			lxCompplFmodifw =  .Fechamodificacionfw			lxCompplFecexpo =  .Fechaexpo			lxCompplCodigo =  .Codigo			lxCompplHoraimpo =  .Horaimpo			lxCompplHaltafw =  .Horaaltafw			lxCompplHoraexpo =  .Horaexpo			lxCompplSaltafw =  .Seriealtafw			lxCompplVmodifw =  .Versionmodificacionfw			lxCompplZadsfw =  .Zadsfw			lxCompplValtafw =  .Versionaltafw			lxCompplUmodifw =  .Usuariomodificacionfw			lxCompplSmodifw =  .Seriemodificacionfw			lxCompplUaltafw =  .Usuarioaltafw			lxCompplHmodifw =  .Horamodificacionfw			lxCompplEsttrans =  .Estadotransferencia			lxCompplBdmodifw =  .Basededatosmodificacionfw			lxCompplBdaltafw =  .Basededatosaltafw			lxCompplTimestamp = goLibrerias.ObtenerTimestamp()			lxCompplFaltafw =  .Fechaaltafw			lxCompplTipocomp =  .Tipocomprobante			lxCompplComprob =  .Entidad			lxCompplLetra =  .Letra			lxCompplPtovta =  .Puntodeventa			lxCompplNumdesde =  .Numerodesde			lxCompplNumhasta =  .Numerohasta			lxCompplSerie =  .Serie			lxCompplVrsn =  .Version			lxCompplDb =  .Db			lxCompplUsuario =  .Usuario			lxCompplObservacio =  .Obs
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
				update ZooLogic.COMPPL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompplFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompplFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompplFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompplFecexpo ) + "'">>,"Codigo" = <<lxCompplCodigo>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompplHoraimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompplHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompplHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompplSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompplVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompplZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompplValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompplUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompplSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompplUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompplHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompplEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompplBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompplBdaltafw ) + "'">>,"Timestamp" = <<lxCompplTimestamp>>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCompplFaltafw ) + "'">>,"Tipocomp" = <<lxCompplTipocomp>>,"Comprob" = <<"'" + this.FormatearTextoSql( lxCompplComprob ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxCompplLetra ) + "'">>,"Ptovta" = <<lxCompplPtovta>>,"Numdesde" = <<lxCompplNumdesde>>,"Numhasta" = <<lxCompplNumhasta>>,"Serie" = <<"'" + this.FormatearTextoSql( lxCompplSerie ) + "'">>,"Vrsn" = <<"'" + this.FormatearTextoSql( lxCompplVrsn ) + "'">>,"Db" = <<"'" + this.FormatearTextoSql( lxCompplDb ) + "'">>,"Usuario" = <<"'" + this.FormatearTextoSql( lxCompplUsuario ) + "'">>,"Observacio" = <<"'" + this.FormatearTextoSql( lxCompplObservacio ) + "'">> where "Codigo" = <<lxCompplCodigo>> and  COMPPL.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCompplTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPPL where " + this.ConvertirFuncionesSql( " COMPPL.CODIGO != 0" ) )
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
			Local lxCompplCodigo
			lxCompplCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs" from ZooLogic.COMPPL where "Codigo" = <<lxCompplCodigo>> and  COMPPL.CODIGO != 0
			endtext
			use in select('c_IMPRIMIRCOMPROBANTEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPRIMIRCOMPROBANTEPORLOTE', set( 'Datasession' ) )

			if reccount( 'c_IMPRIMIRCOMPROBANTEPORLOTE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompplCodigo as Variant
		llRetorno = .t.
		lxCompplCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPPL where "Codigo" = <<lxCompplCodigo>> and  COMPPL.CODIGO != 0
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs" from ZooLogic.COMPPL where  COMPPL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_IMPRIMIRCOMPROBANTEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPRIMIRCOMPROBANTEPORLOTE', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs" from ZooLogic.COMPPL where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPPL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_IMPRIMIRCOMPROBANTEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPRIMIRCOMPROBANTEPORLOTE', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs" from ZooLogic.COMPPL where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPPL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_IMPRIMIRCOMPROBANTEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPRIMIRCOMPROBANTEPORLOTE', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs" from ZooLogic.COMPPL where  COMPPL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_IMPRIMIRCOMPROBANTEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPRIMIRCOMPROBANTEPORLOTE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecimpo,Fmodifw,Fecexpo,Codigo,Horaimpo,Haltafw,Horaexpo,Saltafw,Vmodifw,Zadsfw,Val" + ;
"tafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Bdaltafw,Timestamp,Faltafw,Tipocomp,Comprob,L" + ;
"etra,Ptovta,Numdesde,Numhasta,Serie,Vrsn,Db,Usuario,Observacio" + ;
" from ZooLogic.COMPPL where  COMPPL.CODIGO != 0 and " + lcFiltro )
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
			local  lxCompplFectrans, lxCompplFecimpo, lxCompplFmodifw, lxCompplFecexpo, lxCompplCodigo, lxCompplHoraimpo, lxCompplHaltafw, lxCompplHoraexpo, lxCompplSaltafw, lxCompplVmodifw, lxCompplZadsfw, lxCompplValtafw, lxCompplUmodifw, lxCompplSmodifw, lxCompplUaltafw, lxCompplHmodifw, lxCompplEsttrans, lxCompplBdmodifw, lxCompplBdaltafw, lxCompplTimestamp, lxCompplFaltafw, lxCompplTipocomp, lxCompplComprob, lxCompplLetra, lxCompplPtovta, lxCompplNumdesde, lxCompplNumhasta, lxCompplSerie, lxCompplVrsn, lxCompplDb, lxCompplUsuario, lxCompplObservacio
				lxCompplFectrans = ctod( '  /  /    ' )			lxCompplFecimpo = ctod( '  /  /    ' )			lxCompplFmodifw = ctod( '  /  /    ' )			lxCompplFecexpo = ctod( '  /  /    ' )			lxCompplCodigo = 0			lxCompplHoraimpo = []			lxCompplHaltafw = []			lxCompplHoraexpo = []			lxCompplSaltafw = []			lxCompplVmodifw = []			lxCompplZadsfw = []			lxCompplValtafw = []			lxCompplUmodifw = []			lxCompplSmodifw = []			lxCompplUaltafw = []			lxCompplHmodifw = []			lxCompplEsttrans = []			lxCompplBdmodifw = []			lxCompplBdaltafw = []			lxCompplTimestamp = goLibrerias.ObtenerTimestamp()			lxCompplFaltafw = ctod( '  /  /    ' )			lxCompplTipocomp = 0			lxCompplComprob = []			lxCompplLetra = []			lxCompplPtovta = 0			lxCompplNumdesde = 0			lxCompplNumhasta = 0			lxCompplSerie = []			lxCompplVrsn = []			lxCompplDb = []			lxCompplUsuario = []			lxCompplObservacio = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPPL where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPPL' + '_' + tcCampo
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
		lcWhere = " Where  COMPPL.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPPL', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROB AS ENTIDAD'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMDESDE AS NUMERODESDE'
				Case lcAtributo == 'NUMEROHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMHASTA AS NUMEROHASTA'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SERIE AS SERIE'
				Case lcAtributo == 'VERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VRSN AS VERSION'
				Case lcAtributo == 'DB'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DB AS DB'
				Case lcAtributo == 'USUARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USUARIO AS USUARIO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBSERVACIO AS OBS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'COMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODESDE'
				lcCampo = 'NUMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROHASTA'
				lcCampo = 'NUMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'VERSION'
				lcCampo = 'VRSN'
			Case upper( alltrim( tcAtributo ) ) == 'DB'
				lcCampo = 'DB'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIO'
				lcCampo = 'USUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBSERVACIO'
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
			local  lxCompplFectrans, lxCompplFecimpo, lxCompplFmodifw, lxCompplFecexpo, lxCompplCodigo, lxCompplHoraimpo, lxCompplHaltafw, lxCompplHoraexpo, lxCompplSaltafw, lxCompplVmodifw, lxCompplZadsfw, lxCompplValtafw, lxCompplUmodifw, lxCompplSmodifw, lxCompplUaltafw, lxCompplHmodifw, lxCompplEsttrans, lxCompplBdmodifw, lxCompplBdaltafw, lxCompplTimestamp, lxCompplFaltafw, lxCompplTipocomp, lxCompplComprob, lxCompplLetra, lxCompplPtovta, lxCompplNumdesde, lxCompplNumhasta, lxCompplSerie, lxCompplVrsn, lxCompplDb, lxCompplUsuario, lxCompplObservacio
				lxCompplFectrans =  .Fechatransferencia			lxCompplFecimpo =  .Fechaimpo			lxCompplFmodifw =  .Fechamodificacionfw			lxCompplFecexpo =  .Fechaexpo			lxCompplCodigo =  .Codigo			lxCompplHoraimpo =  .Horaimpo			lxCompplHaltafw =  .Horaaltafw			lxCompplHoraexpo =  .Horaexpo			lxCompplSaltafw =  .Seriealtafw			lxCompplVmodifw =  .Versionmodificacionfw			lxCompplZadsfw =  .Zadsfw			lxCompplValtafw =  .Versionaltafw			lxCompplUmodifw =  .Usuariomodificacionfw			lxCompplSmodifw =  .Seriemodificacionfw			lxCompplUaltafw =  .Usuarioaltafw			lxCompplHmodifw =  .Horamodificacionfw			lxCompplEsttrans =  .Estadotransferencia			lxCompplBdmodifw =  .Basededatosmodificacionfw			lxCompplBdaltafw =  .Basededatosaltafw			lxCompplTimestamp = goLibrerias.ObtenerTimestamp()			lxCompplFaltafw =  .Fechaaltafw			lxCompplTipocomp =  .Tipocomprobante			lxCompplComprob =  .Entidad			lxCompplLetra =  .Letra			lxCompplPtovta =  .Puntodeventa			lxCompplNumdesde =  .Numerodesde			lxCompplNumhasta =  .Numerohasta			lxCompplSerie =  .Serie			lxCompplVrsn =  .Version			lxCompplDb =  .Db			lxCompplUsuario =  .Usuario			lxCompplObservacio =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPPL ( "Fectrans","Fecimpo","Fmodifw","Fecexpo","Codigo","Horaimpo","Haltafw","Horaexpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Bdaltafw","Timestamp","Faltafw","Tipocomp","Comprob","Letra","Ptovta","Numdesde","Numhasta","Serie","Vrsn","Db","Usuario","Observacio" ) values ( <<"'" + this.ConvertirDateSql( lxCompplFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompplFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompplFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompplFecexpo ) + "'" >>, <<lxCompplCodigo >>, <<"'" + this.FormatearTextoSql( lxCompplHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplBdaltafw ) + "'" >>, <<lxCompplTimestamp >>, <<"'" + this.ConvertirDateSql( lxCompplFaltafw ) + "'" >>, <<lxCompplTipocomp >>, <<"'" + this.FormatearTextoSql( lxCompplComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplLetra ) + "'" >>, <<lxCompplPtovta >>, <<lxCompplNumdesde >>, <<lxCompplNumhasta >>, <<"'" + this.FormatearTextoSql( lxCompplSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplVrsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompplObservacio ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPPL' 
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
			local  lxCompplFectrans, lxCompplFecimpo, lxCompplFmodifw, lxCompplFecexpo, lxCompplCodigo, lxCompplHoraimpo, lxCompplHaltafw, lxCompplHoraexpo, lxCompplSaltafw, lxCompplVmodifw, lxCompplZadsfw, lxCompplValtafw, lxCompplUmodifw, lxCompplSmodifw, lxCompplUaltafw, lxCompplHmodifw, lxCompplEsttrans, lxCompplBdmodifw, lxCompplBdaltafw, lxCompplTimestamp, lxCompplFaltafw, lxCompplTipocomp, lxCompplComprob, lxCompplLetra, lxCompplPtovta, lxCompplNumdesde, lxCompplNumhasta, lxCompplSerie, lxCompplVrsn, lxCompplDb, lxCompplUsuario, lxCompplObservacio
				lxCompplFectrans =  .Fechatransferencia			lxCompplFecimpo =  .Fechaimpo			lxCompplFmodifw =  .Fechamodificacionfw			lxCompplFecexpo =  .Fechaexpo			lxCompplCodigo =  .Codigo			lxCompplHoraimpo =  .Horaimpo			lxCompplHaltafw =  .Horaaltafw			lxCompplHoraexpo =  .Horaexpo			lxCompplSaltafw =  .Seriealtafw			lxCompplVmodifw =  .Versionmodificacionfw			lxCompplZadsfw =  .Zadsfw			lxCompplValtafw =  .Versionaltafw			lxCompplUmodifw =  .Usuariomodificacionfw			lxCompplSmodifw =  .Seriemodificacionfw			lxCompplUaltafw =  .Usuarioaltafw			lxCompplHmodifw =  .Horamodificacionfw			lxCompplEsttrans =  .Estadotransferencia			lxCompplBdmodifw =  .Basededatosmodificacionfw			lxCompplBdaltafw =  .Basededatosaltafw			lxCompplTimestamp = goLibrerias.ObtenerTimestamp()			lxCompplFaltafw =  .Fechaaltafw			lxCompplTipocomp =  .Tipocomprobante			lxCompplComprob =  .Entidad			lxCompplLetra =  .Letra			lxCompplPtovta =  .Puntodeventa			lxCompplNumdesde =  .Numerodesde			lxCompplNumhasta =  .Numerohasta			lxCompplSerie =  .Serie			lxCompplVrsn =  .Version			lxCompplDb =  .Db			lxCompplUsuario =  .Usuario			lxCompplObservacio =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPPL.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPPL set "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompplFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompplFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompplFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompplFecexpo ) + "'">>, "Codigo" = <<lxCompplCodigo>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompplHoraimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompplHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompplHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompplSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompplVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompplZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompplValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompplUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompplSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompplUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompplHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompplEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompplBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompplBdaltafw ) + "'">>, "Timestamp" = <<lxCompplTimestamp>>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompplFaltafw ) + "'">>, "Tipocomp" = <<lxCompplTipocomp>>, "Comprob" = <<"'" + this.FormatearTextoSql( lxCompplComprob ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxCompplLetra ) + "'">>, "Ptovta" = <<lxCompplPtovta>>, "Numdesde" = <<lxCompplNumdesde>>, "Numhasta" = <<lxCompplNumhasta>>, "Serie" = <<"'" + this.FormatearTextoSql( lxCompplSerie ) + "'">>, "Vrsn" = <<"'" + this.FormatearTextoSql( lxCompplVrsn ) + "'">>, "Db" = <<"'" + this.FormatearTextoSql( lxCompplDb ) + "'">>, "Usuario" = <<"'" + this.FormatearTextoSql( lxCompplUsuario ) + "'">>, "Observacio" = <<"'" + this.FormatearTextoSql( lxCompplObservacio ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPPL' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPPL.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.COMPPL where ' + lcFiltro )
			loColeccion.cTabla = 'COMPPL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPPL where  COMPPL.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPPL where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  COMPPL.CODIGO != 0" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPRIMIRCOMPROBANTEPORLOTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPPL Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPPL set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, TipoComp = ] + transform( &lcCursor..TipoComp )+ [, Comprob = ] + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, ptovta = ] + transform( &lcCursor..ptovta )+ [, NumDesde = ] + transform( &lcCursor..NumDesde )+ [, NumHasta = ] + transform( &lcCursor..NumHasta )+ [, serie = ] + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'"+ [, vrsn = ] + "'" + this.FormatearTextoSql( &lcCursor..vrsn ) + "'"+ [, db = ] + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'"+ [, usuario = ] + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"+ [, Observacio = ] + "'" + this.FormatearTextoSql( &lcCursor..Observacio ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FECIMPO, FMODIFW, FECEXPO, CODIGO, HORAIMPO, HALTAFW, HORAEXPO, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HMODIFW, ESTTRANS, BDMODIFW, BDALTAFW, TIMESTAMP, FAltaFW, TipoComp, Comprob, Letra, ptovta, NumDesde, NumHasta, serie, vrsn, db, usuario, Observacio
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TipoComp ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..ptovta ) + ',' + transform( &lcCursor..NumDesde ) + ',' + transform( &lcCursor..NumHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..vrsn ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Observacio ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPPL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPRIMIRCOMPROBANTEPORLOTE'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'IMPRIMIRCOMPROBANTEPORLOTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPRIMIRCOMPROBANTEPORLOTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPRIMIRCOMPROBANTEPORLOTE_OBSERVACIO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMPPL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPRIMIRCOMPROBANTEPORLOTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPRIMIRCOMPROBANTEPORLOTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPRIMIRCOMPROBANTEPORLOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPRIMIRCOMPROBANTEPORLOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPPL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPPL
Create Table ZooLogic.TablaTrabajo_COMPPL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"horaimpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"faltafw" datetime  null, 
"tipocomp" numeric( 2, 0 )  null, 
"comprob" char( 40 )  null, 
"letra" char( 1 )  null, 
"ptovta" numeric( 4, 0 )  null, 
"numdesde" numeric( 9, 0 )  null, 
"numhasta" numeric( 9, 0 )  null, 
"serie" char( 20 )  null, 
"vrsn" char( 20 )  null, 
"db" char( 20 )  null, 
"usuario" char( 100 )  null, 
"observacio" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMPPL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMPPL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPRIMIRCOMPROBANTEPORLOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('tipocomp','tipocomp')
			.AgregarMapeo('comprob','comprob')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('numdesde','numdesde')
			.AgregarMapeo('numhasta','numhasta')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('vrsn','vrsn')
			.AgregarMapeo('db','db')
			.AgregarMapeo('usuario','usuario')
			.AgregarMapeo('observacio','observacio')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMPPL'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),t.COMPROB = isnull( d.COMPROB, t.COMPROB ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUMDESDE = isnull( d.NUMDESDE, t.NUMDESDE ),t.NUMHASTA = isnull( d.NUMHASTA, t.NUMHASTA ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.VRSN = isnull( d.VRSN, t.VRSN ),t.DB = isnull( d.DB, t.DB ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.OBSERVACIO = isnull( d.OBSERVACIO, t.OBSERVACIO )
					from ZooLogic.COMPPL t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.COMPPL(Fectrans,Fecimpo,Fmodifw,Fecexpo,Codigo,Horaimpo,Haltafw,Horaexpo,Saltafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Bdaltafw,Timestamp,Faltafw,Tipocomp,Comprob,Letra,Ptovta,Numdesde,Numhasta,Serie,Vrsn,Db,Usuario,Observacio)
					Select isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.CODIGO,0),isnull( d.HORAIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.TIMESTAMP,0),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.TIPOCOMP,0),isnull( d.COMPROB,''),isnull( d.LETRA,''),isnull( d.PTOVTA,0),isnull( d.NUMDESDE,0),isnull( d.NUMHASTA,0),isnull( d.SERIE,''),isnull( d.VRSN,''),isnull( d.DB,''),isnull( d.USUARIO,''),isnull( d.OBSERVACIO,'')
						From deleted d left join ZooLogic.COMPPL pk 
							 on d.CODIGO = pk.CODIGO
						Where pk.CODIGO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPPL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPPL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPRIMIRCOMPROBANTEPORLOTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Codigo, 0 )
					.Horaimpo = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Horaimpo, [] )
					.Horaaltafw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Horaaltafw, [] )
					.Horaexpo = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Horaexpo, [] )
					.Seriealtafw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Basededatosaltafw, [] )
					.Timestamp = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Timestamp, 0 )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Tipocomprobante = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Tipocomprobante, 0 )
					.Entidad = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Entidad, [] )
					.Letra = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Letra, [] )
					.Puntodeventa = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Puntodeventa, 0 )
					.Numerodesde = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Numerodesde, 0 )
					.Numerohasta = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Numerohasta, 0 )
					.Serie = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Serie, [] )
					.Version = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Version, [] )
					.Db = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Db, [] )
					.Usuario = nvl( c_IMPRIMIRCOMPROBANTEPORLOTE.Usuario, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
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
		return c_IMPRIMIRCOMPROBANTEPORLOTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPPL' )
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
								from ZooLogic.COMPPL 
								Where   COMPPL.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPPL", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Timestamp" as "Timestamp", "Faltafw" as "Fechaaltafw", "Tipocomp" as "Tipocomprobante", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Observacio" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPPL 
								Where   COMPPL.CODIGO != 0
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
	Tabla = 'COMPPL'
	Filtro = " COMPPL.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPPL.CODIGO != 0"
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
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="FECHATRANSFERENCIA                      " tabla="COMPPL         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="FECHAIMPO                               " tabla="COMPPL         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="FECHAMODIFICACIONFW                     " tabla="COMPPL         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="FECHAEXPO                               " tabla="COMPPL         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="CODIGO                                  " tabla="COMPPL         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="HORAIMPO                                " tabla="COMPPL         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="HORAALTAFW                              " tabla="COMPPL         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="HORAEXPO                                " tabla="COMPPL         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="SERIEALTAFW                             " tabla="COMPPL         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPPL         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="ZADSFW                                  " tabla="COMPPL         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="VERSIONALTAFW                           " tabla="COMPPL         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPPL         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="SERIEMODIFICACIONFW                     " tabla="COMPPL         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="USUARIOALTAFW                           " tabla="COMPPL         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="HORAMODIFICACIONFW                      " tabla="COMPPL         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPPL         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPPL         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="BASEDEDATOSALTAFW                       " tabla="COMPPL         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="TIMESTAMP                               " tabla="COMPPL         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="FECHAALTAFW                             " tabla="COMPPL         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="2" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="TIPOCOMPROBANTE                         " tabla="COMPPL         " campo="TIPOCOMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=01                                                                                                                                                                                                                                                           " obligatorio="true" admitebusqueda="3" etiqueta="Comprobante                                                                                                                                                     " dominio="TIPOCOMPROBANTEVENTASFISCAL   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="ENTIDAD                                 " tabla="COMPPL         " campo="COMPROB   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Comprobante electrónico                                                                                                                                         " dominio="TIPOCOMPROBANTEVENTASFISCAL   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="LETRA                                   " tabla="COMPPL         " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;A&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="4" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="PUNTODEVENTA                            " tabla="COMPPL         " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.Felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="true" admitebusqueda="5" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="NUMERODESDE                             " tabla="COMPPL         " campo="NUMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número desde                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="NUMEROHASTA                             " tabla="COMPPL         " campo="NUMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="=this.ValorSugeridoNumerohastaEntidad()                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="7" etiqueta="Número hasta                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="SERIE                                   " tabla="COMPPL         " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="200" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="VERSION                                 " tabla="COMPPL         " campo="VRSN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.ObtenerVersion()                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="201" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="DB                                      " tabla="COMPPL         " campo="DB        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Sucursal                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="USUARIO                                 " tabla="COMPPL         " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="203" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPRIMIRCOMPROBANTEPORLOTE              " atributo="OBS                                     " tabla="COMPPL         " campo="OBSERVACIO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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