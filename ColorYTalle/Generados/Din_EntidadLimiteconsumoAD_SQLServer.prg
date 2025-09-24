
define class Din_EntidadLIMITECONSUMOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LIMITECONSUMO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.NUMERO, 8, 0)]
	cTagClaveCandidata = '_LCNCC'
	cTagClavePk = '_LCNPK'
	cTablaPrincipal = 'LCONSUMO'
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
			local  lxLconsumoFecexpo, lxLconsumoFectrans, lxLconsumoFmodifw, lxLconsumoFaltafw, lxLconsumoFecimpo, lxLconsumoNumero, lxLconsumoUaltafw, lxLconsumoSaltafw, lxLconsumoSmodifw, lxLconsumoHmodifw, lxLconsumoUmodifw, lxLconsumoZadsfw, lxLconsumoDescfw, lxLconsumoVmodifw, lxLconsumoHoraimpo, lxLconsumoValtafw, lxLconsumoHaltafw, lxLconsumoBdmodifw, lxLconsumoBdaltafw, lxLconsumoHoraexpo, lxLconsumoEsttrans, lxLconsumoTimestamp, lxLconsumoCodint, lxLconsumoCliente, lxLconsumoFechadesde, lxLconsumoClasif, lxLconsumoFechahasta, lxLconsumoMonto, lxLconsumoObs
				lxLconsumoFecexpo =  .Fechaexpo			lxLconsumoFectrans =  .Fechatransferencia			lxLconsumoFmodifw =  .Fechamodificacionfw			lxLconsumoFaltafw =  .Fechaaltafw			lxLconsumoFecimpo =  .Fechaimpo			lxLconsumoNumero =  .Numero			lxLconsumoUaltafw =  .Usuarioaltafw			lxLconsumoSaltafw =  .Seriealtafw			lxLconsumoSmodifw =  .Seriemodificacionfw			lxLconsumoHmodifw =  .Horamodificacionfw			lxLconsumoUmodifw =  .Usuariomodificacionfw			lxLconsumoZadsfw =  .Zadsfw			lxLconsumoDescfw =  .Descripcionfw			lxLconsumoVmodifw =  .Versionmodificacionfw			lxLconsumoHoraimpo =  .Horaimpo			lxLconsumoValtafw =  .Versionaltafw			lxLconsumoHaltafw =  .Horaaltafw			lxLconsumoBdmodifw =  .Basededatosmodificacionfw			lxLconsumoBdaltafw =  .Basededatosaltafw			lxLconsumoHoraexpo =  .Horaexpo			lxLconsumoEsttrans =  .Estadotransferencia			lxLconsumoTimestamp = goLibrerias.ObtenerTimestamp()			lxLconsumoCodint =  .Codint			lxLconsumoCliente =  upper( .Cliente_PK ) 			lxLconsumoFechadesde =  .Fechadesde			lxLconsumoClasif =  upper( .Clasificacion_PK ) 			lxLconsumoFechahasta =  .Fechahasta			lxLconsumoMonto =  .Monto			lxLconsumoObs =  .Observacion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLconsumoCodint = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LCONSUMO ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Numero","Ualtafw","Saltafw","Smodifw","Hmodifw","Umodifw","Zadsfw","Descfw","Vmodifw","Horaimpo","Valtafw","Haltafw","Bdmodifw","Bdaltafw","Horaexpo","Esttrans","Timestamp","Codint","Cliente","Fechadesde","Clasif","Fechahasta","Monto","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxLconsumoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFecimpo ) + "'" >>, <<lxLconsumoNumero >>, <<"'" + this.FormatearTextoSql( lxLconsumoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoEsttrans ) + "'" >>, <<lxLconsumoTimestamp >>, <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoCliente ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFechadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoClasif ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFechahasta ) + "'" >>, <<lxLconsumoMonto >>, <<"'" + this.FormatearTextoSql( lxLconsumoObs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = lxValorClavePrimaria

			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
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
		this.oEntidad.Timestamp = lxLconsumoTimestamp
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
				lcError  = 'El número a grabar ya existe. Cambie el último número del talonario correspondiente'
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.CODINT
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxLconsumoFecexpo, lxLconsumoFectrans, lxLconsumoFmodifw, lxLconsumoFaltafw, lxLconsumoFecimpo, lxLconsumoNumero, lxLconsumoUaltafw, lxLconsumoSaltafw, lxLconsumoSmodifw, lxLconsumoHmodifw, lxLconsumoUmodifw, lxLconsumoZadsfw, lxLconsumoDescfw, lxLconsumoVmodifw, lxLconsumoHoraimpo, lxLconsumoValtafw, lxLconsumoHaltafw, lxLconsumoBdmodifw, lxLconsumoBdaltafw, lxLconsumoHoraexpo, lxLconsumoEsttrans, lxLconsumoTimestamp, lxLconsumoCodint, lxLconsumoCliente, lxLconsumoFechadesde, lxLconsumoClasif, lxLconsumoFechahasta, lxLconsumoMonto, lxLconsumoObs
				lxLconsumoFecexpo =  .Fechaexpo			lxLconsumoFectrans =  .Fechatransferencia			lxLconsumoFmodifw =  .Fechamodificacionfw			lxLconsumoFaltafw =  .Fechaaltafw			lxLconsumoFecimpo =  .Fechaimpo			lxLconsumoNumero =  .Numero			lxLconsumoUaltafw =  .Usuarioaltafw			lxLconsumoSaltafw =  .Seriealtafw			lxLconsumoSmodifw =  .Seriemodificacionfw			lxLconsumoHmodifw =  .Horamodificacionfw			lxLconsumoUmodifw =  .Usuariomodificacionfw			lxLconsumoZadsfw =  .Zadsfw			lxLconsumoDescfw =  .Descripcionfw			lxLconsumoVmodifw =  .Versionmodificacionfw			lxLconsumoHoraimpo =  .Horaimpo			lxLconsumoValtafw =  .Versionaltafw			lxLconsumoHaltafw =  .Horaaltafw			lxLconsumoBdmodifw =  .Basededatosmodificacionfw			lxLconsumoBdaltafw =  .Basededatosaltafw			lxLconsumoHoraexpo =  .Horaexpo			lxLconsumoEsttrans =  .Estadotransferencia			lxLconsumoTimestamp = goLibrerias.ObtenerTimestamp()			lxLconsumoCodint =  .Codint			lxLconsumoCliente =  upper( .Cliente_PK ) 			lxLconsumoFechadesde =  .Fechadesde			lxLconsumoClasif =  upper( .Clasificacion_PK ) 			lxLconsumoFechahasta =  .Fechahasta			lxLconsumoMonto =  .Monto			lxLconsumoObs =  .Observacion
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.Cliente != .oEntidad.Cliente_Pk or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaDesde) != this.ConvertirDateSql( .oEntidad.FechaDesde) or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaHasta) != this.ConvertirDateSql( .oEntidad.FechaHasta) or  .oEntidad.oAtributosAuditoria.Monto != .oEntidad.Monto )
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODINT
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.LCONSUMO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLconsumoFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLconsumoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLconsumoFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLconsumoFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLconsumoFecimpo ) + "'">>,"Numero" = <<lxLconsumoNumero>>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLconsumoUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLconsumoSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoUmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLconsumoZadsfw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxLconsumoDescfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoVmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLconsumoHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLconsumoValtafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLconsumoHaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLconsumoBdaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLconsumoHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLconsumoEsttrans ) + "'">>,"Timestamp" = <<lxLconsumoTimestamp>>,"Codint" = <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxLconsumoCliente ) + "'">>,"Fechadesde" = <<"'" + this.ConvertirDateSql( lxLconsumoFechadesde ) + "'">>,"Clasif" = <<"'" + this.FormatearTextoSql( lxLconsumoClasif ) + "'">>,"Fechahasta" = <<"'" + this.ConvertirDateSql( lxLconsumoFechahasta ) + "'">>,"Monto" = <<lxLconsumoMonto>>,"Obs" = <<"'" + this.FormatearTextoSql( lxLconsumoObs ) + "'">> where "Codint" = <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'">> and  LCONSUMO.CODINT != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			If llInsertarAuditoria
				lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			EndIf
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
		this.oEntidad.Timestamp = lxLconsumoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CodInt from ZooLogic.LCONSUMO where " + this.ConvertirFuncionesSql( " LCONSUMO.CODINT != ''" ) )
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
			Local lxLconsumoCodint
			lxLconsumoCodint = .Codint

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.LCONSUMO where "Codint" = <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'">> and  LCONSUMO.CODINT != ''
			endtext
			use in select('c_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIMITECONSUMO', set( 'Datasession' ) )

			if reccount( 'c_LIMITECONSUMO' ) = 0
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
			Local lxLCONSUMONUMERO As Variant
			lxLCONSUMONUMERO = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.LCONSUMO where  LCONSUMO.CODINT != '' And NUMERO = <<lxLCONSUMONUMERO>>
			endtext
			use in select('c_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIMITECONSUMO', set( 'Datasession' ) )
			if reccount( 'c_LIMITECONSUMO' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLconsumoCodint as Variant
		llRetorno = .t.
		lxLconsumoCodint = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LCONSUMO where "Codint" = <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'">> and  LCONSUMO.CODINT != ''
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.LCONSUMO where  LCONSUMO.CODINT != '' order by NUMERO
			endtext
			use in select('c_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIMITECONSUMO', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.LCONSUMO where  str( NUMERO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LCONSUMO.CODINT != '' order by NUMERO
			endtext
			use in select('c_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIMITECONSUMO', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.LCONSUMO where  str( NUMERO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LCONSUMO.CODINT != '' order by NUMERO desc
			endtext
			use in select('c_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIMITECONSUMO', set( 'Datasession' ) )
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
				lcOrden =  str( .Numero, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion" from ZooLogic.LCONSUMO where  LCONSUMO.CODINT != '' order by NUMERO desc
			endtext
			use in select('c_LIMITECONSUMO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LIMITECONSUMO', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Numero,Ualtafw,Saltafw,Smodifw,Hmodifw,Umodifw,Zads" + ;
"fw,Descfw,Vmodifw,Horaimpo,Valtafw,Haltafw,Bdmodifw,Bdaltafw,Horaexpo,Esttrans,Timestamp,Codint,Clie" + ;
"nte,Fechadesde,Clasif,Fechahasta,Monto,Obs" + ;
" from ZooLogic.LCONSUMO where  LCONSUMO.CODINT != '' and " + lcFiltro )
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
			local  lxLconsumoFecexpo, lxLconsumoFectrans, lxLconsumoFmodifw, lxLconsumoFaltafw, lxLconsumoFecimpo, lxLconsumoNumero, lxLconsumoUaltafw, lxLconsumoSaltafw, lxLconsumoSmodifw, lxLconsumoHmodifw, lxLconsumoUmodifw, lxLconsumoZadsfw, lxLconsumoDescfw, lxLconsumoVmodifw, lxLconsumoHoraimpo, lxLconsumoValtafw, lxLconsumoHaltafw, lxLconsumoBdmodifw, lxLconsumoBdaltafw, lxLconsumoHoraexpo, lxLconsumoEsttrans, lxLconsumoTimestamp, lxLconsumoCodint, lxLconsumoCliente, lxLconsumoFechadesde, lxLconsumoClasif, lxLconsumoFechahasta, lxLconsumoMonto, lxLconsumoObs
				lxLconsumoFecexpo = ctod( '  /  /    ' )			lxLconsumoFectrans = ctod( '  /  /    ' )			lxLconsumoFmodifw = ctod( '  /  /    ' )			lxLconsumoFaltafw = ctod( '  /  /    ' )			lxLconsumoFecimpo = ctod( '  /  /    ' )			lxLconsumoNumero = 0			lxLconsumoUaltafw = []			lxLconsumoSaltafw = []			lxLconsumoSmodifw = []			lxLconsumoHmodifw = []			lxLconsumoUmodifw = []			lxLconsumoZadsfw = []			lxLconsumoDescfw = []			lxLconsumoVmodifw = []			lxLconsumoHoraimpo = []			lxLconsumoValtafw = []			lxLconsumoHaltafw = []			lxLconsumoBdmodifw = []			lxLconsumoBdaltafw = []			lxLconsumoHoraexpo = []			lxLconsumoEsttrans = []			lxLconsumoTimestamp = goLibrerias.ObtenerTimestamp()			lxLconsumoCodint = []			lxLconsumoCliente = []			lxLconsumoFechadesde = ctod( '  /  /    ' )			lxLconsumoClasif = []			lxLconsumoFechahasta = ctod( '  /  /    ' )			lxLconsumoMonto = 0			lxLconsumoObs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LCONSUMO where "CodInt" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODINT ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LCONSUMO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CodInt = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CodInt, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LCONSUMO.CODINT != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LCONSUMO', '', tnTope )
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
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CODINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODINT'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHADESDE AS FECHADESDE'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASIF AS CLASIFICACION'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAHASTA AS FECHAHASTA'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
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
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODINT'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLASIF'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
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
			local  lxLconsumoFecexpo, lxLconsumoFectrans, lxLconsumoFmodifw, lxLconsumoFaltafw, lxLconsumoFecimpo, lxLconsumoNumero, lxLconsumoUaltafw, lxLconsumoSaltafw, lxLconsumoSmodifw, lxLconsumoHmodifw, lxLconsumoUmodifw, lxLconsumoZadsfw, lxLconsumoDescfw, lxLconsumoVmodifw, lxLconsumoHoraimpo, lxLconsumoValtafw, lxLconsumoHaltafw, lxLconsumoBdmodifw, lxLconsumoBdaltafw, lxLconsumoHoraexpo, lxLconsumoEsttrans, lxLconsumoTimestamp, lxLconsumoCodint, lxLconsumoCliente, lxLconsumoFechadesde, lxLconsumoClasif, lxLconsumoFechahasta, lxLconsumoMonto, lxLconsumoObs
				lxLconsumoFecexpo =  .Fechaexpo			lxLconsumoFectrans =  .Fechatransferencia			lxLconsumoFmodifw =  .Fechamodificacionfw			lxLconsumoFaltafw =  .Fechaaltafw			lxLconsumoFecimpo =  .Fechaimpo			lxLconsumoNumero =  .Numero			lxLconsumoUaltafw =  .Usuarioaltafw			lxLconsumoSaltafw =  .Seriealtafw			lxLconsumoSmodifw =  .Seriemodificacionfw			lxLconsumoHmodifw =  .Horamodificacionfw			lxLconsumoUmodifw =  .Usuariomodificacionfw			lxLconsumoZadsfw =  .Zadsfw			lxLconsumoDescfw =  .Descripcionfw			lxLconsumoVmodifw =  .Versionmodificacionfw			lxLconsumoHoraimpo =  .Horaimpo			lxLconsumoValtafw =  .Versionaltafw			lxLconsumoHaltafw =  .Horaaltafw			lxLconsumoBdmodifw =  .Basededatosmodificacionfw			lxLconsumoBdaltafw =  .Basededatosaltafw			lxLconsumoHoraexpo =  .Horaexpo			lxLconsumoEsttrans =  .Estadotransferencia			lxLconsumoTimestamp = goLibrerias.ObtenerTimestamp()			lxLconsumoCodint =  .Codint			lxLconsumoCliente =  upper( .Cliente_PK ) 			lxLconsumoFechadesde =  .Fechadesde			lxLconsumoClasif =  upper( .Clasificacion_PK ) 			lxLconsumoFechahasta =  .Fechahasta			lxLconsumoMonto =  .Monto			lxLconsumoObs =  .Observacion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LCONSUMO ( "Fecexpo","Fectrans","Fmodifw","Faltafw","Fecimpo","Numero","Ualtafw","Saltafw","Smodifw","Hmodifw","Umodifw","Zadsfw","Descfw","Vmodifw","Horaimpo","Valtafw","Haltafw","Bdmodifw","Bdaltafw","Horaexpo","Esttrans","Timestamp","Codint","Cliente","Fechadesde","Clasif","Fechahasta","Monto","Obs" ) values ( <<"'" + this.ConvertirDateSql( lxLconsumoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFecimpo ) + "'" >>, <<lxLconsumoNumero >>, <<"'" + this.FormatearTextoSql( lxLconsumoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoEsttrans ) + "'" >>, <<lxLconsumoTimestamp >>, <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoCliente ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFechadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLconsumoClasif ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLconsumoFechahasta ) + "'" >>, <<lxLconsumoMonto >>, <<"'" + this.FormatearTextoSql( lxLconsumoObs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'LCONSUMO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLconsumoFecexpo, lxLconsumoFectrans, lxLconsumoFmodifw, lxLconsumoFaltafw, lxLconsumoFecimpo, lxLconsumoNumero, lxLconsumoUaltafw, lxLconsumoSaltafw, lxLconsumoSmodifw, lxLconsumoHmodifw, lxLconsumoUmodifw, lxLconsumoZadsfw, lxLconsumoDescfw, lxLconsumoVmodifw, lxLconsumoHoraimpo, lxLconsumoValtafw, lxLconsumoHaltafw, lxLconsumoBdmodifw, lxLconsumoBdaltafw, lxLconsumoHoraexpo, lxLconsumoEsttrans, lxLconsumoTimestamp, lxLconsumoCodint, lxLconsumoCliente, lxLconsumoFechadesde, lxLconsumoClasif, lxLconsumoFechahasta, lxLconsumoMonto, lxLconsumoObs
				lxLconsumoFecexpo =  .Fechaexpo			lxLconsumoFectrans =  .Fechatransferencia			lxLconsumoFmodifw =  .Fechamodificacionfw			lxLconsumoFaltafw =  .Fechaaltafw			lxLconsumoFecimpo =  .Fechaimpo			lxLconsumoNumero =  .Numero			lxLconsumoUaltafw =  .Usuarioaltafw			lxLconsumoSaltafw =  .Seriealtafw			lxLconsumoSmodifw =  .Seriemodificacionfw			lxLconsumoHmodifw =  .Horamodificacionfw			lxLconsumoUmodifw =  .Usuariomodificacionfw			lxLconsumoZadsfw =  .Zadsfw			lxLconsumoDescfw =  .Descripcionfw			lxLconsumoVmodifw =  .Versionmodificacionfw			lxLconsumoHoraimpo =  .Horaimpo			lxLconsumoValtafw =  .Versionaltafw			lxLconsumoHaltafw =  .Horaaltafw			lxLconsumoBdmodifw =  .Basededatosmodificacionfw			lxLconsumoBdaltafw =  .Basededatosaltafw			lxLconsumoHoraexpo =  .Horaexpo			lxLconsumoEsttrans =  .Estadotransferencia			lxLconsumoTimestamp = goLibrerias.ObtenerTimestamp()			lxLconsumoCodint =  .Codint			lxLconsumoCliente =  upper( .Cliente_PK ) 			lxLconsumoFechadesde =  .Fechadesde			lxLconsumoClasif =  upper( .Clasificacion_PK ) 			lxLconsumoFechahasta =  .Fechahasta			lxLconsumoMonto =  .Monto			lxLconsumoObs =  .Observacion
		endwith
		With this
			local llInsertarAuditoria as Boolean
			llInsertarAuditoria = (  .oEntidad.oAtributosAuditoria.Cliente != .oEntidad.Cliente_Pk or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaDesde) != this.ConvertirDateSql( .oEntidad.FechaDesde) or  .oEntidad.oAtributosAuditoria.Clasificacion != .oEntidad.Clasificacion_Pk or  this.ConvertirDateSql( .oEntidad.oAtributosAuditoria.FechaHasta) != this.ConvertirDateSql( .oEntidad.FechaHasta) or  .oEntidad.oAtributosAuditoria.Monto != .oEntidad.Monto )
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  LCONSUMO.CODINT != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.LCONSUMO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLconsumoFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLconsumoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLconsumoFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLconsumoFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLconsumoFecimpo ) + "'">>, "Numero" = <<lxLconsumoNumero>>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLconsumoUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLconsumoSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoUmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLconsumoZadsfw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxLconsumoDescfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoVmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLconsumoHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLconsumoValtafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLconsumoHaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLconsumoBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLconsumoBdaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLconsumoHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLconsumoEsttrans ) + "'">>, "Timestamp" = <<lxLconsumoTimestamp>>, "Codint" = <<"'" + this.FormatearTextoSql( lxLconsumoCodint ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxLconsumoCliente ) + "'">>, "Fechadesde" = <<"'" + this.ConvertirDateSql( lxLconsumoFechadesde ) + "'">>, "Clasif" = <<"'" + this.FormatearTextoSql( lxLconsumoClasif ) + "'">>, "Fechahasta" = <<"'" + this.ConvertirDateSql( lxLconsumoFechahasta ) + "'">>, "Monto" = <<lxLconsumoMonto>>, "Obs" = <<"'" + this.FormatearTextoSql( lxLconsumoObs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LCONSUMO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
		If llInsertarAuditoria
			lcSentencia = this.ObtenerSentenciasInsertAuditoria()
			loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		EndIf
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
			lxValorClavePrimaria = this.oEntidad.CODINT
			lcValorClavePrimariaString = "'" + this.oEntidad.CODINT + "'"

			lcFiltro = ["Codint" = ] + lcValorClavePrimariaString  + [ and  LCONSUMO.CODINT != '']
		loColeccion.Agregar( 'delete from ZooLogic.LCONSUMO where ' + lcFiltro )
			loColeccion.cTabla = 'LCONSUMO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LCONSUMO where  LCONSUMO.CODINT != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LCONSUMO where CodInt = " + "'" + this.FormatearTextoSql( this.oEntidad.CODINT ) + "'"+ " and  LCONSUMO.CODINT != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxLCONSUMONUMERO as variant, lxLCONSUMOCliente as variant, lxLCONSUMOFechaDesde as variant, lxLCONSUMOClasif as variant, lxLCONSUMOFechaHasta as variant, lxLCONSUMOMonto as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIMITECONSUMO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LCONSUMO Where  NUMERO = ] + transform( &lcCursor..NUMERO     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CodInt
				if lxValorClavePK == curSeek.CodInt or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CodInt and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CodInt
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						local llInsertarAuditoria as boolean
						llInsertarAuditoria = (  iif( isnull( curSeek.Cliente != &lcCursor..Cliente ), .F., curSeek.Cliente != &lcCursor..Cliente ) or  iif( isnull( ( curSeek.FechaDesde != &lcCursor..FechaDesde ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FechaDesde ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FechaDesde ) ) ) ), .F., ( curSeek.FechaDesde != &lcCursor..FechaDesde ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FechaDesde ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FechaDesde ) ) ) ) or  iif( isnull( curSeek.Clasif != &lcCursor..Clasif ), .F., curSeek.Clasif != &lcCursor..Clasif ) or  iif( isnull( ( curSeek.FechaHasta != &lcCursor..FechaHasta ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FechaHasta ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FechaHasta ) ) ) ), .F., ( curSeek.FechaHasta != &lcCursor..FechaHasta ) and ( !empty( goServicios.Librerias.ObtenerFechaFormateada( curSeek.FechaHasta ) ) or !empty( goServicios.Librerias.ObtenerFechaFormateada( &lcCursor..FechaHasta ) ) ) ) or  iif( isnull( curSeek.Monto != &lcCursor..Monto ), .F., curSeek.Monto != &lcCursor..Monto ) )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.LCONSUMO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, NUMERO = ] + transform( &lcCursor..NUMERO )+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, FechaDesde = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaDesde ) + "'"+ [, Clasif = ] + "'" + this.FormatearTextoSql( &lcCursor..Clasif ) + "'"+ [, FechaHasta = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaHasta ) + "'"+ [, Monto = ] + transform( &lcCursor..Monto )+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + [ Where CodInt = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
						if llInsertarAuditoria
							lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
							this.oConexion.EjecutarSql( lcSentencia )
						EndIf
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.LCONSUMO Where CodInt = ] + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FECTRANS, FMODIFW, FALTAFW, FECIMPO, NUMERO, UALTAFW, SALTAFW, SMODIFW, HMODIFW, UMODIFW, ZADSFW, DescFW, VMODIFW, HORAIMPO, VALTAFW, HALTAFW, BDMODIFW, BDALTAFW, HORAEXPO, ESTTRANS, TIMESTAMP, CodInt, Cliente, FechaDesde, Clasif, FechaHasta, Monto, Obs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + transform( &lcCursor..NUMERO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodInt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Clasif ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaHasta ) + "'" + ',' + transform( &lcCursor..Monto )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.LCONSUMO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcSentencia = this.ObtenerSentenciasInsertAuditoria( lcCursor )
					this.oConexion.EjecutarSql( lcSentencia )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LIMITECONSUMO'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CodInt C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..NUMERO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LIMITECONSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIMITECONSUMO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LIMITECONSUMO_OBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_LCONSUMO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LIMITECONSUMO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CodInt
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NUMERO )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LIMITECONSUMO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIMITECONSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CodInt as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CodInt, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( NUMERO, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( NUMERO, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIMITECONSUMO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FechaDesde
		* Validar ANTERIORES A 1/1/1753  FechaHasta
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LCONSUMO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LCONSUMO
Create Table ZooLogic.TablaTrabajo_LCONSUMO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"numero" numeric( 8, 0 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"zadsfw" varchar(max)  null, 
"descfw" char( 200 )  null, 
"vmodifw" char( 13 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"haltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"codint" char( 38 )  null, 
"cliente" char( 10 )  null, 
"fechadesde" datetime  null, 
"clasif" char( 10 )  null, 
"fechahasta" datetime  null, 
"monto" numeric( 15, 2 )  null, 
"obs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_LCONSUMO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_LCONSUMO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LIMITECONSUMO'
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
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('codint','codint')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('fechadesde','fechadesde')
			.AgregarMapeo('clasif','clasif')
			.AgregarMapeo('fechahasta','fechahasta')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('obs','obs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_LCONSUMO'
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
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string
		lcCabecera1 = "replace( newId(),'-','1' )"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera9 = iif( .F., 1, 0 )
		
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				insert into ZooLogic.ADT_LCONSUMO ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","NUMERO","CodInt","Cliente","Fechadesde","Clasif","Fechahasta","Monto" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Numero,d.Codint,Isnull( d.Cliente,t.Cliente),Isnull( d.Fechadesde,t.Fechadesde),Isnull( d.Clasif,t.Clasif),Isnull( d.Fechahasta,t.Fechahasta),Isnull( d.Monto,t.Monto)
						from ZooLogic.LCONSUMO t inner join deleted d 
							 on t.CodInt = d.CodInt
							 and  t.NUMERO = d.NUMERO
					where ( d.Cliente is not null and d.Cliente <> t.Cliente ) or ( d.FechaDesde is not null and d.FechaDesde <> t.FechaDesde ) or ( d.Clasif is not null and d.Clasif <> t.Clasif ) or ( d.FechaHasta is not null and d.FechaHasta <> t.FechaHasta ) or ( d.Monto is not null and d.Monto <> t.Monto )
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CODINT = isnull( d.CODINT, t.CODINT ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.FECHADESDE = isnull( d.FECHADESDE, t.FECHADESDE ),t.CLASIF = isnull( d.CLASIF, t.CLASIF ),t.FECHAHASTA = isnull( d.FECHAHASTA, t.FECHAHASTA ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.OBS = isnull( d.OBS, t.OBS )
					from ZooLogic.LCONSUMO t inner join deleted d 
							 on t.CodInt = d.CodInt
							 and  t.NUMERO = d.NUMERO
				-- Fin Updates
				insert into ZooLogic.ADT_LCONSUMO ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","NUMERO","CodInt","Cliente","Fechadesde","Clasif","Fechahasta","Monto" ) 
					Select <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, case when funciones.empty( d.DescFw ) = 1 then 'IMPORTACION' else d.descFw end, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, d.Numero,d.Codint,isnull( d.CLIENTE,''),isnull( d.FECHADESDE,''),isnull( d.CLASIF,''),isnull( d.FECHAHASTA,''),isnull( d.MONTO,0)
						From deleted d left join ZooLogic.LCONSUMO pk 
							 on d.CodInt = pk.CodInt
						 left join ZooLogic.LCONSUMO cc 
							 on  d.NUMERO = cc.NUMERO
						Where pk.CodInt Is Null 
							 and cc.NUMERO Is Null 
				insert into ZooLogic.LCONSUMO(Fecexpo,Fectrans,Fmodifw,Faltafw,Fecimpo,Numero,Ualtafw,Saltafw,Smodifw,Hmodifw,Umodifw,Zadsfw,Descfw,Vmodifw,Horaimpo,Valtafw,Haltafw,Bdmodifw,Bdaltafw,Horaexpo,Esttrans,Timestamp,Codint,Cliente,Fechadesde,Clasif,Fechahasta,Monto,Obs)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.NUMERO,0),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.ZADSFW,''),isnull( d.DESCFW,''),isnull( d.VMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.CODINT,''),isnull( d.CLIENTE,''),isnull( d.FECHADESDE,''),isnull( d.CLASIF,''),isnull( d.FECHAHASTA,''),isnull( d.MONTO,0),isnull( d.OBS,'')
						From deleted d left join ZooLogic.LCONSUMO pk 
							 on d.CodInt = pk.CodInt
						 left join ZooLogic.LCONSUMO cc 
							 on  d.NUMERO = cc.NUMERO
						Where pk.CodInt Is Null 
							 and cc.NUMERO Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.LCONSUMO t inner join deleted d 
							on   t.NUMERO = d.NUMERO
						left join deleted h 
							 on t.CodInt = h.CodInt
							 where h.CodInt is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.NUMERO as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.LCONSUMO t inner join deleted d 
							 on t.CodInt = d.CodInt
						left join deleted h 
							on   t.NUMERO = h.NUMERO
							where   h.NUMERO is null 
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LCONSUMO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LCONSUMO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LIMITECONSUMO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Numero = nvl( c_LIMITECONSUMO.Numero, 0 )
					.Usuarioaltafw = nvl( c_LIMITECONSUMO.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_LIMITECONSUMO.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_LIMITECONSUMO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_LIMITECONSUMO.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_LIMITECONSUMO.Usuariomodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Descripcionfw = nvl( c_LIMITECONSUMO.Descripcionfw, [] )
					.Versionmodificacionfw = nvl( c_LIMITECONSUMO.Versionmodificacionfw, [] )
					.Horaimpo = nvl( c_LIMITECONSUMO.Horaimpo, [] )
					.Versionaltafw = nvl( c_LIMITECONSUMO.Versionaltafw, [] )
					.Horaaltafw = nvl( c_LIMITECONSUMO.Horaaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_LIMITECONSUMO.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_LIMITECONSUMO.Basededatosaltafw, [] )
					.Horaexpo = nvl( c_LIMITECONSUMO.Horaexpo, [] )
					.Estadotransferencia = nvl( c_LIMITECONSUMO.Estadotransferencia, [] )
					.Timestamp = nvl( c_LIMITECONSUMO.Timestamp, 0 )
					.Codint = nvl( c_LIMITECONSUMO.Codint, [] )
					.Cliente_PK =  nvl( c_LIMITECONSUMO.Cliente, [] )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechadesde, ctod( '  /  /    ' ) ) )
					.Clasificacion_PK =  nvl( c_LIMITECONSUMO.Clasificacion, [] )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_LIMITECONSUMO.Fechahasta, ctod( '  /  /    ' ) ) )
					.Monto = nvl( c_LIMITECONSUMO.Monto, 0 )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					Select c_LIMITECONSUMO
					scatter name This.oEntidad.oAtributosAuditoria
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
	*-----------------------------------------------------------------------------------------
	function ObtenerSentenciasInsertAuditoria( tcCursor as string ) as String
		if empty( tcCursor )
			local lcDescripcionFW as string
			lcDescripcionFW = this.oEntidad.DescripcionFW
		else
			local lcDescripcionFW as string
			lcDescripcionFW = &tcCursor..DescFW
		endif
		Local lcCabecera1 as string, lcCabecera2 as string, lcCabecera3 as string, lcCabecera4 as string, lcCabecera5 as string, lcCabecera6 as string, lcCabecera7 as string, lcCabecera8 as string, lcCabecera9 as string;
		, lcCabecera10 as string
		lcCabecera1 = "'" + this.FormatearTextoSql( goLibrerias.ObtenerGuidPk() ) + "'"
		lcCabecera2 = "'" + this.ConvertirDateSql( golibrerias.obtenerfechaformateada( golibrerias.obtenerfecha() ) ) + "'"
		lcCabecera3 = "'" + this.FormatearTextoSql( golibrerias.obtenerhora() ) + "'"
		lcCabecera4 = "'" + this.FormatearTextoSql( alltrim( _screen.zoo.app.cSerie ) ) + "'"
		lcCabecera5 = "'" + this.FormatearTextoSql( goServicios.Seguridad.cUsuarioLogueado ) + "'"
		lcCabecera6 = "'" + this.FormatearTextoSql( this.oEntidad.ObtenerNombre() ) + "'"
		lcCabecera7 = "'" + this.FormatearTextoSql( lcDescripcionFW ) + "'"
		lcCabecera8 = "'" + this.FormatearTextoSql( alltrim('1.00') ) + "'"
		lcCabecera9 = "'" + this.FormatearTextoSql( _Screen.zoo.app.obtenerversion() ) + "'"
		lcCabecera10 = iif( .F., 1, 0 )
		
		local lxValorClavePrimaria as variant
		if empty( tcCursor )
			lxValorClavePrimaria = this.oEntidad.CODINT
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string
			lcEntidad1 = transform( this.oEntidad.Numero )
			lcEntidad2 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( this.oEntidad.Cliente_pk ) + "'"
			lcEntidad4 = "'" + this.ConvertirDateSql( this.oEntidad.Fechadesde ) + "'"
			lcEntidad5 = "'" + this.FormatearTextoSql( this.oEntidad.Clasificacion_pk ) + "'"
			lcEntidad6 = "'" + this.ConvertirDateSql( this.oEntidad.Fechahasta ) + "'"
			lcEntidad7 = transform( this.oEntidad.Monto )
			
		else
			lxValorClavePrimaria = &tcCursor..CodInt
			Local lcEntidad1 as string, lcEntidad2 as string, lcEntidad3 as string, lcEntidad4 as string, lcEntidad5 as string, lcEntidad6 as string, lcEntidad7 as string
			lcEntidad1 = transform( &tcCursor..Numero )
			lcEntidad2 = "'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'"
			lcEntidad3 = "'" + this.FormatearTextoSql( &tcCursor..Cliente ) + "'"
			lcEntidad4 = "'" + this.ConvertirDateSql( &tcCursor..Fechadesde ) + "'"
			lcEntidad5 = "'" + this.FormatearTextoSql( &tcCursor..Clasif ) + "'"
			lcEntidad6 = "'" + this.ConvertirDateSql( &tcCursor..Fechahasta ) + "'"
			lcEntidad7 = transform( &tcCursor..Monto )
			
		endif
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ADT_LCONSUMO ( "ADT_Cod","ADT_Fecha","ADT_Hora","ADT_Serie","ADT_Usr","ADT_Ent","ADT_Comp","ADT_ADN","ADT_Vers","ADT_Ext","NUMERO","CodInt","Cliente","Fechadesde","Clasif","Fechahasta","Monto" ) values ( <<lcCabecera1>>, <<lcCabecera2>>, <<lcCabecera3>>, <<lcCabecera4>>, <<lcCabecera5>>, <<lcCabecera6>>, <<lcCabecera7>>, <<lcCabecera8>>, <<lcCabecera9>>, <<lcCabecera10>>, <<lcEntidad1>>, <<lcEntidad2>>, <<lcEntidad3>>, <<lcEntidad4>>, <<lcEntidad5>>, <<lcEntidad6>>, <<lcEntidad7>> ) 
			endtext
		return lcSentencia
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_LIMITECONSUMO.CODINT
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
		return c_LIMITECONSUMO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LCONSUMO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodInt"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CodInt as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CodInt from (
							select * 
								from ZooLogic.LCONSUMO 
								Where   LCONSUMO.CODINT != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LCONSUMO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CodInt"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Numero" as "Numero", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Zadsfw" as "Zadsfw", "Descfw" as "Descripcionfw", "Vmodifw" as "Versionmodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Haltafw" as "Horaaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Timestamp" as "Timestamp", "Codint" as "Codint", "Cliente" as "Cliente", "Fechadesde" as "Fechadesde", "Clasif" as "Clasificacion", "Fechahasta" as "Fechahasta", "Monto" as "Monto", "Obs" as "Observacion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LCONSUMO 
								Where   LCONSUMO.CODINT != ''
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
	Tabla = 'LCONSUMO'
	Filtro = " LCONSUMO.CODINT != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LCONSUMO.CODINT != ''"
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
	<row entidad="LIMITECONSUMO                           " atributo="FECHAEXPO                               " tabla="LCONSUMO       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="FECHATRANSFERENCIA                      " tabla="LCONSUMO       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="FECHAMODIFICACIONFW                     " tabla="LCONSUMO       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="FECHAALTAFW                             " tabla="LCONSUMO       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="FECHAIMPO                               " tabla="LCONSUMO       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="NUMERO                                  " tabla="LCONSUMO       " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="USUARIOALTAFW                           " tabla="LCONSUMO       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="SERIEALTAFW                             " tabla="LCONSUMO       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="SERIEMODIFICACIONFW                     " tabla="LCONSUMO       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="HORAMODIFICACIONFW                      " tabla="LCONSUMO       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="USUARIOMODIFICACIONFW                   " tabla="LCONSUMO       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="ZADSFW                                  " tabla="LCONSUMO       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="DESCRIPCIONFW                           " tabla="LCONSUMO       " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="VERSIONMODIFICACIONFW                   " tabla="LCONSUMO       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="HORAIMPO                                " tabla="LCONSUMO       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="VERSIONALTAFW                           " tabla="LCONSUMO       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="HORAALTAFW                              " tabla="LCONSUMO       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LCONSUMO       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="BASEDEDATOSALTAFW                       " tabla="LCONSUMO       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="HORAEXPO                                " tabla="LCONSUMO       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="ESTADOTRANSFERENCIA                     " tabla="LCONSUMO       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="TIMESTAMP                               " tabla="LCONSUMO       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="CODINT                                  " tabla="LCONSUMO       " campo="CODINT    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="198" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="CLIENTE                                 " tabla="LCONSUMO       " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="400" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="FECHADESDE                              " tabla="LCONSUMO       " campo="FECHADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="402" etiqueta="Inicia                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="CLASIFICACION                           " tabla="LCONSUMO       " campo="CLASIF    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="CLIENTE.CLASIFICACION                                                                                                                                                                                                                                         " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="FECHAHASTA                              " tabla="LCONSUMO       " campo="FECHAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=gomonth(goServicios.librerias.ObtenerFecha(),1)                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Caduca                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="MONTO                                   " tabla="LCONSUMO       " campo="MONTO     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="408" etiqueta="Monto máximo                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="MONTOUTILIZADO                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Monto utilizado                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LIMITECONSUMO                           " atributo="OBSERVACION                             " tabla="LCONSUMO       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="401" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On LCONSUMO.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On LCONSUMO.CLASIF = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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