
define class Din_EntidadADT_LIMITECONSUMOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_LIMITECONSUMO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUDLCNPK'
	cTablaPrincipal = 'ADT_LCONSUMO'
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
			local  lxAdt_lconsumoFechahasta, lxAdt_lconsumoFmodifw, lxAdt_lconsumoFechadesde, lxAdt_lconsumoFectrans, lxAdt_lconsumoFaltafw, lxAdt_lconsumoAdt_fecha, lxAdt_lconsumoFecimpo, lxAdt_lconsumoFecexpo, lxAdt_lconsumoNumero, lxAdt_lconsumoMonto, lxAdt_lconsumoAdt_ext, lxAdt_lconsumoHaltafw, lxAdt_lconsumoHoraexpo, lxAdt_lconsumoHmodifw, lxAdt_lconsumoVmodifw, lxAdt_lconsumoZadsfw, lxAdt_lconsumoValtafw, lxAdt_lconsumoUaltafw, lxAdt_lconsumoUmodifw, lxAdt_lconsumoSaltafw, lxAdt_lconsumoSmodifw, lxAdt_lconsumoHoraimpo, lxAdt_lconsumoBdmodifw, lxAdt_lconsumoAdt_usr, lxAdt_lconsumoAdt_ent, lxAdt_lconsumoAdt_serie, lxAdt_lconsumoAdt_comp, lxAdt_lconsumoAdt_hora, lxAdt_lconsumoAdt_vers, lxAdt_lconsumoAdt_adn, lxAdt_lconsumoEsttrans, lxAdt_lconsumoBdaltafw, lxAdt_lconsumoAdt_cod, lxAdt_lconsumoCliente, lxAdt_lconsumoCodint
				lxAdt_lconsumoFechahasta =  .Fechahasta			lxAdt_lconsumoFmodifw =  .Fechamodificacionfw			lxAdt_lconsumoFechadesde =  .Fechadesde			lxAdt_lconsumoFectrans =  .Fechatransferencia			lxAdt_lconsumoFaltafw =  .Fechaaltafw			lxAdt_lconsumoAdt_fecha =  .Adt_fecha			lxAdt_lconsumoFecimpo =  .Fechaimpo			lxAdt_lconsumoFecexpo =  .Fechaexpo			lxAdt_lconsumoNumero =  .Numero			lxAdt_lconsumoMonto =  .Monto			lxAdt_lconsumoAdt_ext =  .Adt_ext			lxAdt_lconsumoHaltafw =  .Horaaltafw			lxAdt_lconsumoHoraexpo =  .Horaexpo			lxAdt_lconsumoHmodifw =  .Horamodificacionfw			lxAdt_lconsumoVmodifw =  .Versionmodificacionfw			lxAdt_lconsumoZadsfw =  .Zadsfw			lxAdt_lconsumoValtafw =  .Versionaltafw			lxAdt_lconsumoUaltafw =  .Usuarioaltafw			lxAdt_lconsumoUmodifw =  .Usuariomodificacionfw			lxAdt_lconsumoSaltafw =  .Seriealtafw			lxAdt_lconsumoSmodifw =  .Seriemodificacionfw			lxAdt_lconsumoHoraimpo =  .Horaimpo			lxAdt_lconsumoBdmodifw =  .Basededatosmodificacionfw			lxAdt_lconsumoAdt_usr =  .Adt_usr			lxAdt_lconsumoAdt_ent =  .Adt_ent			lxAdt_lconsumoAdt_serie =  .Adt_serie			lxAdt_lconsumoAdt_comp =  .Adt_comp			lxAdt_lconsumoAdt_hora =  .Adt_hora			lxAdt_lconsumoAdt_vers =  .Adt_vers			lxAdt_lconsumoAdt_adn =  .Adt_adn			lxAdt_lconsumoEsttrans =  .Estadotransferencia			lxAdt_lconsumoBdaltafw =  .Basededatosaltafw			lxAdt_lconsumoAdt_cod =  .Adt_cod			lxAdt_lconsumoCliente =  upper( .Cliente_PK ) 			lxAdt_lconsumoCodint =  upper( .CodInt_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_lconsumoAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_LCONSUMO ( "Fechahasta","Fmodifw","Fechadesde","Fectrans","Faltafw","Adt_fecha","Fecimpo","Fecexpo","Numero","Monto","Adt_ext","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Bdmodifw","Adt_usr","Adt_ent","Adt_serie","Adt_comp","Adt_hora","Adt_vers","Adt_adn","Esttrans","Bdaltafw","Adt_cod","Cliente","Codint" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechahasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechadesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecexpo ) + "'" >>, <<lxAdt_lconsumoNumero >>, <<lxAdt_lconsumoMonto >>, <<iif( lxAdt_lconsumoAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCodint ) + "'" >> )
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
			local  lxAdt_lconsumoFechahasta, lxAdt_lconsumoFmodifw, lxAdt_lconsumoFechadesde, lxAdt_lconsumoFectrans, lxAdt_lconsumoFaltafw, lxAdt_lconsumoAdt_fecha, lxAdt_lconsumoFecimpo, lxAdt_lconsumoFecexpo, lxAdt_lconsumoNumero, lxAdt_lconsumoMonto, lxAdt_lconsumoAdt_ext, lxAdt_lconsumoHaltafw, lxAdt_lconsumoHoraexpo, lxAdt_lconsumoHmodifw, lxAdt_lconsumoVmodifw, lxAdt_lconsumoZadsfw, lxAdt_lconsumoValtafw, lxAdt_lconsumoUaltafw, lxAdt_lconsumoUmodifw, lxAdt_lconsumoSaltafw, lxAdt_lconsumoSmodifw, lxAdt_lconsumoHoraimpo, lxAdt_lconsumoBdmodifw, lxAdt_lconsumoAdt_usr, lxAdt_lconsumoAdt_ent, lxAdt_lconsumoAdt_serie, lxAdt_lconsumoAdt_comp, lxAdt_lconsumoAdt_hora, lxAdt_lconsumoAdt_vers, lxAdt_lconsumoAdt_adn, lxAdt_lconsumoEsttrans, lxAdt_lconsumoBdaltafw, lxAdt_lconsumoAdt_cod, lxAdt_lconsumoCliente, lxAdt_lconsumoCodint
				lxAdt_lconsumoFechahasta =  .Fechahasta			lxAdt_lconsumoFmodifw =  .Fechamodificacionfw			lxAdt_lconsumoFechadesde =  .Fechadesde			lxAdt_lconsumoFectrans =  .Fechatransferencia			lxAdt_lconsumoFaltafw =  .Fechaaltafw			lxAdt_lconsumoAdt_fecha =  .Adt_fecha			lxAdt_lconsumoFecimpo =  .Fechaimpo			lxAdt_lconsumoFecexpo =  .Fechaexpo			lxAdt_lconsumoNumero =  .Numero			lxAdt_lconsumoMonto =  .Monto			lxAdt_lconsumoAdt_ext =  .Adt_ext			lxAdt_lconsumoHaltafw =  .Horaaltafw			lxAdt_lconsumoHoraexpo =  .Horaexpo			lxAdt_lconsumoHmodifw =  .Horamodificacionfw			lxAdt_lconsumoVmodifw =  .Versionmodificacionfw			lxAdt_lconsumoZadsfw =  .Zadsfw			lxAdt_lconsumoValtafw =  .Versionaltafw			lxAdt_lconsumoUaltafw =  .Usuarioaltafw			lxAdt_lconsumoUmodifw =  .Usuariomodificacionfw			lxAdt_lconsumoSaltafw =  .Seriealtafw			lxAdt_lconsumoSmodifw =  .Seriemodificacionfw			lxAdt_lconsumoHoraimpo =  .Horaimpo			lxAdt_lconsumoBdmodifw =  .Basededatosmodificacionfw			lxAdt_lconsumoAdt_usr =  .Adt_usr			lxAdt_lconsumoAdt_ent =  .Adt_ent			lxAdt_lconsumoAdt_serie =  .Adt_serie			lxAdt_lconsumoAdt_comp =  .Adt_comp			lxAdt_lconsumoAdt_hora =  .Adt_hora			lxAdt_lconsumoAdt_vers =  .Adt_vers			lxAdt_lconsumoAdt_adn =  .Adt_adn			lxAdt_lconsumoEsttrans =  .Estadotransferencia			lxAdt_lconsumoBdaltafw =  .Basededatosaltafw			lxAdt_lconsumoAdt_cod =  .Adt_cod			lxAdt_lconsumoCliente =  upper( .Cliente_PK ) 			lxAdt_lconsumoCodint =  upper( .CodInt_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_LCONSUMO set "Fechahasta" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechahasta ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFmodifw ) + "'">>,"Fechadesde" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechadesde ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFaltafw ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoAdt_fecha ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecexpo ) + "'">>,"Numero" = <<lxAdt_lconsumoNumero>>,"Monto" = <<lxAdt_lconsumoMonto>>,"Adt_ext" = <<iif( lxAdt_lconsumoAdt_ext, 1, 0 )>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdmodifw ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_usr ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_ent ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_serie ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_comp ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_hora ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_vers ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_adn ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdaltafw ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCliente ) + "'">>,"Codint" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCodint ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'">> and  ADT_LCONSUMO.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_LCONSUMO where " + this.ConvertirFuncionesSql( " ADT_LCONSUMO.ADT_COD != ''" ) )
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
			Local lxAdt_lconsumoAdt_cod
			lxAdt_lconsumoAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint" from ZooLogic.ADT_LCONSUMO where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'">> and  ADT_LCONSUMO.ADT_COD != ''
			endtext
			use in select('c_ADT_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_LIMITECONSUMO', set( 'Datasession' ) )

			if reccount( 'c_ADT_LIMITECONSUMO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_lconsumoAdt_cod as Variant
		llRetorno = .t.
		lxAdt_lconsumoAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_LCONSUMO where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'">> and  ADT_LCONSUMO.ADT_COD != ''
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
				select top 1 "Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint" from ZooLogic.ADT_LCONSUMO where  ADT_LCONSUMO.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_LIMITECONSUMO', set( 'Datasession' ) )
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
				select top 1 "Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint" from ZooLogic.ADT_LCONSUMO where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_LCONSUMO.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_LIMITECONSUMO', set( 'Datasession' ) )
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
				select top 1 "Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint" from ZooLogic.ADT_LCONSUMO where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_LCONSUMO.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_LIMITECONSUMO', set( 'Datasession' ) )
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
				select top 1 "Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint" from ZooLogic.ADT_LCONSUMO where  ADT_LCONSUMO.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_LIMITECONSUMO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fechahasta,Fmodifw,Fechadesde,Fectrans,Faltafw,Adt_fecha,Fecimpo,Fecexpo,Numero,Monto,Adt_ex" + ;
"t,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Saltafw,Smodifw,Horaimpo,Bdmodifw," + ;
"Adt_usr,Adt_ent,Adt_serie,Adt_comp,Adt_hora,Adt_vers,Adt_adn,Esttrans,Bdaltafw,Adt_cod,Cliente,Codin" + ;
"t" + ;
" from ZooLogic.ADT_LCONSUMO where  ADT_LCONSUMO.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_lconsumoFechahasta, lxAdt_lconsumoFmodifw, lxAdt_lconsumoFechadesde, lxAdt_lconsumoFectrans, lxAdt_lconsumoFaltafw, lxAdt_lconsumoAdt_fecha, lxAdt_lconsumoFecimpo, lxAdt_lconsumoFecexpo, lxAdt_lconsumoNumero, lxAdt_lconsumoMonto, lxAdt_lconsumoAdt_ext, lxAdt_lconsumoHaltafw, lxAdt_lconsumoHoraexpo, lxAdt_lconsumoHmodifw, lxAdt_lconsumoVmodifw, lxAdt_lconsumoZadsfw, lxAdt_lconsumoValtafw, lxAdt_lconsumoUaltafw, lxAdt_lconsumoUmodifw, lxAdt_lconsumoSaltafw, lxAdt_lconsumoSmodifw, lxAdt_lconsumoHoraimpo, lxAdt_lconsumoBdmodifw, lxAdt_lconsumoAdt_usr, lxAdt_lconsumoAdt_ent, lxAdt_lconsumoAdt_serie, lxAdt_lconsumoAdt_comp, lxAdt_lconsumoAdt_hora, lxAdt_lconsumoAdt_vers, lxAdt_lconsumoAdt_adn, lxAdt_lconsumoEsttrans, lxAdt_lconsumoBdaltafw, lxAdt_lconsumoAdt_cod, lxAdt_lconsumoCliente, lxAdt_lconsumoCodint
				lxAdt_lconsumoFechahasta = ctod( '  /  /    ' )			lxAdt_lconsumoFmodifw = ctod( '  /  /    ' )			lxAdt_lconsumoFechadesde = ctod( '  /  /    ' )			lxAdt_lconsumoFectrans = ctod( '  /  /    ' )			lxAdt_lconsumoFaltafw = ctod( '  /  /    ' )			lxAdt_lconsumoAdt_fecha = ctod( '  /  /    ' )			lxAdt_lconsumoFecimpo = ctod( '  /  /    ' )			lxAdt_lconsumoFecexpo = ctod( '  /  /    ' )			lxAdt_lconsumoNumero = 0			lxAdt_lconsumoMonto = 0			lxAdt_lconsumoAdt_ext = .F.			lxAdt_lconsumoHaltafw = []			lxAdt_lconsumoHoraexpo = []			lxAdt_lconsumoHmodifw = []			lxAdt_lconsumoVmodifw = []			lxAdt_lconsumoZadsfw = []			lxAdt_lconsumoValtafw = []			lxAdt_lconsumoUaltafw = []			lxAdt_lconsumoUmodifw = []			lxAdt_lconsumoSaltafw = []			lxAdt_lconsumoSmodifw = []			lxAdt_lconsumoHoraimpo = []			lxAdt_lconsumoBdmodifw = []			lxAdt_lconsumoAdt_usr = []			lxAdt_lconsumoAdt_ent = []			lxAdt_lconsumoAdt_serie = []			lxAdt_lconsumoAdt_comp = []			lxAdt_lconsumoAdt_hora = []			lxAdt_lconsumoAdt_vers = []			lxAdt_lconsumoAdt_adn = []			lxAdt_lconsumoEsttrans = []			lxAdt_lconsumoBdaltafw = []			lxAdt_lconsumoAdt_cod = []			lxAdt_lconsumoCliente = []			lxAdt_lconsumoCodint = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_LCONSUMO where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_LCONSUMO' + '_' + tcCampo
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
		lcWhere = " Where  ADT_LCONSUMO.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_LCONSUMO', '', tnTope )
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
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAHASTA AS FECHAHASTA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHADESDE AS FECHADESDE'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
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
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CODINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODINT'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CODINT'
				lcCampo = 'CODINT'
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
			local  lxAdt_lconsumoFechahasta, lxAdt_lconsumoFmodifw, lxAdt_lconsumoFechadesde, lxAdt_lconsumoFectrans, lxAdt_lconsumoFaltafw, lxAdt_lconsumoAdt_fecha, lxAdt_lconsumoFecimpo, lxAdt_lconsumoFecexpo, lxAdt_lconsumoNumero, lxAdt_lconsumoMonto, lxAdt_lconsumoAdt_ext, lxAdt_lconsumoHaltafw, lxAdt_lconsumoHoraexpo, lxAdt_lconsumoHmodifw, lxAdt_lconsumoVmodifw, lxAdt_lconsumoZadsfw, lxAdt_lconsumoValtafw, lxAdt_lconsumoUaltafw, lxAdt_lconsumoUmodifw, lxAdt_lconsumoSaltafw, lxAdt_lconsumoSmodifw, lxAdt_lconsumoHoraimpo, lxAdt_lconsumoBdmodifw, lxAdt_lconsumoAdt_usr, lxAdt_lconsumoAdt_ent, lxAdt_lconsumoAdt_serie, lxAdt_lconsumoAdt_comp, lxAdt_lconsumoAdt_hora, lxAdt_lconsumoAdt_vers, lxAdt_lconsumoAdt_adn, lxAdt_lconsumoEsttrans, lxAdt_lconsumoBdaltafw, lxAdt_lconsumoAdt_cod, lxAdt_lconsumoCliente, lxAdt_lconsumoCodint
				lxAdt_lconsumoFechahasta =  .Fechahasta			lxAdt_lconsumoFmodifw =  .Fechamodificacionfw			lxAdt_lconsumoFechadesde =  .Fechadesde			lxAdt_lconsumoFectrans =  .Fechatransferencia			lxAdt_lconsumoFaltafw =  .Fechaaltafw			lxAdt_lconsumoAdt_fecha =  .Adt_fecha			lxAdt_lconsumoFecimpo =  .Fechaimpo			lxAdt_lconsumoFecexpo =  .Fechaexpo			lxAdt_lconsumoNumero =  .Numero			lxAdt_lconsumoMonto =  .Monto			lxAdt_lconsumoAdt_ext =  .Adt_ext			lxAdt_lconsumoHaltafw =  .Horaaltafw			lxAdt_lconsumoHoraexpo =  .Horaexpo			lxAdt_lconsumoHmodifw =  .Horamodificacionfw			lxAdt_lconsumoVmodifw =  .Versionmodificacionfw			lxAdt_lconsumoZadsfw =  .Zadsfw			lxAdt_lconsumoValtafw =  .Versionaltafw			lxAdt_lconsumoUaltafw =  .Usuarioaltafw			lxAdt_lconsumoUmodifw =  .Usuariomodificacionfw			lxAdt_lconsumoSaltafw =  .Seriealtafw			lxAdt_lconsumoSmodifw =  .Seriemodificacionfw			lxAdt_lconsumoHoraimpo =  .Horaimpo			lxAdt_lconsumoBdmodifw =  .Basededatosmodificacionfw			lxAdt_lconsumoAdt_usr =  .Adt_usr			lxAdt_lconsumoAdt_ent =  .Adt_ent			lxAdt_lconsumoAdt_serie =  .Adt_serie			lxAdt_lconsumoAdt_comp =  .Adt_comp			lxAdt_lconsumoAdt_hora =  .Adt_hora			lxAdt_lconsumoAdt_vers =  .Adt_vers			lxAdt_lconsumoAdt_adn =  .Adt_adn			lxAdt_lconsumoEsttrans =  .Estadotransferencia			lxAdt_lconsumoBdaltafw =  .Basededatosaltafw			lxAdt_lconsumoAdt_cod =  .Adt_cod			lxAdt_lconsumoCliente =  upper( .Cliente_PK ) 			lxAdt_lconsumoCodint =  upper( .CodInt_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_LCONSUMO ( "Fechahasta","Fmodifw","Fechadesde","Fectrans","Faltafw","Adt_fecha","Fecimpo","Fecexpo","Numero","Monto","Adt_ext","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Bdmodifw","Adt_usr","Adt_ent","Adt_serie","Adt_comp","Adt_hora","Adt_vers","Adt_adn","Esttrans","Bdaltafw","Adt_cod","Cliente","Codint" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechahasta ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechadesde ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecexpo ) + "'" >>, <<lxAdt_lconsumoNumero >>, <<lxAdt_lconsumoMonto >>, <<iif( lxAdt_lconsumoAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCodint ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_LCONSUMO' 
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
			local  lxAdt_lconsumoFechahasta, lxAdt_lconsumoFmodifw, lxAdt_lconsumoFechadesde, lxAdt_lconsumoFectrans, lxAdt_lconsumoFaltafw, lxAdt_lconsumoAdt_fecha, lxAdt_lconsumoFecimpo, lxAdt_lconsumoFecexpo, lxAdt_lconsumoNumero, lxAdt_lconsumoMonto, lxAdt_lconsumoAdt_ext, lxAdt_lconsumoHaltafw, lxAdt_lconsumoHoraexpo, lxAdt_lconsumoHmodifw, lxAdt_lconsumoVmodifw, lxAdt_lconsumoZadsfw, lxAdt_lconsumoValtafw, lxAdt_lconsumoUaltafw, lxAdt_lconsumoUmodifw, lxAdt_lconsumoSaltafw, lxAdt_lconsumoSmodifw, lxAdt_lconsumoHoraimpo, lxAdt_lconsumoBdmodifw, lxAdt_lconsumoAdt_usr, lxAdt_lconsumoAdt_ent, lxAdt_lconsumoAdt_serie, lxAdt_lconsumoAdt_comp, lxAdt_lconsumoAdt_hora, lxAdt_lconsumoAdt_vers, lxAdt_lconsumoAdt_adn, lxAdt_lconsumoEsttrans, lxAdt_lconsumoBdaltafw, lxAdt_lconsumoAdt_cod, lxAdt_lconsumoCliente, lxAdt_lconsumoCodint
				lxAdt_lconsumoFechahasta =  .Fechahasta			lxAdt_lconsumoFmodifw =  .Fechamodificacionfw			lxAdt_lconsumoFechadesde =  .Fechadesde			lxAdt_lconsumoFectrans =  .Fechatransferencia			lxAdt_lconsumoFaltafw =  .Fechaaltafw			lxAdt_lconsumoAdt_fecha =  .Adt_fecha			lxAdt_lconsumoFecimpo =  .Fechaimpo			lxAdt_lconsumoFecexpo =  .Fechaexpo			lxAdt_lconsumoNumero =  .Numero			lxAdt_lconsumoMonto =  .Monto			lxAdt_lconsumoAdt_ext =  .Adt_ext			lxAdt_lconsumoHaltafw =  .Horaaltafw			lxAdt_lconsumoHoraexpo =  .Horaexpo			lxAdt_lconsumoHmodifw =  .Horamodificacionfw			lxAdt_lconsumoVmodifw =  .Versionmodificacionfw			lxAdt_lconsumoZadsfw =  .Zadsfw			lxAdt_lconsumoValtafw =  .Versionaltafw			lxAdt_lconsumoUaltafw =  .Usuarioaltafw			lxAdt_lconsumoUmodifw =  .Usuariomodificacionfw			lxAdt_lconsumoSaltafw =  .Seriealtafw			lxAdt_lconsumoSmodifw =  .Seriemodificacionfw			lxAdt_lconsumoHoraimpo =  .Horaimpo			lxAdt_lconsumoBdmodifw =  .Basededatosmodificacionfw			lxAdt_lconsumoAdt_usr =  .Adt_usr			lxAdt_lconsumoAdt_ent =  .Adt_ent			lxAdt_lconsumoAdt_serie =  .Adt_serie			lxAdt_lconsumoAdt_comp =  .Adt_comp			lxAdt_lconsumoAdt_hora =  .Adt_hora			lxAdt_lconsumoAdt_vers =  .Adt_vers			lxAdt_lconsumoAdt_adn =  .Adt_adn			lxAdt_lconsumoEsttrans =  .Estadotransferencia			lxAdt_lconsumoBdaltafw =  .Basededatosaltafw			lxAdt_lconsumoAdt_cod =  .Adt_cod			lxAdt_lconsumoCliente =  upper( .Cliente_PK ) 			lxAdt_lconsumoCodint =  upper( .CodInt_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_LCONSUMO.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_LCONSUMO set "Fechahasta" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechahasta ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFmodifw ) + "'">>, "Fechadesde" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFechadesde ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFaltafw ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoAdt_fecha ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_lconsumoFecexpo ) + "'">>, "Numero" = <<lxAdt_lconsumoNumero>>, "Monto" = <<lxAdt_lconsumoMonto>>, "Adt_ext" = <<iif( lxAdt_lconsumoAdt_ext, 1, 0 )>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdmodifw ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_usr ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_ent ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_serie ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_comp ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_hora ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_vers ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_adn ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoBdaltafw ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoAdt_cod ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCliente ) + "'">>, "Codint" = <<"'" + this.FormatearTextoSql( lxAdt_lconsumoCodint ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_LCONSUMO' 
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

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_LCONSUMO.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_LCONSUMO where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_LCONSUMO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_LCONSUMO where  ADT_LCONSUMO.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_LCONSUMO where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_LCONSUMO.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_LIMITECONSUMO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_LCONSUMO Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_LCONSUMO set  FechaHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaHasta ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FechaDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaDesde ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, Monto = ] + transform( &lcCursor..Monto )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FechaHasta, FMODIFW, FechaDesde, FECTRANS, FALTAFW, ADT_Fecha, FECIMPO, FECEXPO, NUMERO, Monto, ADT_Ext, HALTAFW, HORAEXPO, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, HORAIMPO, BDMODIFW, ADT_Usr, ADT_Ent, ADT_Serie, ADT_Comp, ADT_Hora, ADT_Vers, ADT_ADN, ESTTRANS, BDALTAFW, ADT_Cod, Cliente, CodInt
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaHasta ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaDesde ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..NUMERO ) + ',' + transform( &lcCursor..Monto ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_LCONSUMO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_LIMITECONSUMO'
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
			Case  lcAlias == lcPrefijo + 'ADT_LIMITECONSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_LIMITECONSUMO_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_LCONSUMO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_LIMITECONSUMO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_LIMITECONSUMO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_LIMITECONSUMO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_LIMITECONSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FechaHasta
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FechaDesde
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_LCONSUMO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_LCONSUMO
Create Table ZooLogic.TablaTrabajo_ADT_LCONSUMO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fechahasta" datetime  null, 
"fmodifw" datetime  null, 
"fechadesde" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"adt_fecha" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"monto" numeric( 15, 2 )  null, 
"adt_ext" bit  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_usr" char( 100 )  null, 
"adt_ent" char( 40 )  null, 
"adt_serie" char( 20 )  null, 
"adt_comp" char( 254 )  null, 
"adt_hora" char( 8 )  null, 
"adt_vers" char( 13 )  null, 
"adt_adn" char( 10 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"adt_cod" char( 38 )  null, 
"cliente" char( 5 )  null, 
"codint" char( 38 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_LCONSUMO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_LCONSUMO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_LIMITECONSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fechahasta','fechahasta')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fechadesde','fechadesde')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('adt_cod','adt_cod')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('codint','codint')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_LCONSUMO'
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
				Update t Set t.FECHAHASTA = isnull( d.FECHAHASTA, t.FECHAHASTA ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECHADESDE = isnull( d.FECHADESDE, t.FECHADESDE ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.CODINT = isnull( d.CODINT, t.CODINT )
					from ZooLogic.ADT_LCONSUMO t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_LCONSUMO(Fechahasta,Fmodifw,Fechadesde,Fectrans,Faltafw,Adt_fecha,Fecimpo,Fecexpo,Numero,Monto,Adt_ext,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Saltafw,Smodifw,Horaimpo,Bdmodifw,Adt_usr,Adt_ent,Adt_serie,Adt_comp,Adt_hora,Adt_vers,Adt_adn,Esttrans,Bdaltafw,Adt_cod,Cliente,Codint)
					Select isnull( d.FECHAHASTA,''),isnull( d.FMODIFW,''),isnull( d.FECHADESDE,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.ADT_FECHA,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.NUMERO,0),isnull( d.MONTO,0),isnull( d.ADT_EXT,0),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.ADT_USR,''),isnull( d.ADT_ENT,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_COMP,''),isnull( d.ADT_HORA,''),isnull( d.ADT_VERS,''),isnull( d.ADT_ADN,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.ADT_COD,''),isnull( d.CLIENTE,''),isnull( d.CODINT,'')
						From deleted d left join ZooLogic.ADT_LCONSUMO pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_LCONSUMO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_LCONSUMO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_LIMITECONSUMO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechahasta, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_LIMITECONSUMO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_ADT_LIMITECONSUMO.Numero, 0 )
					.Monto = nvl( c_ADT_LIMITECONSUMO.Monto, 0 )
					.Adt_ext = nvl( c_ADT_LIMITECONSUMO.Adt_ext, .F. )
					.Horaaltafw = nvl( c_ADT_LIMITECONSUMO.Horaaltafw, [] )
					.Horaexpo = nvl( c_ADT_LIMITECONSUMO.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_ADT_LIMITECONSUMO.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_ADT_LIMITECONSUMO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ADT_LIMITECONSUMO.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_ADT_LIMITECONSUMO.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_LIMITECONSUMO.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_ADT_LIMITECONSUMO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_ADT_LIMITECONSUMO.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_ADT_LIMITECONSUMO.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_LIMITECONSUMO.Basededatosmodificacionfw, [] )
					.Adt_usr = nvl( c_ADT_LIMITECONSUMO.Adt_usr, [] )
					.Adt_ent = nvl( c_ADT_LIMITECONSUMO.Adt_ent, [] )
					.Adt_serie = nvl( c_ADT_LIMITECONSUMO.Adt_serie, [] )
					.Adt_comp = nvl( c_ADT_LIMITECONSUMO.Adt_comp, [] )
					.Adt_hora = nvl( c_ADT_LIMITECONSUMO.Adt_hora, [] )
					.Adt_vers = nvl( c_ADT_LIMITECONSUMO.Adt_vers, [] )
					.Adt_adn = nvl( c_ADT_LIMITECONSUMO.Adt_adn, [] )
					.Estadotransferencia = nvl( c_ADT_LIMITECONSUMO.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_ADT_LIMITECONSUMO.Basededatosaltafw, [] )
					.Adt_cod = nvl( c_ADT_LIMITECONSUMO.Adt_cod, [] )
					.Cliente_PK =  nvl( c_ADT_LIMITECONSUMO.Cliente, [] )
					.Codint_PK =  nvl( c_ADT_LIMITECONSUMO.Codint, [] )
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
		return c_ADT_LIMITECONSUMO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_LCONSUMO' )
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
								from ZooLogic.ADT_LCONSUMO 
								Where   ADT_LCONSUMO.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_LCONSUMO", "", lcCursor, set("Datasession") )
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
			"Fechahasta" as "Fechahasta", "Fmodifw" as "Fechamodificacionfw", "Fechadesde" as "Fechadesde", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Adt_fecha" as "Adt_fecha", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Numero" as "Numero", "Monto" as "Monto", "Adt_ext" as "Adt_ext", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_usr" as "Adt_usr", "Adt_ent" as "Adt_ent", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Adt_hora" as "Adt_hora", "Adt_vers" as "Adt_vers", "Adt_adn" as "Adt_adn", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Adt_cod" as "Adt_cod", "Cliente" as "Cliente", "Codint" as "Codint"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_LCONSUMO 
								Where   ADT_LCONSUMO.ADT_COD != ''
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
	Tabla = 'ADT_LCONSUMO'
	Filtro = " ADT_LCONSUMO.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_LCONSUMO.ADT_COD != ''"
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
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHAHASTA                              " tabla="ADT_LCONSUMO   " campo="FECHAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha hasta                                                                                                                                                     " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_LCONSUMO   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHADESDE                              " tabla="ADT_LCONSUMO   " campo="FECHADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Fecha desde                                                                                                                                                     " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHATRANSFERENCIA                      " tabla="ADT_LCONSUMO   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHAALTAFW                             " tabla="ADT_LCONSUMO   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_FECHA                               " tabla="ADT_LCONSUMO   " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHAIMPO                               " tabla="ADT_LCONSUMO   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="FECHAEXPO                               " tabla="ADT_LCONSUMO   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="NUMERO                                  " tabla="ADT_LCONSUMO   " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="MONTO                                   " tabla="ADT_LCONSUMO   " campo="MONTO     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_EXT                                 " tabla="ADT_LCONSUMO   " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="HORAALTAFW                              " tabla="ADT_LCONSUMO   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="HORAEXPO                                " tabla="ADT_LCONSUMO   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="HORAMODIFICACIONFW                      " tabla="ADT_LCONSUMO   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_LCONSUMO   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ZADSFW                                  " tabla="ADT_LCONSUMO   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="VERSIONALTAFW                           " tabla="ADT_LCONSUMO   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="USUARIOALTAFW                           " tabla="ADT_LCONSUMO   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_LCONSUMO   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="SERIEALTAFW                             " tabla="ADT_LCONSUMO   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_LCONSUMO   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="HORAIMPO                                " tabla="ADT_LCONSUMO   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_LCONSUMO   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_USR                                 " tabla="ADT_LCONSUMO   " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_ENT                                 " tabla="ADT_LCONSUMO   " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_SERIE                               " tabla="ADT_LCONSUMO   " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_COMP                                " tabla="ADT_LCONSUMO   " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_HORA                                " tabla="ADT_LCONSUMO   " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_VERS                                " tabla="ADT_LCONSUMO   " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_ADN                                 " tabla="ADT_LCONSUMO   " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_LCONSUMO   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_LCONSUMO   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="ADT_COD                                 " tabla="ADT_LCONSUMO   " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="CLIENTE                                 " tabla="ADT_LCONSUMO   " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_LIMITECONSUMO                       " atributo="CODINT                                  " tabla="ADT_LCONSUMO   " campo="CODINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LIMITECONSUMO                           " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Límite de consumos                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="427" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On ADT_LCONSUMO.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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