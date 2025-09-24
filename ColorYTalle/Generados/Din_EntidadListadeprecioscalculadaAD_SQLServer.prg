
define class Din_EntidadLISTADEPRECIOSCALCULADAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LISTADEPRECIOSCALCULADA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [ListaDePrecios + Proveedor]
	cExpresionCCPorCampos = [#tabla#.LPC_LISTA + #tabla#.LPC_PROV]
	cTagClaveCandidata = '_LPCCC'
	cTagClavePk = '_LPCPK'
	cTablaPrincipal = 'LCALCULADA'
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
			local  lxLcalculadaFecexpo, lxLcalculadaFectrans, lxLcalculadaFecimpo, lxLcalculadaFaltafw, lxLcalculadaFmodifw, lxLcalculadaSmodifw, lxLcalculadaHmodifw, lxLcalculadaSaltafw, lxLcalculadaUaltafw, lxLcalculadaUmodifw, lxLcalculadaVmodifw, lxLcalculadaHoraimpo, lxLcalculadaValtafw, lxLcalculadaZadsfw, lxLcalculadaHoraexpo, lxLcalculadaBdaltafw, lxLcalculadaHaltafw, lxLcalculadaEsttrans, lxLcalculadaBdmodifw, lxLcalculadaTimestamp, lxLcalculadaNumero, lxLcalculadaLpc_lista, lxLcalculadaLpc_form, lxLcalculadaLpc_prov, lxLcalculadaLpc_obs
				lxLcalculadaFecexpo =  .Fechaexpo			lxLcalculadaFectrans =  .Fechatransferencia			lxLcalculadaFecimpo =  .Fechaimpo			lxLcalculadaFaltafw =  .Fechaaltafw			lxLcalculadaFmodifw =  .Fechamodificacionfw			lxLcalculadaSmodifw =  .Seriemodificacionfw			lxLcalculadaHmodifw =  .Horamodificacionfw			lxLcalculadaSaltafw =  .Seriealtafw			lxLcalculadaUaltafw =  .Usuarioaltafw			lxLcalculadaUmodifw =  .Usuariomodificacionfw			lxLcalculadaVmodifw =  .Versionmodificacionfw			lxLcalculadaHoraimpo =  .Horaimpo			lxLcalculadaValtafw =  .Versionaltafw			lxLcalculadaZadsfw =  .Zadsfw			lxLcalculadaHoraexpo =  .Horaexpo			lxLcalculadaBdaltafw =  .Basededatosaltafw			lxLcalculadaHaltafw =  .Horaaltafw			lxLcalculadaEsttrans =  .Estadotransferencia			lxLcalculadaBdmodifw =  .Basededatosmodificacionfw			lxLcalculadaTimestamp = goLibrerias.ObtenerTimestamp()			lxLcalculadaNumero =  .Numero			lxLcalculadaLpc_lista =  upper( .ListaDePrecios_PK ) 			lxLcalculadaLpc_form =  upper( .Formula_PK ) 			lxLcalculadaLpc_prov =  upper( .Proveedor_PK ) 			lxLcalculadaLpc_obs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLcalculadaNumero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LCALCULADA ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Vmodifw","Horaimpo","Valtafw","Zadsfw","Horaexpo","Bdaltafw","Haltafw","Esttrans","Bdmodifw","Timestamp","Numero","Lpc_lista","Lpc_form","Lpc_prov","Lpc_obs" ) values ( <<"'" + this.ConvertirDateSql( lxLcalculadaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaBdmodifw ) + "'" >>, <<lxLcalculadaTimestamp >>, <<lxLcalculadaNumero >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_lista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_form ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_prov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_obs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
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
		this.oEntidad.Timestamp = lxLcalculadaTimestamp
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
			If this.ConsultarPorClaveCandidata()
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.NUMERO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxLcalculadaFecexpo, lxLcalculadaFectrans, lxLcalculadaFecimpo, lxLcalculadaFaltafw, lxLcalculadaFmodifw, lxLcalculadaSmodifw, lxLcalculadaHmodifw, lxLcalculadaSaltafw, lxLcalculadaUaltafw, lxLcalculadaUmodifw, lxLcalculadaVmodifw, lxLcalculadaHoraimpo, lxLcalculadaValtafw, lxLcalculadaZadsfw, lxLcalculadaHoraexpo, lxLcalculadaBdaltafw, lxLcalculadaHaltafw, lxLcalculadaEsttrans, lxLcalculadaBdmodifw, lxLcalculadaTimestamp, lxLcalculadaNumero, lxLcalculadaLpc_lista, lxLcalculadaLpc_form, lxLcalculadaLpc_prov, lxLcalculadaLpc_obs
				lxLcalculadaFecexpo =  .Fechaexpo			lxLcalculadaFectrans =  .Fechatransferencia			lxLcalculadaFecimpo =  .Fechaimpo			lxLcalculadaFaltafw =  .Fechaaltafw			lxLcalculadaFmodifw =  .Fechamodificacionfw			lxLcalculadaSmodifw =  .Seriemodificacionfw			lxLcalculadaHmodifw =  .Horamodificacionfw			lxLcalculadaSaltafw =  .Seriealtafw			lxLcalculadaUaltafw =  .Usuarioaltafw			lxLcalculadaUmodifw =  .Usuariomodificacionfw			lxLcalculadaVmodifw =  .Versionmodificacionfw			lxLcalculadaHoraimpo =  .Horaimpo			lxLcalculadaValtafw =  .Versionaltafw			lxLcalculadaZadsfw =  .Zadsfw			lxLcalculadaHoraexpo =  .Horaexpo			lxLcalculadaBdaltafw =  .Basededatosaltafw			lxLcalculadaHaltafw =  .Horaaltafw			lxLcalculadaEsttrans =  .Estadotransferencia			lxLcalculadaBdmodifw =  .Basededatosmodificacionfw			lxLcalculadaTimestamp = goLibrerias.ObtenerTimestamp()			lxLcalculadaNumero =  .Numero			lxLcalculadaLpc_lista =  upper( .ListaDePrecios_PK ) 			lxLcalculadaLpc_form =  upper( .Formula_PK ) 			lxLcalculadaLpc_prov =  upper( .Proveedor_PK ) 			lxLcalculadaLpc_obs =  .Obs
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
			lxValorClavePrimaria = .oEntidad.NUMERO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.LCALCULADA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLcalculadaFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLcalculadaFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLcalculadaFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLcalculadaFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLcalculadaFmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLcalculadaHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLcalculadaZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLcalculadaHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaHaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLcalculadaEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaBdmodifw ) + "'">>,"Timestamp" = <<lxLcalculadaTimestamp>>,"Numero" = <<lxLcalculadaNumero>>,"Lpc_lista" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_lista ) + "'">>,"Lpc_form" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_form ) + "'">>,"Lpc_prov" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_prov ) + "'">>,"Lpc_obs" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_obs ) + "'">> where "Numero" = <<lxLcalculadaNumero>> and  LCALCULADA.NUMERO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxLcalculadaTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 NUMERO from ZooLogic.LCALCULADA where " + this.ConvertirFuncionesSql( " LCALCULADA.NUMERO != 0" ) )
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
			Local lxLcalculadaNumero
			lxLcalculadaNumero = .Numero

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs" from ZooLogic.LCALCULADA where "Numero" = <<lxLcalculadaNumero>> and  LCALCULADA.NUMERO != 0
			endtext
			use in select('c_LISTADEPRECIOSCALCULADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOSCALCULADA', set( 'Datasession' ) )

			if reccount( 'c_LISTADEPRECIOSCALCULADA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxLCALCULADALPC_LISTA As Variant, lxLCALCULADALPC_PROV As Variant
			lxLCALCULADALPC_LISTA = .ListaDePrecios_Pk
			lxLCALCULADALPC_PROV = .Proveedor_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs" from ZooLogic.LCALCULADA where  LCALCULADA.NUMERO != 0 And LPC_LISTA = <<"'" + this.FormatearTextoSql( lxLCALCULADALPC_LISTA ) + "'">> and LPC_PROV = <<"'" + this.FormatearTextoSql( lxLCALCULADALPC_PROV ) + "'">>
			endtext
			use in select('c_LISTADEPRECIOSCALCULADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOSCALCULADA', set( 'Datasession' ) )
			if reccount( 'c_LISTADEPRECIOSCALCULADA' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLcalculadaNumero as Variant
		llRetorno = .t.
		lxLcalculadaNumero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LCALCULADA where "Numero" = <<lxLcalculadaNumero>> and  LCALCULADA.NUMERO != 0
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
				lcOrden =  str( .Numero, 8, 0) + .ListaDePrecios_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs" from ZooLogic.LCALCULADA where  LCALCULADA.NUMERO != 0 order by NUMERO,LPC_LISTA,LPC_PROV
			endtext
			use in select('c_LISTADEPRECIOSCALCULADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOSCALCULADA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0) + .ListaDePrecios_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs" from ZooLogic.LCALCULADA where  str( NUMERO, 8, 0) + funciones.padr( LPC_LISTA, 6, ' ' ) + funciones.padr( LPC_PROV, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LCALCULADA.NUMERO != 0 order by NUMERO,LPC_LISTA,LPC_PROV
			endtext
			use in select('c_LISTADEPRECIOSCALCULADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOSCALCULADA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0) + .ListaDePrecios_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs" from ZooLogic.LCALCULADA where  str( NUMERO, 8, 0) + funciones.padr( LPC_LISTA, 6, ' ' ) + funciones.padr( LPC_PROV, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LCALCULADA.NUMERO != 0 order by NUMERO desc,LPC_LISTA desc,LPC_PROV desc
			endtext
			use in select('c_LISTADEPRECIOSCALCULADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOSCALCULADA', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0) + .ListaDePrecios_PK + .Proveedor_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs" from ZooLogic.LCALCULADA where  LCALCULADA.NUMERO != 0 order by NUMERO desc,LPC_LISTA desc,LPC_PROV desc
			endtext
			use in select('c_LISTADEPRECIOSCALCULADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOSCALCULADA', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.NUMERO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Vmodifw,Hor" + ;
"aimpo,Valtafw,Zadsfw,Horaexpo,Bdaltafw,Haltafw,Esttrans,Bdmodifw,Timestamp,Numero,Lpc_lista,Lpc_form" + ;
",Lpc_prov,Lpc_obs" + ;
" from ZooLogic.LCALCULADA where  LCALCULADA.NUMERO != 0 and " + lcFiltro )
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
			local  lxLcalculadaFecexpo, lxLcalculadaFectrans, lxLcalculadaFecimpo, lxLcalculadaFaltafw, lxLcalculadaFmodifw, lxLcalculadaSmodifw, lxLcalculadaHmodifw, lxLcalculadaSaltafw, lxLcalculadaUaltafw, lxLcalculadaUmodifw, lxLcalculadaVmodifw, lxLcalculadaHoraimpo, lxLcalculadaValtafw, lxLcalculadaZadsfw, lxLcalculadaHoraexpo, lxLcalculadaBdaltafw, lxLcalculadaHaltafw, lxLcalculadaEsttrans, lxLcalculadaBdmodifw, lxLcalculadaTimestamp, lxLcalculadaNumero, lxLcalculadaLpc_lista, lxLcalculadaLpc_form, lxLcalculadaLpc_prov, lxLcalculadaLpc_obs
				lxLcalculadaFecexpo = ctod( '  /  /    ' )			lxLcalculadaFectrans = ctod( '  /  /    ' )			lxLcalculadaFecimpo = ctod( '  /  /    ' )			lxLcalculadaFaltafw = ctod( '  /  /    ' )			lxLcalculadaFmodifw = ctod( '  /  /    ' )			lxLcalculadaSmodifw = []			lxLcalculadaHmodifw = []			lxLcalculadaSaltafw = []			lxLcalculadaUaltafw = []			lxLcalculadaUmodifw = []			lxLcalculadaVmodifw = []			lxLcalculadaHoraimpo = []			lxLcalculadaValtafw = []			lxLcalculadaZadsfw = []			lxLcalculadaHoraexpo = []			lxLcalculadaBdaltafw = []			lxLcalculadaHaltafw = []			lxLcalculadaEsttrans = []			lxLcalculadaBdmodifw = []			lxLcalculadaTimestamp = goLibrerias.ObtenerTimestamp()			lxLcalculadaNumero = 0			lxLcalculadaLpc_lista = []			lxLcalculadaLpc_form = []			lxLcalculadaLpc_prov = []			lxLcalculadaLpc_obs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LCALCULADA where "NUMERO" = ] + transform( .oEntidad.NUMERO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LCALCULADA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where NUMERO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(NUMERO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LCALCULADA.NUMERO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LCALCULADA', '', tnTope )
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
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPC_LISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'FORMULA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPC_FORM AS FORMULA'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPC_PROV AS PROVEEDOR'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPC_OBS AS OBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'LPC_LISTA'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA'
				lcCampo = 'LPC_FORM'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'LPC_PROV'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'LPC_OBS'
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
			local  lxLcalculadaFecexpo, lxLcalculadaFectrans, lxLcalculadaFecimpo, lxLcalculadaFaltafw, lxLcalculadaFmodifw, lxLcalculadaSmodifw, lxLcalculadaHmodifw, lxLcalculadaSaltafw, lxLcalculadaUaltafw, lxLcalculadaUmodifw, lxLcalculadaVmodifw, lxLcalculadaHoraimpo, lxLcalculadaValtafw, lxLcalculadaZadsfw, lxLcalculadaHoraexpo, lxLcalculadaBdaltafw, lxLcalculadaHaltafw, lxLcalculadaEsttrans, lxLcalculadaBdmodifw, lxLcalculadaTimestamp, lxLcalculadaNumero, lxLcalculadaLpc_lista, lxLcalculadaLpc_form, lxLcalculadaLpc_prov, lxLcalculadaLpc_obs
				lxLcalculadaFecexpo =  .Fechaexpo			lxLcalculadaFectrans =  .Fechatransferencia			lxLcalculadaFecimpo =  .Fechaimpo			lxLcalculadaFaltafw =  .Fechaaltafw			lxLcalculadaFmodifw =  .Fechamodificacionfw			lxLcalculadaSmodifw =  .Seriemodificacionfw			lxLcalculadaHmodifw =  .Horamodificacionfw			lxLcalculadaSaltafw =  .Seriealtafw			lxLcalculadaUaltafw =  .Usuarioaltafw			lxLcalculadaUmodifw =  .Usuariomodificacionfw			lxLcalculadaVmodifw =  .Versionmodificacionfw			lxLcalculadaHoraimpo =  .Horaimpo			lxLcalculadaValtafw =  .Versionaltafw			lxLcalculadaZadsfw =  .Zadsfw			lxLcalculadaHoraexpo =  .Horaexpo			lxLcalculadaBdaltafw =  .Basededatosaltafw			lxLcalculadaHaltafw =  .Horaaltafw			lxLcalculadaEsttrans =  .Estadotransferencia			lxLcalculadaBdmodifw =  .Basededatosmodificacionfw			lxLcalculadaTimestamp = goLibrerias.ObtenerTimestamp()			lxLcalculadaNumero =  .Numero			lxLcalculadaLpc_lista =  upper( .ListaDePrecios_PK ) 			lxLcalculadaLpc_form =  upper( .Formula_PK ) 			lxLcalculadaLpc_prov =  upper( .Proveedor_PK ) 			lxLcalculadaLpc_obs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LCALCULADA ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Smodifw","Hmodifw","Saltafw","Ualtafw","Umodifw","Vmodifw","Horaimpo","Valtafw","Zadsfw","Horaexpo","Bdaltafw","Haltafw","Esttrans","Bdmodifw","Timestamp","Numero","Lpc_lista","Lpc_form","Lpc_prov","Lpc_obs" ) values ( <<"'" + this.ConvertirDateSql( lxLcalculadaFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLcalculadaFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaBdmodifw ) + "'" >>, <<lxLcalculadaTimestamp >>, <<lxLcalculadaNumero >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_lista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_form ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_prov ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_obs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'LCALCULADA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLcalculadaFecexpo, lxLcalculadaFectrans, lxLcalculadaFecimpo, lxLcalculadaFaltafw, lxLcalculadaFmodifw, lxLcalculadaSmodifw, lxLcalculadaHmodifw, lxLcalculadaSaltafw, lxLcalculadaUaltafw, lxLcalculadaUmodifw, lxLcalculadaVmodifw, lxLcalculadaHoraimpo, lxLcalculadaValtafw, lxLcalculadaZadsfw, lxLcalculadaHoraexpo, lxLcalculadaBdaltafw, lxLcalculadaHaltafw, lxLcalculadaEsttrans, lxLcalculadaBdmodifw, lxLcalculadaTimestamp, lxLcalculadaNumero, lxLcalculadaLpc_lista, lxLcalculadaLpc_form, lxLcalculadaLpc_prov, lxLcalculadaLpc_obs
				lxLcalculadaFecexpo =  .Fechaexpo			lxLcalculadaFectrans =  .Fechatransferencia			lxLcalculadaFecimpo =  .Fechaimpo			lxLcalculadaFaltafw =  .Fechaaltafw			lxLcalculadaFmodifw =  .Fechamodificacionfw			lxLcalculadaSmodifw =  .Seriemodificacionfw			lxLcalculadaHmodifw =  .Horamodificacionfw			lxLcalculadaSaltafw =  .Seriealtafw			lxLcalculadaUaltafw =  .Usuarioaltafw			lxLcalculadaUmodifw =  .Usuariomodificacionfw			lxLcalculadaVmodifw =  .Versionmodificacionfw			lxLcalculadaHoraimpo =  .Horaimpo			lxLcalculadaValtafw =  .Versionaltafw			lxLcalculadaZadsfw =  .Zadsfw			lxLcalculadaHoraexpo =  .Horaexpo			lxLcalculadaBdaltafw =  .Basededatosaltafw			lxLcalculadaHaltafw =  .Horaaltafw			lxLcalculadaEsttrans =  .Estadotransferencia			lxLcalculadaBdmodifw =  .Basededatosmodificacionfw			lxLcalculadaTimestamp = goLibrerias.ObtenerTimestamp()			lxLcalculadaNumero =  .Numero			lxLcalculadaLpc_lista =  upper( .ListaDePrecios_PK ) 			lxLcalculadaLpc_form =  upper( .Formula_PK ) 			lxLcalculadaLpc_prov =  upper( .Proveedor_PK ) 			lxLcalculadaLpc_obs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  LCALCULADA.NUMERO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.LCALCULADA set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLcalculadaFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLcalculadaFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLcalculadaFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLcalculadaFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLcalculadaFmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLcalculadaHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLcalculadaZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLcalculadaHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLcalculadaHaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLcalculadaEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLcalculadaBdmodifw ) + "'">>, "Timestamp" = <<lxLcalculadaTimestamp>>, "Numero" = <<lxLcalculadaNumero>>, "Lpc_lista" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_lista ) + "'">>, "Lpc_form" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_form ) + "'">>, "Lpc_prov" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_prov ) + "'">>, "Lpc_obs" = <<"'" + this.FormatearTextoSql( lxLcalculadaLpc_obs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LCALCULADA' 
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
			lxValorClavePrimaria = this.oEntidad.NUMERO
			lcValorClavePrimariaString = transform( this.oEntidad.NUMERO )

			lcFiltro = ["Numero" = ] + lcValorClavePrimariaString  + [ and  LCALCULADA.NUMERO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.LCALCULADA where ' + lcFiltro )
			loColeccion.cTabla = 'LCALCULADA' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LCALCULADA where  LCALCULADA.NUMERO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LCALCULADA where NUMERO = " + transform( this.oEntidad.NUMERO )+ " and  LCALCULADA.NUMERO != 0" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
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
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxLCALCULADALPC_LISTA as variant, lxLCALCULADALPC_PROV as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOSCALCULADA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LCALCULADA Where  LPC_LISTA = ] + "'" + this.FormatearTextoSql( &lcCursor..LPC_LISTA  ) + "'" + [ and LPC_PROV = ] + "'" + this.FormatearTextoSql( &lcCursor..LPC_PROV   ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..NUMERO
				if lxValorClavePK == curSeek.NUMERO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.NUMERO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.NUMERO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.LCALCULADA set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, LPC_LISTA = ] + "'" + this.FormatearTextoSql( &lcCursor..LPC_LISTA ) + "'"+ [, LPC_FORM = ] + "'" + this.FormatearTextoSql( &lcCursor..LPC_FORM ) + "'"+ [, LPC_PROV = ] + "'" + this.FormatearTextoSql( &lcCursor..LPC_PROV ) + "'"+ [, LPC_OBS = ] + "'" + this.FormatearTextoSql( &lcCursor..LPC_OBS ) + "'" + [ Where NUMERO = ] + transform( lcValorABuscar ) )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.LCALCULADA Where NUMERO = ] + transform( &lcCursor..NUMERO ), 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, SMODIFW, HMODIFW, SALTAFW, UALTAFW, UMODIFW, VMODIFW, HORAIMPO, VALTAFW, ZADSFW, HORAEXPO, BDALTAFW, HALTAFW, ESTTRANS, BDMODIFW, TIMESTAMP, NUMERO, LPC_LISTA, LPC_FORM, LPC_PROV, LPC_OBS
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..NUMERO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPC_LISTA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPC_FORM ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPC_PROV ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPC_OBS ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.LCALCULADA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOSCALCULADA'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( NUMERO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Lista de precios: ' + transform( &tcCursor..LPC_LISTA  )
		lcRetorno = lcRetorno + ' - Proveedor: ' + transform( &tcCursor..LPC_PROV   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LISTADEPRECIOSCALCULADA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LISTADEPRECIOSCALCULADA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LISTADEPRECIOSCALCULADA_LPC_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_LCALCULADA')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LISTADEPRECIOSCALCULADA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..NUMERO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..LPC_LISTA ) or isnull( &lcCursor..LPC_PROV )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LISTADEPRECIOSCALCULADA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOSCALCULADA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,NUMERO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( NUMERO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,LPC_LISTA + LPC_PROV as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( LPC_LISTA + LPC_PROV, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOSCALCULADA'
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LCALCULADA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LCALCULADA
Create Table ZooLogic.TablaTrabajo_LCALCULADA ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"numero" numeric( 8, 0 )  null, 
"lpc_lista" char( 6 )  null, 
"lpc_form" char( 10 )  null, 
"lpc_prov" char( 10 )  null, 
"lpc_obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_LCALCULADA' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_LCALCULADA' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOSCALCULADA'
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
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('lpc_lista','lpc_lista')
			.AgregarMapeo('lpc_form','lpc_form')
			.AgregarMapeo('lpc_prov','lpc_prov')
			.AgregarMapeo('lpc_obs','lpc_obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_LCALCULADA'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.LPC_LISTA = isnull( d.LPC_LISTA, t.LPC_LISTA ),t.LPC_FORM = isnull( d.LPC_FORM, t.LPC_FORM ),t.LPC_PROV = isnull( d.LPC_PROV, t.LPC_PROV ),t.LPC_OBS = isnull( d.LPC_OBS, t.LPC_OBS )
					from ZooLogic.LCALCULADA t inner join deleted d 
							 on t.NUMERO = d.NUMERO
							 and  t.LPC_LISTA = d.LPC_LISTA
							 and  t.LPC_PROV = d.LPC_PROV
				-- Fin Updates
				insert into ZooLogic.LCALCULADA(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Smodifw,Hmodifw,Saltafw,Ualtafw,Umodifw,Vmodifw,Horaimpo,Valtafw,Zadsfw,Horaexpo,Bdaltafw,Haltafw,Esttrans,Bdmodifw,Timestamp,Numero,Lpc_lista,Lpc_form,Lpc_prov,Lpc_obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.NUMERO,0),isnull( d.LPC_LISTA,''),isnull( d.LPC_FORM,''),isnull( d.LPC_PROV,''),isnull( d.LPC_OBS,'')
						From deleted d left join ZooLogic.LCALCULADA pk 
							 on d.NUMERO = pk.NUMERO
						 left join ZooLogic.LCALCULADA cc 
							 on  d.LPC_LISTA = cc.LPC_LISTA
							 and  d.LPC_PROV = cc.LPC_PROV
						Where pk.NUMERO Is Null 
							 and cc.LPC_LISTA Is Null 
							 and cc.LPC_PROV Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: LISTA DE PRECIOS ' + cast( d.LPC_LISTA as Varchar(6) ) + ', PROVEEDOR ' + cast( d.LPC_PROV as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.LCALCULADA t inner join deleted d 
							on   t.LPC_LISTA = d.LPC_LISTA
							 and  t.LPC_PROV = d.LPC_PROV
						left join deleted h 
							 on t.NUMERO = h.NUMERO
							 where h.NUMERO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: LISTA DE PRECIOS ' + cast( d.LPC_LISTA as Varchar(6) ) + ', PROVEEDOR ' + cast( d.LPC_PROV as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.LCALCULADA t inner join deleted d 
							 on t.NUMERO = d.NUMERO
						left join deleted h 
							on   t.LPC_LISTA = h.LPC_LISTA
							 and   t.LPC_PROV = h.LPC_PROV
							where   h.LPC_LISTA is null 
							 and   h.LPC_PROV is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LCALCULADA') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LCALCULADA
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LISTADEPRECIOSCALCULADA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOSCALCULADA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOSCALCULADA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOSCALCULADA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOSCALCULADA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOSCALCULADA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Seriemodificacionfw = nvl( c_LISTADEPRECIOSCALCULADA.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_LISTADEPRECIOSCALCULADA.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_LISTADEPRECIOSCALCULADA.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_LISTADEPRECIOSCALCULADA.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_LISTADEPRECIOSCALCULADA.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_LISTADEPRECIOSCALCULADA.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_LISTADEPRECIOSCALCULADA.Horaimpo, [] )
					.Versionaltafw = nvl( c_LISTADEPRECIOSCALCULADA.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_LISTADEPRECIOSCALCULADA.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_LISTADEPRECIOSCALCULADA.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_LISTADEPRECIOSCALCULADA.Horaaltafw, [] )
					.Estadotransferencia = nvl( c_LISTADEPRECIOSCALCULADA.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_LISTADEPRECIOSCALCULADA.Basededatosmodificacionfw, [] )
					.Timestamp = nvl( c_LISTADEPRECIOSCALCULADA.Timestamp, 0 )
					.Numero = nvl( c_LISTADEPRECIOSCALCULADA.Numero, 0 )
					.Listadeprecios_PK =  nvl( c_LISTADEPRECIOSCALCULADA.Listadeprecios, [] )
					.Formula_PK =  nvl( c_LISTADEPRECIOSCALCULADA.Formula, [] )
					.Proveedor_PK =  nvl( c_LISTADEPRECIOSCALCULADA.Proveedor, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
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
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_LISTADEPRECIOSCALCULADA.NUMERO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_LISTADEPRECIOSCALCULADA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LCALCULADA' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,NUMERO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    NUMERO from (
							select * 
								from ZooLogic.LCALCULADA 
								Where   LCALCULADA.NUMERO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LCALCULADA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Numero" as "Numero", "Lpc_lista" as "Listadeprecios", "Lpc_form" as "Formula", "Lpc_prov" as "Proveedor", "Lpc_obs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LCALCULADA 
								Where   LCALCULADA.NUMERO != 0
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
	Tabla = 'LCALCULADA'
	Filtro = " LCALCULADA.NUMERO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LCALCULADA.NUMERO != 0"
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
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="FECHAEXPO                               " tabla="LCALCULADA     " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="FECHATRANSFERENCIA                      " tabla="LCALCULADA     " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="FECHAIMPO                               " tabla="LCALCULADA     " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="FECHAALTAFW                             " tabla="LCALCULADA     " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="FECHAMODIFICACIONFW                     " tabla="LCALCULADA     " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="SERIEMODIFICACIONFW                     " tabla="LCALCULADA     " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="HORAMODIFICACIONFW                      " tabla="LCALCULADA     " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="SERIEALTAFW                             " tabla="LCALCULADA     " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="USUARIOALTAFW                           " tabla="LCALCULADA     " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="USUARIOMODIFICACIONFW                   " tabla="LCALCULADA     " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="VERSIONMODIFICACIONFW                   " tabla="LCALCULADA     " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="HORAIMPO                                " tabla="LCALCULADA     " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="VERSIONALTAFW                           " tabla="LCALCULADA     " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="ZADSFW                                  " tabla="LCALCULADA     " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="HORAEXPO                                " tabla="LCALCULADA     " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="BASEDEDATOSALTAFW                       " tabla="LCALCULADA     " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="HORAALTAFW                              " tabla="LCALCULADA     " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="ESTADOTRANSFERENCIA                     " tabla="LCALCULADA     " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LCALCULADA     " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="TIMESTAMP                               " tabla="LCALCULADA     " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="NUMERO                                  " tabla="LCALCULADA     " campo="NUMERO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="EXPRESION                               " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Expresión                                                                                                                                                       " dominio="EXPRESION                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="LISTADEPRECIOS                          " tabla="LCALCULADA     " campo="LPC_LISTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Lista de precios                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="FORMULA                                 " tabla="LCALCULADA     " campo="LPC_FORM  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FORMULA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="4" etiqueta="Fórmula                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="PROVEEDOR                               " tabla="LCALCULADA     " campo="LPC_PROV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOSCALCULADA                 " atributo="OBS                                     " tabla="LCALCULADA     " campo="LPC_OBS   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On LCALCULADA.LPC_LISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FORMULA                                 " atributo="DESCRIPCION                             " tabla="FORMULA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="5" etiqueta="Detalle Fór.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FORMULA On LCALCULADA.LPC_FORM = FORMULA.Codigo And  FORMULA.CODIGO != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On LCALCULADA.LPC_PROV = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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