
define class Din_EntidadCODIGOPOSTALAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CODIGOPOSTAL'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_CP8PK'
	cTablaPrincipal = 'CODPOSTAL1'
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

		with this.oEntidad
			local  lxCodpostal1Fecexpo, lxCodpostal1Fectrans, lxCodpostal1Fecimpo, lxCodpostal1Faltafw, lxCodpostal1Fmodifw, lxCodpostal1Bloqreg, lxCodpostal1Smodifw, lxCodpostal1Saltafw, lxCodpostal1Ualtafw, lxCodpostal1Zadsfw, lxCodpostal1Umodifw, lxCodpostal1Valtafw, lxCodpostal1Hmodifw, lxCodpostal1Vmodifw, lxCodpostal1Haltafw, lxCodpostal1Horaimpo, lxCodpostal1Bdmodifw, lxCodpostal1Bdaltafw, lxCodpostal1Esttrans, lxCodpostal1Horaexpo, lxCodpostal1Codigo, lxCodpostal1Clobs, lxCodpostal1Cp, lxCodpostal1Provincia, lxCodpostal1Localidad, lxCodpostal1Desde, lxCodpostal1Hasta
				lxCodpostal1Fecexpo =  .Fechaexpo			lxCodpostal1Fectrans =  .Fechatransferencia			lxCodpostal1Fecimpo =  .Fechaimpo			lxCodpostal1Faltafw =  .Fechaaltafw			lxCodpostal1Fmodifw =  .Fechamodificacionfw			lxCodpostal1Bloqreg =  .Bloquearregistro			lxCodpostal1Smodifw =  .Seriemodificacionfw			lxCodpostal1Saltafw =  .Seriealtafw			lxCodpostal1Ualtafw =  .Usuarioaltafw			lxCodpostal1Zadsfw =  .Zadsfw			lxCodpostal1Umodifw =  .Usuariomodificacionfw			lxCodpostal1Valtafw =  .Versionaltafw			lxCodpostal1Hmodifw =  .Horamodificacionfw			lxCodpostal1Vmodifw =  .Versionmodificacionfw			lxCodpostal1Haltafw =  .Horaaltafw			lxCodpostal1Horaimpo =  .Horaimpo			lxCodpostal1Bdmodifw =  .Basededatosmodificacionfw			lxCodpostal1Bdaltafw =  .Basededatosaltafw			lxCodpostal1Esttrans =  .Estadotransferencia			lxCodpostal1Horaexpo =  .Horaexpo			lxCodpostal1Codigo =  .Codigo			lxCodpostal1Clobs =  .Obs			lxCodpostal1Cp =  .Codigopostal			lxCodpostal1Provincia =  upper( .Provincia_PK ) 			lxCodpostal1Localidad =  .Localidad			lxCodpostal1Desde =  .Desde			lxCodpostal1Hasta =  .Hasta
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCodpostal1Cp = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.CODPOSTAL1 ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Bloqreg","Smodifw","Saltafw","Ualtafw","Zadsfw","Umodifw","Valtafw","Hmodifw","Vmodifw","Haltafw","Horaimpo","Bdmodifw","Bdaltafw","Esttrans","Horaexpo","Codigo","Clobs","Cp","Provincia","Localidad","Desde","Hasta" ) values ( <<"'" + this.ConvertirDateSql( lxCodpostal1Fecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Fectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Fecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Faltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Fmodifw ) + "'" >>, <<iif( lxCodpostal1Bloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Smodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Saltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Ualtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Zadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Umodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Valtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Hmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Vmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Haltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Horaimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Bdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Bdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Esttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Horaexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Codigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Clobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Provincia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Localidad ) + "'" >>, <<lxCodpostal1Desde >>, <<lxCodpostal1Hasta >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGOPOSTAL
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
		return this.oEntidad.CODIGOPOSTAL
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxCodpostal1Fecexpo, lxCodpostal1Fectrans, lxCodpostal1Fecimpo, lxCodpostal1Faltafw, lxCodpostal1Fmodifw, lxCodpostal1Bloqreg, lxCodpostal1Smodifw, lxCodpostal1Saltafw, lxCodpostal1Ualtafw, lxCodpostal1Zadsfw, lxCodpostal1Umodifw, lxCodpostal1Valtafw, lxCodpostal1Hmodifw, lxCodpostal1Vmodifw, lxCodpostal1Haltafw, lxCodpostal1Horaimpo, lxCodpostal1Bdmodifw, lxCodpostal1Bdaltafw, lxCodpostal1Esttrans, lxCodpostal1Horaexpo, lxCodpostal1Codigo, lxCodpostal1Clobs, lxCodpostal1Cp, lxCodpostal1Provincia, lxCodpostal1Localidad, lxCodpostal1Desde, lxCodpostal1Hasta
				lxCodpostal1Fecexpo =  .Fechaexpo			lxCodpostal1Fectrans =  .Fechatransferencia			lxCodpostal1Fecimpo =  .Fechaimpo			lxCodpostal1Faltafw =  .Fechaaltafw			lxCodpostal1Fmodifw =  .Fechamodificacionfw			lxCodpostal1Bloqreg =  .Bloquearregistro			lxCodpostal1Smodifw =  .Seriemodificacionfw			lxCodpostal1Saltafw =  .Seriealtafw			lxCodpostal1Ualtafw =  .Usuarioaltafw			lxCodpostal1Zadsfw =  .Zadsfw			lxCodpostal1Umodifw =  .Usuariomodificacionfw			lxCodpostal1Valtafw =  .Versionaltafw			lxCodpostal1Hmodifw =  .Horamodificacionfw			lxCodpostal1Vmodifw =  .Versionmodificacionfw			lxCodpostal1Haltafw =  .Horaaltafw			lxCodpostal1Horaimpo =  .Horaimpo			lxCodpostal1Bdmodifw =  .Basededatosmodificacionfw			lxCodpostal1Bdaltafw =  .Basededatosaltafw			lxCodpostal1Esttrans =  .Estadotransferencia			lxCodpostal1Horaexpo =  .Horaexpo			lxCodpostal1Codigo =  .Codigo			lxCodpostal1Clobs =  .Obs			lxCodpostal1Cp =  .Codigopostal			lxCodpostal1Provincia =  upper( .Provincia_PK ) 			lxCodpostal1Localidad =  .Localidad			lxCodpostal1Desde =  .Desde			lxCodpostal1Hasta =  .Hasta
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGOPOSTAL
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.CODPOSTAL1 set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCodpostal1Faltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fmodifw ) + "'">>,"Bloqreg" = <<iif( lxCodpostal1Bloqreg, 1, 0 )>>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Smodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Saltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Ualtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Zadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Umodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Valtafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Hmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Vmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Haltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCodpostal1Horaimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Bdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Bdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCodpostal1Esttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCodpostal1Horaexpo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCodpostal1Codigo ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxCodpostal1Clobs ) + "'">>,"Cp" = <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'">>,"Provincia" = <<"'" + this.FormatearTextoSql( lxCodpostal1Provincia ) + "'">>,"Localidad" = <<"'" + this.FormatearTextoSql( lxCodpostal1Localidad ) + "'">>,"Desde" = <<lxCodpostal1Desde>>,"Hasta" = <<lxCodpostal1Hasta>> where "Cp" = <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'">> and  CODPOSTAL1.CP != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CP from ORGANIZACION.CODPOSTAL1 where " + this.ConvertirFuncionesSql( " CODPOSTAL1.CP != ''" ) )
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
			Local lxCodpostal1Cp
			lxCodpostal1Cp = .Codigopostal

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta" from ORGANIZACION.CODPOSTAL1 where "Cp" = <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'">> and  CODPOSTAL1.CP != ''
			endtext
			use in select('c_CODIGOPOSTAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODIGOPOSTAL', set( 'Datasession' ) )

			if reccount( 'c_CODIGOPOSTAL' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCodpostal1Cp as Variant
		llRetorno = .t.
		lxCodpostal1Cp = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.CODPOSTAL1 where "Cp" = <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'">> and  CODPOSTAL1.CP != ''
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
				lcOrden =  .CodigoPostal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta" from ORGANIZACION.CODPOSTAL1 where  CODPOSTAL1.CP != '' order by CP
			endtext
			use in select('c_CODIGOPOSTAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODIGOPOSTAL', set( 'Datasession' ) )
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
				lcOrden =  .CodigoPostal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta" from ORGANIZACION.CODPOSTAL1 where  funciones.padr( CP, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CODPOSTAL1.CP != '' order by CP
			endtext
			use in select('c_CODIGOPOSTAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODIGOPOSTAL', set( 'Datasession' ) )
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
				lcOrden =  .CodigoPostal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta" from ORGANIZACION.CODPOSTAL1 where  funciones.padr( CP, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CODPOSTAL1.CP != '' order by CP desc
			endtext
			use in select('c_CODIGOPOSTAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODIGOPOSTAL', set( 'Datasession' ) )
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
				lcOrden =  .CodigoPostal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta" from ORGANIZACION.CODPOSTAL1 where  CODPOSTAL1.CP != '' order by CP desc
			endtext
			use in select('c_CODIGOPOSTAL')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CODIGOPOSTAL', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGOPOSTAL ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Bloqreg,Smodifw,Saltafw,Ualtafw,Zadsfw,Umodifw,Valt" + ;
"afw,Hmodifw,Vmodifw,Haltafw,Horaimpo,Bdmodifw,Bdaltafw,Esttrans,Horaexpo,Codigo,Clobs,Cp,Provincia,L" + ;
"ocalidad,Desde,Hasta" + ;
" from ORGANIZACION.CODPOSTAL1 where  CODPOSTAL1.CP != '' and " + lcFiltro )
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
			local  lxCodpostal1Fecexpo, lxCodpostal1Fectrans, lxCodpostal1Fecimpo, lxCodpostal1Faltafw, lxCodpostal1Fmodifw, lxCodpostal1Bloqreg, lxCodpostal1Smodifw, lxCodpostal1Saltafw, lxCodpostal1Ualtafw, lxCodpostal1Zadsfw, lxCodpostal1Umodifw, lxCodpostal1Valtafw, lxCodpostal1Hmodifw, lxCodpostal1Vmodifw, lxCodpostal1Haltafw, lxCodpostal1Horaimpo, lxCodpostal1Bdmodifw, lxCodpostal1Bdaltafw, lxCodpostal1Esttrans, lxCodpostal1Horaexpo, lxCodpostal1Codigo, lxCodpostal1Clobs, lxCodpostal1Cp, lxCodpostal1Provincia, lxCodpostal1Localidad, lxCodpostal1Desde, lxCodpostal1Hasta
				lxCodpostal1Fecexpo = ctod( '  /  /    ' )			lxCodpostal1Fectrans = ctod( '  /  /    ' )			lxCodpostal1Fecimpo = ctod( '  /  /    ' )			lxCodpostal1Faltafw = ctod( '  /  /    ' )			lxCodpostal1Fmodifw = ctod( '  /  /    ' )			lxCodpostal1Bloqreg = .F.			lxCodpostal1Smodifw = []			lxCodpostal1Saltafw = []			lxCodpostal1Ualtafw = []			lxCodpostal1Zadsfw = []			lxCodpostal1Umodifw = []			lxCodpostal1Valtafw = []			lxCodpostal1Hmodifw = []			lxCodpostal1Vmodifw = []			lxCodpostal1Haltafw = []			lxCodpostal1Horaimpo = []			lxCodpostal1Bdmodifw = []			lxCodpostal1Bdaltafw = []			lxCodpostal1Esttrans = []			lxCodpostal1Horaexpo = []			lxCodpostal1Codigo = []			lxCodpostal1Clobs = []			lxCodpostal1Cp = []			lxCodpostal1Provincia = []			lxCodpostal1Localidad = []			lxCodpostal1Desde = 0			lxCodpostal1Hasta = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.CODPOSTAL1 where "CP" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGOPOSTAL ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CODPOSTAL1' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CP = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CP, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CODPOSTAL1.CP != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CODPOSTAL1', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBS'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CP AS CODIGOPOSTAL'
				Case lcAtributo == 'PROVINCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVINCIA AS PROVINCIA'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOCALIDAD AS LOCALIDAD'
				Case lcAtributo == 'DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDE AS DESDE'
				Case lcAtributo == 'HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTA AS HASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVINCIA'
				lcCampo = 'PROVINCIA'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'LOCALIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'DESDE'
				lcCampo = 'DESDE'
			Case upper( alltrim( tcAtributo ) ) == 'HASTA'
				lcCampo = 'HASTA'
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
			local  lxCodpostal1Fecexpo, lxCodpostal1Fectrans, lxCodpostal1Fecimpo, lxCodpostal1Faltafw, lxCodpostal1Fmodifw, lxCodpostal1Bloqreg, lxCodpostal1Smodifw, lxCodpostal1Saltafw, lxCodpostal1Ualtafw, lxCodpostal1Zadsfw, lxCodpostal1Umodifw, lxCodpostal1Valtafw, lxCodpostal1Hmodifw, lxCodpostal1Vmodifw, lxCodpostal1Haltafw, lxCodpostal1Horaimpo, lxCodpostal1Bdmodifw, lxCodpostal1Bdaltafw, lxCodpostal1Esttrans, lxCodpostal1Horaexpo, lxCodpostal1Codigo, lxCodpostal1Clobs, lxCodpostal1Cp, lxCodpostal1Provincia, lxCodpostal1Localidad, lxCodpostal1Desde, lxCodpostal1Hasta
				lxCodpostal1Fecexpo =  .Fechaexpo			lxCodpostal1Fectrans =  .Fechatransferencia			lxCodpostal1Fecimpo =  .Fechaimpo			lxCodpostal1Faltafw =  .Fechaaltafw			lxCodpostal1Fmodifw =  .Fechamodificacionfw			lxCodpostal1Bloqreg =  .Bloquearregistro			lxCodpostal1Smodifw =  .Seriemodificacionfw			lxCodpostal1Saltafw =  .Seriealtafw			lxCodpostal1Ualtafw =  .Usuarioaltafw			lxCodpostal1Zadsfw =  .Zadsfw			lxCodpostal1Umodifw =  .Usuariomodificacionfw			lxCodpostal1Valtafw =  .Versionaltafw			lxCodpostal1Hmodifw =  .Horamodificacionfw			lxCodpostal1Vmodifw =  .Versionmodificacionfw			lxCodpostal1Haltafw =  .Horaaltafw			lxCodpostal1Horaimpo =  .Horaimpo			lxCodpostal1Bdmodifw =  .Basededatosmodificacionfw			lxCodpostal1Bdaltafw =  .Basededatosaltafw			lxCodpostal1Esttrans =  .Estadotransferencia			lxCodpostal1Horaexpo =  .Horaexpo			lxCodpostal1Codigo =  .Codigo			lxCodpostal1Clobs =  .Obs			lxCodpostal1Cp =  .Codigopostal			lxCodpostal1Provincia =  upper( .Provincia_PK ) 			lxCodpostal1Localidad =  .Localidad			lxCodpostal1Desde =  .Desde			lxCodpostal1Hasta =  .Hasta
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.CODPOSTAL1 ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Bloqreg","Smodifw","Saltafw","Ualtafw","Zadsfw","Umodifw","Valtafw","Hmodifw","Vmodifw","Haltafw","Horaimpo","Bdmodifw","Bdaltafw","Esttrans","Horaexpo","Codigo","Clobs","Cp","Provincia","Localidad","Desde","Hasta" ) values ( <<"'" + this.ConvertirDateSql( lxCodpostal1Fecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Fectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Fecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Faltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCodpostal1Fmodifw ) + "'" >>, <<iif( lxCodpostal1Bloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Smodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Saltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Ualtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Zadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Umodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Valtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Hmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Vmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Haltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Horaimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Bdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Bdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Esttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Horaexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Codigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Clobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Provincia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCodpostal1Localidad ) + "'" >>, <<lxCodpostal1Desde >>, <<lxCodpostal1Hasta >> )
		endtext
		loColeccion.cTabla = 'CODPOSTAL1' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGOPOSTAL + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCodpostal1Fecexpo, lxCodpostal1Fectrans, lxCodpostal1Fecimpo, lxCodpostal1Faltafw, lxCodpostal1Fmodifw, lxCodpostal1Bloqreg, lxCodpostal1Smodifw, lxCodpostal1Saltafw, lxCodpostal1Ualtafw, lxCodpostal1Zadsfw, lxCodpostal1Umodifw, lxCodpostal1Valtafw, lxCodpostal1Hmodifw, lxCodpostal1Vmodifw, lxCodpostal1Haltafw, lxCodpostal1Horaimpo, lxCodpostal1Bdmodifw, lxCodpostal1Bdaltafw, lxCodpostal1Esttrans, lxCodpostal1Horaexpo, lxCodpostal1Codigo, lxCodpostal1Clobs, lxCodpostal1Cp, lxCodpostal1Provincia, lxCodpostal1Localidad, lxCodpostal1Desde, lxCodpostal1Hasta
				lxCodpostal1Fecexpo =  .Fechaexpo			lxCodpostal1Fectrans =  .Fechatransferencia			lxCodpostal1Fecimpo =  .Fechaimpo			lxCodpostal1Faltafw =  .Fechaaltafw			lxCodpostal1Fmodifw =  .Fechamodificacionfw			lxCodpostal1Bloqreg =  .Bloquearregistro			lxCodpostal1Smodifw =  .Seriemodificacionfw			lxCodpostal1Saltafw =  .Seriealtafw			lxCodpostal1Ualtafw =  .Usuarioaltafw			lxCodpostal1Zadsfw =  .Zadsfw			lxCodpostal1Umodifw =  .Usuariomodificacionfw			lxCodpostal1Valtafw =  .Versionaltafw			lxCodpostal1Hmodifw =  .Horamodificacionfw			lxCodpostal1Vmodifw =  .Versionmodificacionfw			lxCodpostal1Haltafw =  .Horaaltafw			lxCodpostal1Horaimpo =  .Horaimpo			lxCodpostal1Bdmodifw =  .Basededatosmodificacionfw			lxCodpostal1Bdaltafw =  .Basededatosaltafw			lxCodpostal1Esttrans =  .Estadotransferencia			lxCodpostal1Horaexpo =  .Horaexpo			lxCodpostal1Codigo =  .Codigo			lxCodpostal1Clobs =  .Obs			lxCodpostal1Cp =  .Codigopostal			lxCodpostal1Provincia =  upper( .Provincia_PK ) 			lxCodpostal1Localidad =  .Localidad			lxCodpostal1Desde =  .Desde			lxCodpostal1Hasta =  .Hasta
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGOPOSTAL
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGOPOSTAL + "'"

			lcFiltro = ["Cp" = ] + lcValorClavePrimariaString  + [ and  CODPOSTAL1.CP != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.CODPOSTAL1 set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCodpostal1Faltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCodpostal1Fmodifw ) + "'">>, "Bloqreg" = <<iif( lxCodpostal1Bloqreg, 1, 0 )>>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Smodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Saltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Ualtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Zadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Umodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Valtafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Hmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Vmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Haltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCodpostal1Horaimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Bdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCodpostal1Bdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCodpostal1Esttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCodpostal1Horaexpo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCodpostal1Codigo ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxCodpostal1Clobs ) + "'">>, "Cp" = <<"'" + this.FormatearTextoSql( lxCodpostal1Cp ) + "'">>, "Provincia" = <<"'" + this.FormatearTextoSql( lxCodpostal1Provincia ) + "'">>, "Localidad" = <<"'" + this.FormatearTextoSql( lxCodpostal1Localidad ) + "'">>, "Desde" = <<lxCodpostal1Desde>>, "Hasta" = <<lxCodpostal1Hasta>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CODPOSTAL1' 
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
			lxValorClavePrimaria = this.oEntidad.CODIGOPOSTAL
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGOPOSTAL + "'"

			lcFiltro = ["Cp" = ] + lcValorClavePrimariaString  + [ and  CODPOSTAL1.CP != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.CODPOSTAL1 where ' + lcFiltro )
			loColeccion.cTabla = 'CODPOSTAL1' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.CODPOSTAL1 where  CODPOSTAL1.CP != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.CODPOSTAL1 where CP = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGOPOSTAL ) + "'"+ " and  CODPOSTAL1.CP != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CODIGOPOSTAL'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.CODPOSTAL1 Where CP = ] + "'" + this.FormatearTextoSql( &lcCursor..CP ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.CODPOSTAL1 set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CP = ] + "'" + this.FormatearTextoSql( &lcCursor..CP ) + "'"+ [, Provincia = ] + "'" + this.FormatearTextoSql( &lcCursor..Provincia ) + "'"+ [, Localidad = ] + "'" + this.FormatearTextoSql( &lcCursor..Localidad ) + "'"+ [, Desde = ] + transform( &lcCursor..Desde )+ [, Hasta = ] + transform( &lcCursor..Hasta ) + [ Where CP = ] + "'" + this.FormatearTextoSql( &lcCursor..CP ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, BLOQREG, SMODIFW, SALTAFW, UALTAFW, ZADSFW, UMODIFW, VALTAFW, HMODIFW, VMODIFW, HALTAFW, HORAIMPO, BDMODIFW, BDALTAFW, ESTTRANS, HORAEXPO, Codigo, CLOBS, CP, Provincia, Localidad, Desde, Hasta
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CP ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Provincia ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Localidad ) + "'" + ',' + transform( &lcCursor..Desde ) + ',' + transform( &lcCursor..Hasta )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.CODPOSTAL1 ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CODIGOPOSTAL'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CP C (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código postal: ' + transform( &tcCursor..CP         )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CODIGOPOSTAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CODIGOPOSTAL_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CODIGOPOSTAL_CLOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_CodPostal1')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CODIGOPOSTAL'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CP
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CODIGOPOSTAL. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CODIGOPOSTAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CP as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CP, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CODIGOPOSTAL'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_CodPostal1') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_CodPostal1
Create Table ORGANIZACION.TablaTrabajo_CodPostal1 ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"bloqreg" bit  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"codigo" char( 38 )  null, 
"clobs" varchar(max)  null, 
"cp" char( 8 )  null, 
"provincia" char( 2 )  null, 
"localidad" char( 100 )  null, 
"desde" numeric( 6, 0 )  null, 
"hasta" numeric( 6, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CodPostal1' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CodPostal1' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CODIGOPOSTAL'
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('cp','cp')
			.AgregarMapeo('provincia','provincia')
			.AgregarMapeo('localidad','localidad')
			.AgregarMapeo('desde','desde')
			.AgregarMapeo('hasta','hasta')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_CodPostal1'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CP = isnull( d.CP, t.CP ),t.PROVINCIA = isnull( d.PROVINCIA, t.PROVINCIA ),t.LOCALIDAD = isnull( d.LOCALIDAD, t.LOCALIDAD ),t.DESDE = isnull( d.DESDE, t.DESDE ),t.HASTA = isnull( d.HASTA, t.HASTA )
					from ORGANIZACION.CODPOSTAL1 t inner join deleted d 
							 on t.CP = d.CP
				-- Fin Updates
				insert into ORGANIZACION.CODPOSTAL1(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Bloqreg,Smodifw,Saltafw,Ualtafw,Zadsfw,Umodifw,Valtafw,Hmodifw,Vmodifw,Haltafw,Horaimpo,Bdmodifw,Bdaltafw,Esttrans,Horaexpo,Codigo,Clobs,Cp,Provincia,Localidad,Desde,Hasta)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.BLOQREG,0),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),isnull( d.CODIGO,''),isnull( d.CLOBS,''),isnull( d.CP,''),isnull( d.PROVINCIA,''),isnull( d.LOCALIDAD,''),isnull( d.DESDE,0),isnull( d.HASTA,0)
						From deleted d left join ORGANIZACION.CODPOSTAL1 pk 
							 on d.CP = pk.CP
						Where pk.CP Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_CodPostal1') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_CodPostal1
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CODIGOPOSTAL' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODIGOPOSTAL.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODIGOPOSTAL.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODIGOPOSTAL.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODIGOPOSTAL.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CODIGOPOSTAL.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Bloquearregistro = nvl( c_CODIGOPOSTAL.Bloquearregistro, .F. )
					.Seriemodificacionfw = nvl( c_CODIGOPOSTAL.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_CODIGOPOSTAL.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CODIGOPOSTAL.Usuarioaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_CODIGOPOSTAL.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_CODIGOPOSTAL.Versionaltafw, [] )
					.Horamodificacionfw = nvl( c_CODIGOPOSTAL.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_CODIGOPOSTAL.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_CODIGOPOSTAL.Horaaltafw, [] )
					.Horaimpo = nvl( c_CODIGOPOSTAL.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_CODIGOPOSTAL.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_CODIGOPOSTAL.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_CODIGOPOSTAL.Estadotransferencia, [] )
					.Horaexpo = nvl( c_CODIGOPOSTAL.Horaexpo, [] )
					.Codigo = nvl( c_CODIGOPOSTAL.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Codigopostal = nvl( c_CODIGOPOSTAL.Codigopostal, [] )
					.Provincia_PK =  nvl( c_CODIGOPOSTAL.Provincia, [] )
					.Localidad = nvl( c_CODIGOPOSTAL.Localidad, [] )
					.Desde = nvl( c_CODIGOPOSTAL.Desde, 0 )
					.Hasta = nvl( c_CODIGOPOSTAL.Hasta, 0 )
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
		return c_CODIGOPOSTAL.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.CODPOSTAL1' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CP"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CP as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CP from (
							select * 
								from ORGANIZACION.CODPOSTAL1 
								Where   CODPOSTAL1.CP != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CODPOSTAL1", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CP"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Bloqreg" as "Bloquearregistro", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Codigo" as "Codigo", "Clobs" as "Obs", "Cp" as "Codigopostal", "Provincia" as "Provincia", "Localidad" as "Localidad", "Desde" as "Desde", "Hasta" as "Hasta"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.CODPOSTAL1 
								Where   CODPOSTAL1.CP != ''
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
	Tabla = 'CODPOSTAL1'
	Filtro = " CODPOSTAL1.CP != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CODPOSTAL1.CP != ''"
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
	<row entidad="CODIGOPOSTAL                            " atributo="FECHAEXPO                               " tabla="CODPOSTAL1     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="FECHATRANSFERENCIA                      " tabla="CODPOSTAL1     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="FECHAIMPO                               " tabla="CODPOSTAL1     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="FECHAALTAFW                             " tabla="CODPOSTAL1     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="FECHAMODIFICACIONFW                     " tabla="CODPOSTAL1     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="BLOQUEARREGISTRO                        " tabla="CODPOSTAL1     " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="SERIEMODIFICACIONFW                     " tabla="CODPOSTAL1     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="SERIEALTAFW                             " tabla="CODPOSTAL1     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="USUARIOALTAFW                           " tabla="CODPOSTAL1     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="ZADSFW                                  " tabla="CODPOSTAL1     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="USUARIOMODIFICACIONFW                   " tabla="CODPOSTAL1     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="VERSIONALTAFW                           " tabla="CODPOSTAL1     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="HORAMODIFICACIONFW                      " tabla="CODPOSTAL1     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="VERSIONMODIFICACIONFW                   " tabla="CODPOSTAL1     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="HORAALTAFW                              " tabla="CODPOSTAL1     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="HORAIMPO                                " tabla="CODPOSTAL1     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CODPOSTAL1     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="BASEDEDATOSALTAFW                       " tabla="CODPOSTAL1     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="ESTADOTRANSFERENCIA                     " tabla="CODPOSTAL1     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="HORAEXPO                                " tabla="CODPOSTAL1     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="CODIGO                                  " tabla="CODPOSTAL1     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="OBS                                     " tabla="CODPOSTAL1     " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="CODIGOPOSTAL                            " tabla="CODPOSTAL1     " campo="CP        " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código postal                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="PROVINCIA                               " tabla="CODPOSTAL1     " campo="PROVINCIA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVINCIA                               " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Provincia                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="LOCALIDAD                               " tabla="CODPOSTAL1     " campo="LOCALIDAD " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Localidad/Calle                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="DESDE                                   " tabla="CODPOSTAL1     " campo="DESDE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Desde                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CODIGOPOSTAL                            " atributo="HASTA                                   " tabla="CODPOSTAL1     " campo="HASTA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Hasta                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVINCIA                               " atributo="DESCRIPCION                             " tabla="PROVINCI       " campo="PRV_DES   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVINCI On CODPOSTAL1.PROVINCIA = PROVINCI.PRV_COD And  PROVINCI.PRV_COD != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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