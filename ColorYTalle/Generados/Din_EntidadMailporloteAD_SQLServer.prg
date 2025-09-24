
define class Din_EntidadMAILPORLOTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_MAILPORLOTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_MFAPK'
	cTablaPrincipal = 'MCAEPL'
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
			local  lxMcaeplFecexpo, lxMcaeplFmodifw, lxMcaeplFecimpo, lxMcaeplFectrans, lxMcaeplCodigo, lxMcaeplHoraimpo, lxMcaeplHoraexpo, lxMcaeplHaltafw, lxMcaeplSaltafw, lxMcaeplVmodifw, lxMcaeplZadsfw, lxMcaeplValtafw, lxMcaeplUmodifw, lxMcaeplSmodifw, lxMcaeplUaltafw, lxMcaeplHmodifw, lxMcaeplEsttrans, lxMcaeplBdmodifw, lxMcaeplBdaltafw, lxMcaeplFaltafw, lxMcaeplComprob, lxMcaeplLetra, lxMcaeplPtovta, lxMcaeplNumdesde, lxMcaeplNumhasta, lxMcaeplSerie, lxMcaeplVrsn, lxMcaeplDb, lxMcaeplUsuario, lxMcaeplDetalle
				lxMcaeplFecexpo =  .Fechaexpo			lxMcaeplFmodifw =  .Fechamodificacionfw			lxMcaeplFecimpo =  .Fechaimpo			lxMcaeplFectrans =  .Fechatransferencia			lxMcaeplCodigo =  .Codigo			lxMcaeplHoraimpo =  .Horaimpo			lxMcaeplHoraexpo =  .Horaexpo			lxMcaeplHaltafw =  .Horaaltafw			lxMcaeplSaltafw =  .Seriealtafw			lxMcaeplVmodifw =  .Versionmodificacionfw			lxMcaeplZadsfw =  .Zadsfw			lxMcaeplValtafw =  .Versionaltafw			lxMcaeplUmodifw =  .Usuariomodificacionfw			lxMcaeplSmodifw =  .Seriemodificacionfw			lxMcaeplUaltafw =  .Usuarioaltafw			lxMcaeplHmodifw =  .Horamodificacionfw			lxMcaeplEsttrans =  .Estadotransferencia			lxMcaeplBdmodifw =  .Basededatosmodificacionfw			lxMcaeplBdaltafw =  .Basededatosaltafw			lxMcaeplFaltafw =  .Fechaaltafw			lxMcaeplComprob =  .Entidad			lxMcaeplLetra =  .Letra			lxMcaeplPtovta =  .Puntodeventa			lxMcaeplNumdesde =  .Numerodesde			lxMcaeplNumhasta =  .Numerohasta			lxMcaeplSerie =  .Serie			lxMcaeplVrsn =  .Version			lxMcaeplDb =  .Db			lxMcaeplUsuario =  .Usuario			lxMcaeplDetalle =  .Detalle
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxMcaeplCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.MCAEPL ( "Fecexpo","Fmodifw","Fecimpo","Fectrans","Codigo","Horaimpo","Horaexpo","Haltafw","Saltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Bdaltafw","Faltafw","Comprob","Letra","Ptovta","Numdesde","Numhasta","Serie","Vrsn","Db","Usuario","Detalle" ) values ( <<"'" + this.ConvertirDateSql( lxMcaeplFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFectrans ) + "'" >>, <<lxMcaeplCodigo >>, <<"'" + this.FormatearTextoSql( lxMcaeplHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplBdaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplLetra ) + "'" >>, <<lxMcaeplPtovta >>, <<lxMcaeplNumdesde >>, <<lxMcaeplNumhasta >>, <<"'" + this.FormatearTextoSql( lxMcaeplSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplVrsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplDetalle ) + "'" >> )
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
			local  lxMcaeplFecexpo, lxMcaeplFmodifw, lxMcaeplFecimpo, lxMcaeplFectrans, lxMcaeplCodigo, lxMcaeplHoraimpo, lxMcaeplHoraexpo, lxMcaeplHaltafw, lxMcaeplSaltafw, lxMcaeplVmodifw, lxMcaeplZadsfw, lxMcaeplValtafw, lxMcaeplUmodifw, lxMcaeplSmodifw, lxMcaeplUaltafw, lxMcaeplHmodifw, lxMcaeplEsttrans, lxMcaeplBdmodifw, lxMcaeplBdaltafw, lxMcaeplFaltafw, lxMcaeplComprob, lxMcaeplLetra, lxMcaeplPtovta, lxMcaeplNumdesde, lxMcaeplNumhasta, lxMcaeplSerie, lxMcaeplVrsn, lxMcaeplDb, lxMcaeplUsuario, lxMcaeplDetalle
				lxMcaeplFecexpo =  .Fechaexpo			lxMcaeplFmodifw =  .Fechamodificacionfw			lxMcaeplFecimpo =  .Fechaimpo			lxMcaeplFectrans =  .Fechatransferencia			lxMcaeplCodigo =  .Codigo			lxMcaeplHoraimpo =  .Horaimpo			lxMcaeplHoraexpo =  .Horaexpo			lxMcaeplHaltafw =  .Horaaltafw			lxMcaeplSaltafw =  .Seriealtafw			lxMcaeplVmodifw =  .Versionmodificacionfw			lxMcaeplZadsfw =  .Zadsfw			lxMcaeplValtafw =  .Versionaltafw			lxMcaeplUmodifw =  .Usuariomodificacionfw			lxMcaeplSmodifw =  .Seriemodificacionfw			lxMcaeplUaltafw =  .Usuarioaltafw			lxMcaeplHmodifw =  .Horamodificacionfw			lxMcaeplEsttrans =  .Estadotransferencia			lxMcaeplBdmodifw =  .Basededatosmodificacionfw			lxMcaeplBdaltafw =  .Basededatosaltafw			lxMcaeplFaltafw =  .Fechaaltafw			lxMcaeplComprob =  .Entidad			lxMcaeplLetra =  .Letra			lxMcaeplPtovta =  .Puntodeventa			lxMcaeplNumdesde =  .Numerodesde			lxMcaeplNumhasta =  .Numerohasta			lxMcaeplSerie =  .Serie			lxMcaeplVrsn =  .Version			lxMcaeplDb =  .Db			lxMcaeplUsuario =  .Usuario			lxMcaeplDetalle =  .Detalle
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.MCAEPL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMcaeplFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxMcaeplFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxMcaeplFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxMcaeplFectrans ) + "'">>,"Codigo" = <<lxMcaeplCodigo>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxMcaeplHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxMcaeplHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxMcaeplHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxMcaeplSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxMcaeplZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxMcaeplValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxMcaeplUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxMcaeplEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMcaeplBdaltafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxMcaeplFaltafw ) + "'">>,"Comprob" = <<"'" + this.FormatearTextoSql( lxMcaeplComprob ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxMcaeplLetra ) + "'">>,"Ptovta" = <<lxMcaeplPtovta>>,"Numdesde" = <<lxMcaeplNumdesde>>,"Numhasta" = <<lxMcaeplNumhasta>>,"Serie" = <<"'" + this.FormatearTextoSql( lxMcaeplSerie ) + "'">>,"Vrsn" = <<"'" + this.FormatearTextoSql( lxMcaeplVrsn ) + "'">>,"Db" = <<"'" + this.FormatearTextoSql( lxMcaeplDb ) + "'">>,"Usuario" = <<"'" + this.FormatearTextoSql( lxMcaeplUsuario ) + "'">>,"Detalle" = <<"'" + this.FormatearTextoSql( lxMcaeplDetalle ) + "'">> where "Codigo" = <<lxMcaeplCodigo>> and  MCAEPL.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.MCAEPL where " + this.ConvertirFuncionesSql( " MCAEPL.CODIGO != 0" ) )
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
			Local lxMcaeplCodigo
			lxMcaeplCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle" from ZooLogic.MCAEPL where "Codigo" = <<lxMcaeplCodigo>> and  MCAEPL.CODIGO != 0
			endtext
			use in select('c_MAILPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAILPORLOTE', set( 'Datasession' ) )

			if reccount( 'c_MAILPORLOTE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxMcaeplCodigo as Variant
		llRetorno = .t.
		lxMcaeplCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.MCAEPL where "Codigo" = <<lxMcaeplCodigo>> and  MCAEPL.CODIGO != 0
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle" from ZooLogic.MCAEPL where  MCAEPL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_MAILPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAILPORLOTE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle" from ZooLogic.MCAEPL where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MCAEPL.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_MAILPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAILPORLOTE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle" from ZooLogic.MCAEPL where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  MCAEPL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_MAILPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAILPORLOTE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle" from ZooLogic.MCAEPL where  MCAEPL.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_MAILPORLOTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_MAILPORLOTE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fmodifw,Fecimpo,Fectrans,Codigo,Horaimpo,Horaexpo,Haltafw,Saltafw,Vmodifw,Zadsfw,Val" + ;
"tafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Bdaltafw,Faltafw,Comprob,Letra,Ptovta,Numdesd" + ;
"e,Numhasta,Serie,Vrsn,Db,Usuario,Detalle" + ;
" from ZooLogic.MCAEPL where  MCAEPL.CODIGO != 0 and " + lcFiltro )
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
			local  lxMcaeplFecexpo, lxMcaeplFmodifw, lxMcaeplFecimpo, lxMcaeplFectrans, lxMcaeplCodigo, lxMcaeplHoraimpo, lxMcaeplHoraexpo, lxMcaeplHaltafw, lxMcaeplSaltafw, lxMcaeplVmodifw, lxMcaeplZadsfw, lxMcaeplValtafw, lxMcaeplUmodifw, lxMcaeplSmodifw, lxMcaeplUaltafw, lxMcaeplHmodifw, lxMcaeplEsttrans, lxMcaeplBdmodifw, lxMcaeplBdaltafw, lxMcaeplFaltafw, lxMcaeplComprob, lxMcaeplLetra, lxMcaeplPtovta, lxMcaeplNumdesde, lxMcaeplNumhasta, lxMcaeplSerie, lxMcaeplVrsn, lxMcaeplDb, lxMcaeplUsuario, lxMcaeplDetalle
				lxMcaeplFecexpo = ctod( '  /  /    ' )			lxMcaeplFmodifw = ctod( '  /  /    ' )			lxMcaeplFecimpo = ctod( '  /  /    ' )			lxMcaeplFectrans = ctod( '  /  /    ' )			lxMcaeplCodigo = 0			lxMcaeplHoraimpo = []			lxMcaeplHoraexpo = []			lxMcaeplHaltafw = []			lxMcaeplSaltafw = []			lxMcaeplVmodifw = []			lxMcaeplZadsfw = []			lxMcaeplValtafw = []			lxMcaeplUmodifw = []			lxMcaeplSmodifw = []			lxMcaeplUaltafw = []			lxMcaeplHmodifw = []			lxMcaeplEsttrans = []			lxMcaeplBdmodifw = []			lxMcaeplBdaltafw = []			lxMcaeplFaltafw = ctod( '  /  /    ' )			lxMcaeplComprob = []			lxMcaeplLetra = []			lxMcaeplPtovta = 0			lxMcaeplNumdesde = 0			lxMcaeplNumhasta = 0			lxMcaeplSerie = []			lxMcaeplVrsn = []			lxMcaeplDb = []			lxMcaeplUsuario = []			lxMcaeplDetalle = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.MCAEPL where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'MCAEPL' + '_' + tcCampo
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
		lcWhere = " Where  MCAEPL.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'MCAEPL', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
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
			local  lxMcaeplFecexpo, lxMcaeplFmodifw, lxMcaeplFecimpo, lxMcaeplFectrans, lxMcaeplCodigo, lxMcaeplHoraimpo, lxMcaeplHoraexpo, lxMcaeplHaltafw, lxMcaeplSaltafw, lxMcaeplVmodifw, lxMcaeplZadsfw, lxMcaeplValtafw, lxMcaeplUmodifw, lxMcaeplSmodifw, lxMcaeplUaltafw, lxMcaeplHmodifw, lxMcaeplEsttrans, lxMcaeplBdmodifw, lxMcaeplBdaltafw, lxMcaeplFaltafw, lxMcaeplComprob, lxMcaeplLetra, lxMcaeplPtovta, lxMcaeplNumdesde, lxMcaeplNumhasta, lxMcaeplSerie, lxMcaeplVrsn, lxMcaeplDb, lxMcaeplUsuario, lxMcaeplDetalle
				lxMcaeplFecexpo =  .Fechaexpo			lxMcaeplFmodifw =  .Fechamodificacionfw			lxMcaeplFecimpo =  .Fechaimpo			lxMcaeplFectrans =  .Fechatransferencia			lxMcaeplCodigo =  .Codigo			lxMcaeplHoraimpo =  .Horaimpo			lxMcaeplHoraexpo =  .Horaexpo			lxMcaeplHaltafw =  .Horaaltafw			lxMcaeplSaltafw =  .Seriealtafw			lxMcaeplVmodifw =  .Versionmodificacionfw			lxMcaeplZadsfw =  .Zadsfw			lxMcaeplValtafw =  .Versionaltafw			lxMcaeplUmodifw =  .Usuariomodificacionfw			lxMcaeplSmodifw =  .Seriemodificacionfw			lxMcaeplUaltafw =  .Usuarioaltafw			lxMcaeplHmodifw =  .Horamodificacionfw			lxMcaeplEsttrans =  .Estadotransferencia			lxMcaeplBdmodifw =  .Basededatosmodificacionfw			lxMcaeplBdaltafw =  .Basededatosaltafw			lxMcaeplFaltafw =  .Fechaaltafw			lxMcaeplComprob =  .Entidad			lxMcaeplLetra =  .Letra			lxMcaeplPtovta =  .Puntodeventa			lxMcaeplNumdesde =  .Numerodesde			lxMcaeplNumhasta =  .Numerohasta			lxMcaeplSerie =  .Serie			lxMcaeplVrsn =  .Version			lxMcaeplDb =  .Db			lxMcaeplUsuario =  .Usuario			lxMcaeplDetalle =  .Detalle
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.MCAEPL ( "Fecexpo","Fmodifw","Fecimpo","Fectrans","Codigo","Horaimpo","Horaexpo","Haltafw","Saltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Bdmodifw","Bdaltafw","Faltafw","Comprob","Letra","Ptovta","Numdesde","Numhasta","Serie","Vrsn","Db","Usuario","Detalle" ) values ( <<"'" + this.ConvertirDateSql( lxMcaeplFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFectrans ) + "'" >>, <<lxMcaeplCodigo >>, <<"'" + this.FormatearTextoSql( lxMcaeplHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplBdaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxMcaeplFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplComprob ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplLetra ) + "'" >>, <<lxMcaeplPtovta >>, <<lxMcaeplNumdesde >>, <<lxMcaeplNumhasta >>, <<"'" + this.FormatearTextoSql( lxMcaeplSerie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplVrsn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplUsuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxMcaeplDetalle ) + "'" >> )
		endtext
		loColeccion.cTabla = 'MCAEPL' 
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
			local  lxMcaeplFecexpo, lxMcaeplFmodifw, lxMcaeplFecimpo, lxMcaeplFectrans, lxMcaeplCodigo, lxMcaeplHoraimpo, lxMcaeplHoraexpo, lxMcaeplHaltafw, lxMcaeplSaltafw, lxMcaeplVmodifw, lxMcaeplZadsfw, lxMcaeplValtafw, lxMcaeplUmodifw, lxMcaeplSmodifw, lxMcaeplUaltafw, lxMcaeplHmodifw, lxMcaeplEsttrans, lxMcaeplBdmodifw, lxMcaeplBdaltafw, lxMcaeplFaltafw, lxMcaeplComprob, lxMcaeplLetra, lxMcaeplPtovta, lxMcaeplNumdesde, lxMcaeplNumhasta, lxMcaeplSerie, lxMcaeplVrsn, lxMcaeplDb, lxMcaeplUsuario, lxMcaeplDetalle
				lxMcaeplFecexpo =  .Fechaexpo			lxMcaeplFmodifw =  .Fechamodificacionfw			lxMcaeplFecimpo =  .Fechaimpo			lxMcaeplFectrans =  .Fechatransferencia			lxMcaeplCodigo =  .Codigo			lxMcaeplHoraimpo =  .Horaimpo			lxMcaeplHoraexpo =  .Horaexpo			lxMcaeplHaltafw =  .Horaaltafw			lxMcaeplSaltafw =  .Seriealtafw			lxMcaeplVmodifw =  .Versionmodificacionfw			lxMcaeplZadsfw =  .Zadsfw			lxMcaeplValtafw =  .Versionaltafw			lxMcaeplUmodifw =  .Usuariomodificacionfw			lxMcaeplSmodifw =  .Seriemodificacionfw			lxMcaeplUaltafw =  .Usuarioaltafw			lxMcaeplHmodifw =  .Horamodificacionfw			lxMcaeplEsttrans =  .Estadotransferencia			lxMcaeplBdmodifw =  .Basededatosmodificacionfw			lxMcaeplBdaltafw =  .Basededatosaltafw			lxMcaeplFaltafw =  .Fechaaltafw			lxMcaeplComprob =  .Entidad			lxMcaeplLetra =  .Letra			lxMcaeplPtovta =  .Puntodeventa			lxMcaeplNumdesde =  .Numerodesde			lxMcaeplNumhasta =  .Numerohasta			lxMcaeplSerie =  .Serie			lxMcaeplVrsn =  .Version			lxMcaeplDb =  .Db			lxMcaeplUsuario =  .Usuario			lxMcaeplDetalle =  .Detalle
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MCAEPL.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.MCAEPL set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxMcaeplFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxMcaeplFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxMcaeplFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxMcaeplFectrans ) + "'">>, "Codigo" = <<lxMcaeplCodigo>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxMcaeplHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxMcaeplHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxMcaeplHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxMcaeplSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxMcaeplZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxMcaeplValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxMcaeplUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxMcaeplEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxMcaeplBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxMcaeplBdaltafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxMcaeplFaltafw ) + "'">>, "Comprob" = <<"'" + this.FormatearTextoSql( lxMcaeplComprob ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxMcaeplLetra ) + "'">>, "Ptovta" = <<lxMcaeplPtovta>>, "Numdesde" = <<lxMcaeplNumdesde>>, "Numhasta" = <<lxMcaeplNumhasta>>, "Serie" = <<"'" + this.FormatearTextoSql( lxMcaeplSerie ) + "'">>, "Vrsn" = <<"'" + this.FormatearTextoSql( lxMcaeplVrsn ) + "'">>, "Db" = <<"'" + this.FormatearTextoSql( lxMcaeplDb ) + "'">>, "Usuario" = <<"'" + this.FormatearTextoSql( lxMcaeplUsuario ) + "'">>, "Detalle" = <<"'" + this.FormatearTextoSql( lxMcaeplDetalle ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'MCAEPL' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  MCAEPL.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.MCAEPL where ' + lcFiltro )
			loColeccion.cTabla = 'MCAEPL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.MCAEPL where  MCAEPL.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.MCAEPL where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  MCAEPL.CODIGO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MAILPORLOTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.MCAEPL Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.MCAEPL set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, Comprob = ] + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, ptovta = ] + transform( &lcCursor..ptovta )+ [, NumDesde = ] + transform( &lcCursor..NumDesde )+ [, NumHasta = ] + transform( &lcCursor..NumHasta )+ [, serie = ] + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'"+ [, vrsn = ] + "'" + this.FormatearTextoSql( &lcCursor..vrsn ) + "'"+ [, db = ] + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'"+ [, usuario = ] + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"+ [, detalle = ] + "'" + this.FormatearTextoSql( &lcCursor..detalle ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FMODIFW, FECIMPO, FECTRANS, CODIGO, HORAIMPO, HORAEXPO, HALTAFW, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HMODIFW, ESTTRANS, BDMODIFW, BDALTAFW, FAltaFW, Comprob, Letra, ptovta, NumDesde, NumHasta, serie, vrsn, db, usuario, detalle
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Comprob ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..ptovta ) + ',' + transform( &lcCursor..NumDesde ) + ',' + transform( &lcCursor..NumHasta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..vrsn ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..usuario ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..detalle ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.MCAEPL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'MAILPORLOTE'
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
			Case  lcAlias == lcPrefijo + 'MAILPORLOTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MAILPORLOTE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'MAILPORLOTE_DETALLE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_MCAEPL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'MAILPORLOTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad MAILPORLOTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MAILPORLOTE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MAILPORLOTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MCAEPL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MCAEPL
Create Table ZooLogic.TablaTrabajo_MCAEPL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
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
"detalle" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_MCAEPL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_MCAEPL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'MAILPORLOTE'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
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
			.AgregarMapeo('detalle','detalle')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_MCAEPL'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.COMPROB = isnull( d.COMPROB, t.COMPROB ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.NUMDESDE = isnull( d.NUMDESDE, t.NUMDESDE ),t.NUMHASTA = isnull( d.NUMHASTA, t.NUMHASTA ),t.SERIE = isnull( d.SERIE, t.SERIE ),t.VRSN = isnull( d.VRSN, t.VRSN ),t.DB = isnull( d.DB, t.DB ),t.USUARIO = isnull( d.USUARIO, t.USUARIO ),t.DETALLE = isnull( d.DETALLE, t.DETALLE )
					from ZooLogic.MCAEPL t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.MCAEPL(Fecexpo,Fmodifw,Fecimpo,Fectrans,Codigo,Horaimpo,Horaexpo,Haltafw,Saltafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Bdmodifw,Bdaltafw,Faltafw,Comprob,Letra,Ptovta,Numdesde,Numhasta,Serie,Vrsn,Db,Usuario,Detalle)
					Select isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.CODIGO,0),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.COMPROB,''),isnull( d.LETRA,''),isnull( d.PTOVTA,0),isnull( d.NUMDESDE,0),isnull( d.NUMHASTA,0),isnull( d.SERIE,''),isnull( d.VRSN,''),isnull( d.DB,''),isnull( d.USUARIO,''),isnull( d.DETALLE,'')
						From deleted d left join ZooLogic.MCAEPL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_MCAEPL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_MCAEPL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_MAILPORLOTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAILPORLOTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAILPORLOTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAILPORLOTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAILPORLOTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_MAILPORLOTE.Codigo, 0 )
					.Horaimpo = nvl( c_MAILPORLOTE.Horaimpo, [] )
					.Horaexpo = nvl( c_MAILPORLOTE.Horaexpo, [] )
					.Horaaltafw = nvl( c_MAILPORLOTE.Horaaltafw, [] )
					.Seriealtafw = nvl( c_MAILPORLOTE.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_MAILPORLOTE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_MAILPORLOTE.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_MAILPORLOTE.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_MAILPORLOTE.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_MAILPORLOTE.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_MAILPORLOTE.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_MAILPORLOTE.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_MAILPORLOTE.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_MAILPORLOTE.Basededatosaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_MAILPORLOTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Entidad = nvl( c_MAILPORLOTE.Entidad, [] )
					.Letra = nvl( c_MAILPORLOTE.Letra, [] )
					.Puntodeventa = nvl( c_MAILPORLOTE.Puntodeventa, 0 )
					.Numerodesde = nvl( c_MAILPORLOTE.Numerodesde, 0 )
					.Numerohasta = nvl( c_MAILPORLOTE.Numerohasta, 0 )
					.Serie = nvl( c_MAILPORLOTE.Serie, [] )
					.Version = nvl( c_MAILPORLOTE.Version, [] )
					.Db = nvl( c_MAILPORLOTE.Db, [] )
					.Usuario = nvl( c_MAILPORLOTE.Usuario, [] )
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
		return c_MAILPORLOTE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.MCAEPL' )
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
								from ZooLogic.MCAEPL 
								Where   MCAEPL.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "MCAEPL", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Codigo" as "Codigo", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Faltafw" as "Fechaaltafw", "Comprob" as "Entidad", "Letra" as "Letra", "Ptovta" as "Puntodeventa", "Numdesde" as "Numerodesde", "Numhasta" as "Numerohasta", "Serie" as "Serie", "Vrsn" as "Version", "Db" as "Db", "Usuario" as "Usuario", "Detalle" as "Detalle"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.MCAEPL 
								Where   MCAEPL.CODIGO != 0
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
	Tabla = 'MCAEPL'
	Filtro = " MCAEPL.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " MCAEPL.CODIGO != 0"
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
	<row entidad="MAILPORLOTE                             " atributo="FECHAEXPO                               " tabla="MCAEPL         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="FECHAMODIFICACIONFW                     " tabla="MCAEPL         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="FECHAIMPO                               " tabla="MCAEPL         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="FECHATRANSFERENCIA                      " tabla="MCAEPL         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="CODIGO                                  " tabla="MCAEPL         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="HORAIMPO                                " tabla="MCAEPL         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="HORAEXPO                                " tabla="MCAEPL         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="HORAALTAFW                              " tabla="MCAEPL         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="SERIEALTAFW                             " tabla="MCAEPL         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="VERSIONMODIFICACIONFW                   " tabla="MCAEPL         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="ZADSFW                                  " tabla="MCAEPL         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="VERSIONALTAFW                           " tabla="MCAEPL         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="USUARIOMODIFICACIONFW                   " tabla="MCAEPL         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="SERIEMODIFICACIONFW                     " tabla="MCAEPL         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="USUARIOALTAFW                           " tabla="MCAEPL         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="HORAMODIFICACIONFW                      " tabla="MCAEPL         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="ESTADOTRANSFERENCIA                     " tabla="MCAEPL         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="MCAEPL         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="BASEDEDATOSALTAFW                       " tabla="MCAEPL         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="FECHAALTAFW                             " tabla="MCAEPL         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="2" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="ENTIDAD                                 " tabla="MCAEPL         " campo="COMPROB   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="=&quot;FACTURAELECTRONICA&quot;                                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="3" etiqueta="Comprobante                                                                                                                                                     " dominio="COMBOENTIDADESCAEPORLOTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="LETRA                                   " tabla="MCAEPL         " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;A&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="4" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="PUNTODEVENTA                            " tabla="MCAEPL         " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.Felino.GestionDeVentas.FacturacionElectronica.Nacional.PuntoDeVenta                                                                                                                                                                   " obligatorio="true" admitebusqueda="5" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="NUMERODESDE                             " tabla="MCAEPL         " campo="NUMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número desde                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="NUMEROHASTA                             " tabla="MCAEPL         " campo="NUMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Número hasta                                                                                                                                                    " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="SERIE                                   " tabla="MCAEPL         " campo="SERIE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="0" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="VERSION                                 " tabla="MCAEPL         " campo="VRSN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.ObtenerVersion()                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="DB                                      " tabla="MCAEPL         " campo="DB        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sucursal                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="USUARIO                                 " tabla="MCAEPL         " campo="USUARIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="0" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="14" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MAILPORLOTE                             " atributo="DETALLE                                 " tabla="MCAEPL         " campo="DETALLE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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