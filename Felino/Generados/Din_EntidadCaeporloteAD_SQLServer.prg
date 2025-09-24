
define class Din_EntidadCAEPORLOTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CAEPORLOTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_OFAPK'
	cTablaPrincipal = 'CAEPL'
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
			local  lxCaeplFecexpo, lxCaeplFectrans, lxCaeplFecimpo, lxCaeplFmodifw, lxCaeplCodigo, lxCaeplTimestamp, lxCaeplHoraexpo, lxCaeplHaltafw, lxCaeplHoraimpo, lxCaeplSmodifw, lxCaeplVmodifw, lxCaeplZadsfw, lxCaeplValtafw, lxCaeplUmodifw, lxCaeplSaltafw, lxCaeplUaltafw, lxCaeplHmodifw, lxCaeplEsttrans, lxCaeplBdmodifw, lxCaeplBdaltafw, lxCaeplFaltafw, lxCaeplComprob, lxCaeplLetra, lxCaeplPtovta, lxCaeplNumdesde, lxCaeplNumhasta, lxCaeplSerie, lxCaeplVrsn, lxCaeplDb, lxCaeplUsuario, lxCaeplMobs, lxCaeplDetalle
				lxCaeplFecexpo =  .Fechaexpo			lxCaeplFectrans =  .Fechatransferencia			lxCaeplFecimpo =  .Fechaimpo			lxCaeplFmodifw =  .Fechamodificacionfw			lxCaeplCodigo =  .Codigo			lxCaeplTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeplHoraexpo =  .Horaexpo			lxCaeplHaltafw =  .Horaaltafw			lxCaeplHoraimpo =  .Horaimpo			lxCaeplSmodifw =  .Seriemodificacionfw			lxCaeplVmodifw =  .Versionmodificacionfw			lxCaeplZadsfw =  .Zadsfw			lxCaeplValtafw =  .Versionaltafw			lxCaeplUmodifw =  .Usuariomodificacionfw			lxCaeplSaltafw =  .Seriealtafw			lxCaeplUaltafw =  .Usuarioaltafw			lxCaeplHmodifw =  .Horamodificacionfw			lxCaeplEsttrans =  .Estadotransferencia			lxCaeplBdmodifw =  .Basededatosmodificacionfw			lxCaeplBdaltafw =  .Basededatosaltafw			lxCaeplFaltafw =  .Fechaaltafw			lxCaeplComprob =  .Entidad			lxCaeplLetra =  .Letra			lxCaeplPtovta =  .Puntodeventa			lxCaeplNumdesde =  .Numerodesde			lxCaeplNumhasta =  .Numerohasta			lxCaeplSerie =  .Serie			lxCaeplVrsn =  .Version			lxCaeplDb =  .Db			lxCaeplUsuario =  .Usuario			lxCaeplMobs =  .Obs			lxCaeplDetalle =  .Detalle
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCaeplCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CAEPL ( "Fecexpo","Fectrans","Fecimpo","Fmodifw","Codigo","Timestamp","Horaexpo","Haltafw","Horaimpo","Smodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Bdaltafw","Faltafw","Comprob","Letra","Ptovta","Numdesde","Numhasta","Serie","Vrsn","Db","Usuario","Mobs","Detalle" ) values ( <<"'" + this.ConvertirDateSql( lxCaeplFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFmodifw ) + "'" >>, <<lxCaeplCodigo >>, <<lxCaeplTimestamp >>, <<"'" + this.FormatearTextoSql( lxCaeplHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplBdaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplLetra ) + "'" >>, <<lxCaeplPtovta >>, <<lxCaeplNumdesde >>, <<lxCaeplNumhasta >>, <<"'" + this.FormatearTextoSql( lxCaeplSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplVrsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplDetalle ) + "'" >> )
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
		this.oEntidad.Timestamp = lxCaeplTimestamp
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
			local  lxCaeplFecexpo, lxCaeplFectrans, lxCaeplFecimpo, lxCaeplFmodifw, lxCaeplCodigo, lxCaeplTimestamp, lxCaeplHoraexpo, lxCaeplHaltafw, lxCaeplHoraimpo, lxCaeplSmodifw, lxCaeplVmodifw, lxCaeplZadsfw, lxCaeplValtafw, lxCaeplUmodifw, lxCaeplSaltafw, lxCaeplUaltafw, lxCaeplHmodifw, lxCaeplEsttrans, lxCaeplBdmodifw, lxCaeplBdaltafw, lxCaeplFaltafw, lxCaeplComprob, lxCaeplLetra, lxCaeplPtovta, lxCaeplNumdesde, lxCaeplNumhasta, lxCaeplSerie, lxCaeplVrsn, lxCaeplDb, lxCaeplUsuario, lxCaeplMobs, lxCaeplDetalle
				lxCaeplFecexpo =  .Fechaexpo			lxCaeplFectrans =  .Fechatransferencia			lxCaeplFecimpo =  .Fechaimpo			lxCaeplFmodifw =  .Fechamodificacionfw			lxCaeplCodigo =  .Codigo			lxCaeplTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeplHoraexpo =  .Horaexpo			lxCaeplHaltafw =  .Horaaltafw			lxCaeplHoraimpo =  .Horaimpo			lxCaeplSmodifw =  .Seriemodificacionfw			lxCaeplVmodifw =  .Versionmodificacionfw			lxCaeplZadsfw =  .Zadsfw			lxCaeplValtafw =  .Versionaltafw			lxCaeplUmodifw =  .Usuariomodificacionfw			lxCaeplSaltafw =  .Seriealtafw			lxCaeplUaltafw =  .Usuarioaltafw			lxCaeplHmodifw =  .Horamodificacionfw			lxCaeplEsttrans =  .Estadotransferencia			lxCaeplBdmodifw =  .Basededatosmodificacionfw			lxCaeplBdaltafw =  .Basededatosaltafw			lxCaeplFaltafw =  .Fechaaltafw			lxCaeplComprob =  .Entidad			lxCaeplLetra =  .Letra			lxCaeplPtovta =  .Puntodeventa			lxCaeplNumdesde =  .Numerodesde			lxCaeplNumhasta =  .Numerohasta			lxCaeplSerie =  .Serie			lxCaeplVrsn =  .Version			lxCaeplDb =  .Db			lxCaeplUsuario =  .Usuario			lxCaeplMobs =  .Obs			lxCaeplDetalle =  .Detalle
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
				update ZooLogic.CAEPL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCaeplFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCaeplFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCaeplFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCaeplFmodifw ) + "'">>,"Codigo" = <<lxCaeplCodigo>>,"Timestamp" = <<lxCaeplTimestamp>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCaeplHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCaeplHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCaeplHoraimpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCaeplSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCaeplVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCaeplZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCaeplValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCaeplUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCaeplSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCaeplUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCaeplHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCaeplEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCaeplBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCaeplBdaltafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCaeplFaltafw ) + "'">>,"Comprob" = <<"'" + this.FormatearTextoSql( lxCaeplComprob ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxCaeplLetra ) + "'">>,"Ptovta" = <<lxCaeplPtovta>>,"Numdesde" = <<lxCaeplNumdesde>>,"Numhasta" = <<lxCaeplNumhasta>>,"Serie" = <<"'" + this.FormatearTextoSql( lxCaeplSerie ) + "'">>,"Vrsn" = <<"'" + this.FormatearTextoSql( lxCaeplVrsn ) + "'">>,"Db" = <<"'" + this.FormatearTextoSql( lxCaeplDb ) + "'">>,"Usuario" = <<"'" + this.FormatearTextoSql( lxCaeplUsuario ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxCaeplMobs ) + "'">>,"Detalle" = <<"'" + this.FormatearTextoSql( lxCaeplDetalle ) + "'">> where "Codigo" = <<lxCaeplCodigo>> and  CAEPL.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxCaeplTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.CAEPL where " + this.ConvertirFuncionesSql( " CAEPL.CODIGO != 0" ) )
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
			Local lxCaeplCodigo
			lxCaeplCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle" from ZooLogic.CAEPL where "Codigo" = <<lxCaeplCodigo>> and  CAEPL.CODIGO != 0
			endtext
			use in select('c_CAEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEPORLOTE', set( 'Datasession' ) )

			if reccount( 'c_CAEPORLOTE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCaeplCodigo as Variant
		llRetorno = .t.
		lxCaeplCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CAEPL where "Codigo" = <<lxCaeplCodigo>> and  CAEPL.CODIGO != 0
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle" from ZooLogic.CAEPL where  CAEPL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_CAEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEPORLOTE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle" from ZooLogic.CAEPL where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAEPL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_CAEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEPORLOTE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle" from ZooLogic.CAEPL where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CAEPL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_CAEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEPORLOTE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle" from ZooLogic.CAEPL where  CAEPL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_CAEPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CAEPORLOTE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Fmodifw,Codigo,Timestamp,Horaexpo,Haltafw,Horaimpo,Smodifw,Vmodifw," + ;
"Zadsfw,Valtafw,Umodifw,Saltafw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Bdaltafw,Faltafw,Comprob,Letra,Ptov" + ;
"ta,Numdesde,Numhasta,Serie,Vrsn,Db,Usuario,Mobs,Detalle" + ;
" from ZooLogic.CAEPL where  CAEPL.CODIGO != 0 and " + lcFiltro )
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
			local  lxCaeplFecexpo, lxCaeplFectrans, lxCaeplFecimpo, lxCaeplFmodifw, lxCaeplCodigo, lxCaeplTimestamp, lxCaeplHoraexpo, lxCaeplHaltafw, lxCaeplHoraimpo, lxCaeplSmodifw, lxCaeplVmodifw, lxCaeplZadsfw, lxCaeplValtafw, lxCaeplUmodifw, lxCaeplSaltafw, lxCaeplUaltafw, lxCaeplHmodifw, lxCaeplEsttrans, lxCaeplBdmodifw, lxCaeplBdaltafw, lxCaeplFaltafw, lxCaeplComprob, lxCaeplLetra, lxCaeplPtovta, lxCaeplNumdesde, lxCaeplNumhasta, lxCaeplSerie, lxCaeplVrsn, lxCaeplDb, lxCaeplUsuario, lxCaeplMobs, lxCaeplDetalle
				lxCaeplFecexpo = ctod( '  /  /    ' )			lxCaeplFectrans = ctod( '  /  /    ' )			lxCaeplFecimpo = ctod( '  /  /    ' )			lxCaeplFmodifw = ctod( '  /  /    ' )			lxCaeplCodigo = 0			lxCaeplTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeplHoraexpo = []			lxCaeplHaltafw = []			lxCaeplHoraimpo = []			lxCaeplSmodifw = []			lxCaeplVmodifw = []			lxCaeplZadsfw = []			lxCaeplValtafw = []			lxCaeplUmodifw = []			lxCaeplSaltafw = []			lxCaeplUaltafw = []			lxCaeplHmodifw = []			lxCaeplEsttrans = []			lxCaeplBdmodifw = []			lxCaeplBdaltafw = []			lxCaeplFaltafw = ctod( '  /  /    ' )			lxCaeplComprob = []			lxCaeplLetra = []			lxCaeplPtovta = 0			lxCaeplNumdesde = 0			lxCaeplNumhasta = 0			lxCaeplSerie = []			lxCaeplVrsn = []			lxCaeplDb = []			lxCaeplUsuario = []			lxCaeplMobs = []			lxCaeplDetalle = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CAEPL where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CAEPL' + '_' + tcCampo
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
		lcWhere = " Where  CAEPL.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CAEPL', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBS'
				Case lcAtributo == 'DETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DETALLE AS DETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
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
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'DETALLE'
				lcCampo = 'DETALLE'
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
			local  lxCaeplFecexpo, lxCaeplFectrans, lxCaeplFecimpo, lxCaeplFmodifw, lxCaeplCodigo, lxCaeplTimestamp, lxCaeplHoraexpo, lxCaeplHaltafw, lxCaeplHoraimpo, lxCaeplSmodifw, lxCaeplVmodifw, lxCaeplZadsfw, lxCaeplValtafw, lxCaeplUmodifw, lxCaeplSaltafw, lxCaeplUaltafw, lxCaeplHmodifw, lxCaeplEsttrans, lxCaeplBdmodifw, lxCaeplBdaltafw, lxCaeplFaltafw, lxCaeplComprob, lxCaeplLetra, lxCaeplPtovta, lxCaeplNumdesde, lxCaeplNumhasta, lxCaeplSerie, lxCaeplVrsn, lxCaeplDb, lxCaeplUsuario, lxCaeplMobs, lxCaeplDetalle
				lxCaeplFecexpo =  .Fechaexpo			lxCaeplFectrans =  .Fechatransferencia			lxCaeplFecimpo =  .Fechaimpo			lxCaeplFmodifw =  .Fechamodificacionfw			lxCaeplCodigo =  .Codigo			lxCaeplTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeplHoraexpo =  .Horaexpo			lxCaeplHaltafw =  .Horaaltafw			lxCaeplHoraimpo =  .Horaimpo			lxCaeplSmodifw =  .Seriemodificacionfw			lxCaeplVmodifw =  .Versionmodificacionfw			lxCaeplZadsfw =  .Zadsfw			lxCaeplValtafw =  .Versionaltafw			lxCaeplUmodifw =  .Usuariomodificacionfw			lxCaeplSaltafw =  .Seriealtafw			lxCaeplUaltafw =  .Usuarioaltafw			lxCaeplHmodifw =  .Horamodificacionfw			lxCaeplEsttrans =  .Estadotransferencia			lxCaeplBdmodifw =  .Basededatosmodificacionfw			lxCaeplBdaltafw =  .Basededatosaltafw			lxCaeplFaltafw =  .Fechaaltafw			lxCaeplComprob =  .Entidad			lxCaeplLetra =  .Letra			lxCaeplPtovta =  .Puntodeventa			lxCaeplNumdesde =  .Numerodesde			lxCaeplNumhasta =  .Numerohasta			lxCaeplSerie =  .Serie			lxCaeplVrsn =  .Version			lxCaeplDb =  .Db			lxCaeplUsuario =  .Usuario			lxCaeplMobs =  .Obs			lxCaeplDetalle =  .Detalle
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CAEPL ( "Fecexpo","Fectrans","Fecimpo","Fmodifw","Codigo","Timestamp","Horaexpo","Haltafw","Horaimpo","Smodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Saltafw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Bdaltafw","Faltafw","Comprob","Letra","Ptovta","Numdesde","Numhasta","Serie","Vrsn","Db","Usuario","Mobs","Detalle" ) values ( <<"'" + this.ConvertirDateSql( lxCaeplFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFmodifw ) + "'" >>, <<lxCaeplCodigo >>, <<lxCaeplTimestamp >>, <<"'" + this.FormatearTextoSql( lxCaeplHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplBdaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCaeplFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplLetra ) + "'" >>, <<lxCaeplPtovta >>, <<lxCaeplNumdesde >>, <<lxCaeplNumhasta >>, <<"'" + this.FormatearTextoSql( lxCaeplSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplVrsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplMobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCaeplDetalle ) + "'" >> )
		endtext
		loColeccion.cTabla = 'CAEPL' 
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
			local  lxCaeplFecexpo, lxCaeplFectrans, lxCaeplFecimpo, lxCaeplFmodifw, lxCaeplCodigo, lxCaeplTimestamp, lxCaeplHoraexpo, lxCaeplHaltafw, lxCaeplHoraimpo, lxCaeplSmodifw, lxCaeplVmodifw, lxCaeplZadsfw, lxCaeplValtafw, lxCaeplUmodifw, lxCaeplSaltafw, lxCaeplUaltafw, lxCaeplHmodifw, lxCaeplEsttrans, lxCaeplBdmodifw, lxCaeplBdaltafw, lxCaeplFaltafw, lxCaeplComprob, lxCaeplLetra, lxCaeplPtovta, lxCaeplNumdesde, lxCaeplNumhasta, lxCaeplSerie, lxCaeplVrsn, lxCaeplDb, lxCaeplUsuario, lxCaeplMobs, lxCaeplDetalle
				lxCaeplFecexpo =  .Fechaexpo			lxCaeplFectrans =  .Fechatransferencia			lxCaeplFecimpo =  .Fechaimpo			lxCaeplFmodifw =  .Fechamodificacionfw			lxCaeplCodigo =  .Codigo			lxCaeplTimestamp = goLibrerias.ObtenerTimestamp()			lxCaeplHoraexpo =  .Horaexpo			lxCaeplHaltafw =  .Horaaltafw			lxCaeplHoraimpo =  .Horaimpo			lxCaeplSmodifw =  .Seriemodificacionfw			lxCaeplVmodifw =  .Versionmodificacionfw			lxCaeplZadsfw =  .Zadsfw			lxCaeplValtafw =  .Versionaltafw			lxCaeplUmodifw =  .Usuariomodificacionfw			lxCaeplSaltafw =  .Seriealtafw			lxCaeplUaltafw =  .Usuarioaltafw			lxCaeplHmodifw =  .Horamodificacionfw			lxCaeplEsttrans =  .Estadotransferencia			lxCaeplBdmodifw =  .Basededatosmodificacionfw			lxCaeplBdaltafw =  .Basededatosaltafw			lxCaeplFaltafw =  .Fechaaltafw			lxCaeplComprob =  .Entidad			lxCaeplLetra =  .Letra			lxCaeplPtovta =  .Puntodeventa			lxCaeplNumdesde =  .Numerodesde			lxCaeplNumhasta =  .Numerohasta			lxCaeplSerie =  .Serie			lxCaeplVrsn =  .Version			lxCaeplDb =  .Db			lxCaeplUsuario =  .Usuario			lxCaeplMobs =  .Obs			lxCaeplDetalle =  .Detalle
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAEPL.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.CAEPL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCaeplFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCaeplFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCaeplFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCaeplFmodifw ) + "'">>, "Codigo" = <<lxCaeplCodigo>>, "Timestamp" = <<lxCaeplTimestamp>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCaeplHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCaeplHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCaeplHoraimpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCaeplSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCaeplVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCaeplZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCaeplValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCaeplUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCaeplSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCaeplUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCaeplHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCaeplEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCaeplBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCaeplBdaltafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCaeplFaltafw ) + "'">>, "Comprob" = <<"'" + this.FormatearTextoSql( lxCaeplComprob ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxCaeplLetra ) + "'">>, "Ptovta" = <<lxCaeplPtovta>>, "Numdesde" = <<lxCaeplNumdesde>>, "Numhasta" = <<lxCaeplNumhasta>>, "Serie" = <<"'" + this.FormatearTextoSql( lxCaeplSerie ) + "'">>, "Vrsn" = <<"'" + this.FormatearTextoSql( lxCaeplVrsn ) + "'">>, "Db" = <<"'" + this.FormatearTextoSql( lxCaeplDb ) + "'">>, "Usuario" = <<"'" + this.FormatearTextoSql( lxCaeplUsuario ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxCaeplMobs ) + "'">>, "Detalle" = <<"'" + this.FormatearTextoSql( lxCaeplDetalle ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CAEPL' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  CAEPL.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.CAEPL where ' + lcFiltro )
			loColeccion.cTabla = 'CAEPL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CAEPL where  CAEPL.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CAEPL where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  CAEPL.CODIGO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEPORLOTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CAEPL Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.CAEPL set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Comprob = ] + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, ptovta = ] + transform( &lcCursor..ptovta )+ [, NumDesde = ] + transform( &lcCursor..NumDesde )+ [, NumHasta = ] + transform( &lcCursor..NumHasta )+ [, serie = ] + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'"+ [, vrsn = ] + "'" + this.FormatearTextoSql( &lcCursor..vrsn ) + "'"+ [, db = ] + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'"+ [, usuario = ] + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, detalle = ] + "'" + this.FormatearTextoSql( &lcCursor..detalle ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FMODIFW, CODIGO, TIMESTAMP, HORAEXPO, HALTAFW, HORAIMPO, SMODIFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SALTAFW, UALTAFW, HMODIFW, ESTTRANS, BDMODIFW, BDALTAFW, FAltaFW, Comprob, Letra, ptovta, NumDesde, NumHasta, serie, vrsn, db, usuario, MObs, detalle
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..ptovta ) + ',' + transform( &lcCursor..NumDesde ) + ',' + transform( &lcCursor..NumHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..vrsn ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..detalle ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.CAEPL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEPORLOTE'
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
			Case  lcAlias == lcPrefijo + 'CAEPORLOTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAEPORLOTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAEPORLOTE_MOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CAEPORLOTE_DETALLE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CAEPL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CAEPORLOTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CAEPORLOTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEPORLOTE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEPORLOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CAEPL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CAEPL
Create Table ZooLogic.TablaTrabajo_CAEPL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"faltafw" datetime  null, 
"comprob" char( 40 )  null, 
"letra" char( 1 )  null, 
"ptovta" numeric( 4, 0 )  null, 
"numdesde" numeric( 9, 0 )  null, 
"numhasta" numeric( 9, 0 )  null, 
"serie" char( 20 )  null, 
"vrsn" char( 20 )  null, 
"db" char( 20 )  null, 
"usuario" char( 100 )  null, 
"mobs" varchar(max)  null, 
"detalle" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CAEPL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CAEPL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CAEPORLOTE'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('comprob','comprob')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('numdesde','numdesde')
			.AgregarMapeo('numhasta','numhasta')
			.AgregarMapeo('serie','serie')
			.AgregarMapeo('vrsn','vrsn')
			.AgregarMapeo('db','db')
			.AgregarMapeo('usuario','usuario')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('detalle','detalle')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CAEPL'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.COMPROB = isnull( d.COMPROB, t.COMPROB ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUMDESDE = isnull( d.NUMDESDE, t.NUMDESDE ),t.NUMHASTA = isnull( d.NUMHASTA, t.NUMHASTA ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.VRSN = isnull( d.VRSN, t.VRSN ),t.DB = isnull( d.DB, t.DB ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.DETALLE = isnull( d.DETALLE, t.DETALLE )
					from ZooLogic.CAEPL t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.CAEPL(Fecexpo,Fectrans,Fecimpo,Fmodifw,Codigo,Timestamp,Horaexpo,Haltafw,Horaimpo,Smodifw,Vmodifw,Zadsfw,Valtafw,Umodifw,Saltafw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Bdaltafw,Faltafw,Comprob,Letra,Ptovta,Numdesde,Numhasta,Serie,Vrsn,Db,Usuario,Mobs,Detalle)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.CODIGO,0),isnull( d.TIMESTAMP,0),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.COMPROB,''),isnull( d.LETRA,''),isnull( d.PTOVTA,0),isnull( d.NUMDESDE,0),isnull( d.NUMHASTA,0),isnull( d.SERIE,''),isnull( d.VRSN,''),isnull( d.DB,''),isnull( d.USUARIO,''),isnull( d.MOBS,''),isnull( d.DETALLE,'')
						From deleted d left join ZooLogic.CAEPL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CAEPL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CAEPL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CAEPORLOTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEPORLOTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEPORLOTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEPORLOTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEPORLOTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_CAEPORLOTE.Codigo, 0 )
					.Timestamp = nvl( c_CAEPORLOTE.Timestamp, 0 )
					.Horaexpo = nvl( c_CAEPORLOTE.Horaexpo, [] )
					.Horaaltafw = nvl( c_CAEPORLOTE.Horaaltafw, [] )
					.Horaimpo = nvl( c_CAEPORLOTE.Horaimpo, [] )
					.Seriemodificacionfw = nvl( c_CAEPORLOTE.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CAEPORLOTE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_CAEPORLOTE.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_CAEPORLOTE.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_CAEPORLOTE.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CAEPORLOTE.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_CAEPORLOTE.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_CAEPORLOTE.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_CAEPORLOTE.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CAEPORLOTE.Basededatosaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CAEPORLOTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Entidad = nvl( c_CAEPORLOTE.Entidad, [] )
					.Letra = nvl( c_CAEPORLOTE.Letra, [] )
					.Puntodeventa = nvl( c_CAEPORLOTE.Puntodeventa, 0 )
					.Numerodesde = nvl( c_CAEPORLOTE.Numerodesde, 0 )
					.Numerohasta = nvl( c_CAEPORLOTE.Numerohasta, 0 )
					.Serie = nvl( c_CAEPORLOTE.Serie, [] )
					.Version = nvl( c_CAEPORLOTE.Version, [] )
					.Db = nvl( c_CAEPORLOTE.Db, [] )
					.Usuario = nvl( c_CAEPORLOTE.Usuario, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					lcValor = This.ObtenerMemo( 'c_Detalle')
					.Detalle = lcValor 
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
		return c_CAEPORLOTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CAEPL' )
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
								from ZooLogic.CAEPL 
								Where   CAEPL.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CAEPL", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Codigo" as "Codigo", "Timestamp" as "Timestamp", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Mobs" as "Obs", "Detalle" as "Detalle"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CAEPL 
								Where   CAEPL.CODIGO != 0
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
	Tabla = 'CAEPL'
	Filtro = " CAEPL.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CAEPL.CODIGO != 0"
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
	<row entidad="CAEPORLOTE                              " atributo="FECHAEXPO                               " tabla="CAEPL          " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="FECHATRANSFERENCIA                      " tabla="CAEPL          " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="FECHAIMPO                               " tabla="CAEPL          " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="FECHAMODIFICACIONFW                     " tabla="CAEPL          " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="CODIGO                                  " tabla="CAEPL          " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="TIMESTAMP                               " tabla="CAEPL          " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="HORAEXPO                                " tabla="CAEPL          " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="HORAALTAFW                              " tabla="CAEPL          " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="HORAIMPO                                " tabla="CAEPL          " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="SERIEMODIFICACIONFW                     " tabla="CAEPL          " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="VERSIONMODIFICACIONFW                   " tabla="CAEPL          " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="ZADSFW                                  " tabla="CAEPL          " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="VERSIONALTAFW                           " tabla="CAEPL          " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="USUARIOMODIFICACIONFW                   " tabla="CAEPL          " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="SERIEALTAFW                             " tabla="CAEPL          " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="USUARIOALTAFW                           " tabla="CAEPL          " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="HORAMODIFICACIONFW                      " tabla="CAEPL          " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="ESTADOTRANSFERENCIA                     " tabla="CAEPL          " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CAEPL          " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="BASEDEDATOSALTAFW                       " tabla="CAEPL          " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="FECHAALTAFW                             " tabla="CAEPL          " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="2" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="ENTIDAD                                 " tabla="CAEPL          " campo="COMPROB   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="=&quot;FACTURAELECTRONICA&quot;                                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="3" etiqueta="Comprobante                                                                                                                                                     " dominio="COMBOENTIDADESCAEPORLOTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="LETRA                                   " tabla="CAEPL          " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;A&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="4" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="PUNTODEVENTA                            " tabla="CAEPL          " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.Felino.GestionDeVentas.FacturacionElectronica.Nacional.PuntoDeVenta                                                                                                                                                                   " obligatorio="true" admitebusqueda="5" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="NUMERODESDE                             " tabla="CAEPL          " campo="NUMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="NUMEROHASTA                             " tabla="CAEPL          " campo="NUMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="=99999999                                                                                                                                                                                                                                                     " obligatorio="false" admitebusqueda="7" etiqueta="Número                                                                                                                                                          " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="SERIE                                   " tabla="CAEPL          " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="200" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="VERSION                                 " tabla="CAEPL          " campo="VRSN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.ObtenerVersion()                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="201" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="DB                                      " tabla="CAEPL          " campo="DB        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Sucursal                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="USUARIO                                 " tabla="CAEPL          " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="203" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="OBS                                     " tabla="CAEPL          " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Observaciones Afip                                                                                                                                              " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAEPORLOTE                              " atributo="DETALLE                                 " tabla="CAEPL          " campo="DETALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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