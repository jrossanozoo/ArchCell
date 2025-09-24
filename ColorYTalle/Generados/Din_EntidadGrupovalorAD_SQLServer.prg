
define class Din_EntidadGRUPOVALORAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_GRUPOVALOR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_GPVPK'
	cTablaPrincipal = 'GRUPOVALOR'
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
			local  lxGrupovalorFecimpo, lxGrupovalorFectrans, lxGrupovalorFmodifw, lxGrupovalorFecexpo, lxGrupovalorFaltafw, lxGrupovalorSmodifw, lxGrupovalorSaltafw, lxGrupovalorZadsfw, lxGrupovalorValtafw, lxGrupovalorVmodifw, lxGrupovalorHmodifw, lxGrupovalorUmodifw, lxGrupovalorUaltafw, lxGrupovalorHoraexpo, lxGrupovalorBdmodifw, lxGrupovalorHoraimpo, lxGrupovalorBdaltafw, lxGrupovalorEsttrans, lxGrupovalorHaltafw, lxGrupovalorTipagrupub, lxGrupovalorTimestamp, lxGrupovalorGobs, lxGrupovalorCodigo, lxGrupovalorGrunom
				lxGrupovalorFecimpo =  .Fechaimpo			lxGrupovalorFectrans =  .Fechatransferencia			lxGrupovalorFmodifw =  .Fechamodificacionfw			lxGrupovalorFecexpo =  .Fechaexpo			lxGrupovalorFaltafw =  .Fechaaltafw			lxGrupovalorSmodifw =  .Seriemodificacionfw			lxGrupovalorSaltafw =  .Seriealtafw			lxGrupovalorZadsfw =  .Zadsfw			lxGrupovalorValtafw =  .Versionaltafw			lxGrupovalorVmodifw =  .Versionmodificacionfw			lxGrupovalorHmodifw =  .Horamodificacionfw			lxGrupovalorUmodifw =  .Usuariomodificacionfw			lxGrupovalorUaltafw =  .Usuarioaltafw			lxGrupovalorHoraexpo =  .Horaexpo			lxGrupovalorBdmodifw =  .Basededatosmodificacionfw			lxGrupovalorHoraimpo =  .Horaimpo			lxGrupovalorBdaltafw =  .Basededatosaltafw			lxGrupovalorEsttrans =  .Estadotransferencia			lxGrupovalorHaltafw =  .Horaaltafw			lxGrupovalorTipagrupub =  .Tipoagrupamientopublicaciones			lxGrupovalorTimestamp = goLibrerias.ObtenerTimestamp()			lxGrupovalorGobs =  .Observ			lxGrupovalorCodigo =  .Codigo			lxGrupovalorGrunom =  .Descripcion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxGrupovalorCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.GRUPOVALOR ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Smodifw","Saltafw","Zadsfw","Valtafw","Vmodifw","Hmodifw","Umodifw","Ualtafw","Horaexpo","Bdmodifw","Horaimpo","Bdaltafw","Esttrans","Haltafw","Tipagrupub","Timestamp","Gobs","Codigo","Grunom" ) values ( <<"'" + this.ConvertirDateSql( lxGrupovalorFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHaltafw ) + "'" >>, <<lxGrupovalorTipagrupub >>, <<lxGrupovalorTimestamp >>, <<"'" + this.FormatearTextoSql( lxGrupovalorGobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorGrunom ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubGPV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
		this.oEntidad.Timestamp = lxGrupovalorTimestamp
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
			local  lxGrupovalorFecimpo, lxGrupovalorFectrans, lxGrupovalorFmodifw, lxGrupovalorFecexpo, lxGrupovalorFaltafw, lxGrupovalorSmodifw, lxGrupovalorSaltafw, lxGrupovalorZadsfw, lxGrupovalorValtafw, lxGrupovalorVmodifw, lxGrupovalorHmodifw, lxGrupovalorUmodifw, lxGrupovalorUaltafw, lxGrupovalorHoraexpo, lxGrupovalorBdmodifw, lxGrupovalorHoraimpo, lxGrupovalorBdaltafw, lxGrupovalorEsttrans, lxGrupovalorHaltafw, lxGrupovalorTipagrupub, lxGrupovalorTimestamp, lxGrupovalorGobs, lxGrupovalorCodigo, lxGrupovalorGrunom
				lxGrupovalorFecimpo =  .Fechaimpo			lxGrupovalorFectrans =  .Fechatransferencia			lxGrupovalorFmodifw =  .Fechamodificacionfw			lxGrupovalorFecexpo =  .Fechaexpo			lxGrupovalorFaltafw =  .Fechaaltafw			lxGrupovalorSmodifw =  .Seriemodificacionfw			lxGrupovalorSaltafw =  .Seriealtafw			lxGrupovalorZadsfw =  .Zadsfw			lxGrupovalorValtafw =  .Versionaltafw			lxGrupovalorVmodifw =  .Versionmodificacionfw			lxGrupovalorHmodifw =  .Horamodificacionfw			lxGrupovalorUmodifw =  .Usuariomodificacionfw			lxGrupovalorUaltafw =  .Usuarioaltafw			lxGrupovalorHoraexpo =  .Horaexpo			lxGrupovalorBdmodifw =  .Basededatosmodificacionfw			lxGrupovalorHoraimpo =  .Horaimpo			lxGrupovalorBdaltafw =  .Basededatosaltafw			lxGrupovalorEsttrans =  .Estadotransferencia			lxGrupovalorHaltafw =  .Horaaltafw			lxGrupovalorTipagrupub =  .Tipoagrupamientopublicaciones			lxGrupovalorTimestamp = goLibrerias.ObtenerTimestamp()			lxGrupovalorGobs =  .Observ			lxGrupovalorCodigo =  .Codigo			lxGrupovalorGrunom =  .Descripcion
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
				update ZooLogic.GRUPOVALOR set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxGrupovalorFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxGrupovalorFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxGrupovalorFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxGrupovalorFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxGrupovalorFaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxGrupovalorZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorVmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorUaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxGrupovalorHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxGrupovalorHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxGrupovalorEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorHaltafw ) + "'">>,"Tipagrupub" = <<lxGrupovalorTipagrupub>>,"Timestamp" = <<lxGrupovalorTimestamp>>,"Gobs" = <<"'" + this.FormatearTextoSql( lxGrupovalorGobs ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'">>,"Grunom" = <<"'" + this.FormatearTextoSql( lxGrupovalorGrunom ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'">> and  GRUPOVALOR.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubGPV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubGPV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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
		this.oEntidad.Timestamp = lxGrupovalorTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.GRUPOVALOR where " + this.ConvertirFuncionesSql( " GRUPOVALOR.CODIGO != ''" ) )
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
			Local lxGrupovalorCodigo
			lxGrupovalorCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion" from ZooLogic.GRUPOVALOR where "Codigo" = <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'">> and  GRUPOVALOR.CODIGO != ''
			endtext
			use in select('c_GRUPOVALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GRUPOVALOR', set( 'Datasession' ) )

			if reccount( 'c_GRUPOVALOR' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubGPV where Codigo = <<"'" + this.FormatearTextoSql( c_GRUPOVALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxGrupovalorCodigo as Variant
		llRetorno = .t.
		lxGrupovalorCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.GRUPOVALOR where "Codigo" = <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'">> and  GRUPOVALOR.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion" from ZooLogic.GRUPOVALOR where  GRUPOVALOR.CODIGO != '' order by Codigo
			endtext
			use in select('c_GRUPOVALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GRUPOVALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubGPV where Codigo = <<"'" + this.FormatearTextoSql( c_GRUPOVALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion" from ZooLogic.GRUPOVALOR where  funciones.padr( Codigo, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  GRUPOVALOR.CODIGO != '' order by Codigo
			endtext
			use in select('c_GRUPOVALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GRUPOVALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubGPV where Codigo = <<"'" + this.FormatearTextoSql( c_GRUPOVALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion" from ZooLogic.GRUPOVALOR where  funciones.padr( Codigo, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  GRUPOVALOR.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_GRUPOVALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GRUPOVALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubGPV where Codigo = <<"'" + this.FormatearTextoSql( c_GRUPOVALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion" from ZooLogic.GRUPOVALOR where  GRUPOVALOR.CODIGO != '' order by Codigo desc
			endtext
			use in select('c_GRUPOVALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GRUPOVALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubGPV where Codigo = <<"'" + this.FormatearTextoSql( c_GRUPOVALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Smodifw,Saltafw,Zadsfw,Valtafw,Vmodifw,Hmodifw,Umod" + ;
"ifw,Ualtafw,Horaexpo,Bdmodifw,Horaimpo,Bdaltafw,Esttrans,Haltafw,Tipagrupub,Timestamp,Gobs,Codigo,Gr" + ;
"unom" + ;
" from ZooLogic.GRUPOVALOR where  GRUPOVALOR.CODIGO != '' and " + lcFiltro )
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
			local  lxGrupovalorFecimpo, lxGrupovalorFectrans, lxGrupovalorFmodifw, lxGrupovalorFecexpo, lxGrupovalorFaltafw, lxGrupovalorSmodifw, lxGrupovalorSaltafw, lxGrupovalorZadsfw, lxGrupovalorValtafw, lxGrupovalorVmodifw, lxGrupovalorHmodifw, lxGrupovalorUmodifw, lxGrupovalorUaltafw, lxGrupovalorHoraexpo, lxGrupovalorBdmodifw, lxGrupovalorHoraimpo, lxGrupovalorBdaltafw, lxGrupovalorEsttrans, lxGrupovalorHaltafw, lxGrupovalorTipagrupub, lxGrupovalorTimestamp, lxGrupovalorGobs, lxGrupovalorCodigo, lxGrupovalorGrunom
				lxGrupovalorFecimpo = ctod( '  /  /    ' )			lxGrupovalorFectrans = ctod( '  /  /    ' )			lxGrupovalorFmodifw = ctod( '  /  /    ' )			lxGrupovalorFecexpo = ctod( '  /  /    ' )			lxGrupovalorFaltafw = ctod( '  /  /    ' )			lxGrupovalorSmodifw = []			lxGrupovalorSaltafw = []			lxGrupovalorZadsfw = []			lxGrupovalorValtafw = []			lxGrupovalorVmodifw = []			lxGrupovalorHmodifw = []			lxGrupovalorUmodifw = []			lxGrupovalorUaltafw = []			lxGrupovalorHoraexpo = []			lxGrupovalorBdmodifw = []			lxGrupovalorHoraimpo = []			lxGrupovalorBdaltafw = []			lxGrupovalorEsttrans = []			lxGrupovalorHaltafw = []			lxGrupovalorTipagrupub = 0			lxGrupovalorTimestamp = goLibrerias.ObtenerTimestamp()			lxGrupovalorGobs = []			lxGrupovalorCodigo = []			lxGrupovalorGrunom = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubGPV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.GRUPOVALOR where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'GRUPOVALOR' + '_' + tcCampo
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
		lcWhere = " Where  GRUPOVALOR.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GRUPOVALOR', '', tnTope )
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
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBGPV.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubGPV', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'OBSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GOBS AS OBSERV'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUNOM AS DESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERV'
				lcCampo = 'GOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'GRUNOM'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBGPV'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxGrupovalorFecimpo, lxGrupovalorFectrans, lxGrupovalorFmodifw, lxGrupovalorFecexpo, lxGrupovalorFaltafw, lxGrupovalorSmodifw, lxGrupovalorSaltafw, lxGrupovalorZadsfw, lxGrupovalorValtafw, lxGrupovalorVmodifw, lxGrupovalorHmodifw, lxGrupovalorUmodifw, lxGrupovalorUaltafw, lxGrupovalorHoraexpo, lxGrupovalorBdmodifw, lxGrupovalorHoraimpo, lxGrupovalorBdaltafw, lxGrupovalorEsttrans, lxGrupovalorHaltafw, lxGrupovalorTipagrupub, lxGrupovalorTimestamp, lxGrupovalorGobs, lxGrupovalorCodigo, lxGrupovalorGrunom
				lxGrupovalorFecimpo =  .Fechaimpo			lxGrupovalorFectrans =  .Fechatransferencia			lxGrupovalorFmodifw =  .Fechamodificacionfw			lxGrupovalorFecexpo =  .Fechaexpo			lxGrupovalorFaltafw =  .Fechaaltafw			lxGrupovalorSmodifw =  .Seriemodificacionfw			lxGrupovalorSaltafw =  .Seriealtafw			lxGrupovalorZadsfw =  .Zadsfw			lxGrupovalorValtafw =  .Versionaltafw			lxGrupovalorVmodifw =  .Versionmodificacionfw			lxGrupovalorHmodifw =  .Horamodificacionfw			lxGrupovalorUmodifw =  .Usuariomodificacionfw			lxGrupovalorUaltafw =  .Usuarioaltafw			lxGrupovalorHoraexpo =  .Horaexpo			lxGrupovalorBdmodifw =  .Basededatosmodificacionfw			lxGrupovalorHoraimpo =  .Horaimpo			lxGrupovalorBdaltafw =  .Basededatosaltafw			lxGrupovalorEsttrans =  .Estadotransferencia			lxGrupovalorHaltafw =  .Horaaltafw			lxGrupovalorTipagrupub =  .Tipoagrupamientopublicaciones			lxGrupovalorTimestamp = goLibrerias.ObtenerTimestamp()			lxGrupovalorGobs =  .Observ			lxGrupovalorCodigo =  .Codigo			lxGrupovalorGrunom =  .Descripcion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.GRUPOVALOR ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Smodifw","Saltafw","Zadsfw","Valtafw","Vmodifw","Hmodifw","Umodifw","Ualtafw","Horaexpo","Bdmodifw","Horaimpo","Bdaltafw","Esttrans","Haltafw","Tipagrupub","Timestamp","Gobs","Codigo","Grunom" ) values ( <<"'" + this.ConvertirDateSql( lxGrupovalorFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGrupovalorFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorHaltafw ) + "'" >>, <<lxGrupovalorTipagrupub >>, <<lxGrupovalorTimestamp >>, <<"'" + this.FormatearTextoSql( lxGrupovalorGobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGrupovalorGrunom ) + "'" >> )
		endtext
		loColeccion.cTabla = 'GRUPOVALOR' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubGPV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxGrupovalorFecimpo, lxGrupovalorFectrans, lxGrupovalorFmodifw, lxGrupovalorFecexpo, lxGrupovalorFaltafw, lxGrupovalorSmodifw, lxGrupovalorSaltafw, lxGrupovalorZadsfw, lxGrupovalorValtafw, lxGrupovalorVmodifw, lxGrupovalorHmodifw, lxGrupovalorUmodifw, lxGrupovalorUaltafw, lxGrupovalorHoraexpo, lxGrupovalorBdmodifw, lxGrupovalorHoraimpo, lxGrupovalorBdaltafw, lxGrupovalorEsttrans, lxGrupovalorHaltafw, lxGrupovalorTipagrupub, lxGrupovalorTimestamp, lxGrupovalorGobs, lxGrupovalorCodigo, lxGrupovalorGrunom
				lxGrupovalorFecimpo =  .Fechaimpo			lxGrupovalorFectrans =  .Fechatransferencia			lxGrupovalorFmodifw =  .Fechamodificacionfw			lxGrupovalorFecexpo =  .Fechaexpo			lxGrupovalorFaltafw =  .Fechaaltafw			lxGrupovalorSmodifw =  .Seriemodificacionfw			lxGrupovalorSaltafw =  .Seriealtafw			lxGrupovalorZadsfw =  .Zadsfw			lxGrupovalorValtafw =  .Versionaltafw			lxGrupovalorVmodifw =  .Versionmodificacionfw			lxGrupovalorHmodifw =  .Horamodificacionfw			lxGrupovalorUmodifw =  .Usuariomodificacionfw			lxGrupovalorUaltafw =  .Usuarioaltafw			lxGrupovalorHoraexpo =  .Horaexpo			lxGrupovalorBdmodifw =  .Basededatosmodificacionfw			lxGrupovalorHoraimpo =  .Horaimpo			lxGrupovalorBdaltafw =  .Basededatosaltafw			lxGrupovalorEsttrans =  .Estadotransferencia			lxGrupovalorHaltafw =  .Horaaltafw			lxGrupovalorTipagrupub =  .Tipoagrupamientopublicaciones			lxGrupovalorTimestamp = goLibrerias.ObtenerTimestamp()			lxGrupovalorGobs =  .Observ			lxGrupovalorCodigo =  .Codigo			lxGrupovalorGrunom =  .Descripcion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  GRUPOVALOR.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.GRUPOVALOR set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxGrupovalorFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxGrupovalorFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxGrupovalorFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxGrupovalorFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxGrupovalorFaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxGrupovalorZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorVmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorUaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxGrupovalorHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxGrupovalorBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxGrupovalorHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxGrupovalorEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxGrupovalorHaltafw ) + "'">>, "Tipagrupub" = <<lxGrupovalorTipagrupub>>, "Timestamp" = <<lxGrupovalorTimestamp>>, "Gobs" = <<"'" + this.FormatearTextoSql( lxGrupovalorGobs ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxGrupovalorCodigo ) + "'">>, "Grunom" = <<"'" + this.FormatearTextoSql( lxGrupovalorGrunom ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'GRUPOVALOR' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.AgruPubGPV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubGPV("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  GRUPOVALOR.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.GRUPOVALOR where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.AgruPubGPV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'GRUPOVALOR' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.GRUPOVALOR where  GRUPOVALOR.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.GRUPOVALOR where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  GRUPOVALOR.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'GRUPOVALOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.GRUPOVALOR Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.GRUPOVALOR set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, GObs = ] + "'" + this.FormatearTextoSql( &lcCursor..GObs ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, GRUNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..GRUNOM ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, SMODIFW, SALTAFW, ZADSFW, VALTAFW, VMODIFW, HMODIFW, UMODIFW, UALTAFW, HORAEXPO, BDMODIFW, HORAIMPO, BDALTAFW, ESTTRANS, HALTAFW, tipagrupub, TIMESTAMP, GObs, Codigo, GRUNOM
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..GObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GRUNOM ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.GRUPOVALOR ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'GRUPOVALOR'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'Codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','Codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubGPV Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICGPV'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubGPV ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (5) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'GRUPOVALOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'GRUPOVALOR_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'GRUPOVALOR_GOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICGPV'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_GRUPOVALOR')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'GRUPOVALOR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad GRUPOVALOR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'GRUPOVALOR'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'GRUPOVALOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_GRUPOVALOR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_GRUPOVALOR
Create Table ZooLogic.TablaTrabajo_GRUPOVALOR ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"gobs" varchar(max)  null, 
"codigo" char( 5 )  null, 
"grunom" char( 50 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_GRUPOVALOR' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_GRUPOVALOR' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'GRUPOVALOR'
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
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('gobs','gobs')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('grunom','grunom')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_GRUPOVALOR'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.GOBS = isnull( d.GOBS, t.GOBS ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.GRUNOM = isnull( d.GRUNOM, t.GRUNOM )
					from ZooLogic.GRUPOVALOR t inner join deleted d 
							 on t.Codigo = d.Codigo
				-- Fin Updates
				insert into ZooLogic.GRUPOVALOR(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Smodifw,Saltafw,Zadsfw,Valtafw,Vmodifw,Hmodifw,Umodifw,Ualtafw,Horaexpo,Bdmodifw,Horaimpo,Bdaltafw,Esttrans,Haltafw,Tipagrupub,Timestamp,Gobs,Codigo,Grunom)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.TIPAGRUPUB,0),isnull( d.TIMESTAMP,0),isnull( d.GOBS,''),isnull( d.CODIGO,''),isnull( d.GRUNOM,'')
						From deleted d left join ZooLogic.GRUPOVALOR pk 
							 on d.Codigo = pk.Codigo
						Where pk.Codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubGPV( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_GRUPOVALOR_AgruPubGPV
ON ZooLogic.TablaTrabajo_GRUPOVALOR_AgruPubGPV
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubGPV t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubGPV
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPubGPV pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_GRUPOVALOR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_GRUPOVALOR
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_GRUPOVALOR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_GRUPOVALOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_GRUPOVALOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_GRUPOVALOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_GRUPOVALOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_GRUPOVALOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_GRUPOVALOR.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_GRUPOVALOR.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_GRUPOVALOR.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_GRUPOVALOR.Versionmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_GRUPOVALOR.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_GRUPOVALOR.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_GRUPOVALOR.Usuarioaltafw, [] )
					.Horaexpo = nvl( c_GRUPOVALOR.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_GRUPOVALOR.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_GRUPOVALOR.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_GRUPOVALOR.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_GRUPOVALOR.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_GRUPOVALOR.Horaaltafw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_GRUPOVALOR.Tipoagrupamientopublicaciones, 0 )
					.Timestamp = nvl( c_GRUPOVALOR.Timestamp, 0 )
					lcValor = This.ObtenerMemo( 'c_Observ')
					.Observ = lcValor 
					.Codigo = nvl( c_GRUPOVALOR.Codigo, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Descripcion = nvl( c_GRUPOVALOR.Descripcion, [] )
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
		
		loDetalle = this.oEntidad.AgruPubliDetalle
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_GRUPOVALOR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.GRUPOVALOR' )
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
								from ZooLogic.GRUPOVALOR 
								Where   GRUPOVALOR.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "GRUPOVALOR", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Gobs" as "Observ", "Codigo" as "Codigo", "Grunom" as "Descripcion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.GRUPOVALOR 
								Where   GRUPOVALOR.CODIGO != ''
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
	Tabla = 'GRUPOVALOR'
	Filtro = " GRUPOVALOR.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " GRUPOVALOR.CODIGO != ''"
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
	<row entidad="GRUPOVALOR                              " atributo="FECHAIMPO                               " tabla="GRUPOVALOR     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="FECHATRANSFERENCIA                      " tabla="GRUPOVALOR     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="FECHAMODIFICACIONFW                     " tabla="GRUPOVALOR     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="FECHAEXPO                               " tabla="GRUPOVALOR     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="FECHAALTAFW                             " tabla="GRUPOVALOR     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="SERIEMODIFICACIONFW                     " tabla="GRUPOVALOR     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="SERIEALTAFW                             " tabla="GRUPOVALOR     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="ZADSFW                                  " tabla="GRUPOVALOR     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="VERSIONALTAFW                           " tabla="GRUPOVALOR     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="VERSIONMODIFICACIONFW                   " tabla="GRUPOVALOR     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="HORAMODIFICACIONFW                      " tabla="GRUPOVALOR     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="USUARIOMODIFICACIONFW                   " tabla="GRUPOVALOR     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="USUARIOALTAFW                           " tabla="GRUPOVALOR     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="HORAEXPO                                " tabla="GRUPOVALOR     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="GRUPOVALOR     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="HORAIMPO                                " tabla="GRUPOVALOR     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="BASEDEDATOSALTAFW                       " tabla="GRUPOVALOR     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="ESTADOTRANSFERENCIA                     " tabla="GRUPOVALOR     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="HORAALTAFW                              " tabla="GRUPOVALOR     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="GRUPOVALOR     " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="TIMESTAMP                               " tabla="GRUPOVALOR     " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="OBSERV                                  " tabla="GRUPOVALOR     " campo="GOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="CODIGO                                  " tabla="GRUPOVALOR     " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBGPV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICGPV    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="DESCRIPCION                             " tabla="GRUPOVALOR     " campo="GRUNOM    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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