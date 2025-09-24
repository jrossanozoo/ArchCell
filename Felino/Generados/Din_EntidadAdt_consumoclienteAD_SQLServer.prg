
define class Din_EntidadADT_CONSUMOCLIENTEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_CONSUMOCLIENTE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUDCCLPK'
	cTablaPrincipal = 'ADT_CONCLI'
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
			local  lxAdt_concliFmodifw, lxAdt_concliFectrans, lxAdt_concliFaltafw, lxAdt_concliFeccomp, lxAdt_concliFecimpo, lxAdt_concliAdt_fecha, lxAdt_concliFecexpo, lxAdt_concliPtovta, lxAdt_concliMonto, lxAdt_concliNum, lxAdt_concliTipcomp, lxAdt_concliAdt_ext, lxAdt_concliValtafw, lxAdt_concliUmodifw, lxAdt_concliVmodifw, lxAdt_concliZadsfw, lxAdt_concliUaltafw, lxAdt_concliSmodifw, lxAdt_concliSaltafw, lxAdt_concliHoraimpo, lxAdt_concliHoraexpo, lxAdt_concliHaltafw, lxAdt_concliHmodifw, lxAdt_concliDb, lxAdt_concliAdt_comp, lxAdt_concliAdt_adn, lxAdt_concliAdt_ent, lxAdt_concliAdt_usr, lxAdt_concliAdt_hora, lxAdt_concliAdt_serie, lxAdt_concliAdt_vers, lxAdt_concliLetra, lxAdt_concliBdaltafw, lxAdt_concliBdmodifw, lxAdt_concliCliente, lxAdt_concliCodcomp, lxAdt_concliEsttrans, lxAdt_concliAdt_cod, lxAdt_concliCodigo, lxAdt_concliLimconsumo
				lxAdt_concliFmodifw =  .Fechamodificacionfw			lxAdt_concliFectrans =  .Fechatransferencia			lxAdt_concliFaltafw =  .Fechaaltafw			lxAdt_concliFeccomp =  .Fechacomp			lxAdt_concliFecimpo =  .Fechaimpo			lxAdt_concliAdt_fecha =  .Adt_fecha			lxAdt_concliFecexpo =  .Fechaexpo			lxAdt_concliPtovta =  .Puntodeventa			lxAdt_concliMonto =  .Monto			lxAdt_concliNum =  .Numero			lxAdt_concliTipcomp =  .Tipocomprobante			lxAdt_concliAdt_ext =  .Adt_ext			lxAdt_concliValtafw =  .Versionaltafw			lxAdt_concliUmodifw =  .Usuariomodificacionfw			lxAdt_concliVmodifw =  .Versionmodificacionfw			lxAdt_concliZadsfw =  .Zadsfw			lxAdt_concliUaltafw =  .Usuarioaltafw			lxAdt_concliSmodifw =  .Seriemodificacionfw			lxAdt_concliSaltafw =  .Seriealtafw			lxAdt_concliHoraimpo =  .Horaimpo			lxAdt_concliHoraexpo =  .Horaexpo			lxAdt_concliHaltafw =  .Horaaltafw			lxAdt_concliHmodifw =  .Horamodificacionfw			lxAdt_concliDb =  .Basededatos			lxAdt_concliAdt_comp =  .Adt_comp			lxAdt_concliAdt_adn =  .Adt_adn			lxAdt_concliAdt_ent =  .Adt_ent			lxAdt_concliAdt_usr =  .Adt_usr			lxAdt_concliAdt_hora =  .Adt_hora			lxAdt_concliAdt_serie =  .Adt_serie			lxAdt_concliAdt_vers =  .Adt_vers			lxAdt_concliLetra =  .Letra			lxAdt_concliBdaltafw =  .Basededatosaltafw			lxAdt_concliBdmodifw =  .Basededatosmodificacionfw			lxAdt_concliCliente =  .Cliente			lxAdt_concliCodcomp =  .Codigocomprobante			lxAdt_concliEsttrans =  .Estadotransferencia			lxAdt_concliAdt_cod =  .Adt_cod			lxAdt_concliCodigo =  upper( .Codigo_PK ) 			lxAdt_concliLimconsumo =  upper( .LimiteConsumo_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_concliAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_CONCLI ( "Fmodifw","Fectrans","Faltafw","Feccomp","Fecimpo","Adt_fecha","Fecexpo","Ptovta","Monto","Num","Tipcomp","Adt_ext","Valtafw","Umodifw","Vmodifw","Zadsfw","Ualtafw","Smodifw","Saltafw","Horaimpo","Horaexpo","Haltafw","Hmodifw","Db","Adt_comp","Adt_adn","Adt_ent","Adt_usr","Adt_hora","Adt_serie","Adt_vers","Letra","Bdaltafw","Bdmodifw","Cliente","Codcomp","Esttrans","Adt_cod","Codigo","Limconsumo" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_concliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFeccomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFecexpo ) + "'" >>, <<lxAdt_concliPtovta >>, <<lxAdt_concliMonto >>, <<lxAdt_concliNum >>, <<lxAdt_concliTipcomp >>, <<iif( lxAdt_concliAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_concliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliLimconsumo ) + "'" >> )
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
			local  lxAdt_concliFmodifw, lxAdt_concliFectrans, lxAdt_concliFaltafw, lxAdt_concliFeccomp, lxAdt_concliFecimpo, lxAdt_concliAdt_fecha, lxAdt_concliFecexpo, lxAdt_concliPtovta, lxAdt_concliMonto, lxAdt_concliNum, lxAdt_concliTipcomp, lxAdt_concliAdt_ext, lxAdt_concliValtafw, lxAdt_concliUmodifw, lxAdt_concliVmodifw, lxAdt_concliZadsfw, lxAdt_concliUaltafw, lxAdt_concliSmodifw, lxAdt_concliSaltafw, lxAdt_concliHoraimpo, lxAdt_concliHoraexpo, lxAdt_concliHaltafw, lxAdt_concliHmodifw, lxAdt_concliDb, lxAdt_concliAdt_comp, lxAdt_concliAdt_adn, lxAdt_concliAdt_ent, lxAdt_concliAdt_usr, lxAdt_concliAdt_hora, lxAdt_concliAdt_serie, lxAdt_concliAdt_vers, lxAdt_concliLetra, lxAdt_concliBdaltafw, lxAdt_concliBdmodifw, lxAdt_concliCliente, lxAdt_concliCodcomp, lxAdt_concliEsttrans, lxAdt_concliAdt_cod, lxAdt_concliCodigo, lxAdt_concliLimconsumo
				lxAdt_concliFmodifw =  .Fechamodificacionfw			lxAdt_concliFectrans =  .Fechatransferencia			lxAdt_concliFaltafw =  .Fechaaltafw			lxAdt_concliFeccomp =  .Fechacomp			lxAdt_concliFecimpo =  .Fechaimpo			lxAdt_concliAdt_fecha =  .Adt_fecha			lxAdt_concliFecexpo =  .Fechaexpo			lxAdt_concliPtovta =  .Puntodeventa			lxAdt_concliMonto =  .Monto			lxAdt_concliNum =  .Numero			lxAdt_concliTipcomp =  .Tipocomprobante			lxAdt_concliAdt_ext =  .Adt_ext			lxAdt_concliValtafw =  .Versionaltafw			lxAdt_concliUmodifw =  .Usuariomodificacionfw			lxAdt_concliVmodifw =  .Versionmodificacionfw			lxAdt_concliZadsfw =  .Zadsfw			lxAdt_concliUaltafw =  .Usuarioaltafw			lxAdt_concliSmodifw =  .Seriemodificacionfw			lxAdt_concliSaltafw =  .Seriealtafw			lxAdt_concliHoraimpo =  .Horaimpo			lxAdt_concliHoraexpo =  .Horaexpo			lxAdt_concliHaltafw =  .Horaaltafw			lxAdt_concliHmodifw =  .Horamodificacionfw			lxAdt_concliDb =  .Basededatos			lxAdt_concliAdt_comp =  .Adt_comp			lxAdt_concliAdt_adn =  .Adt_adn			lxAdt_concliAdt_ent =  .Adt_ent			lxAdt_concliAdt_usr =  .Adt_usr			lxAdt_concliAdt_hora =  .Adt_hora			lxAdt_concliAdt_serie =  .Adt_serie			lxAdt_concliAdt_vers =  .Adt_vers			lxAdt_concliLetra =  .Letra			lxAdt_concliBdaltafw =  .Basededatosaltafw			lxAdt_concliBdmodifw =  .Basededatosmodificacionfw			lxAdt_concliCliente =  .Cliente			lxAdt_concliCodcomp =  .Codigocomprobante			lxAdt_concliEsttrans =  .Estadotransferencia			lxAdt_concliAdt_cod =  .Adt_cod			lxAdt_concliCodigo =  upper( .Codigo_PK ) 			lxAdt_concliLimconsumo =  upper( .LimiteConsumo_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_CONCLI set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_concliFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_concliFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_concliFaltafw ) + "'">>,"Feccomp" = <<"'" + this.ConvertirDateSql( lxAdt_concliFeccomp ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_concliFecimpo ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_concliAdt_fecha ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_concliFecexpo ) + "'">>,"Ptovta" = <<lxAdt_concliPtovta>>,"Monto" = <<lxAdt_concliMonto>>,"Num" = <<lxAdt_concliNum>>,"Tipcomp" = <<lxAdt_concliTipcomp>>,"Adt_ext" = <<iif( lxAdt_concliAdt_ext, 1, 0 )>>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_concliZadsfw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_concliHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_concliHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliHmodifw ) + "'">>,"Db" = <<"'" + this.FormatearTextoSql( lxAdt_concliDb ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_comp ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_adn ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_ent ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_usr ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_hora ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_serie ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_vers ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxAdt_concliLetra ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliBdmodifw ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxAdt_concliCliente ) + "'">>,"Codcomp" = <<"'" + this.FormatearTextoSql( lxAdt_concliCodcomp ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_concliEsttrans ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxAdt_concliCodigo ) + "'">>,"Limconsumo" = <<"'" + this.FormatearTextoSql( lxAdt_concliLimconsumo ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'">> and  ADT_CONCLI.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_CONCLI where " + this.ConvertirFuncionesSql( " ADT_CONCLI.ADT_COD != ''" ) )
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
			Local lxAdt_concliAdt_cod
			lxAdt_concliAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo" from ZooLogic.ADT_CONCLI where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'">> and  ADT_CONCLI.ADT_COD != ''
			endtext
			use in select('c_ADT_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_CONSUMOCLIENTE', set( 'Datasession' ) )

			if reccount( 'c_ADT_CONSUMOCLIENTE' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_concliAdt_cod as Variant
		llRetorno = .t.
		lxAdt_concliAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_CONCLI where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'">> and  ADT_CONCLI.ADT_COD != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo" from ZooLogic.ADT_CONCLI where  ADT_CONCLI.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_CONSUMOCLIENTE', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo" from ZooLogic.ADT_CONCLI where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_CONCLI.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_CONSUMOCLIENTE', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo" from ZooLogic.ADT_CONCLI where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_CONCLI.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_CONSUMOCLIENTE', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo" from ZooLogic.ADT_CONCLI where  ADT_CONCLI.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_CONSUMOCLIENTE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_CONSUMOCLIENTE', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Faltafw,Feccomp,Fecimpo,Adt_fecha,Fecexpo,Ptovta,Monto,Num,Tipcomp,Adt_ext," + ;
"Valtafw,Umodifw,Vmodifw,Zadsfw,Ualtafw,Smodifw,Saltafw,Horaimpo,Horaexpo,Haltafw,Hmodifw,Db,Adt_comp" + ;
",Adt_adn,Adt_ent,Adt_usr,Adt_hora,Adt_serie,Adt_vers,Letra,Bdaltafw,Bdmodifw,Cliente,Codcomp,Esttran" + ;
"s,Adt_cod,Codigo,Limconsumo" + ;
" from ZooLogic.ADT_CONCLI where  ADT_CONCLI.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_concliFmodifw, lxAdt_concliFectrans, lxAdt_concliFaltafw, lxAdt_concliFeccomp, lxAdt_concliFecimpo, lxAdt_concliAdt_fecha, lxAdt_concliFecexpo, lxAdt_concliPtovta, lxAdt_concliMonto, lxAdt_concliNum, lxAdt_concliTipcomp, lxAdt_concliAdt_ext, lxAdt_concliValtafw, lxAdt_concliUmodifw, lxAdt_concliVmodifw, lxAdt_concliZadsfw, lxAdt_concliUaltafw, lxAdt_concliSmodifw, lxAdt_concliSaltafw, lxAdt_concliHoraimpo, lxAdt_concliHoraexpo, lxAdt_concliHaltafw, lxAdt_concliHmodifw, lxAdt_concliDb, lxAdt_concliAdt_comp, lxAdt_concliAdt_adn, lxAdt_concliAdt_ent, lxAdt_concliAdt_usr, lxAdt_concliAdt_hora, lxAdt_concliAdt_serie, lxAdt_concliAdt_vers, lxAdt_concliLetra, lxAdt_concliBdaltafw, lxAdt_concliBdmodifw, lxAdt_concliCliente, lxAdt_concliCodcomp, lxAdt_concliEsttrans, lxAdt_concliAdt_cod, lxAdt_concliCodigo, lxAdt_concliLimconsumo
				lxAdt_concliFmodifw = ctod( '  /  /    ' )			lxAdt_concliFectrans = ctod( '  /  /    ' )			lxAdt_concliFaltafw = ctod( '  /  /    ' )			lxAdt_concliFeccomp = ctod( '  /  /    ' )			lxAdt_concliFecimpo = ctod( '  /  /    ' )			lxAdt_concliAdt_fecha = ctod( '  /  /    ' )			lxAdt_concliFecexpo = ctod( '  /  /    ' )			lxAdt_concliPtovta = 0			lxAdt_concliMonto = 0			lxAdt_concliNum = 0			lxAdt_concliTipcomp = 0			lxAdt_concliAdt_ext = .F.			lxAdt_concliValtafw = []			lxAdt_concliUmodifw = []			lxAdt_concliVmodifw = []			lxAdt_concliZadsfw = []			lxAdt_concliUaltafw = []			lxAdt_concliSmodifw = []			lxAdt_concliSaltafw = []			lxAdt_concliHoraimpo = []			lxAdt_concliHoraexpo = []			lxAdt_concliHaltafw = []			lxAdt_concliHmodifw = []			lxAdt_concliDb = []			lxAdt_concliAdt_comp = []			lxAdt_concliAdt_adn = []			lxAdt_concliAdt_ent = []			lxAdt_concliAdt_usr = []			lxAdt_concliAdt_hora = []			lxAdt_concliAdt_serie = []			lxAdt_concliAdt_vers = []			lxAdt_concliLetra = []			lxAdt_concliBdaltafw = []			lxAdt_concliBdmodifw = []			lxAdt_concliCliente = []			lxAdt_concliCodcomp = []			lxAdt_concliEsttrans = []			lxAdt_concliAdt_cod = []			lxAdt_concliCodigo = []			lxAdt_concliLimconsumo = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_CONCLI where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_CONCLI' + '_' + tcCampo
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
		lcWhere = " Where  ADT_CONCLI.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_CONCLI', '', tnTope )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECCOMP AS FECHACOMP'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVTA AS PUNTODEVENTA'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUM AS NUMERO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPOCOMPROBANTE'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DB AS BASEDEDATOS'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'LIMITECONSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LIMCONSUMO AS LIMITECONSUMO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'FECCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'DB'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'LIMITECONSUMO'
				lcCampo = 'LIMCONSUMO'
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
			local  lxAdt_concliFmodifw, lxAdt_concliFectrans, lxAdt_concliFaltafw, lxAdt_concliFeccomp, lxAdt_concliFecimpo, lxAdt_concliAdt_fecha, lxAdt_concliFecexpo, lxAdt_concliPtovta, lxAdt_concliMonto, lxAdt_concliNum, lxAdt_concliTipcomp, lxAdt_concliAdt_ext, lxAdt_concliValtafw, lxAdt_concliUmodifw, lxAdt_concliVmodifw, lxAdt_concliZadsfw, lxAdt_concliUaltafw, lxAdt_concliSmodifw, lxAdt_concliSaltafw, lxAdt_concliHoraimpo, lxAdt_concliHoraexpo, lxAdt_concliHaltafw, lxAdt_concliHmodifw, lxAdt_concliDb, lxAdt_concliAdt_comp, lxAdt_concliAdt_adn, lxAdt_concliAdt_ent, lxAdt_concliAdt_usr, lxAdt_concliAdt_hora, lxAdt_concliAdt_serie, lxAdt_concliAdt_vers, lxAdt_concliLetra, lxAdt_concliBdaltafw, lxAdt_concliBdmodifw, lxAdt_concliCliente, lxAdt_concliCodcomp, lxAdt_concliEsttrans, lxAdt_concliAdt_cod, lxAdt_concliCodigo, lxAdt_concliLimconsumo
				lxAdt_concliFmodifw =  .Fechamodificacionfw			lxAdt_concliFectrans =  .Fechatransferencia			lxAdt_concliFaltafw =  .Fechaaltafw			lxAdt_concliFeccomp =  .Fechacomp			lxAdt_concliFecimpo =  .Fechaimpo			lxAdt_concliAdt_fecha =  .Adt_fecha			lxAdt_concliFecexpo =  .Fechaexpo			lxAdt_concliPtovta =  .Puntodeventa			lxAdt_concliMonto =  .Monto			lxAdt_concliNum =  .Numero			lxAdt_concliTipcomp =  .Tipocomprobante			lxAdt_concliAdt_ext =  .Adt_ext			lxAdt_concliValtafw =  .Versionaltafw			lxAdt_concliUmodifw =  .Usuariomodificacionfw			lxAdt_concliVmodifw =  .Versionmodificacionfw			lxAdt_concliZadsfw =  .Zadsfw			lxAdt_concliUaltafw =  .Usuarioaltafw			lxAdt_concliSmodifw =  .Seriemodificacionfw			lxAdt_concliSaltafw =  .Seriealtafw			lxAdt_concliHoraimpo =  .Horaimpo			lxAdt_concliHoraexpo =  .Horaexpo			lxAdt_concliHaltafw =  .Horaaltafw			lxAdt_concliHmodifw =  .Horamodificacionfw			lxAdt_concliDb =  .Basededatos			lxAdt_concliAdt_comp =  .Adt_comp			lxAdt_concliAdt_adn =  .Adt_adn			lxAdt_concliAdt_ent =  .Adt_ent			lxAdt_concliAdt_usr =  .Adt_usr			lxAdt_concliAdt_hora =  .Adt_hora			lxAdt_concliAdt_serie =  .Adt_serie			lxAdt_concliAdt_vers =  .Adt_vers			lxAdt_concliLetra =  .Letra			lxAdt_concliBdaltafw =  .Basededatosaltafw			lxAdt_concliBdmodifw =  .Basededatosmodificacionfw			lxAdt_concliCliente =  .Cliente			lxAdt_concliCodcomp =  .Codigocomprobante			lxAdt_concliEsttrans =  .Estadotransferencia			lxAdt_concliAdt_cod =  .Adt_cod			lxAdt_concliCodigo =  upper( .Codigo_PK ) 			lxAdt_concliLimconsumo =  upper( .LimiteConsumo_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_CONCLI ( "Fmodifw","Fectrans","Faltafw","Feccomp","Fecimpo","Adt_fecha","Fecexpo","Ptovta","Monto","Num","Tipcomp","Adt_ext","Valtafw","Umodifw","Vmodifw","Zadsfw","Ualtafw","Smodifw","Saltafw","Horaimpo","Horaexpo","Haltafw","Hmodifw","Db","Adt_comp","Adt_adn","Adt_ent","Adt_usr","Adt_hora","Adt_serie","Adt_vers","Letra","Bdaltafw","Bdmodifw","Cliente","Codcomp","Esttrans","Adt_cod","Codigo","Limconsumo" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_concliFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFeccomp ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_concliFecexpo ) + "'" >>, <<lxAdt_concliPtovta >>, <<lxAdt_concliMonto >>, <<lxAdt_concliNum >>, <<lxAdt_concliTipcomp >>, <<iif( lxAdt_concliAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_concliValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliDb ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliLetra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliCodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_concliLimconsumo ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_CONCLI' 
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
			local  lxAdt_concliFmodifw, lxAdt_concliFectrans, lxAdt_concliFaltafw, lxAdt_concliFeccomp, lxAdt_concliFecimpo, lxAdt_concliAdt_fecha, lxAdt_concliFecexpo, lxAdt_concliPtovta, lxAdt_concliMonto, lxAdt_concliNum, lxAdt_concliTipcomp, lxAdt_concliAdt_ext, lxAdt_concliValtafw, lxAdt_concliUmodifw, lxAdt_concliVmodifw, lxAdt_concliZadsfw, lxAdt_concliUaltafw, lxAdt_concliSmodifw, lxAdt_concliSaltafw, lxAdt_concliHoraimpo, lxAdt_concliHoraexpo, lxAdt_concliHaltafw, lxAdt_concliHmodifw, lxAdt_concliDb, lxAdt_concliAdt_comp, lxAdt_concliAdt_adn, lxAdt_concliAdt_ent, lxAdt_concliAdt_usr, lxAdt_concliAdt_hora, lxAdt_concliAdt_serie, lxAdt_concliAdt_vers, lxAdt_concliLetra, lxAdt_concliBdaltafw, lxAdt_concliBdmodifw, lxAdt_concliCliente, lxAdt_concliCodcomp, lxAdt_concliEsttrans, lxAdt_concliAdt_cod, lxAdt_concliCodigo, lxAdt_concliLimconsumo
				lxAdt_concliFmodifw =  .Fechamodificacionfw			lxAdt_concliFectrans =  .Fechatransferencia			lxAdt_concliFaltafw =  .Fechaaltafw			lxAdt_concliFeccomp =  .Fechacomp			lxAdt_concliFecimpo =  .Fechaimpo			lxAdt_concliAdt_fecha =  .Adt_fecha			lxAdt_concliFecexpo =  .Fechaexpo			lxAdt_concliPtovta =  .Puntodeventa			lxAdt_concliMonto =  .Monto			lxAdt_concliNum =  .Numero			lxAdt_concliTipcomp =  .Tipocomprobante			lxAdt_concliAdt_ext =  .Adt_ext			lxAdt_concliValtafw =  .Versionaltafw			lxAdt_concliUmodifw =  .Usuariomodificacionfw			lxAdt_concliVmodifw =  .Versionmodificacionfw			lxAdt_concliZadsfw =  .Zadsfw			lxAdt_concliUaltafw =  .Usuarioaltafw			lxAdt_concliSmodifw =  .Seriemodificacionfw			lxAdt_concliSaltafw =  .Seriealtafw			lxAdt_concliHoraimpo =  .Horaimpo			lxAdt_concliHoraexpo =  .Horaexpo			lxAdt_concliHaltafw =  .Horaaltafw			lxAdt_concliHmodifw =  .Horamodificacionfw			lxAdt_concliDb =  .Basededatos			lxAdt_concliAdt_comp =  .Adt_comp			lxAdt_concliAdt_adn =  .Adt_adn			lxAdt_concliAdt_ent =  .Adt_ent			lxAdt_concliAdt_usr =  .Adt_usr			lxAdt_concliAdt_hora =  .Adt_hora			lxAdt_concliAdt_serie =  .Adt_serie			lxAdt_concliAdt_vers =  .Adt_vers			lxAdt_concliLetra =  .Letra			lxAdt_concliBdaltafw =  .Basededatosaltafw			lxAdt_concliBdmodifw =  .Basededatosmodificacionfw			lxAdt_concliCliente =  .Cliente			lxAdt_concliCodcomp =  .Codigocomprobante			lxAdt_concliEsttrans =  .Estadotransferencia			lxAdt_concliAdt_cod =  .Adt_cod			lxAdt_concliCodigo =  upper( .Codigo_PK ) 			lxAdt_concliLimconsumo =  upper( .LimiteConsumo_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_CONCLI.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_CONCLI set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_concliFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_concliFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_concliFaltafw ) + "'">>, "Feccomp" = <<"'" + this.ConvertirDateSql( lxAdt_concliFeccomp ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_concliFecimpo ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_concliAdt_fecha ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_concliFecexpo ) + "'">>, "Ptovta" = <<lxAdt_concliPtovta>>, "Monto" = <<lxAdt_concliMonto>>, "Num" = <<lxAdt_concliNum>>, "Tipcomp" = <<lxAdt_concliTipcomp>>, "Adt_ext" = <<iif( lxAdt_concliAdt_ext, 1, 0 )>>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_concliZadsfw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_concliHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_concliHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliHmodifw ) + "'">>, "Db" = <<"'" + this.FormatearTextoSql( lxAdt_concliDb ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_comp ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_adn ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_ent ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_usr ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_hora ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_serie ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_vers ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxAdt_concliLetra ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_concliBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_concliBdmodifw ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxAdt_concliCliente ) + "'">>, "Codcomp" = <<"'" + this.FormatearTextoSql( lxAdt_concliCodcomp ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_concliEsttrans ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_concliAdt_cod ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxAdt_concliCodigo ) + "'">>, "Limconsumo" = <<"'" + this.FormatearTextoSql( lxAdt_concliLimconsumo ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_CONCLI' 
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

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_CONCLI.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_CONCLI where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_CONCLI' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_CONCLI where  ADT_CONCLI.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_CONCLI where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_CONCLI.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_CONSUMOCLIENTE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_CONCLI Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_CONCLI set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FecComp = ] + "'" + this.ConvertirDateSql( &lcCursor..FecComp ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ptoVta = ] + transform( &lcCursor..ptoVta )+ [, monto = ] + transform( &lcCursor..monto )+ [, num = ] + transform( &lcCursor..num )+ [, TipComp = ] + transform( &lcCursor..TipComp )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, db = ] + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..cliente ) + "'"+ [, codcomp = ] + "'" + this.FormatearTextoSql( &lcCursor..codcomp ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, limConsumo = ] + "'" + this.FormatearTextoSql( &lcCursor..limConsumo ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FALTAFW, FecComp, FECIMPO, ADT_Fecha, FECEXPO, ptoVta, monto, num, TipComp, ADT_Ext, VALTAFW, UMODIFW, VMODIFW, ZADSFW, UALTAFW, SMODIFW, SALTAFW, HORAIMPO, HORAEXPO, HALTAFW, HMODIFW, db, ADT_Comp, ADT_ADN, ADT_Ent, ADT_Usr, ADT_Hora, ADT_Serie, ADT_Vers, Letra, BDALTAFW, BDMODIFW, cliente, codcomp, ESTTRANS, ADT_Cod, Codigo, limConsumo
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecComp ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ptoVta ) + ',' + transform( &lcCursor..monto ) + ',' + transform( &lcCursor..num ) + ',' + transform( &lcCursor..TipComp ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..db ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codcomp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..limConsumo ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_CONCLI ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_CONSUMOCLIENTE'
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
			Case  lcAlias == lcPrefijo + 'ADT_CONSUMOCLIENTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_CONSUMOCLIENTE_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_CONCLI')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_CONSUMOCLIENTE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_CONSUMOCLIENTE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_CONSUMOCLIENTE'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_CONSUMOCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FecComp   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_CONCLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_CONCLI
Create Table ZooLogic.TablaTrabajo_ADT_CONCLI ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"feccomp" datetime  null, 
"fecimpo" datetime  null, 
"adt_fecha" datetime  null, 
"fecexpo" datetime  null, 
"ptovta" numeric( 4, 0 )  null, 
"monto" numeric( 16, 2 )  null, 
"num" numeric( 8, 0 )  null, 
"tipcomp" numeric( 2, 0 )  null, 
"adt_ext" bit  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"db" char( 8 )  null, 
"adt_comp" char( 254 )  null, 
"adt_adn" char( 10 )  null, 
"adt_ent" char( 40 )  null, 
"adt_usr" char( 100 )  null, 
"adt_hora" char( 8 )  null, 
"adt_serie" char( 20 )  null, 
"adt_vers" char( 13 )  null, 
"letra" char( 1 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"cliente" char( 5 )  null, 
"codcomp" char( 38 )  null, 
"esttrans" char( 20 )  null, 
"adt_cod" char( 38 )  null, 
"codigo" char( 38 )  null, 
"limconsumo" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_CONCLI' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_CONCLI' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_CONSUMOCLIENTE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('feccomp','feccomp')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('ptovta','ptovta')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('num','num')
			.AgregarMapeo('tipcomp','tipcomp')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('db','db')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('codcomp','codcomp')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('adt_cod','adt_cod')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('limconsumo','limconsumo')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_CONCLI'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECCOMP = isnull( d.FECCOMP, t.FECCOMP ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.PTOVTA = isnull( d.PTOVTA, t.PTOVTA ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.NUM = isnull( d.NUM, t.NUM ),t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.DB = isnull( d.DB, t.DB ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.LIMCONSUMO = isnull( d.LIMCONSUMO, t.LIMCONSUMO )
					from ZooLogic.ADT_CONCLI t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_CONCLI(Fmodifw,Fectrans,Faltafw,Feccomp,Fecimpo,Adt_fecha,Fecexpo,Ptovta,Monto,Num,Tipcomp,Adt_ext,Valtafw,Umodifw,Vmodifw,Zadsfw,Ualtafw,Smodifw,Saltafw,Horaimpo,Horaexpo,Haltafw,Hmodifw,Db,Adt_comp,Adt_adn,Adt_ent,Adt_usr,Adt_hora,Adt_serie,Adt_vers,Letra,Bdaltafw,Bdmodifw,Cliente,Codcomp,Esttrans,Adt_cod,Codigo,Limconsumo)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECCOMP,''),isnull( d.FECIMPO,''),isnull( d.ADT_FECHA,''),isnull( d.FECEXPO,''),isnull( d.PTOVTA,0),isnull( d.MONTO,0),isnull( d.NUM,0),isnull( d.TIPCOMP,0),isnull( d.ADT_EXT,0),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.DB,''),isnull( d.ADT_COMP,''),isnull( d.ADT_ADN,''),isnull( d.ADT_ENT,''),isnull( d.ADT_USR,''),isnull( d.ADT_HORA,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_VERS,''),isnull( d.LETRA,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CLIENTE,''),isnull( d.CODCOMP,''),isnull( d.ESTTRANS,''),isnull( d.ADT_COD,''),isnull( d.CODIGO,''),isnull( d.LIMCONSUMO,'')
						From deleted d left join ZooLogic.ADT_CONCLI pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_CONCLI') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_CONCLI
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_CONSUMOCLIENTE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechacomp = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Fechacomp, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_CONSUMOCLIENTE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Puntodeventa = nvl( c_ADT_CONSUMOCLIENTE.Puntodeventa, 0 )
					.Monto = nvl( c_ADT_CONSUMOCLIENTE.Monto, 0 )
					.Numero = nvl( c_ADT_CONSUMOCLIENTE.Numero, 0 )
					.Tipocomprobante = nvl( c_ADT_CONSUMOCLIENTE.Tipocomprobante, 0 )
					.Adt_ext = nvl( c_ADT_CONSUMOCLIENTE.Adt_ext, .F. )
					.Versionaltafw = nvl( c_ADT_CONSUMOCLIENTE.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_CONSUMOCLIENTE.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ADT_CONSUMOCLIENTE.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuarioaltafw = nvl( c_ADT_CONSUMOCLIENTE.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_ADT_CONSUMOCLIENTE.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_ADT_CONSUMOCLIENTE.Seriealtafw, [] )
					.Horaimpo = nvl( c_ADT_CONSUMOCLIENTE.Horaimpo, [] )
					.Horaexpo = nvl( c_ADT_CONSUMOCLIENTE.Horaexpo, [] )
					.Horaaltafw = nvl( c_ADT_CONSUMOCLIENTE.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_ADT_CONSUMOCLIENTE.Horamodificacionfw, [] )
					.Basededatos = nvl( c_ADT_CONSUMOCLIENTE.Basededatos, [] )
					.Adt_comp = nvl( c_ADT_CONSUMOCLIENTE.Adt_comp, [] )
					.Adt_adn = nvl( c_ADT_CONSUMOCLIENTE.Adt_adn, [] )
					.Adt_ent = nvl( c_ADT_CONSUMOCLIENTE.Adt_ent, [] )
					.Adt_usr = nvl( c_ADT_CONSUMOCLIENTE.Adt_usr, [] )
					.Adt_hora = nvl( c_ADT_CONSUMOCLIENTE.Adt_hora, [] )
					.Adt_serie = nvl( c_ADT_CONSUMOCLIENTE.Adt_serie, [] )
					.Adt_vers = nvl( c_ADT_CONSUMOCLIENTE.Adt_vers, [] )
					.Letra = nvl( c_ADT_CONSUMOCLIENTE.Letra, [] )
					.Basededatosaltafw = nvl( c_ADT_CONSUMOCLIENTE.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_CONSUMOCLIENTE.Basededatosmodificacionfw, [] )
					.Cliente = nvl( c_ADT_CONSUMOCLIENTE.Cliente, [] )
					.Codigocomprobante = nvl( c_ADT_CONSUMOCLIENTE.Codigocomprobante, [] )
					.Estadotransferencia = nvl( c_ADT_CONSUMOCLIENTE.Estadotransferencia, [] )
					.Adt_cod = nvl( c_ADT_CONSUMOCLIENTE.Adt_cod, [] )
					.Codigo_PK =  nvl( c_ADT_CONSUMOCLIENTE.Codigo, [] )
					.Limiteconsumo_PK =  nvl( c_ADT_CONSUMOCLIENTE.Limiteconsumo, [] )
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
		return c_ADT_CONSUMOCLIENTE.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_CONCLI' )
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
								from ZooLogic.ADT_CONCLI 
								Where   ADT_CONCLI.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_CONCLI", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Feccomp" as "Fechacomp", "Fecimpo" as "Fechaimpo", "Adt_fecha" as "Adt_fecha", "Fecexpo" as "Fechaexpo", "Ptovta" as "Puntodeventa", "Monto" as "Monto", "Num" as "Numero", "Tipcomp" as "Tipocomprobante", "Adt_ext" as "Adt_ext", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Db" as "Basededatos", "Adt_comp" as "Adt_comp", "Adt_adn" as "Adt_adn", "Adt_ent" as "Adt_ent", "Adt_usr" as "Adt_usr", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_vers" as "Adt_vers", "Letra" as "Letra", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cliente" as "Cliente", "Codcomp" as "Codigocomprobante", "Esttrans" as "Estadotransferencia", "Adt_cod" as "Adt_cod", "Codigo" as "Codigo", "Limconsumo" as "Limiteconsumo"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_CONCLI 
								Where   ADT_CONCLI.ADT_COD != ''
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
	Tabla = 'ADT_CONCLI'
	Filtro = " ADT_CONCLI.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_CONCLI.ADT_COD != ''"
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
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_CONCLI     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="FECHATRANSFERENCIA                      " tabla="ADT_CONCLI     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="FECHAALTAFW                             " tabla="ADT_CONCLI     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="FECHACOMP                               " tabla="ADT_CONCLI     " campo="FECCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha comprobante                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="FECHAIMPO                               " tabla="ADT_CONCLI     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_FECHA                               " tabla="ADT_CONCLI     " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="FECHAEXPO                               " tabla="ADT_CONCLI     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="PUNTODEVENTA                            " tabla="ADT_CONCLI     " campo="PTOVTA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Punto de Venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="MONTO                                   " tabla="ADT_CONCLI     " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Total                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="NUMERO                                  " tabla="ADT_CONCLI     " campo="NUM       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="TIPOCOMPROBANTE                         " tabla="ADT_CONCLI     " campo="TIPCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Tipo comprobante                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_EXT                                 " tabla="ADT_CONCLI     " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="VERSIONALTAFW                           " tabla="ADT_CONCLI     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_CONCLI     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_CONCLI     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ZADSFW                                  " tabla="ADT_CONCLI     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="USUARIOALTAFW                           " tabla="ADT_CONCLI     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_CONCLI     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="SERIEALTAFW                             " tabla="ADT_CONCLI     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="HORAIMPO                                " tabla="ADT_CONCLI     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="HORAEXPO                                " tabla="ADT_CONCLI     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="HORAALTAFW                              " tabla="ADT_CONCLI     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="HORAMODIFICACIONFW                      " tabla="ADT_CONCLI     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="BASEDEDATOS                             " tabla="ADT_CONCLI     " campo="DB        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_COMP                                " tabla="ADT_CONCLI     " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_ADN                                 " tabla="ADT_CONCLI     " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_ENT                                 " tabla="ADT_CONCLI     " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_USR                                 " tabla="ADT_CONCLI     " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_HORA                                " tabla="ADT_CONCLI     " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_SERIE                               " tabla="ADT_CONCLI     " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_VERS                                " tabla="ADT_CONCLI     " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="LETRA                                   " tabla="ADT_CONCLI     " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_CONCLI     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_CONCLI     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="CLIENTE                                 " tabla="ADT_CONCLI     " campo="CLIENTE   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Cliente                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="CODIGOCOMPROBANTE                       " tabla="ADT_CONCLI     " campo="CODCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo comprobante                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_CONCLI     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="ADT_COD                                 " tabla="ADT_CONCLI     " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="CODIGO                                  " tabla="ADT_CONCLI     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ConsumoCliente                          " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Consumo de clientes                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_CONSUMOCLIENTE                      " atributo="LIMITECONSUMO                           " tabla="ADT_CONCLI     " campo="LIMCONSUMO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LIMITECONSUMO                           " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Limite Consumo                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONSUMOCLIENTE                          " atributo="CLIENTE                                 " tabla="CONCLI         " campo="CLIENTE   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Con.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCLI On ADT_CONCLI.CODIGO = CONCLI.Codigo And  CONCLI.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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