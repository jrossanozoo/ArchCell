
define class Din_EntidadADT_VENDEDORAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_VENDEDOR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUDVENPK'
	cTablaPrincipal = 'ADT_VEN'
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
			local  lxAdt_venFectrans, lxAdt_venFecexpo, lxAdt_venFmodifw, lxAdt_venFecimpo, lxAdt_venAdt_fecha, lxAdt_venFaltafw, lxAdt_venHaltafw, lxAdt_venHoraexpo, lxAdt_venHoraimpo, lxAdt_venSaltafw, lxAdt_venVmodifw, lxAdt_venZadsfw, lxAdt_venValtafw, lxAdt_venUmodifw, lxAdt_venSmodifw, lxAdt_venUaltafw, lxAdt_venHmodifw, lxAdt_venEsttrans, lxAdt_venAdt_ent, lxAdt_venAdt_adn, lxAdt_venAdt_vers, lxAdt_venAdt_usr, lxAdt_venAdt_serie, lxAdt_venBdmodifw, lxAdt_venAdt_hora, lxAdt_venBdaltafw, lxAdt_venAdt_comp, lxAdt_venAdt_ext, lxAdt_venInactivofw, lxAdt_venClcod, lxAdt_venClas, lxAdt_venAdt_cod
				lxAdt_venFectrans =  .Fechatransferencia			lxAdt_venFecexpo =  .Fechaexpo			lxAdt_venFmodifw =  .Fechamodificacionfw			lxAdt_venFecimpo =  .Fechaimpo			lxAdt_venAdt_fecha =  .Adt_fecha			lxAdt_venFaltafw =  .Fechaaltafw			lxAdt_venHaltafw =  .Horaaltafw			lxAdt_venHoraexpo =  .Horaexpo			lxAdt_venHoraimpo =  .Horaimpo			lxAdt_venSaltafw =  .Seriealtafw			lxAdt_venVmodifw =  .Versionmodificacionfw			lxAdt_venZadsfw =  .Zadsfw			lxAdt_venValtafw =  .Versionaltafw			lxAdt_venUmodifw =  .Usuariomodificacionfw			lxAdt_venSmodifw =  .Seriemodificacionfw			lxAdt_venUaltafw =  .Usuarioaltafw			lxAdt_venHmodifw =  .Horamodificacionfw			lxAdt_venEsttrans =  .Estadotransferencia			lxAdt_venAdt_ent =  .Adt_ent			lxAdt_venAdt_adn =  .Adt_adn			lxAdt_venAdt_vers =  .Adt_vers			lxAdt_venAdt_usr =  .Adt_usr			lxAdt_venAdt_serie =  .Adt_serie			lxAdt_venBdmodifw =  .Basededatosmodificacionfw			lxAdt_venAdt_hora =  .Adt_hora			lxAdt_venBdaltafw =  .Basededatosaltafw			lxAdt_venAdt_comp =  .Adt_comp			lxAdt_venAdt_ext =  .Adt_ext			lxAdt_venInactivofw =  .Inactivofw			lxAdt_venClcod =  upper( .Codigo_PK ) 			lxAdt_venClas =  upper( .Clasificacion_PK ) 			lxAdt_venAdt_cod =  .Adt_cod
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_venAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_VEN ( "Fectrans","Fecexpo","Fmodifw","Fecimpo","Adt_fecha","Faltafw","Haltafw","Horaexpo","Horaimpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Adt_ent","Adt_adn","Adt_vers","Adt_usr","Adt_serie","Bdmodifw","Adt_hora","Bdaltafw","Adt_comp","Adt_ext","Inactivofw","Clcod","Clas","Adt_cod" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_venFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_comp ) + "'" >>, <<iif( lxAdt_venAdt_ext, 1, 0 ) >>, <<iif( lxAdt_venInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_venClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venClas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'" >> )
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
			local  lxAdt_venFectrans, lxAdt_venFecexpo, lxAdt_venFmodifw, lxAdt_venFecimpo, lxAdt_venAdt_fecha, lxAdt_venFaltafw, lxAdt_venHaltafw, lxAdt_venHoraexpo, lxAdt_venHoraimpo, lxAdt_venSaltafw, lxAdt_venVmodifw, lxAdt_venZadsfw, lxAdt_venValtafw, lxAdt_venUmodifw, lxAdt_venSmodifw, lxAdt_venUaltafw, lxAdt_venHmodifw, lxAdt_venEsttrans, lxAdt_venAdt_ent, lxAdt_venAdt_adn, lxAdt_venAdt_vers, lxAdt_venAdt_usr, lxAdt_venAdt_serie, lxAdt_venBdmodifw, lxAdt_venAdt_hora, lxAdt_venBdaltafw, lxAdt_venAdt_comp, lxAdt_venAdt_ext, lxAdt_venInactivofw, lxAdt_venClcod, lxAdt_venClas, lxAdt_venAdt_cod
				lxAdt_venFectrans =  .Fechatransferencia			lxAdt_venFecexpo =  .Fechaexpo			lxAdt_venFmodifw =  .Fechamodificacionfw			lxAdt_venFecimpo =  .Fechaimpo			lxAdt_venAdt_fecha =  .Adt_fecha			lxAdt_venFaltafw =  .Fechaaltafw			lxAdt_venHaltafw =  .Horaaltafw			lxAdt_venHoraexpo =  .Horaexpo			lxAdt_venHoraimpo =  .Horaimpo			lxAdt_venSaltafw =  .Seriealtafw			lxAdt_venVmodifw =  .Versionmodificacionfw			lxAdt_venZadsfw =  .Zadsfw			lxAdt_venValtafw =  .Versionaltafw			lxAdt_venUmodifw =  .Usuariomodificacionfw			lxAdt_venSmodifw =  .Seriemodificacionfw			lxAdt_venUaltafw =  .Usuarioaltafw			lxAdt_venHmodifw =  .Horamodificacionfw			lxAdt_venEsttrans =  .Estadotransferencia			lxAdt_venAdt_ent =  .Adt_ent			lxAdt_venAdt_adn =  .Adt_adn			lxAdt_venAdt_vers =  .Adt_vers			lxAdt_venAdt_usr =  .Adt_usr			lxAdt_venAdt_serie =  .Adt_serie			lxAdt_venBdmodifw =  .Basededatosmodificacionfw			lxAdt_venAdt_hora =  .Adt_hora			lxAdt_venBdaltafw =  .Basededatosaltafw			lxAdt_venAdt_comp =  .Adt_comp			lxAdt_venAdt_ext =  .Adt_ext			lxAdt_venInactivofw =  .Inactivofw			lxAdt_venClcod =  upper( .Codigo_PK ) 			lxAdt_venClas =  upper( .Clasificacion_PK ) 			lxAdt_venAdt_cod =  .Adt_cod
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_VEN set "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_venFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_venFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_venFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_venFecimpo ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_venAdt_fecha ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_venFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_venHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_venHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_venHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_venSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_venZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_venValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_venUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_venEsttrans ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_ent ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_adn ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_vers ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_usr ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_serie ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venBdmodifw ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_hora ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_venBdaltafw ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_comp ) + "'">>,"Adt_ext" = <<iif( lxAdt_venAdt_ext, 1, 0 )>>,"Inactivofw" = <<iif( lxAdt_venInactivofw, 1, 0 )>>,"Clcod" = <<"'" + this.FormatearTextoSql( lxAdt_venClcod ) + "'">>,"Clas" = <<"'" + this.FormatearTextoSql( lxAdt_venClas ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'">> and  ADT_VEN.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_VEN where " + this.ConvertirFuncionesSql( " ADT_VEN.ADT_COD != ''" ) )
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
			Local lxAdt_venAdt_cod
			lxAdt_venAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_VEN where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'">> and  ADT_VEN.ADT_COD != ''
			endtext
			use in select('c_ADT_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_VENDEDOR', set( 'Datasession' ) )

			if reccount( 'c_ADT_VENDEDOR' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_venAdt_cod as Variant
		llRetorno = .t.
		lxAdt_venAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_VEN where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'">> and  ADT_VEN.ADT_COD != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_VEN where  ADT_VEN.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_VENDEDOR', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_VEN where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_VEN.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_VENDEDOR', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_VEN where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_VEN.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_VENDEDOR', set( 'Datasession' ) )
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
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod" from ZooLogic.ADT_VEN where  ADT_VEN.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_VENDEDOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_VENDEDOR', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecexpo,Fmodifw,Fecimpo,Adt_fecha,Faltafw,Haltafw,Horaexpo,Horaimpo,Saltafw,Vmodifw" + ;
",Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Adt_ent,Adt_adn,Adt_vers,Adt_usr,Adt_serie," + ;
"Bdmodifw,Adt_hora,Bdaltafw,Adt_comp,Adt_ext,Inactivofw,Clcod,Clas,Adt_cod" + ;
" from ZooLogic.ADT_VEN where  ADT_VEN.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_venFectrans, lxAdt_venFecexpo, lxAdt_venFmodifw, lxAdt_venFecimpo, lxAdt_venAdt_fecha, lxAdt_venFaltafw, lxAdt_venHaltafw, lxAdt_venHoraexpo, lxAdt_venHoraimpo, lxAdt_venSaltafw, lxAdt_venVmodifw, lxAdt_venZadsfw, lxAdt_venValtafw, lxAdt_venUmodifw, lxAdt_venSmodifw, lxAdt_venUaltafw, lxAdt_venHmodifw, lxAdt_venEsttrans, lxAdt_venAdt_ent, lxAdt_venAdt_adn, lxAdt_venAdt_vers, lxAdt_venAdt_usr, lxAdt_venAdt_serie, lxAdt_venBdmodifw, lxAdt_venAdt_hora, lxAdt_venBdaltafw, lxAdt_venAdt_comp, lxAdt_venAdt_ext, lxAdt_venInactivofw, lxAdt_venClcod, lxAdt_venClas, lxAdt_venAdt_cod
				lxAdt_venFectrans = ctod( '  /  /    ' )			lxAdt_venFecexpo = ctod( '  /  /    ' )			lxAdt_venFmodifw = ctod( '  /  /    ' )			lxAdt_venFecimpo = ctod( '  /  /    ' )			lxAdt_venAdt_fecha = ctod( '  /  /    ' )			lxAdt_venFaltafw = ctod( '  /  /    ' )			lxAdt_venHaltafw = []			lxAdt_venHoraexpo = []			lxAdt_venHoraimpo = []			lxAdt_venSaltafw = []			lxAdt_venVmodifw = []			lxAdt_venZadsfw = []			lxAdt_venValtafw = []			lxAdt_venUmodifw = []			lxAdt_venSmodifw = []			lxAdt_venUaltafw = []			lxAdt_venHmodifw = []			lxAdt_venEsttrans = []			lxAdt_venAdt_ent = []			lxAdt_venAdt_adn = []			lxAdt_venAdt_vers = []			lxAdt_venAdt_usr = []			lxAdt_venAdt_serie = []			lxAdt_venBdmodifw = []			lxAdt_venAdt_hora = []			lxAdt_venBdaltafw = []			lxAdt_venAdt_comp = []			lxAdt_venAdt_ext = .F.			lxAdt_venInactivofw = .F.			lxAdt_venClcod = []			lxAdt_venClas = []			lxAdt_venAdt_cod = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_VEN where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_VEN' + '_' + tcCampo
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
		lcWhere = " Where  ADT_VEN.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_VEN', '', tnTope )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
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
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAS AS CLASIFICACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLAS'
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
			local  lxAdt_venFectrans, lxAdt_venFecexpo, lxAdt_venFmodifw, lxAdt_venFecimpo, lxAdt_venAdt_fecha, lxAdt_venFaltafw, lxAdt_venHaltafw, lxAdt_venHoraexpo, lxAdt_venHoraimpo, lxAdt_venSaltafw, lxAdt_venVmodifw, lxAdt_venZadsfw, lxAdt_venValtafw, lxAdt_venUmodifw, lxAdt_venSmodifw, lxAdt_venUaltafw, lxAdt_venHmodifw, lxAdt_venEsttrans, lxAdt_venAdt_ent, lxAdt_venAdt_adn, lxAdt_venAdt_vers, lxAdt_venAdt_usr, lxAdt_venAdt_serie, lxAdt_venBdmodifw, lxAdt_venAdt_hora, lxAdt_venBdaltafw, lxAdt_venAdt_comp, lxAdt_venAdt_ext, lxAdt_venInactivofw, lxAdt_venClcod, lxAdt_venClas, lxAdt_venAdt_cod
				lxAdt_venFectrans =  .Fechatransferencia			lxAdt_venFecexpo =  .Fechaexpo			lxAdt_venFmodifw =  .Fechamodificacionfw			lxAdt_venFecimpo =  .Fechaimpo			lxAdt_venAdt_fecha =  .Adt_fecha			lxAdt_venFaltafw =  .Fechaaltafw			lxAdt_venHaltafw =  .Horaaltafw			lxAdt_venHoraexpo =  .Horaexpo			lxAdt_venHoraimpo =  .Horaimpo			lxAdt_venSaltafw =  .Seriealtafw			lxAdt_venVmodifw =  .Versionmodificacionfw			lxAdt_venZadsfw =  .Zadsfw			lxAdt_venValtafw =  .Versionaltafw			lxAdt_venUmodifw =  .Usuariomodificacionfw			lxAdt_venSmodifw =  .Seriemodificacionfw			lxAdt_venUaltafw =  .Usuarioaltafw			lxAdt_venHmodifw =  .Horamodificacionfw			lxAdt_venEsttrans =  .Estadotransferencia			lxAdt_venAdt_ent =  .Adt_ent			lxAdt_venAdt_adn =  .Adt_adn			lxAdt_venAdt_vers =  .Adt_vers			lxAdt_venAdt_usr =  .Adt_usr			lxAdt_venAdt_serie =  .Adt_serie			lxAdt_venBdmodifw =  .Basededatosmodificacionfw			lxAdt_venAdt_hora =  .Adt_hora			lxAdt_venBdaltafw =  .Basededatosaltafw			lxAdt_venAdt_comp =  .Adt_comp			lxAdt_venAdt_ext =  .Adt_ext			lxAdt_venInactivofw =  .Inactivofw			lxAdt_venClcod =  upper( .Codigo_PK ) 			lxAdt_venClas =  upper( .Clasificacion_PK ) 			lxAdt_venAdt_cod =  .Adt_cod
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_VEN ( "Fectrans","Fecexpo","Fmodifw","Fecimpo","Adt_fecha","Faltafw","Haltafw","Horaexpo","Horaimpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Esttrans","Adt_ent","Adt_adn","Adt_vers","Adt_usr","Adt_serie","Bdmodifw","Adt_hora","Bdaltafw","Adt_comp","Adt_ext","Inactivofw","Clcod","Clas","Adt_cod" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_venFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_venFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_comp ) + "'" >>, <<iif( lxAdt_venAdt_ext, 1, 0 ) >>, <<iif( lxAdt_venInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_venClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venClas ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_VEN' 
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
			local  lxAdt_venFectrans, lxAdt_venFecexpo, lxAdt_venFmodifw, lxAdt_venFecimpo, lxAdt_venAdt_fecha, lxAdt_venFaltafw, lxAdt_venHaltafw, lxAdt_venHoraexpo, lxAdt_venHoraimpo, lxAdt_venSaltafw, lxAdt_venVmodifw, lxAdt_venZadsfw, lxAdt_venValtafw, lxAdt_venUmodifw, lxAdt_venSmodifw, lxAdt_venUaltafw, lxAdt_venHmodifw, lxAdt_venEsttrans, lxAdt_venAdt_ent, lxAdt_venAdt_adn, lxAdt_venAdt_vers, lxAdt_venAdt_usr, lxAdt_venAdt_serie, lxAdt_venBdmodifw, lxAdt_venAdt_hora, lxAdt_venBdaltafw, lxAdt_venAdt_comp, lxAdt_venAdt_ext, lxAdt_venInactivofw, lxAdt_venClcod, lxAdt_venClas, lxAdt_venAdt_cod
				lxAdt_venFectrans =  .Fechatransferencia			lxAdt_venFecexpo =  .Fechaexpo			lxAdt_venFmodifw =  .Fechamodificacionfw			lxAdt_venFecimpo =  .Fechaimpo			lxAdt_venAdt_fecha =  .Adt_fecha			lxAdt_venFaltafw =  .Fechaaltafw			lxAdt_venHaltafw =  .Horaaltafw			lxAdt_venHoraexpo =  .Horaexpo			lxAdt_venHoraimpo =  .Horaimpo			lxAdt_venSaltafw =  .Seriealtafw			lxAdt_venVmodifw =  .Versionmodificacionfw			lxAdt_venZadsfw =  .Zadsfw			lxAdt_venValtafw =  .Versionaltafw			lxAdt_venUmodifw =  .Usuariomodificacionfw			lxAdt_venSmodifw =  .Seriemodificacionfw			lxAdt_venUaltafw =  .Usuarioaltafw			lxAdt_venHmodifw =  .Horamodificacionfw			lxAdt_venEsttrans =  .Estadotransferencia			lxAdt_venAdt_ent =  .Adt_ent			lxAdt_venAdt_adn =  .Adt_adn			lxAdt_venAdt_vers =  .Adt_vers			lxAdt_venAdt_usr =  .Adt_usr			lxAdt_venAdt_serie =  .Adt_serie			lxAdt_venBdmodifw =  .Basededatosmodificacionfw			lxAdt_venAdt_hora =  .Adt_hora			lxAdt_venBdaltafw =  .Basededatosaltafw			lxAdt_venAdt_comp =  .Adt_comp			lxAdt_venAdt_ext =  .Adt_ext			lxAdt_venInactivofw =  .Inactivofw			lxAdt_venClcod =  upper( .Codigo_PK ) 			lxAdt_venClas =  upper( .Clasificacion_PK ) 			lxAdt_venAdt_cod =  .Adt_cod
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_VEN.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_VEN set "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_venFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_venFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_venFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_venFecimpo ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_venAdt_fecha ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_venFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_venHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_venHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_venHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_venSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_venZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_venValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_venUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_venEsttrans ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_ent ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_adn ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_vers ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_usr ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_serie ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_venBdmodifw ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_hora ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_venBdaltafw ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_comp ) + "'">>, "Adt_ext" = <<iif( lxAdt_venAdt_ext, 1, 0 )>>, "Inactivofw" = <<iif( lxAdt_venInactivofw, 1, 0 )>>, "Clcod" = <<"'" + this.FormatearTextoSql( lxAdt_venClcod ) + "'">>, "Clas" = <<"'" + this.FormatearTextoSql( lxAdt_venClas ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_venAdt_cod ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_VEN' 
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

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_VEN.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_VEN where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_VEN' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_VEN where  ADT_VEN.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_VEN where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_VEN.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_VENDEDOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_VEN Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_VEN set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLAS ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FECEXPO, FMODIFW, FECIMPO, ADT_Fecha, FALTAFW, HALTAFW, HORAEXPO, HORAIMPO, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HMODIFW, ESTTRANS, ADT_Ent, ADT_ADN, ADT_Vers, ADT_Usr, ADT_Serie, BDMODIFW, ADT_Hora, BDALTAFW, ADT_Comp, ADT_Ext, InactivoFW, CLCOD, CLAS, ADT_Cod
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLAS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_VEN ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_VENDEDOR'
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
			Case  lcAlias == lcPrefijo + 'ADT_VENDEDOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_VENDEDOR_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_VEN')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_VENDEDOR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_VENDEDOR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_VENDEDOR'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_VENDEDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_VEN') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_VEN
Create Table ZooLogic.TablaTrabajo_ADT_VEN ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"adt_fecha" datetime  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"adt_ent" char( 40 )  null, 
"adt_adn" char( 10 )  null, 
"adt_vers" char( 13 )  null, 
"adt_usr" char( 100 )  null, 
"adt_serie" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_hora" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"adt_comp" char( 254 )  null, 
"adt_ext" bit  null, 
"inactivofw" bit  null, 
"clcod" char( 10 )  null, 
"clas" char( 10 )  null, 
"adt_cod" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_VEN' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_VEN' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_VENDEDOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clas','clas')
			.AgregarMapeo('adt_cod','adt_cod')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_VEN'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLAS = isnull( d.CLAS, t.CLAS ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD )
					from ZooLogic.ADT_VEN t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_VEN(Fectrans,Fecexpo,Fmodifw,Fecimpo,Adt_fecha,Faltafw,Haltafw,Horaexpo,Horaimpo,Saltafw,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Esttrans,Adt_ent,Adt_adn,Adt_vers,Adt_usr,Adt_serie,Bdmodifw,Adt_hora,Bdaltafw,Adt_comp,Adt_ext,Inactivofw,Clcod,Clas,Adt_cod)
					Select isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.ADT_FECHA,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.ADT_ENT,''),isnull( d.ADT_ADN,''),isnull( d.ADT_VERS,''),isnull( d.ADT_USR,''),isnull( d.ADT_SERIE,''),isnull( d.BDMODIFW,''),isnull( d.ADT_HORA,''),isnull( d.BDALTAFW,''),isnull( d.ADT_COMP,''),isnull( d.ADT_EXT,0),isnull( d.INACTIVOFW,0),isnull( d.CLCOD,''),isnull( d.CLAS,''),isnull( d.ADT_COD,'')
						From deleted d left join ZooLogic.ADT_VEN pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_VEN') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_VEN
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_VENDEDOR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_VENDEDOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_VENDEDOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_VENDEDOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_VENDEDOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_VENDEDOR.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_VENDEDOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_ADT_VENDEDOR.Horaaltafw, [] )
					.Horaexpo = nvl( c_ADT_VENDEDOR.Horaexpo, [] )
					.Horaimpo = nvl( c_ADT_VENDEDOR.Horaimpo, [] )
					.Seriealtafw = nvl( c_ADT_VENDEDOR.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_ADT_VENDEDOR.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ADT_VENDEDOR.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_VENDEDOR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_ADT_VENDEDOR.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ADT_VENDEDOR.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_ADT_VENDEDOR.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_ADT_VENDEDOR.Estadotransferencia, [] )
					.Adt_ent = nvl( c_ADT_VENDEDOR.Adt_ent, [] )
					.Adt_adn = nvl( c_ADT_VENDEDOR.Adt_adn, [] )
					.Adt_vers = nvl( c_ADT_VENDEDOR.Adt_vers, [] )
					.Adt_usr = nvl( c_ADT_VENDEDOR.Adt_usr, [] )
					.Adt_serie = nvl( c_ADT_VENDEDOR.Adt_serie, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_VENDEDOR.Basededatosmodificacionfw, [] )
					.Adt_hora = nvl( c_ADT_VENDEDOR.Adt_hora, [] )
					.Basededatosaltafw = nvl( c_ADT_VENDEDOR.Basededatosaltafw, [] )
					.Adt_comp = nvl( c_ADT_VENDEDOR.Adt_comp, [] )
					.Adt_ext = nvl( c_ADT_VENDEDOR.Adt_ext, .F. )
					.Inactivofw = nvl( c_ADT_VENDEDOR.Inactivofw, .F. )
					.Codigo_PK =  nvl( c_ADT_VENDEDOR.Codigo, [] )
					.Clasificacion_PK =  nvl( c_ADT_VENDEDOR.Clasificacion, [] )
					.Adt_cod = nvl( c_ADT_VENDEDOR.Adt_cod, [] )
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
		return c_ADT_VENDEDOR.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_VEN' )
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
								from ZooLogic.ADT_VEN 
								Where   ADT_VEN.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_VEN", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_adn" as "Adt_adn", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_serie" as "Adt_serie", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Bdaltafw" as "Basededatosaltafw", "Adt_comp" as "Adt_comp", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Clcod" as "Codigo", "Clas" as "Clasificacion", "Adt_cod" as "Adt_cod"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_VEN 
								Where   ADT_VEN.ADT_COD != ''
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
	Tabla = 'ADT_VEN'
	Filtro = " ADT_VEN.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_VEN.ADT_COD != ''"
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
	<row entidad="ADT_VENDEDOR                            " atributo="FECHATRANSFERENCIA                      " tabla="ADT_VEN        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="FECHAEXPO                               " tabla="ADT_VEN        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_VEN        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="FECHAIMPO                               " tabla="ADT_VEN        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_FECHA                               " tabla="ADT_VEN        " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="FECHAALTAFW                             " tabla="ADT_VEN        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="HORAALTAFW                              " tabla="ADT_VEN        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="HORAEXPO                                " tabla="ADT_VEN        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="HORAIMPO                                " tabla="ADT_VEN        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="SERIEALTAFW                             " tabla="ADT_VEN        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_VEN        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ZADSFW                                  " tabla="ADT_VEN        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="VERSIONALTAFW                           " tabla="ADT_VEN        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_VEN        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_VEN        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="USUARIOALTAFW                           " tabla="ADT_VEN        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="HORAMODIFICACIONFW                      " tabla="ADT_VEN        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_VEN        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_ENT                                 " tabla="ADT_VEN        " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_ADN                                 " tabla="ADT_VEN        " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_VERS                                " tabla="ADT_VEN        " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_USR                                 " tabla="ADT_VEN        " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_SERIE                               " tabla="ADT_VEN        " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_VEN        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_HORA                                " tabla="ADT_VEN        " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_VEN        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_COMP                                " tabla="ADT_VEN        " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_EXT                                 " tabla="ADT_VEN        " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="INACTIVOFW                              " tabla="ADT_VEN        " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Inactivo                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="CODIGO                                  " tabla="ADT_VEN        " campo="CLCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Vendedores                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="CLASIFICACION                           " tabla="ADT_VEN        " campo="CLAS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONVENDEDOR                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_VENDEDOR                            " atributo="ADT_COD                                 " tabla="ADT_VEN        " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On ADT_VEN.CLCOD = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONVENDEDOR                   " atributo="DESCRIPCION                             " tabla="CLASVEND       " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASVEND On ADT_VEN.CLAS = CLASVEND.CLACOD And  CLASVEND.CLACOD != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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