
define class Din_EntidadVALEDECAMBIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_VALEDECAMBIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_VCBPK'
	cTablaPrincipal = 'VALCAMBIO'
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
			local  lxValcambioFecexpo, lxValcambioFaltafw, lxValcambioFecimpo, lxValcambioFectrans, lxValcambioFmodifw, lxValcambioCfecha, lxValcambioCtipcd, lxValcambioSaldo, lxValcambioCtipc, lxValcambioBdmodifw, lxValcambioEsttrans, lxValcambioHaltafw, lxValcambioSaltafw, lxValcambioValtafw, lxValcambioZadsfw, lxValcambioVmodifw, lxValcambioUmodifw, lxValcambioSmodifw, lxValcambioUaltafw, lxValcambioHoraimpo, lxValcambioBdaltafw, lxValcambioHmodifw, lxValcambioHoraexpo, lxValcambioCcodcompd, lxValcambioCcliented, lxValcambioCcodcomp, lxValcambioCcliente, lxValcambioCseried, lxValcambioArticulo, lxValcambioCserie, lxValcambioChora, lxValcambioCobss, lxValcambioCfechavenc, lxValcambioCcompori, lxValcambioCcompdes, lxValcambioCletd, lxValcambioClet, lxValcambioCusuariod, lxValcambioCusuario, lxValcambioCcod, lxValcambioCfchdest, lxValcambioCfchorig, lxValcambioCptovtad, lxValcambioPtoventa, lxValcambioCptovta, lxValcambioCbddest, lxValcambioCbdorig, lxValcambioNumero, lxValcambioCnumd, lxValcambioCnum, lxValcambioCmonto, lxValcambioTipo, lxValcambioReutiliza, lxValcambioValor, lxValcambioEmail, lxValcambioCsignod, lxValcambioCsigno, lxValcambioMoneda
				lxValcambioFecexpo =  .Fechaexpo			lxValcambioFaltafw =  .Fechaaltafw			lxValcambioFecimpo =  .Fechaimpo			lxValcambioFectrans =  .Fechatransferencia			lxValcambioFmodifw =  .Fechamodificacionfw			lxValcambioCfecha =  .Fecha			lxValcambioCtipcd =  .Tipodecomprobantedestino			lxValcambioSaldo =  .Saldo			lxValcambioCtipc =  .Tipodecomprobanteorigen			lxValcambioBdmodifw =  .Basededatosmodificacionfw			lxValcambioEsttrans =  .Estadotransferencia			lxValcambioHaltafw =  .Horaaltafw			lxValcambioSaltafw =  .Seriealtafw			lxValcambioValtafw =  .Versionaltafw			lxValcambioZadsfw =  .Zadsfw			lxValcambioVmodifw =  .Versionmodificacionfw			lxValcambioUmodifw =  .Usuariomodificacionfw			lxValcambioSmodifw =  .Seriemodificacionfw			lxValcambioUaltafw =  .Usuarioaltafw			lxValcambioHoraimpo =  .Horaimpo			lxValcambioBdaltafw =  .Basededatosaltafw			lxValcambioHmodifw =  .Horamodificacionfw			lxValcambioHoraexpo =  .Horaexpo			lxValcambioCcodcompd =  .Codigocomprobantedestino			lxValcambioCcliented =  .Clientedestino			lxValcambioCcodcomp =  .Codigocomprobanteorigen			lxValcambioCcliente =  .Clienteorigen			lxValcambioCseried =  .Seriedestino			lxValcambioArticulo =  .Articulo			lxValcambioCserie =  .Serieorigen			lxValcambioChora =  .Hora			lxValcambioCobss =  .Obs			lxValcambioCfechavenc =  .Fechavencimiento			lxValcambioCcompori =  .Comprobanteorigen			lxValcambioCcompdes =  .Comprobantedestino			lxValcambioCletd =  .Letradestino			lxValcambioClet =  .Letraorigen			lxValcambioCusuariod =  .Usuariodestino			lxValcambioCusuario =  .Usuarioorigen			lxValcambioCcod =  .Codigo			lxValcambioCfchdest =  .Fechadestino			lxValcambioCfchorig =  .Fechaorigen			lxValcambioCptovtad =  .Puntodeventadestino			lxValcambioPtoventa =  .Puntodeventa			lxValcambioCptovta =  .Puntodeventaorigen			lxValcambioCbddest =  .Bddestino			lxValcambioCbdorig =  .Bdorigen			lxValcambioNumero =  .Numero			lxValcambioCnumd =  .Numerodestino			lxValcambioCnum =  .Numeroorigen			lxValcambioCmonto =  .Monto			lxValcambioTipo =  .Tipo			lxValcambioReutiliza =  .Reutilizable			lxValcambioValor =  .Valor			lxValcambioEmail =  .Email			lxValcambioCsignod =  .Signodemovimientodestino			lxValcambioCsigno =  .Signodemovimientoorigen			lxValcambioMoneda =  .Simbolomonetario
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxValcambioCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.VALCAMBIO ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Cfecha","Ctipcd","Saldo","Ctipc","Bdmodifw","Esttrans","Haltafw","Saltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Smodifw","Ualtafw","Horaimpo","Bdaltafw","Hmodifw","Horaexpo","Ccodcompd","Ccliented","Ccodcomp","Ccliente","Cseried","Articulo","Cserie","Chora","Cobss","Cfechavenc","Ccompori","Ccompdes","Cletd","Clet","Cusuariod","Cusuario","Ccod","Cfchdest","Cfchorig","Cptovtad","Ptoventa","Cptovta","Cbddest","Cbdorig","Numero","Cnumd","Cnum","Cmonto","Tipo","Reutiliza","Valor","Email","Csignod","Csigno","Moneda" ) values ( <<"'" + this.ConvertirDateSql( lxValcambioFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfecha ) + "'" >>, <<lxValcambioCtipcd >>, <<lxValcambioSaldo >>, <<lxValcambioCtipc >>, <<"'" + this.FormatearTextoSql( lxValcambioBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcodcompd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcliented ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCseried ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioArticulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioChora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCobss ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfechavenc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcompori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcompdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCletd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioClet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCusuariod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCusuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfchdest ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfchorig ) + "'" >>, <<lxValcambioCptovtad >>, <<lxValcambioPtoventa >>, <<lxValcambioCptovta >>, <<"'" + this.FormatearTextoSql( lxValcambioCbddest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCbdorig ) + "'" >>, <<lxValcambioNumero >>, <<lxValcambioCnumd >>, <<lxValcambioCnum >>, <<lxValcambioCmonto >>, <<"'" + this.FormatearTextoSql( lxValcambioTipo ) + "'" >>, <<iif( lxValcambioReutiliza, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxValcambioValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioEmail ) + "'" >>, <<lxValcambioCsignod >>, <<lxValcambioCsigno >>, <<"'" + this.FormatearTextoSql( lxValcambioMoneda ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobanteDetalle
				if this.oEntidad.ComprobanteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigocomprobantedestino = loItem.Codigocomprobantedestino
					lxTipodecomprobantedestino = loItem.Tipodecomprobantedestino
					lxLetradestino = loItem.Letradestino
					lxPuntodeventadestino = loItem.Puntodeventadestino
					lxNumerodestino = loItem.Numerodestino
					lxComprobantedestino = loItem.Comprobantedestino
					lxClientedestino = loItem.Clientedestino
					lxFechadestino = loItem.Fechadestino
					lxMonto = loItem.Monto
					lxSeriedestino = loItem.Seriedestino
					lxUsuariodestino = loItem.Usuariodestino
					lxBddestino = loItem.Bddestino
					lxSignodemovimientodestino = loItem.Signodemovimientodestino
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VALCAMBIODET("NROITEM","Codigo","CCodCompd","cTipCd","cletd","cptovtad","cnumd","CCompDes","cClienteD","CFchDest","CMonto","CSerieD","CUsuarioD","CBDDest","cSignod" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobantedestino ) + "'">>, <<lxTipodecomprobantedestino>>, <<"'" + this.FormatearTextoSql( lxLetradestino ) + "'">>, <<lxPuntodeventadestino>>, <<lxNumerodestino>>, <<"'" + this.FormatearTextoSql( lxComprobantedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedestino ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechadestino ) + "'">>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxSeriedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxUsuariodestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxBddestino ) + "'">>, <<lxSignodemovimientodestino>> ) 
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
			local  lxValcambioFecexpo, lxValcambioFaltafw, lxValcambioFecimpo, lxValcambioFectrans, lxValcambioFmodifw, lxValcambioCfecha, lxValcambioCtipcd, lxValcambioSaldo, lxValcambioCtipc, lxValcambioBdmodifw, lxValcambioEsttrans, lxValcambioHaltafw, lxValcambioSaltafw, lxValcambioValtafw, lxValcambioZadsfw, lxValcambioVmodifw, lxValcambioUmodifw, lxValcambioSmodifw, lxValcambioUaltafw, lxValcambioHoraimpo, lxValcambioBdaltafw, lxValcambioHmodifw, lxValcambioHoraexpo, lxValcambioCcodcompd, lxValcambioCcliented, lxValcambioCcodcomp, lxValcambioCcliente, lxValcambioCseried, lxValcambioArticulo, lxValcambioCserie, lxValcambioChora, lxValcambioCobss, lxValcambioCfechavenc, lxValcambioCcompori, lxValcambioCcompdes, lxValcambioCletd, lxValcambioClet, lxValcambioCusuariod, lxValcambioCusuario, lxValcambioCcod, lxValcambioCfchdest, lxValcambioCfchorig, lxValcambioCptovtad, lxValcambioPtoventa, lxValcambioCptovta, lxValcambioCbddest, lxValcambioCbdorig, lxValcambioNumero, lxValcambioCnumd, lxValcambioCnum, lxValcambioCmonto, lxValcambioTipo, lxValcambioReutiliza, lxValcambioValor, lxValcambioEmail, lxValcambioCsignod, lxValcambioCsigno, lxValcambioMoneda
				lxValcambioFecexpo =  .Fechaexpo			lxValcambioFaltafw =  .Fechaaltafw			lxValcambioFecimpo =  .Fechaimpo			lxValcambioFectrans =  .Fechatransferencia			lxValcambioFmodifw =  .Fechamodificacionfw			lxValcambioCfecha =  .Fecha			lxValcambioCtipcd =  .Tipodecomprobantedestino			lxValcambioSaldo =  .Saldo			lxValcambioCtipc =  .Tipodecomprobanteorigen			lxValcambioBdmodifw =  .Basededatosmodificacionfw			lxValcambioEsttrans =  .Estadotransferencia			lxValcambioHaltafw =  .Horaaltafw			lxValcambioSaltafw =  .Seriealtafw			lxValcambioValtafw =  .Versionaltafw			lxValcambioZadsfw =  .Zadsfw			lxValcambioVmodifw =  .Versionmodificacionfw			lxValcambioUmodifw =  .Usuariomodificacionfw			lxValcambioSmodifw =  .Seriemodificacionfw			lxValcambioUaltafw =  .Usuarioaltafw			lxValcambioHoraimpo =  .Horaimpo			lxValcambioBdaltafw =  .Basededatosaltafw			lxValcambioHmodifw =  .Horamodificacionfw			lxValcambioHoraexpo =  .Horaexpo			lxValcambioCcodcompd =  .Codigocomprobantedestino			lxValcambioCcliented =  .Clientedestino			lxValcambioCcodcomp =  .Codigocomprobanteorigen			lxValcambioCcliente =  .Clienteorigen			lxValcambioCseried =  .Seriedestino			lxValcambioArticulo =  .Articulo			lxValcambioCserie =  .Serieorigen			lxValcambioChora =  .Hora			lxValcambioCobss =  .Obs			lxValcambioCfechavenc =  .Fechavencimiento			lxValcambioCcompori =  .Comprobanteorigen			lxValcambioCcompdes =  .Comprobantedestino			lxValcambioCletd =  .Letradestino			lxValcambioClet =  .Letraorigen			lxValcambioCusuariod =  .Usuariodestino			lxValcambioCusuario =  .Usuarioorigen			lxValcambioCcod =  .Codigo			lxValcambioCfchdest =  .Fechadestino			lxValcambioCfchorig =  .Fechaorigen			lxValcambioCptovtad =  .Puntodeventadestino			lxValcambioPtoventa =  .Puntodeventa			lxValcambioCptovta =  .Puntodeventaorigen			lxValcambioCbddest =  .Bddestino			lxValcambioCbdorig =  .Bdorigen			lxValcambioNumero =  .Numero			lxValcambioCnumd =  .Numerodestino			lxValcambioCnum =  .Numeroorigen			lxValcambioCmonto =  .Monto			lxValcambioTipo =  .Tipo			lxValcambioReutiliza =  .Reutilizable			lxValcambioValor =  .Valor			lxValcambioEmail =  .Email			lxValcambioCsignod =  .Signodemovimientodestino			lxValcambioCsigno =  .Signodemovimientoorigen			lxValcambioMoneda =  .Simbolomonetario
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.VALCAMBIO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxValcambioFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxValcambioFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxValcambioFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxValcambioFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxValcambioFmodifw ) + "'">>,"Cfecha" = <<"'" + this.ConvertirDateSql( lxValcambioCfecha ) + "'">>,"Ctipcd" = <<lxValcambioCtipcd>>,"Saldo" = <<lxValcambioSaldo>>,"Ctipc" = <<lxValcambioCtipc>>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxValcambioBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxValcambioEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxValcambioHaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxValcambioSaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxValcambioValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxValcambioZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxValcambioVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxValcambioUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxValcambioSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxValcambioUaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxValcambioHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxValcambioBdaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxValcambioHmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxValcambioHoraexpo ) + "'">>,"Ccodcompd" = <<"'" + this.FormatearTextoSql( lxValcambioCcodcompd ) + "'">>,"Ccliented" = <<"'" + this.FormatearTextoSql( lxValcambioCcliented ) + "'">>,"Ccodcomp" = <<"'" + this.FormatearTextoSql( lxValcambioCcodcomp ) + "'">>,"Ccliente" = <<"'" + this.FormatearTextoSql( lxValcambioCcliente ) + "'">>,"Cseried" = <<"'" + this.FormatearTextoSql( lxValcambioCseried ) + "'">>,"Articulo" = <<"'" + this.FormatearTextoSql( lxValcambioArticulo ) + "'">>,"Cserie" = <<"'" + this.FormatearTextoSql( lxValcambioCserie ) + "'">>,"Chora" = <<"'" + this.FormatearTextoSql( lxValcambioChora ) + "'">>,"Cobss" = <<"'" + this.FormatearTextoSql( lxValcambioCobss ) + "'">>,"Cfechavenc" = <<"'" + this.ConvertirDateSql( lxValcambioCfechavenc ) + "'">>,"Ccompori" = <<"'" + this.FormatearTextoSql( lxValcambioCcompori ) + "'">>,"Ccompdes" = <<"'" + this.FormatearTextoSql( lxValcambioCcompdes ) + "'">>,"Cletd" = <<"'" + this.FormatearTextoSql( lxValcambioCletd ) + "'">>,"Clet" = <<"'" + this.FormatearTextoSql( lxValcambioClet ) + "'">>,"Cusuariod" = <<"'" + this.FormatearTextoSql( lxValcambioCusuariod ) + "'">>,"Cusuario" = <<"'" + this.FormatearTextoSql( lxValcambioCusuario ) + "'">>,"Ccod" = <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'">>,"Cfchdest" = <<"'" + this.ConvertirDateSql( lxValcambioCfchdest ) + "'">>,"Cfchorig" = <<"'" + this.ConvertirDateSql( lxValcambioCfchorig ) + "'">>,"Cptovtad" = <<lxValcambioCptovtad>>,"Ptoventa" = <<lxValcambioPtoventa>>,"Cptovta" = <<lxValcambioCptovta>>,"Cbddest" = <<"'" + this.FormatearTextoSql( lxValcambioCbddest ) + "'">>,"Cbdorig" = <<"'" + this.FormatearTextoSql( lxValcambioCbdorig ) + "'">>,"Numero" = <<lxValcambioNumero>>,"Cnumd" = <<lxValcambioCnumd>>,"Cnum" = <<lxValcambioCnum>>,"Cmonto" = <<lxValcambioCmonto>>,"Tipo" = <<"'" + this.FormatearTextoSql( lxValcambioTipo ) + "'">>,"Reutiliza" = <<iif( lxValcambioReutiliza, 1, 0 )>>,"Valor" = <<"'" + this.FormatearTextoSql( lxValcambioValor ) + "'">>,"Email" = <<"'" + this.FormatearTextoSql( lxValcambioEmail ) + "'">>,"Csignod" = <<lxValcambioCsignod>>,"Csigno" = <<lxValcambioCsigno>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxValcambioMoneda ) + "'">> where "Ccod" = <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'">> and  VALCAMBIO.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VALCAMBIODET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobanteDetalle
				if this.oEntidad.ComprobanteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigocomprobantedestino = loItem.Codigocomprobantedestino
					lxTipodecomprobantedestino = loItem.Tipodecomprobantedestino
					lxLetradestino = loItem.Letradestino
					lxPuntodeventadestino = loItem.Puntodeventadestino
					lxNumerodestino = loItem.Numerodestino
					lxComprobantedestino = loItem.Comprobantedestino
					lxClientedestino = loItem.Clientedestino
					lxFechadestino = loItem.Fechadestino
					lxMonto = loItem.Monto
					lxSeriedestino = loItem.Seriedestino
					lxUsuariodestino = loItem.Usuariodestino
					lxBddestino = loItem.Bddestino
					lxSignodemovimientodestino = loItem.Signodemovimientodestino
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VALCAMBIODET("NROITEM","Codigo","CCodCompd","cTipCd","cletd","cptovtad","cnumd","CCompDes","cClienteD","CFchDest","CMonto","CSerieD","CUsuarioD","CBDDest","cSignod" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobantedestino ) + "'">>, <<lxTipodecomprobantedestino>>, <<"'" + this.FormatearTextoSql( lxLetradestino ) + "'">>, <<lxPuntodeventadestino>>, <<lxNumerodestino>>, <<"'" + this.FormatearTextoSql( lxComprobantedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedestino ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechadestino ) + "'">>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxSeriedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxUsuariodestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxBddestino ) + "'">>, <<lxSignodemovimientodestino>> ) 
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
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CCOD from ZooLogic.VALCAMBIO where " + this.ConvertirFuncionesSql( " VALCAMBIO.CCOD != ''" ) )
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
			Local lxValcambioCcod
			lxValcambioCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario" from ZooLogic.VALCAMBIO where "Ccod" = <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'">> and  VALCAMBIO.CCOD != ''
			endtext
			use in select('c_VALEDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALEDECAMBIO', set( 'Datasession' ) )

			if reccount( 'c_VALEDECAMBIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Ccodcompd" as "Codigocomprobantedestino", "Ctipcd" as "Tipodecomprobantedestino", "Cletd" as "Letradestino", "Cptovtad" as "Puntodeventadestino", "Cnumd" as "Numerodestino", "Ccompdes" as "Comprobantedestino", "Ccliented" as "Clientedestino", "Cfchdest" as "Fechadestino", "Cmonto" as "Monto", "Cseried" as "Seriedestino", "Cusuariod" as "Usuariodestino", "Cbddest" as "Bddestino", "Csignod" as "Signodemovimientodestino" from ZooLogic.VALCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_VALEDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobanteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobanteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobanteDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxValcambioCcod as Variant
		llRetorno = .t.
		lxValcambioCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.VALCAMBIO where "Ccod" = <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'">> and  VALCAMBIO.CCOD != ''
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario" from ZooLogic.VALCAMBIO where  VALCAMBIO.CCOD != '' order by CCOD
			endtext
			use in select('c_VALEDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALEDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Ccodcompd" as "Codigocomprobantedestino", "Ctipcd" as "Tipodecomprobantedestino", "Cletd" as "Letradestino", "Cptovtad" as "Puntodeventadestino", "Cnumd" as "Numerodestino", "Ccompdes" as "Comprobantedestino", "Ccliented" as "Clientedestino", "Cfchdest" as "Fechadestino", "Cmonto" as "Monto", "Cseried" as "Seriedestino", "Cusuariod" as "Usuariodestino", "Cbddest" as "Bddestino", "Csignod" as "Signodemovimientodestino" from ZooLogic.VALCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_VALEDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobanteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobanteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobanteDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario" from ZooLogic.VALCAMBIO where  funciones.padr( CCOD, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VALCAMBIO.CCOD != '' order by CCOD
			endtext
			use in select('c_VALEDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALEDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Ccodcompd" as "Codigocomprobantedestino", "Ctipcd" as "Tipodecomprobantedestino", "Cletd" as "Letradestino", "Cptovtad" as "Puntodeventadestino", "Cnumd" as "Numerodestino", "Ccompdes" as "Comprobantedestino", "Ccliented" as "Clientedestino", "Cfchdest" as "Fechadestino", "Cmonto" as "Monto", "Cseried" as "Seriedestino", "Cusuariod" as "Usuariodestino", "Cbddest" as "Bddestino", "Csignod" as "Signodemovimientodestino" from ZooLogic.VALCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_VALEDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobanteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobanteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobanteDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario" from ZooLogic.VALCAMBIO where  funciones.padr( CCOD, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  VALCAMBIO.CCOD != '' order by CCOD desc
			endtext
			use in select('c_VALEDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALEDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Ccodcompd" as "Codigocomprobantedestino", "Ctipcd" as "Tipodecomprobantedestino", "Cletd" as "Letradestino", "Cptovtad" as "Puntodeventadestino", "Cnumd" as "Numerodestino", "Ccompdes" as "Comprobantedestino", "Ccliented" as "Clientedestino", "Cfchdest" as "Fechadestino", "Cmonto" as "Monto", "Cseried" as "Seriedestino", "Cusuariod" as "Usuariodestino", "Cbddest" as "Bddestino", "Csignod" as "Signodemovimientodestino" from ZooLogic.VALCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_VALEDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobanteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobanteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobanteDetalle
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
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario" from ZooLogic.VALCAMBIO where  VALCAMBIO.CCOD != '' order by CCOD desc
			endtext
			use in select('c_VALEDECAMBIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALEDECAMBIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Ccodcompd" as "Codigocomprobantedestino", "Ctipcd" as "Tipodecomprobantedestino", "Cletd" as "Letradestino", "Cptovtad" as "Puntodeventadestino", "Cnumd" as "Numerodestino", "Ccompdes" as "Comprobantedestino", "Ccliented" as "Clientedestino", "Cfchdest" as "Fechadestino", "Cmonto" as "Monto", "Cseried" as "Seriedestino", "Cusuariod" as "Usuariodestino", "Cbddest" as "Bddestino", "Csignod" as "Signodemovimientodestino" from ZooLogic.VALCAMBIODET where Codigo = <<"'" + this.FormatearTextoSql( c_VALEDECAMBIO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobanteDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobanteDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobanteDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Cfecha,Ctipcd,Saldo,Ctipc,Bdmodifw,Esttrans,Haltafw" + ;
",Saltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Smodifw,Ualtafw,Horaimpo,Bdaltafw,Hmodifw,Horaexpo,Ccodcompd" + ;
",Ccliented,Ccodcomp,Ccliente,Cseried,Articulo,Cserie,Chora,Cobss,Cfechavenc,Ccompori,Ccompdes,Cletd," + ;
"Clet,Cusuariod,Cusuario,Ccod,Cfchdest,Cfchorig,Cptovtad,Ptoventa,Cptovta,Cbddest,Cbdorig,Numero,Cnum" + ;
"d,Cnum,Cmonto,Tipo,Reutiliza,Valor,Email,Csignod,Csigno,Moneda" + ;
" from ZooLogic.VALCAMBIO where  VALCAMBIO.CCOD != '' and " + lcFiltro )
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
			local  lxValcambioFecexpo, lxValcambioFaltafw, lxValcambioFecimpo, lxValcambioFectrans, lxValcambioFmodifw, lxValcambioCfecha, lxValcambioCtipcd, lxValcambioSaldo, lxValcambioCtipc, lxValcambioBdmodifw, lxValcambioEsttrans, lxValcambioHaltafw, lxValcambioSaltafw, lxValcambioValtafw, lxValcambioZadsfw, lxValcambioVmodifw, lxValcambioUmodifw, lxValcambioSmodifw, lxValcambioUaltafw, lxValcambioHoraimpo, lxValcambioBdaltafw, lxValcambioHmodifw, lxValcambioHoraexpo, lxValcambioCcodcompd, lxValcambioCcliented, lxValcambioCcodcomp, lxValcambioCcliente, lxValcambioCseried, lxValcambioArticulo, lxValcambioCserie, lxValcambioChora, lxValcambioCobss, lxValcambioCfechavenc, lxValcambioCcompori, lxValcambioCcompdes, lxValcambioCletd, lxValcambioClet, lxValcambioCusuariod, lxValcambioCusuario, lxValcambioCcod, lxValcambioCfchdest, lxValcambioCfchorig, lxValcambioCptovtad, lxValcambioPtoventa, lxValcambioCptovta, lxValcambioCbddest, lxValcambioCbdorig, lxValcambioNumero, lxValcambioCnumd, lxValcambioCnum, lxValcambioCmonto, lxValcambioTipo, lxValcambioReutiliza, lxValcambioValor, lxValcambioEmail, lxValcambioCsignod, lxValcambioCsigno, lxValcambioMoneda
				lxValcambioFecexpo = ctod( '  /  /    ' )			lxValcambioFaltafw = ctod( '  /  /    ' )			lxValcambioFecimpo = ctod( '  /  /    ' )			lxValcambioFectrans = ctod( '  /  /    ' )			lxValcambioFmodifw = ctod( '  /  /    ' )			lxValcambioCfecha = ctod( '  /  /    ' )			lxValcambioCtipcd = 0			lxValcambioSaldo = 0			lxValcambioCtipc = 0			lxValcambioBdmodifw = []			lxValcambioEsttrans = []			lxValcambioHaltafw = []			lxValcambioSaltafw = []			lxValcambioValtafw = []			lxValcambioZadsfw = []			lxValcambioVmodifw = []			lxValcambioUmodifw = []			lxValcambioSmodifw = []			lxValcambioUaltafw = []			lxValcambioHoraimpo = []			lxValcambioBdaltafw = []			lxValcambioHmodifw = []			lxValcambioHoraexpo = []			lxValcambioCcodcompd = []			lxValcambioCcliented = []			lxValcambioCcodcomp = []			lxValcambioCcliente = []			lxValcambioCseried = []			lxValcambioArticulo = []			lxValcambioCserie = []			lxValcambioChora = []			lxValcambioCobss = []			lxValcambioCfechavenc = ctod( '  /  /    ' )			lxValcambioCcompori = []			lxValcambioCcompdes = []			lxValcambioCletd = []			lxValcambioClet = []			lxValcambioCusuariod = []			lxValcambioCusuario = []			lxValcambioCcod = []			lxValcambioCfchdest = ctod( '  /  /    ' )			lxValcambioCfchorig = ctod( '  /  /    ' )			lxValcambioCptovtad = 0			lxValcambioPtoventa = 0			lxValcambioCptovta = 0			lxValcambioCbddest = []			lxValcambioCbdorig = []			lxValcambioNumero = 0			lxValcambioCnumd = 0			lxValcambioCnum = 0			lxValcambioCmonto = 0			lxValcambioTipo = []			lxValcambioReutiliza = .F.			lxValcambioValor = []			lxValcambioEmail = []			lxValcambioCsignod = 0			lxValcambioCsigno = 0			lxValcambioMoneda = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VALCAMBIODET where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.VALCAMBIO where "CCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'VALCAMBIO' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VALCAMBIO.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VALCAMBIO', '', tnTope )
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
	Function ObtenerDatosDetalleComprobanteDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VALCAMBIODET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Ccodcompd" as "Codigocomprobantedestino", "Ctipcd" as "Tipodecomprobantedestino", "Cletd" as "Letradestino", "Cptovtad" as "Puntodeventadestino", "Cnumd" as "Numerodestino", "Ccompdes" as "Comprobantedestino", "Ccliented" as "Clientedestino", "Cfchdest" as "Fechadestino", "Cmonto" as "Monto", "Cseried" as "Seriedestino", "Cusuariod" as "Usuariodestino", "Cbddest" as "Bddestino", "Csignod" as "Signodemovimientodestino"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleComprobanteDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VALCAMBIODET', 'ComprobanteDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleComprobanteDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleComprobanteDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHA AS FECHA'
				Case lcAtributo == 'TIPODECOMPROBANTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPCD AS TIPODECOMPROBANTEDESTINO'
				Case lcAtributo == 'SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALDO AS SALDO'
				Case lcAtributo == 'TIPODECOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPC AS TIPODECOMPROBANTEORIGEN'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'CODIGOCOMPROBANTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMPD AS CODIGOCOMPROBANTEDESTINO'
				Case lcAtributo == 'CLIENTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCLIENTED AS CLIENTEDESTINO'
				Case lcAtributo == 'CODIGOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMP AS CODIGOCOMPROBANTEORIGEN'
				Case lcAtributo == 'CLIENTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCLIENTE AS CLIENTEORIGEN'
				Case lcAtributo == 'SERIEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIED AS SERIEDESTINO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTICULO AS ARTICULO'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIE AS SERIEORIGEN'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHORA AS HORA'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBSS AS OBS'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAVENC AS FECHAVENCIMIENTO'
				Case lcAtributo == 'COMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOMPORI AS COMPROBANTEORIGEN'
				Case lcAtributo == 'COMPROBANTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOMPDES AS COMPROBANTEDESTINO'
				Case lcAtributo == 'LETRADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLETD AS LETRADESTINO'
				Case lcAtributo == 'LETRAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLET AS LETRAORIGEN'
				Case lcAtributo == 'USUARIODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUSUARIOD AS USUARIODESTINO'
				Case lcAtributo == 'USUARIOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUSUARIO AS USUARIOORIGEN'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'FECHADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFCHDEST AS FECHADESTINO'
				Case lcAtributo == 'FECHAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFCHORIG AS FECHAORIGEN'
				Case lcAtributo == 'PUNTODEVENTADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTOVTAD AS PUNTODEVENTADESTINO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'PUNTODEVENTAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTOVTA AS PUNTODEVENTAORIGEN'
				Case lcAtributo == 'BDDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDDEST AS BDDESTINO'
				Case lcAtributo == 'BDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDORIG AS BDORIGEN'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'NUMERODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUMD AS NUMERODESTINO'
				Case lcAtributo == 'NUMEROORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUM AS NUMEROORIGEN'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONTO AS MONTO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'REUTILIZABLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REUTILIZA AS REUTILIZABLE'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALOR AS VALOR'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMAIL AS EMAIL'
				Case lcAtributo == 'SIGNODEMOVIMIENTODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSIGNOD AS SIGNODEMOVIMIENTODESTINO'
				Case lcAtributo == 'SIGNODEMOVIMIENTOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSIGNO AS SIGNODEMOVIMIENTOORIGEN'
				Case lcAtributo == 'SIMBOLOMONETARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS SIMBOLOMONETARIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleComprobanteDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOCOMPROBANTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMPD AS CODIGOCOMPROBANTEDESTINO'
				Case lcAtributo == 'TIPODECOMPROBANTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPCD AS TIPODECOMPROBANTEDESTINO'
				Case lcAtributo == 'LETRADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLETD AS LETRADESTINO'
				Case lcAtributo == 'PUNTODEVENTADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTOVTAD AS PUNTODEVENTADESTINO'
				Case lcAtributo == 'NUMERODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUMD AS NUMERODESTINO'
				Case lcAtributo == 'COMPROBANTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOMPDES AS COMPROBANTEDESTINO'
				Case lcAtributo == 'CLIENTEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCLIENTED AS CLIENTEDESTINO'
				Case lcAtributo == 'FECHADESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFCHDEST AS FECHADESTINO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONTO AS MONTO'
				Case lcAtributo == 'SERIEDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIED AS SERIEDESTINO'
				Case lcAtributo == 'USUARIODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUSUARIOD AS USUARIODESTINO'
				Case lcAtributo == 'BDDESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDDEST AS BDDESTINO'
				Case lcAtributo == 'SIGNODEMOVIMIENTODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSIGNOD AS SIGNODEMOVIMIENTODESTINO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'CFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEDESTINO'
				lcCampo = 'CTIPCD'
			Case upper( alltrim( tcAtributo ) ) == 'SALDO'
				lcCampo = 'SALDO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEORIGEN'
				lcCampo = 'CTIPC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEDESTINO'
				lcCampo = 'CCODCOMPD'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESTINO'
				lcCampo = 'CCLIENTED'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEORIGEN'
				lcCampo = 'CCODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEORIGEN'
				lcCampo = 'CCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEDESTINO'
				lcCampo = 'CSERIED'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'ARTICULO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'CSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'CHORA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBSS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'CFECHAVENC'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEORIGEN'
				lcCampo = 'CCOMPORI'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEDESTINO'
				lcCampo = 'CCOMPDES'
			Case upper( alltrim( tcAtributo ) ) == 'LETRADESTINO'
				lcCampo = 'CLETD'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAORIGEN'
				lcCampo = 'CLET'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIODESTINO'
				lcCampo = 'CUSUARIOD'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOORIGEN'
				lcCampo = 'CUSUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESTINO'
				lcCampo = 'CFCHDEST'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGEN'
				lcCampo = 'CFCHORIG'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTADESTINO'
				lcCampo = 'CPTOVTAD'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAORIGEN'
				lcCampo = 'CPTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'BDDESTINO'
				lcCampo = 'CBDDEST'
			Case upper( alltrim( tcAtributo ) ) == 'BDORIGEN'
				lcCampo = 'CBDORIG'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODESTINO'
				lcCampo = 'CNUMD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORIGEN'
				lcCampo = 'CNUM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'CMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'REUTILIZABLE'
				lcCampo = 'REUTILIZA'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'VALOR'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'EMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTODESTINO'
				lcCampo = 'CSIGNOD'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTOORIGEN'
				lcCampo = 'CSIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIO'
				lcCampo = 'MONEDA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleComprobanteDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEDESTINO'
				lcCampo = 'CCODCOMPD'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEDESTINO'
				lcCampo = 'CTIPCD'
			Case upper( alltrim( tcAtributo ) ) == 'LETRADESTINO'
				lcCampo = 'CLETD'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTADESTINO'
				lcCampo = 'CPTOVTAD'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODESTINO'
				lcCampo = 'CNUMD'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEDESTINO'
				lcCampo = 'CCOMPDES'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESTINO'
				lcCampo = 'CCLIENTED'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESTINO'
				lcCampo = 'CFCHDEST'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'CMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEDESTINO'
				lcCampo = 'CSERIED'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIODESTINO'
				lcCampo = 'CUSUARIOD'
			Case upper( alltrim( tcAtributo ) ) == 'BDDESTINO'
				lcCampo = 'CBDDEST'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTODESTINO'
				lcCampo = 'CSIGNOD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMPROBANTEDETALLE'
			lcRetorno = 'VALCAMBIODET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxValcambioFecexpo, lxValcambioFaltafw, lxValcambioFecimpo, lxValcambioFectrans, lxValcambioFmodifw, lxValcambioCfecha, lxValcambioCtipcd, lxValcambioSaldo, lxValcambioCtipc, lxValcambioBdmodifw, lxValcambioEsttrans, lxValcambioHaltafw, lxValcambioSaltafw, lxValcambioValtafw, lxValcambioZadsfw, lxValcambioVmodifw, lxValcambioUmodifw, lxValcambioSmodifw, lxValcambioUaltafw, lxValcambioHoraimpo, lxValcambioBdaltafw, lxValcambioHmodifw, lxValcambioHoraexpo, lxValcambioCcodcompd, lxValcambioCcliented, lxValcambioCcodcomp, lxValcambioCcliente, lxValcambioCseried, lxValcambioArticulo, lxValcambioCserie, lxValcambioChora, lxValcambioCobss, lxValcambioCfechavenc, lxValcambioCcompori, lxValcambioCcompdes, lxValcambioCletd, lxValcambioClet, lxValcambioCusuariod, lxValcambioCusuario, lxValcambioCcod, lxValcambioCfchdest, lxValcambioCfchorig, lxValcambioCptovtad, lxValcambioPtoventa, lxValcambioCptovta, lxValcambioCbddest, lxValcambioCbdorig, lxValcambioNumero, lxValcambioCnumd, lxValcambioCnum, lxValcambioCmonto, lxValcambioTipo, lxValcambioReutiliza, lxValcambioValor, lxValcambioEmail, lxValcambioCsignod, lxValcambioCsigno, lxValcambioMoneda
				lxValcambioFecexpo =  .Fechaexpo			lxValcambioFaltafw =  .Fechaaltafw			lxValcambioFecimpo =  .Fechaimpo			lxValcambioFectrans =  .Fechatransferencia			lxValcambioFmodifw =  .Fechamodificacionfw			lxValcambioCfecha =  .Fecha			lxValcambioCtipcd =  .Tipodecomprobantedestino			lxValcambioSaldo =  .Saldo			lxValcambioCtipc =  .Tipodecomprobanteorigen			lxValcambioBdmodifw =  .Basededatosmodificacionfw			lxValcambioEsttrans =  .Estadotransferencia			lxValcambioHaltafw =  .Horaaltafw			lxValcambioSaltafw =  .Seriealtafw			lxValcambioValtafw =  .Versionaltafw			lxValcambioZadsfw =  .Zadsfw			lxValcambioVmodifw =  .Versionmodificacionfw			lxValcambioUmodifw =  .Usuariomodificacionfw			lxValcambioSmodifw =  .Seriemodificacionfw			lxValcambioUaltafw =  .Usuarioaltafw			lxValcambioHoraimpo =  .Horaimpo			lxValcambioBdaltafw =  .Basededatosaltafw			lxValcambioHmodifw =  .Horamodificacionfw			lxValcambioHoraexpo =  .Horaexpo			lxValcambioCcodcompd =  .Codigocomprobantedestino			lxValcambioCcliented =  .Clientedestino			lxValcambioCcodcomp =  .Codigocomprobanteorigen			lxValcambioCcliente =  .Clienteorigen			lxValcambioCseried =  .Seriedestino			lxValcambioArticulo =  .Articulo			lxValcambioCserie =  .Serieorigen			lxValcambioChora =  .Hora			lxValcambioCobss =  .Obs			lxValcambioCfechavenc =  .Fechavencimiento			lxValcambioCcompori =  .Comprobanteorigen			lxValcambioCcompdes =  .Comprobantedestino			lxValcambioCletd =  .Letradestino			lxValcambioClet =  .Letraorigen			lxValcambioCusuariod =  .Usuariodestino			lxValcambioCusuario =  .Usuarioorigen			lxValcambioCcod =  .Codigo			lxValcambioCfchdest =  .Fechadestino			lxValcambioCfchorig =  .Fechaorigen			lxValcambioCptovtad =  .Puntodeventadestino			lxValcambioPtoventa =  .Puntodeventa			lxValcambioCptovta =  .Puntodeventaorigen			lxValcambioCbddest =  .Bddestino			lxValcambioCbdorig =  .Bdorigen			lxValcambioNumero =  .Numero			lxValcambioCnumd =  .Numerodestino			lxValcambioCnum =  .Numeroorigen			lxValcambioCmonto =  .Monto			lxValcambioTipo =  .Tipo			lxValcambioReutiliza =  .Reutilizable			lxValcambioValor =  .Valor			lxValcambioEmail =  .Email			lxValcambioCsignod =  .Signodemovimientodestino			lxValcambioCsigno =  .Signodemovimientoorigen			lxValcambioMoneda =  .Simbolomonetario
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.VALCAMBIO ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Cfecha","Ctipcd","Saldo","Ctipc","Bdmodifw","Esttrans","Haltafw","Saltafw","Valtafw","Zadsfw","Vmodifw","Umodifw","Smodifw","Ualtafw","Horaimpo","Bdaltafw","Hmodifw","Horaexpo","Ccodcompd","Ccliented","Ccodcomp","Ccliente","Cseried","Articulo","Cserie","Chora","Cobss","Cfechavenc","Ccompori","Ccompdes","Cletd","Clet","Cusuariod","Cusuario","Ccod","Cfchdest","Cfchorig","Cptovtad","Ptoventa","Cptovta","Cbddest","Cbdorig","Numero","Cnumd","Cnum","Cmonto","Tipo","Reutiliza","Valor","Email","Csignod","Csigno","Moneda" ) values ( <<"'" + this.ConvertirDateSql( lxValcambioFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfecha ) + "'" >>, <<lxValcambioCtipcd >>, <<lxValcambioSaldo >>, <<lxValcambioCtipc >>, <<"'" + this.FormatearTextoSql( lxValcambioBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcodcompd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcliented ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCseried ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioArticulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioChora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCobss ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfechavenc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcompori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcompdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCletd ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioClet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCusuariod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCusuario ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfchdest ) + "'" >>, <<"'" + this.ConvertirDateSql( lxValcambioCfchorig ) + "'" >>, <<lxValcambioCptovtad >>, <<lxValcambioPtoventa >>, <<lxValcambioCptovta >>, <<"'" + this.FormatearTextoSql( lxValcambioCbddest ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioCbdorig ) + "'" >>, <<lxValcambioNumero >>, <<lxValcambioCnumd >>, <<lxValcambioCnum >>, <<lxValcambioCmonto >>, <<"'" + this.FormatearTextoSql( lxValcambioTipo ) + "'" >>, <<iif( lxValcambioReutiliza, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxValcambioValor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxValcambioEmail ) + "'" >>, <<lxValcambioCsignod >>, <<lxValcambioCsigno >>, <<"'" + this.FormatearTextoSql( lxValcambioMoneda ) + "'" >> )
		endtext
		loColeccion.cTabla = 'VALCAMBIO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobanteDetalle
				if this.oEntidad.ComprobanteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigocomprobantedestino = loItem.Codigocomprobantedestino
					lxTipodecomprobantedestino = loItem.Tipodecomprobantedestino
					lxLetradestino = loItem.Letradestino
					lxPuntodeventadestino = loItem.Puntodeventadestino
					lxNumerodestino = loItem.Numerodestino
					lxComprobantedestino = loItem.Comprobantedestino
					lxClientedestino = loItem.Clientedestino
					lxFechadestino = loItem.Fechadestino
					lxMonto = loItem.Monto
					lxSeriedestino = loItem.Seriedestino
					lxUsuariodestino = loItem.Usuariodestino
					lxBddestino = loItem.Bddestino
					lxSignodemovimientodestino = loItem.Signodemovimientodestino
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VALCAMBIODET("NROITEM","Codigo","CCodCompd","cTipCd","cletd","cptovtad","cnumd","CCompDes","cClienteD","CFchDest","CMonto","CSerieD","CUsuarioD","CBDDest","cSignod" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigocomprobantedestino ) + "'">>, <<lxTipodecomprobantedestino>>, <<"'" + this.FormatearTextoSql( lxLetradestino ) + "'">>, <<lxPuntodeventadestino>>, <<lxNumerodestino>>, <<"'" + this.FormatearTextoSql( lxComprobantedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedestino ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechadestino ) + "'">>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxSeriedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxUsuariodestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxBddestino ) + "'">>, <<lxSignodemovimientodestino>> ) 
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
			local  lxValcambioFecexpo, lxValcambioFaltafw, lxValcambioFecimpo, lxValcambioFectrans, lxValcambioFmodifw, lxValcambioCfecha, lxValcambioCtipcd, lxValcambioSaldo, lxValcambioCtipc, lxValcambioBdmodifw, lxValcambioEsttrans, lxValcambioHaltafw, lxValcambioSaltafw, lxValcambioValtafw, lxValcambioZadsfw, lxValcambioVmodifw, lxValcambioUmodifw, lxValcambioSmodifw, lxValcambioUaltafw, lxValcambioHoraimpo, lxValcambioBdaltafw, lxValcambioHmodifw, lxValcambioHoraexpo, lxValcambioCcodcompd, lxValcambioCcliented, lxValcambioCcodcomp, lxValcambioCcliente, lxValcambioCseried, lxValcambioArticulo, lxValcambioCserie, lxValcambioChora, lxValcambioCobss, lxValcambioCfechavenc, lxValcambioCcompori, lxValcambioCcompdes, lxValcambioCletd, lxValcambioClet, lxValcambioCusuariod, lxValcambioCusuario, lxValcambioCcod, lxValcambioCfchdest, lxValcambioCfchorig, lxValcambioCptovtad, lxValcambioPtoventa, lxValcambioCptovta, lxValcambioCbddest, lxValcambioCbdorig, lxValcambioNumero, lxValcambioCnumd, lxValcambioCnum, lxValcambioCmonto, lxValcambioTipo, lxValcambioReutiliza, lxValcambioValor, lxValcambioEmail, lxValcambioCsignod, lxValcambioCsigno, lxValcambioMoneda
				lxValcambioFecexpo =  .Fechaexpo			lxValcambioFaltafw =  .Fechaaltafw			lxValcambioFecimpo =  .Fechaimpo			lxValcambioFectrans =  .Fechatransferencia			lxValcambioFmodifw =  .Fechamodificacionfw			lxValcambioCfecha =  .Fecha			lxValcambioCtipcd =  .Tipodecomprobantedestino			lxValcambioSaldo =  .Saldo			lxValcambioCtipc =  .Tipodecomprobanteorigen			lxValcambioBdmodifw =  .Basededatosmodificacionfw			lxValcambioEsttrans =  .Estadotransferencia			lxValcambioHaltafw =  .Horaaltafw			lxValcambioSaltafw =  .Seriealtafw			lxValcambioValtafw =  .Versionaltafw			lxValcambioZadsfw =  .Zadsfw			lxValcambioVmodifw =  .Versionmodificacionfw			lxValcambioUmodifw =  .Usuariomodificacionfw			lxValcambioSmodifw =  .Seriemodificacionfw			lxValcambioUaltafw =  .Usuarioaltafw			lxValcambioHoraimpo =  .Horaimpo			lxValcambioBdaltafw =  .Basededatosaltafw			lxValcambioHmodifw =  .Horamodificacionfw			lxValcambioHoraexpo =  .Horaexpo			lxValcambioCcodcompd =  .Codigocomprobantedestino			lxValcambioCcliented =  .Clientedestino			lxValcambioCcodcomp =  .Codigocomprobanteorigen			lxValcambioCcliente =  .Clienteorigen			lxValcambioCseried =  .Seriedestino			lxValcambioArticulo =  .Articulo			lxValcambioCserie =  .Serieorigen			lxValcambioChora =  .Hora			lxValcambioCobss =  .Obs			lxValcambioCfechavenc =  .Fechavencimiento			lxValcambioCcompori =  .Comprobanteorigen			lxValcambioCcompdes =  .Comprobantedestino			lxValcambioCletd =  .Letradestino			lxValcambioClet =  .Letraorigen			lxValcambioCusuariod =  .Usuariodestino			lxValcambioCusuario =  .Usuarioorigen			lxValcambioCcod =  .Codigo			lxValcambioCfchdest =  .Fechadestino			lxValcambioCfchorig =  .Fechaorigen			lxValcambioCptovtad =  .Puntodeventadestino			lxValcambioPtoventa =  .Puntodeventa			lxValcambioCptovta =  .Puntodeventaorigen			lxValcambioCbddest =  .Bddestino			lxValcambioCbdorig =  .Bdorigen			lxValcambioNumero =  .Numero			lxValcambioCnumd =  .Numerodestino			lxValcambioCnum =  .Numeroorigen			lxValcambioCmonto =  .Monto			lxValcambioTipo =  .Tipo			lxValcambioReutiliza =  .Reutilizable			lxValcambioValor =  .Valor			lxValcambioEmail =  .Email			lxValcambioCsignod =  .Signodemovimientodestino			lxValcambioCsigno =  .Signodemovimientoorigen			lxValcambioMoneda =  .Simbolomonetario
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  VALCAMBIO.CCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.VALCAMBIO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxValcambioFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxValcambioFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxValcambioFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxValcambioFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxValcambioFmodifw ) + "'">>, "Cfecha" = <<"'" + this.ConvertirDateSql( lxValcambioCfecha ) + "'">>, "Ctipcd" = <<lxValcambioCtipcd>>, "Saldo" = <<lxValcambioSaldo>>, "Ctipc" = <<lxValcambioCtipc>>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxValcambioBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxValcambioEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxValcambioHaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxValcambioSaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxValcambioValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxValcambioZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxValcambioVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxValcambioUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxValcambioSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxValcambioUaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxValcambioHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxValcambioBdaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxValcambioHmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxValcambioHoraexpo ) + "'">>, "Ccodcompd" = <<"'" + this.FormatearTextoSql( lxValcambioCcodcompd ) + "'">>, "Ccliented" = <<"'" + this.FormatearTextoSql( lxValcambioCcliented ) + "'">>, "Ccodcomp" = <<"'" + this.FormatearTextoSql( lxValcambioCcodcomp ) + "'">>, "Ccliente" = <<"'" + this.FormatearTextoSql( lxValcambioCcliente ) + "'">>, "Cseried" = <<"'" + this.FormatearTextoSql( lxValcambioCseried ) + "'">>, "Articulo" = <<"'" + this.FormatearTextoSql( lxValcambioArticulo ) + "'">>, "Cserie" = <<"'" + this.FormatearTextoSql( lxValcambioCserie ) + "'">>, "Chora" = <<"'" + this.FormatearTextoSql( lxValcambioChora ) + "'">>, "Cobss" = <<"'" + this.FormatearTextoSql( lxValcambioCobss ) + "'">>, "Cfechavenc" = <<"'" + this.ConvertirDateSql( lxValcambioCfechavenc ) + "'">>, "Ccompori" = <<"'" + this.FormatearTextoSql( lxValcambioCcompori ) + "'">>, "Ccompdes" = <<"'" + this.FormatearTextoSql( lxValcambioCcompdes ) + "'">>, "Cletd" = <<"'" + this.FormatearTextoSql( lxValcambioCletd ) + "'">>, "Clet" = <<"'" + this.FormatearTextoSql( lxValcambioClet ) + "'">>, "Cusuariod" = <<"'" + this.FormatearTextoSql( lxValcambioCusuariod ) + "'">>, "Cusuario" = <<"'" + this.FormatearTextoSql( lxValcambioCusuario ) + "'">>, "Ccod" = <<"'" + this.FormatearTextoSql( lxValcambioCcod ) + "'">>, "Cfchdest" = <<"'" + this.ConvertirDateSql( lxValcambioCfchdest ) + "'">>, "Cfchorig" = <<"'" + this.ConvertirDateSql( lxValcambioCfchorig ) + "'">>, "Cptovtad" = <<lxValcambioCptovtad>>, "Ptoventa" = <<lxValcambioPtoventa>>, "Cptovta" = <<lxValcambioCptovta>>, "Cbddest" = <<"'" + this.FormatearTextoSql( lxValcambioCbddest ) + "'">>, "Cbdorig" = <<"'" + this.FormatearTextoSql( lxValcambioCbdorig ) + "'">>, "Numero" = <<lxValcambioNumero>>, "Cnumd" = <<lxValcambioCnumd>>, "Cnum" = <<lxValcambioCnum>>, "Cmonto" = <<lxValcambioCmonto>>, "Tipo" = <<"'" + this.FormatearTextoSql( lxValcambioTipo ) + "'">>, "Reutiliza" = <<iif( lxValcambioReutiliza, 1, 0 )>>, "Valor" = <<"'" + this.FormatearTextoSql( lxValcambioValor ) + "'">>, "Email" = <<"'" + this.FormatearTextoSql( lxValcambioEmail ) + "'">>, "Csignod" = <<lxValcambioCsignod>>, "Csigno" = <<lxValcambioCsigno>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxValcambioMoneda ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'VALCAMBIO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.VALCAMBIODET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobanteDetalle
				if this.oEntidad.ComprobanteDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCodigocomprobantedestino = loItem.Codigocomprobantedestino
					lxTipodecomprobantedestino = loItem.Tipodecomprobantedestino
					lxLetradestino = loItem.Letradestino
					lxPuntodeventadestino = loItem.Puntodeventadestino
					lxNumerodestino = loItem.Numerodestino
					lxComprobantedestino = loItem.Comprobantedestino
					lxClientedestino = loItem.Clientedestino
					lxFechadestino = loItem.Fechadestino
					lxMonto = loItem.Monto
					lxSeriedestino = loItem.Seriedestino
					lxUsuariodestino = loItem.Usuariodestino
					lxBddestino = loItem.Bddestino
					lxSignodemovimientodestino = loItem.Signodemovimientodestino
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VALCAMBIODET("NROITEM","Codigo","CCodCompd","cTipCd","cletd","cptovtad","cnumd","CCompDes","cClienteD","CFchDest","CMonto","CSerieD","CUsuarioD","CBDDest","cSignod" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigocomprobantedestino ) + "'">>, <<lxTipodecomprobantedestino>>, <<"'" + this.FormatearTextoSql( lxLetradestino ) + "'">>, <<lxPuntodeventadestino>>, <<lxNumerodestino>>, <<"'" + this.FormatearTextoSql( lxComprobantedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedestino ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechadestino ) + "'">>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxSeriedestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxUsuariodestino ) + "'">>, <<"'" + this.FormatearTextoSql( lxBddestino ) + "'">>, <<lxSignodemovimientodestino>> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  VALCAMBIO.CCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.VALCAMBIO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.VALCAMBIODET where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'VALCAMBIO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.VALCAMBIO where  VALCAMBIO.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.VALCAMBIO where CCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  VALCAMBIO.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALEDECAMBIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.VALCAMBIO Where CCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.VALCAMBIO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, CFECHA = ] + "'" + this.ConvertirDateSql( &lcCursor..CFECHA ) + "'"+ [, cTipCd = ] + transform( &lcCursor..cTipCd )+ [, Saldo = ] + transform( &lcCursor..Saldo )+ [, cTipC = ] + transform( &lcCursor..cTipC )+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, cCodCompd = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodCompd ) + "'"+ [, cClienteD = ] + "'" + this.FormatearTextoSql( &lcCursor..cClienteD ) + "'"+ [, cCodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodComp ) + "'"+ [, cCliente = ] + "'" + this.FormatearTextoSql( &lcCursor..cCliente ) + "'"+ [, CSERIED = ] + "'" + this.FormatearTextoSql( &lcCursor..CSERIED ) + "'"+ [, Articulo = ] + "'" + this.FormatearTextoSql( &lcCursor..Articulo ) + "'"+ [, CSERIE = ] + "'" + this.FormatearTextoSql( &lcCursor..CSERIE ) + "'"+ [, CHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..CHORA ) + "'"+ [, COBSS = ] + "'" + this.FormatearTextoSql( &lcCursor..COBSS ) + "'"+ [, CFECHAVENC = ] + "'" + this.ConvertirDateSql( &lcCursor..CFECHAVENC ) + "'"+ [, CCOMPORI = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOMPORI ) + "'"+ [, CCOMPDES = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOMPDES ) + "'"+ [, cletd = ] + "'" + this.FormatearTextoSql( &lcCursor..cletd ) + "'"+ [, clet = ] + "'" + this.FormatearTextoSql( &lcCursor..clet ) + "'"+ [, CUSUARIOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CUSUARIOD ) + "'"+ [, CUSUARIO = ] + "'" + this.FormatearTextoSql( &lcCursor..CUSUARIO ) + "'"+ [, CCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOD ) + "'"+ [, CFCHDEST = ] + "'" + this.ConvertirDateSql( &lcCursor..CFCHDEST ) + "'"+ [, CFCHORIG = ] + "'" + this.ConvertirDateSql( &lcCursor..CFCHORIG ) + "'"+ [, cptovtad = ] + transform( &lcCursor..cptovtad )+ [, ptoventa = ] + transform( &lcCursor..ptoventa )+ [, cptovta = ] + transform( &lcCursor..cptovta )+ [, CBDDEST = ] + "'" + this.FormatearTextoSql( &lcCursor..CBDDEST ) + "'"+ [, CBDORIG = ] + "'" + this.FormatearTextoSql( &lcCursor..CBDORIG ) + "'"+ [, numero = ] + transform( &lcCursor..numero )+ [, cnumd = ] + transform( &lcCursor..cnumd )+ [, cnum = ] + transform( &lcCursor..cnum )+ [, CMONTO = ] + transform( &lcCursor..CMONTO )+ [, Tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..Tipo ) + "'"+ [, Reutiliza = ] + Transform( iif( &lcCursor..Reutiliza, 1, 0 ))+ [, Valor = ] + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'"+ [, email = ] + "'" + this.FormatearTextoSql( &lcCursor..email ) + "'"+ [, cSignod = ] + transform( &lcCursor..cSignod )+ [, cSigno = ] + transform( &lcCursor..cSigno )+ [, MONEDA = ] + "'" + this.FormatearTextoSql( &lcCursor..MONEDA ) + "'" + [ Where CCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FECIMPO, FECTRANS, FMODIFW, CFECHA, cTipCd, Saldo, cTipC, BDMODIFW, ESTTRANS, HALTAFW, SALTAFW, VALTAFW, ZADSFW, VMODIFW, UMODIFW, SMODIFW, UALTAFW, HORAIMPO, BDALTAFW, HMODIFW, HORAEXPO, cCodCompd, cClienteD, cCodComp, cCliente, CSERIED, Articulo, CSERIE, CHORA, COBSS, CFECHAVENC, CCOMPORI, CCOMPDES, cletd, clet, CUSUARIOD, CUSUARIO, CCOD, CFCHDEST, CFCHORIG, cptovtad, ptoventa, cptovta, CBDDEST, CBDORIG, numero, cnumd, cnum, CMONTO, Tipo, Reutiliza, Valor, email, cSignod, cSigno, MONEDA
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CFECHA ) + "'" + ',' + transform( &lcCursor..cTipCd )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Saldo ) + ',' + transform( &lcCursor..cTipC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodCompd ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cClienteD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CSERIED ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Articulo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CSERIE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..COBSS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CFECHAVENC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCOMPORI ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCOMPDES ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cletd ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..clet ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CUSUARIOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CUSUARIO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCOD ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CFCHDEST ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..CFCHORIG ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..cptovtad ) + ',' + transform( &lcCursor..ptoventa ) + ',' + transform( &lcCursor..cptovta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBDDEST ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBDORIG ) + "'" + ',' + transform( &lcCursor..numero ) + ',' + transform( &lcCursor..cnumd ) + ',' + transform( &lcCursor..cnum ) + ',' + transform( &lcCursor..CMONTO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Tipo ) + "'" + ',' + Transform( iif( &lcCursor..Reutiliza, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Valor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..email ) + "'" + ',' + transform( &lcCursor..cSignod ) + ',' + transform( &lcCursor..cSigno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MONEDA ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.VALCAMBIO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALEDECAMBIO'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CCOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CCOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VALCAMBIODET Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALEDECAMBIO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","CCodCompd","cTipCd","cletd","cptovtad","cnumd","CCompDes","cClienteD","CFchDest","CMonto","CSerieD","CUsuarioD","CBDDest","cSignod"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.VALCAMBIODET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CCodCompd  ) + "'" + ',' + transform( cDetallesExistentes.cTipCd     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cletd      ) + "'" + ',' + transform( cDetallesExistentes.cptovtad   ) + ',' + transform( cDetallesExistentes.cnumd      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CCompDes   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cClienteD  ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.CFchDest   ) + "'" + ',' + transform( cDetallesExistentes.CMonto     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CSerieD    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CUsuarioD  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CBDDest    ) + "'" + ',' + transform( cDetallesExistentes.cSignod    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CCOD C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..CCOD       )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'VALEDECAMBIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VALEDECAMBIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VALEDECAMBIO_COBSS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALEDECAMBIO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_VALCAMBIO')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'VALEDECAMBIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad VALEDECAMBIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALEDECAMBIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALEDECAMBIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  CFECHA    
		* Validar ANTERIORES A 1/1/1753  CFECHAVENC
		* Validar ANTERIORES A 1/1/1753  CFCHDEST  
		* Validar ANTERIORES A 1/1/1753  CFCHORIG  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_VALCAMBIO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_VALCAMBIO
Create Table ZooLogic.TablaTrabajo_VALCAMBIO ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"cfecha" datetime  null, 
"ctipcd" numeric( 2, 0 )  null, 
"saldo" numeric( 15, 2 )  null, 
"ctipc" numeric( 2, 0 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"ccodcompd" char( 38 )  null, 
"ccliented" char( 200 )  null, 
"ccodcomp" char( 38 )  null, 
"ccliente" char( 200 )  null, 
"cseried" char( 10 )  null, 
"articulo" char( 15 )  null, 
"cserie" char( 10 )  null, 
"chora" char( 8 )  null, 
"cobss" varchar(max)  null, 
"cfechavenc" datetime  null, 
"ccompori" char( 50 )  null, 
"ccompdes" char( 50 )  null, 
"cletd" char( 1 )  null, 
"clet" char( 1 )  null, 
"cusuariod" char( 100 )  null, 
"cusuario" char( 100 )  null, 
"ccod" char( 38 )  null, 
"cfchdest" datetime  null, 
"cfchorig" datetime  null, 
"cptovtad" numeric( 4, 0 )  null, 
"ptoventa" numeric( 4, 0 )  null, 
"cptovta" numeric( 4, 0 )  null, 
"cbddest" char( 8 )  null, 
"cbdorig" char( 8 )  null, 
"numero" numeric( 8, 0 )  null, 
"cnumd" numeric( 8, 0 )  null, 
"cnum" numeric( 8, 0 )  null, 
"cmonto" numeric( 15, 2 )  null, 
"tipo" char( 15 )  null, 
"reutiliza" bit  null, 
"valor" char( 5 )  null, 
"email" char( 250 )  null, 
"csignod" numeric( 2, 0 )  null, 
"csigno" numeric( 2, 0 )  null, 
"moneda" char( 10 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_VALCAMBIO' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_VALCAMBIO' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALEDECAMBIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('cfecha','cfecha')
			.AgregarMapeo('ctipcd','ctipcd')
			.AgregarMapeo('saldo','saldo')
			.AgregarMapeo('ctipc','ctipc')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('ccodcompd','ccodcompd')
			.AgregarMapeo('ccliented','ccliented')
			.AgregarMapeo('ccodcomp','ccodcomp')
			.AgregarMapeo('ccliente','ccliente')
			.AgregarMapeo('cseried','cseried')
			.AgregarMapeo('articulo','articulo')
			.AgregarMapeo('cserie','cserie')
			.AgregarMapeo('chora','chora')
			.AgregarMapeo('cobss','cobss')
			.AgregarMapeo('cfechavenc','cfechavenc')
			.AgregarMapeo('ccompori','ccompori')
			.AgregarMapeo('ccompdes','ccompdes')
			.AgregarMapeo('cletd','cletd')
			.AgregarMapeo('clet','clet')
			.AgregarMapeo('cusuariod','cusuariod')
			.AgregarMapeo('cusuario','cusuario')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('cfchdest','cfchdest')
			.AgregarMapeo('cfchorig','cfchorig')
			.AgregarMapeo('cptovtad','cptovtad')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('cptovta','cptovta')
			.AgregarMapeo('cbddest','cbddest')
			.AgregarMapeo('cbdorig','cbdorig')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('cnumd','cnumd')
			.AgregarMapeo('cnum','cnum')
			.AgregarMapeo('cmonto','cmonto')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('reutiliza','reutiliza')
			.AgregarMapeo('valor','valor')
			.AgregarMapeo('email','email')
			.AgregarMapeo('csignod','csignod')
			.AgregarMapeo('csigno','csigno')
			.AgregarMapeo('moneda','moneda')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_VALCAMBIO'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.CFECHA = isnull( d.CFECHA, t.CFECHA ),t.CTIPCD = isnull( d.CTIPCD, t.CTIPCD ),t.SALDO = isnull( d.SALDO, t.SALDO ),t.CTIPC = isnull( d.CTIPC, t.CTIPC ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.CCODCOMPD = isnull( d.CCODCOMPD, t.CCODCOMPD ),t.CCLIENTED = isnull( d.CCLIENTED, t.CCLIENTED ),t.CCODCOMP = isnull( d.CCODCOMP, t.CCODCOMP ),t.CCLIENTE = isnull( d.CCLIENTE, t.CCLIENTE ),t.CSERIED = isnull( d.CSERIED, t.CSERIED ),t.ARTICULO = isnull( d.ARTICULO, t.ARTICULO ),t.CSERIE = isnull( d.CSERIE, t.CSERIE ),t.CHORA = isnull( d.CHORA, t.CHORA ),t.COBSS = isnull( d.COBSS, t.COBSS ),t.CFECHAVENC = isnull( d.CFECHAVENC, t.CFECHAVENC ),t.CCOMPORI = isnull( d.CCOMPORI, t.CCOMPORI ),t.CCOMPDES = isnull( d.CCOMPDES, t.CCOMPDES ),t.CLETD = isnull( d.CLETD, t.CLETD ),t.CLET = isnull( d.CLET, t.CLET ),t.CUSUARIOD = isnull( d.CUSUARIOD, t.CUSUARIOD ),t.CUSUARIO = isnull( d.CUSUARIO, t.CUSUARIO ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.CFCHDEST = isnull( d.CFCHDEST, t.CFCHDEST ),t.CFCHORIG = isnull( d.CFCHORIG, t.CFCHORIG ),t.CPTOVTAD = isnull( d.CPTOVTAD, t.CPTOVTAD ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.CPTOVTA = isnull( d.CPTOVTA, t.CPTOVTA ),t.CBDDEST = isnull( d.CBDDEST, t.CBDDEST ),t.CBDORIG = isnull( d.CBDORIG, t.CBDORIG ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.CNUMD = isnull( d.CNUMD, t.CNUMD ),t.CNUM = isnull( d.CNUM, t.CNUM ),t.CMONTO = isnull( d.CMONTO, t.CMONTO ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.REUTILIZA = isnull( d.REUTILIZA, t.REUTILIZA ),t.VALOR = isnull( d.VALOR, t.VALOR ),t.EMAIL = isnull( d.EMAIL, t.EMAIL ),t.CSIGNOD = isnull( d.CSIGNOD, t.CSIGNOD ),t.CSIGNO = isnull( d.CSIGNO, t.CSIGNO ),t.MONEDA = isnull( d.MONEDA, t.MONEDA )
					from ZooLogic.VALCAMBIO t inner join deleted d 
							 on t.CCOD = d.CCOD
				-- Fin Updates
				insert into ZooLogic.VALCAMBIO(Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Cfecha,Ctipcd,Saldo,Ctipc,Bdmodifw,Esttrans,Haltafw,Saltafw,Valtafw,Zadsfw,Vmodifw,Umodifw,Smodifw,Ualtafw,Horaimpo,Bdaltafw,Hmodifw,Horaexpo,Ccodcompd,Ccliented,Ccodcomp,Ccliente,Cseried,Articulo,Cserie,Chora,Cobss,Cfechavenc,Ccompori,Ccompdes,Cletd,Clet,Cusuariod,Cusuario,Ccod,Cfchdest,Cfchorig,Cptovtad,Ptoventa,Cptovta,Cbddest,Cbdorig,Numero,Cnumd,Cnum,Cmonto,Tipo,Reutiliza,Valor,Email,Csignod,Csigno,Moneda)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.CFECHA,''),isnull( d.CTIPCD,0),isnull( d.SALDO,0),isnull( d.CTIPC,0),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.SALTAFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.HMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.CCODCOMPD,''),isnull( d.CCLIENTED,''),isnull( d.CCODCOMP,''),isnull( d.CCLIENTE,''),isnull( d.CSERIED,''),isnull( d.ARTICULO,''),isnull( d.CSERIE,''),isnull( d.CHORA,''),isnull( d.COBSS,''),isnull( d.CFECHAVENC,''),isnull( d.CCOMPORI,''),isnull( d.CCOMPDES,''),isnull( d.CLETD,''),isnull( d.CLET,''),isnull( d.CUSUARIOD,''),isnull( d.CUSUARIO,''),isnull( d.CCOD,''),isnull( d.CFCHDEST,''),isnull( d.CFCHORIG,''),isnull( d.CPTOVTAD,0),isnull( d.PTOVENTA,0),isnull( d.CPTOVTA,0),isnull( d.CBDDEST,''),isnull( d.CBDORIG,''),isnull( d.NUMERO,0),isnull( d.CNUMD,0),isnull( d.CNUM,0),isnull( d.CMONTO,0),isnull( d.TIPO,''),isnull( d.REUTILIZA,0),isnull( d.VALOR,''),isnull( d.EMAIL,''),isnull( d.CSIGNOD,0),isnull( d.CSIGNO,0),isnull( d.MONEDA,'')
						From deleted d left join ZooLogic.VALCAMBIO pk 
							 on d.CCOD = pk.CCOD
						Where pk.CCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_VALCAMBIODET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_VALCAMBIO_VALCAMBIODET
ON ZooLogic.TablaTrabajo_VALCAMBIO_VALCAMBIODET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CCODCOMPD = isnull( d.CCODCOMPD, t.CCODCOMPD ),
t.CTIPCD = isnull( d.CTIPCD, t.CTIPCD ),
t.CLETD = isnull( d.CLETD, t.CLETD ),
t.CPTOVTAD = isnull( d.CPTOVTAD, t.CPTOVTAD ),
t.CNUMD = isnull( d.CNUMD, t.CNUMD ),
t.CCOMPDES = isnull( d.CCOMPDES, t.CCOMPDES ),
t.CCLIENTED = isnull( d.CCLIENTED, t.CCLIENTED ),
t.CFCHDEST = isnull( d.CFCHDEST, t.CFCHDEST ),
t.CMONTO = isnull( d.CMONTO, t.CMONTO ),
t.CSERIED = isnull( d.CSERIED, t.CSERIED ),
t.CUSUARIOD = isnull( d.CUSUARIOD, t.CUSUARIOD ),
t.CBDDEST = isnull( d.CBDDEST, t.CBDDEST ),
t.CSIGNOD = isnull( d.CSIGNOD, t.CSIGNOD )
from ZooLogic.VALCAMBIODET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.VALCAMBIODET
( 
"NROITEM",
"CODIGO",
"CCODCOMPD",
"CTIPCD",
"CLETD",
"CPTOVTAD",
"CNUMD",
"CCOMPDES",
"CCLIENTED",
"CFCHDEST",
"CMONTO",
"CSERIED",
"CUSUARIOD",
"CBDDEST",
"CSIGNOD"
 )
Select 
d.NROITEM,
d.CODIGO,
d.CCODCOMPD,
d.CTIPCD,
d.CLETD,
d.CPTOVTAD,
d.CNUMD,
d.CCOMPDES,
d.CCLIENTED,
d.CFCHDEST,
d.CMONTO,
d.CSERIED,
d.CUSUARIOD,
d.CBDDEST,
d.CSIGNOD
From deleted d left join ZooLogic.VALCAMBIODET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_VALCAMBIO') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_VALCAMBIO
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_VALEDECAMBIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fecha, ctod( '  /  /    ' ) ) )
					.Tipodecomprobantedestino = nvl( c_VALEDECAMBIO.Tipodecomprobantedestino, 0 )
					.Saldo = nvl( c_VALEDECAMBIO.Saldo, 0 )
					.Tipodecomprobanteorigen = nvl( c_VALEDECAMBIO.Tipodecomprobanteorigen, 0 )
					.Basededatosmodificacionfw = nvl( c_VALEDECAMBIO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_VALEDECAMBIO.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_VALEDECAMBIO.Horaaltafw, [] )
					.Seriealtafw = nvl( c_VALEDECAMBIO.Seriealtafw, [] )
					.Versionaltafw = nvl( c_VALEDECAMBIO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_VALEDECAMBIO.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_VALEDECAMBIO.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_VALEDECAMBIO.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_VALEDECAMBIO.Usuarioaltafw, [] )
					.Horaimpo = nvl( c_VALEDECAMBIO.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_VALEDECAMBIO.Basededatosaltafw, [] )
					.Horamodificacionfw = nvl( c_VALEDECAMBIO.Horamodificacionfw, [] )
					.Horaexpo = nvl( c_VALEDECAMBIO.Horaexpo, [] )
					.Codigocomprobantedestino = nvl( c_VALEDECAMBIO.Codigocomprobantedestino, [] )
					.Clientedestino = nvl( c_VALEDECAMBIO.Clientedestino, [] )
					.Codigocomprobanteorigen = nvl( c_VALEDECAMBIO.Codigocomprobanteorigen, [] )
					.Clienteorigen = nvl( c_VALEDECAMBIO.Clienteorigen, [] )
					.Seriedestino = nvl( c_VALEDECAMBIO.Seriedestino, [] )
					.Articulo = nvl( c_VALEDECAMBIO.Articulo, [] )
					.Serieorigen = nvl( c_VALEDECAMBIO.Serieorigen, [] )
					.Hora = nvl( c_VALEDECAMBIO.Hora, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Comprobantedetalle.Limpiar()
					.Comprobantedetalle.SetearEsNavegacion( .lProcesando )
					.Comprobantedetalle.Cargar()
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Comprobanteorigen = nvl( c_VALEDECAMBIO.Comprobanteorigen, [] )
					.Comprobantedestino = nvl( c_VALEDECAMBIO.Comprobantedestino, [] )
					.Letradestino = nvl( c_VALEDECAMBIO.Letradestino, [] )
					.Letraorigen = nvl( c_VALEDECAMBIO.Letraorigen, [] )
					.Usuariodestino = nvl( c_VALEDECAMBIO.Usuariodestino, [] )
					.Usuarioorigen = nvl( c_VALEDECAMBIO.Usuarioorigen, [] )
					.Codigo = nvl( c_VALEDECAMBIO.Codigo, [] )
					.Fechadestino = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechadestino, ctod( '  /  /    ' ) ) )
					.Fechaorigen = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALEDECAMBIO.Fechaorigen, ctod( '  /  /    ' ) ) )
					.Puntodeventadestino = nvl( c_VALEDECAMBIO.Puntodeventadestino, 0 )
					.Puntodeventa = nvl( c_VALEDECAMBIO.Puntodeventa, 0 )
					.Puntodeventaorigen = nvl( c_VALEDECAMBIO.Puntodeventaorigen, 0 )
					.Bddestino = nvl( c_VALEDECAMBIO.Bddestino, [] )
					.Bdorigen = nvl( c_VALEDECAMBIO.Bdorigen, [] )
					.Numero = nvl( c_VALEDECAMBIO.Numero, 0 )
					.Numerodestino = nvl( c_VALEDECAMBIO.Numerodestino, 0 )
					.Numeroorigen = nvl( c_VALEDECAMBIO.Numeroorigen, 0 )
					.Monto = nvl( c_VALEDECAMBIO.Monto, 0 )
					.Tipo = nvl( c_VALEDECAMBIO.Tipo, [] )
					.Reutilizable = nvl( c_VALEDECAMBIO.Reutilizable, .F. )
					.Valor = nvl( c_VALEDECAMBIO.Valor, [] )
					.Email = nvl( c_VALEDECAMBIO.Email, [] )
					.Signodemovimientodestino = nvl( c_VALEDECAMBIO.Signodemovimientodestino, 0 )
					.Signodemovimientoorigen = nvl( c_VALEDECAMBIO.Signodemovimientoorigen, 0 )
					.Simbolomonetario = nvl( c_VALEDECAMBIO.Simbolomonetario, [] )
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
		
		loDetalle = this.oEntidad.ComprobanteDetalle
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
		return c_VALEDECAMBIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.VALCAMBIO' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CCOD from (
							select * 
								from ZooLogic.VALCAMBIO 
								Where   VALCAMBIO.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "VALCAMBIO", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Cfecha" as "Fecha", "Ctipcd" as "Tipodecomprobantedestino", "Saldo" as "Saldo", "Ctipc" as "Tipodecomprobanteorigen", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Saltafw" as "Seriealtafw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Horaexpo" as "Horaexpo", "Ccodcompd" as "Codigocomprobantedestino", "Ccliented" as "Clientedestino", "Ccodcomp" as "Codigocomprobanteorigen", "Ccliente" as "Clienteorigen", "Cseried" as "Seriedestino", "Articulo" as "Articulo", "Cserie" as "Serieorigen", "Chora" as "Hora", "Cobss" as "Obs", "Cfechavenc" as "Fechavencimiento", "Ccompori" as "Comprobanteorigen", "Ccompdes" as "Comprobantedestino", "Cletd" as "Letradestino", "Clet" as "Letraorigen", "Cusuariod" as "Usuariodestino", "Cusuario" as "Usuarioorigen", "Ccod" as "Codigo", "Cfchdest" as "Fechadestino", "Cfchorig" as "Fechaorigen", "Cptovtad" as "Puntodeventadestino", "Ptoventa" as "Puntodeventa", "Cptovta" as "Puntodeventaorigen", "Cbddest" as "Bddestino", "Cbdorig" as "Bdorigen", "Numero" as "Numero", "Cnumd" as "Numerodestino", "Cnum" as "Numeroorigen", "Cmonto" as "Monto", "Tipo" as "Tipo", "Reutiliza" as "Reutilizable", "Valor" as "Valor", "Email" as "Email", "Csignod" as "Signodemovimientodestino", "Csigno" as "Signodemovimientoorigen", "Moneda" as "Simbolomonetario"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.VALCAMBIO 
								Where   VALCAMBIO.CCOD != ''
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
	Tabla = 'VALCAMBIO'
	Filtro = " VALCAMBIO.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " VALCAMBIO.CCOD != ''"
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
	<row entidad="VALEDECAMBIO                            " atributo="FECHAEXPO                               " tabla="VALCAMBIO      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHAALTAFW                             " tabla="VALCAMBIO      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHAIMPO                               " tabla="VALCAMBIO      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHATRANSFERENCIA                      " tabla="VALCAMBIO      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHAMODIFICACIONFW                     " tabla="VALCAMBIO      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHA                                   " tabla="VALCAMBIO      " campo="CFECHA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="4" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="TIPODECOMPROBANTEDESTINO                " tabla="VALCAMBIO      " campo="CTIPCD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo Comprobante destino                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SALDO                                   " tabla="VALCAMBIO      " campo="SALDO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="TIPODECOMPROBANTEORIGEN                 " tabla="VALCAMBIO      " campo="CTIPC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo Comprobante                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="VALCAMBIO      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="ESTADOTRANSFERENCIA                     " tabla="VALCAMBIO      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="HORAALTAFW                              " tabla="VALCAMBIO      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SERIEALTAFW                             " tabla="VALCAMBIO      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="VERSIONALTAFW                           " tabla="VALCAMBIO      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="ZADSFW                                  " tabla="VALCAMBIO      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="VERSIONMODIFICACIONFW                   " tabla="VALCAMBIO      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="USUARIOMODIFICACIONFW                   " tabla="VALCAMBIO      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SERIEMODIFICACIONFW                     " tabla="VALCAMBIO      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="USUARIOALTAFW                           " tabla="VALCAMBIO      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="HORAIMPO                                " tabla="VALCAMBIO      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="BASEDEDATOSALTAFW                       " tabla="VALCAMBIO      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="HORAMODIFICACIONFW                      " tabla="VALCAMBIO      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="HORAEXPO                                " tabla="VALCAMBIO      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="CODIGOCOMPROBANTEDESTINO                " tabla="VALCAMBIO      " campo="CCODCOMPD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="CLIENTEDESTINO                          " tabla="VALCAMBIO      " campo="CCLIENTED " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="200" etiqueta="Cliente                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="CODIGOCOMPROBANTEORIGEN                 " tabla="VALCAMBIO      " campo="CCODCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="CLIENTEORIGEN                           " tabla="VALCAMBIO      " campo="CCLIENTE  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Cliente                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SERIEDESTINO                            " tabla="VALCAMBIO      " campo="CSERIED   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="ARTICULO                                " tabla="VALCAMBIO      " campo="ARTICULO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SERIEORIGEN                             " tabla="VALCAMBIO      " campo="CSERIE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="9" etiqueta="Serie                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="HORA                                    " tabla="VALCAMBIO      " campo="CHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerhora()                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="5" etiqueta="Hora                                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="OBS                                     " tabla="VALCAMBIO      " campo="COBSS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="COMPROBANTEDETALLE                      " tabla="VALCAMBIODET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="Comprobantes afectantes                                                                                                                                         " dominio="DETALLEITEMVALEDECAMBIO       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHAVENCIMIENTO                        " tabla="VALCAMBIO      " campo="CFECHAVENC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="@ObtenerFechaDeVencimiento()                                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="6" etiqueta="Fecha vencimiento                                                                                                                                               " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="COMPROBANTEORIGEN                       " tabla="VALCAMBIO      " campo="CCOMPORI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="COMPROBANTEDESTINO                      " tabla="VALCAMBIO      " campo="CCOMPDES  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Comprobante                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="LETRADESTINO                            " tabla="VALCAMBIO      " campo="CLETD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra destino                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="LETRAORIGEN                             " tabla="VALCAMBIO      " campo="CLET      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="USUARIODESTINO                          " tabla="VALCAMBIO      " campo="CUSUARIOD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="USUARIOORIGEN                           " tabla="VALCAMBIO      " campo="CUSUARIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="10" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="CODIGO                                  " tabla="VALCAMBIO      " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="1" etiqueta="Número interno                                                                                                                                                  " dominio="CODIGOVALEDECAMBIO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHADESTINO                            " tabla="VALCAMBIO      " campo="CFCHDEST  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="23" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="FECHAORIGEN                             " tabla="VALCAMBIO      " campo="CFCHORIG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="13" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="PUNTODEVENTADESTINO                     " tabla="VALCAMBIO      " campo="CPTOVTAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta destino                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="PUNTODEVENTA                            " tabla="VALCAMBIO      " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="=goParametros.felino.Numeraciones.BocaDeExpendio                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="PUNTODEVENTAORIGEN                      " tabla="VALCAMBIO      " campo="CPTOVTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="BDDESTINO                               " tabla="VALCAMBIO      " campo="CBDDEST   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="BDORIGEN                                " tabla="VALCAMBIO      " campo="CBDORIG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="NUMERO                                  " tabla="VALCAMBIO      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="NUMERODESTINO                           " tabla="VALCAMBIO      " campo="CNUMD     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número destino                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="NUMEROORIGEN                            " tabla="VALCAMBIO      " campo="CNUM      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="MONTO                                   " tabla="VALCAMBIO      " campo="CMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="5" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="TIPO                                    " tabla="VALCAMBIO      " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="204" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="REUTILIZABLE                            " tabla="VALCAMBIO      " campo="REUTILIZA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="l         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Reutilizable                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="14" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="VALOR                                   " tabla="VALCAMBIO      " campo="VALOR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Valor                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="18" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="EMAIL                                   " tabla="VALCAMBIO      " campo="EMAIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SIGNODEMOVIMIENTODESTINO                " tabla="VALCAMBIO      " campo="CSIGNOD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Signo de Movimiento destino                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SIGNODEMOVIMIENTOORIGEN                 " tabla="VALCAMBIO      " campo="CSIGNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Signo de Movimiento                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALEDECAMBIO                            " atributo="SIMBOLOMONETARIO                        " tabla="VALCAMBIO      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="0" etiqueta="Moneda                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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