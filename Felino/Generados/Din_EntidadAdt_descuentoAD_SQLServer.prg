
define class Din_EntidadADT_DESCUENTOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_DESCUENTO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUDDESPK'
	cTablaPrincipal = 'ADT_DESCUENTOS'
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
			local  lxAdt_descuentosFecimpo, lxAdt_descuentosFectrans, lxAdt_descuentosFmodifw, lxAdt_descuentosFecexpo, lxAdt_descuentosFaltafw, lxAdt_descuentosAdt_fecha, lxAdt_descuentosAdt_ext, lxAdt_descuentosInactivofw, lxAdt_descuentosHoraimpo, lxAdt_descuentosHmodifw, lxAdt_descuentosHoraexpo, lxAdt_descuentosSaltafw, lxAdt_descuentosHaltafw, lxAdt_descuentosSmodifw, lxAdt_descuentosUmodifw, lxAdt_descuentosVmodifw, lxAdt_descuentosZadsfw, lxAdt_descuentosValtafw, lxAdt_descuentosUaltafw, lxAdt_descuentosAdt_serie, lxAdt_descuentosAdt_vers, lxAdt_descuentosAdt_comp, lxAdt_descuentosAdt_adn, lxAdt_descuentosBdaltafw, lxAdt_descuentosBdmodifw, lxAdt_descuentosAdt_hora, lxAdt_descuentosEsttrans, lxAdt_descuentosAdt_ent, lxAdt_descuentosAdt_usr, lxAdt_descuentosAdt_cod, lxAdt_descuentosCodigo
				lxAdt_descuentosFecimpo =  .Fechaimpo			lxAdt_descuentosFectrans =  .Fechatransferencia			lxAdt_descuentosFmodifw =  .Fechamodificacionfw			lxAdt_descuentosFecexpo =  .Fechaexpo			lxAdt_descuentosFaltafw =  .Fechaaltafw			lxAdt_descuentosAdt_fecha =  .Adt_fecha			lxAdt_descuentosAdt_ext =  .Adt_ext			lxAdt_descuentosInactivofw =  .Inactivofw			lxAdt_descuentosHoraimpo =  .Horaimpo			lxAdt_descuentosHmodifw =  .Horamodificacionfw			lxAdt_descuentosHoraexpo =  .Horaexpo			lxAdt_descuentosSaltafw =  .Seriealtafw			lxAdt_descuentosHaltafw =  .Horaaltafw			lxAdt_descuentosSmodifw =  .Seriemodificacionfw			lxAdt_descuentosUmodifw =  .Usuariomodificacionfw			lxAdt_descuentosVmodifw =  .Versionmodificacionfw			lxAdt_descuentosZadsfw =  .Zadsfw			lxAdt_descuentosValtafw =  .Versionaltafw			lxAdt_descuentosUaltafw =  .Usuarioaltafw			lxAdt_descuentosAdt_serie =  .Adt_serie			lxAdt_descuentosAdt_vers =  .Adt_vers			lxAdt_descuentosAdt_comp =  .Adt_comp			lxAdt_descuentosAdt_adn =  .Adt_adn			lxAdt_descuentosBdaltafw =  .Basededatosaltafw			lxAdt_descuentosBdmodifw =  .Basededatosmodificacionfw			lxAdt_descuentosAdt_hora =  .Adt_hora			lxAdt_descuentosEsttrans =  .Estadotransferencia			lxAdt_descuentosAdt_ent =  .Adt_ent			lxAdt_descuentosAdt_usr =  .Adt_usr			lxAdt_descuentosAdt_cod =  .Adt_cod			lxAdt_descuentosCodigo =  upper( .Codigo_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_descuentosAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_DESCUENTOS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Adt_fecha","Adt_ext","Inactivofw","Horaimpo","Hmodifw","Horaexpo","Saltafw","Haltafw","Smodifw","Umodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Adt_serie","Adt_vers","Adt_comp","Adt_adn","Bdaltafw","Bdmodifw","Adt_hora","Esttrans","Adt_ent","Adt_usr","Adt_cod","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosAdt_fecha ) + "'" >>, <<iif( lxAdt_descuentosAdt_ext, 1, 0 ) >>, <<iif( lxAdt_descuentosInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosCodigo ) + "'" >> )
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
			local  lxAdt_descuentosFecimpo, lxAdt_descuentosFectrans, lxAdt_descuentosFmodifw, lxAdt_descuentosFecexpo, lxAdt_descuentosFaltafw, lxAdt_descuentosAdt_fecha, lxAdt_descuentosAdt_ext, lxAdt_descuentosInactivofw, lxAdt_descuentosHoraimpo, lxAdt_descuentosHmodifw, lxAdt_descuentosHoraexpo, lxAdt_descuentosSaltafw, lxAdt_descuentosHaltafw, lxAdt_descuentosSmodifw, lxAdt_descuentosUmodifw, lxAdt_descuentosVmodifw, lxAdt_descuentosZadsfw, lxAdt_descuentosValtafw, lxAdt_descuentosUaltafw, lxAdt_descuentosAdt_serie, lxAdt_descuentosAdt_vers, lxAdt_descuentosAdt_comp, lxAdt_descuentosAdt_adn, lxAdt_descuentosBdaltafw, lxAdt_descuentosBdmodifw, lxAdt_descuentosAdt_hora, lxAdt_descuentosEsttrans, lxAdt_descuentosAdt_ent, lxAdt_descuentosAdt_usr, lxAdt_descuentosAdt_cod, lxAdt_descuentosCodigo
				lxAdt_descuentosFecimpo =  .Fechaimpo			lxAdt_descuentosFectrans =  .Fechatransferencia			lxAdt_descuentosFmodifw =  .Fechamodificacionfw			lxAdt_descuentosFecexpo =  .Fechaexpo			lxAdt_descuentosFaltafw =  .Fechaaltafw			lxAdt_descuentosAdt_fecha =  .Adt_fecha			lxAdt_descuentosAdt_ext =  .Adt_ext			lxAdt_descuentosInactivofw =  .Inactivofw			lxAdt_descuentosHoraimpo =  .Horaimpo			lxAdt_descuentosHmodifw =  .Horamodificacionfw			lxAdt_descuentosHoraexpo =  .Horaexpo			lxAdt_descuentosSaltafw =  .Seriealtafw			lxAdt_descuentosHaltafw =  .Horaaltafw			lxAdt_descuentosSmodifw =  .Seriemodificacionfw			lxAdt_descuentosUmodifw =  .Usuariomodificacionfw			lxAdt_descuentosVmodifw =  .Versionmodificacionfw			lxAdt_descuentosZadsfw =  .Zadsfw			lxAdt_descuentosValtafw =  .Versionaltafw			lxAdt_descuentosUaltafw =  .Usuarioaltafw			lxAdt_descuentosAdt_serie =  .Adt_serie			lxAdt_descuentosAdt_vers =  .Adt_vers			lxAdt_descuentosAdt_comp =  .Adt_comp			lxAdt_descuentosAdt_adn =  .Adt_adn			lxAdt_descuentosBdaltafw =  .Basededatosaltafw			lxAdt_descuentosBdmodifw =  .Basededatosmodificacionfw			lxAdt_descuentosAdt_hora =  .Adt_hora			lxAdt_descuentosEsttrans =  .Estadotransferencia			lxAdt_descuentosAdt_ent =  .Adt_ent			lxAdt_descuentosAdt_usr =  .Adt_usr			lxAdt_descuentosAdt_cod =  .Adt_cod			lxAdt_descuentosCodigo =  upper( .Codigo_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_DESCUENTOS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFaltafw ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosAdt_fecha ) + "'">>,"Adt_ext" = <<iif( lxAdt_descuentosAdt_ext, 1, 0 )>>,"Inactivofw" = <<iif( lxAdt_descuentosInactivofw, 1, 0 )>>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraimpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosSaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosUaltafw ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_serie ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_vers ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_comp ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_adn ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdmodifw ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_hora ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosEsttrans ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_ent ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_usr ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosCodigo ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'">> and  ADT_DESCUENTOS.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_DESCUENTOS where " + this.ConvertirFuncionesSql( " ADT_DESCUENTOS.ADT_COD != ''" ) )
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
			Local lxAdt_descuentosAdt_cod
			lxAdt_descuentosAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo" from ZooLogic.ADT_DESCUENTOS where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'">> and  ADT_DESCUENTOS.ADT_COD != ''
			endtext
			use in select('c_ADT_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_DESCUENTO', set( 'Datasession' ) )

			if reccount( 'c_ADT_DESCUENTO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_descuentosAdt_cod as Variant
		llRetorno = .t.
		lxAdt_descuentosAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_DESCUENTOS where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'">> and  ADT_DESCUENTOS.ADT_COD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo" from ZooLogic.ADT_DESCUENTOS where  ADT_DESCUENTOS.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_DESCUENTO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo" from ZooLogic.ADT_DESCUENTOS where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_DESCUENTOS.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_DESCUENTO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo" from ZooLogic.ADT_DESCUENTOS where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_DESCUENTOS.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_DESCUENTO', set( 'Datasession' ) )
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo" from ZooLogic.ADT_DESCUENTOS where  ADT_DESCUENTOS.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_DESCUENTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_DESCUENTO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Adt_fecha,Adt_ext,Inactivofw,Horaimpo,Hmodifw,Horae" + ;
"xpo,Saltafw,Haltafw,Smodifw,Umodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Adt_serie,Adt_vers,Adt_comp,Adt_a" + ;
"dn,Bdaltafw,Bdmodifw,Adt_hora,Esttrans,Adt_ent,Adt_usr,Adt_cod,Codigo" + ;
" from ZooLogic.ADT_DESCUENTOS where  ADT_DESCUENTOS.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_descuentosFecimpo, lxAdt_descuentosFectrans, lxAdt_descuentosFmodifw, lxAdt_descuentosFecexpo, lxAdt_descuentosFaltafw, lxAdt_descuentosAdt_fecha, lxAdt_descuentosAdt_ext, lxAdt_descuentosInactivofw, lxAdt_descuentosHoraimpo, lxAdt_descuentosHmodifw, lxAdt_descuentosHoraexpo, lxAdt_descuentosSaltafw, lxAdt_descuentosHaltafw, lxAdt_descuentosSmodifw, lxAdt_descuentosUmodifw, lxAdt_descuentosVmodifw, lxAdt_descuentosZadsfw, lxAdt_descuentosValtafw, lxAdt_descuentosUaltafw, lxAdt_descuentosAdt_serie, lxAdt_descuentosAdt_vers, lxAdt_descuentosAdt_comp, lxAdt_descuentosAdt_adn, lxAdt_descuentosBdaltafw, lxAdt_descuentosBdmodifw, lxAdt_descuentosAdt_hora, lxAdt_descuentosEsttrans, lxAdt_descuentosAdt_ent, lxAdt_descuentosAdt_usr, lxAdt_descuentosAdt_cod, lxAdt_descuentosCodigo
				lxAdt_descuentosFecimpo = ctod( '  /  /    ' )			lxAdt_descuentosFectrans = ctod( '  /  /    ' )			lxAdt_descuentosFmodifw = ctod( '  /  /    ' )			lxAdt_descuentosFecexpo = ctod( '  /  /    ' )			lxAdt_descuentosFaltafw = ctod( '  /  /    ' )			lxAdt_descuentosAdt_fecha = ctod( '  /  /    ' )			lxAdt_descuentosAdt_ext = .F.			lxAdt_descuentosInactivofw = .F.			lxAdt_descuentosHoraimpo = []			lxAdt_descuentosHmodifw = []			lxAdt_descuentosHoraexpo = []			lxAdt_descuentosSaltafw = []			lxAdt_descuentosHaltafw = []			lxAdt_descuentosSmodifw = []			lxAdt_descuentosUmodifw = []			lxAdt_descuentosVmodifw = []			lxAdt_descuentosZadsfw = []			lxAdt_descuentosValtafw = []			lxAdt_descuentosUaltafw = []			lxAdt_descuentosAdt_serie = []			lxAdt_descuentosAdt_vers = []			lxAdt_descuentosAdt_comp = []			lxAdt_descuentosAdt_adn = []			lxAdt_descuentosBdaltafw = []			lxAdt_descuentosBdmodifw = []			lxAdt_descuentosAdt_hora = []			lxAdt_descuentosEsttrans = []			lxAdt_descuentosAdt_ent = []			lxAdt_descuentosAdt_usr = []			lxAdt_descuentosAdt_cod = []			lxAdt_descuentosCodigo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_DESCUENTOS where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_DESCUENTOS' + '_' + tcCampo
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
		lcWhere = " Where  ADT_DESCUENTOS.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_DESCUENTOS', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'INACTIVOFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INACTIVOFW AS INACTIVOFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
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
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'INACTIVOFW'
				lcCampo = 'INACTIVOFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
			local  lxAdt_descuentosFecimpo, lxAdt_descuentosFectrans, lxAdt_descuentosFmodifw, lxAdt_descuentosFecexpo, lxAdt_descuentosFaltafw, lxAdt_descuentosAdt_fecha, lxAdt_descuentosAdt_ext, lxAdt_descuentosInactivofw, lxAdt_descuentosHoraimpo, lxAdt_descuentosHmodifw, lxAdt_descuentosHoraexpo, lxAdt_descuentosSaltafw, lxAdt_descuentosHaltafw, lxAdt_descuentosSmodifw, lxAdt_descuentosUmodifw, lxAdt_descuentosVmodifw, lxAdt_descuentosZadsfw, lxAdt_descuentosValtafw, lxAdt_descuentosUaltafw, lxAdt_descuentosAdt_serie, lxAdt_descuentosAdt_vers, lxAdt_descuentosAdt_comp, lxAdt_descuentosAdt_adn, lxAdt_descuentosBdaltafw, lxAdt_descuentosBdmodifw, lxAdt_descuentosAdt_hora, lxAdt_descuentosEsttrans, lxAdt_descuentosAdt_ent, lxAdt_descuentosAdt_usr, lxAdt_descuentosAdt_cod, lxAdt_descuentosCodigo
				lxAdt_descuentosFecimpo =  .Fechaimpo			lxAdt_descuentosFectrans =  .Fechatransferencia			lxAdt_descuentosFmodifw =  .Fechamodificacionfw			lxAdt_descuentosFecexpo =  .Fechaexpo			lxAdt_descuentosFaltafw =  .Fechaaltafw			lxAdt_descuentosAdt_fecha =  .Adt_fecha			lxAdt_descuentosAdt_ext =  .Adt_ext			lxAdt_descuentosInactivofw =  .Inactivofw			lxAdt_descuentosHoraimpo =  .Horaimpo			lxAdt_descuentosHmodifw =  .Horamodificacionfw			lxAdt_descuentosHoraexpo =  .Horaexpo			lxAdt_descuentosSaltafw =  .Seriealtafw			lxAdt_descuentosHaltafw =  .Horaaltafw			lxAdt_descuentosSmodifw =  .Seriemodificacionfw			lxAdt_descuentosUmodifw =  .Usuariomodificacionfw			lxAdt_descuentosVmodifw =  .Versionmodificacionfw			lxAdt_descuentosZadsfw =  .Zadsfw			lxAdt_descuentosValtafw =  .Versionaltafw			lxAdt_descuentosUaltafw =  .Usuarioaltafw			lxAdt_descuentosAdt_serie =  .Adt_serie			lxAdt_descuentosAdt_vers =  .Adt_vers			lxAdt_descuentosAdt_comp =  .Adt_comp			lxAdt_descuentosAdt_adn =  .Adt_adn			lxAdt_descuentosBdaltafw =  .Basededatosaltafw			lxAdt_descuentosBdmodifw =  .Basededatosmodificacionfw			lxAdt_descuentosAdt_hora =  .Adt_hora			lxAdt_descuentosEsttrans =  .Estadotransferencia			lxAdt_descuentosAdt_ent =  .Adt_ent			lxAdt_descuentosAdt_usr =  .Adt_usr			lxAdt_descuentosAdt_cod =  .Adt_cod			lxAdt_descuentosCodigo =  upper( .Codigo_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_DESCUENTOS ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Adt_fecha","Adt_ext","Inactivofw","Horaimpo","Hmodifw","Horaexpo","Saltafw","Haltafw","Smodifw","Umodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Adt_serie","Adt_vers","Adt_comp","Adt_adn","Bdaltafw","Bdmodifw","Adt_hora","Esttrans","Adt_ent","Adt_usr","Adt_cod","Codigo" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_descuentosAdt_fecha ) + "'" >>, <<iif( lxAdt_descuentosAdt_ext, 1, 0 ) >>, <<iif( lxAdt_descuentosInactivofw, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_descuentosCodigo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_DESCUENTOS' 
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
			local  lxAdt_descuentosFecimpo, lxAdt_descuentosFectrans, lxAdt_descuentosFmodifw, lxAdt_descuentosFecexpo, lxAdt_descuentosFaltafw, lxAdt_descuentosAdt_fecha, lxAdt_descuentosAdt_ext, lxAdt_descuentosInactivofw, lxAdt_descuentosHoraimpo, lxAdt_descuentosHmodifw, lxAdt_descuentosHoraexpo, lxAdt_descuentosSaltafw, lxAdt_descuentosHaltafw, lxAdt_descuentosSmodifw, lxAdt_descuentosUmodifw, lxAdt_descuentosVmodifw, lxAdt_descuentosZadsfw, lxAdt_descuentosValtafw, lxAdt_descuentosUaltafw, lxAdt_descuentosAdt_serie, lxAdt_descuentosAdt_vers, lxAdt_descuentosAdt_comp, lxAdt_descuentosAdt_adn, lxAdt_descuentosBdaltafw, lxAdt_descuentosBdmodifw, lxAdt_descuentosAdt_hora, lxAdt_descuentosEsttrans, lxAdt_descuentosAdt_ent, lxAdt_descuentosAdt_usr, lxAdt_descuentosAdt_cod, lxAdt_descuentosCodigo
				lxAdt_descuentosFecimpo =  .Fechaimpo			lxAdt_descuentosFectrans =  .Fechatransferencia			lxAdt_descuentosFmodifw =  .Fechamodificacionfw			lxAdt_descuentosFecexpo =  .Fechaexpo			lxAdt_descuentosFaltafw =  .Fechaaltafw			lxAdt_descuentosAdt_fecha =  .Adt_fecha			lxAdt_descuentosAdt_ext =  .Adt_ext			lxAdt_descuentosInactivofw =  .Inactivofw			lxAdt_descuentosHoraimpo =  .Horaimpo			lxAdt_descuentosHmodifw =  .Horamodificacionfw			lxAdt_descuentosHoraexpo =  .Horaexpo			lxAdt_descuentosSaltafw =  .Seriealtafw			lxAdt_descuentosHaltafw =  .Horaaltafw			lxAdt_descuentosSmodifw =  .Seriemodificacionfw			lxAdt_descuentosUmodifw =  .Usuariomodificacionfw			lxAdt_descuentosVmodifw =  .Versionmodificacionfw			lxAdt_descuentosZadsfw =  .Zadsfw			lxAdt_descuentosValtafw =  .Versionaltafw			lxAdt_descuentosUaltafw =  .Usuarioaltafw			lxAdt_descuentosAdt_serie =  .Adt_serie			lxAdt_descuentosAdt_vers =  .Adt_vers			lxAdt_descuentosAdt_comp =  .Adt_comp			lxAdt_descuentosAdt_adn =  .Adt_adn			lxAdt_descuentosBdaltafw =  .Basededatosaltafw			lxAdt_descuentosBdmodifw =  .Basededatosmodificacionfw			lxAdt_descuentosAdt_hora =  .Adt_hora			lxAdt_descuentosEsttrans =  .Estadotransferencia			lxAdt_descuentosAdt_ent =  .Adt_ent			lxAdt_descuentosAdt_usr =  .Adt_usr			lxAdt_descuentosAdt_cod =  .Adt_cod			lxAdt_descuentosCodigo =  upper( .Codigo_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_DESCUENTOS.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_DESCUENTOS set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosFaltafw ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_descuentosAdt_fecha ) + "'">>, "Adt_ext" = <<iif( lxAdt_descuentosAdt_ext, 1, 0 )>>, "Inactivofw" = <<iif( lxAdt_descuentosInactivofw, 1, 0 )>>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraimpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosSaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosUaltafw ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_serie ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_vers ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_comp ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_adn ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosBdmodifw ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_hora ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosEsttrans ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_ent ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_usr ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosAdt_cod ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAdt_descuentosCodigo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_DESCUENTOS' 
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

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_DESCUENTOS.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_DESCUENTOS where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_DESCUENTOS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_DESCUENTOS where  ADT_DESCUENTOS.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_DESCUENTOS where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_DESCUENTOS.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_DESCUENTO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_DESCUENTOS Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_DESCUENTOS set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, InactivoFW = ] + Transform( iif( &lcCursor..InactivoFW, 1, 0 ))+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, ADT_Fecha, ADT_Ext, InactivoFW, HORAIMPO, HMODIFW, HORAEXPO, SALTAFW, HALTAFW, SMODIFW, UMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, ADT_Serie, ADT_Vers, ADT_Comp, ADT_ADN, BDALTAFW, BDMODIFW, ADT_Hora, ESTTRANS, ADT_Ent, ADT_Usr, ADT_Cod, codigo
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..InactivoFW, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_DESCUENTOS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_DESCUENTO'
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
			Case  lcAlias == lcPrefijo + 'ADT_DESCUENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_DESCUENTO_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_DESCUENTOS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_DESCUENTO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_DESCUENTO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_DESCUENTO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_DESCUENTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_DESCUENTOS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_DESCUENTOS
Create Table ZooLogic.TablaTrabajo_ADT_DESCUENTOS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"adt_fecha" datetime  null, 
"adt_ext" bit  null, 
"inactivofw" bit  null, 
"horaimpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"adt_serie" char( 20 )  null, 
"adt_vers" char( 13 )  null, 
"adt_comp" char( 254 )  null, 
"adt_adn" char( 10 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_hora" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"adt_ent" char( 40 )  null, 
"adt_usr" char( 100 )  null, 
"adt_cod" char( 38 )  null, 
"codigo" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_DESCUENTOS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_DESCUENTOS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_DESCUENTO'
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
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('inactivofw','inactivofw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_cod','adt_cod')
			.AgregarMapeo('codigo','codigo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_DESCUENTOS'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.INACTIVOFW = isnull( d.INACTIVOFW, t.INACTIVOFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD ),t.CODIGO = isnull( d.CODIGO, t.CODIGO )
					from ZooLogic.ADT_DESCUENTOS t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_DESCUENTOS(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Adt_fecha,Adt_ext,Inactivofw,Horaimpo,Hmodifw,Horaexpo,Saltafw,Haltafw,Smodifw,Umodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Adt_serie,Adt_vers,Adt_comp,Adt_adn,Bdaltafw,Bdmodifw,Adt_hora,Esttrans,Adt_ent,Adt_usr,Adt_cod,Codigo)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ADT_FECHA,''),isnull( d.ADT_EXT,0),isnull( d.INACTIVOFW,0),isnull( d.HORAIMPO,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_VERS,''),isnull( d.ADT_COMP,''),isnull( d.ADT_ADN,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ADT_HORA,''),isnull( d.ESTTRANS,''),isnull( d.ADT_ENT,''),isnull( d.ADT_USR,''),isnull( d.ADT_COD,''),isnull( d.CODIGO,'')
						From deleted d left join ZooLogic.ADT_DESCUENTOS pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_DESCUENTOS') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_DESCUENTOS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_DESCUENTO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_DESCUENTO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_DESCUENTO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_DESCUENTO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_DESCUENTO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_DESCUENTO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_DESCUENTO.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Adt_ext = nvl( c_ADT_DESCUENTO.Adt_ext, .F. )
					.Inactivofw = nvl( c_ADT_DESCUENTO.Inactivofw, .F. )
					.Horaimpo = nvl( c_ADT_DESCUENTO.Horaimpo, [] )
					.Horamodificacionfw = nvl( c_ADT_DESCUENTO.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_ADT_DESCUENTO.Horaexpo, [] )
					.Seriealtafw = nvl( c_ADT_DESCUENTO.Seriealtafw, [] )
					.Horaaltafw = nvl( c_ADT_DESCUENTO.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_ADT_DESCUENTO.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_DESCUENTO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ADT_DESCUENTO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ADT_DESCUENTO.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_ADT_DESCUENTO.Usuarioaltafw, [] )
					.Adt_serie = nvl( c_ADT_DESCUENTO.Adt_serie, [] )
					.Adt_vers = nvl( c_ADT_DESCUENTO.Adt_vers, [] )
					.Adt_comp = nvl( c_ADT_DESCUENTO.Adt_comp, [] )
					.Adt_adn = nvl( c_ADT_DESCUENTO.Adt_adn, [] )
					.Basededatosaltafw = nvl( c_ADT_DESCUENTO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_DESCUENTO.Basededatosmodificacionfw, [] )
					.Adt_hora = nvl( c_ADT_DESCUENTO.Adt_hora, [] )
					.Estadotransferencia = nvl( c_ADT_DESCUENTO.Estadotransferencia, [] )
					.Adt_ent = nvl( c_ADT_DESCUENTO.Adt_ent, [] )
					.Adt_usr = nvl( c_ADT_DESCUENTO.Adt_usr, [] )
					.Adt_cod = nvl( c_ADT_DESCUENTO.Adt_cod, [] )
					.Codigo_PK =  nvl( c_ADT_DESCUENTO.Codigo, [] )
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
		return c_ADT_DESCUENTO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_DESCUENTOS' )
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
								from ZooLogic.ADT_DESCUENTOS 
								Where   ADT_DESCUENTOS.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_DESCUENTOS", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Adt_ext" as "Adt_ext", "Inactivofw" as "Inactivofw", "Horaimpo" as "Horaimpo", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_hora" as "Adt_hora", "Esttrans" as "Estadotransferencia", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_DESCUENTOS 
								Where   ADT_DESCUENTOS.ADT_COD != ''
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
	Tabla = 'ADT_DESCUENTOS'
	Filtro = " ADT_DESCUENTOS.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_DESCUENTOS.ADT_COD != ''"
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
	<row entidad="ADT_DESCUENTO                           " atributo="FECHAIMPO                               " tabla="ADT_DESCUENTOS " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="FECHATRANSFERENCIA                      " tabla="ADT_DESCUENTOS " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_DESCUENTOS " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="FECHAEXPO                               " tabla="ADT_DESCUENTOS " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="FECHAALTAFW                             " tabla="ADT_DESCUENTOS " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_FECHA                               " tabla="ADT_DESCUENTOS " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_EXT                                 " tabla="ADT_DESCUENTOS " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="INACTIVOFW                              " tabla="ADT_DESCUENTOS " campo="INACTIVOFW" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Inactivo                                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="HORAIMPO                                " tabla="ADT_DESCUENTOS " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="HORAMODIFICACIONFW                      " tabla="ADT_DESCUENTOS " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="HORAEXPO                                " tabla="ADT_DESCUENTOS " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="SERIEALTAFW                             " tabla="ADT_DESCUENTOS " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="HORAALTAFW                              " tabla="ADT_DESCUENTOS " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_DESCUENTOS " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_DESCUENTOS " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_DESCUENTOS " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ZADSFW                                  " tabla="ADT_DESCUENTOS " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="VERSIONALTAFW                           " tabla="ADT_DESCUENTOS " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="USUARIOALTAFW                           " tabla="ADT_DESCUENTOS " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_SERIE                               " tabla="ADT_DESCUENTOS " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_VERS                                " tabla="ADT_DESCUENTOS " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_COMP                                " tabla="ADT_DESCUENTOS " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_ADN                                 " tabla="ADT_DESCUENTOS " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_DESCUENTOS " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_DESCUENTOS " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_HORA                                " tabla="ADT_DESCUENTOS " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_DESCUENTOS " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_ENT                                 " tabla="ADT_DESCUENTOS " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_USR                                 " tabla="ADT_DESCUENTOS " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="ADT_COD                                 " tabla="ADT_DESCUENTOS " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_DESCUENTO                           " atributo="CODIGO                                  " tabla="ADT_DESCUENTOS " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Descuentos y recargos                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On ADT_DESCUENTOS.CODIGO = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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