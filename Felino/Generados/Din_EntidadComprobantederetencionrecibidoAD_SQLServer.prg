
define class Din_EntidadCOMPROBANTEDERETENCIONRECIBIDOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMPROBANTEDERETENCIONRECIBIDO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( NumeroInterno, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.numint, 8, 0)]
	cTagClaveCandidata = '_CRRCC'
	cTagClavePk = '_CRRPK'
	cTablaPrincipal = 'COMPRR'
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
			local  lxComprrFecimpo, lxComprrFecexpo, lxComprrFmodifw, lxComprrFaltafw, lxComprrFectrans, lxComprrTimestamp, lxComprrAnulado, lxComprrDescfw, lxComprrZadsfw, lxComprrSmodifw, lxComprrHmodifw, lxComprrUmodifw, lxComprrValtafw, lxComprrUaltafw, lxComprrHoraimpo, lxComprrSaltafw, lxComprrVmodifw, lxComprrEsttrans, lxComprrHoraexpo, lxComprrHaltafw, lxComprrBdaltafw, lxComprrBdmodifw, lxComprrCodigo, lxComprrCliente, lxComprrCliedesc, lxComprrCuit, lxComprrTipoimp, lxComprrRegimen, lxComprrRegidesc, lxComprrNumint, lxComprrFechcert, lxComprrNumecert, lxComprrRecibo, lxComprrFechreci, lxComprrRtotal, lxComprrObse
				lxComprrFecimpo =  .Fechaimpo			lxComprrFecexpo =  .Fechaexpo			lxComprrFmodifw =  .Fechamodificacionfw			lxComprrFaltafw =  .Fechaaltafw			lxComprrFectrans =  .Fechatransferencia			lxComprrTimestamp = goLibrerias.ObtenerTimestamp()			lxComprrAnulado =  .Anulado			lxComprrDescfw =  .Descripcionfw			lxComprrZadsfw =  .Zadsfw			lxComprrSmodifw =  .Seriemodificacionfw			lxComprrHmodifw =  .Horamodificacionfw			lxComprrUmodifw =  .Usuariomodificacionfw			lxComprrValtafw =  .Versionaltafw			lxComprrUaltafw =  .Usuarioaltafw			lxComprrHoraimpo =  .Horaimpo			lxComprrSaltafw =  .Seriealtafw			lxComprrVmodifw =  .Versionmodificacionfw			lxComprrEsttrans =  .Estadotransferencia			lxComprrHoraexpo =  .Horaexpo			lxComprrHaltafw =  .Horaaltafw			lxComprrBdaltafw =  .Basededatosaltafw			lxComprrBdmodifw =  .Basededatosmodificacionfw			lxComprrCodigo =  .Codigo			lxComprrCliente =  upper( .Cliente_PK ) 			lxComprrCliedesc =  .Clientedetalle			lxComprrCuit =  .Cuit			lxComprrTipoimp =  .Tipoimpuesto			lxComprrRegimen =  upper( .Regimen_PK ) 			lxComprrRegidesc =  .Regimendetalle			lxComprrNumint =  .Numerointerno			lxComprrFechcert =  .Fechacertificado			lxComprrNumecert =  .Numerocertificado			lxComprrRecibo =  .Recibo			lxComprrFechreci =  .Fecharecibo			lxComprrRtotal =  .Total			lxComprrObse =  .Observaciones
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxComprrCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPRR ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Timestamp","Anulado","Descfw","Zadsfw","Smodifw","Hmodifw","Umodifw","Valtafw","Ualtafw","Horaimpo","Saltafw","Vmodifw","Esttrans","Horaexpo","Haltafw","Bdaltafw","Bdmodifw","Codigo","Cliente","Cliedesc","Cuit","Tipoimp","Regimen","Regidesc","Numint","Fechcert","Numecert","Recibo","Fechreci","Rtotal","Obse" ) values ( <<"'" + this.ConvertirDateSql( lxComprrFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFectrans ) + "'" >>, <<lxComprrTimestamp >>, <<iif( lxComprrAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprrDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCliedesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrTipoimp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrRegimen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrRegidesc ) + "'" >>, <<lxComprrNumint >>, <<"'" + this.ConvertirDateSql( lxComprrFechcert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrNumecert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrRecibo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFechreci ) + "'" >>, <<lxComprrRtotal >>, <<"'" + this.FormatearTextoSql( lxComprrObse ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesDetalle
				if this.oEntidad.RetencionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxJurisdiccion = loItem.Jurisdiccion
					lxResolucion = loItem.Resolucion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompRRDet("NROITEM","Codigo","Impuesto","jurisdicci","resolucion","monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxComprrTimestamp
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
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxComprrFecimpo, lxComprrFecexpo, lxComprrFmodifw, lxComprrFaltafw, lxComprrFectrans, lxComprrTimestamp, lxComprrAnulado, lxComprrDescfw, lxComprrZadsfw, lxComprrSmodifw, lxComprrHmodifw, lxComprrUmodifw, lxComprrValtafw, lxComprrUaltafw, lxComprrHoraimpo, lxComprrSaltafw, lxComprrVmodifw, lxComprrEsttrans, lxComprrHoraexpo, lxComprrHaltafw, lxComprrBdaltafw, lxComprrBdmodifw, lxComprrCodigo, lxComprrCliente, lxComprrCliedesc, lxComprrCuit, lxComprrTipoimp, lxComprrRegimen, lxComprrRegidesc, lxComprrNumint, lxComprrFechcert, lxComprrNumecert, lxComprrRecibo, lxComprrFechreci, lxComprrRtotal, lxComprrObse
				lxComprrFecimpo =  .Fechaimpo			lxComprrFecexpo =  .Fechaexpo			lxComprrFmodifw =  .Fechamodificacionfw			lxComprrFaltafw =  .Fechaaltafw			lxComprrFectrans =  .Fechatransferencia			lxComprrTimestamp = goLibrerias.ObtenerTimestamp()			lxComprrAnulado =  .Anulado			lxComprrDescfw =  .Descripcionfw			lxComprrZadsfw =  .Zadsfw			lxComprrSmodifw =  .Seriemodificacionfw			lxComprrHmodifw =  .Horamodificacionfw			lxComprrUmodifw =  .Usuariomodificacionfw			lxComprrValtafw =  .Versionaltafw			lxComprrUaltafw =  .Usuarioaltafw			lxComprrHoraimpo =  .Horaimpo			lxComprrSaltafw =  .Seriealtafw			lxComprrVmodifw =  .Versionmodificacionfw			lxComprrEsttrans =  .Estadotransferencia			lxComprrHoraexpo =  .Horaexpo			lxComprrHaltafw =  .Horaaltafw			lxComprrBdaltafw =  .Basededatosaltafw			lxComprrBdmodifw =  .Basededatosmodificacionfw			lxComprrCodigo =  .Codigo			lxComprrCliente =  upper( .Cliente_PK ) 			lxComprrCliedesc =  .Clientedetalle			lxComprrCuit =  .Cuit			lxComprrTipoimp =  .Tipoimpuesto			lxComprrRegimen =  upper( .Regimen_PK ) 			lxComprrRegidesc =  .Regimendetalle			lxComprrNumint =  .Numerointerno			lxComprrFechcert =  .Fechacertificado			lxComprrNumecert =  .Numerocertificado			lxComprrRecibo =  .Recibo			lxComprrFechreci =  .Fecharecibo			lxComprrRtotal =  .Total			lxComprrObse =  .Observaciones
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
				update ZooLogic.COMPRR set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprrFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprrFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprrFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComprrFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComprrFectrans ) + "'">>,"Timestamp" = <<lxComprrTimestamp>>,"Anulado" = <<iif( lxComprrAnulado, 1, 0 )>>,"Descfw" = <<"'" + this.FormatearTextoSql( lxComprrDescfw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprrZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComprrSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprrHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComprrUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComprrValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprrUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprrHoraimpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComprrSaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprrVmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComprrEsttrans ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprrHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComprrHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprrBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprrBdmodifw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxComprrCliente ) + "'">>,"Cliedesc" = <<"'" + this.FormatearTextoSql( lxComprrCliedesc ) + "'">>,"Cuit" = <<"'" + this.FormatearTextoSql( lxComprrCuit ) + "'">>,"Tipoimp" = <<"'" + this.FormatearTextoSql( lxComprrTipoimp ) + "'">>,"Regimen" = <<"'" + this.FormatearTextoSql( lxComprrRegimen ) + "'">>,"Regidesc" = <<"'" + this.FormatearTextoSql( lxComprrRegidesc ) + "'">>,"Numint" = <<lxComprrNumint>>,"Fechcert" = <<"'" + this.ConvertirDateSql( lxComprrFechcert ) + "'">>,"Numecert" = <<"'" + this.FormatearTextoSql( lxComprrNumecert ) + "'">>,"Recibo" = <<"'" + this.FormatearTextoSql( lxComprrRecibo ) + "'">>,"Fechreci" = <<"'" + this.ConvertirDateSql( lxComprrFechreci ) + "'">>,"Rtotal" = <<lxComprrRtotal>>,"Obse" = <<"'" + this.FormatearTextoSql( lxComprrObse ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'">> and  COMPRR.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompRRDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesDetalle
				if this.oEntidad.RetencionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxJurisdiccion = loItem.Jurisdiccion
					lxResolucion = loItem.Resolucion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompRRDet("NROITEM","Codigo","Impuesto","jurisdicci","resolucion","monto" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxComprrTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.COMPRR where " + this.ConvertirFuncionesSql( " COMPRR.CODIGO != ''" ) )
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
			Local lxComprrCodigo
			lxComprrCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones" from ZooLogic.COMPRR where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'">> and  COMPRR.CODIGO != ''
			endtext
			use in select('c_COMPROBANTEDERETENCIONRECIBIDO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONRECIBIDO', set( 'Datasession' ) )

			if reccount( 'c_COMPROBANTEDERETENCIONRECIBIDO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto" from ZooLogic.CompRRDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCompRRnumint As Variant
			lxCompRRnumint = .NumeroInterno
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones" from ZooLogic.COMPRR where  COMPRR.CODIGO != '' And numint = <<lxCompRRnumint>>
			endtext
			use in select('c_COMPROBANTEDERETENCIONRECIBIDO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONRECIBIDO', set( 'Datasession' ) )
			if reccount( 'c_COMPROBANTEDERETENCIONRECIBIDO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto" from ZooLogic.CompRRDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxComprrCodigo as Variant
		llRetorno = .t.
		lxComprrCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPRR where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'">> and  COMPRR.CODIGO != ''
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
				lcOrden =  str( .NumeroInterno, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones" from ZooLogic.COMPRR where  COMPRR.CODIGO != '' order by numint,codigo
			endtext
			use in select('c_COMPROBANTEDERETENCIONRECIBIDO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONRECIBIDO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto" from ZooLogic.CompRRDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesDetalle
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
				lcOrden =  str( .NumeroInterno, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones" from ZooLogic.COMPRR where  str( numint, 8, 0) + funciones.padr( codigo, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPRR.CODIGO != '' order by numint,codigo
			endtext
			use in select('c_COMPROBANTEDERETENCIONRECIBIDO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONRECIBIDO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto" from ZooLogic.CompRRDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesDetalle
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
				lcOrden =  str( .NumeroInterno, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones" from ZooLogic.COMPRR where  str( numint, 8, 0) + funciones.padr( codigo, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPRR.CODIGO != '' order by numint desc,codigo desc
			endtext
			use in select('c_COMPROBANTEDERETENCIONRECIBIDO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONRECIBIDO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto" from ZooLogic.CompRRDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesDetalle
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
				lcOrden =  str( .NumeroInterno, 8, 0) + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones" from ZooLogic.COMPRR where  COMPRR.CODIGO != '' order by numint desc,codigo desc
			endtext
			use in select('c_COMPROBANTEDERETENCIONRECIBIDO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONRECIBIDO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto" from ZooLogic.CompRRDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_RetencionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_RetencionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_RetencionesDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Timestamp,Anulado,Descfw,Zadsfw,Smodifw,Hmodifw,Umo" + ;
"difw,Valtafw,Ualtafw,Horaimpo,Saltafw,Vmodifw,Esttrans,Horaexpo,Haltafw,Bdaltafw,Bdmodifw,Codigo,Cli" + ;
"ente,Cliedesc,Cuit,Tipoimp,Regimen,Regidesc,Numint,Fechcert,Numecert,Recibo,Fechreci,Rtotal,Obse" + ;
" from ZooLogic.COMPRR where  COMPRR.CODIGO != '' and " + lcFiltro )
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
			local  lxComprrFecimpo, lxComprrFecexpo, lxComprrFmodifw, lxComprrFaltafw, lxComprrFectrans, lxComprrTimestamp, lxComprrAnulado, lxComprrDescfw, lxComprrZadsfw, lxComprrSmodifw, lxComprrHmodifw, lxComprrUmodifw, lxComprrValtafw, lxComprrUaltafw, lxComprrHoraimpo, lxComprrSaltafw, lxComprrVmodifw, lxComprrEsttrans, lxComprrHoraexpo, lxComprrHaltafw, lxComprrBdaltafw, lxComprrBdmodifw, lxComprrCodigo, lxComprrCliente, lxComprrCliedesc, lxComprrCuit, lxComprrTipoimp, lxComprrRegimen, lxComprrRegidesc, lxComprrNumint, lxComprrFechcert, lxComprrNumecert, lxComprrRecibo, lxComprrFechreci, lxComprrRtotal, lxComprrObse
				lxComprrFecimpo = ctod( '  /  /    ' )			lxComprrFecexpo = ctod( '  /  /    ' )			lxComprrFmodifw = ctod( '  /  /    ' )			lxComprrFaltafw = ctod( '  /  /    ' )			lxComprrFectrans = ctod( '  /  /    ' )			lxComprrTimestamp = goLibrerias.ObtenerTimestamp()			lxComprrAnulado = .F.			lxComprrDescfw = []			lxComprrZadsfw = []			lxComprrSmodifw = []			lxComprrHmodifw = []			lxComprrUmodifw = []			lxComprrValtafw = []			lxComprrUaltafw = []			lxComprrHoraimpo = []			lxComprrSaltafw = []			lxComprrVmodifw = []			lxComprrEsttrans = []			lxComprrHoraexpo = []			lxComprrHaltafw = []			lxComprrBdaltafw = []			lxComprrBdmodifw = []			lxComprrCodigo = []			lxComprrCliente = []			lxComprrCliedesc = []			lxComprrCuit = []			lxComprrTipoimp = []			lxComprrRegimen = []			lxComprrRegidesc = []			lxComprrNumint = 0			lxComprrFechcert = ctod( '  /  /    ' )			lxComprrNumecert = []			lxComprrRecibo = []			lxComprrFechreci = ctod( '  /  /    ' )			lxComprrRtotal = 0			lxComprrObse = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompRRDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPRR where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPRR' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where codigo = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(codigo, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPRR.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPRR', '', tnTope )
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
	Function ObtenerDatosDetalleRetencionesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPRRDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Impuesto" as "Impuesto", "Jurisdicci" as "Jurisdiccion", "Resolucion" as "Resolucion", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleRetencionesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompRRDet', 'RetencionesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleRetencionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleRetencionesDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIEDESC AS CLIENTEDETALLE'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUIT AS CUIT'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOIMP AS TIPOIMPUESTO'
				Case lcAtributo == 'REGIMEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMEN AS REGIMEN'
				Case lcAtributo == 'REGIMENDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIDESC AS REGIMENDETALLE'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS NUMEROINTERNO'
				Case lcAtributo == 'FECHACERTIFICADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHCERT AS FECHACERTIFICADO'
				Case lcAtributo == 'NUMEROCERTIFICADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMECERT AS NUMEROCERTIFICADO'
				Case lcAtributo == 'RECIBO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECIBO AS RECIBO'
				Case lcAtributo == 'FECHARECIBO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHRECI AS FECHARECIBO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RTOTAL AS TOTAL'
				Case lcAtributo == 'OBSERVACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBSE AS OBSERVACIONES'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleRetencionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'IMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPUESTO AS IMPUESTO'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDICCI AS JURISDICCION'
				Case lcAtributo == 'RESOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESOLUCION AS RESOLUCION'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDETALLE'
				lcCampo = 'CLIEDESC'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CUIT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMEN'
				lcCampo = 'REGIMEN'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMENDETALLE'
				lcCampo = 'REGIDESC'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACERTIFICADO'
				lcCampo = 'FECHCERT'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCERTIFICADO'
				lcCampo = 'NUMECERT'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBO'
				lcCampo = 'RECIBO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHARECIBO'
				lcCampo = 'FECHRECI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'RTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACIONES'
				lcCampo = 'OBSE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleRetencionesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTO'
				lcCampo = 'IMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURISDICCI'
			Case upper( alltrim( tcAtributo ) ) == 'RESOLUCION'
				lcCampo = 'RESOLUCION'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'RETENCIONESDETALLE'
			lcRetorno = 'COMPRRDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComprrFecimpo, lxComprrFecexpo, lxComprrFmodifw, lxComprrFaltafw, lxComprrFectrans, lxComprrTimestamp, lxComprrAnulado, lxComprrDescfw, lxComprrZadsfw, lxComprrSmodifw, lxComprrHmodifw, lxComprrUmodifw, lxComprrValtafw, lxComprrUaltafw, lxComprrHoraimpo, lxComprrSaltafw, lxComprrVmodifw, lxComprrEsttrans, lxComprrHoraexpo, lxComprrHaltafw, lxComprrBdaltafw, lxComprrBdmodifw, lxComprrCodigo, lxComprrCliente, lxComprrCliedesc, lxComprrCuit, lxComprrTipoimp, lxComprrRegimen, lxComprrRegidesc, lxComprrNumint, lxComprrFechcert, lxComprrNumecert, lxComprrRecibo, lxComprrFechreci, lxComprrRtotal, lxComprrObse
				lxComprrFecimpo =  .Fechaimpo			lxComprrFecexpo =  .Fechaexpo			lxComprrFmodifw =  .Fechamodificacionfw			lxComprrFaltafw =  .Fechaaltafw			lxComprrFectrans =  .Fechatransferencia			lxComprrTimestamp = goLibrerias.ObtenerTimestamp()			lxComprrAnulado =  .Anulado			lxComprrDescfw =  .Descripcionfw			lxComprrZadsfw =  .Zadsfw			lxComprrSmodifw =  .Seriemodificacionfw			lxComprrHmodifw =  .Horamodificacionfw			lxComprrUmodifw =  .Usuariomodificacionfw			lxComprrValtafw =  .Versionaltafw			lxComprrUaltafw =  .Usuarioaltafw			lxComprrHoraimpo =  .Horaimpo			lxComprrSaltafw =  .Seriealtafw			lxComprrVmodifw =  .Versionmodificacionfw			lxComprrEsttrans =  .Estadotransferencia			lxComprrHoraexpo =  .Horaexpo			lxComprrHaltafw =  .Horaaltafw			lxComprrBdaltafw =  .Basededatosaltafw			lxComprrBdmodifw =  .Basededatosmodificacionfw			lxComprrCodigo =  .Codigo			lxComprrCliente =  upper( .Cliente_PK ) 			lxComprrCliedesc =  .Clientedetalle			lxComprrCuit =  .Cuit			lxComprrTipoimp =  .Tipoimpuesto			lxComprrRegimen =  upper( .Regimen_PK ) 			lxComprrRegidesc =  .Regimendetalle			lxComprrNumint =  .Numerointerno			lxComprrFechcert =  .Fechacertificado			lxComprrNumecert =  .Numerocertificado			lxComprrRecibo =  .Recibo			lxComprrFechreci =  .Fecharecibo			lxComprrRtotal =  .Total			lxComprrObse =  .Observaciones
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPRR ( "Fecimpo","Fecexpo","Fmodifw","Faltafw","Fectrans","Timestamp","Anulado","Descfw","Zadsfw","Smodifw","Hmodifw","Umodifw","Valtafw","Ualtafw","Horaimpo","Saltafw","Vmodifw","Esttrans","Horaexpo","Haltafw","Bdaltafw","Bdmodifw","Codigo","Cliente","Cliedesc","Cuit","Tipoimp","Regimen","Regidesc","Numint","Fechcert","Numecert","Recibo","Fechreci","Rtotal","Obse" ) values ( <<"'" + this.ConvertirDateSql( lxComprrFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFectrans ) + "'" >>, <<lxComprrTimestamp >>, <<iif( lxComprrAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprrDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCliedesc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrCuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrTipoimp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrRegimen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrRegidesc ) + "'" >>, <<lxComprrNumint >>, <<"'" + this.ConvertirDateSql( lxComprrFechcert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrNumecert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprrRecibo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprrFechreci ) + "'" >>, <<lxComprrRtotal >>, <<"'" + this.FormatearTextoSql( lxComprrObse ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPRR' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesDetalle
				if this.oEntidad.RetencionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxJurisdiccion = loItem.Jurisdiccion
					lxResolucion = loItem.Resolucion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompRRDet("NROITEM","Codigo","Impuesto","jurisdicci","resolucion","monto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMonto>> ) 
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
			if .lAnular
				.oAtributosAnulacion = .CrearObjeto( 'zooColeccion' )
				.ObtenerAtributosAnulacion()
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxComprrFecimpo, lxComprrFecexpo, lxComprrFmodifw, lxComprrFaltafw, lxComprrFectrans, lxComprrTimestamp, lxComprrAnulado, lxComprrDescfw, lxComprrZadsfw, lxComprrSmodifw, lxComprrHmodifw, lxComprrUmodifw, lxComprrValtafw, lxComprrUaltafw, lxComprrHoraimpo, lxComprrSaltafw, lxComprrVmodifw, lxComprrEsttrans, lxComprrHoraexpo, lxComprrHaltafw, lxComprrBdaltafw, lxComprrBdmodifw, lxComprrCodigo, lxComprrCliente, lxComprrCliedesc, lxComprrCuit, lxComprrTipoimp, lxComprrRegimen, lxComprrRegidesc, lxComprrNumint, lxComprrFechcert, lxComprrNumecert, lxComprrRecibo, lxComprrFechreci, lxComprrRtotal, lxComprrObse
				lxComprrFecimpo =  .Fechaimpo			lxComprrFecexpo =  .Fechaexpo			lxComprrFmodifw =  .Fechamodificacionfw			lxComprrFaltafw =  .Fechaaltafw			lxComprrFectrans =  .Fechatransferencia			lxComprrTimestamp = goLibrerias.ObtenerTimestamp()			lxComprrAnulado =  .Anulado			lxComprrDescfw =  .Descripcionfw			lxComprrZadsfw =  .Zadsfw			lxComprrSmodifw =  .Seriemodificacionfw			lxComprrHmodifw =  .Horamodificacionfw			lxComprrUmodifw =  .Usuariomodificacionfw			lxComprrValtafw =  .Versionaltafw			lxComprrUaltafw =  .Usuarioaltafw			lxComprrHoraimpo =  .Horaimpo			lxComprrSaltafw =  .Seriealtafw			lxComprrVmodifw =  .Versionmodificacionfw			lxComprrEsttrans =  .Estadotransferencia			lxComprrHoraexpo =  .Horaexpo			lxComprrHaltafw =  .Horaaltafw			lxComprrBdaltafw =  .Basededatosaltafw			lxComprrBdmodifw =  .Basededatosmodificacionfw			lxComprrCodigo =  .Codigo			lxComprrCliente =  upper( .Cliente_PK ) 			lxComprrCliedesc =  .Clientedetalle			lxComprrCuit =  .Cuit			lxComprrTipoimp =  .Tipoimpuesto			lxComprrRegimen =  upper( .Regimen_PK ) 			lxComprrRegidesc =  .Regimendetalle			lxComprrNumint =  .Numerointerno			lxComprrFechcert =  .Fechacertificado			lxComprrNumecert =  .Numerocertificado			lxComprrRecibo =  .Recibo			lxComprrFechreci =  .Fecharecibo			lxComprrRtotal =  .Total			lxComprrObse =  .Observaciones
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPRR.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPRR set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprrFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprrFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprrFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComprrFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComprrFectrans ) + "'">>, "Timestamp" = <<lxComprrTimestamp>>, "Anulado" = <<iif( lxComprrAnulado, 1, 0 )>>, "Descfw" = <<"'" + this.FormatearTextoSql( lxComprrDescfw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprrZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComprrSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprrHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComprrUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComprrValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprrUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprrHoraimpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComprrSaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprrVmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComprrEsttrans ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprrHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComprrHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprrBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprrBdmodifw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComprrCodigo ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxComprrCliente ) + "'">>, "Cliedesc" = <<"'" + this.FormatearTextoSql( lxComprrCliedesc ) + "'">>, "Cuit" = <<"'" + this.FormatearTextoSql( lxComprrCuit ) + "'">>, "Tipoimp" = <<"'" + this.FormatearTextoSql( lxComprrTipoimp ) + "'">>, "Regimen" = <<"'" + this.FormatearTextoSql( lxComprrRegimen ) + "'">>, "Regidesc" = <<"'" + this.FormatearTextoSql( lxComprrRegidesc ) + "'">>, "Numint" = <<lxComprrNumint>>, "Fechcert" = <<"'" + this.ConvertirDateSql( lxComprrFechcert ) + "'">>, "Numecert" = <<"'" + this.FormatearTextoSql( lxComprrNumecert ) + "'">>, "Recibo" = <<"'" + this.FormatearTextoSql( lxComprrRecibo ) + "'">>, "Fechreci" = <<"'" + this.ConvertirDateSql( lxComprrFechreci ) + "'">>, "Rtotal" = <<lxComprrRtotal>>, "Obse" = <<"'" + this.FormatearTextoSql( lxComprrObse ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPRR' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompRRDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.RetencionesDetalle
				if this.oEntidad.RetencionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxImpuesto_PK = loItem.Impuesto_PK
					lxJurisdiccion = loItem.Jurisdiccion
					lxResolucion = loItem.Resolucion
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompRRDet("NROITEM","Codigo","Impuesto","jurisdicci","resolucion","monto" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxImpuesto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPRR.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.COMPRR where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompRRDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'COMPRR' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPRR where  COMPRR.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPRR where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPRR.CODIGO != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCompRRnumint as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONRECIBIDO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPRR Where  numint = ] + transform( &lcCursor..numint     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..codigo
				if lxValorClavePK == curSeek.codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPRR set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..cliente ) + "'"+ [, cliedesc = ] + "'" + this.FormatearTextoSql( &lcCursor..cliedesc ) + "'"+ [, cuit = ] + "'" + this.FormatearTextoSql( &lcCursor..cuit ) + "'"+ [, TipoImp = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoImp ) + "'"+ [, regimen = ] + "'" + this.FormatearTextoSql( &lcCursor..regimen ) + "'"+ [, regidesc = ] + "'" + this.FormatearTextoSql( &lcCursor..regidesc ) + "'"+ [, numint = ] + transform( &lcCursor..numint )+ [, fechcert = ] + "'" + this.ConvertirDateSql( &lcCursor..fechcert ) + "'"+ [, numecert = ] + "'" + this.FormatearTextoSql( &lcCursor..numecert ) + "'"+ [, recibo = ] + "'" + this.FormatearTextoSql( &lcCursor..recibo ) + "'"+ [, fechreci = ] + "'" + this.ConvertirDateSql( &lcCursor..fechreci ) + "'"+ [, RTotal = ] + transform( &lcCursor..RTotal )+ [, obse = ] + "'" + this.FormatearTextoSql( &lcCursor..obse ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
							else
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
							endif
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPRR Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FECEXPO, FMODIFW, FALTAFW, FECTRANS, TIMESTAMP, Anulado, DescFW, ZADSFW, SMODIFW, HMODIFW, UMODIFW, VALTAFW, UALTAFW, HORAIMPO, SALTAFW, VMODIFW, ESTTRANS, HORAEXPO, HALTAFW, BDALTAFW, BDMODIFW, codigo, cliente, cliedesc, cuit, TipoImp, regimen, regidesc, numint, fechcert, numecert, recibo, fechreci, RTotal, obse
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cliedesc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cuit ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoImp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..regimen ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..regidesc ) + "'" + ',' + transform( &lcCursor..numint ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechcert ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..numecert ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..recibo ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..fechreci ) + "'" + ',' + transform( &lcCursor..RTotal )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..obse ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPRR ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONRECIBIDO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'codigo','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','codigo')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompRRDet Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMRETENCIONRECIBIDA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Impuesto","jurisdicci","resolucion","monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompRRDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Impuesto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.jurisdicci ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.resolucion ) + "'" + ',' + transform( cDetallesExistentes.monto      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..numint     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDERETENCIONRECIBIDO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDERETENCIONRECIBIDO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDERETENCIONRECIBIDO_OBSE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMRETENCIONRECIBIDA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CompRR')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMPROBANTEDERETENCIONRECIBIDO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..numint )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMPROBANTEDERETENCIONRECIBIDO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONRECIBIDO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( numint, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( numint, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONRECIBIDO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  fechcert  
		* Validar ANTERIORES A 1/1/1753  fechreci  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CompRR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CompRR
Create Table ZooLogic.TablaTrabajo_CompRR ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"descfw" char( 200 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"vmodifw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"cliente" char( 5 )  null, 
"cliedesc" char( 30 )  null, 
"cuit" char( 15 )  null, 
"tipoimp" char( 10 )  null, 
"regimen" char( 5 )  null, 
"regidesc" char( 100 )  null, 
"numint" numeric( 8, 0 )  null, 
"fechcert" datetime  null, 
"numecert" char( 20 )  null, 
"recibo" char( 20 )  null, 
"fechreci" datetime  null, 
"rtotal" numeric( 15, 2 )  null, 
"obse" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CompRR' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CompRR' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONRECIBIDO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('cliedesc','cliedesc')
			.AgregarMapeo('cuit','cuit')
			.AgregarMapeo('tipoimp','tipoimp')
			.AgregarMapeo('regimen','regimen')
			.AgregarMapeo('regidesc','regidesc')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('fechcert','fechcert')
			.AgregarMapeo('numecert','numecert')
			.AgregarMapeo('recibo','recibo')
			.AgregarMapeo('fechreci','fechreci')
			.AgregarMapeo('rtotal','rtotal')
			.AgregarMapeo('obse','obse')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CompRR'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.CLIEDESC = isnull( d.CLIEDESC, t.CLIEDESC ),t.CUIT = isnull( d.CUIT, t.CUIT ),t.TIPOIMP = isnull( d.TIPOIMP, t.TIPOIMP ),t.REGIMEN = isnull( d.REGIMEN, t.REGIMEN ),t.REGIDESC = isnull( d.REGIDESC, t.REGIDESC ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.FECHCERT = isnull( d.FECHCERT, t.FECHCERT ),t.NUMECERT = isnull( d.NUMECERT, t.NUMECERT ),t.RECIBO = isnull( d.RECIBO, t.RECIBO ),t.FECHRECI = isnull( d.FECHRECI, t.FECHRECI ),t.RTOTAL = isnull( d.RTOTAL, t.RTOTAL ),t.OBSE = isnull( d.OBSE, t.OBSE )
					from ZooLogic.COMPRR t inner join deleted d 
							 on t.codigo = d.codigo
							 and  t.numint = d.numint
				-- Fin Updates
				insert into ZooLogic.COMPRR(Fecimpo,Fecexpo,Fmodifw,Faltafw,Fectrans,Timestamp,Anulado,Descfw,Zadsfw,Smodifw,Hmodifw,Umodifw,Valtafw,Ualtafw,Horaimpo,Saltafw,Vmodifw,Esttrans,Horaexpo,Haltafw,Bdaltafw,Bdmodifw,Codigo,Cliente,Cliedesc,Cuit,Tipoimp,Regimen,Regidesc,Numint,Fechcert,Numecert,Recibo,Fechreci,Rtotal,Obse)
					Select isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.DESCFW,''),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.SALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CODIGO,''),isnull( d.CLIENTE,''),isnull( d.CLIEDESC,''),isnull( d.CUIT,''),isnull( d.TIPOIMP,''),isnull( d.REGIMEN,''),isnull( d.REGIDESC,''),isnull( d.NUMINT,0),isnull( d.FECHCERT,''),isnull( d.NUMECERT,''),isnull( d.RECIBO,''),isnull( d.FECHRECI,''),isnull( d.RTOTAL,0),isnull( d.OBSE,'')
						From deleted d left join ZooLogic.COMPRR pk 
							 on d.codigo = pk.codigo
						 left join ZooLogic.COMPRR cc 
							 on  d.numint = cc.numint
						Where pk.codigo Is Null 
							 and cc.numint Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CÓDIGO ' + cast( d.numint as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.COMPRR t inner join deleted d 
							on   t.numint = d.numint
						left join deleted h 
							 on t.codigo = h.codigo
							 where h.codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CÓDIGO ' + cast( d.numint as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.COMPRR t inner join deleted d 
							 on t.codigo = d.codigo
						left join deleted h 
							on   t.numint = h.numint
							where   h.numint is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompRRDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPRR_CompRRDet
ON ZooLogic.TablaTrabajo_COMPRR_CompRRDet
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IMPUESTO = isnull( d.IMPUESTO, t.IMPUESTO ),
t.JURISDICCI = isnull( d.JURISDICCI, t.JURISDICCI ),
t.RESOLUCION = isnull( d.RESOLUCION, t.RESOLUCION ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.CompRRDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CompRRDet
( 
"NROITEM",
"CODIGO",
"IMPUESTO",
"JURISDICCI",
"RESOLUCION",
"MONTO"
 )
Select 
d.NROITEM,
d.CODIGO,
d.IMPUESTO,
d.JURISDICCI,
d.RESOLUCION,
d.MONTO
From deleted d left join ZooLogic.CompRRDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CompRR') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CompRR
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMPROBANTEDERETENCIONRECIBIDO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Timestamp, 0 )
					.Anulado = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Anulado, .F. )
					.Descripcionfw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Descripcionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Horaimpo, [] )
					.Seriealtafw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Seriealtafw, [] )
					.Versionmodificacionfw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Versionmodificacionfw, [] )
					.Estadotransferencia = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Estadotransferencia, [] )
					.Horaexpo = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Horaexpo, [] )
					.Horaaltafw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Basededatosmodificacionfw, [] )
					.Codigo = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Codigo, [] )
					.Cliente_PK =  nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Cliente, [] )
					.Clientedetalle = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Clientedetalle, [] )
					.Cuit = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Cuit, [] )
					.Tipoimpuesto = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Tipoimpuesto, [] )
					.Regimen_PK =  nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Regimen, [] )
					.Regimendetalle = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Regimendetalle, [] )
					.Numerointerno = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Numerointerno, 0 )
					.Fechacertificado = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fechacertificado, ctod( '  /  /    ' ) ) )
					.Numerocertificado = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Numerocertificado, [] )
					.Recibo = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Recibo, [] )
					.Fecharecibo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Fecharecibo, ctod( '  /  /    ' ) ) )
					.Retencionesdetalle.Limpiar()
					.Retencionesdetalle.SetearEsNavegacion( .lProcesando )
					.Retencionesdetalle.Cargar()
					.Total = nvl( c_COMPROBANTEDERETENCIONRECIBIDO.Total, 0 )
					lcValor = This.ObtenerMemo( 'c_Observaciones')
					.Observaciones = lcValor 
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
			lxRetorno = c_COMPROBANTEDERETENCIONRECIBIDO.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.RetencionesDetalle
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
		return c_COMPROBANTEDERETENCIONRECIBIDO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPRR' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,codigo as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    codigo from (
							select * 
								from ZooLogic.COMPRR 
								Where   COMPRR.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPRR", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "codigo"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Descfw" as "Descripcionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Saltafw" as "Seriealtafw", "Vmodifw" as "Versionmodificacionfw", "Esttrans" as "Estadotransferencia", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Codigo" as "Codigo", "Cliente" as "Cliente", "Cliedesc" as "Clientedetalle", "Cuit" as "Cuit", "Tipoimp" as "Tipoimpuesto", "Regimen" as "Regimen", "Regidesc" as "Regimendetalle", "Numint" as "Numerointerno", "Fechcert" as "Fechacertificado", "Numecert" as "Numerocertificado", "Recibo" as "Recibo", "Fechreci" as "Fecharecibo", "Rtotal" as "Total", "Obse" as "Observaciones"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPRR 
								Where   COMPRR.CODIGO != ''
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
	Tabla = 'COMPRR'
	Filtro = " COMPRR.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPRR.CODIGO != ''"
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
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHAIMPO                               " tabla="COMPRR         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHAEXPO                               " tabla="COMPRR         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHAMODIFICACIONFW                     " tabla="COMPRR         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHAALTAFW                             " tabla="COMPRR         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHATRANSFERENCIA                      " tabla="COMPRR         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="TIMESTAMP                               " tabla="COMPRR         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="ANULADO                                 " tabla="COMPRR         " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="DESCRIPCIONFW                           " tabla="COMPRR         " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="ZADSFW                                  " tabla="COMPRR         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="SERIEMODIFICACIONFW                     " tabla="COMPRR         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="HORAMODIFICACIONFW                      " tabla="COMPRR         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPRR         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="VERSIONALTAFW                           " tabla="COMPRR         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="USUARIOALTAFW                           " tabla="COMPRR         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="HORAIMPO                                " tabla="COMPRR         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="SERIEALTAFW                             " tabla="COMPRR         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPRR         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPRR         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="HORAEXPO                                " tabla="COMPRR         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="HORAALTAFW                              " tabla="COMPRR         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="BASEDEDATOSALTAFW                       " tabla="COMPRR         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPRR         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="CODIGO                                  " tabla="COMPRR         " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="CLIENTE                                 " tabla="COMPRR         " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="CLIENTEDETALLE                          " tabla="COMPRR         " campo="CLIEDESC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Descripcion del Cliente                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="CLIENTE.NOMBRE                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="CUIT                                    " tabla="COMPRR         " campo="CUIT      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="CUIT                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="TIPOIMPUESTO                            " tabla="COMPRR         " campo="TIPOIMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="IVA                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="14" etiqueta="Tipo de impuesto                                                                                                                                                " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="REGIMEN                                 " tabla="COMPRR         " campo="REGIMEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REGIMENIMPOSITIVO                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Regímen                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="REGIMENDETALLE                          " tabla="COMPRR         " campo="REGIDESC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="REGIMEN.DESCRIPCION                                                                                                                                                                                                                                           " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="NUMEROINTERNO                           " tabla="COMPRR         " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHACERTIFICADO                        " tabla="COMPRR         " campo="FECHCERT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Fecha de certificado                                                                                                                                            " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="NUMEROCERTIFICADO                       " tabla="COMPRR         " campo="NUMECERT  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número de certificado                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="RECIBO                                  " tabla="COMPRR         " campo="RECIBO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Recibo                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="FECHARECIBO                             " tabla="COMPRR         " campo="FECHRECI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Fecha de recibo                                                                                                                                                 " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="RETENCIONESDETALLE                      " tabla="COMPRRDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMRETENCIONRECIBIDA  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="12" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="TOTAL                                   " tabla="COMPRR         " campo="RTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONRECIBIDO          " atributo="OBSERVACIONES                           " tabla="COMPRR         " campo="OBSE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPRR.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGIMENIMPOSITIVO                       " atributo="DESCRIPCION                             " tabla="REGIMP         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Reg.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REGIMP On COMPRR.REGIMEN = REGIMP.Codigo And  REGIMP.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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