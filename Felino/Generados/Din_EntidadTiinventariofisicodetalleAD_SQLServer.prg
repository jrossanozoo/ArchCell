
define class Din_EntidadTIINVENTARIOFISICODETALLEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIINVENTARIOFISICODETALLE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_FITPK'
	cTablaPrincipal = 'TIINVFISDET'
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
			local  lxTiinvfisdetFecexpo, lxTiinvfisdetFectrans, lxTiinvfisdetFmodifw, lxTiinvfisdetFaltafw, lxTiinvfisdetFecimpo, lxTiinvfisdetZadsfw, lxTiinvfisdetSaltafw, lxTiinvfisdetSmodifw, lxTiinvfisdetVmodifw, lxTiinvfisdetUaltafw, lxTiinvfisdetHmodifw, lxTiinvfisdetValtafw, lxTiinvfisdetUmodifw, lxTiinvfisdetHaltafw, lxTiinvfisdetHoraimpo, lxTiinvfisdetEsttrans, lxTiinvfisdetBdaltafw, lxTiinvfisdetBdmodifw, lxTiinvfisdetHoraexpo, lxTiinvfisdetMart, lxTiinvfisdetMcolo, lxTiinvfisdetCodigo, lxTiinvfisdetIdcabecera, lxTiinvfisdetMtall, lxTiinvfisdetMobs, lxTiinvfisdetCanti
				lxTiinvfisdetFecexpo =  .Fechaexpo			lxTiinvfisdetFectrans =  .Fechatransferencia			lxTiinvfisdetFmodifw =  .Fechamodificacionfw			lxTiinvfisdetFaltafw =  .Fechaaltafw			lxTiinvfisdetFecimpo =  .Fechaimpo			lxTiinvfisdetZadsfw =  .Zadsfw			lxTiinvfisdetSaltafw =  .Seriealtafw			lxTiinvfisdetSmodifw =  .Seriemodificacionfw			lxTiinvfisdetVmodifw =  .Versionmodificacionfw			lxTiinvfisdetUaltafw =  .Usuarioaltafw			lxTiinvfisdetHmodifw =  .Horamodificacionfw			lxTiinvfisdetValtafw =  .Versionaltafw			lxTiinvfisdetUmodifw =  .Usuariomodificacionfw			lxTiinvfisdetHaltafw =  .Horaaltafw			lxTiinvfisdetHoraimpo =  .Horaimpo			lxTiinvfisdetEsttrans =  .Estadotransferencia			lxTiinvfisdetBdaltafw =  .Basededatosaltafw			lxTiinvfisdetBdmodifw =  .Basededatosmodificacionfw			lxTiinvfisdetHoraexpo =  .Horaexpo			lxTiinvfisdetMart =  upper( .Articulo_PK ) 			lxTiinvfisdetMcolo =  upper( .Color_PK ) 			lxTiinvfisdetCodigo =  .Codigo			lxTiinvfisdetIdcabecera =  .Idcabecera_PK 			lxTiinvfisdetMtall =  .Talle			lxTiinvfisdetMobs =  .Obs			lxTiinvfisdetCanti =  .Cantidad
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTiinvfisdetCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TIINVFISDET ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Zadsfw","Saltafw","Smodifw","Vmodifw","Ualtafw","Hmodifw","Valtafw","Umodifw","Haltafw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Horaexpo","Mart","Mcolo","Codigo","Idcabecera","Mtall","Mobs","Canti" ) values ( <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMcolo ) + "'" >>, <<lxTiinvfisdetCodigo >>, <<lxTiinvfisdetIdcabecera >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMtall ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMobs ) + "'" >>, <<lxTiinvfisdetCanti >> )
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
			local  lxTiinvfisdetFecexpo, lxTiinvfisdetFectrans, lxTiinvfisdetFmodifw, lxTiinvfisdetFaltafw, lxTiinvfisdetFecimpo, lxTiinvfisdetZadsfw, lxTiinvfisdetSaltafw, lxTiinvfisdetSmodifw, lxTiinvfisdetVmodifw, lxTiinvfisdetUaltafw, lxTiinvfisdetHmodifw, lxTiinvfisdetValtafw, lxTiinvfisdetUmodifw, lxTiinvfisdetHaltafw, lxTiinvfisdetHoraimpo, lxTiinvfisdetEsttrans, lxTiinvfisdetBdaltafw, lxTiinvfisdetBdmodifw, lxTiinvfisdetHoraexpo, lxTiinvfisdetMart, lxTiinvfisdetMcolo, lxTiinvfisdetCodigo, lxTiinvfisdetIdcabecera, lxTiinvfisdetMtall, lxTiinvfisdetMobs, lxTiinvfisdetCanti
				lxTiinvfisdetFecexpo =  .Fechaexpo			lxTiinvfisdetFectrans =  .Fechatransferencia			lxTiinvfisdetFmodifw =  .Fechamodificacionfw			lxTiinvfisdetFaltafw =  .Fechaaltafw			lxTiinvfisdetFecimpo =  .Fechaimpo			lxTiinvfisdetZadsfw =  .Zadsfw			lxTiinvfisdetSaltafw =  .Seriealtafw			lxTiinvfisdetSmodifw =  .Seriemodificacionfw			lxTiinvfisdetVmodifw =  .Versionmodificacionfw			lxTiinvfisdetUaltafw =  .Usuarioaltafw			lxTiinvfisdetHmodifw =  .Horamodificacionfw			lxTiinvfisdetValtafw =  .Versionaltafw			lxTiinvfisdetUmodifw =  .Usuariomodificacionfw			lxTiinvfisdetHaltafw =  .Horaaltafw			lxTiinvfisdetHoraimpo =  .Horaimpo			lxTiinvfisdetEsttrans =  .Estadotransferencia			lxTiinvfisdetBdaltafw =  .Basededatosaltafw			lxTiinvfisdetBdmodifw =  .Basededatosmodificacionfw			lxTiinvfisdetHoraexpo =  .Horaexpo			lxTiinvfisdetMart =  upper( .Articulo_PK ) 			lxTiinvfisdetMcolo =  upper( .Color_PK ) 			lxTiinvfisdetCodigo =  .Codigo			lxTiinvfisdetIdcabecera =  .Idcabecera_PK 			lxTiinvfisdetMtall =  .Talle			lxTiinvfisdetMobs =  .Obs			lxTiinvfisdetCanti =  .Cantidad
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TIINVFISDET set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecimpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetZadsfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetSmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetUmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraexpo ) + "'">>,"Mart" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMart ) + "'">>,"Mcolo" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMcolo ) + "'">>,"Codigo" = <<lxTiinvfisdetCodigo>>,"Idcabecera" = <<lxTiinvfisdetIdcabecera>>,"Mtall" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMtall ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMobs ) + "'">>,"Canti" = <<lxTiinvfisdetCanti>> where "Codigo" = <<lxTiinvfisdetCodigo>> and  TIINVFISDET.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.TIINVFISDET where " + this.ConvertirFuncionesSql( " TIINVFISDET.CODIGO != 0" ) )
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
			Local lxTiinvfisdetCodigo
			lxTiinvfisdetCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad" from ZooLogic.TIINVFISDET where "Codigo" = <<lxTiinvfisdetCodigo>> and  TIINVFISDET.CODIGO != 0
			endtext
			use in select('c_TIINVENTARIOFISICODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOFISICODETALLE', set( 'Datasession' ) )

			if reccount( 'c_TIINVENTARIOFISICODETALLE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTiinvfisdetCodigo as Variant
		llRetorno = .t.
		lxTiinvfisdetCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TIINVFISDET where "Codigo" = <<lxTiinvfisdetCodigo>> and  TIINVFISDET.CODIGO != 0
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad" from ZooLogic.TIINVFISDET where  TIINVFISDET.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_TIINVENTARIOFISICODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOFISICODETALLE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad" from ZooLogic.TIINVFISDET where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIINVFISDET.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_TIINVENTARIOFISICODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOFISICODETALLE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad" from ZooLogic.TIINVFISDET where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIINVFISDET.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_TIINVENTARIOFISICODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOFISICODETALLE', set( 'Datasession' ) )
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
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad" from ZooLogic.TIINVFISDET where  TIINVFISDET.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_TIINVENTARIOFISICODETALLE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOFISICODETALLE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Zadsfw,Saltafw,Smodifw,Vmodifw,Ualtafw,Hmodifw,Valt" + ;
"afw,Umodifw,Haltafw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Horaexpo,Mart,Mcolo,Codigo,Idcabecera,Mtall," + ;
"Mobs,Canti" + ;
" from ZooLogic.TIINVFISDET where  TIINVFISDET.CODIGO != 0 and " + lcFiltro )
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
			local  lxTiinvfisdetFecexpo, lxTiinvfisdetFectrans, lxTiinvfisdetFmodifw, lxTiinvfisdetFaltafw, lxTiinvfisdetFecimpo, lxTiinvfisdetZadsfw, lxTiinvfisdetSaltafw, lxTiinvfisdetSmodifw, lxTiinvfisdetVmodifw, lxTiinvfisdetUaltafw, lxTiinvfisdetHmodifw, lxTiinvfisdetValtafw, lxTiinvfisdetUmodifw, lxTiinvfisdetHaltafw, lxTiinvfisdetHoraimpo, lxTiinvfisdetEsttrans, lxTiinvfisdetBdaltafw, lxTiinvfisdetBdmodifw, lxTiinvfisdetHoraexpo, lxTiinvfisdetMart, lxTiinvfisdetMcolo, lxTiinvfisdetCodigo, lxTiinvfisdetIdcabecera, lxTiinvfisdetMtall, lxTiinvfisdetMobs, lxTiinvfisdetCanti
				lxTiinvfisdetFecexpo = ctod( '  /  /    ' )			lxTiinvfisdetFectrans = ctod( '  /  /    ' )			lxTiinvfisdetFmodifw = ctod( '  /  /    ' )			lxTiinvfisdetFaltafw = ctod( '  /  /    ' )			lxTiinvfisdetFecimpo = ctod( '  /  /    ' )			lxTiinvfisdetZadsfw = []			lxTiinvfisdetSaltafw = []			lxTiinvfisdetSmodifw = []			lxTiinvfisdetVmodifw = []			lxTiinvfisdetUaltafw = []			lxTiinvfisdetHmodifw = []			lxTiinvfisdetValtafw = []			lxTiinvfisdetUmodifw = []			lxTiinvfisdetHaltafw = []			lxTiinvfisdetHoraimpo = []			lxTiinvfisdetEsttrans = []			lxTiinvfisdetBdaltafw = []			lxTiinvfisdetBdmodifw = []			lxTiinvfisdetHoraexpo = []			lxTiinvfisdetMart = []			lxTiinvfisdetMcolo = []			lxTiinvfisdetCodigo = 0			lxTiinvfisdetIdcabecera = 0			lxTiinvfisdetMtall = []			lxTiinvfisdetMobs = []			lxTiinvfisdetCanti = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.TIINVFISDET where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TIINVFISDET' + '_' + tcCampo
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
		lcWhere = " Where  TIINVFISDET.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TIINVFISDET', '', tnTope )
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
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MART AS ARTICULO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCOLO AS COLOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IDCABECERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCABECERA AS IDCABECERA'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MTALL AS TALLE'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBS'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTI AS CANTIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MART'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'MCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDCABECERA'
				lcCampo = 'IDCABECERA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'MTALL'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'MOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTI'
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
			local  lxTiinvfisdetFecexpo, lxTiinvfisdetFectrans, lxTiinvfisdetFmodifw, lxTiinvfisdetFaltafw, lxTiinvfisdetFecimpo, lxTiinvfisdetZadsfw, lxTiinvfisdetSaltafw, lxTiinvfisdetSmodifw, lxTiinvfisdetVmodifw, lxTiinvfisdetUaltafw, lxTiinvfisdetHmodifw, lxTiinvfisdetValtafw, lxTiinvfisdetUmodifw, lxTiinvfisdetHaltafw, lxTiinvfisdetHoraimpo, lxTiinvfisdetEsttrans, lxTiinvfisdetBdaltafw, lxTiinvfisdetBdmodifw, lxTiinvfisdetHoraexpo, lxTiinvfisdetMart, lxTiinvfisdetMcolo, lxTiinvfisdetCodigo, lxTiinvfisdetIdcabecera, lxTiinvfisdetMtall, lxTiinvfisdetMobs, lxTiinvfisdetCanti
				lxTiinvfisdetFecexpo =  .Fechaexpo			lxTiinvfisdetFectrans =  .Fechatransferencia			lxTiinvfisdetFmodifw =  .Fechamodificacionfw			lxTiinvfisdetFaltafw =  .Fechaaltafw			lxTiinvfisdetFecimpo =  .Fechaimpo			lxTiinvfisdetZadsfw =  .Zadsfw			lxTiinvfisdetSaltafw =  .Seriealtafw			lxTiinvfisdetSmodifw =  .Seriemodificacionfw			lxTiinvfisdetVmodifw =  .Versionmodificacionfw			lxTiinvfisdetUaltafw =  .Usuarioaltafw			lxTiinvfisdetHmodifw =  .Horamodificacionfw			lxTiinvfisdetValtafw =  .Versionaltafw			lxTiinvfisdetUmodifw =  .Usuariomodificacionfw			lxTiinvfisdetHaltafw =  .Horaaltafw			lxTiinvfisdetHoraimpo =  .Horaimpo			lxTiinvfisdetEsttrans =  .Estadotransferencia			lxTiinvfisdetBdaltafw =  .Basededatosaltafw			lxTiinvfisdetBdmodifw =  .Basededatosmodificacionfw			lxTiinvfisdetHoraexpo =  .Horaexpo			lxTiinvfisdetMart =  upper( .Articulo_PK ) 			lxTiinvfisdetMcolo =  upper( .Color_PK ) 			lxTiinvfisdetCodigo =  .Codigo			lxTiinvfisdetIdcabecera =  .Idcabecera_PK 			lxTiinvfisdetMtall =  .Talle			lxTiinvfisdetMobs =  .Obs			lxTiinvfisdetCanti =  .Cantidad
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TIINVFISDET ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Zadsfw","Saltafw","Smodifw","Vmodifw","Ualtafw","Hmodifw","Valtafw","Umodifw","Haltafw","Horaimpo","Esttrans","Bdaltafw","Bdmodifw","Horaexpo","Mart","Mcolo","Codigo","Idcabecera","Mtall","Mobs","Canti" ) values ( <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMcolo ) + "'" >>, <<lxTiinvfisdetCodigo >>, <<lxTiinvfisdetIdcabecera >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMtall ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvfisdetMobs ) + "'" >>, <<lxTiinvfisdetCanti >> )
		endtext
		loColeccion.cTabla = 'TIINVFISDET' 
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
			local  lxTiinvfisdetFecexpo, lxTiinvfisdetFectrans, lxTiinvfisdetFmodifw, lxTiinvfisdetFaltafw, lxTiinvfisdetFecimpo, lxTiinvfisdetZadsfw, lxTiinvfisdetSaltafw, lxTiinvfisdetSmodifw, lxTiinvfisdetVmodifw, lxTiinvfisdetUaltafw, lxTiinvfisdetHmodifw, lxTiinvfisdetValtafw, lxTiinvfisdetUmodifw, lxTiinvfisdetHaltafw, lxTiinvfisdetHoraimpo, lxTiinvfisdetEsttrans, lxTiinvfisdetBdaltafw, lxTiinvfisdetBdmodifw, lxTiinvfisdetHoraexpo, lxTiinvfisdetMart, lxTiinvfisdetMcolo, lxTiinvfisdetCodigo, lxTiinvfisdetIdcabecera, lxTiinvfisdetMtall, lxTiinvfisdetMobs, lxTiinvfisdetCanti
				lxTiinvfisdetFecexpo =  .Fechaexpo			lxTiinvfisdetFectrans =  .Fechatransferencia			lxTiinvfisdetFmodifw =  .Fechamodificacionfw			lxTiinvfisdetFaltafw =  .Fechaaltafw			lxTiinvfisdetFecimpo =  .Fechaimpo			lxTiinvfisdetZadsfw =  .Zadsfw			lxTiinvfisdetSaltafw =  .Seriealtafw			lxTiinvfisdetSmodifw =  .Seriemodificacionfw			lxTiinvfisdetVmodifw =  .Versionmodificacionfw			lxTiinvfisdetUaltafw =  .Usuarioaltafw			lxTiinvfisdetHmodifw =  .Horamodificacionfw			lxTiinvfisdetValtafw =  .Versionaltafw			lxTiinvfisdetUmodifw =  .Usuariomodificacionfw			lxTiinvfisdetHaltafw =  .Horaaltafw			lxTiinvfisdetHoraimpo =  .Horaimpo			lxTiinvfisdetEsttrans =  .Estadotransferencia			lxTiinvfisdetBdaltafw =  .Basededatosaltafw			lxTiinvfisdetBdmodifw =  .Basededatosmodificacionfw			lxTiinvfisdetHoraexpo =  .Horaexpo			lxTiinvfisdetMart =  upper( .Articulo_PK ) 			lxTiinvfisdetMcolo =  upper( .Color_PK ) 			lxTiinvfisdetCodigo =  .Codigo			lxTiinvfisdetIdcabecera =  .Idcabecera_PK 			lxTiinvfisdetMtall =  .Talle			lxTiinvfisdetMobs =  .Obs			lxTiinvfisdetCanti =  .Cantidad
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIINVFISDET.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.TIINVFISDET set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTiinvfisdetFecimpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetZadsfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetSmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetUmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetHoraexpo ) + "'">>, "Mart" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMart ) + "'">>, "Mcolo" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMcolo ) + "'">>, "Codigo" = <<lxTiinvfisdetCodigo>>, "Idcabecera" = <<lxTiinvfisdetIdcabecera>>, "Mtall" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMtall ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxTiinvfisdetMobs ) + "'">>, "Canti" = <<lxTiinvfisdetCanti>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TIINVFISDET' 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIINVFISDET.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.TIINVFISDET where ' + lcFiltro )
			loColeccion.cTabla = 'TIINVFISDET' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TIINVFISDET where  TIINVFISDET.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TIINVFISDET where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  TIINVFISDET.CODIGO != 0" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOFISICODETALLE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TIINVFISDET Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TIINVFISDET set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, MART = ] + "'" + this.FormatearTextoSql( &lcCursor..MART ) + "'"+ [, MCOLO = ] + "'" + this.FormatearTextoSql( &lcCursor..MCOLO ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, IDCABECERA = ] + transform( &lcCursor..IDCABECERA )+ [, MTALL = ] + "'" + this.FormatearTextoSql( &lcCursor..MTALL ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"+ [, CANTI = ] + transform( &lcCursor..CANTI ) + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, ZADSFW, SALTAFW, SMODIFW, VMODIFW, UALTAFW, HMODIFW, VALTAFW, UMODIFW, HALTAFW, HORAIMPO, ESTTRANS, BDALTAFW, BDMODIFW, HORAEXPO, MART, MCOLO, CODIGO, IDCABECERA, MTALL, MObs, CANTI
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MART ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MCOLO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CODIGO ) + ',' + transform( &lcCursor..IDCABECERA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MTALL ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + ',' + transform( &lcCursor..CANTI )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TIINVFISDET ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOFISICODETALLE'
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
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TIINVENTARIOFISICODETALLE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIINVENTARIOFISICODETALLE_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TIInvFisDet')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIINVENTARIOFISICODETALLE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIINVENTARIOFISICODETALLE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOFISICODETALLE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOFISICODETALLE'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIInvFisDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIInvFisDet
Create Table ZooLogic.TablaTrabajo_TIInvFisDet ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"zadsfw" varchar(max)  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"mart" char( 13 )  null, 
"mcolo" char( 2 )  null, 
"codigo" numeric( 8, 0 )  null, 
"idcabecera" numeric( 8, 0 )  null, 
"mtall" char( 3 )  null, 
"mobs" char( 100 )  null, 
"canti" numeric( 8, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TIInvFisDet' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TIInvFisDet' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOFISICODETALLE'
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
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('mart','mart')
			.AgregarMapeo('mcolo','mcolo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('idcabecera','idcabecera')
			.AgregarMapeo('mtall','mtall')
			.AgregarMapeo('mobs','mobs')
			.AgregarMapeo('canti','canti')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TIInvFisDet'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.MART = isnull( d.MART, t.MART ),t.MCOLO = isnull( d.MCOLO, t.MCOLO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.IDCABECERA = isnull( d.IDCABECERA, t.IDCABECERA ),t.MTALL = isnull( d.MTALL, t.MTALL ),t.MOBS = isnull( d.MOBS, t.MOBS ),t.CANTI = isnull( d.CANTI, t.CANTI )
					from ZooLogic.TIINVFISDET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.TIINVFISDET(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Zadsfw,Saltafw,Smodifw,Vmodifw,Ualtafw,Hmodifw,Valtafw,Umodifw,Haltafw,Horaimpo,Esttrans,Bdaltafw,Bdmodifw,Horaexpo,Mart,Mcolo,Codigo,Idcabecera,Mtall,Mobs,Canti)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.ZADSFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.MART,''),isnull( d.MCOLO,''),isnull( d.CODIGO,0),isnull( d.IDCABECERA,0),isnull( d.MTALL,''),isnull( d.MOBS,''),isnull( d.CANTI,0)
						From deleted d left join ZooLogic.TIINVFISDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIInvFisDet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIInvFisDet
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIINVENTARIOFISICODETALLE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOFISICODETALLE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOFISICODETALLE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOFISICODETALLE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOFISICODETALLE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOFISICODETALLE.Fechaimpo, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriealtafw = nvl( c_TIINVENTARIOFISICODETALLE.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_TIINVENTARIOFISICODETALLE.Seriemodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_TIINVENTARIOFISICODETALLE.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_TIINVENTARIOFISICODETALLE.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_TIINVENTARIOFISICODETALLE.Horamodificacionfw, [] )
					.Versionaltafw = nvl( c_TIINVENTARIOFISICODETALLE.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_TIINVENTARIOFISICODETALLE.Usuariomodificacionfw, [] )
					.Horaaltafw = nvl( c_TIINVENTARIOFISICODETALLE.Horaaltafw, [] )
					.Horaimpo = nvl( c_TIINVENTARIOFISICODETALLE.Horaimpo, [] )
					.Estadotransferencia = nvl( c_TIINVENTARIOFISICODETALLE.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_TIINVENTARIOFISICODETALLE.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_TIINVENTARIOFISICODETALLE.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_TIINVENTARIOFISICODETALLE.Horaexpo, [] )
					.Articulo_PK =  nvl( c_TIINVENTARIOFISICODETALLE.Articulo, [] )
					.Color_PK =  nvl( c_TIINVENTARIOFISICODETALLE.Color, [] )
					.Codigo = nvl( c_TIINVENTARIOFISICODETALLE.Codigo, 0 )
					.Idcabecera_PK =  nvl( c_TIINVENTARIOFISICODETALLE.Idcabecera, 0 )
					.Talle = nvl( c_TIINVENTARIOFISICODETALLE.Talle, [] )
					.Obs = nvl( c_TIINVENTARIOFISICODETALLE.Obs, [] )
					.Cantidad = nvl( c_TIINVENTARIOFISICODETALLE.Cantidad, 0 )
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
		return c_TIINVENTARIOFISICODETALLE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TIINVFISDET' )
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
								from ZooLogic.TIINVFISDET 
								Where   TIINVFISDET.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TIINVFISDET", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Zadsfw" as "Zadsfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Mart" as "Articulo", "Mcolo" as "Color", "Codigo" as "Codigo", "Idcabecera" as "Idcabecera", "Mtall" as "Talle", "Mobs" as "Obs", "Canti" as "Cantidad"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TIINVFISDET 
								Where   TIINVFISDET.CODIGO != 0
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
	Tabla = 'TIINVFISDET'
	Filtro = " TIINVFISDET.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TIINVFISDET.CODIGO != 0"
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
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="FECHAEXPO                               " tabla="TIINVFISDET    " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="FECHATRANSFERENCIA                      " tabla="TIINVFISDET    " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="FECHAMODIFICACIONFW                     " tabla="TIINVFISDET    " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="FECHAALTAFW                             " tabla="TIINVFISDET    " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="FECHAIMPO                               " tabla="TIINVFISDET    " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="ZADSFW                                  " tabla="TIINVFISDET    " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="SERIEALTAFW                             " tabla="TIINVFISDET    " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="SERIEMODIFICACIONFW                     " tabla="TIINVFISDET    " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="VERSIONMODIFICACIONFW                   " tabla="TIINVFISDET    " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="USUARIOALTAFW                           " tabla="TIINVFISDET    " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="HORAMODIFICACIONFW                      " tabla="TIINVFISDET    " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="VERSIONALTAFW                           " tabla="TIINVFISDET    " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="USUARIOMODIFICACIONFW                   " tabla="TIINVFISDET    " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="HORAALTAFW                              " tabla="TIINVFISDET    " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="HORAIMPO                                " tabla="TIINVFISDET    " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="ESTADOTRANSFERENCIA                     " tabla="TIINVFISDET    " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="BASEDEDATOSALTAFW                       " tabla="TIINVFISDET    " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TIINVFISDET    " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="HORAEXPO                                " tabla="TIINVFISDET    " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="ARTICULO                                " tabla="TIINVFISDET    " campo="MART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Artículo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; art.astock &lt;= 1 &quot;                                                                                                                                                                                     " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="COLOR                                   " tabla="TIINVFISDET    " campo="MCOLO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="CODIGO                                  " tabla="TIINVFISDET    " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="IDCABECERA                              " tabla="TIINVFISDET    " campo="IDCABECERA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIInventarioFisico                      " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Inventario físico                                                                                                                                               " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="TALLE                                   " tabla="TIINVFISDET    " campo="MTALL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Talle                                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="OBS                                     " tabla="TIINVFISDET    " campo="MOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICODETALLE               " atributo="CANTIDAD                                " tabla="TIINVFISDET    " campo="CANTI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Cantidad                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On TIINVFISDET.MART = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On TIINVFISDET.MCOLO = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOFISICO                      " atributo="DESCRIPCION                             " tabla="TIINVFIS       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Inv.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIINVFIS On TIINVFISDET.IDCABECERA = TIINVFIS.CODIGO And  TIINVFIS.CODIGO != 0                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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