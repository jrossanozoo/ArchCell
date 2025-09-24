
define class Din_EntidadDESCARGADECHEQUESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DESCARGADECHEQUES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0)]
	cExpresionCCPorCampos = [#tabla#.Letra + str( #tabla#.PtoVen, 4, 0) + str( #tabla#.NumComp, 8, 0)]
	cTagClaveCandidata = '_DCTCC'
	cTagClavePk = '_DCTPK'
	cTablaPrincipal = 'DESCARGACHEQUE'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
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
			local  lxDescargachequeFectrans, lxDescargachequeFmodifw, lxDescargachequeFecexpo, lxDescargachequeFecimpo, lxDescargachequeHoraexpo, lxDescargachequeVmodifw, lxDescargachequeValtafw, lxDescargachequeZadsfw, lxDescargachequeHmodifw, lxDescargachequeHoraimpo, lxDescargachequeUmodifw, lxDescargachequeSmodifw, lxDescargachequeUaltafw, lxDescargachequeSaltafw, lxDescargachequeEsttrans, lxDescargachequeHaltafw, lxDescargachequeFaltafw, lxDescargachequeBdaltafw, lxDescargachequeBdmodifw, lxDescargachequeTimestamp, lxDescargachequeAnulado, lxDescargachequeCodigo, lxDescargachequeDestino, lxDescargachequeConcepto, lxDescargachequeFfch, lxDescargachequeLetra, lxDescargachequePtoven, lxDescargachequeNumcomp, lxDescargachequeComptipo, lxDescargachequeCobs
				lxDescargachequeFectrans =  .Fechatransferencia			lxDescargachequeFmodifw =  .Fechamodificacionfw			lxDescargachequeFecexpo =  .Fechaexpo			lxDescargachequeFecimpo =  .Fechaimpo			lxDescargachequeHoraexpo =  .Horaexpo			lxDescargachequeVmodifw =  .Versionmodificacionfw			lxDescargachequeValtafw =  .Versionaltafw			lxDescargachequeZadsfw =  .Zadsfw			lxDescargachequeHmodifw =  .Horamodificacionfw			lxDescargachequeHoraimpo =  .Horaimpo			lxDescargachequeUmodifw =  .Usuariomodificacionfw			lxDescargachequeSmodifw =  .Seriemodificacionfw			lxDescargachequeUaltafw =  .Usuarioaltafw			lxDescargachequeSaltafw =  .Seriealtafw			lxDescargachequeEsttrans =  .Estadotransferencia			lxDescargachequeHaltafw =  .Horaaltafw			lxDescargachequeFaltafw =  .Fechaaltafw			lxDescargachequeBdaltafw =  .Basededatosaltafw			lxDescargachequeBdmodifw =  .Basededatosmodificacionfw			lxDescargachequeTimestamp = goLibrerias.ObtenerTimestamp()			lxDescargachequeAnulado =  .Anulado			lxDescargachequeCodigo =  .Codigo			lxDescargachequeDestino =  upper( .DestinoDescarga_PK ) 			lxDescargachequeConcepto =  upper( .Concepto_PK ) 			lxDescargachequeFfch =  .Fecha			lxDescargachequeLetra =  .Letra			lxDescargachequePtoven =  .Puntodeventa			lxDescargachequeNumcomp =  .Numero			lxDescargachequeComptipo =  .Tipocomprobante			lxDescargachequeCobs =  .Observ
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDescargachequeCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.DESCARGACHEQUE ( "Fectrans","Fmodifw","Fecexpo","Fecimpo","Horaexpo","Vmodifw","Valtafw","Zadsfw","Hmodifw","Horaimpo","Umodifw","Smodifw","Ualtafw","Saltafw","Esttrans","Haltafw","Faltafw","Bdaltafw","Bdmodifw","Timestamp","Anulado","Codigo","Destino","Concepto","Ffch","Letra","Ptoven","Numcomp","Comptipo","Cobs" ) values ( <<"'" + this.ConvertirDateSql( lxDescargachequeFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeBdmodifw ) + "'" >>, <<lxDescargachequeTimestamp >>, <<iif( lxDescargachequeAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeDestino ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeConcepto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeLetra ) + "'" >>, <<lxDescargachequePtoven >>, <<lxDescargachequeNumcomp >>, <<lxDescargachequeComptipo >>, <<"'" + this.FormatearTextoSql( lxDescargachequeCobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ChequesDetalle
				if this.oEntidad.ChequesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerointerno = loItem.Numerointerno
					lxIditemcomponente = loItem.Iditemcomponente
					lxEntidadfinanciera_PK = loItem.Entidadfinanciera_PK
					lxEntidadfinancieradetalle = loItem.Entidadfinancieradetalle
					lxNumero = loItem.Numero
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxCodigotributariolibrador = loItem.Codigotributariolibrador
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETDESCCHEQUE("JJT","NROITEM","Pesos","CODIGO","NroCheque","NroInterno","guidComp","EntFin","EFDet","cNumero","cFechaEmi","cFechaPago","cCoTribGir","Cliente","FCLIENTE","cMonto" ) values ( <<lxTipo>>, <<lxNroitem>>, <<lxPesosalcambio>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinanciera_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinancieradetalle ) + "'">>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigotributariolibrador ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxDescargachequeTimestamp
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
				lcError  = 'El n�mero a grabar ya existe. Cambie el �ltimo n�mero del talonario correspondiente'
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
			this.GenerarSentenciasComponentes()
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxDescargachequeFectrans, lxDescargachequeFmodifw, lxDescargachequeFecexpo, lxDescargachequeFecimpo, lxDescargachequeHoraexpo, lxDescargachequeVmodifw, lxDescargachequeValtafw, lxDescargachequeZadsfw, lxDescargachequeHmodifw, lxDescargachequeHoraimpo, lxDescargachequeUmodifw, lxDescargachequeSmodifw, lxDescargachequeUaltafw, lxDescargachequeSaltafw, lxDescargachequeEsttrans, lxDescargachequeHaltafw, lxDescargachequeFaltafw, lxDescargachequeBdaltafw, lxDescargachequeBdmodifw, lxDescargachequeTimestamp, lxDescargachequeAnulado, lxDescargachequeCodigo, lxDescargachequeDestino, lxDescargachequeConcepto, lxDescargachequeFfch, lxDescargachequeLetra, lxDescargachequePtoven, lxDescargachequeNumcomp, lxDescargachequeComptipo, lxDescargachequeCobs
				lxDescargachequeFectrans =  .Fechatransferencia			lxDescargachequeFmodifw =  .Fechamodificacionfw			lxDescargachequeFecexpo =  .Fechaexpo			lxDescargachequeFecimpo =  .Fechaimpo			lxDescargachequeHoraexpo =  .Horaexpo			lxDescargachequeVmodifw =  .Versionmodificacionfw			lxDescargachequeValtafw =  .Versionaltafw			lxDescargachequeZadsfw =  .Zadsfw			lxDescargachequeHmodifw =  .Horamodificacionfw			lxDescargachequeHoraimpo =  .Horaimpo			lxDescargachequeUmodifw =  .Usuariomodificacionfw			lxDescargachequeSmodifw =  .Seriemodificacionfw			lxDescargachequeUaltafw =  .Usuarioaltafw			lxDescargachequeSaltafw =  .Seriealtafw			lxDescargachequeEsttrans =  .Estadotransferencia			lxDescargachequeHaltafw =  .Horaaltafw			lxDescargachequeFaltafw =  .Fechaaltafw			lxDescargachequeBdaltafw =  .Basededatosaltafw			lxDescargachequeBdmodifw =  .Basededatosmodificacionfw			lxDescargachequeTimestamp = goLibrerias.ObtenerTimestamp()			lxDescargachequeAnulado =  .Anulado			lxDescargachequeCodigo =  .Codigo			lxDescargachequeDestino =  upper( .DestinoDescarga_PK ) 			lxDescargachequeConcepto =  upper( .Concepto_PK ) 			lxDescargachequeFfch =  .Fecha			lxDescargachequeLetra =  .Letra			lxDescargachequePtoven =  .Puntodeventa			lxDescargachequeNumcomp =  .Numero			lxDescargachequeComptipo =  .Tipocomprobante			lxDescargachequeCobs =  .Observ
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
				update ZooLogic.DESCARGACHEQUE set "Fectrans" = <<"'" + this.ConvertirDateSql( lxDescargachequeFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxDescargachequeFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxDescargachequeFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDescargachequeFecimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDescargachequeHoraexpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDescargachequeZadsfw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDescargachequeHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeSaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDescargachequeEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeHaltafw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDescargachequeFaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeBdaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeBdmodifw ) + "'">>,"Timestamp" = <<lxDescargachequeTimestamp>>,"Anulado" = <<iif( lxDescargachequeAnulado, 1, 0 )>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'">>,"Destino" = <<"'" + this.FormatearTextoSql( lxDescargachequeDestino ) + "'">>,"Concepto" = <<"'" + this.FormatearTextoSql( lxDescargachequeConcepto ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxDescargachequeFfch ) + "'">>,"Letra" = <<"'" + this.FormatearTextoSql( lxDescargachequeLetra ) + "'">>,"Ptoven" = <<lxDescargachequePtoven>>,"Numcomp" = <<lxDescargachequeNumcomp>>,"Comptipo" = <<lxDescargachequeComptipo>>,"Cobs" = <<"'" + this.FormatearTextoSql( lxDescargachequeCobs ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'">> and  DESCARGACHEQUE.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETDESCCHEQUE where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ChequesDetalle
				if this.oEntidad.ChequesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerointerno = loItem.Numerointerno
					lxIditemcomponente = loItem.Iditemcomponente
					lxEntidadfinanciera_PK = loItem.Entidadfinanciera_PK
					lxEntidadfinancieradetalle = loItem.Entidadfinancieradetalle
					lxNumero = loItem.Numero
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxCodigotributariolibrador = loItem.Codigotributariolibrador
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETDESCCHEQUE("JJT","NROITEM","Pesos","CODIGO","NroCheque","NroInterno","guidComp","EntFin","EFDet","cNumero","cFechaEmi","cFechaPago","cCoTribGir","Cliente","FCLIENTE","cMonto" ) values ( <<lxTipo>>, <<lxNroitem>>, <<lxPesosalcambio>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinanciera_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinancieradetalle ) + "'">>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigotributariolibrador ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxDescargachequeTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.DESCARGACHEQUE where " + this.ConvertirFuncionesSql( " DESCARGACHEQUE.CODIGO != ''" ) )
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
			Local lxDescargachequeCodigo
			lxDescargachequeCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ" from ZooLogic.DESCARGACHEQUE where "Codigo" = <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'">> and  DESCARGACHEQUE.CODIGO != ''
			endtext
			use in select('c_DESCARGADECHEQUES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCARGADECHEQUES', set( 'Datasession' ) )

			if reccount( 'c_DESCARGADECHEQUES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto" from ZooLogic.DETDESCCHEQUE where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCARGADECHEQUES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ChequesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ChequesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ChequesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxDESCARGACHEQUELetra As Variant, lxDESCARGACHEQUEPtoVen As Variant, lxDESCARGACHEQUENumComp As Variant
			lxDESCARGACHEQUELetra = .Letra
			lxDESCARGACHEQUEPtoVen = .PuntoDeVenta
			lxDESCARGACHEQUENumComp = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ" from ZooLogic.DESCARGACHEQUE where  DESCARGACHEQUE.CODIGO != '' And Letra = <<"'" + this.FormatearTextoSql( lxDESCARGACHEQUELetra ) + "'">> and PtoVen = <<lxDESCARGACHEQUEPtoVen>> and NumComp = <<lxDESCARGACHEQUENumComp>>
			endtext
			use in select('c_DESCARGADECHEQUES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCARGADECHEQUES', set( 'Datasession' ) )
			if reccount( 'c_DESCARGADECHEQUES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto" from ZooLogic.DETDESCCHEQUE where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCARGADECHEQUES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ChequesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ChequesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ChequesDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxDescargachequeCodigo as Variant
		llRetorno = .t.
		lxDescargachequeCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.DESCARGACHEQUE where "Codigo" = <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'">> and  DESCARGACHEQUE.CODIGO != ''
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ" from ZooLogic.DESCARGACHEQUE where  DESCARGACHEQUE.CODIGO != '' order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_DESCARGADECHEQUES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCARGADECHEQUES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto" from ZooLogic.DETDESCCHEQUE where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCARGADECHEQUES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ChequesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ChequesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ChequesDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ" from ZooLogic.DESCARGACHEQUE where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DESCARGACHEQUE.CODIGO != '' order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_DESCARGADECHEQUES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCARGADECHEQUES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto" from ZooLogic.DETDESCCHEQUE where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCARGADECHEQUES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ChequesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ChequesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ChequesDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ" from ZooLogic.DESCARGACHEQUE where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DESCARGACHEQUE.CODIGO != '' order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_DESCARGADECHEQUES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCARGADECHEQUES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto" from ZooLogic.DETDESCCHEQUE where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCARGADECHEQUES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ChequesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ChequesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ChequesDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ" from ZooLogic.DESCARGACHEQUE where  DESCARGACHEQUE.CODIGO != '' order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_DESCARGADECHEQUES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DESCARGADECHEQUES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto" from ZooLogic.DETDESCCHEQUE where CODIGO = <<"'" + this.FormatearTextoSql( c_DESCARGADECHEQUES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ChequesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ChequesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ChequesDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fmodifw,Fecexpo,Fecimpo,Horaexpo,Vmodifw,Valtafw,Zadsfw,Hmodifw,Horaimpo,Umodifw,Sm" + ;
"odifw,Ualtafw,Saltafw,Esttrans,Haltafw,Faltafw,Bdaltafw,Bdmodifw,Timestamp,Anulado,Codigo,Destino,Co" + ;
"ncepto,Ffch,Letra,Ptoven,Numcomp,Comptipo,Cobs" + ;
" from ZooLogic.DESCARGACHEQUE where  DESCARGACHEQUE.CODIGO != '' and " + lcFiltro )
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
			local  lxDescargachequeFectrans, lxDescargachequeFmodifw, lxDescargachequeFecexpo, lxDescargachequeFecimpo, lxDescargachequeHoraexpo, lxDescargachequeVmodifw, lxDescargachequeValtafw, lxDescargachequeZadsfw, lxDescargachequeHmodifw, lxDescargachequeHoraimpo, lxDescargachequeUmodifw, lxDescargachequeSmodifw, lxDescargachequeUaltafw, lxDescargachequeSaltafw, lxDescargachequeEsttrans, lxDescargachequeHaltafw, lxDescargachequeFaltafw, lxDescargachequeBdaltafw, lxDescargachequeBdmodifw, lxDescargachequeTimestamp, lxDescargachequeAnulado, lxDescargachequeCodigo, lxDescargachequeDestino, lxDescargachequeConcepto, lxDescargachequeFfch, lxDescargachequeLetra, lxDescargachequePtoven, lxDescargachequeNumcomp, lxDescargachequeComptipo, lxDescargachequeCobs
				lxDescargachequeFectrans = ctod( '  /  /    ' )			lxDescargachequeFmodifw = ctod( '  /  /    ' )			lxDescargachequeFecexpo = ctod( '  /  /    ' )			lxDescargachequeFecimpo = ctod( '  /  /    ' )			lxDescargachequeHoraexpo = []			lxDescargachequeVmodifw = []			lxDescargachequeValtafw = []			lxDescargachequeZadsfw = []			lxDescargachequeHmodifw = []			lxDescargachequeHoraimpo = []			lxDescargachequeUmodifw = []			lxDescargachequeSmodifw = []			lxDescargachequeUaltafw = []			lxDescargachequeSaltafw = []			lxDescargachequeEsttrans = []			lxDescargachequeHaltafw = []			lxDescargachequeFaltafw = ctod( '  /  /    ' )			lxDescargachequeBdaltafw = []			lxDescargachequeBdmodifw = []			lxDescargachequeTimestamp = goLibrerias.ObtenerTimestamp()			lxDescargachequeAnulado = .F.			lxDescargachequeCodigo = []			lxDescargachequeDestino = []			lxDescargachequeConcepto = []			lxDescargachequeFfch = ctod( '  /  /    ' )			lxDescargachequeLetra = []			lxDescargachequePtoven = 0			lxDescargachequeNumcomp = 0			lxDescargachequeComptipo = 0			lxDescargachequeCobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DETDESCCHEQUE where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.DESCARGACHEQUE where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'DESCARGACHEQUE' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DESCARGACHEQUE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DESCARGACHEQUE', '', tnTope )
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
	Function ObtenerDatosDetalleChequesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETDESCCHEQUE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Jjt" as "Tipo", "Nroitem" as "Nroitem", "Pesos" as "Pesosalcambio", "Codigo" as "Codigo", "Nrocheque" as "Numerocheque", "Nrointerno" as "Numerointerno", "Guidcomp" as "Iditemcomponente", "Entfin" as "Entidadfinanciera", "Efdet" as "Entidadfinancieradetalle", "Cnumero" as "Numero", "Cfechaemi" as "Fechaemision", "Cfechapago" as "Fechapago", "Ccotribgir" as "Codigotributariolibrador", "Cliente" as "Cliente", "Fcliente" as "Clientedetalle", "Cmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleChequesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETDESCCHEQUE', 'ChequesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleChequesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleChequesDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESTINODESCARGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESTINO AS DESTINODESCARGA'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMP AS NUMERO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'OBSERV'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERV'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleChequesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'ENTIDADFINANCIERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTFIN AS ENTIDADFINANCIERA'
				Case lcAtributo == 'ENTIDADFINANCIERADETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EFDET AS ENTIDADFINANCIERADETALLE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUMERO AS NUMERO'
				Case lcAtributo == 'FECHAEMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAEMI AS FECHAEMISION'
				Case lcAtributo == 'FECHAPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAPAGO AS FECHAPAGO'
				Case lcAtributo == 'CODIGOTRIBUTARIOLIBRADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOTRIBGIR AS CODIGOTRIBUTARIOLIBRADOR'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDETALLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONTO AS MONTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINODESCARGA'
				lcCampo = 'DESTINO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'COMPTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERV'
				lcCampo = 'COBS'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleChequesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERA'
				lcCampo = 'ENTFIN'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERADETALLE'
				lcCampo = 'EFDET'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEMISION'
				lcCampo = 'CFECHAEMI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAPAGO'
				lcCampo = 'CFECHAPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOTRIBUTARIOLIBRADOR'
				lcCampo = 'CCOTRIBGIR'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDETALLE'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'CMONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'CHEQUESDETALLE'
			lcRetorno = 'DETDESCCHEQUE'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDescargachequeFectrans, lxDescargachequeFmodifw, lxDescargachequeFecexpo, lxDescargachequeFecimpo, lxDescargachequeHoraexpo, lxDescargachequeVmodifw, lxDescargachequeValtafw, lxDescargachequeZadsfw, lxDescargachequeHmodifw, lxDescargachequeHoraimpo, lxDescargachequeUmodifw, lxDescargachequeSmodifw, lxDescargachequeUaltafw, lxDescargachequeSaltafw, lxDescargachequeEsttrans, lxDescargachequeHaltafw, lxDescargachequeFaltafw, lxDescargachequeBdaltafw, lxDescargachequeBdmodifw, lxDescargachequeTimestamp, lxDescargachequeAnulado, lxDescargachequeCodigo, lxDescargachequeDestino, lxDescargachequeConcepto, lxDescargachequeFfch, lxDescargachequeLetra, lxDescargachequePtoven, lxDescargachequeNumcomp, lxDescargachequeComptipo, lxDescargachequeCobs
				lxDescargachequeFectrans =  .Fechatransferencia			lxDescargachequeFmodifw =  .Fechamodificacionfw			lxDescargachequeFecexpo =  .Fechaexpo			lxDescargachequeFecimpo =  .Fechaimpo			lxDescargachequeHoraexpo =  .Horaexpo			lxDescargachequeVmodifw =  .Versionmodificacionfw			lxDescargachequeValtafw =  .Versionaltafw			lxDescargachequeZadsfw =  .Zadsfw			lxDescargachequeHmodifw =  .Horamodificacionfw			lxDescargachequeHoraimpo =  .Horaimpo			lxDescargachequeUmodifw =  .Usuariomodificacionfw			lxDescargachequeSmodifw =  .Seriemodificacionfw			lxDescargachequeUaltafw =  .Usuarioaltafw			lxDescargachequeSaltafw =  .Seriealtafw			lxDescargachequeEsttrans =  .Estadotransferencia			lxDescargachequeHaltafw =  .Horaaltafw			lxDescargachequeFaltafw =  .Fechaaltafw			lxDescargachequeBdaltafw =  .Basededatosaltafw			lxDescargachequeBdmodifw =  .Basededatosmodificacionfw			lxDescargachequeTimestamp = goLibrerias.ObtenerTimestamp()			lxDescargachequeAnulado =  .Anulado			lxDescargachequeCodigo =  .Codigo			lxDescargachequeDestino =  upper( .DestinoDescarga_PK ) 			lxDescargachequeConcepto =  upper( .Concepto_PK ) 			lxDescargachequeFfch =  .Fecha			lxDescargachequeLetra =  .Letra			lxDescargachequePtoven =  .Puntodeventa			lxDescargachequeNumcomp =  .Numero			lxDescargachequeComptipo =  .Tipocomprobante			lxDescargachequeCobs =  .Observ
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.DESCARGACHEQUE ( "Fectrans","Fmodifw","Fecexpo","Fecimpo","Horaexpo","Vmodifw","Valtafw","Zadsfw","Hmodifw","Horaimpo","Umodifw","Smodifw","Ualtafw","Saltafw","Esttrans","Haltafw","Faltafw","Bdaltafw","Bdmodifw","Timestamp","Anulado","Codigo","Destino","Concepto","Ffch","Letra","Ptoven","Numcomp","Comptipo","Cobs" ) values ( <<"'" + this.ConvertirDateSql( lxDescargachequeFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeHaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeBdmodifw ) + "'" >>, <<lxDescargachequeTimestamp >>, <<iif( lxDescargachequeAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeDestino ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeConcepto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDescargachequeFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDescargachequeLetra ) + "'" >>, <<lxDescargachequePtoven >>, <<lxDescargachequeNumcomp >>, <<lxDescargachequeComptipo >>, <<"'" + this.FormatearTextoSql( lxDescargachequeCobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'DESCARGACHEQUE' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ChequesDetalle
				if this.oEntidad.ChequesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerointerno = loItem.Numerointerno
					lxIditemcomponente = loItem.Iditemcomponente
					lxEntidadfinanciera_PK = loItem.Entidadfinanciera_PK
					lxEntidadfinancieradetalle = loItem.Entidadfinancieradetalle
					lxNumero = loItem.Numero
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxCodigotributariolibrador = loItem.Codigotributariolibrador
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETDESCCHEQUE("JJT","NROITEM","Pesos","CODIGO","NroCheque","NroInterno","guidComp","EntFin","EFDet","cNumero","cFechaEmi","cFechaPago","cCoTribGir","Cliente","FCLIENTE","cMonto" ) values ( <<lxTipo>>, <<lxNroitem>>, <<lxPesosalcambio>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinanciera_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinancieradetalle ) + "'">>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigotributariolibrador ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<lxMonto>> ) 
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
			local  lxDescargachequeFectrans, lxDescargachequeFmodifw, lxDescargachequeFecexpo, lxDescargachequeFecimpo, lxDescargachequeHoraexpo, lxDescargachequeVmodifw, lxDescargachequeValtafw, lxDescargachequeZadsfw, lxDescargachequeHmodifw, lxDescargachequeHoraimpo, lxDescargachequeUmodifw, lxDescargachequeSmodifw, lxDescargachequeUaltafw, lxDescargachequeSaltafw, lxDescargachequeEsttrans, lxDescargachequeHaltafw, lxDescargachequeFaltafw, lxDescargachequeBdaltafw, lxDescargachequeBdmodifw, lxDescargachequeTimestamp, lxDescargachequeAnulado, lxDescargachequeCodigo, lxDescargachequeDestino, lxDescargachequeConcepto, lxDescargachequeFfch, lxDescargachequeLetra, lxDescargachequePtoven, lxDescargachequeNumcomp, lxDescargachequeComptipo, lxDescargachequeCobs
				lxDescargachequeFectrans =  .Fechatransferencia			lxDescargachequeFmodifw =  .Fechamodificacionfw			lxDescargachequeFecexpo =  .Fechaexpo			lxDescargachequeFecimpo =  .Fechaimpo			lxDescargachequeHoraexpo =  .Horaexpo			lxDescargachequeVmodifw =  .Versionmodificacionfw			lxDescargachequeValtafw =  .Versionaltafw			lxDescargachequeZadsfw =  .Zadsfw			lxDescargachequeHmodifw =  .Horamodificacionfw			lxDescargachequeHoraimpo =  .Horaimpo			lxDescargachequeUmodifw =  .Usuariomodificacionfw			lxDescargachequeSmodifw =  .Seriemodificacionfw			lxDescargachequeUaltafw =  .Usuarioaltafw			lxDescargachequeSaltafw =  .Seriealtafw			lxDescargachequeEsttrans =  .Estadotransferencia			lxDescargachequeHaltafw =  .Horaaltafw			lxDescargachequeFaltafw =  .Fechaaltafw			lxDescargachequeBdaltafw =  .Basededatosaltafw			lxDescargachequeBdmodifw =  .Basededatosmodificacionfw			lxDescargachequeTimestamp = goLibrerias.ObtenerTimestamp()			lxDescargachequeAnulado =  .Anulado			lxDescargachequeCodigo =  .Codigo			lxDescargachequeDestino =  upper( .DestinoDescarga_PK ) 			lxDescargachequeConcepto =  upper( .Concepto_PK ) 			lxDescargachequeFfch =  .Fecha			lxDescargachequeLetra =  .Letra			lxDescargachequePtoven =  .Puntodeventa			lxDescargachequeNumcomp =  .Numero			lxDescargachequeComptipo =  .Tipocomprobante			lxDescargachequeCobs =  .Observ
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  DESCARGACHEQUE.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.DESCARGACHEQUE set "Fectrans" = <<"'" + this.ConvertirDateSql( lxDescargachequeFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDescargachequeFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDescargachequeFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDescargachequeFecimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDescargachequeHoraexpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDescargachequeZadsfw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDescargachequeHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeSaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDescargachequeEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeHaltafw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDescargachequeFaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDescargachequeBdaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDescargachequeBdmodifw ) + "'">>, "Timestamp" = <<lxDescargachequeTimestamp>>, "Anulado" = <<iif( lxDescargachequeAnulado, 1, 0 )>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxDescargachequeCodigo ) + "'">>, "Destino" = <<"'" + this.FormatearTextoSql( lxDescargachequeDestino ) + "'">>, "Concepto" = <<"'" + this.FormatearTextoSql( lxDescargachequeConcepto ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxDescargachequeFfch ) + "'">>, "Letra" = <<"'" + this.FormatearTextoSql( lxDescargachequeLetra ) + "'">>, "Ptoven" = <<lxDescargachequePtoven>>, "Numcomp" = <<lxDescargachequeNumcomp>>, "Comptipo" = <<lxDescargachequeComptipo>>, "Cobs" = <<"'" + this.FormatearTextoSql( lxDescargachequeCobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DESCARGACHEQUE' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DETDESCCHEQUE where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ChequesDetalle
				if this.oEntidad.ChequesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipo = loItem.Tipo
					lxNroitem = lnContadorNroItem
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerointerno = loItem.Numerointerno
					lxIditemcomponente = loItem.Iditemcomponente
					lxEntidadfinanciera_PK = loItem.Entidadfinanciera_PK
					lxEntidadfinancieradetalle = loItem.Entidadfinancieradetalle
					lxNumero = loItem.Numero
					lxFechaemision = loItem.Fechaemision
					lxFechapago = loItem.Fechapago
					lxCodigotributariolibrador = loItem.Codigotributariolibrador
					lxCliente_PK = loItem.Cliente_PK
					lxClientedetalle = loItem.Clientedetalle
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DETDESCCHEQUE("JJT","NROITEM","Pesos","CODIGO","NroCheque","NroInterno","guidComp","EntFin","EFDet","cNumero","cFechaEmi","cFechaPago","cCoTribGir","Cliente","FCLIENTE","cMonto" ) values ( <<lxTipo>>, <<lxNroitem>>, <<lxPesosalcambio>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinanciera_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidadfinancieradetalle ) + "'">>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFechaemision ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechapago ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigotributariolibrador ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedetalle ) + "'">>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  DESCARGACHEQUE.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.DESCARGACHEQUE where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DETDESCCHEQUE where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DESCARGACHEQUE' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
		
			.oCompCuentabancariadescargadecheques.lNuevo = .EsNuevo()
			.oCompCuentabancariadescargadecheques.lEdicion = .EsEdicion()
			.oCompCuentabancariadescargadecheques.lEliminar = .lEliminar
			.oCompCuentabancariadescargadecheques.lAnular = .lAnular
			loColSentencias = .oCompCuentabancariadescargadecheques.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
		with this.oEntidad
			.ChequesDetalle.oItem.oCompDescargadecheques.lNuevo = .EsNuevo()
			.ChequesDetalle.oItem.oCompDescargadecheques.lEdicion = .EsEdicion()
			.ChequesDetalle.oItem.oCompDescargadecheques.lEliminar = .lEliminar
			.ChequesDetalle.oItem.oCompDescargadecheques.lAnular = .lAnular
			loColSentencias = .ChequesDetalle.oItem.oCompDescargadecheques.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.DESCARGACHEQUE set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  DESCARGACHEQUE.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.DESCARGACHEQUE where  DESCARGACHEQUE.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.DESCARGACHEQUE where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DESCARGACHEQUE.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxDESCARGACHEQUELetra as variant, lxDESCARGACHEQUEPtoVen as variant, lxDESCARGACHEQUENumComp as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCARGADECHEQUES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.DESCARGACHEQUE Where  Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra      ) + "'" + [ and PtoVen = ] + transform( &lcCursor..PtoVen     ) + [ and NumComp = ] + transform( &lcCursor..NumComp    ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.DESCARGACHEQUE set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, destino = ] + "'" + this.FormatearTextoSql( &lcCursor..destino ) + "'"+ [, concepto = ] + "'" + this.FormatearTextoSql( &lcCursor..concepto ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, Letra = ] + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'"+ [, PtoVen = ] + transform( &lcCursor..PtoVen )+ [, NumComp = ] + transform( &lcCursor..NumComp )+ [, CompTipo = ] + transform( &lcCursor..CompTipo )+ [, CObs = ] + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
							else
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
							endif
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versi�n m�s actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.DESCARGACHEQUE Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FMODIFW, FECEXPO, FECIMPO, HORAEXPO, VMODIFW, VALTAFW, ZADSFW, HMODIFW, HORAIMPO, UMODIFW, SMODIFW, UALTAFW, SALTAFW, ESTTRANS, HAltaFW, FAltaFW, BDALTAFW, BDMODIFW, TIMESTAMP, Anulado, CODIGO, destino, concepto, FFCH, Letra, PtoVen, NumComp, CompTipo, CObs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..destino ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..concepto ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Letra ) + "'" + ',' + transform( &lcCursor..PtoVen ) + ',' + transform( &lcCursor..NumComp ) + ',' + transform( &lcCursor..CompTipo )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.DESCARGACHEQUE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCARGADECHEQUES'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DETDESCCHEQUE Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMDESCARGACHEQUE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"JJT","NROITEM","Pesos","CODIGO","NroCheque","NroInterno","guidComp","EntFin","EFDet","cNumero","cFechaEmi","cFechaPago","cCoTribGir","Cliente","FCLIENTE","cMonto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DETDESCCHEQUE ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.EntFin     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.EFDet      ) + "'" + ',' + transform( cDetallesExistentes.cNumero    ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.cFechaEmi  ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.cFechaPago ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCoTribGir ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCLIENTE   ) + "'" + ',' + transform( cDetallesExistentes.cMonto     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.ChequesDetalle.oItem.oCompDescargadecheques.Recibir( this.oEntidad, 'ChequesDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMDESCARGACHEQUE',this.oEntidad.cPrefijoRecibir + 'DESCARGADECHEQUES')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - N�mero comprobante: ' + transform( &tcCursor..Letra      )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..PtoVen     )
		lcRetorno = lcRetorno + ' - N�mero: ' + transform( &tcCursor..NumComp    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DESCARGADECHEQUES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DESCARGADECHEQUES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMDESCARGACHEQUE'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_DESCARGACHEQUE')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DESCARGADECHEQUES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Letra ) or isnull( &lcCursor..PtoVen ) or isnull( &lcCursor..NumComp )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DESCARGADECHEQUES. Hay un error en el dise�o de importaci�n.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el dise�o.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCARGADECHEQUES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,Letra + str( PtoVen, 4, 0) + str( NumComp, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Letra + str( PtoVen, 4, 0) + str( NumComp, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCARGADECHEQUES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DESCARGACHEQUE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DESCARGACHEQUE
Create Table ZooLogic.TablaTrabajo_DESCARGACHEQUE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"horaexpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"faltafw" datetime  null, 
"bdaltafw" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"codigo" char( 38 )  null, 
"destino" char( 10 )  null, 
"concepto" char( 10 )  null, 
"ffch" datetime  null, 
"letra" char( 1 )  null, 
"ptoven" numeric( 4, 0 )  null, 
"numcomp" numeric( 8, 0 )  null, 
"comptipo" numeric( 2, 0 )  null, 
"cobs" char( 100 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DESCARGACHEQUE' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DESCARGACHEQUE' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DESCARGADECHEQUES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('destino','destino')
			.AgregarMapeo('concepto','concepto')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('letra','letra')
			.AgregarMapeo('ptoven','ptoven')
			.AgregarMapeo('numcomp','numcomp')
			.AgregarMapeo('comptipo','comptipo')
			.AgregarMapeo('cobs','cobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_DESCARGACHEQUE'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESTINO = isnull( d.DESTINO, t.DESTINO ),t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.LETRA = isnull( d.LETRA, t.LETRA ),t.PTOVEN = isnull( d.PTOVEN, t.PTOVEN ),t.NUMCOMP = isnull( d.NUMCOMP, t.NUMCOMP ),t.COMPTIPO = isnull( d.COMPTIPO, t.COMPTIPO ),t.COBS = isnull( d.COBS, t.COBS )
					from ZooLogic.DESCARGACHEQUE t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.Letra = d.Letra
							 and  t.PtoVen = d.PtoVen
							 and  t.NumComp = d.NumComp
				-- Fin Updates
				insert into ZooLogic.DESCARGACHEQUE(Fectrans,Fmodifw,Fecexpo,Fecimpo,Horaexpo,Vmodifw,Valtafw,Zadsfw,Hmodifw,Horaimpo,Umodifw,Smodifw,Ualtafw,Saltafw,Esttrans,Haltafw,Faltafw,Bdaltafw,Bdmodifw,Timestamp,Anulado,Codigo,Destino,Concepto,Ffch,Letra,Ptoven,Numcomp,Comptipo,Cobs)
					Select isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.HORAEXPO,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.BDALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),isnull( d.CODIGO,''),isnull( d.DESTINO,''),isnull( d.CONCEPTO,''),isnull( d.FFCH,''),isnull( d.LETRA,''),isnull( d.PTOVEN,0),isnull( d.NUMCOMP,0),isnull( d.COMPTIPO,0),isnull( d.COBS,'')
						From deleted d left join ZooLogic.DESCARGACHEQUE pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.DESCARGACHEQUE cc 
							 on  d.Letra = cc.Letra
							 and  d.PtoVen = cc.PtoVen
							 and  d.NumComp = cc.NumComp
						Where pk.CODIGO Is Null 
							 and cc.Letra Is Null 
							 and cc.PtoVen Is Null 
							 and cc.NumComp Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importaci�n <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: N�MERO COMPROBANTE ' + cast( d.Letra as Varchar(1) ) + ', PTO. VENTA ' + cast( d.PtoVen as Varchar(4) ) + ', N�MERO ' + cast( d.NumComp as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.DESCARGACHEQUE t inner join deleted d 
							on   t.Letra = d.Letra
							 and  t.PtoVen = d.PtoVen
							 and  t.NumComp = d.NumComp
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importaci�n <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: N�MERO COMPROBANTE ' + cast( d.Letra as Varchar(1) ) + ', PTO. VENTA ' + cast( d.PtoVen as Varchar(4) ) + ', N�MERO ' + cast( d.NumComp as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.DESCARGACHEQUE t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.Letra = h.Letra
							 and   t.PtoVen = h.PtoVen
							 and   t.NumComp = h.NumComp
							where   h.Letra is null 
							 and   h.PtoVen is null 
							 and   h.NumComp is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETDESCCHEQUE( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DESCARGACHEQUE_DETDESCCHEQUE
ON ZooLogic.TablaTrabajo_DESCARGACHEQUE_DETDESCCHEQUE
AFTER DELETE
As
Begin
Update t Set 
t.JJT = isnull( d.JJT, t.JJT ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.ENTFIN = isnull( d.ENTFIN, t.ENTFIN ),
t.EFDET = isnull( d.EFDET, t.EFDET ),
t.CNUMERO = isnull( d.CNUMERO, t.CNUMERO ),
t.CFECHAEMI = isnull( d.CFECHAEMI, t.CFECHAEMI ),
t.CFECHAPAGO = isnull( d.CFECHAPAGO, t.CFECHAPAGO ),
t.CCOTRIBGIR = isnull( d.CCOTRIBGIR, t.CCOTRIBGIR ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),
t.CMONTO = isnull( d.CMONTO, t.CMONTO )
from ZooLogic.DETDESCCHEQUE t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DETDESCCHEQUE
( 
"JJT",
"NROITEM",
"PESOS",
"CODIGO",
"NROCHEQUE",
"NROINTERNO",
"GUIDCOMP",
"ENTFIN",
"EFDET",
"CNUMERO",
"CFECHAEMI",
"CFECHAPAGO",
"CCOTRIBGIR",
"CLIENTE",
"FCLIENTE",
"CMONTO"
 )
Select 
d.JJT,
d.NROITEM,
d.PESOS,
d.CODIGO,
d.NROCHEQUE,
d.NROINTERNO,
d.GUIDCOMP,
d.ENTFIN,
d.EFDET,
d.CNUMERO,
d.CFECHAEMI,
d.CFECHAPAGO,
d.CCOTRIBGIR,
d.CLIENTE,
d.FCLIENTE,
d.CMONTO
From deleted d left join ZooLogic.DETDESCCHEQUE pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DESCARGACHEQUE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DESCARGACHEQUE
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DESCARGADECHEQUES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCARGADECHEQUES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCARGADECHEQUES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCARGADECHEQUES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCARGADECHEQUES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_DESCARGADECHEQUES.Horaexpo, [] )
					.Versionmodificacionfw = nvl( c_DESCARGADECHEQUES.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_DESCARGADECHEQUES.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horamodificacionfw = nvl( c_DESCARGADECHEQUES.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_DESCARGADECHEQUES.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_DESCARGADECHEQUES.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_DESCARGADECHEQUES.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_DESCARGADECHEQUES.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_DESCARGADECHEQUES.Seriealtafw, [] )
					.Estadotransferencia = nvl( c_DESCARGADECHEQUES.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_DESCARGADECHEQUES.Horaaltafw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCARGADECHEQUES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Basededatosaltafw = nvl( c_DESCARGADECHEQUES.Basededatosaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_DESCARGADECHEQUES.Basededatosmodificacionfw, [] )
					.Timestamp = nvl( c_DESCARGADECHEQUES.Timestamp, 0 )
					.Anulado = nvl( c_DESCARGADECHEQUES.Anulado, .F. )
					.Codigo = nvl( c_DESCARGADECHEQUES.Codigo, [] )
					.Destinodescarga_PK =  nvl( c_DESCARGADECHEQUES.Destinodescarga, [] )
					.Concepto_PK =  nvl( c_DESCARGADECHEQUES.Concepto, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_DESCARGADECHEQUES.Fecha, ctod( '  /  /    ' ) ) )
					.Letra = nvl( c_DESCARGADECHEQUES.Letra, [] )
					.Puntodeventa = nvl( c_DESCARGADECHEQUES.Puntodeventa, 0 )
					.Numero = nvl( c_DESCARGADECHEQUES.Numero, 0 )
					.Tipocomprobante = nvl( c_DESCARGADECHEQUES.Tipocomprobante, 0 )
					.Chequesdetalle.Limpiar()
					.Chequesdetalle.SetearEsNavegacion( .lProcesando )
					.Chequesdetalle.Cargar()
					.Observ = nvl( c_DESCARGADECHEQUES.Observ, [] )
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
			lxRetorno = c_DESCARGADECHEQUES.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ChequesDetalle
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
		return c_DESCARGADECHEQUES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.DESCARGACHEQUE' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.DESCARGACHEQUE 
								Where   DESCARGACHEQUE.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DESCARGACHEQUE", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Horaexpo" as "Horaexpo", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Faltafw" as "Fechaaltafw", "Bdaltafw" as "Basededatosaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Codigo" as "Codigo", "Destino" as "Destinodescarga", "Concepto" as "Concepto", "Ffch" as "Fecha", "Letra" as "Letra", "Ptoven" as "Puntodeventa", "Numcomp" as "Numero", "Comptipo" as "Tipocomprobante", "Cobs" as "Observ"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.DESCARGACHEQUE 
								Where   DESCARGACHEQUE.CODIGO != ''
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
	Tabla = 'DESCARGACHEQUE'
	Filtro = " DESCARGACHEQUE.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DESCARGACHEQUE.CODIGO != ''"
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
	<row entidad="DESCARGADECHEQUES                       " atributo="FECHATRANSFERENCIA                      " tabla="DESCARGACHEQUE " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="FECHAMODIFICACIONFW                     " tabla="DESCARGACHEQUE " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificaci�n                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="FECHAEXPO                               " tabla="DESCARGACHEQUE " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportaci�n                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="FECHAIMPO                               " tabla="DESCARGACHEQUE " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importaci�n                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="HORAEXPO                                " tabla="DESCARGACHEQUE " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportaci�n                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="VERSIONMODIFICACIONFW                   " tabla="DESCARGACHEQUE " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versi�n modificaci�n                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="VERSIONALTAFW                           " tabla="DESCARGACHEQUE " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versi�n alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="ZADSFW                                  " tabla="DESCARGACHEQUE " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="HORAMODIFICACIONFW                      " tabla="DESCARGACHEQUE " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificaci�n                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="HORAIMPO                                " tabla="DESCARGACHEQUE " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importaci�n                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="USUARIOMODIFICACIONFW                   " tabla="DESCARGACHEQUE " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificaci�n                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="SERIEMODIFICACIONFW                     " tabla="DESCARGACHEQUE " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificaci�n                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="USUARIOALTAFW                           " tabla="DESCARGACHEQUE " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="SERIEALTAFW                             " tabla="DESCARGACHEQUE " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="ESTADOTRANSFERENCIA                     " tabla="DESCARGACHEQUE " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="HORAALTAFW                              " tabla="DESCARGACHEQUE " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="FECHAALTAFW                             " tabla="DESCARGACHEQUE " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="BASEDEDATOSALTAFW                       " tabla="DESCARGACHEQUE " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DESCARGACHEQUE " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificaci�n                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="TIMESTAMP                               " tabla="DESCARGACHEQUE " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="ANULADO                                 " tabla="DESCARGACHEQUE " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="CODIGO                                  " tabla="DESCARGACHEQUE " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="C�digo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="DESTINODESCARGA                         " tabla="DESCARGACHEQUE " campo="DESTINO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESTINODESCARGACHEQUES                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Destino de descarga                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="CONCEPTO                                " tabla="DESCARGACHEQUE " campo="CONCEPTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONCEPTOCAJA                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Concepto                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="FECHA                                   " tabla="DESCARGACHEQUE " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="400" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="LETRA                                   " tabla="DESCARGACHEQUE " campo="LETRA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="=&quot;X&quot;                                                                                                                                                                                                                                                          " obligatorio="true" admitebusqueda="2" etiqueta="N�mero comprobante                                                                                                                                              " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="PUNTODEVENTA                            " tabla="DESCARGACHEQUE " campo="PTOVEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goServicios.Parametros.Felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                    " obligatorio="true" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="NUMERO                                  " tabla="DESCARGACHEQUE " campo="NUMCOMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="N�mero                                                                                                                                                          " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="TIPOCOMPROBANTE                         " tabla="DESCARGACHEQUE " campo="COMPTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=46                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de comprobante                                                                                                                                             " dominio="COMBOTIPOCOMPROBANTE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="70" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="CHEQUESDETALLE                          " tabla="DETDESCCHEQUE  " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Detalle                                                                                                                                                         " dominio="DETALLEITEMDESCARGACHEQUE     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="80" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESCARGADECHEQUES                       " atributo="OBSERV                                  " tabla="DESCARGACHEQUE " campo="COBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DESTINODESCARGACHEQUES                  " atributo="DESCRIPCION                             " tabla="DESTDESC       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Des.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DESTDESC On DESCARGACHEQUE.DESTINO = DESTDESC.Codigo And  DESTDESC.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONCEPTOCAJA                            " atributo="DESCRIPCION                             " tabla="CONCECAJA      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONCECAJA On DESCARGACHEQUE.CONCEPTO = CONCECAJA.Codigo And  CONCECAJA.CODIGO != ''                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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