
define class Din_EntidadADT_STOCKINVENTARIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ADT_STOCKINVENTARIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_AUD013PK'
	cTablaPrincipal = 'ADT_STOCKINV'
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
			local  lxAdt_stockinvFmodifw, lxAdt_stockinvFectrans, lxAdt_stockinvFecimpo, lxAdt_stockinvFecexpo, lxAdt_stockinvAdt_fecha, lxAdt_stockinvFaltafw, lxAdt_stockinvHoraexpo, lxAdt_stockinvHaltafw, lxAdt_stockinvHoraimpo, lxAdt_stockinvSaltafw, lxAdt_stockinvVmodifw, lxAdt_stockinvZadsfw, lxAdt_stockinvValtafw, lxAdt_stockinvUaltafw, lxAdt_stockinvUmodifw, lxAdt_stockinvEsttrans, lxAdt_stockinvSmodifw, lxAdt_stockinvHmodifw, lxAdt_stockinvBdaltafw, lxAdt_stockinvBdmodifw, lxAdt_stockinvAdt_ent, lxAdt_stockinvAdt_vers, lxAdt_stockinvAdt_usr, lxAdt_stockinvAdt_adn, lxAdt_stockinvInvent, lxAdt_stockinvAdt_hora, lxAdt_stockinvAdt_serie, lxAdt_stockinvAdt_comp, lxAdt_stockinvNropartida, lxAdt_stockinvCocant, lxAdt_stockinvAdt_ext, lxAdt_stockinvCoart, lxAdt_stockinvAdt_cod, lxAdt_stockinvTalle, lxAdt_stockinvCocod, lxAdt_stockinvCocol
				lxAdt_stockinvFmodifw =  .Fechamodificacionfw			lxAdt_stockinvFectrans =  .Fechatransferencia			lxAdt_stockinvFecimpo =  .Fechaimpo			lxAdt_stockinvFecexpo =  .Fechaexpo			lxAdt_stockinvAdt_fecha =  .Adt_fecha			lxAdt_stockinvFaltafw =  .Fechaaltafw			lxAdt_stockinvHoraexpo =  .Horaexpo			lxAdt_stockinvHaltafw =  .Horaaltafw			lxAdt_stockinvHoraimpo =  .Horaimpo			lxAdt_stockinvSaltafw =  .Seriealtafw			lxAdt_stockinvVmodifw =  .Versionmodificacionfw			lxAdt_stockinvZadsfw =  .Zadsfw			lxAdt_stockinvValtafw =  .Versionaltafw			lxAdt_stockinvUaltafw =  .Usuarioaltafw			lxAdt_stockinvUmodifw =  .Usuariomodificacionfw			lxAdt_stockinvEsttrans =  .Estadotransferencia			lxAdt_stockinvSmodifw =  .Seriemodificacionfw			lxAdt_stockinvHmodifw =  .Horamodificacionfw			lxAdt_stockinvBdaltafw =  .Basededatosaltafw			lxAdt_stockinvBdmodifw =  .Basededatosmodificacionfw			lxAdt_stockinvAdt_ent =  .Adt_ent			lxAdt_stockinvAdt_vers =  .Adt_vers			lxAdt_stockinvAdt_usr =  .Adt_usr			lxAdt_stockinvAdt_adn =  .Adt_adn			lxAdt_stockinvInvent =  upper( .Inventario_PK ) 			lxAdt_stockinvAdt_hora =  .Adt_hora			lxAdt_stockinvAdt_serie =  .Adt_serie			lxAdt_stockinvAdt_comp =  .Adt_comp			lxAdt_stockinvNropartida =  .Partida			lxAdt_stockinvCocant =  .Cantidad			lxAdt_stockinvAdt_ext =  .Adt_ext			lxAdt_stockinvCoart =  upper( .Insumo_PK ) 			lxAdt_stockinvAdt_cod =  .Adt_cod			lxAdt_stockinvTalle =  upper( .Talle_PK ) 			lxAdt_stockinvCocod =  upper( .Codigo_PK ) 			lxAdt_stockinvCocol =  upper( .Color_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxAdt_stockinvAdt_cod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_STOCKINV ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Adt_fecha","Faltafw","Horaexpo","Haltafw","Horaimpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Esttrans","Smodifw","Hmodifw","Bdaltafw","Bdmodifw","Adt_ent","Adt_vers","Adt_usr","Adt_adn","Invent","Adt_hora","Adt_serie","Adt_comp","Nropartida","Cocant","Adt_ext","Coart","Adt_cod","Talle","Cocod","Cocol" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_stockinvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvInvent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvNropartida ) + "'" >>, <<lxAdt_stockinvCocant >>, <<iif( lxAdt_stockinvAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvCoart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocol ) + "'" >> )
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
			local  lxAdt_stockinvFmodifw, lxAdt_stockinvFectrans, lxAdt_stockinvFecimpo, lxAdt_stockinvFecexpo, lxAdt_stockinvAdt_fecha, lxAdt_stockinvFaltafw, lxAdt_stockinvHoraexpo, lxAdt_stockinvHaltafw, lxAdt_stockinvHoraimpo, lxAdt_stockinvSaltafw, lxAdt_stockinvVmodifw, lxAdt_stockinvZadsfw, lxAdt_stockinvValtafw, lxAdt_stockinvUaltafw, lxAdt_stockinvUmodifw, lxAdt_stockinvEsttrans, lxAdt_stockinvSmodifw, lxAdt_stockinvHmodifw, lxAdt_stockinvBdaltafw, lxAdt_stockinvBdmodifw, lxAdt_stockinvAdt_ent, lxAdt_stockinvAdt_vers, lxAdt_stockinvAdt_usr, lxAdt_stockinvAdt_adn, lxAdt_stockinvInvent, lxAdt_stockinvAdt_hora, lxAdt_stockinvAdt_serie, lxAdt_stockinvAdt_comp, lxAdt_stockinvNropartida, lxAdt_stockinvCocant, lxAdt_stockinvAdt_ext, lxAdt_stockinvCoart, lxAdt_stockinvAdt_cod, lxAdt_stockinvTalle, lxAdt_stockinvCocod, lxAdt_stockinvCocol
				lxAdt_stockinvFmodifw =  .Fechamodificacionfw			lxAdt_stockinvFectrans =  .Fechatransferencia			lxAdt_stockinvFecimpo =  .Fechaimpo			lxAdt_stockinvFecexpo =  .Fechaexpo			lxAdt_stockinvAdt_fecha =  .Adt_fecha			lxAdt_stockinvFaltafw =  .Fechaaltafw			lxAdt_stockinvHoraexpo =  .Horaexpo			lxAdt_stockinvHaltafw =  .Horaaltafw			lxAdt_stockinvHoraimpo =  .Horaimpo			lxAdt_stockinvSaltafw =  .Seriealtafw			lxAdt_stockinvVmodifw =  .Versionmodificacionfw			lxAdt_stockinvZadsfw =  .Zadsfw			lxAdt_stockinvValtafw =  .Versionaltafw			lxAdt_stockinvUaltafw =  .Usuarioaltafw			lxAdt_stockinvUmodifw =  .Usuariomodificacionfw			lxAdt_stockinvEsttrans =  .Estadotransferencia			lxAdt_stockinvSmodifw =  .Seriemodificacionfw			lxAdt_stockinvHmodifw =  .Horamodificacionfw			lxAdt_stockinvBdaltafw =  .Basededatosaltafw			lxAdt_stockinvBdmodifw =  .Basededatosmodificacionfw			lxAdt_stockinvAdt_ent =  .Adt_ent			lxAdt_stockinvAdt_vers =  .Adt_vers			lxAdt_stockinvAdt_usr =  .Adt_usr			lxAdt_stockinvAdt_adn =  .Adt_adn			lxAdt_stockinvInvent =  upper( .Inventario_PK ) 			lxAdt_stockinvAdt_hora =  .Adt_hora			lxAdt_stockinvAdt_serie =  .Adt_serie			lxAdt_stockinvAdt_comp =  .Adt_comp			lxAdt_stockinvNropartida =  .Partida			lxAdt_stockinvCocant =  .Cantidad			lxAdt_stockinvAdt_ext =  .Adt_ext			lxAdt_stockinvCoart =  upper( .Insumo_PK ) 			lxAdt_stockinvAdt_cod =  .Adt_cod			lxAdt_stockinvTalle =  upper( .Talle_PK ) 			lxAdt_stockinvCocod =  upper( .Codigo_PK ) 			lxAdt_stockinvCocol =  upper( .Color_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.ADT_COD
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ADT_STOCKINV set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecexpo ) + "'">>,"Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvAdt_fecha ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvUmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvEsttrans ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdmodifw ) + "'">>,"Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_ent ) + "'">>,"Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_vers ) + "'">>,"Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_usr ) + "'">>,"Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_adn ) + "'">>,"Invent" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvInvent ) + "'">>,"Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_hora ) + "'">>,"Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_serie ) + "'">>,"Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_comp ) + "'">>,"Nropartida" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvNropartida ) + "'">>,"Cocant" = <<lxAdt_stockinvCocant>>,"Adt_ext" = <<iif( lxAdt_stockinvAdt_ext, 1, 0 )>>,"Coart" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvCoart ) + "'">>,"Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'">>,"Talle" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvTalle ) + "'">>,"Cocod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocod ) + "'">>,"Cocol" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocol ) + "'">> where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'">> and  ADT_STOCKINV.ADT_COD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 ADT_Cod from ZooLogic.ADT_STOCKINV where " + this.ConvertirFuncionesSql( " ADT_STOCKINV.ADT_COD != ''" ) )
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
			Local lxAdt_stockinvAdt_cod
			lxAdt_stockinvAdt_cod = .Adt_cod

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color" from ZooLogic.ADT_STOCKINV where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'">> and  ADT_STOCKINV.ADT_COD != ''
			endtext
			use in select('c_ADT_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKINVENTARIO', set( 'Datasession' ) )

			if reccount( 'c_ADT_STOCKINVENTARIO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxAdt_stockinvAdt_cod as Variant
		llRetorno = .t.
		lxAdt_stockinvAdt_cod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ADT_STOCKINV where "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'">> and  ADT_STOCKINV.ADT_COD != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color" from ZooLogic.ADT_STOCKINV where  ADT_STOCKINV.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKINVENTARIO', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color" from ZooLogic.ADT_STOCKINV where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_STOCKINV.ADT_COD != '' order by FALTAFW,HALTAFW
			endtext
			use in select('c_ADT_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKINVENTARIO', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color" from ZooLogic.ADT_STOCKINV where  funciones.dtos( FALTAFW ) + funciones.padr( HALTAFW, 8, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ADT_STOCKINV.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKINVENTARIO', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color" from ZooLogic.ADT_STOCKINV where  ADT_STOCKINV.ADT_COD != '' order by FALTAFW desc,HALTAFW desc
			endtext
			use in select('c_ADT_STOCKINVENTARIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ADT_STOCKINVENTARIO', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fecexpo,Adt_fecha,Faltafw,Horaexpo,Haltafw,Horaimpo,Saltafw,Vmodifw" + ;
",Zadsfw,Valtafw,Ualtafw,Umodifw,Esttrans,Smodifw,Hmodifw,Bdaltafw,Bdmodifw,Adt_ent,Adt_vers,Adt_usr," + ;
"Adt_adn,Invent,Adt_hora,Adt_serie,Adt_comp,Nropartida,Cocant,Adt_ext,Coart,Adt_cod,Talle,Cocod,Cocol" + ;
" from ZooLogic.ADT_STOCKINV where  ADT_STOCKINV.ADT_COD != '' and " + lcFiltro )
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
			local  lxAdt_stockinvFmodifw, lxAdt_stockinvFectrans, lxAdt_stockinvFecimpo, lxAdt_stockinvFecexpo, lxAdt_stockinvAdt_fecha, lxAdt_stockinvFaltafw, lxAdt_stockinvHoraexpo, lxAdt_stockinvHaltafw, lxAdt_stockinvHoraimpo, lxAdt_stockinvSaltafw, lxAdt_stockinvVmodifw, lxAdt_stockinvZadsfw, lxAdt_stockinvValtafw, lxAdt_stockinvUaltafw, lxAdt_stockinvUmodifw, lxAdt_stockinvEsttrans, lxAdt_stockinvSmodifw, lxAdt_stockinvHmodifw, lxAdt_stockinvBdaltafw, lxAdt_stockinvBdmodifw, lxAdt_stockinvAdt_ent, lxAdt_stockinvAdt_vers, lxAdt_stockinvAdt_usr, lxAdt_stockinvAdt_adn, lxAdt_stockinvInvent, lxAdt_stockinvAdt_hora, lxAdt_stockinvAdt_serie, lxAdt_stockinvAdt_comp, lxAdt_stockinvNropartida, lxAdt_stockinvCocant, lxAdt_stockinvAdt_ext, lxAdt_stockinvCoart, lxAdt_stockinvAdt_cod, lxAdt_stockinvTalle, lxAdt_stockinvCocod, lxAdt_stockinvCocol
				lxAdt_stockinvFmodifw = ctod( '  /  /    ' )			lxAdt_stockinvFectrans = ctod( '  /  /    ' )			lxAdt_stockinvFecimpo = ctod( '  /  /    ' )			lxAdt_stockinvFecexpo = ctod( '  /  /    ' )			lxAdt_stockinvAdt_fecha = ctod( '  /  /    ' )			lxAdt_stockinvFaltafw = ctod( '  /  /    ' )			lxAdt_stockinvHoraexpo = []			lxAdt_stockinvHaltafw = []			lxAdt_stockinvHoraimpo = []			lxAdt_stockinvSaltafw = []			lxAdt_stockinvVmodifw = []			lxAdt_stockinvZadsfw = []			lxAdt_stockinvValtafw = []			lxAdt_stockinvUaltafw = []			lxAdt_stockinvUmodifw = []			lxAdt_stockinvEsttrans = []			lxAdt_stockinvSmodifw = []			lxAdt_stockinvHmodifw = []			lxAdt_stockinvBdaltafw = []			lxAdt_stockinvBdmodifw = []			lxAdt_stockinvAdt_ent = []			lxAdt_stockinvAdt_vers = []			lxAdt_stockinvAdt_usr = []			lxAdt_stockinvAdt_adn = []			lxAdt_stockinvInvent = []			lxAdt_stockinvAdt_hora = []			lxAdt_stockinvAdt_serie = []			lxAdt_stockinvAdt_comp = []			lxAdt_stockinvNropartida = []			lxAdt_stockinvCocant = 0			lxAdt_stockinvAdt_ext = .F.			lxAdt_stockinvCoart = []			lxAdt_stockinvAdt_cod = []			lxAdt_stockinvTalle = []			lxAdt_stockinvCocod = []			lxAdt_stockinvCocol = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ADT_STOCKINV where "ADT_Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.ADT_COD ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ADT_STOCKINV' + '_' + tcCampo
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
		lcWhere = " Where  ADT_STOCKINV.ADT_COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ADT_STOCKINV', '', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'ADT_FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_FECHA AS ADT_FECHA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
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
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ADT_ENT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ENT AS ADT_ENT'
				Case lcAtributo == 'ADT_VERS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_VERS AS ADT_VERS'
				Case lcAtributo == 'ADT_USR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_USR AS ADT_USR'
				Case lcAtributo == 'ADT_ADN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_ADN AS ADT_ADN'
				Case lcAtributo == 'INVENTARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENT AS INVENTARIO'
				Case lcAtributo == 'ADT_HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_HORA AS ADT_HORA'
				Case lcAtributo == 'ADT_SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_SERIE AS ADT_SERIE'
				Case lcAtributo == 'ADT_COMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COMP AS ADT_COMP'
				Case lcAtributo == 'PARTIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROPARTIDA AS PARTIDA'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCANT AS CANTIDAD'
				Case lcAtributo == 'ADT_EXT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_EXT AS ADT_EXT'
				Case lcAtributo == 'INSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COART AS INSUMO'
				Case lcAtributo == 'ADT_COD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ADT_COD AS ADT_COD'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOD AS CODIGO'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COCOL AS COLOR'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_FECHA'
				lcCampo = 'ADT_FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ENT'
				lcCampo = 'ADT_ENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_VERS'
				lcCampo = 'ADT_VERS'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_USR'
				lcCampo = 'ADT_USR'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_ADN'
				lcCampo = 'ADT_ADN'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIO'
				lcCampo = 'INVENT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_HORA'
				lcCampo = 'ADT_HORA'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_SERIE'
				lcCampo = 'ADT_SERIE'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COMP'
				lcCampo = 'ADT_COMP'
			Case upper( alltrim( tcAtributo ) ) == 'PARTIDA'
				lcCampo = 'NROPARTIDA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'COCANT'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_EXT'
				lcCampo = 'ADT_EXT'
			Case upper( alltrim( tcAtributo ) ) == 'INSUMO'
				lcCampo = 'COART'
			Case upper( alltrim( tcAtributo ) ) == 'ADT_COD'
				lcCampo = 'ADT_COD'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COCOD'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'COCOL'
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
			local  lxAdt_stockinvFmodifw, lxAdt_stockinvFectrans, lxAdt_stockinvFecimpo, lxAdt_stockinvFecexpo, lxAdt_stockinvAdt_fecha, lxAdt_stockinvFaltafw, lxAdt_stockinvHoraexpo, lxAdt_stockinvHaltafw, lxAdt_stockinvHoraimpo, lxAdt_stockinvSaltafw, lxAdt_stockinvVmodifw, lxAdt_stockinvZadsfw, lxAdt_stockinvValtafw, lxAdt_stockinvUaltafw, lxAdt_stockinvUmodifw, lxAdt_stockinvEsttrans, lxAdt_stockinvSmodifw, lxAdt_stockinvHmodifw, lxAdt_stockinvBdaltafw, lxAdt_stockinvBdmodifw, lxAdt_stockinvAdt_ent, lxAdt_stockinvAdt_vers, lxAdt_stockinvAdt_usr, lxAdt_stockinvAdt_adn, lxAdt_stockinvInvent, lxAdt_stockinvAdt_hora, lxAdt_stockinvAdt_serie, lxAdt_stockinvAdt_comp, lxAdt_stockinvNropartida, lxAdt_stockinvCocant, lxAdt_stockinvAdt_ext, lxAdt_stockinvCoart, lxAdt_stockinvAdt_cod, lxAdt_stockinvTalle, lxAdt_stockinvCocod, lxAdt_stockinvCocol
				lxAdt_stockinvFmodifw =  .Fechamodificacionfw			lxAdt_stockinvFectrans =  .Fechatransferencia			lxAdt_stockinvFecimpo =  .Fechaimpo			lxAdt_stockinvFecexpo =  .Fechaexpo			lxAdt_stockinvAdt_fecha =  .Adt_fecha			lxAdt_stockinvFaltafw =  .Fechaaltafw			lxAdt_stockinvHoraexpo =  .Horaexpo			lxAdt_stockinvHaltafw =  .Horaaltafw			lxAdt_stockinvHoraimpo =  .Horaimpo			lxAdt_stockinvSaltafw =  .Seriealtafw			lxAdt_stockinvVmodifw =  .Versionmodificacionfw			lxAdt_stockinvZadsfw =  .Zadsfw			lxAdt_stockinvValtafw =  .Versionaltafw			lxAdt_stockinvUaltafw =  .Usuarioaltafw			lxAdt_stockinvUmodifw =  .Usuariomodificacionfw			lxAdt_stockinvEsttrans =  .Estadotransferencia			lxAdt_stockinvSmodifw =  .Seriemodificacionfw			lxAdt_stockinvHmodifw =  .Horamodificacionfw			lxAdt_stockinvBdaltafw =  .Basededatosaltafw			lxAdt_stockinvBdmodifw =  .Basededatosmodificacionfw			lxAdt_stockinvAdt_ent =  .Adt_ent			lxAdt_stockinvAdt_vers =  .Adt_vers			lxAdt_stockinvAdt_usr =  .Adt_usr			lxAdt_stockinvAdt_adn =  .Adt_adn			lxAdt_stockinvInvent =  upper( .Inventario_PK ) 			lxAdt_stockinvAdt_hora =  .Adt_hora			lxAdt_stockinvAdt_serie =  .Adt_serie			lxAdt_stockinvAdt_comp =  .Adt_comp			lxAdt_stockinvNropartida =  .Partida			lxAdt_stockinvCocant =  .Cantidad			lxAdt_stockinvAdt_ext =  .Adt_ext			lxAdt_stockinvCoart =  upper( .Insumo_PK ) 			lxAdt_stockinvAdt_cod =  .Adt_cod			lxAdt_stockinvTalle =  upper( .Talle_PK ) 			lxAdt_stockinvCocod =  upper( .Codigo_PK ) 			lxAdt_stockinvCocol =  upper( .Color_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ADT_STOCKINV ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Adt_fecha","Faltafw","Horaexpo","Haltafw","Horaimpo","Saltafw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Esttrans","Smodifw","Hmodifw","Bdaltafw","Bdmodifw","Adt_ent","Adt_vers","Adt_usr","Adt_adn","Invent","Adt_hora","Adt_serie","Adt_comp","Nropartida","Cocant","Adt_ext","Coart","Adt_cod","Talle","Cocod","Cocol" ) values ( <<"'" + this.ConvertirDateSql( lxAdt_stockinvFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvAdt_fecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxAdt_stockinvFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_ent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_vers ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_usr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_adn ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvInvent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_hora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_serie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_comp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvNropartida ) + "'" >>, <<lxAdt_stockinvCocant >>, <<iif( lxAdt_stockinvAdt_ext, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvCoart ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvTalle ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocol ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ADT_STOCKINV' 
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
			local  lxAdt_stockinvFmodifw, lxAdt_stockinvFectrans, lxAdt_stockinvFecimpo, lxAdt_stockinvFecexpo, lxAdt_stockinvAdt_fecha, lxAdt_stockinvFaltafw, lxAdt_stockinvHoraexpo, lxAdt_stockinvHaltafw, lxAdt_stockinvHoraimpo, lxAdt_stockinvSaltafw, lxAdt_stockinvVmodifw, lxAdt_stockinvZadsfw, lxAdt_stockinvValtafw, lxAdt_stockinvUaltafw, lxAdt_stockinvUmodifw, lxAdt_stockinvEsttrans, lxAdt_stockinvSmodifw, lxAdt_stockinvHmodifw, lxAdt_stockinvBdaltafw, lxAdt_stockinvBdmodifw, lxAdt_stockinvAdt_ent, lxAdt_stockinvAdt_vers, lxAdt_stockinvAdt_usr, lxAdt_stockinvAdt_adn, lxAdt_stockinvInvent, lxAdt_stockinvAdt_hora, lxAdt_stockinvAdt_serie, lxAdt_stockinvAdt_comp, lxAdt_stockinvNropartida, lxAdt_stockinvCocant, lxAdt_stockinvAdt_ext, lxAdt_stockinvCoart, lxAdt_stockinvAdt_cod, lxAdt_stockinvTalle, lxAdt_stockinvCocod, lxAdt_stockinvCocol
				lxAdt_stockinvFmodifw =  .Fechamodificacionfw			lxAdt_stockinvFectrans =  .Fechatransferencia			lxAdt_stockinvFecimpo =  .Fechaimpo			lxAdt_stockinvFecexpo =  .Fechaexpo			lxAdt_stockinvAdt_fecha =  .Adt_fecha			lxAdt_stockinvFaltafw =  .Fechaaltafw			lxAdt_stockinvHoraexpo =  .Horaexpo			lxAdt_stockinvHaltafw =  .Horaaltafw			lxAdt_stockinvHoraimpo =  .Horaimpo			lxAdt_stockinvSaltafw =  .Seriealtafw			lxAdt_stockinvVmodifw =  .Versionmodificacionfw			lxAdt_stockinvZadsfw =  .Zadsfw			lxAdt_stockinvValtafw =  .Versionaltafw			lxAdt_stockinvUaltafw =  .Usuarioaltafw			lxAdt_stockinvUmodifw =  .Usuariomodificacionfw			lxAdt_stockinvEsttrans =  .Estadotransferencia			lxAdt_stockinvSmodifw =  .Seriemodificacionfw			lxAdt_stockinvHmodifw =  .Horamodificacionfw			lxAdt_stockinvBdaltafw =  .Basededatosaltafw			lxAdt_stockinvBdmodifw =  .Basededatosmodificacionfw			lxAdt_stockinvAdt_ent =  .Adt_ent			lxAdt_stockinvAdt_vers =  .Adt_vers			lxAdt_stockinvAdt_usr =  .Adt_usr			lxAdt_stockinvAdt_adn =  .Adt_adn			lxAdt_stockinvInvent =  upper( .Inventario_PK ) 			lxAdt_stockinvAdt_hora =  .Adt_hora			lxAdt_stockinvAdt_serie =  .Adt_serie			lxAdt_stockinvAdt_comp =  .Adt_comp			lxAdt_stockinvNropartida =  .Partida			lxAdt_stockinvCocant =  .Cantidad			lxAdt_stockinvAdt_ext =  .Adt_ext			lxAdt_stockinvCoart =  upper( .Insumo_PK ) 			lxAdt_stockinvAdt_cod =  .Adt_cod			lxAdt_stockinvTalle =  upper( .Talle_PK ) 			lxAdt_stockinvCocod =  upper( .Codigo_PK ) 			lxAdt_stockinvCocol =  upper( .Color_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.ADT_COD
			lcValorClavePrimariaString = "'" + this.oEntidad.ADT_COD + "'"

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_STOCKINV.ADT_COD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ADT_STOCKINV set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFecexpo ) + "'">>, "Adt_fecha" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvAdt_fecha ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxAdt_stockinvFaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvUmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvEsttrans ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvBdmodifw ) + "'">>, "Adt_ent" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_ent ) + "'">>, "Adt_vers" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_vers ) + "'">>, "Adt_usr" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_usr ) + "'">>, "Adt_adn" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_adn ) + "'">>, "Invent" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvInvent ) + "'">>, "Adt_hora" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_hora ) + "'">>, "Adt_serie" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_serie ) + "'">>, "Adt_comp" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_comp ) + "'">>, "Nropartida" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvNropartida ) + "'">>, "Cocant" = <<lxAdt_stockinvCocant>>, "Adt_ext" = <<iif( lxAdt_stockinvAdt_ext, 1, 0 )>>, "Coart" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvCoart ) + "'">>, "Adt_cod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvAdt_cod ) + "'">>, "Talle" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvTalle ) + "'">>, "Cocod" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocod ) + "'">>, "Cocol" = <<"'" + this.FormatearTextoSql( lxAdt_stockinvCocol ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ADT_STOCKINV' 
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

			lcFiltro = ["Adt_cod" = ] + lcValorClavePrimariaString  + [ and  ADT_STOCKINV.ADT_COD != '']
		loColeccion.Agregar( 'delete from ZooLogic.ADT_STOCKINV where ' + lcFiltro )
			loColeccion.cTabla = 'ADT_STOCKINV' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ADT_STOCKINV where  ADT_STOCKINV.ADT_COD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ADT_STOCKINV where ADT_Cod = " + "'" + this.FormatearTextoSql( this.oEntidad.ADT_COD ) + "'"+ " and  ADT_STOCKINV.ADT_COD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKINVENTARIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ADT_STOCKINV Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.ADT_STOCKINV set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, ADT_Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ADT_Ent = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"+ [, ADT_Vers = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'"+ [, ADT_Usr = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'"+ [, ADT_ADN = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'"+ [, Invent = ] + "'" + this.FormatearTextoSql( &lcCursor..Invent ) + "'"+ [, ADT_Hora = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'"+ [, ADT_Serie = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'"+ [, ADT_Comp = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"+ [, NroPartida = ] + "'" + this.FormatearTextoSql( &lcCursor..NroPartida ) + "'"+ [, COCANT = ] + transform( &lcCursor..COCANT )+ [, ADT_Ext = ] + Transform( iif( &lcCursor..ADT_Ext, 1, 0 ))+ [, COART = ] + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'"+ [, ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'"+ [, Talle = ] + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'"+ [, COCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"+ [, COCOL = ] + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'" + [ Where ADT_Cod = ] + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FECEXPO, ADT_Fecha, FALTAFW, HORAEXPO, HALTAFW, HORAIMPO, SALTAFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, ESTTRANS, SMODIFW, HMODIFW, BDALTAFW, BDMODIFW, ADT_Ent, ADT_Vers, ADT_Usr, ADT_ADN, Invent, ADT_Hora, ADT_Serie, ADT_Comp, NroPartida, COCANT, ADT_Ext, COART, ADT_Cod, Talle, COCOD, COCOL
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..ADT_Fecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Ent ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Vers ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Usr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_ADN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Invent ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Hora ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Serie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Comp ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..NroPartida ) + "'" + ',' + transform( &lcCursor..COCANT ) + ',' + Transform( iif( &lcCursor..ADT_Ext, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..COART ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ADT_Cod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Talle ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOD ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..COCOL ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.ADT_STOCKINV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKINVENTARIO'
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
			Case  lcAlias == lcPrefijo + 'ADT_STOCKINVENTARIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ADT_STOCKINVENTARIO_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ADT_STOCKINV')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ADT_STOCKINVENTARIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..ADT_Cod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ADT_STOCKINVENTARIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKINVENTARIO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKINVENTARIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  ADT_Fecha 
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_STOCKINV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_STOCKINV
Create Table ZooLogic.TablaTrabajo_ADT_STOCKINV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"adt_fecha" datetime  null, 
"faltafw" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"adt_ent" char( 40 )  null, 
"adt_vers" char( 13 )  null, 
"adt_usr" char( 100 )  null, 
"adt_adn" char( 10 )  null, 
"invent" char( 15 )  null, 
"adt_hora" char( 8 )  null, 
"adt_serie" char( 20 )  null, 
"adt_comp" char( 254 )  null, 
"nropartida" char( 25 )  null, 
"cocant" numeric( 17, 6 )  null, 
"adt_ext" bit  null, 
"coart" char( 25 )  null, 
"adt_cod" char( 38 )  null, 
"talle" char( 5 )  null, 
"cocod" char( 38 )  null, 
"cocol" char( 6 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ADT_STOCKINV' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ADT_STOCKINV' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ADT_STOCKINVENTARIO'
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
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('adt_fecha','adt_fecha')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('adt_ent','adt_ent')
			.AgregarMapeo('adt_vers','adt_vers')
			.AgregarMapeo('adt_usr','adt_usr')
			.AgregarMapeo('adt_adn','adt_adn')
			.AgregarMapeo('invent','invent')
			.AgregarMapeo('adt_hora','adt_hora')
			.AgregarMapeo('adt_serie','adt_serie')
			.AgregarMapeo('adt_comp','adt_comp')
			.AgregarMapeo('nropartida','nropartida')
			.AgregarMapeo('cocant','cocant')
			.AgregarMapeo('adt_ext','adt_ext')
			.AgregarMapeo('coart','coart')
			.AgregarMapeo('adt_cod','adt_cod')
			.AgregarMapeo('talle','talle')
			.AgregarMapeo('cocod','cocod')
			.AgregarMapeo('cocol','cocol')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ADT_STOCKINV'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.ADT_FECHA = isnull( d.ADT_FECHA, t.ADT_FECHA ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ADT_ENT = isnull( d.ADT_ENT, t.ADT_ENT ),t.ADT_VERS = isnull( d.ADT_VERS, t.ADT_VERS ),t.ADT_USR = isnull( d.ADT_USR, t.ADT_USR ),t.ADT_ADN = isnull( d.ADT_ADN, t.ADT_ADN ),t.INVENT = isnull( d.INVENT, t.INVENT ),t.ADT_HORA = isnull( d.ADT_HORA, t.ADT_HORA ),t.ADT_SERIE = isnull( d.ADT_SERIE, t.ADT_SERIE ),t.ADT_COMP = isnull( d.ADT_COMP, t.ADT_COMP ),t.NROPARTIDA = isnull( d.NROPARTIDA, t.NROPARTIDA ),t.COCANT = isnull( d.COCANT, t.COCANT ),t.ADT_EXT = isnull( d.ADT_EXT, t.ADT_EXT ),t.COART = isnull( d.COART, t.COART ),t.ADT_COD = isnull( d.ADT_COD, t.ADT_COD ),t.TALLE = isnull( d.TALLE, t.TALLE ),t.COCOD = isnull( d.COCOD, t.COCOD ),t.COCOL = isnull( d.COCOL, t.COCOL )
					from ZooLogic.ADT_STOCKINV t inner join deleted d 
							 on t.ADT_Cod = d.ADT_Cod
				-- Fin Updates
				insert into ZooLogic.ADT_STOCKINV(Fmodifw,Fectrans,Fecimpo,Fecexpo,Adt_fecha,Faltafw,Horaexpo,Haltafw,Horaimpo,Saltafw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Esttrans,Smodifw,Hmodifw,Bdaltafw,Bdmodifw,Adt_ent,Adt_vers,Adt_usr,Adt_adn,Invent,Adt_hora,Adt_serie,Adt_comp,Nropartida,Cocant,Adt_ext,Coart,Adt_cod,Talle,Cocod,Cocol)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.ADT_FECHA,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ADT_ENT,''),isnull( d.ADT_VERS,''),isnull( d.ADT_USR,''),isnull( d.ADT_ADN,''),isnull( d.INVENT,''),isnull( d.ADT_HORA,''),isnull( d.ADT_SERIE,''),isnull( d.ADT_COMP,''),isnull( d.NROPARTIDA,''),isnull( d.COCANT,0),isnull( d.ADT_EXT,0),isnull( d.COART,''),isnull( d.ADT_COD,''),isnull( d.TALLE,''),isnull( d.COCOD,''),isnull( d.COCOL,'')
						From deleted d left join ZooLogic.ADT_STOCKINV pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ADT_STOCKINV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ADT_STOCKINV
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ADT_STOCKINVENTARIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKINVENTARIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKINVENTARIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKINVENTARIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKINVENTARIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Adt_fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKINVENTARIO.Adt_fecha, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ADT_STOCKINVENTARIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_ADT_STOCKINVENTARIO.Horaexpo, [] )
					.Horaaltafw = nvl( c_ADT_STOCKINVENTARIO.Horaaltafw, [] )
					.Horaimpo = nvl( c_ADT_STOCKINVENTARIO.Horaimpo, [] )
					.Seriealtafw = nvl( c_ADT_STOCKINVENTARIO.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_ADT_STOCKINVENTARIO.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ADT_STOCKINVENTARIO.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_ADT_STOCKINVENTARIO.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ADT_STOCKINVENTARIO.Usuariomodificacionfw, [] )
					.Estadotransferencia = nvl( c_ADT_STOCKINVENTARIO.Estadotransferencia, [] )
					.Seriemodificacionfw = nvl( c_ADT_STOCKINVENTARIO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_ADT_STOCKINVENTARIO.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_ADT_STOCKINVENTARIO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_ADT_STOCKINVENTARIO.Basededatosmodificacionfw, [] )
					.Adt_ent = nvl( c_ADT_STOCKINVENTARIO.Adt_ent, [] )
					.Adt_vers = nvl( c_ADT_STOCKINVENTARIO.Adt_vers, [] )
					.Adt_usr = nvl( c_ADT_STOCKINVENTARIO.Adt_usr, [] )
					.Adt_adn = nvl( c_ADT_STOCKINVENTARIO.Adt_adn, [] )
					.Inventario_PK =  nvl( c_ADT_STOCKINVENTARIO.Inventario, [] )
					.Adt_hora = nvl( c_ADT_STOCKINVENTARIO.Adt_hora, [] )
					.Adt_serie = nvl( c_ADT_STOCKINVENTARIO.Adt_serie, [] )
					.Adt_comp = nvl( c_ADT_STOCKINVENTARIO.Adt_comp, [] )
					.Partida = nvl( c_ADT_STOCKINVENTARIO.Partida, [] )
					.Cantidad = nvl( c_ADT_STOCKINVENTARIO.Cantidad, 0 )
					.Adt_ext = nvl( c_ADT_STOCKINVENTARIO.Adt_ext, .F. )
					.Insumo_PK =  nvl( c_ADT_STOCKINVENTARIO.Insumo, [] )
					.Adt_cod = nvl( c_ADT_STOCKINVENTARIO.Adt_cod, [] )
					.Talle_PK =  nvl( c_ADT_STOCKINVENTARIO.Talle, [] )
					.Codigo_PK =  nvl( c_ADT_STOCKINVENTARIO.Codigo, [] )
					.Color_PK =  nvl( c_ADT_STOCKINVENTARIO.Color, [] )
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
		return c_ADT_STOCKINVENTARIO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ZooLogic.ADT_STOCKINV' )
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
								from ZooLogic.ADT_STOCKINV 
								Where   ADT_STOCKINV.ADT_COD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ADT_STOCKINV", "", lcCursor, set("Datasession") )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Adt_fecha" as "Adt_fecha", "Faltafw" as "Fechaaltafw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Esttrans" as "Estadotransferencia", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Adt_ent" as "Adt_ent", "Adt_vers" as "Adt_vers", "Adt_usr" as "Adt_usr", "Adt_adn" as "Adt_adn", "Invent" as "Inventario", "Adt_hora" as "Adt_hora", "Adt_serie" as "Adt_serie", "Adt_comp" as "Adt_comp", "Nropartida" as "Partida", "Cocant" as "Cantidad", "Adt_ext" as "Adt_ext", "Coart" as "Insumo", "Adt_cod" as "Adt_cod", "Talle" as "Talle", "Cocod" as "Codigo", "Cocol" as "Color"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ADT_STOCKINV 
								Where   ADT_STOCKINV.ADT_COD != ''
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
	Tabla = 'ADT_STOCKINV'
	Filtro = " ADT_STOCKINV.ADT_COD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ADT_STOCKINV.ADT_COD != ''"
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
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="FECHAMODIFICACIONFW                     " tabla="ADT_STOCKINV   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="FECHATRANSFERENCIA                      " tabla="ADT_STOCKINV   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="FECHAIMPO                               " tabla="ADT_STOCKINV   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="FECHAEXPO                               " tabla="ADT_STOCKINV   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_FECHA                               " tabla="ADT_STOCKINV   " campo="ADT_FECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="FECHAALTAFW                             " tabla="ADT_STOCKINV   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="HORAEXPO                                " tabla="ADT_STOCKINV   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="HORAALTAFW                              " tabla="ADT_STOCKINV   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="HORAIMPO                                " tabla="ADT_STOCKINV   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="SERIEALTAFW                             " tabla="ADT_STOCKINV   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="VERSIONMODIFICACIONFW                   " tabla="ADT_STOCKINV   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ZADSFW                                  " tabla="ADT_STOCKINV   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="VERSIONALTAFW                           " tabla="ADT_STOCKINV   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="USUARIOALTAFW                           " tabla="ADT_STOCKINV   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="USUARIOMODIFICACIONFW                   " tabla="ADT_STOCKINV   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ESTADOTRANSFERENCIA                     " tabla="ADT_STOCKINV   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="SERIEMODIFICACIONFW                     " tabla="ADT_STOCKINV   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="HORAMODIFICACIONFW                      " tabla="ADT_STOCKINV   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="BASEDEDATOSALTAFW                       " tabla="ADT_STOCKINV   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ADT_STOCKINV   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_ENT                                 " tabla="ADT_STOCKINV   " campo="ADT_ENT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Entidad                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_VERS                                " tabla="ADT_STOCKINV   " campo="ADT_VERS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Versión                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_USR                                 " tabla="ADT_STOCKINV   " campo="ADT_USR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_ADN                                 " tabla="ADT_STOCKINV   " campo="ADT_ADN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="ADN                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="INVENTARIO                              " tabla="ADT_STOCKINV   " campo="INVENT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INVENTARIO                              " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Inventario                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_HORA                                " tabla="ADT_STOCKINV   " campo="ADT_HORA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_SERIE                               " tabla="ADT_STOCKINV   " campo="ADT_SERIE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_COMP                                " tabla="ADT_STOCKINV   " campo="ADT_COMP  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="PARTIDA                                 " tabla="ADT_STOCKINV   " campo="NROPARTIDA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Número de partida                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="CANTIDAD                                " tabla="ADT_STOCKINV   " campo="COCANT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="6" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Cantidad en stock                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_EXT                                 " tabla="ADT_STOCKINV   " campo="ADT_EXT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Información remota                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="INSUMO                                  " tabla="ADT_STOCKINV   " campo="COART     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INSUMO                                  " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Insumo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="ADT_COD                                 " tabla="ADT_STOCKINV   " campo="ADT_COD   " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="TALLE                                   " tabla="ADT_STOCKINV   " campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Talle                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="CODIGO                                  " tabla="ADT_STOCKINV   " campo="COCOD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="STOCKINVENTARIO                         " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Stock inventario                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ADT_STOCKINVENTARIO                     " atributo="COLOR                                   " tabla="ADT_STOCKINV   " campo="COCOL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Color                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INVENTARIO                              " atributo="DESCRIPCION                             " tabla="INV            " campo="INVDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Inv.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INV On ADT_STOCKINV.INVENT = INV.invcod And  INV.INVCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INSUMO                                  " atributo="DESCRIPCION                             " tabla="INS            " campo="INSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Ins.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INS On ADT_STOCKINV.COART = INS.INSCOD And  INS.INSCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On ADT_STOCKINV.TALLE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On ADT_STOCKINV.COCOL = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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