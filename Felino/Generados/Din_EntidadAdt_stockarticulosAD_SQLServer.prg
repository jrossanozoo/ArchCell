
define class Din_EntidadADT_STOCKARTICULOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_STOCKARTICULOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUD024PK'
	cTablaPrincipal = 'ADT_ART'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'SUCURSAL'
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
			local  lxAdt_artFecexpo, lxAdt_artFaltafw, lxAdt_artFecimpo, lxAdt_artFectrans, lxAdt_artAdt_fecha, lxAdt_artFmodifw, lxAdt_artCorig, lxAdt_artAcant, lxAdt_artAdt_ext, lxAdt_artValtafw, lxAdt_artUmodifw, lxAdt_artVmodifw, lxAdt_artHaltafw, lxAdt_artZadsfw, lxAdt_artHoraexpo, lxAdt_artSmodifw, lxAdt_artHmodifw, lxAdt_artUaltafw, lxAdt_artSaltafw, lxAdt_artHoraimpo, lxAdt_artEsttrans, lxAdt_artAdt_usr, lxAdt_artAdt_ent, lxAdt_artAdt_serie, lxAdt_artAdt_comp, lxAdt_artAdt_hora, lxAdt_artAdt_adn, lxAdt_artBdmodifw, lxAdt_artAdt_vers, lxAdt_artBdaltafw, lxAdt_artArtcod, lxAdt_artAdt_cod
				lxAdt_artFecexpo =  .Fechaexpo			lxAdt_artFaltafw =  .Fechaaltafw			lxAdt_artFecimpo =  .Fechaimpo			lxAdt_artFectrans =  .Fechatransferencia			lxAdt_artAdt_fecha =  .Adt_fecha			lxAdt_artFmodifw =  .Fechamodificacionfw			lxAdt_artCorig =  .Cantidadoriginal			lxAdt_artAcant =  .Cantidad			lxAdt_artAdt_ext =  .Adt_ext			lxAdt_artValtafw =  .Versionaltafw			lxAdt_artUmodifw =  .Usuariomodificacionfw			lxAdt_artVmodifw =  .Versionmodificacionfw			lxAdt_artHaltafw =  .Horaaltafw			lxAdt_artZadsfw =  .Zadsfw			lxAdt_artHoraexpo =  .Horaexpo			lxAdt_artSmodifw =  .Seriemodificacionfw			lxAdt_artHmodifw =  .Horamodificacionfw			lxAdt_artUaltafw =  .Usuarioaltafw			lxAdt_artSaltafw =  .Seriealtafw			lxAdt_artHoraimpo =  .Horaimpo			lxAdt_artEsttrans =  .Estadotransferencia			lxAdt_artAdt_usr =  .Adt_usr			lxAdt_artAdt_ent =  .Adt_ent			lxAdt_artAdt_serie =  .Adt_serie			lxAdt_artAdt_comp =  .Adt_comp			lxAdt_artAdt_hora =  .Adt_hora			lxAdt_artAdt_adn =  .Adt_adn			lxAdt_artBdmodifw =  .Basededatosmodificacionfw			lxAdt_artAdt_vers =  .Adt_vers			lxAdt_artBdaltafw =  .Basededatosaltafw			lxAdt_artArtcod =  upper( .Codigo_PK ) 			lxAdt_artAdt_cod =  .Adt_cod
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_artAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_ART ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Adt_fecha","Fmodifw","Corig","Acant","Adt_ext","Valtafw","Umodifw","Vmodifw","Haltafw","Zadsfw","Horaexpo","Smodifw","Hmodifw","Ualtafw","Saltafw","Horaimpo","Esttrans","Adt_usr","Adt_ent","Adt_serie","Adt_comp","Adt_hora","Adt_adn","Bdmodifw","Adt_vers","Bdaltafw","Artcod","Adt_cod" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_artFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFmodifw ) + "'" >>, <<lxAdt_artCorig >>, <<lxAdt_artAcant >>, <<iif( lxAdt_artAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_artValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artArtcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
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
		return this.oEntidad.ADT_COD
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxAdt_artFecexpo, lxAdt_artFaltafw, lxAdt_artFecimpo, lxAdt_artFectrans, lxAdt_artAdt_fecha, lxAdt_artFmodifw, lxAdt_artCorig, lxAdt_artAcant, lxAdt_artAdt_ext, lxAdt_artValtafw, lxAdt_artUmodifw, lxAdt_artVmodifw, lxAdt_artHaltafw, lxAdt_artZadsfw, lxAdt_artHoraexpo, lxAdt_artSmodifw, lxAdt_artHmodifw, lxAdt_artUaltafw, lxAdt_artSaltafw, lxAdt_artHoraimpo, lxAdt_artEsttrans, lxAdt_artAdt_usr, lxAdt_artAdt_ent, lxAdt_artAdt_serie, lxAdt_artAdt_comp, lxAdt_artAdt_hora, lxAdt_artAdt_adn, lxAdt_artBdmodifw, lxAdt_artAdt_vers, lxAdt_artBdaltafw, lxAdt_artArtcod, lxAdt_artAdt_cod
				lxAdt_artFecexpo =  .Fechaexpo			lxAdt_artFaltafw =  .Fechaaltafw			lxAdt_artFecimpo =  .Fechaimpo			lxAdt_artFectrans =  .Fechatransferencia			lxAdt_artAdt_fecha =  .Adt_fecha			lxAdt_artFmodifw =  .Fechamodificacionfw			lxAdt_artCorig =  .Cantidadoriginal			lxAdt_artAcant =  .Cantidad			lxAdt_artAdt_ext =  .Adt_ext			lxAdt_artValtafw =  .Versionaltafw			lxAdt_artUmodifw =  .Usuariomodificacionfw			lxAdt_artVmodifw =  .Versionmodificacionfw			lxAdt_artHaltafw =  .Horaaltafw			lxAdt_artZadsfw =  .Zadsfw			lxAdt_artHoraexpo =  .Horaexpo			lxAdt_artSmodifw =  .Seriemodificacionfw			lxAdt_artHmodifw =  .Horamodificacionfw			lxAdt_artUaltafw =  .Usuarioaltafw			lxAdt_artSaltafw =  .Seriealtafw			lxAdt_artHoraimpo =  .Horaimpo			lxAdt_artEsttrans =  .Estadotransferencia			lxAdt_artAdt_usr =  .Adt_usr			lxAdt_artAdt_ent =  .Adt_ent			lxAdt_artAdt_serie =  .Adt_serie			lxAdt_artAdt_comp =  .Adt_comp			lxAdt_artAdt_hora =  .Adt_hora			lxAdt_artAdt_adn =  .Adt_adn			lxAdt_artBdmodifw =  .Basededatosmodificacionfw			lxAdt_artAdt_vers =  .Adt_vers			lxAdt_artBdaltafw =  .Basededatosaltafw			lxAdt_artArtcod =  upper( .Codigo_PK ) 			lxAdt_artAdt_cod =  .Adt_cod
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_ART set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_artFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_artFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_artFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_artFectrans ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_artAdt_fecha ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_artFmodifw ) + "'">>,"Corig" = <<lxAdt_artCorig>>,"Acant" = <<lxAdt_artAcant>>,"Adt_ext" = <<iif( lxAdt_artAdt_ext, 1, 0 )>>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_artValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artVmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_artHaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_artZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_artHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artHmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_artUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_artSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_artHoraimpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_artEsttrans ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_usr ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_ent ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_serie ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_comp ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_hora ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_adn ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artBdmodifw ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_vers ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_artBdaltafw ) + "'">>,"Artcod" = <<"'" + this.FormatearTextoSql( lxAdt_artArtcod ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'">> and  ADT_ART.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_ART where " + this.ConvertirFuncionesSql( " ADT_ART.ADT_COD != ''" ) )
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
			Local lxAdt_artAdt_cod
			lxAdt_artAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_ART where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'">> and  ADT_ART.ADT_COD != ''
			endtext
			use in select('c_ADT_STOCKARTICULOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKARTICULOS', set( 'Datasession' ) )

			if reccount( 'c_ADT_STOCKARTICULOS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_artAdt_cod as Variant
		llRetorno = .t.
		lxAdt_artAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_ART where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'">> and  ADT_ART.ADT_COD != ''
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_ART where  ADT_ART.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_STOCKARTICULOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKARTICULOS', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_ART where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_ART.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_STOCKARTICULOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKARTICULOS', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_ART where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_ART.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_STOCKARTICULOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKARTICULOS', set( 'Datasession' ) )
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
				lcOrden =   iif( empty( .FECHAALTAFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FECHAALTAFW ) ) + .HORAALTAFW
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_ART where  ADT_ART.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_STOCKARTICULOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKARTICULOS', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Adt_fecha,Fmodifw,Corig,Acant,Adt_ext,Valtafw,Umodifw,Vmodi" + ;
"fw,Haltafw,Zadsfw,Horaexpo,Smodifw,Hmodifw,Ualtafw,Saltafw,Horaimpo,Esttrans,Adt_usr,Adt_ent,Adt_ser" + ;
"ie,Adt_comp,Adt_hora,Adt_adn,Bdmodifw,Adt_vers,Bdaltafw,Artcod,Adt_cod" + ;
" from ZooLogic.ADT_ART where  ADT_ART.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_artFecexpo, lxAdt_artFaltafw, lxAdt_artFecimpo, lxAdt_artFectrans, lxAdt_artAdt_fecha, lxAdt_artFmodifw, lxAdt_artCorig, lxAdt_artAcant, lxAdt_artAdt_ext, lxAdt_artValtafw, lxAdt_artUmodifw, lxAdt_artVmodifw, lxAdt_artHaltafw, lxAdt_artZadsfw, lxAdt_artHoraexpo, lxAdt_artSmodifw, lxAdt_artHmodifw, lxAdt_artUaltafw, lxAdt_artSaltafw, lxAdt_artHoraimpo, lxAdt_artEsttrans, lxAdt_artAdt_usr, lxAdt_artAdt_ent, lxAdt_artAdt_serie, lxAdt_artAdt_comp, lxAdt_artAdt_hora, lxAdt_artAdt_adn, lxAdt_artBdmodifw, lxAdt_artAdt_vers, lxAdt_artBdaltafw, lxAdt_artArtcod, lxAdt_artAdt_cod
				lxAdt_artFecexpo = ctod( '  /  /    ' )			lxAdt_artFaltafw = ctod( '  /  /    ' )			lxAdt_artFecimpo = ctod( '  /  /    ' )			lxAdt_artFectrans = ctod( '  /  /    ' )			lxAdt_artAdt_fecha = ctod( '  /  /    ' )			lxAdt_artFmodifw = ctod( '  /  /    ' )			lxAdt_artCorig = 0			lxAdt_artAcant = 0			lxAdt_artAdt_ext = .F.			lxAdt_artValtafw = []			lxAdt_artUmodifw = []			lxAdt_artVmodifw = []			lxAdt_artHaltafw = []			lxAdt_artZadsfw = []			lxAdt_artHoraexpo = []			lxAdt_artSmodifw = []			lxAdt_artHmodifw = []			lxAdt_artUaltafw = []			lxAdt_artSaltafw = []			lxAdt_artHoraimpo = []			lxAdt_artEsttrans = []			lxAdt_artAdt_usr = []			lxAdt_artAdt_ent = []			lxAdt_artAdt_serie = []			lxAdt_artAdt_comp = []			lxAdt_artAdt_hora = []			lxAdt_artAdt_adn = []			lxAdt_artBdmodifw = []			lxAdt_artAdt_vers = []			lxAdt_artBdaltafw = []			lxAdt_artArtcod = []			lxAdt_artAdt_cod = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_ART where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_ART' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where ADT_Cod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(ADT_Cod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ADT_ART.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_ART', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'CANTIDADORIGINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CORIG AS CANTIDADORIGINAL'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACANT AS CANTIDAD'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTCOD AS CODIGO'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADORIGINAL'
				lcCampo = 'CORIG'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'ACANT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ARTCOD'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
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
			local  lxAdt_artFecexpo, lxAdt_artFaltafw, lxAdt_artFecimpo, lxAdt_artFectrans, lxAdt_artAdt_fecha, lxAdt_artFmodifw, lxAdt_artCorig, lxAdt_artAcant, lxAdt_artAdt_ext, lxAdt_artValtafw, lxAdt_artUmodifw, lxAdt_artVmodifw, lxAdt_artHaltafw, lxAdt_artZadsfw, lxAdt_artHoraexpo, lxAdt_artSmodifw, lxAdt_artHmodifw, lxAdt_artUaltafw, lxAdt_artSaltafw, lxAdt_artHoraimpo, lxAdt_artEsttrans, lxAdt_artAdt_usr, lxAdt_artAdt_ent, lxAdt_artAdt_serie, lxAdt_artAdt_comp, lxAdt_artAdt_hora, lxAdt_artAdt_adn, lxAdt_artBdmodifw, lxAdt_artAdt_vers, lxAdt_artBdaltafw, lxAdt_artArtcod, lxAdt_artAdt_cod
				lxAdt_artFecexpo =  .Fechaexpo			lxAdt_artFaltafw =  .Fechaaltafw			lxAdt_artFecimpo =  .Fechaimpo			lxAdt_artFectrans =  .Fechatransferencia			lxAdt_artAdt_fecha =  .Adt_fecha			lxAdt_artFmodifw =  .Fechamodificacionfw			lxAdt_artCorig =  .Cantidadoriginal			lxAdt_artAcant =  .Cantidad			lxAdt_artAdt_ext =  .Adt_ext			lxAdt_artValtafw =  .Versionaltafw			lxAdt_artUmodifw =  .Usuariomodificacionfw			lxAdt_artVmodifw =  .Versionmodificacionfw			lxAdt_artHaltafw =  .Horaaltafw			lxAdt_artZadsfw =  .Zadsfw			lxAdt_artHoraexpo =  .Horaexpo			lxAdt_artSmodifw =  .Seriemodificacionfw			lxAdt_artHmodifw =  .Horamodificacionfw			lxAdt_artUaltafw =  .Usuarioaltafw			lxAdt_artSaltafw =  .Seriealtafw			lxAdt_artHoraimpo =  .Horaimpo			lxAdt_artEsttrans =  .Estadotransferencia			lxAdt_artAdt_usr =  .Adt_usr			lxAdt_artAdt_ent =  .Adt_ent			lxAdt_artAdt_serie =  .Adt_serie			lxAdt_artAdt_comp =  .Adt_comp			lxAdt_artAdt_hora =  .Adt_hora			lxAdt_artAdt_adn =  .Adt_adn			lxAdt_artBdmodifw =  .Basededatosmodificacionfw			lxAdt_artAdt_vers =  .Adt_vers			lxAdt_artBdaltafw =  .Basededatosaltafw			lxAdt_artArtcod =  upper( .Codigo_PK ) 			lxAdt_artAdt_cod =  .Adt_cod
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_ART ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Adt_fecha","Fmodifw","Corig","Acant","Adt_ext","Valtafw","Umodifw","Vmodifw","Haltafw","Zadsfw","Horaexpo","Smodifw","Hmodifw","Ualtafw","Saltafw","Horaimpo","Esttrans","Adt_usr","Adt_ent","Adt_serie","Adt_comp","Adt_hora","Adt_adn","Bdmodifw","Adt_vers","Bdaltafw","Artcod","Adt_cod" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_artFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_artFmodifw ) + "'" >>, <<lxAdt_artCorig >>, <<lxAdt_artAcant >>, <<iif( lxAdt_artAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_artValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artArtcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_ART' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxAdt_artFecexpo, lxAdt_artFaltafw, lxAdt_artFecimpo, lxAdt_artFectrans, lxAdt_artAdt_fecha, lxAdt_artFmodifw, lxAdt_artCorig, lxAdt_artAcant, lxAdt_artAdt_ext, lxAdt_artValtafw, lxAdt_artUmodifw, lxAdt_artVmodifw, lxAdt_artHaltafw, lxAdt_artZadsfw, lxAdt_artHoraexpo, lxAdt_artSmodifw, lxAdt_artHmodifw, lxAdt_artUaltafw, lxAdt_artSaltafw, lxAdt_artHoraimpo, lxAdt_artEsttrans, lxAdt_artAdt_usr, lxAdt_artAdt_ent, lxAdt_artAdt_serie, lxAdt_artAdt_comp, lxAdt_artAdt_hora, lxAdt_artAdt_adn, lxAdt_artBdmodifw, lxAdt_artAdt_vers, lxAdt_artBdaltafw, lxAdt_artArtcod, lxAdt_artAdt_cod
				lxAdt_artFecexpo =  .Fechaexpo			lxAdt_artFaltafw =  .Fechaaltafw			lxAdt_artFecimpo =  .Fechaimpo			lxAdt_artFectrans =  .Fechatransferencia			lxAdt_artAdt_fecha =  .Adt_fecha			lxAdt_artFmodifw =  .Fechamodificacionfw			lxAdt_artCorig =  .Cantidadoriginal			lxAdt_artAcant =  .Cantidad			lxAdt_artAdt_ext =  .Adt_ext			lxAdt_artValtafw =  .Versionaltafw			lxAdt_artUmodifw =  .Usuariomodificacionfw			lxAdt_artVmodifw =  .Versionmodificacionfw			lxAdt_artHaltafw =  .Horaaltafw			lxAdt_artZadsfw =  .Zadsfw			lxAdt_artHoraexpo =  .Horaexpo			lxAdt_artSmodifw =  .Seriemodificacionfw			lxAdt_artHmodifw =  .Horamodificacionfw			lxAdt_artUaltafw =  .Usuarioaltafw			lxAdt_artSaltafw =  .Seriealtafw			lxAdt_artHoraimpo =  .Horaimpo			lxAdt_artEsttrans =  .Estadotransferencia			lxAdt_artAdt_usr =  .Adt_usr			lxAdt_artAdt_ent =  .Adt_ent			lxAdt_artAdt_serie =  .Adt_serie			lxAdt_artAdt_comp =  .Adt_comp			lxAdt_artAdt_hora =  .Adt_hora			lxAdt_artAdt_adn =  .Adt_adn			lxAdt_artBdmodifw =  .Basededatosmodificacionfw			lxAdt_artAdt_vers =  .Adt_vers			lxAdt_artBdaltafw =  .Basededatosaltafw			lxAdt_artArtcod =  upper( .Codigo_PK ) 			lxAdt_artAdt_cod =  .Adt_cod
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_ART.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_ART set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_artFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_artFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_artFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_artFectrans ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_artAdt_fecha ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_artFmodifw ) + "'">>, "Corig" = <<lxAdt_artCorig>>, "Acant" = <<lxAdt_artAcant>>, "Adt_ext" = <<iif( lxAdt_artAdt_ext, 1, 0 )>>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_artValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artVmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_artHaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_artZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_artHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artHmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_artUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_artSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_artHoraimpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_artEsttrans ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_usr ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_ent ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_serie ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_comp ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_hora ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_adn ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_artBdmodifw ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_vers ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_artBdaltafw ) + "'">>, "Artcod" = <<"'" + this.FormatearTextoSql( lxAdt_artArtcod ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_artAdt_cod ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_ART' 
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
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_ART.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_ART where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_ART' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_ART where  ADT_ART.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_ART where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_ART.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKARTICULOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_ART Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_ART set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, CORIG = ] + transform( &lcCursor..CORIG )+ [, ACANT = ] + transform( &lcCursor..ACANT )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, ARTCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FECTRANS, ADT_Fecha, FMODIFW, CORIG, ACANT, ADT_Ext, VALTAFW, UMODIFW, VMODIFW, HALTAFW, ZADSFW, HORAEXPO, SMODIFW, HMODIFW, UALTAFW, SALTAFW, HORAIMPO, ESTTRANS, ADT_Usr, ADT_Ent, ADT_Serie, ADT_Comp, ADT_Hora, ADT_ADN, BDMODIFW, ADT_Vers, BDALTAFW, ARTCOD, ADT_Cod
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..CORIG )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ACANT ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ARTCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_ART ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKARTICULOS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( ADT_Cod C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..ADT_Cod    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'ADT_STOCKARTICULOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_STOCKARTICULOS_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_ART')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_STOCKARTICULOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_STOCKARTICULOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKARTICULOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,ADT_Cod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( ADT_Cod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKARTICULOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_ART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_ART
Create Table ZooLogic.TablaTrabajo_ADT_ART ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"adt_fecha" datetime  null, 
"fmodifw" datetime  null, 
"corig" numeric( 10, 2 )  null, 
"acant" numeric( 10, 2 )  null, 
"adt_ext" bit  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"adt_usr" char( 100 )  null, 
"adt_ent" char( 40 )  null, 
"adt_serie" char( 20 )  null, 
"adt_comp" char( 254 )  null, 
"adt_hora" char( 8 )  null, 
"adt_adn" char( 10 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_vers" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"artcod" char( 13 )  null, 
"adt_cod" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_ART' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_ART' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKARTICULOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('corig','corig')
			.AgregarMapeo('acant','acant')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('artcod','artcod')
			.AgregarMapeo('adt_cod','adt_cod')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_ART'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.CORIG = isnull( d.CORIG, t.CORIG ),t.ACANT = isnull( d.ACANT, t.ACANT ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ARTCOD = isnull( d.ARTCOD, t.ARTCOD ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD )
					from ZooLogic.ADT_ART t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_ART(Fecexpo,Faltafw,Fecimpo,Fectrans,Adt_fecha,Fmodifw,Corig,Acant,Adt_ext,Valtafw,Umodifw,Vmodifw,Haltafw,Zadsfw,Horaexpo,Smodifw,Hmodifw,Ualtafw,Saltafw,Horaimpo,Esttrans,Adt_usr,Adt_ent,Adt_serie,Adt_comp,Adt_hora,Adt_adn,Bdmodifw,Adt_vers,Bdaltafw,Artcod,Adt_cod)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.ADT_FECHA,''),isnull( d.FMODIFW,''),isnull( d.CORIG,0),isnull( d.ACANT,0),isnull( d.ADT_EXT,0),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.ESTTRANS,''),isnull( d.ADT_USR,''),isnull( d.ADT_ENT,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_COMP,''),isnull( d.ADT_HORA,''),isnull( d.ADT_ADN,''),isnull( d.BDMODIFW,''),isnull( d.ADT_VERS,''),isnull( d.BDALTAFW,''),isnull( d.ARTCOD,''),isnull( d.ADT_COD,'')
						From deleted d left join ZooLogic.ADT_ART pk 
							 on d.ADT_Cod = pk.ADT_Cod
						Where pk.ADT_Cod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_ART') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_ART
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_STOCKARTICULOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKARTICULOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKARTICULOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKARTICULOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKARTICULOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKARTICULOS.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKARTICULOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Cantidadoriginal = nvl( c_ADT_STOCKARTICULOS.Cantidadoriginal, 0 )
					.Cantidad = nvl( c_ADT_STOCKARTICULOS.Cantidad, 0 )
					.Adt_ext = nvl( c_ADT_STOCKARTICULOS.Adt_ext, .F. )
					.Versionaltafw = nvl( c_ADT_STOCKARTICULOS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_STOCKARTICULOS.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ADT_STOCKARTICULOS.Versionmodificacionfw, [] )
					.Horaaltafw = nvl( c_ADT_STOCKARTICULOS.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_ADT_STOCKARTICULOS.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_ADT_STOCKARTICULOS.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ADT_STOCKARTICULOS.Horamodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ADT_STOCKARTICULOS.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_ADT_STOCKARTICULOS.Seriealtafw, [] )
					.Horaimpo = nvl( c_ADT_STOCKARTICULOS.Horaimpo, [] )
					.Estadotransferencia = nvl( c_ADT_STOCKARTICULOS.Estadotransferencia, [] )
					.Adt_usr = nvl( c_ADT_STOCKARTICULOS.Adt_usr, [] )
					.Adt_ent = nvl( c_ADT_STOCKARTICULOS.Adt_ent, [] )
					.Adt_serie = nvl( c_ADT_STOCKARTICULOS.Adt_serie, [] )
					.Adt_comp = nvl( c_ADT_STOCKARTICULOS.Adt_comp, [] )
					.Adt_hora = nvl( c_ADT_STOCKARTICULOS.Adt_hora, [] )
					.Adt_adn = nvl( c_ADT_STOCKARTICULOS.Adt_adn, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_STOCKARTICULOS.Basededatosmodificacionfw, [] )
					.Adt_vers = nvl( c_ADT_STOCKARTICULOS.Adt_vers, [] )
					.Basededatosaltafw = nvl( c_ADT_STOCKARTICULOS.Basededatosaltafw, [] )
					.Codigo_PK =  nvl( c_ADT_STOCKARTICULOS.Codigo, [] )
					.Adt_cod = nvl( c_ADT_STOCKARTICULOS.Adt_cod, [] )
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
		return c_ADT_STOCKARTICULOS.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_ART' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ADT_Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,ADT_Cod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    ADT_Cod from (
							select * 
								from ZooLogic.ADT_ART 
								Where   ADT_ART.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_ART", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "ADT_Cod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Adt_fecha" as "Adt_fecha", "Fmodifw" as "Fechamodificacionfw", "Corig" as "Cantidadoriginal", "Acant" as "Cantidad", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Esttrans" as "Estadotransferencia", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_adn" as "Adt_adn", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_vers" as "Adt_vers", "Bdaltafw" as "Basededatosaltafw", "Artcod" as "Codigo", "Adt_cod" as "Adt_cod"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_ART 
								Where   ADT_ART.ADT_COD != ''
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
	Tabla = 'ADT_ART'
	Filtro = " ADT_ART.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_ART.ADT_COD != ''"
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
	<row entidad="ADT_STOCKARTICULOS                      " atributo="FECHAEXPO                               " tabla="ADT_ART        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="FECHAALTAFW                             " tabla="ADT_ART        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="FECHAIMPO                               " tabla="ADT_ART        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="FECHATRANSFERENCIA                      " tabla="ADT_ART        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_FECHA                               " tabla="ADT_ART        " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_ART        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="CANTIDADORIGINAL                        " tabla="ADT_ART        " campo="CORIG     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Stock Original                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="CANTIDAD                                " tabla="ADT_ART        " campo="ACANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Cant. en Stock                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_EXT                                 " tabla="ADT_ART        " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="VERSIONALTAFW                           " tabla="ADT_ART        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_ART        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_ART        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="HORAALTAFW                              " tabla="ADT_ART        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ZADSFW                                  " tabla="ADT_ART        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="HORAEXPO                                " tabla="ADT_ART        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_ART        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="HORAMODIFICACIONFW                      " tabla="ADT_ART        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="USUARIOALTAFW                           " tabla="ADT_ART        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="SERIEALTAFW                             " tabla="ADT_ART        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="HORAIMPO                                " tabla="ADT_ART        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_ART        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_USR                                 " tabla="ADT_ART        " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_ENT                                 " tabla="ADT_ART        " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_SERIE                               " tabla="ADT_ART        " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_COMP                                " tabla="ADT_ART        " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_HORA                                " tabla="ADT_ART        " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_ADN                                 " tabla="ADT_ART        " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_ART        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_VERS                                " tabla="ADT_ART        " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_ART        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="CODIGO                                  " tabla="ADT_ART        " campo="ARTCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="STOCKARTICULOS                          " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Stock de artículos                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKARTICULOS                      " atributo="ADT_COD                                 " tabla="ADT_ART        " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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