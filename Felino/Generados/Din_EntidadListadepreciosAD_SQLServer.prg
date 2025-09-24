
define class Din_EntidadLISTADEPRECIOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LISTADEPRECIOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_005PK'
	cTablaPrincipal = 'LPRECIO'
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
			local  lxLprecioFmodifw, lxLprecioFaltafw, lxLprecioFectrans, lxLprecioFecimpo, lxLprecioFecexpo, lxLprecioTimestamp, lxLprecioHaltafw, lxLprecioHoraexpo, lxLprecioSaltafw, lxLprecioHoraimpo, lxLprecioVmodifw, lxLprecioZadsfw, lxLprecioValtafw, lxLprecioUmodifw, lxLprecioSmodifw, lxLprecioUaltafw, lxLprecioHmodifw, lxLprecioBdaltafw, lxLprecioEsttrans, lxLprecioBdmodifw, lxLprecioLpr_numero, lxLprecioLobs, lxLprecioPcalculado, lxLprecioLpr_nombre, lxLprecioLpr_condiv, lxLprecioFechahasta, lxLprecioLpr_redond, lxLprecioListabase, lxLprecioLpr_moneda, lxLprecioOperador, lxLprecioCoeficient, lxLprecioLordcons, lxLprecioLpr_desc, lxLprecioMonedacoti, lxLprecioTredondeo, lxLprecioCantidad, lxLprecioLhabilitac, lxLprecioNivelvis
				lxLprecioFmodifw =  .Fechamodificacionfw			lxLprecioFaltafw =  .Fechaaltafw			lxLprecioFectrans =  .Fechatransferencia			lxLprecioFecimpo =  .Fechaimpo			lxLprecioFecexpo =  .Fechaexpo			lxLprecioTimestamp = goLibrerias.ObtenerTimestamp()			lxLprecioHaltafw =  .Horaaltafw			lxLprecioHoraexpo =  .Horaexpo			lxLprecioSaltafw =  .Seriealtafw			lxLprecioHoraimpo =  .Horaimpo			lxLprecioVmodifw =  .Versionmodificacionfw			lxLprecioZadsfw =  .Zadsfw			lxLprecioValtafw =  .Versionaltafw			lxLprecioUmodifw =  .Usuariomodificacionfw			lxLprecioSmodifw =  .Seriemodificacionfw			lxLprecioUaltafw =  .Usuarioaltafw			lxLprecioHmodifw =  .Horamodificacionfw			lxLprecioBdaltafw =  .Basededatosaltafw			lxLprecioEsttrans =  .Estadotransferencia			lxLprecioBdmodifw =  .Basededatosmodificacionfw			lxLprecioLpr_numero =  .Codigo			lxLprecioLobs =  .Observacion			lxLprecioPcalculado =  .Precioscalculadosalusarlos			lxLprecioLpr_nombre =  .Nombre			lxLprecioLpr_condiv =  .Condicioniva			lxLprecioFechahasta =  .Fechahasta			lxLprecioLpr_redond =  upper( .Redondeo_PK ) 			lxLprecioListabase =  upper( .ListaPBase_PK ) 			lxLprecioLpr_moneda =  upper( .Moneda_PK ) 			lxLprecioOperador =  .Operador			lxLprecioCoeficient =  .Coeficiente			lxLprecioLordcons =  .Ordenconsulta			lxLprecioLpr_desc =  upper( .DescuentoPreferente_PK ) 			lxLprecioMonedacoti =  upper( .MonedaParaCotiz_PK ) 			lxLprecioTredondeo =  .Tiporedondeo			lxLprecioCantidad =  .Cantidad			lxLprecioLhabilitac =  .Habilitaconsultas			lxLprecioNivelvis =  .Nivelvisibilidad
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLprecioLpr_numero = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.LPRECIO ( "Fmodifw","Faltafw","Fectrans","Fecimpo","Fecexpo","Timestamp","Haltafw","Horaexpo","Saltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Bdaltafw","Esttrans","Bdmodifw","Lpr_numero","Lobs","Pcalculado","Lpr_nombre","Lpr_condiv","Fechahasta","Lpr_redond","Listabase","Lpr_moneda","Operador","Coeficient","Lordcons","Lpr_desc","Monedacoti","Tredondeo","Cantidad","Lhabilitac","Nivelvis" ) values ( <<"'" + this.ConvertirDateSql( lxLprecioFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFecexpo ) + "'" >>, <<lxLprecioTimestamp >>, <<"'" + this.FormatearTextoSql( lxLprecioHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLobs ) + "'" >>, <<iif( lxLprecioPcalculado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_nombre ) + "'" >>, <<lxLprecioLpr_condiv >>, <<"'" + this.ConvertirDateSql( lxLprecioFechahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_redond ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioListabase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_moneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioOperador ) + "'" >>, <<lxLprecioCoeficient >>, <<lxLprecioLordcons >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_desc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioMonedacoti ) + "'" >>, <<lxLprecioTredondeo >>, <<lxLprecioCantidad >>, <<iif( lxLprecioLhabilitac, 1, 0 ) >>, <<lxLprecioNivelvis >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
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
		this.oEntidad.Timestamp = lxLprecioTimestamp
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
			local  lxLprecioFmodifw, lxLprecioFaltafw, lxLprecioFectrans, lxLprecioFecimpo, lxLprecioFecexpo, lxLprecioTimestamp, lxLprecioHaltafw, lxLprecioHoraexpo, lxLprecioSaltafw, lxLprecioHoraimpo, lxLprecioVmodifw, lxLprecioZadsfw, lxLprecioValtafw, lxLprecioUmodifw, lxLprecioSmodifw, lxLprecioUaltafw, lxLprecioHmodifw, lxLprecioBdaltafw, lxLprecioEsttrans, lxLprecioBdmodifw, lxLprecioLpr_numero, lxLprecioLobs, lxLprecioPcalculado, lxLprecioLpr_nombre, lxLprecioLpr_condiv, lxLprecioFechahasta, lxLprecioLpr_redond, lxLprecioListabase, lxLprecioLpr_moneda, lxLprecioOperador, lxLprecioCoeficient, lxLprecioLordcons, lxLprecioLpr_desc, lxLprecioMonedacoti, lxLprecioTredondeo, lxLprecioCantidad, lxLprecioLhabilitac, lxLprecioNivelvis
				lxLprecioFmodifw =  .Fechamodificacionfw			lxLprecioFaltafw =  .Fechaaltafw			lxLprecioFectrans =  .Fechatransferencia			lxLprecioFecimpo =  .Fechaimpo			lxLprecioFecexpo =  .Fechaexpo			lxLprecioTimestamp = goLibrerias.ObtenerTimestamp()			lxLprecioHaltafw =  .Horaaltafw			lxLprecioHoraexpo =  .Horaexpo			lxLprecioSaltafw =  .Seriealtafw			lxLprecioHoraimpo =  .Horaimpo			lxLprecioVmodifw =  .Versionmodificacionfw			lxLprecioZadsfw =  .Zadsfw			lxLprecioValtafw =  .Versionaltafw			lxLprecioUmodifw =  .Usuariomodificacionfw			lxLprecioSmodifw =  .Seriemodificacionfw			lxLprecioUaltafw =  .Usuarioaltafw			lxLprecioHmodifw =  .Horamodificacionfw			lxLprecioBdaltafw =  .Basededatosaltafw			lxLprecioEsttrans =  .Estadotransferencia			lxLprecioBdmodifw =  .Basededatosmodificacionfw			lxLprecioLpr_numero =  .Codigo			lxLprecioLobs =  .Observacion			lxLprecioPcalculado =  .Precioscalculadosalusarlos			lxLprecioLpr_nombre =  .Nombre			lxLprecioLpr_condiv =  .Condicioniva			lxLprecioFechahasta =  .Fechahasta			lxLprecioLpr_redond =  upper( .Redondeo_PK ) 			lxLprecioListabase =  upper( .ListaPBase_PK ) 			lxLprecioLpr_moneda =  upper( .Moneda_PK ) 			lxLprecioOperador =  .Operador			lxLprecioCoeficient =  .Coeficiente			lxLprecioLordcons =  .Ordenconsulta			lxLprecioLpr_desc =  upper( .DescuentoPreferente_PK ) 			lxLprecioMonedacoti =  upper( .MonedaParaCotiz_PK ) 			lxLprecioTredondeo =  .Tiporedondeo			lxLprecioCantidad =  .Cantidad			lxLprecioLhabilitac =  .Habilitaconsultas			lxLprecioNivelvis =  .Nivelvisibilidad
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
				update ZooLogic.LPRECIO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLprecioFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLprecioFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLprecioFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLprecioFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxLprecioFecexpo ) + "'">>,"Timestamp" = <<lxLprecioTimestamp>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLprecioHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLprecioHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLprecioSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLprecioHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLprecioVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLprecioZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLprecioValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLprecioUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLprecioSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLprecioUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLprecioHmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLprecioBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLprecioEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLprecioBdmodifw ) + "'">>,"Lpr_numero" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'">>,"Lobs" = <<"'" + this.FormatearTextoSql( lxLprecioLobs ) + "'">>,"Pcalculado" = <<iif( lxLprecioPcalculado, 1, 0 )>>,"Lpr_nombre" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_nombre ) + "'">>,"Lpr_condiv" = <<lxLprecioLpr_condiv>>,"Fechahasta" = <<"'" + this.ConvertirDateSql( lxLprecioFechahasta ) + "'">>,"Lpr_redond" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_redond ) + "'">>,"Listabase" = <<"'" + this.FormatearTextoSql( lxLprecioListabase ) + "'">>,"Lpr_moneda" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_moneda ) + "'">>,"Operador" = <<"'" + this.FormatearTextoSql( lxLprecioOperador ) + "'">>,"Coeficient" = <<lxLprecioCoeficient>>,"Lordcons" = <<lxLprecioLordcons>>,"Lpr_desc" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_desc ) + "'">>,"Monedacoti" = <<"'" + this.FormatearTextoSql( lxLprecioMonedacoti ) + "'">>,"Tredondeo" = <<lxLprecioTredondeo>>,"Cantidad" = <<lxLprecioCantidad>>,"Lhabilitac" = <<iif( lxLprecioLhabilitac, 1, 0 )>>,"Nivelvis" = <<lxLprecioNivelvis>> where "Lpr_numero" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'">> and  LPRECIO.LPR_NUMERO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
		this.oEntidad.Timestamp = lxLprecioTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 LPR_NUMERO from ZooLogic.LPRECIO where " + this.ConvertirFuncionesSql( " LPRECIO.LPR_NUMERO != ''" ) )
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
			Local lxLprecioLpr_numero
			lxLprecioLpr_numero = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad" from ZooLogic.LPRECIO where "Lpr_numero" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'">> and  LPRECIO.LPR_NUMERO != ''
			endtext
			use in select('c_LISTADEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOS', set( 'Datasession' ) )

			if reccount( 'c_LISTADEPRECIOS' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLprecioLpr_numero as Variant
		llRetorno = .t.
		lxLprecioLpr_numero = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.LPRECIO where "Lpr_numero" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'">> and  LPRECIO.LPR_NUMERO != ''
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad" from ZooLogic.LPRECIO where  LPRECIO.LPR_NUMERO != '' order by LPR_NUMERO
			endtext
			use in select('c_LISTADEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOS', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad" from ZooLogic.LPRECIO where  funciones.padr( LPR_NUMERO, 6, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LPRECIO.LPR_NUMERO != '' order by LPR_NUMERO
			endtext
			use in select('c_LISTADEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOS', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad" from ZooLogic.LPRECIO where  funciones.padr( LPR_NUMERO, 6, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LPRECIO.LPR_NUMERO != '' order by LPR_NUMERO desc
			endtext
			use in select('c_LISTADEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOS', set( 'Datasession' ) )
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad" from ZooLogic.LPRECIO where  LPRECIO.LPR_NUMERO != '' order by LPR_NUMERO desc
			endtext
			use in select('c_LISTADEPRECIOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADEPRECIOS', set( 'Datasession' ) )
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fectrans,Fecimpo,Fecexpo,Timestamp,Haltafw,Horaexpo,Saltafw,Horaimpo,Vmodifw" + ;
",Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Bdaltafw,Esttrans,Bdmodifw,Lpr_numero,Lobs,Pcalculad" + ;
"o,Lpr_nombre,Lpr_condiv,Fechahasta,Lpr_redond,Listabase,Lpr_moneda,Operador,Coeficient,Lordcons,Lpr_" + ;
"desc,Monedacoti,Tredondeo,Cantidad,Lhabilitac,Nivelvis" + ;
" from ZooLogic.LPRECIO where  LPRECIO.LPR_NUMERO != '' and " + lcFiltro )
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
			local  lxLprecioFmodifw, lxLprecioFaltafw, lxLprecioFectrans, lxLprecioFecimpo, lxLprecioFecexpo, lxLprecioTimestamp, lxLprecioHaltafw, lxLprecioHoraexpo, lxLprecioSaltafw, lxLprecioHoraimpo, lxLprecioVmodifw, lxLprecioZadsfw, lxLprecioValtafw, lxLprecioUmodifw, lxLprecioSmodifw, lxLprecioUaltafw, lxLprecioHmodifw, lxLprecioBdaltafw, lxLprecioEsttrans, lxLprecioBdmodifw, lxLprecioLpr_numero, lxLprecioLobs, lxLprecioPcalculado, lxLprecioLpr_nombre, lxLprecioLpr_condiv, lxLprecioFechahasta, lxLprecioLpr_redond, lxLprecioListabase, lxLprecioLpr_moneda, lxLprecioOperador, lxLprecioCoeficient, lxLprecioLordcons, lxLprecioLpr_desc, lxLprecioMonedacoti, lxLprecioTredondeo, lxLprecioCantidad, lxLprecioLhabilitac, lxLprecioNivelvis
				lxLprecioFmodifw = ctod( '  /  /    ' )			lxLprecioFaltafw = ctod( '  /  /    ' )			lxLprecioFectrans = ctod( '  /  /    ' )			lxLprecioFecimpo = ctod( '  /  /    ' )			lxLprecioFecexpo = ctod( '  /  /    ' )			lxLprecioTimestamp = goLibrerias.ObtenerTimestamp()			lxLprecioHaltafw = []			lxLprecioHoraexpo = []			lxLprecioSaltafw = []			lxLprecioHoraimpo = []			lxLprecioVmodifw = []			lxLprecioZadsfw = []			lxLprecioValtafw = []			lxLprecioUmodifw = []			lxLprecioSmodifw = []			lxLprecioUaltafw = []			lxLprecioHmodifw = []			lxLprecioBdaltafw = []			lxLprecioEsttrans = []			lxLprecioBdmodifw = []			lxLprecioLpr_numero = []			lxLprecioLobs = []			lxLprecioPcalculado = .F.			lxLprecioLpr_nombre = []			lxLprecioLpr_condiv = 0			lxLprecioFechahasta = ctod( '  /  /    ' )			lxLprecioLpr_redond = []			lxLprecioListabase = []			lxLprecioLpr_moneda = []			lxLprecioOperador = []			lxLprecioCoeficient = 0			lxLprecioLordcons = 0			lxLprecioLpr_desc = []			lxLprecioMonedacoti = []			lxLprecioTredondeo = 0			lxLprecioCantidad = 0			lxLprecioLhabilitac = .F.			lxLprecioNivelvis = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( [delete from ZooLogic.LPRECIO where "LPR_NUMERO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LPRECIO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where LPR_NUMERO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(LPR_NUMERO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  LPRECIO.LPR_NUMERO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LPRECIO', '', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
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
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPR_NUMERO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LOBS AS OBSERVACION'
				Case lcAtributo == 'PRECIOSCALCULADOSALUSARLOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCALCULADO AS PRECIOSCALCULADOSALUSARLOS'
				Case lcAtributo == 'NOMBRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPR_NOMBRE AS NOMBRE'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPR_CONDIV AS CONDICIONIVA'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAHASTA AS FECHAHASTA'
				Case lcAtributo == 'REDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPR_REDOND AS REDONDEO'
				Case lcAtributo == 'LISTAPBASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LISTABASE AS LISTAPBASE'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPR_MONEDA AS MONEDA'
				Case lcAtributo == 'OPERADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPERADOR AS OPERADOR'
				Case lcAtributo == 'COEFICIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COEFICIENT AS COEFICIENTE'
				Case lcAtributo == 'ORDENCONSULTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LORDCONS AS ORDENCONSULTA'
				Case lcAtributo == 'DESCUENTOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPR_DESC AS DESCUENTOPREFERENTE'
				Case lcAtributo == 'MONEDAPARACOTIZ'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDACOTI AS MONEDAPARACOTIZ'
				Case lcAtributo == 'TIPOREDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TREDONDEO AS TIPOREDONDEO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'HABILITACONSULTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LHABILITAC AS HABILITACONSULTAS'
				Case lcAtributo == 'NIVELVISIBILIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NIVELVIS AS NIVELVISIBILIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'LPR_NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'LOBS'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSCALCULADOSALUSARLOS'
				lcCampo = 'PCALCULADO'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRE'
				lcCampo = 'LPR_NOMBRE'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'LPR_CONDIV'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEO'
				lcCampo = 'LPR_REDOND'
			Case upper( alltrim( tcAtributo ) ) == 'LISTAPBASE'
				lcCampo = 'LISTABASE'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'LPR_MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADOR'
				lcCampo = 'OPERADOR'
			Case upper( alltrim( tcAtributo ) ) == 'COEFICIENTE'
				lcCampo = 'COEFICIENT'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENCONSULTA'
				lcCampo = 'LORDCONS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPREFERENTE'
				lcCampo = 'LPR_DESC'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDAPARACOTIZ'
				lcCampo = 'MONEDACOTI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOREDONDEO'
				lcCampo = 'TREDONDEO'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITACONSULTAS'
				lcCampo = 'LHABILITAC'
			Case upper( alltrim( tcAtributo ) ) == 'NIVELVISIBILIDAD'
				lcCampo = 'NIVELVIS'
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
			local  lxLprecioFmodifw, lxLprecioFaltafw, lxLprecioFectrans, lxLprecioFecimpo, lxLprecioFecexpo, lxLprecioTimestamp, lxLprecioHaltafw, lxLprecioHoraexpo, lxLprecioSaltafw, lxLprecioHoraimpo, lxLprecioVmodifw, lxLprecioZadsfw, lxLprecioValtafw, lxLprecioUmodifw, lxLprecioSmodifw, lxLprecioUaltafw, lxLprecioHmodifw, lxLprecioBdaltafw, lxLprecioEsttrans, lxLprecioBdmodifw, lxLprecioLpr_numero, lxLprecioLobs, lxLprecioPcalculado, lxLprecioLpr_nombre, lxLprecioLpr_condiv, lxLprecioFechahasta, lxLprecioLpr_redond, lxLprecioListabase, lxLprecioLpr_moneda, lxLprecioOperador, lxLprecioCoeficient, lxLprecioLordcons, lxLprecioLpr_desc, lxLprecioMonedacoti, lxLprecioTredondeo, lxLprecioCantidad, lxLprecioLhabilitac, lxLprecioNivelvis
				lxLprecioFmodifw =  .Fechamodificacionfw			lxLprecioFaltafw =  .Fechaaltafw			lxLprecioFectrans =  .Fechatransferencia			lxLprecioFecimpo =  .Fechaimpo			lxLprecioFecexpo =  .Fechaexpo			lxLprecioTimestamp = goLibrerias.ObtenerTimestamp()			lxLprecioHaltafw =  .Horaaltafw			lxLprecioHoraexpo =  .Horaexpo			lxLprecioSaltafw =  .Seriealtafw			lxLprecioHoraimpo =  .Horaimpo			lxLprecioVmodifw =  .Versionmodificacionfw			lxLprecioZadsfw =  .Zadsfw			lxLprecioValtafw =  .Versionaltafw			lxLprecioUmodifw =  .Usuariomodificacionfw			lxLprecioSmodifw =  .Seriemodificacionfw			lxLprecioUaltafw =  .Usuarioaltafw			lxLprecioHmodifw =  .Horamodificacionfw			lxLprecioBdaltafw =  .Basededatosaltafw			lxLprecioEsttrans =  .Estadotransferencia			lxLprecioBdmodifw =  .Basededatosmodificacionfw			lxLprecioLpr_numero =  .Codigo			lxLprecioLobs =  .Observacion			lxLprecioPcalculado =  .Precioscalculadosalusarlos			lxLprecioLpr_nombre =  .Nombre			lxLprecioLpr_condiv =  .Condicioniva			lxLprecioFechahasta =  .Fechahasta			lxLprecioLpr_redond =  upper( .Redondeo_PK ) 			lxLprecioListabase =  upper( .ListaPBase_PK ) 			lxLprecioLpr_moneda =  upper( .Moneda_PK ) 			lxLprecioOperador =  .Operador			lxLprecioCoeficient =  .Coeficiente			lxLprecioLordcons =  .Ordenconsulta			lxLprecioLpr_desc =  upper( .DescuentoPreferente_PK ) 			lxLprecioMonedacoti =  upper( .MonedaParaCotiz_PK ) 			lxLprecioTredondeo =  .Tiporedondeo			lxLprecioCantidad =  .Cantidad			lxLprecioLhabilitac =  .Habilitaconsultas			lxLprecioNivelvis =  .Nivelvisibilidad
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.LPRECIO ( "Fmodifw","Faltafw","Fectrans","Fecimpo","Fecexpo","Timestamp","Haltafw","Horaexpo","Saltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Hmodifw","Bdaltafw","Esttrans","Bdmodifw","Lpr_numero","Lobs","Pcalculado","Lpr_nombre","Lpr_condiv","Fechahasta","Lpr_redond","Listabase","Lpr_moneda","Operador","Coeficient","Lordcons","Lpr_desc","Monedacoti","Tredondeo","Cantidad","Lhabilitac","Nivelvis" ) values ( <<"'" + this.ConvertirDateSql( lxLprecioFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLprecioFecexpo ) + "'" >>, <<lxLprecioTimestamp >>, <<"'" + this.FormatearTextoSql( lxLprecioHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLobs ) + "'" >>, <<iif( lxLprecioPcalculado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_nombre ) + "'" >>, <<lxLprecioLpr_condiv >>, <<"'" + this.ConvertirDateSql( lxLprecioFechahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_redond ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioListabase ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_moneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioOperador ) + "'" >>, <<lxLprecioCoeficient >>, <<lxLprecioLordcons >>, <<"'" + this.FormatearTextoSql( lxLprecioLpr_desc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLprecioMonedacoti ) + "'" >>, <<lxLprecioTredondeo >>, <<lxLprecioCantidad >>, <<iif( lxLprecioLhabilitac, 1, 0 ) >>, <<lxLprecioNivelvis >> )
		endtext
		loColeccion.cTabla = 'LPRECIO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLprecioFmodifw, lxLprecioFaltafw, lxLprecioFectrans, lxLprecioFecimpo, lxLprecioFecexpo, lxLprecioTimestamp, lxLprecioHaltafw, lxLprecioHoraexpo, lxLprecioSaltafw, lxLprecioHoraimpo, lxLprecioVmodifw, lxLprecioZadsfw, lxLprecioValtafw, lxLprecioUmodifw, lxLprecioSmodifw, lxLprecioUaltafw, lxLprecioHmodifw, lxLprecioBdaltafw, lxLprecioEsttrans, lxLprecioBdmodifw, lxLprecioLpr_numero, lxLprecioLobs, lxLprecioPcalculado, lxLprecioLpr_nombre, lxLprecioLpr_condiv, lxLprecioFechahasta, lxLprecioLpr_redond, lxLprecioListabase, lxLprecioLpr_moneda, lxLprecioOperador, lxLprecioCoeficient, lxLprecioLordcons, lxLprecioLpr_desc, lxLprecioMonedacoti, lxLprecioTredondeo, lxLprecioCantidad, lxLprecioLhabilitac, lxLprecioNivelvis
				lxLprecioFmodifw =  .Fechamodificacionfw			lxLprecioFaltafw =  .Fechaaltafw			lxLprecioFectrans =  .Fechatransferencia			lxLprecioFecimpo =  .Fechaimpo			lxLprecioFecexpo =  .Fechaexpo			lxLprecioTimestamp = goLibrerias.ObtenerTimestamp()			lxLprecioHaltafw =  .Horaaltafw			lxLprecioHoraexpo =  .Horaexpo			lxLprecioSaltafw =  .Seriealtafw			lxLprecioHoraimpo =  .Horaimpo			lxLprecioVmodifw =  .Versionmodificacionfw			lxLprecioZadsfw =  .Zadsfw			lxLprecioValtafw =  .Versionaltafw			lxLprecioUmodifw =  .Usuariomodificacionfw			lxLprecioSmodifw =  .Seriemodificacionfw			lxLprecioUaltafw =  .Usuarioaltafw			lxLprecioHmodifw =  .Horamodificacionfw			lxLprecioBdaltafw =  .Basededatosaltafw			lxLprecioEsttrans =  .Estadotransferencia			lxLprecioBdmodifw =  .Basededatosmodificacionfw			lxLprecioLpr_numero =  .Codigo			lxLprecioLobs =  .Observacion			lxLprecioPcalculado =  .Precioscalculadosalusarlos			lxLprecioLpr_nombre =  .Nombre			lxLprecioLpr_condiv =  .Condicioniva			lxLprecioFechahasta =  .Fechahasta			lxLprecioLpr_redond =  upper( .Redondeo_PK ) 			lxLprecioListabase =  upper( .ListaPBase_PK ) 			lxLprecioLpr_moneda =  upper( .Moneda_PK ) 			lxLprecioOperador =  .Operador			lxLprecioCoeficient =  .Coeficiente			lxLprecioLordcons =  .Ordenconsulta			lxLprecioLpr_desc =  upper( .DescuentoPreferente_PK ) 			lxLprecioMonedacoti =  upper( .MonedaParaCotiz_PK ) 			lxLprecioTredondeo =  .Tiporedondeo			lxLprecioCantidad =  .Cantidad			lxLprecioLhabilitac =  .Habilitaconsultas			lxLprecioNivelvis =  .Nivelvisibilidad
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Lpr_numero" = ] + lcValorClavePrimariaString  + [ and  LPRECIO.LPR_NUMERO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.LPRECIO set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLprecioFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLprecioFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLprecioFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLprecioFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLprecioFecexpo ) + "'">>, "Timestamp" = <<lxLprecioTimestamp>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLprecioHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLprecioHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLprecioSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLprecioHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLprecioVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLprecioZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLprecioValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLprecioUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLprecioSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLprecioUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLprecioHmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLprecioBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLprecioEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLprecioBdmodifw ) + "'">>, "Lpr_numero" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_numero ) + "'">>, "Lobs" = <<"'" + this.FormatearTextoSql( lxLprecioLobs ) + "'">>, "Pcalculado" = <<iif( lxLprecioPcalculado, 1, 0 )>>, "Lpr_nombre" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_nombre ) + "'">>, "Lpr_condiv" = <<lxLprecioLpr_condiv>>, "Fechahasta" = <<"'" + this.ConvertirDateSql( lxLprecioFechahasta ) + "'">>, "Lpr_redond" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_redond ) + "'">>, "Listabase" = <<"'" + this.FormatearTextoSql( lxLprecioListabase ) + "'">>, "Lpr_moneda" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_moneda ) + "'">>, "Operador" = <<"'" + this.FormatearTextoSql( lxLprecioOperador ) + "'">>, "Coeficient" = <<lxLprecioCoeficient>>, "Lordcons" = <<lxLprecioLordcons>>, "Lpr_desc" = <<"'" + this.FormatearTextoSql( lxLprecioLpr_desc ) + "'">>, "Monedacoti" = <<"'" + this.FormatearTextoSql( lxLprecioMonedacoti ) + "'">>, "Tredondeo" = <<lxLprecioTredondeo>>, "Cantidad" = <<lxLprecioCantidad>>, "Lhabilitac" = <<iif( lxLprecioLhabilitac, 1, 0 )>>, "Nivelvis" = <<lxLprecioNivelvis>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LPRECIO' 
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
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Lpr_numero" = ] + lcValorClavePrimariaString  + [ and  LPRECIO.LPR_NUMERO != '']
		loColeccion.Agregar( 'delete from ZooLogic.LPRECIO where ' + lcFiltro )
			loColeccion.cTabla = 'LPRECIO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.LPRECIO where  LPRECIO.LPR_NUMERO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.LPRECIO where LPR_NUMERO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  LPRECIO.LPR_NUMERO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.LPRECIO Where LPR_NUMERO = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_NUMERO ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.LPRECIO set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, LPR_NUMERO = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_NUMERO ) + "'"+ [, LObs = ] + "'" + this.FormatearTextoSql( &lcCursor..LObs ) + "'"+ [, PCalculado = ] + Transform( iif( &lcCursor..PCalculado, 1, 0 ))+ [, LPR_NOMBRE = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_NOMBRE ) + "'"+ [, LPR_CONDIV = ] + transform( &lcCursor..LPR_CONDIV )+ [, fechahasta = ] + "'" + this.ConvertirDateSql( &lcCursor..fechahasta ) + "'"+ [, LPR_REDOND = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_REDOND ) + "'"+ [, ListaBase = ] + "'" + this.FormatearTextoSql( &lcCursor..ListaBase ) + "'"+ [, LPR_MONEDA = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_MONEDA ) + "'"+ [, Operador = ] + "'" + this.FormatearTextoSql( &lcCursor..Operador ) + "'"+ [, Coeficient = ] + transform( &lcCursor..Coeficient )+ [, LPR_DESC = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_DESC ) + "'"+ [, MonedaCoti = ] + "'" + this.FormatearTextoSql( &lcCursor..MonedaCoti ) + "'"+ [, TRedondeo = ] + transform( &lcCursor..TRedondeo )+ [, Cantidad = ] + transform( &lcCursor..Cantidad )+ [, LHabilitaC = ] + Transform( iif( &lcCursor..LHabilitaC, 1, 0 ))+ [, NivelVis = ] + transform( &lcCursor..NivelVis ) + [ Where LPR_NUMERO = ] + "'" + this.FormatearTextoSql( &lcCursor..LPR_NUMERO ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FALTAFW, FECTRANS, FECIMPO, FECEXPO, TIMESTAMP, HALTAFW, HORAEXPO, SALTAFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, HMODIFW, BDALTAFW, ESTTRANS, BDMODIFW, LPR_NUMERO, LObs, PCalculado, LPR_NOMBRE, LPR_CONDIV, fechahasta, LPR_REDOND, ListaBase, LPR_MONEDA, Operador, Coeficient, LPR_DESC, MonedaCoti, TRedondeo, Cantidad, LHabilitaC, NivelVis
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPR_NUMERO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LObs ) + "'" + ',' + Transform( iif( &lcCursor..PCalculado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPR_NOMBRE ) + "'" + ',' + transform( &lcCursor..LPR_CONDIV ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechahasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPR_REDOND ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ListaBase ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPR_MONEDA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Operador ) + "'" + ',' + transform( &lcCursor..Coeficient ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..LPR_DESC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonedaCoti ) + "'" + ',' + transform( &lcCursor..TRedondeo ) + ',' + transform( &lcCursor..Cantidad ) + ',' + Transform( iif( &lcCursor..LHabilitaC, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..NivelVis )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.LPRECIO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOS'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( LPR_NUMERO C (6) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..LPR_NUMERO )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LISTADEPRECIOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LISTADEPRECIOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LISTADEPRECIOS_LOBS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_LPRECIO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LISTADEPRECIOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..LPR_NUMERO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LISTADEPRECIOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,LPR_NUMERO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( LPR_NUMERO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  fechahasta
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LPRECIO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LPRECIO
Create Table ZooLogic.TablaTrabajo_LPRECIO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"lpr_numero" char( 6 )  null, 
"lobs" varchar(max)  null, 
"pcalculado" bit  null, 
"lpr_nombre" char( 30 )  null, 
"lpr_condiv" numeric( 1, 0 )  null, 
"fechahasta" datetime  null, 
"lpr_redond" char( 10 )  null, 
"listabase" char( 6 )  null, 
"lpr_moneda" char( 10 )  null, 
"operador" char( 1 )  null, 
"coeficient" numeric( 15, 2 )  null, 
"lordcons" numeric( 1, 0 )  null, 
"lpr_desc" char( 10 )  null, 
"monedacoti" char( 10 )  null, 
"tredondeo" numeric( 1, 0 )  null, 
"cantidad" numeric( 2, 0 )  null, 
"lhabilitac" bit  null, 
"nivelvis" numeric( 1, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_LPRECIO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_LPRECIO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADEPRECIOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('lpr_numero','lpr_numero')
			.AgregarMapeo('lobs','lobs')
			.AgregarMapeo('pcalculado','pcalculado')
			.AgregarMapeo('lpr_nombre','lpr_nombre')
			.AgregarMapeo('lpr_condiv','lpr_condiv')
			.AgregarMapeo('fechahasta','fechahasta')
			.AgregarMapeo('lpr_redond','lpr_redond')
			.AgregarMapeo('listabase','listabase')
			.AgregarMapeo('lpr_moneda','lpr_moneda')
			.AgregarMapeo('operador','operador')
			.AgregarMapeo('coeficient','coeficient')
			.AgregarMapeo('lordcons','lordcons')
			.AgregarMapeo('lpr_desc','lpr_desc')
			.AgregarMapeo('monedacoti','monedacoti')
			.AgregarMapeo('tredondeo','tredondeo')
			.AgregarMapeo('cantidad','cantidad')
			.AgregarMapeo('lhabilitac','lhabilitac')
			.AgregarMapeo('nivelvis','nivelvis')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_LPRECIO'
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.LPR_NUMERO = isnull( d.LPR_NUMERO, t.LPR_NUMERO ),t.LOBS = isnull( d.LOBS, t.LOBS ),t.PCALCULADO = isnull( d.PCALCULADO, t.PCALCULADO ),t.LPR_NOMBRE = isnull( d.LPR_NOMBRE, t.LPR_NOMBRE ),t.LPR_CONDIV = isnull( d.LPR_CONDIV, t.LPR_CONDIV ),t.FECHAHASTA = isnull( d.FECHAHASTA, t.FECHAHASTA ),t.LPR_REDOND = isnull( d.LPR_REDOND, t.LPR_REDOND ),t.LISTABASE = isnull( d.LISTABASE, t.LISTABASE ),t.LPR_MONEDA = isnull( d.LPR_MONEDA, t.LPR_MONEDA ),t.OPERADOR = isnull( d.OPERADOR, t.OPERADOR ),t.COEFICIENT = isnull( d.COEFICIENT, t.COEFICIENT ),t.LORDCONS = isnull( d.LORDCONS, t.LORDCONS ),t.LPR_DESC = isnull( d.LPR_DESC, t.LPR_DESC ),t.MONEDACOTI = isnull( d.MONEDACOTI, t.MONEDACOTI ),t.TREDONDEO = isnull( d.TREDONDEO, t.TREDONDEO ),t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),t.LHABILITAC = isnull( d.LHABILITAC, t.LHABILITAC ),t.NIVELVIS = isnull( d.NIVELVIS, t.NIVELVIS )
					from ZooLogic.LPRECIO t inner join deleted d 
							 on t.LPR_NUMERO = d.LPR_NUMERO
				-- Fin Updates
				insert into ZooLogic.LPRECIO(Fmodifw,Faltafw,Fectrans,Fecimpo,Fecexpo,Timestamp,Haltafw,Horaexpo,Saltafw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Hmodifw,Bdaltafw,Esttrans,Bdmodifw,Lpr_numero,Lobs,Pcalculado,Lpr_nombre,Lpr_condiv,Fechahasta,Lpr_redond,Listabase,Lpr_moneda,Operador,Coeficient,Lordcons,Lpr_desc,Monedacoti,Tredondeo,Cantidad,Lhabilitac,Nivelvis)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.TIMESTAMP,0),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.LPR_NUMERO,''),isnull( d.LOBS,''),isnull( d.PCALCULADO,0),isnull( d.LPR_NOMBRE,''),isnull( d.LPR_CONDIV,0),isnull( d.FECHAHASTA,''),isnull( d.LPR_REDOND,''),isnull( d.LISTABASE,''),isnull( d.LPR_MONEDA,''),isnull( d.OPERADOR,''),isnull( d.COEFICIENT,0),isnull( d.LORDCONS,0),isnull( d.LPR_DESC,''),isnull( d.MONEDACOTI,''),isnull( d.TREDONDEO,0),isnull( d.CANTIDAD,0),isnull( d.LHABILITAC,0),isnull( d.NIVELVIS,0)
						From deleted d left join ZooLogic.LPRECIO pk 
							 on d.LPR_NUMERO = pk.LPR_NUMERO
						Where pk.LPR_NUMERO Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_LPRECIO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_LPRECIO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LISTADEPRECIOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_LISTADEPRECIOS.Timestamp, 0 )
					.Horaaltafw = nvl( c_LISTADEPRECIOS.Horaaltafw, [] )
					.Horaexpo = nvl( c_LISTADEPRECIOS.Horaexpo, [] )
					.Seriealtafw = nvl( c_LISTADEPRECIOS.Seriealtafw, [] )
					.Horaimpo = nvl( c_LISTADEPRECIOS.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_LISTADEPRECIOS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_LISTADEPRECIOS.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_LISTADEPRECIOS.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_LISTADEPRECIOS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_LISTADEPRECIOS.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_LISTADEPRECIOS.Horamodificacionfw, [] )
					.Basededatosaltafw = nvl( c_LISTADEPRECIOS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_LISTADEPRECIOS.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_LISTADEPRECIOS.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_LISTADEPRECIOS.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Precioscalculadosalusarlos = nvl( c_LISTADEPRECIOS.Precioscalculadosalusarlos, .F. )
					.Nombre = nvl( c_LISTADEPRECIOS.Nombre, [] )
					.Condicioniva = nvl( c_LISTADEPRECIOS.Condicioniva, 0 )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADEPRECIOS.Fechahasta, ctod( '  /  /    ' ) ) )
					.Redondeo_PK =  nvl( c_LISTADEPRECIOS.Redondeo, [] )
					.Listapbase_PK =  nvl( c_LISTADEPRECIOS.Listapbase, [] )
					.Moneda_PK =  nvl( c_LISTADEPRECIOS.Moneda, [] )
					.Operador = nvl( c_LISTADEPRECIOS.Operador, [] )
					.Coeficiente = nvl( c_LISTADEPRECIOS.Coeficiente, 0 )
					.Ordenconsulta = nvl( c_LISTADEPRECIOS.Ordenconsulta, 0 )
					.Descuentopreferente_PK =  nvl( c_LISTADEPRECIOS.Descuentopreferente, [] )
					.Monedaparacotiz_PK =  nvl( c_LISTADEPRECIOS.Monedaparacotiz, [] )
					.Tiporedondeo = nvl( c_LISTADEPRECIOS.Tiporedondeo, 0 )
					.Cantidad = nvl( c_LISTADEPRECIOS.Cantidad, 0 )
					.Habilitaconsultas = nvl( c_LISTADEPRECIOS.Habilitaconsultas, .F. )
					.Nivelvisibilidad = nvl( c_LISTADEPRECIOS.Nivelvisibilidad, 0 )
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
		return c_LISTADEPRECIOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.LPRECIO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "LPR_NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,LPR_NUMERO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    LPR_NUMERO from (
							select * 
								from ZooLogic.LPRECIO 
								Where   LPRECIO.LPR_NUMERO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LPRECIO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "LPR_NUMERO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Timestamp" as "Timestamp", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Lpr_numero" as "Codigo", "Lobs" as "Observacion", "Pcalculado" as "Precioscalculadosalusarlos", "Lpr_nombre" as "Nombre", "Lpr_condiv" as "Condicioniva", "Fechahasta" as "Fechahasta", "Lpr_redond" as "Redondeo", "Listabase" as "Listapbase", "Lpr_moneda" as "Moneda", "Operador" as "Operador", "Coeficient" as "Coeficiente", "Lordcons" as "Ordenconsulta", "Lpr_desc" as "Descuentopreferente", "Monedacoti" as "Monedaparacotiz", "Tredondeo" as "Tiporedondeo", "Cantidad" as "Cantidad", "Lhabilitac" as "Habilitaconsultas", "Nivelvis" as "Nivelvisibilidad"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.LPRECIO 
								Where   LPRECIO.LPR_NUMERO != ''
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
	Tabla = 'LPRECIO'
	Filtro = " LPRECIO.LPR_NUMERO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LPRECIO.LPR_NUMERO != ''"
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
	<row entidad="LISTADEPRECIOS                          " atributo="FECHAMODIFICACIONFW                     " tabla="LPRECIO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="FECHAALTAFW                             " tabla="LPRECIO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="FECHATRANSFERENCIA                      " tabla="LPRECIO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="FECHAIMPO                               " tabla="LPRECIO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="FECHAEXPO                               " tabla="LPRECIO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="TIMESTAMP                               " tabla="LPRECIO        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="HORAALTAFW                              " tabla="LPRECIO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="HORAEXPO                                " tabla="LPRECIO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="SERIEALTAFW                             " tabla="LPRECIO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="HORAIMPO                                " tabla="LPRECIO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="VERSIONMODIFICACIONFW                   " tabla="LPRECIO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="ZADSFW                                  " tabla="LPRECIO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="VERSIONALTAFW                           " tabla="LPRECIO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="USUARIOMODIFICACIONFW                   " tabla="LPRECIO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="SERIEMODIFICACIONFW                     " tabla="LPRECIO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="USUARIOALTAFW                           " tabla="LPRECIO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="HORAMODIFICACIONFW                      " tabla="LPRECIO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="BASEDEDATOSALTAFW                       " tabla="LPRECIO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="ESTADOTRANSFERENCIA                     " tabla="LPRECIO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LPRECIO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="CODIGO                                  " tabla="LPRECIO        " campo="LPR_NUMERO" claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="OBSERVACION                             " tabla="LPRECIO        " campo="LOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="PRECIOSCALCULADOSALUSARLOS              " tabla="LPRECIO        " campo="PCALCULADO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Precios calculados al momento de usarlos                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Nombre                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="CONDICIONIVA                            " tabla="LPRECIO        " campo="LPR_CONDIV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=goRegistry.felino.ListaDePreciosIVAincluido                                                                                                                                                                                                                  " obligatorio="true" admitebusqueda="406" etiqueta="Condición impuestos                                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="FECHAHASTA                              " tabla="LPRECIO        " campo="FECHAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="No seleccionable a partir de                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="REDONDEO                                " tabla="LPRECIO        " campo="LPR_REDOND" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REDONDEODEPRECIOS                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Redondeo                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="LISTAPBASE                              " tabla="LPRECIO        " campo="LISTABASE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Lista de precios base                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; LPRECIO.PCalculado = 0 &quot;                                                                                                                                                                              " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="MONEDA                                  " tabla="LPRECIO        " campo="LPR_MONEDA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="true" admitebusqueda="414" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="OPERADOR                                " tabla="LPRECIO        " campo="OPERADOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Operador                                                                                                                                                        " dominio="COMBOOPERACION                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="COEFICIENTE                             " tabla="LPRECIO        " campo="COEFICIENT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Coeficiente                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="ORDENCONSULTA                           " tabla="LPRECIO        " campo="LORDCONS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Orden en Consulta                                                                                                                                               " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="DESCUENTOPREFERENTE                     " tabla="LPRECIO        " campo="LPR_DESC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESCUENTO                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Descuento                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="MONEDAPARACOTIZ                         " tabla="LPRECIO        " campo="MONEDACOTI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Cotización                                                                                                                                                      " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="TIPOREDONDEO                            " tabla="LPRECIO        " campo="TREDONDEO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Redondeo                                                                                                                                                        " dominio="REDONDEOLISTAPRECIOS          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="CANTIDAD                                " tabla="LPRECIO        " campo="CANTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Cantidad                                                                                                                                                        " dominio="REDONDEOLISTAPRECIOS          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="HABILITACONSULTAS                       " tabla="LPRECIO        " campo="LHABILITAC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Habilitada para consulta de stock y precios                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NIVELVISIBILIDAD                        " tabla="LPRECIO        " campo="NIVELVIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Visibilidad                                                                                                                                                     " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DESCRIPCION                             " tabla="REDO           " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="411" etiqueta="Detalle Red.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REDO On LPRECIO.LPR_REDOND = REDO.codigo And  REDO.CODIGO != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On LPRECIO.LPR_MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCUENTO                               " atributo="DESCRIPCION                             " tabla="DESCUENTOS     " campo="DES       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESCUENTOS On LPRECIO.LPR_DESC = DESCUENTOS.codigo And  DESCUENTOS.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Cot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On LPRECIO.MONEDACOTI = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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