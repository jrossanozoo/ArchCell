
define class Din_EntidadCHEQUEAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CHEQUE'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( PuntoDeVenta, 4, 0) + str( NumeroC, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.ptoventa, 4, 0) + str( #tabla#.numeroC, 8, 0)]
	cTagClaveCandidata = '_CHCC'
	cTagClavePk = '_CHPK'
	cTablaPrincipal = 'CHEQUE'
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
			local  lxChequeFecimpo, lxChequeFmodifw, lxChequeFaltafw, lxChequeFecexpo, lxChequeFectrans, lxChequeFechaorden, lxChequeFletraa, lxChequeBdaltafw, lxChequeCcodcompa, lxChequeVmodifw, lxChequeSmodifw, lxChequeSaltafw, lxChequeUaltafw, lxChequeHmodifw, lxChequeUmodifw, lxChequeHoraexpo, lxChequeHoraimpo, lxChequeZadsfw, lxChequeEsttrans, lxChequeValtafw, lxChequeBdmodifw, lxChequeHaltafw, lxChequeCletra, lxChequeCcodcomp, lxChequeCvalor, lxChequePtoventa, lxChequeCcod, lxChequeCobss, lxChequeCfecend, lxChequeFptovena, lxChequeCnumero, lxChequeCptovta, lxChequeCusuario, lxChequeNumeroc, lxChequeEstado, lxChequeFnumcompa, lxChequeTipoch, lxChequeCmonto, lxChequeCnum, lxChequeCentfinend, lxChequeCfechaemi, lxChequeCtipca, lxChequeCautori, lxChequeCautoalfa, lxChequeCompa, lxChequeCcompori, lxChequeFechaa, lxChequeCfecha, lxChequeCfecori, lxChequeCgirador, lxChequeCctaendoso, lxChequeCtipc, lxChequeCelectro, lxChequeCseriea, lxChequeCleyendoso, lxChequeCtelgir, lxChequeCliente, lxChequeClican, lxChequeCvend, lxChequeCcotribgir, lxChequeCversiona, lxChequeCpaguesea, lxChequeCserie, lxChequeCcotribrut, lxChequeProvcan, lxChequeProvori, lxChequeCversion, lxChequeCbdedata, lxChequeCentfin, lxChequeCbdorig, lxChequeCmoneda, lxChequeFechavenci, lxChequeDestde, lxChequeCsigno
				lxChequeFecimpo =  .Fechaimpo			lxChequeFmodifw =  .Fechamodificacionfw			lxChequeFaltafw =  .Fechaaltafw			lxChequeFecexpo =  .Fechaexpo			lxChequeFectrans =  .Fechatransferencia			lxChequeFechaorden =  .Fechaordenamiento			lxChequeFletraa =  .Letraafectante			lxChequeBdaltafw =  .Basededatosaltafw			lxChequeCcodcompa =  .Codigocomprobanteafectante			lxChequeVmodifw =  .Versionmodificacionfw			lxChequeSmodifw =  .Seriemodificacionfw			lxChequeSaltafw =  .Seriealtafw			lxChequeUaltafw =  .Usuarioaltafw			lxChequeHmodifw =  .Horamodificacionfw			lxChequeUmodifw =  .Usuariomodificacionfw			lxChequeHoraexpo =  .Horaexpo			lxChequeHoraimpo =  .Horaimpo			lxChequeZadsfw =  .Zadsfw			lxChequeEsttrans =  .Estadotransferencia			lxChequeValtafw =  .Versionaltafw			lxChequeBdmodifw =  .Basededatosmodificacionfw			lxChequeHaltafw =  .Horaaltafw			lxChequeCletra =  .Letraorigen			lxChequeCcodcomp =  .Codigocomprobanteorigen			lxChequeCvalor =  .Valor			lxChequePtoventa =  .Puntodeventa			lxChequeCcod =  .Codigo			lxChequeCobss =  .Observacion			lxChequeCfecend =  .Fechaendoso			lxChequeFptovena =  .Puntodeventaafectante			lxChequeCnumero =  .Numero			lxChequeCptovta =  .Puntodeventaorigen			lxChequeCusuario =  .Usuarioorigen			lxChequeNumeroc =  .Numeroc			lxChequeEstado =  .Estado			lxChequeFnumcompa =  .Numeroafectante			lxChequeTipoch =  .Tipo			lxChequeCmonto =  .Monto			lxChequeCnum =  .Numeroorigen			lxChequeCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChequeCfechaemi =  .Fechaemision			lxChequeCtipca =  .Tipodecomprobanteafectante			lxChequeCautori =  .Autorizacion			lxChequeCautoalfa =  .Autorizacionalfa			lxChequeCompa =  .Comprobanteafectante			lxChequeCcompori =  .Comprobanteorigen			lxChequeFechaa =  .Fechaafectante			lxChequeCfecha =  .Fecha			lxChequeCfecori =  .Fechaorigen			lxChequeCgirador =  .Nombrelibrador			lxChequeCctaendoso =  .Cuentaendoso			lxChequeCtipc =  .Tipodecomprobanteorigen			lxChequeCelectro =  .Chequeelectronico			lxChequeCseriea =  .Cserieafectante			lxChequeCleyendoso =  .Leyendaendoso			lxChequeCtelgir =  .Telefonolibrador			lxChequeCliente =  upper( .Cliente_PK ) 			lxChequeClican =  upper( .ClienteAfectante_PK ) 			lxChequeCvend =  upper( .Vendedor_PK ) 			lxChequeCcotribgir =  .Codigotributariolibrador			lxChequeCversiona =  .Cversionafectante			lxChequeCpaguesea =  .Paguesea			lxChequeCserie =  .Serieorigen			lxChequeCcotribrut =  .Codigotributariolibradorrut			lxChequeProvcan =  upper( .ProveedorAfectante_PK ) 			lxChequeProvori =  upper( .Proveedor_PK ) 			lxChequeCversion =  .Cversionorigen			lxChequeCbdedata =  .Cbasededatosafectante			lxChequeCentfin =  upper( .EntidadFinanciera_PK ) 			lxChequeCbdorig =  .Bdorigen			lxChequeCmoneda =  upper( .Moneda_PK ) 			lxChequeFechavenci =  .Fechavencimiento			lxChequeDestde =  upper( .DestinoDeDescargaEnCheque_PK ) 			lxChequeCsigno =  .Signodemovimientoorigen
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxChequeCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CHEQUE ( "Fecimpo","Fmodifw","Faltafw","Fecexpo","Fectrans","Fechaorden","Fletraa","Bdaltafw","Ccodcompa","Vmodifw","Smodifw","Saltafw","Ualtafw","Hmodifw","Umodifw","Horaexpo","Horaimpo","Zadsfw","Esttrans","Valtafw","Bdmodifw","Haltafw","Cletra","Ccodcomp","Cvalor","Ptoventa","Ccod","Cobss","Cfecend","Fptovena","Cnumero","Cptovta","Cusuario","Numeroc","Estado","Fnumcompa","Tipoch","Cmonto","Cnum","Centfinend","Cfechaemi","Ctipca","Cautori","Cautoalfa","Compa","Ccompori","Fechaa","Cfecha","Cfecori","Cgirador","Cctaendoso","Ctipc","Celectro","Cseriea","Cleyendoso","Ctelgir","Cliente","Clican","Cvend","Ccotribgir","Cversiona","Cpaguesea","Cserie","Ccotribrut","Provcan","Provori","Cversion","Cbdedata","Centfin","Cbdorig","Cmoneda","Fechavenci","Destde","Csigno" ) values ( <<"'" + this.ConvertirDateSql( lxChequeFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFechaorden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeFletraa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcodcompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCvalor ) + "'" >>, <<lxChequePtoventa >>, <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCobss ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfecend ) + "'" >>, <<lxChequeFptovena >>, <<lxChequeCnumero >>, <<lxChequeCptovta >>, <<"'" + this.FormatearTextoSql( lxChequeCusuario ) + "'" >>, <<lxChequeNumeroc >>, <<"'" + this.FormatearTextoSql( lxChequeEstado ) + "'" >>, <<lxChequeFnumcompa >>, <<lxChequeTipoch >>, <<lxChequeCmonto >>, <<lxChequeCnum >>, <<"'" + this.FormatearTextoSql( lxChequeCentfinend ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfechaemi ) + "'" >>, <<lxChequeCtipca >>, <<lxChequeCautori >>, <<"'" + this.FormatearTextoSql( lxChequeCautoalfa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcompori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFechaa ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfecori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCgirador ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCctaendoso ) + "'" >>, <<lxChequeCtipc >>, <<iif( lxChequeCelectro, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxChequeCseriea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCleyendoso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCtelgir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeClican ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcotribgir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCversiona ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCpaguesea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcotribrut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeProvcan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeProvori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCbdedata ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCbdorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCmoneda ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFechavenci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeDestde ) + "'" >>, <<lxChequeCsigno >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxDestinodedescargadescripcion = loItem.Destinodedescargadescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxClientedescripcion = loItem.Clientedescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
					lxNroitem = lnContadorNroItem
					lxVersion = loItem.Version
					lxSerie = loItem.Serie
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCliente = loItem.Cliente
					lxCodigocomprobante = loItem.Codigocomprobante
					lxProveedor = loItem.Proveedor
					lxVendedor = loItem.Vendedor
					lxDestinodedescarga_PK = loItem.Destinodedescarga_PK
					lxCuentabancaria_PK = loItem.Cuentabancaria_PK
					lxFecha = loItem.Fecha
					lxHora = loItem.Hora
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxComprobante = loItem.Comprobante
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxTipo = loItem.Tipo
					lxCajaestado = loItem.Cajaestado
					lxCajaestadodetalle = loItem.Cajaestadodetalle
					lxBasedeorigen = loItem.Basedeorigen
					lxEstado = loItem.Estado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CHEQUEHIST("ProveedDes","DestDescDe","VendedDes","ClienteDes","CtaBancDes","NROITEM","cVersion","cSerie","IdentifEnt","Cliente","CodigoComp","Proveedor","Vendedor","Codigo","DestDesc","CtaBanc","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxDestinodedescargadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDestinodedescarga_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxChequeFecimpo, lxChequeFmodifw, lxChequeFaltafw, lxChequeFecexpo, lxChequeFectrans, lxChequeFechaorden, lxChequeFletraa, lxChequeBdaltafw, lxChequeCcodcompa, lxChequeVmodifw, lxChequeSmodifw, lxChequeSaltafw, lxChequeUaltafw, lxChequeHmodifw, lxChequeUmodifw, lxChequeHoraexpo, lxChequeHoraimpo, lxChequeZadsfw, lxChequeEsttrans, lxChequeValtafw, lxChequeBdmodifw, lxChequeHaltafw, lxChequeCletra, lxChequeCcodcomp, lxChequeCvalor, lxChequePtoventa, lxChequeCcod, lxChequeCobss, lxChequeCfecend, lxChequeFptovena, lxChequeCnumero, lxChequeCptovta, lxChequeCusuario, lxChequeNumeroc, lxChequeEstado, lxChequeFnumcompa, lxChequeTipoch, lxChequeCmonto, lxChequeCnum, lxChequeCentfinend, lxChequeCfechaemi, lxChequeCtipca, lxChequeCautori, lxChequeCautoalfa, lxChequeCompa, lxChequeCcompori, lxChequeFechaa, lxChequeCfecha, lxChequeCfecori, lxChequeCgirador, lxChequeCctaendoso, lxChequeCtipc, lxChequeCelectro, lxChequeCseriea, lxChequeCleyendoso, lxChequeCtelgir, lxChequeCliente, lxChequeClican, lxChequeCvend, lxChequeCcotribgir, lxChequeCversiona, lxChequeCpaguesea, lxChequeCserie, lxChequeCcotribrut, lxChequeProvcan, lxChequeProvori, lxChequeCversion, lxChequeCbdedata, lxChequeCentfin, lxChequeCbdorig, lxChequeCmoneda, lxChequeFechavenci, lxChequeDestde, lxChequeCsigno
				lxChequeFecimpo =  .Fechaimpo			lxChequeFmodifw =  .Fechamodificacionfw			lxChequeFaltafw =  .Fechaaltafw			lxChequeFecexpo =  .Fechaexpo			lxChequeFectrans =  .Fechatransferencia			lxChequeFechaorden =  .Fechaordenamiento			lxChequeFletraa =  .Letraafectante			lxChequeBdaltafw =  .Basededatosaltafw			lxChequeCcodcompa =  .Codigocomprobanteafectante			lxChequeVmodifw =  .Versionmodificacionfw			lxChequeSmodifw =  .Seriemodificacionfw			lxChequeSaltafw =  .Seriealtafw			lxChequeUaltafw =  .Usuarioaltafw			lxChequeHmodifw =  .Horamodificacionfw			lxChequeUmodifw =  .Usuariomodificacionfw			lxChequeHoraexpo =  .Horaexpo			lxChequeHoraimpo =  .Horaimpo			lxChequeZadsfw =  .Zadsfw			lxChequeEsttrans =  .Estadotransferencia			lxChequeValtafw =  .Versionaltafw			lxChequeBdmodifw =  .Basededatosmodificacionfw			lxChequeHaltafw =  .Horaaltafw			lxChequeCletra =  .Letraorigen			lxChequeCcodcomp =  .Codigocomprobanteorigen			lxChequeCvalor =  .Valor			lxChequePtoventa =  .Puntodeventa			lxChequeCcod =  .Codigo			lxChequeCobss =  .Observacion			lxChequeCfecend =  .Fechaendoso			lxChequeFptovena =  .Puntodeventaafectante			lxChequeCnumero =  .Numero			lxChequeCptovta =  .Puntodeventaorigen			lxChequeCusuario =  .Usuarioorigen			lxChequeNumeroc =  .Numeroc			lxChequeEstado =  .Estado			lxChequeFnumcompa =  .Numeroafectante			lxChequeTipoch =  .Tipo			lxChequeCmonto =  .Monto			lxChequeCnum =  .Numeroorigen			lxChequeCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChequeCfechaemi =  .Fechaemision			lxChequeCtipca =  .Tipodecomprobanteafectante			lxChequeCautori =  .Autorizacion			lxChequeCautoalfa =  .Autorizacionalfa			lxChequeCompa =  .Comprobanteafectante			lxChequeCcompori =  .Comprobanteorigen			lxChequeFechaa =  .Fechaafectante			lxChequeCfecha =  .Fecha			lxChequeCfecori =  .Fechaorigen			lxChequeCgirador =  .Nombrelibrador			lxChequeCctaendoso =  .Cuentaendoso			lxChequeCtipc =  .Tipodecomprobanteorigen			lxChequeCelectro =  .Chequeelectronico			lxChequeCseriea =  .Cserieafectante			lxChequeCleyendoso =  .Leyendaendoso			lxChequeCtelgir =  .Telefonolibrador			lxChequeCliente =  upper( .Cliente_PK ) 			lxChequeClican =  upper( .ClienteAfectante_PK ) 			lxChequeCvend =  upper( .Vendedor_PK ) 			lxChequeCcotribgir =  .Codigotributariolibrador			lxChequeCversiona =  .Cversionafectante			lxChequeCpaguesea =  .Paguesea			lxChequeCserie =  .Serieorigen			lxChequeCcotribrut =  .Codigotributariolibradorrut			lxChequeProvcan =  upper( .ProveedorAfectante_PK ) 			lxChequeProvori =  upper( .Proveedor_PK ) 			lxChequeCversion =  .Cversionorigen			lxChequeCbdedata =  .Cbasededatosafectante			lxChequeCentfin =  upper( .EntidadFinanciera_PK ) 			lxChequeCbdorig =  .Bdorigen			lxChequeCmoneda =  upper( .Moneda_PK ) 			lxChequeFechavenci =  .Fechavencimiento			lxChequeDestde =  upper( .DestinoDeDescargaEnCheque_PK ) 			lxChequeCsigno =  .Signodemovimientoorigen
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CHEQUE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxChequeFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxChequeFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxChequeFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxChequeFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxChequeFectrans ) + "'">>,"Fechaorden" = <<"'" + this.ConvertirDateSql( lxChequeFechaorden ) + "'">>,"Fletraa" = <<"'" + this.FormatearTextoSql( lxChequeFletraa ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxChequeBdaltafw ) + "'">>,"Ccodcompa" = <<"'" + this.FormatearTextoSql( lxChequeCcodcompa ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxChequeVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxChequeSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxChequeSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxChequeUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxChequeHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxChequeUmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxChequeHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxChequeHoraimpo ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxChequeZadsfw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxChequeEsttrans ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxChequeValtafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxChequeBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxChequeHaltafw ) + "'">>,"Cletra" = <<"'" + this.FormatearTextoSql( lxChequeCletra ) + "'">>,"Ccodcomp" = <<"'" + this.FormatearTextoSql( lxChequeCcodcomp ) + "'">>,"Cvalor" = <<"'" + this.FormatearTextoSql( lxChequeCvalor ) + "'">>,"Ptoventa" = <<lxChequePtoventa>>,"Ccod" = <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'">>,"Cobss" = <<"'" + this.FormatearTextoSql( lxChequeCobss ) + "'">>,"Cfecend" = <<"'" + this.ConvertirDateSql( lxChequeCfecend ) + "'">>,"Fptovena" = <<lxChequeFptovena>>,"Cnumero" = <<lxChequeCnumero>>,"Cptovta" = <<lxChequeCptovta>>,"Cusuario" = <<"'" + this.FormatearTextoSql( lxChequeCusuario ) + "'">>,"Numeroc" = <<lxChequeNumeroc>>,"Estado" = <<"'" + this.FormatearTextoSql( lxChequeEstado ) + "'">>,"Fnumcompa" = <<lxChequeFnumcompa>>,"Tipoch" = <<lxChequeTipoch>>,"Cmonto" = <<lxChequeCmonto>>,"Cnum" = <<lxChequeCnum>>,"Centfinend" = <<"'" + this.FormatearTextoSql( lxChequeCentfinend ) + "'">>,"Cfechaemi" = <<"'" + this.ConvertirDateSql( lxChequeCfechaemi ) + "'">>,"Ctipca" = <<lxChequeCtipca>>,"Cautori" = <<lxChequeCautori>>,"Cautoalfa" = <<"'" + this.FormatearTextoSql( lxChequeCautoalfa ) + "'">>,"Compa" = <<"'" + this.FormatearTextoSql( lxChequeCompa ) + "'">>,"Ccompori" = <<"'" + this.FormatearTextoSql( lxChequeCcompori ) + "'">>,"Fechaa" = <<"'" + this.ConvertirDateSql( lxChequeFechaa ) + "'">>,"Cfecha" = <<"'" + this.ConvertirDateSql( lxChequeCfecha ) + "'">>,"Cfecori" = <<"'" + this.ConvertirDateSql( lxChequeCfecori ) + "'">>,"Cgirador" = <<"'" + this.FormatearTextoSql( lxChequeCgirador ) + "'">>,"Cctaendoso" = <<"'" + this.FormatearTextoSql( lxChequeCctaendoso ) + "'">>,"Ctipc" = <<lxChequeCtipc>>,"Celectro" = <<iif( lxChequeCelectro, 1, 0 )>>,"Cseriea" = <<"'" + this.FormatearTextoSql( lxChequeCseriea ) + "'">>,"Cleyendoso" = <<"'" + this.FormatearTextoSql( lxChequeCleyendoso ) + "'">>,"Ctelgir" = <<"'" + this.FormatearTextoSql( lxChequeCtelgir ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxChequeCliente ) + "'">>,"Clican" = <<"'" + this.FormatearTextoSql( lxChequeClican ) + "'">>,"Cvend" = <<"'" + this.FormatearTextoSql( lxChequeCvend ) + "'">>,"Ccotribgir" = <<"'" + this.FormatearTextoSql( lxChequeCcotribgir ) + "'">>,"Cversiona" = <<"'" + this.FormatearTextoSql( lxChequeCversiona ) + "'">>,"Cpaguesea" = <<"'" + this.FormatearTextoSql( lxChequeCpaguesea ) + "'">>,"Cserie" = <<"'" + this.FormatearTextoSql( lxChequeCserie ) + "'">>,"Ccotribrut" = <<"'" + this.FormatearTextoSql( lxChequeCcotribrut ) + "'">>,"Provcan" = <<"'" + this.FormatearTextoSql( lxChequeProvcan ) + "'">>,"Provori" = <<"'" + this.FormatearTextoSql( lxChequeProvori ) + "'">>,"Cversion" = <<"'" + this.FormatearTextoSql( lxChequeCversion ) + "'">>,"Cbdedata" = <<"'" + this.FormatearTextoSql( lxChequeCbdedata ) + "'">>,"Centfin" = <<"'" + this.FormatearTextoSql( lxChequeCentfin ) + "'">>,"Cbdorig" = <<"'" + this.FormatearTextoSql( lxChequeCbdorig ) + "'">>,"Cmoneda" = <<"'" + this.FormatearTextoSql( lxChequeCmoneda ) + "'">>,"Fechavenci" = <<"'" + this.ConvertirDateSql( lxChequeFechavenci ) + "'">>,"Destde" = <<"'" + this.FormatearTextoSql( lxChequeDestde ) + "'">>,"Csigno" = <<lxChequeCsigno>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'">> and  CHEQUE.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CHEQUEHIST where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxDestinodedescargadescripcion = loItem.Destinodedescargadescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxClientedescripcion = loItem.Clientedescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
					lxNroitem = lnContadorNroItem
					lxVersion = loItem.Version
					lxSerie = loItem.Serie
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCliente = loItem.Cliente
					lxCodigocomprobante = loItem.Codigocomprobante
					lxProveedor = loItem.Proveedor
					lxVendedor = loItem.Vendedor
					lxDestinodedescarga_PK = loItem.Destinodedescarga_PK
					lxCuentabancaria_PK = loItem.Cuentabancaria_PK
					lxFecha = loItem.Fecha
					lxHora = loItem.Hora
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxComprobante = loItem.Comprobante
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxTipo = loItem.Tipo
					lxCajaestado = loItem.Cajaestado
					lxCajaestadodetalle = loItem.Cajaestadodetalle
					lxBasedeorigen = loItem.Basedeorigen
					lxEstado = loItem.Estado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CHEQUEHIST("ProveedDes","DestDescDe","VendedDes","ClienteDes","CtaBancDes","NROITEM","cVersion","cSerie","IdentifEnt","Cliente","CodigoComp","Proveedor","Vendedor","Codigo","DestDesc","CtaBanc","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxDestinodedescargadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDestinodedescarga_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ZooLogic.CHEQUE where " + this.ConvertirFuncionesSql( " CHEQUE.CCOD != ''" ) )
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
			Local lxChequeCcod
			lxChequeCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHEQUE where "Ccod" = <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'">> and  CHEQUE.CCOD != ''
			endtext
			use in select('c_CHEQUE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUE', set( 'Datasession' ) )

			if reccount( 'c_CHEQUE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHEQUEHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUE.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
			endtext
			use in select('c_HistorialDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HistorialDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_HistorialDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCHEQUEptoventa As Variant, lxCHEQUEnumeroC As Variant
			lxCHEQUEptoventa = .PuntoDeVenta
			lxCHEQUEnumeroC = .NumeroC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHEQUE where  CHEQUE.CCOD != '' And ptoventa = <<lxCHEQUEptoventa>> and numeroC = <<lxCHEQUEnumeroC>>
			endtext
			use in select('c_CHEQUE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUE', set( 'Datasession' ) )
			if reccount( 'c_CHEQUE' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHEQUEHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUE.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
			endtext
			use in select('c_HistorialDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HistorialDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_HistorialDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxChequeCcod as Variant
		llRetorno = .t.
		lxChequeCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CHEQUE where "Ccod" = <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'">> and  CHEQUE.CCOD != ''
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHEQUE where  CHEQUE.CCOD != '' order by ptoventa,numeroC
			endtext
			use in select('c_CHEQUE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHEQUEHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUE.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
			endtext
			use in select('c_HistorialDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HistorialDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_HistorialDetalle
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHEQUE where  str( ptoventa, 4, 0) + str( numeroC, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CHEQUE.CCOD != '' order by ptoventa,numeroC
			endtext
			use in select('c_CHEQUE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHEQUEHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUE.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
			endtext
			use in select('c_HistorialDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HistorialDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_HistorialDetalle
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHEQUE where  str( ptoventa, 4, 0) + str( numeroC, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CHEQUE.CCOD != '' order by ptoventa desc,numeroC desc
			endtext
			use in select('c_CHEQUE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHEQUEHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUE.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
			endtext
			use in select('c_HistorialDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HistorialDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_HistorialDetalle
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .NumeroC, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHEQUE where  CHEQUE.CCOD != '' order by ptoventa desc,numeroC desc
			endtext
			use in select('c_CHEQUE')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUE', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHEQUEHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUE.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
			endtext
			use in select('c_HistorialDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_HistorialDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_HistorialDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fmodifw,Faltafw,Fecexpo,Fectrans,Fechaorden,Fletraa,Bdaltafw,Ccodcompa,Vmodifw,Smodi" + ;
"fw,Saltafw,Ualtafw,Hmodifw,Umodifw,Horaexpo,Horaimpo,Zadsfw,Esttrans,Valtafw,Bdmodifw,Haltafw,Cletra" + ;
",Ccodcomp,Cvalor,Ptoventa,Ccod,Cobss,Cfecend,Fptovena,Cnumero,Cptovta,Cusuario,Numeroc,Estado,Fnumco" + ;
"mpa,Tipoch,Cmonto,Cnum,Centfinend,Cfechaemi,Ctipca,Cautori,Cautoalfa,Compa,Ccompori,Fechaa,Cfecha,Cf" + ;
"ecori,Cgirador,Cctaendoso,Ctipc,Celectro,Cseriea,Cleyendoso,Ctelgir,Cliente,Clican,Cvend,Ccotribgir," + ;
"Cversiona,Cpaguesea,Cserie,Ccotribrut,Provcan,Provori,Cversion,Cbdedata,Centfin,Cbdorig,Cmoneda,Fech" + ;
"avenci,Destde,Csigno" + ;
" from ZooLogic.CHEQUE where  CHEQUE.CCOD != '' and " + lcFiltro )
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
			local  lxChequeFecimpo, lxChequeFmodifw, lxChequeFaltafw, lxChequeFecexpo, lxChequeFectrans, lxChequeFechaorden, lxChequeFletraa, lxChequeBdaltafw, lxChequeCcodcompa, lxChequeVmodifw, lxChequeSmodifw, lxChequeSaltafw, lxChequeUaltafw, lxChequeHmodifw, lxChequeUmodifw, lxChequeHoraexpo, lxChequeHoraimpo, lxChequeZadsfw, lxChequeEsttrans, lxChequeValtafw, lxChequeBdmodifw, lxChequeHaltafw, lxChequeCletra, lxChequeCcodcomp, lxChequeCvalor, lxChequePtoventa, lxChequeCcod, lxChequeCobss, lxChequeCfecend, lxChequeFptovena, lxChequeCnumero, lxChequeCptovta, lxChequeCusuario, lxChequeNumeroc, lxChequeEstado, lxChequeFnumcompa, lxChequeTipoch, lxChequeCmonto, lxChequeCnum, lxChequeCentfinend, lxChequeCfechaemi, lxChequeCtipca, lxChequeCautori, lxChequeCautoalfa, lxChequeCompa, lxChequeCcompori, lxChequeFechaa, lxChequeCfecha, lxChequeCfecori, lxChequeCgirador, lxChequeCctaendoso, lxChequeCtipc, lxChequeCelectro, lxChequeCseriea, lxChequeCleyendoso, lxChequeCtelgir, lxChequeCliente, lxChequeClican, lxChequeCvend, lxChequeCcotribgir, lxChequeCversiona, lxChequeCpaguesea, lxChequeCserie, lxChequeCcotribrut, lxChequeProvcan, lxChequeProvori, lxChequeCversion, lxChequeCbdedata, lxChequeCentfin, lxChequeCbdorig, lxChequeCmoneda, lxChequeFechavenci, lxChequeDestde, lxChequeCsigno
				lxChequeFecimpo = ctod( '  /  /    ' )			lxChequeFmodifw = ctod( '  /  /    ' )			lxChequeFaltafw = ctod( '  /  /    ' )			lxChequeFecexpo = ctod( '  /  /    ' )			lxChequeFectrans = ctod( '  /  /    ' )			lxChequeFechaorden = ctod( '  /  /    ' )			lxChequeFletraa = []			lxChequeBdaltafw = []			lxChequeCcodcompa = []			lxChequeVmodifw = []			lxChequeSmodifw = []			lxChequeSaltafw = []			lxChequeUaltafw = []			lxChequeHmodifw = []			lxChequeUmodifw = []			lxChequeHoraexpo = []			lxChequeHoraimpo = []			lxChequeZadsfw = []			lxChequeEsttrans = []			lxChequeValtafw = []			lxChequeBdmodifw = []			lxChequeHaltafw = []			lxChequeCletra = []			lxChequeCcodcomp = []			lxChequeCvalor = []			lxChequePtoventa = 0			lxChequeCcod = []			lxChequeCobss = []			lxChequeCfecend = ctod( '  /  /    ' )			lxChequeFptovena = 0			lxChequeCnumero = 0			lxChequeCptovta = 0			lxChequeCusuario = []			lxChequeNumeroc = 0			lxChequeEstado = []			lxChequeFnumcompa = 0			lxChequeTipoch = 0			lxChequeCmonto = 0			lxChequeCnum = 0			lxChequeCentfinend = []			lxChequeCfechaemi = ctod( '  /  /    ' )			lxChequeCtipca = 0			lxChequeCautori = 0			lxChequeCautoalfa = []			lxChequeCompa = []			lxChequeCcompori = []			lxChequeFechaa = ctod( '  /  /    ' )			lxChequeCfecha = ctod( '  /  /    ' )			lxChequeCfecori = ctod( '  /  /    ' )			lxChequeCgirador = []			lxChequeCctaendoso = []			lxChequeCtipc = 0			lxChequeCelectro = .F.			lxChequeCseriea = []			lxChequeCleyendoso = []			lxChequeCtelgir = []			lxChequeCliente = []			lxChequeClican = []			lxChequeCvend = []			lxChequeCcotribgir = []			lxChequeCversiona = []			lxChequeCpaguesea = []			lxChequeCserie = []			lxChequeCcotribrut = []			lxChequeProvcan = []			lxChequeProvori = []			lxChequeCversion = []			lxChequeCbdedata = []			lxChequeCentfin = []			lxChequeCbdorig = []			lxChequeCmoneda = []			lxChequeFechavenci = ctod( '  /  /    ' )			lxChequeDestde = []			lxChequeCsigno = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CHEQUEHIST where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CHEQUE where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CHEQUE' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where cCod = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(cCod, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CHEQUE.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CHEQUE', '', tnTope )
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
	Function ObtenerDatosDetalleHistorialDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CHEQUEHIST.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Proveeddes" as "Proveedordescripcion", "Destdescde" as "Destinodedescargadescripcion", "Vendeddes" as "Vendedordescripcion", "Clientedes" as "Clientedescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Nroitem" as "Nroitem", "Cversion" as "Version", "Cserie" as "Serie", "Identifent" as "Identificadorentidadcomprobante", "Cliente" as "Cliente", "Codigocomp" as "Codigocomprobante", "Proveedor" as "Proveedor", "Vendedor" as "Vendedor", "Codigo" as "Codigo", "Destdesc" as "Destinodedescarga", "Ctabanc" as "Cuentabancaria", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleHistorialDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CHEQUEHIST', 'HistorialDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleHistorialDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleHistorialDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAORDENAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAORDEN AS FECHAORDENAMIENTO'
				Case lcAtributo == 'LETRAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRAA AS LETRAAFECTANTE'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGOCOMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMPA AS CODIGOCOMPROBANTEAFECTANTE'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'LETRAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLETRA AS LETRAORIGEN'
				Case lcAtributo == 'CODIGOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMP AS CODIGOCOMPROBANTEORIGEN'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVALOR AS VALOR'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBSS AS OBSERVACION'
				Case lcAtributo == 'FECHAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECEND AS FECHAENDOSO'
				Case lcAtributo == 'PUNTODEVENTAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENA AS PUNTODEVENTAAFECTANTE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUMERO AS NUMERO'
				Case lcAtributo == 'PUNTODEVENTAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTOVTA AS PUNTODEVENTAORIGEN'
				Case lcAtributo == 'USUARIOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUSUARIO AS USUARIOORIGEN'
				Case lcAtributo == 'NUMEROC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROC AS NUMEROC'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADO'
				Case lcAtributo == 'NUMEROAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMPA AS NUMEROAFECTANTE'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCH AS TIPO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONTO AS MONTO'
				Case lcAtributo == 'NUMEROORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUM AS NUMEROORIGEN'
				Case lcAtributo == 'ENTIDADFINANCIERAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTFINEND AS ENTIDADFINANCIERAENDOSO'
				Case lcAtributo == 'FECHAEMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAEMI AS FECHAEMISION'
				Case lcAtributo == 'TIPODECOMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPCA AS TIPODECOMPROBANTEAFECTANTE'
				Case lcAtributo == 'AUTORIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAUTORI AS AUTORIZACION'
				Case lcAtributo == 'AUTORIZACIONALFA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAUTOALFA AS AUTORIZACIONALFA'
				Case lcAtributo == 'COMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPA AS COMPROBANTEAFECTANTE'
				Case lcAtributo == 'COMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOMPORI AS COMPROBANTEORIGEN'
				Case lcAtributo == 'FECHAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAA AS FECHAAFECTANTE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHA AS FECHA'
				Case lcAtributo == 'FECHAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECORI AS FECHAORIGEN'
				Case lcAtributo == 'NOMBRELIBRADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CGIRADOR AS NOMBRELIBRADOR'
				Case lcAtributo == 'CUENTAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCTAENDOSO AS CUENTAENDOSO'
				Case lcAtributo == 'TIPODECOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPC AS TIPODECOMPROBANTEORIGEN'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'CSERIEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIEA AS CSERIEAFECTANTE'
				Case lcAtributo == 'LEYENDAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEYENDOSO AS LEYENDAENDOSO'
				Case lcAtributo == 'TELEFONOLIBRADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTELGIR AS TELEFONOLIBRADOR'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CLIENTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLICAN AS CLIENTEAFECTANTE'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVEND AS VENDEDOR'
				Case lcAtributo == 'CODIGOTRIBUTARIOLIBRADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOTRIBGIR AS CODIGOTRIBUTARIOLIBRADOR'
				Case lcAtributo == 'CVERSIONAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSIONA AS CVERSIONAFECTANTE'
				Case lcAtributo == 'PAGUESEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPAGUESEA AS PAGUESEA'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIE AS SERIEORIGEN'
				Case lcAtributo == 'CODIGOTRIBUTARIOLIBRADORRUT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOTRIBRUT AS CODIGOTRIBUTARIOLIBRADORRUT'
				Case lcAtributo == 'PROVEEDORAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVCAN AS PROVEEDORAFECTANTE'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVORI AS PROVEEDOR'
				Case lcAtributo == 'CVERSIONORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSION AS CVERSIONORIGEN'
				Case lcAtributo == 'CBASEDEDATOSAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDEDATA AS CBASEDEDATOSAFECTANTE'
				Case lcAtributo == 'ENTIDADFINANCIERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTFIN AS ENTIDADFINANCIERA'
				Case lcAtributo == 'BDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDORIG AS BDORIGEN'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONEDA AS MONEDA'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVENCI AS FECHAVENCIMIENTO'
				Case lcAtributo == 'DESTINODEDESCARGAENCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESTDE AS DESTINODEDESCARGAENCHEQUE'
				Case lcAtributo == 'SIGNODEMOVIMIENTOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSIGNO AS SIGNODEMOVIMIENTOORIGEN'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleHistorialDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'PROVEEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDDES AS PROVEEDORDESCRIPCION'
				Case lcAtributo == 'DESTINODEDESCARGADESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESTDESCDE AS DESTINODEDESCARGADESCRIPCION'
				Case lcAtributo == 'VENDEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDDES AS VENDEDORDESCRIPCION'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTEDES AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'CUENTABANCARIADESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANCDES AS CUENTABANCARIADESCRIPCION'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'VERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSION AS VERSION'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIE AS SERIE'
				Case lcAtributo == 'IDENTIFICADORENTIDADCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFENT AS IDENTIFICADORENTIDADCOMPROBANTE'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESTINODEDESCARGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESTDESC AS DESTINODEDESCARGA'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANC AS CUENTABANCARIA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORA AS HORA'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'COMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPROB AS COMPROBANTE'
				Case lcAtributo == 'CONCEPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTO AS CONCEPTO'
				Case lcAtributo == 'CONCEPTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONCEPTDES AS CONCEPTODETALLE'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'CAJAESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJAESTADO'
				Case lcAtributo == 'CAJAESTADODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAJADESC AS CAJAESTADODETALLE'
				Case lcAtributo == 'BASEDEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASEORIGEN AS BASEDEORIGEN'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORDENAMIENTO'
				lcCampo = 'FECHAORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAAFECTANTE'
				lcCampo = 'FLETRAA'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEAFECTANTE'
				lcCampo = 'CCODCOMPA'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAORIGEN'
				lcCampo = 'CLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEORIGEN'
				lcCampo = 'CCODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'CVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBSS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAENDOSO'
				lcCampo = 'CFECEND'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAAFECTANTE'
				lcCampo = 'FPTOVENA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAORIGEN'
				lcCampo = 'CPTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOORIGEN'
				lcCampo = 'CUSUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROC'
				lcCampo = 'NUMEROC'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROAFECTANTE'
				lcCampo = 'FNUMCOMPA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOCH'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'CMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORIGEN'
				lcCampo = 'CNUM'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERAENDOSO'
				lcCampo = 'CENTFINEND'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEMISION'
				lcCampo = 'CFECHAEMI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEAFECTANTE'
				lcCampo = 'CTIPCA'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACION'
				lcCampo = 'CAUTORI'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONALFA'
				lcCampo = 'CAUTOALFA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEAFECTANTE'
				lcCampo = 'COMPA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEORIGEN'
				lcCampo = 'CCOMPORI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAAFECTANTE'
				lcCampo = 'FECHAA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'CFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGEN'
				lcCampo = 'CFECORI'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBRELIBRADOR'
				lcCampo = 'CGIRADOR'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTAENDOSO'
				lcCampo = 'CCTAENDOSO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEORIGEN'
				lcCampo = 'CTIPC'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'CSERIEAFECTANTE'
				lcCampo = 'CSERIEA'
			Case upper( alltrim( tcAtributo ) ) == 'LEYENDAENDOSO'
				lcCampo = 'CLEYENDOSO'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONOLIBRADOR'
				lcCampo = 'CTELGIR'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEAFECTANTE'
				lcCampo = 'CLICAN'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'CVEND'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOTRIBUTARIOLIBRADOR'
				lcCampo = 'CCOTRIBGIR'
			Case upper( alltrim( tcAtributo ) ) == 'CVERSIONAFECTANTE'
				lcCampo = 'CVERSIONA'
			Case upper( alltrim( tcAtributo ) ) == 'PAGUESEA'
				lcCampo = 'CPAGUESEA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'CSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOTRIBUTARIOLIBRADORRUT'
				lcCampo = 'CCOTRIBRUT'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORAFECTANTE'
				lcCampo = 'PROVCAN'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVORI'
			Case upper( alltrim( tcAtributo ) ) == 'CVERSIONORIGEN'
				lcCampo = 'CVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'CBASEDEDATOSAFECTANTE'
				lcCampo = 'CBDEDATA'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERA'
				lcCampo = 'CENTFIN'
			Case upper( alltrim( tcAtributo ) ) == 'BDORIGEN'
				lcCampo = 'CBDORIG'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'CMONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVENCI'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINODEDESCARGAENCHEQUE'
				lcCampo = 'DESTDE'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTOORIGEN'
				lcCampo = 'CSIGNO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleHistorialDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORDESCRIPCION'
				lcCampo = 'PROVEEDDES'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINODEDESCARGADESCRIPCION'
				lcCampo = 'DESTDESCDE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORDESCRIPCION'
				lcCampo = 'VENDEDDES'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'CLIENTEDES'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIADESCRIPCION'
				lcCampo = 'CTABANCDES'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'VERSION'
				lcCampo = 'CVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'CSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADORENTIDADCOMPROBANTE'
				lcCampo = 'IDENTIFENT'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODIGOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINODEDESCARGA'
				lcCampo = 'DESTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CTABANC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'HORA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTE'
				lcCampo = 'COMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTO'
				lcCampo = 'CONCEPTO'
			Case upper( alltrim( tcAtributo ) ) == 'CONCEPTODETALLE'
				lcCampo = 'CONCEPTDES'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAESTADO'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJAESTADODETALLE'
				lcCampo = 'CAJADESC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEORIGEN'
				lcCampo = 'BASEORIGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'ESTADO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'HISTORIALDETALLE'
			lcRetorno = 'CHEQUEHIST'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxChequeFecimpo, lxChequeFmodifw, lxChequeFaltafw, lxChequeFecexpo, lxChequeFectrans, lxChequeFechaorden, lxChequeFletraa, lxChequeBdaltafw, lxChequeCcodcompa, lxChequeVmodifw, lxChequeSmodifw, lxChequeSaltafw, lxChequeUaltafw, lxChequeHmodifw, lxChequeUmodifw, lxChequeHoraexpo, lxChequeHoraimpo, lxChequeZadsfw, lxChequeEsttrans, lxChequeValtafw, lxChequeBdmodifw, lxChequeHaltafw, lxChequeCletra, lxChequeCcodcomp, lxChequeCvalor, lxChequePtoventa, lxChequeCcod, lxChequeCobss, lxChequeCfecend, lxChequeFptovena, lxChequeCnumero, lxChequeCptovta, lxChequeCusuario, lxChequeNumeroc, lxChequeEstado, lxChequeFnumcompa, lxChequeTipoch, lxChequeCmonto, lxChequeCnum, lxChequeCentfinend, lxChequeCfechaemi, lxChequeCtipca, lxChequeCautori, lxChequeCautoalfa, lxChequeCompa, lxChequeCcompori, lxChequeFechaa, lxChequeCfecha, lxChequeCfecori, lxChequeCgirador, lxChequeCctaendoso, lxChequeCtipc, lxChequeCelectro, lxChequeCseriea, lxChequeCleyendoso, lxChequeCtelgir, lxChequeCliente, lxChequeClican, lxChequeCvend, lxChequeCcotribgir, lxChequeCversiona, lxChequeCpaguesea, lxChequeCserie, lxChequeCcotribrut, lxChequeProvcan, lxChequeProvori, lxChequeCversion, lxChequeCbdedata, lxChequeCentfin, lxChequeCbdorig, lxChequeCmoneda, lxChequeFechavenci, lxChequeDestde, lxChequeCsigno
				lxChequeFecimpo =  .Fechaimpo			lxChequeFmodifw =  .Fechamodificacionfw			lxChequeFaltafw =  .Fechaaltafw			lxChequeFecexpo =  .Fechaexpo			lxChequeFectrans =  .Fechatransferencia			lxChequeFechaorden =  .Fechaordenamiento			lxChequeFletraa =  .Letraafectante			lxChequeBdaltafw =  .Basededatosaltafw			lxChequeCcodcompa =  .Codigocomprobanteafectante			lxChequeVmodifw =  .Versionmodificacionfw			lxChequeSmodifw =  .Seriemodificacionfw			lxChequeSaltafw =  .Seriealtafw			lxChequeUaltafw =  .Usuarioaltafw			lxChequeHmodifw =  .Horamodificacionfw			lxChequeUmodifw =  .Usuariomodificacionfw			lxChequeHoraexpo =  .Horaexpo			lxChequeHoraimpo =  .Horaimpo			lxChequeZadsfw =  .Zadsfw			lxChequeEsttrans =  .Estadotransferencia			lxChequeValtafw =  .Versionaltafw			lxChequeBdmodifw =  .Basededatosmodificacionfw			lxChequeHaltafw =  .Horaaltafw			lxChequeCletra =  .Letraorigen			lxChequeCcodcomp =  .Codigocomprobanteorigen			lxChequeCvalor =  .Valor			lxChequePtoventa =  .Puntodeventa			lxChequeCcod =  .Codigo			lxChequeCobss =  .Observacion			lxChequeCfecend =  .Fechaendoso			lxChequeFptovena =  .Puntodeventaafectante			lxChequeCnumero =  .Numero			lxChequeCptovta =  .Puntodeventaorigen			lxChequeCusuario =  .Usuarioorigen			lxChequeNumeroc =  .Numeroc			lxChequeEstado =  .Estado			lxChequeFnumcompa =  .Numeroafectante			lxChequeTipoch =  .Tipo			lxChequeCmonto =  .Monto			lxChequeCnum =  .Numeroorigen			lxChequeCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChequeCfechaemi =  .Fechaemision			lxChequeCtipca =  .Tipodecomprobanteafectante			lxChequeCautori =  .Autorizacion			lxChequeCautoalfa =  .Autorizacionalfa			lxChequeCompa =  .Comprobanteafectante			lxChequeCcompori =  .Comprobanteorigen			lxChequeFechaa =  .Fechaafectante			lxChequeCfecha =  .Fecha			lxChequeCfecori =  .Fechaorigen			lxChequeCgirador =  .Nombrelibrador			lxChequeCctaendoso =  .Cuentaendoso			lxChequeCtipc =  .Tipodecomprobanteorigen			lxChequeCelectro =  .Chequeelectronico			lxChequeCseriea =  .Cserieafectante			lxChequeCleyendoso =  .Leyendaendoso			lxChequeCtelgir =  .Telefonolibrador			lxChequeCliente =  upper( .Cliente_PK ) 			lxChequeClican =  upper( .ClienteAfectante_PK ) 			lxChequeCvend =  upper( .Vendedor_PK ) 			lxChequeCcotribgir =  .Codigotributariolibrador			lxChequeCversiona =  .Cversionafectante			lxChequeCpaguesea =  .Paguesea			lxChequeCserie =  .Serieorigen			lxChequeCcotribrut =  .Codigotributariolibradorrut			lxChequeProvcan =  upper( .ProveedorAfectante_PK ) 			lxChequeProvori =  upper( .Proveedor_PK ) 			lxChequeCversion =  .Cversionorigen			lxChequeCbdedata =  .Cbasededatosafectante			lxChequeCentfin =  upper( .EntidadFinanciera_PK ) 			lxChequeCbdorig =  .Bdorigen			lxChequeCmoneda =  upper( .Moneda_PK ) 			lxChequeFechavenci =  .Fechavencimiento			lxChequeDestde =  upper( .DestinoDeDescargaEnCheque_PK ) 			lxChequeCsigno =  .Signodemovimientoorigen
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CHEQUE ( "Fecimpo","Fmodifw","Faltafw","Fecexpo","Fectrans","Fechaorden","Fletraa","Bdaltafw","Ccodcompa","Vmodifw","Smodifw","Saltafw","Ualtafw","Hmodifw","Umodifw","Horaexpo","Horaimpo","Zadsfw","Esttrans","Valtafw","Bdmodifw","Haltafw","Cletra","Ccodcomp","Cvalor","Ptoventa","Ccod","Cobss","Cfecend","Fptovena","Cnumero","Cptovta","Cusuario","Numeroc","Estado","Fnumcompa","Tipoch","Cmonto","Cnum","Centfinend","Cfechaemi","Ctipca","Cautori","Cautoalfa","Compa","Ccompori","Fechaa","Cfecha","Cfecori","Cgirador","Cctaendoso","Ctipc","Celectro","Cseriea","Cleyendoso","Ctelgir","Cliente","Clican","Cvend","Ccotribgir","Cversiona","Cpaguesea","Cserie","Ccotribrut","Provcan","Provori","Cversion","Cbdedata","Centfin","Cbdorig","Cmoneda","Fechavenci","Destde","Csigno" ) values ( <<"'" + this.ConvertirDateSql( lxChequeFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFechaorden ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeFletraa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcodcompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCvalor ) + "'" >>, <<lxChequePtoventa >>, <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCobss ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfecend ) + "'" >>, <<lxChequeFptovena >>, <<lxChequeCnumero >>, <<lxChequeCptovta >>, <<"'" + this.FormatearTextoSql( lxChequeCusuario ) + "'" >>, <<lxChequeNumeroc >>, <<"'" + this.FormatearTextoSql( lxChequeEstado ) + "'" >>, <<lxChequeFnumcompa >>, <<lxChequeTipoch >>, <<lxChequeCmonto >>, <<lxChequeCnum >>, <<"'" + this.FormatearTextoSql( lxChequeCentfinend ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfechaemi ) + "'" >>, <<lxChequeCtipca >>, <<lxChequeCautori >>, <<"'" + this.FormatearTextoSql( lxChequeCautoalfa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcompori ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFechaa ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfecha ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeCfecori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCgirador ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCctaendoso ) + "'" >>, <<lxChequeCtipc >>, <<iif( lxChequeCelectro, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxChequeCseriea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCleyendoso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCtelgir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeClican ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCvend ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcotribgir ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCversiona ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCpaguesea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCserie ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCcotribrut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeProvcan ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeProvori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCversion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCbdedata ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCbdorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeCmoneda ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChequeFechavenci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChequeDestde ) + "'" >>, <<lxChequeCsigno >> )
		endtext
		loColeccion.cTabla = 'CHEQUE' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxDestinodedescargadescripcion = loItem.Destinodedescargadescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxClientedescripcion = loItem.Clientedescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
					lxNroitem = lnContadorNroItem
					lxVersion = loItem.Version
					lxSerie = loItem.Serie
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCliente = loItem.Cliente
					lxCodigocomprobante = loItem.Codigocomprobante
					lxProveedor = loItem.Proveedor
					lxVendedor = loItem.Vendedor
					lxDestinodedescarga_PK = loItem.Destinodedescarga_PK
					lxCuentabancaria_PK = loItem.Cuentabancaria_PK
					lxFecha = loItem.Fecha
					lxHora = loItem.Hora
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxComprobante = loItem.Comprobante
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxTipo = loItem.Tipo
					lxCajaestado = loItem.Cajaestado
					lxCajaestadodetalle = loItem.Cajaestadodetalle
					lxBasedeorigen = loItem.Basedeorigen
					lxEstado = loItem.Estado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CHEQUEHIST("ProveedDes","DestDescDe","VendedDes","ClienteDes","CtaBancDes","NROITEM","cVersion","cSerie","IdentifEnt","Cliente","CodigoComp","Proveedor","Vendedor","Codigo","DestDesc","CtaBanc","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxDestinodedescargadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDestinodedescarga_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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
			local  lxChequeFecimpo, lxChequeFmodifw, lxChequeFaltafw, lxChequeFecexpo, lxChequeFectrans, lxChequeFechaorden, lxChequeFletraa, lxChequeBdaltafw, lxChequeCcodcompa, lxChequeVmodifw, lxChequeSmodifw, lxChequeSaltafw, lxChequeUaltafw, lxChequeHmodifw, lxChequeUmodifw, lxChequeHoraexpo, lxChequeHoraimpo, lxChequeZadsfw, lxChequeEsttrans, lxChequeValtafw, lxChequeBdmodifw, lxChequeHaltafw, lxChequeCletra, lxChequeCcodcomp, lxChequeCvalor, lxChequePtoventa, lxChequeCcod, lxChequeCobss, lxChequeCfecend, lxChequeFptovena, lxChequeCnumero, lxChequeCptovta, lxChequeCusuario, lxChequeNumeroc, lxChequeEstado, lxChequeFnumcompa, lxChequeTipoch, lxChequeCmonto, lxChequeCnum, lxChequeCentfinend, lxChequeCfechaemi, lxChequeCtipca, lxChequeCautori, lxChequeCautoalfa, lxChequeCompa, lxChequeCcompori, lxChequeFechaa, lxChequeCfecha, lxChequeCfecori, lxChequeCgirador, lxChequeCctaendoso, lxChequeCtipc, lxChequeCelectro, lxChequeCseriea, lxChequeCleyendoso, lxChequeCtelgir, lxChequeCliente, lxChequeClican, lxChequeCvend, lxChequeCcotribgir, lxChequeCversiona, lxChequeCpaguesea, lxChequeCserie, lxChequeCcotribrut, lxChequeProvcan, lxChequeProvori, lxChequeCversion, lxChequeCbdedata, lxChequeCentfin, lxChequeCbdorig, lxChequeCmoneda, lxChequeFechavenci, lxChequeDestde, lxChequeCsigno
				lxChequeFecimpo =  .Fechaimpo			lxChequeFmodifw =  .Fechamodificacionfw			lxChequeFaltafw =  .Fechaaltafw			lxChequeFecexpo =  .Fechaexpo			lxChequeFectrans =  .Fechatransferencia			lxChequeFechaorden =  .Fechaordenamiento			lxChequeFletraa =  .Letraafectante			lxChequeBdaltafw =  .Basededatosaltafw			lxChequeCcodcompa =  .Codigocomprobanteafectante			lxChequeVmodifw =  .Versionmodificacionfw			lxChequeSmodifw =  .Seriemodificacionfw			lxChequeSaltafw =  .Seriealtafw			lxChequeUaltafw =  .Usuarioaltafw			lxChequeHmodifw =  .Horamodificacionfw			lxChequeUmodifw =  .Usuariomodificacionfw			lxChequeHoraexpo =  .Horaexpo			lxChequeHoraimpo =  .Horaimpo			lxChequeZadsfw =  .Zadsfw			lxChequeEsttrans =  .Estadotransferencia			lxChequeValtafw =  .Versionaltafw			lxChequeBdmodifw =  .Basededatosmodificacionfw			lxChequeHaltafw =  .Horaaltafw			lxChequeCletra =  .Letraorigen			lxChequeCcodcomp =  .Codigocomprobanteorigen			lxChequeCvalor =  .Valor			lxChequePtoventa =  .Puntodeventa			lxChequeCcod =  .Codigo			lxChequeCobss =  .Observacion			lxChequeCfecend =  .Fechaendoso			lxChequeFptovena =  .Puntodeventaafectante			lxChequeCnumero =  .Numero			lxChequeCptovta =  .Puntodeventaorigen			lxChequeCusuario =  .Usuarioorigen			lxChequeNumeroc =  .Numeroc			lxChequeEstado =  .Estado			lxChequeFnumcompa =  .Numeroafectante			lxChequeTipoch =  .Tipo			lxChequeCmonto =  .Monto			lxChequeCnum =  .Numeroorigen			lxChequeCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChequeCfechaemi =  .Fechaemision			lxChequeCtipca =  .Tipodecomprobanteafectante			lxChequeCautori =  .Autorizacion			lxChequeCautoalfa =  .Autorizacionalfa			lxChequeCompa =  .Comprobanteafectante			lxChequeCcompori =  .Comprobanteorigen			lxChequeFechaa =  .Fechaafectante			lxChequeCfecha =  .Fecha			lxChequeCfecori =  .Fechaorigen			lxChequeCgirador =  .Nombrelibrador			lxChequeCctaendoso =  .Cuentaendoso			lxChequeCtipc =  .Tipodecomprobanteorigen			lxChequeCelectro =  .Chequeelectronico			lxChequeCseriea =  .Cserieafectante			lxChequeCleyendoso =  .Leyendaendoso			lxChequeCtelgir =  .Telefonolibrador			lxChequeCliente =  upper( .Cliente_PK ) 			lxChequeClican =  upper( .ClienteAfectante_PK ) 			lxChequeCvend =  upper( .Vendedor_PK ) 			lxChequeCcotribgir =  .Codigotributariolibrador			lxChequeCversiona =  .Cversionafectante			lxChequeCpaguesea =  .Paguesea			lxChequeCserie =  .Serieorigen			lxChequeCcotribrut =  .Codigotributariolibradorrut			lxChequeProvcan =  upper( .ProveedorAfectante_PK ) 			lxChequeProvori =  upper( .Proveedor_PK ) 			lxChequeCversion =  .Cversionorigen			lxChequeCbdedata =  .Cbasededatosafectante			lxChequeCentfin =  upper( .EntidadFinanciera_PK ) 			lxChequeCbdorig =  .Bdorigen			lxChequeCmoneda =  upper( .Moneda_PK ) 			lxChequeFechavenci =  .Fechavencimiento			lxChequeDestde =  upper( .DestinoDeDescargaEnCheque_PK ) 			lxChequeCsigno =  .Signodemovimientoorigen
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  CHEQUE.CCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CHEQUE set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxChequeFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxChequeFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxChequeFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxChequeFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxChequeFectrans ) + "'">>, "Fechaorden" = <<"'" + this.ConvertirDateSql( lxChequeFechaorden ) + "'">>, "Fletraa" = <<"'" + this.FormatearTextoSql( lxChequeFletraa ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxChequeBdaltafw ) + "'">>, "Ccodcompa" = <<"'" + this.FormatearTextoSql( lxChequeCcodcompa ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxChequeVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxChequeSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxChequeSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxChequeUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxChequeHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxChequeUmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxChequeHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxChequeHoraimpo ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxChequeZadsfw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxChequeEsttrans ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxChequeValtafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxChequeBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxChequeHaltafw ) + "'">>, "Cletra" = <<"'" + this.FormatearTextoSql( lxChequeCletra ) + "'">>, "Ccodcomp" = <<"'" + this.FormatearTextoSql( lxChequeCcodcomp ) + "'">>, "Cvalor" = <<"'" + this.FormatearTextoSql( lxChequeCvalor ) + "'">>, "Ptoventa" = <<lxChequePtoventa>>, "Ccod" = <<"'" + this.FormatearTextoSql( lxChequeCcod ) + "'">>, "Cobss" = <<"'" + this.FormatearTextoSql( lxChequeCobss ) + "'">>, "Cfecend" = <<"'" + this.ConvertirDateSql( lxChequeCfecend ) + "'">>, "Fptovena" = <<lxChequeFptovena>>, "Cnumero" = <<lxChequeCnumero>>, "Cptovta" = <<lxChequeCptovta>>, "Cusuario" = <<"'" + this.FormatearTextoSql( lxChequeCusuario ) + "'">>, "Numeroc" = <<lxChequeNumeroc>>, "Estado" = <<"'" + this.FormatearTextoSql( lxChequeEstado ) + "'">>, "Fnumcompa" = <<lxChequeFnumcompa>>, "Tipoch" = <<lxChequeTipoch>>, "Cmonto" = <<lxChequeCmonto>>, "Cnum" = <<lxChequeCnum>>, "Centfinend" = <<"'" + this.FormatearTextoSql( lxChequeCentfinend ) + "'">>, "Cfechaemi" = <<"'" + this.ConvertirDateSql( lxChequeCfechaemi ) + "'">>, "Ctipca" = <<lxChequeCtipca>>, "Cautori" = <<lxChequeCautori>>, "Cautoalfa" = <<"'" + this.FormatearTextoSql( lxChequeCautoalfa ) + "'">>, "Compa" = <<"'" + this.FormatearTextoSql( lxChequeCompa ) + "'">>, "Ccompori" = <<"'" + this.FormatearTextoSql( lxChequeCcompori ) + "'">>, "Fechaa" = <<"'" + this.ConvertirDateSql( lxChequeFechaa ) + "'">>, "Cfecha" = <<"'" + this.ConvertirDateSql( lxChequeCfecha ) + "'">>, "Cfecori" = <<"'" + this.ConvertirDateSql( lxChequeCfecori ) + "'">>, "Cgirador" = <<"'" + this.FormatearTextoSql( lxChequeCgirador ) + "'">>, "Cctaendoso" = <<"'" + this.FormatearTextoSql( lxChequeCctaendoso ) + "'">>, "Ctipc" = <<lxChequeCtipc>>, "Celectro" = <<iif( lxChequeCelectro, 1, 0 )>>, "Cseriea" = <<"'" + this.FormatearTextoSql( lxChequeCseriea ) + "'">>, "Cleyendoso" = <<"'" + this.FormatearTextoSql( lxChequeCleyendoso ) + "'">>, "Ctelgir" = <<"'" + this.FormatearTextoSql( lxChequeCtelgir ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxChequeCliente ) + "'">>, "Clican" = <<"'" + this.FormatearTextoSql( lxChequeClican ) + "'">>, "Cvend" = <<"'" + this.FormatearTextoSql( lxChequeCvend ) + "'">>, "Ccotribgir" = <<"'" + this.FormatearTextoSql( lxChequeCcotribgir ) + "'">>, "Cversiona" = <<"'" + this.FormatearTextoSql( lxChequeCversiona ) + "'">>, "Cpaguesea" = <<"'" + this.FormatearTextoSql( lxChequeCpaguesea ) + "'">>, "Cserie" = <<"'" + this.FormatearTextoSql( lxChequeCserie ) + "'">>, "Ccotribrut" = <<"'" + this.FormatearTextoSql( lxChequeCcotribrut ) + "'">>, "Provcan" = <<"'" + this.FormatearTextoSql( lxChequeProvcan ) + "'">>, "Provori" = <<"'" + this.FormatearTextoSql( lxChequeProvori ) + "'">>, "Cversion" = <<"'" + this.FormatearTextoSql( lxChequeCversion ) + "'">>, "Cbdedata" = <<"'" + this.FormatearTextoSql( lxChequeCbdedata ) + "'">>, "Centfin" = <<"'" + this.FormatearTextoSql( lxChequeCentfin ) + "'">>, "Cbdorig" = <<"'" + this.FormatearTextoSql( lxChequeCbdorig ) + "'">>, "Cmoneda" = <<"'" + this.FormatearTextoSql( lxChequeCmoneda ) + "'">>, "Fechavenci" = <<"'" + this.ConvertirDateSql( lxChequeFechavenci ) + "'">>, "Destde" = <<"'" + this.FormatearTextoSql( lxChequeDestde ) + "'">>, "Csigno" = <<lxChequeCsigno>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CHEQUE' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CHEQUEHIST where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxDestinodedescargadescripcion = loItem.Destinodedescargadescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxClientedescripcion = loItem.Clientedescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
					lxNroitem = lnContadorNroItem
					lxVersion = loItem.Version
					lxSerie = loItem.Serie
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCliente = loItem.Cliente
					lxCodigocomprobante = loItem.Codigocomprobante
					lxProveedor = loItem.Proveedor
					lxVendedor = loItem.Vendedor
					lxDestinodedescarga_PK = loItem.Destinodedescarga_PK
					lxCuentabancaria_PK = loItem.Cuentabancaria_PK
					lxFecha = loItem.Fecha
					lxHora = loItem.Hora
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxComprobante = loItem.Comprobante
					lxConcepto_PK = loItem.Concepto_PK
					lxConceptodetalle = loItem.Conceptodetalle
					lxTipo = loItem.Tipo
					lxCajaestado = loItem.Cajaestado
					lxCajaestadodetalle = loItem.Cajaestadodetalle
					lxBasedeorigen = loItem.Basedeorigen
					lxEstado = loItem.Estado
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CHEQUEHIST("ProveedDes","DestDescDe","VendedDes","ClienteDes","CtaBancDes","NROITEM","cVersion","cSerie","IdentifEnt","Cliente","CodigoComp","Proveedor","Vendedor","Codigo","DestDesc","CtaBanc","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxDestinodedescargadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDestinodedescarga_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  CHEQUE.CCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.CHEQUE where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CHEQUEHIST where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CHEQUE' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CHEQUE where  CHEQUE.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CHEQUE where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CHEQUE.CCOD != ''" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMEROC') ) and iif( type( '.NUMEROC' ) = 'C', int( val( .NUMEROC ) ),.NUMEROC ) = .oNumeraciones.UltimoNumero( 'NUMEROC' )
						.oNumeraciones.Actualizar( 'NUMEROC' )
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
					.NUMEROC = .oNumeraciones.grabar( 'NUMEROC' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCHEQUEptoventa as variant, lxCHEQUEcNumero as variant, lxCHEQUEnumeroC as variant, lxCHEQUEEstado as variant, lxCHEQUEcMonto as variant, lxCHEQUEcFechaEmi as variant, lxCHEQUEcFecha as variant, lxCHEQUEcEntFin as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUE'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CHEQUE Where  ptoventa = ] + transform( &lcCursor..ptoventa   ) + [ and numeroC = ] + transform( &lcCursor..numeroC    ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..cCod
				if lxValorClavePK == curSeek.cCod or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.cCod and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.cCod
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CHEQUE set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FechaOrden = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaOrden ) + "'"+ [, FLETRAA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRAA ) + "'"+ [, cCodCompA = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodCompA ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, cLetra = ] + "'" + this.FormatearTextoSql( &lcCursor..cLetra ) + "'"+ [, cCodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodComp ) + "'"+ [, cValor = ] + "'" + this.FormatearTextoSql( &lcCursor..cValor ) + "'"+ [, ptoventa = ] + transform( &lcCursor..ptoventa )+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, cObss = ] + "'" + this.FormatearTextoSql( &lcCursor..cObss ) + "'"+ [, cFecEnd = ] + "'" + this.ConvertirDateSql( &lcCursor..cFecEnd ) + "'"+ [, FPTOVENA = ] + transform( &lcCursor..FPTOVENA )+ [, cNumero = ] + transform( &lcCursor..cNumero )+ [, cptovta = ] + transform( &lcCursor..cptovta )+ [, cUsuario = ] + "'" + this.FormatearTextoSql( &lcCursor..cUsuario ) + "'"+ [, numeroC = ] + transform( &lcCursor..numeroC )+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, FNUMCOMPA = ] + transform( &lcCursor..FNUMCOMPA )+ [, TipoCH = ] + transform( &lcCursor..TipoCH )+ [, cMonto = ] + transform( &lcCursor..cMonto )+ [, cnum = ] + transform( &lcCursor..cnum )+ [, cEntFinEnd = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntFinEnd ) + "'"+ [, cFechaEmi = ] + "'" + this.ConvertirDateSql( &lcCursor..cFechaEmi ) + "'"+ [, cTipCA = ] + transform( &lcCursor..cTipCA )+ [, cAutori = ] + transform( &lcCursor..cAutori )+ [, cAutoAlfa = ] + "'" + this.FormatearTextoSql( &lcCursor..cAutoAlfa ) + "'"+ [, CompA = ] + "'" + this.FormatearTextoSql( &lcCursor..CompA ) + "'"+ [, cCompOri = ] + "'" + this.FormatearTextoSql( &lcCursor..cCompOri ) + "'"+ [, FechaA = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaA ) + "'"+ [, cFecha = ] + "'" + this.ConvertirDateSql( &lcCursor..cFecha ) + "'"+ [, cFecOri = ] + "'" + this.ConvertirDateSql( &lcCursor..cFecOri ) + "'"+ [, cGirador = ] + "'" + this.FormatearTextoSql( &lcCursor..cGirador ) + "'"+ [, cCtaEndoso = ] + "'" + this.FormatearTextoSql( &lcCursor..cCtaEndoso ) + "'"+ [, cTipC = ] + transform( &lcCursor..cTipC )+ [, CElectro = ] + Transform( iif( &lcCursor..CElectro, 1, 0 ))+ [, CSERIEA = ] + "'" + this.FormatearTextoSql( &lcCursor..CSERIEA ) + "'"+ [, cLeyEndoso = ] + "'" + this.FormatearTextoSql( &lcCursor..cLeyEndoso ) + "'"+ [, cTelGir = ] + "'" + this.FormatearTextoSql( &lcCursor..cTelGir ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, CliCan = ] + "'" + this.FormatearTextoSql( &lcCursor..CliCan ) + "'"+ [, cVend = ] + "'" + this.FormatearTextoSql( &lcCursor..cVend ) + "'"+ [, cCoTribGir = ] + "'" + this.FormatearTextoSql( &lcCursor..cCoTribGir ) + "'"+ [, CVERSIONA = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSIONA ) + "'"+ [, cPagueseA = ] + "'" + this.FormatearTextoSql( &lcCursor..cPagueseA ) + "'"+ [, cSerie = ] + "'" + this.FormatearTextoSql( &lcCursor..cSerie ) + "'"+ [, cCoTribRut = ] + "'" + this.FormatearTextoSql( &lcCursor..cCoTribRut ) + "'"+ [, ProvCan = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvCan ) + "'"+ [, ProvOri = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvOri ) + "'"+ [, CVERSION = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'"+ [, cBDeDatA = ] + "'" + this.FormatearTextoSql( &lcCursor..cBDeDatA ) + "'"+ [, cEntFin = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntFin ) + "'"+ [, cBdorig = ] + "'" + this.FormatearTextoSql( &lcCursor..cBdorig ) + "'"+ [, cMoneda = ] + "'" + this.FormatearTextoSql( &lcCursor..cMoneda ) + "'"+ [, FechaVenci = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaVenci ) + "'"+ [, DestDe = ] + "'" + this.FormatearTextoSql( &lcCursor..DestDe ) + "'"+ [, cSigno = ] + transform( &lcCursor..cSigno ) + [ Where cCod = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CHEQUE Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECIMPO, FMODIFW, FALTAFW, FECEXPO, FECTRANS, FechaOrden, FLETRAA, BDALTAFW, cCodCompA, VMODIFW, SMODIFW, SALTAFW, UALTAFW, HMODIFW, UMODIFW, HORAEXPO, HORAIMPO, ZADSFW, ESTTRANS, VALTAFW, BDMODIFW, HALTAFW, cLetra, cCodComp, cValor, ptoventa, cCod, cObss, cFecEnd, FPTOVENA, cNumero, cptovta, cUsuario, numeroC, Estado, FNUMCOMPA, TipoCH, cMonto, cnum, cEntFinEnd, cFechaEmi, cTipCA, cAutori, cAutoAlfa, CompA, cCompOri, FechaA, cFecha, cFecOri, cGirador, cCtaEndoso, cTipC, CElectro, CSERIEA, cLeyEndoso, cTelGir, Cliente, CliCan, cVend, cCoTribGir, CVERSIONA, cPagueseA, cSerie, cCoTribRut, ProvCan, ProvOri, CVERSION, cBDeDatA, cEntFin, cBdorig, cMoneda, FechaVenci, DestDe, cSigno
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaOrden ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRAA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodCompA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cLetra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cValor ) + "'" + ',' + transform( &lcCursor..ptoventa ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObss ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFecEnd ) + "'" + ',' + transform( &lcCursor..FPTOVENA ) + ',' + transform( &lcCursor..cNumero ) + ',' + transform( &lcCursor..cptovta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cUsuario ) + "'" + ',' + transform( &lcCursor..numeroC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'" + ',' + transform( &lcCursor..FNUMCOMPA ) + ',' + transform( &lcCursor..TipoCH )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..cMonto ) + ',' + transform( &lcCursor..cnum ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntFinEnd ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFechaEmi ) + "'" + ',' + transform( &lcCursor..cTipCA ) + ',' + transform( &lcCursor..cAutori ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cAutoAlfa ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CompA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCompOri ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFecha ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFecOri ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cGirador ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCtaEndoso ) + "'" + ',' + transform( &lcCursor..cTipC )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..CElectro, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CSERIEA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cLeyEndoso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cTelGir ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CliCan ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cVend ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCoTribGir ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSIONA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cPagueseA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cSerie ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCoTribRut ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvCan ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvOri ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBDeDatA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntFin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBdorig ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cMoneda ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaVenci ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DestDe ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..cSigno )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CHEQUE ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUE'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'cCod','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','cCod')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CHEQUEHIST Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCHEQUEHISTORIAL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"ProveedDes","DestDescDe","VendedDes","ClienteDes","CtaBancDes","NROITEM","cVersion","cSerie","IdentifEnt","Cliente","CodigoComp","Proveedor","Vendedor","Codigo","DestDesc","CtaBanc","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CHEQUEHIST ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.ProveedDes ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DestDescDe ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.VendedDes  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ClienteDes ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CtaBancDes ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cVersion   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cSerie     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdentifEnt ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoComp ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proveedor  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Vendedor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DestDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CtaBanc    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Hora       ) + "'" + ',' + transform( cDetallesExistentes.TipoComp   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Comprob    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Concepto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ConceptDes ) + "'" + ',' + transform( cDetallesExistentes.Tipo       ) + ',' + transform( cDetallesExistentes.idCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CajaDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BaseOrigen ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Estado     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCod C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..ptoventa   )
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..numeroC    )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'CHEQUE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CHEQUE_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CHEQUE_COBSS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCHEQUEHISTORIAL'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CHEQUE')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CHEQUE'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..ptoventa ) or isnull( &lcCursor..numeroC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CHEQUE. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( ptoventa, 4, 0) + str( numeroC, 8, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( ptoventa, 4, 0) + str( numeroC, 8, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FechaOrden
		* Validar ANTERIORES A 1/1/1753  cFecEnd   
		* Validar ANTERIORES A 1/1/1753  cFechaEmi 
		* Validar ANTERIORES A 1/1/1753  FechaA    
		* Validar ANTERIORES A 1/1/1753  cFecha    
		* Validar ANTERIORES A 1/1/1753  cFecOri   
		* Validar ANTERIORES A 1/1/1753  FechaVenci
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CHEQUE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CHEQUE
Create Table ZooLogic.TablaTrabajo_CHEQUE ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fechaorden" datetime  null, 
"fletraa" char( 1 )  null, 
"bdaltafw" char( 8 )  null, 
"ccodcompa" char( 38 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"esttrans" char( 20 )  null, 
"valtafw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"cletra" char( 1 )  null, 
"ccodcomp" char( 38 )  null, 
"cvalor" char( 5 )  null, 
"ptoventa" numeric( 4, 0 )  null, 
"ccod" char( 38 )  null, 
"cobss" varchar(max)  null, 
"cfecend" datetime  null, 
"fptovena" numeric( 4, 0 )  null, 
"cnumero" numeric( 8, 0 )  null, 
"cptovta" numeric( 4, 0 )  null, 
"cusuario" char( 100 )  null, 
"numeroc" numeric( 8, 0 )  null, 
"estado" char( 5 )  null, 
"fnumcompa" numeric( 8, 0 )  null, 
"tipoch" numeric( 2, 0 )  null, 
"cmonto" numeric( 15, 2 )  null, 
"cnum" numeric( 8, 0 )  null, 
"centfinend" char( 5 )  null, 
"cfechaemi" datetime  null, 
"ctipca" numeric( 2, 0 )  null, 
"cautori" numeric( 9, 0 )  null, 
"cautoalfa" char( 8 )  null, 
"compa" char( 20 )  null, 
"ccompori" char( 20 )  null, 
"fechaa" datetime  null, 
"cfecha" datetime  null, 
"cfecori" datetime  null, 
"cgirador" char( 60 )  null, 
"cctaendoso" char( 25 )  null, 
"ctipc" numeric( 2, 0 )  null, 
"celectro" bit  null, 
"cseriea" char( 10 )  null, 
"cleyendoso" char( 55 )  null, 
"ctelgir" char( 30 )  null, 
"cliente" char( 5 )  null, 
"clican" char( 5 )  null, 
"cvend" char( 5 )  null, 
"ccotribgir" char( 15 )  null, 
"cversiona" char( 13 )  null, 
"cpaguesea" char( 50 )  null, 
"cserie" char( 10 )  null, 
"ccotribrut" char( 15 )  null, 
"provcan" char( 5 )  null, 
"provori" char( 5 )  null, 
"cversion" char( 13 )  null, 
"cbdedata" char( 8 )  null, 
"centfin" char( 5 )  null, 
"cbdorig" char( 8 )  null, 
"cmoneda" char( 10 )  null, 
"fechavenci" datetime  null, 
"destde" char( 10 )  null, 
"csigno" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CHEQUE' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CHEQUE' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUE'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fechaorden','fechaorden')
			.AgregarMapeo('fletraa','fletraa')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('ccodcompa','ccodcompa')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('cletra','cletra')
			.AgregarMapeo('ccodcomp','ccodcomp')
			.AgregarMapeo('cvalor','cvalor')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('cobss','cobss')
			.AgregarMapeo('cfecend','cfecend')
			.AgregarMapeo('fptovena','fptovena')
			.AgregarMapeo('cnumero','cnumero')
			.AgregarMapeo('cptovta','cptovta')
			.AgregarMapeo('cusuario','cusuario')
			.AgregarMapeo('numeroc','numeroc')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('fnumcompa','fnumcompa')
			.AgregarMapeo('tipoch','tipoch')
			.AgregarMapeo('cmonto','cmonto')
			.AgregarMapeo('cnum','cnum')
			.AgregarMapeo('centfinend','centfinend')
			.AgregarMapeo('cfechaemi','cfechaemi')
			.AgregarMapeo('ctipca','ctipca')
			.AgregarMapeo('cautori','cautori')
			.AgregarMapeo('cautoalfa','cautoalfa')
			.AgregarMapeo('compa','compa')
			.AgregarMapeo('ccompori','ccompori')
			.AgregarMapeo('fechaa','fechaa')
			.AgregarMapeo('cfecha','cfecha')
			.AgregarMapeo('cfecori','cfecori')
			.AgregarMapeo('cgirador','cgirador')
			.AgregarMapeo('cctaendoso','cctaendoso')
			.AgregarMapeo('ctipc','ctipc')
			.AgregarMapeo('celectro','celectro')
			.AgregarMapeo('cseriea','cseriea')
			.AgregarMapeo('cleyendoso','cleyendoso')
			.AgregarMapeo('ctelgir','ctelgir')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('clican','clican')
			.AgregarMapeo('cvend','cvend')
			.AgregarMapeo('ccotribgir','ccotribgir')
			.AgregarMapeo('cversiona','cversiona')
			.AgregarMapeo('cpaguesea','cpaguesea')
			.AgregarMapeo('cserie','cserie')
			.AgregarMapeo('ccotribrut','ccotribrut')
			.AgregarMapeo('provcan','provcan')
			.AgregarMapeo('provori','provori')
			.AgregarMapeo('cversion','cversion')
			.AgregarMapeo('cbdedata','cbdedata')
			.AgregarMapeo('centfin','centfin')
			.AgregarMapeo('cbdorig','cbdorig')
			.AgregarMapeo('cmoneda','cmoneda')
			.AgregarMapeo('fechavenci','fechavenci')
			.AgregarMapeo('destde','destde')
			.AgregarMapeo('csigno','csigno')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CHEQUE'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECHAORDEN = isnull( d.FECHAORDEN, t.FECHAORDEN ),t.FLETRAA = isnull( d.FLETRAA, t.FLETRAA ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CCODCOMPA = isnull( d.CCODCOMPA, t.CCODCOMPA ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.CLETRA = isnull( d.CLETRA, t.CLETRA ),t.CCODCOMP = isnull( d.CCODCOMP, t.CCODCOMP ),t.CVALOR = isnull( d.CVALOR, t.CVALOR ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.COBSS = isnull( d.COBSS, t.COBSS ),t.CFECEND = isnull( d.CFECEND, t.CFECEND ),t.FPTOVENA = isnull( d.FPTOVENA, t.FPTOVENA ),t.CNUMERO = isnull( d.CNUMERO, t.CNUMERO ),t.CPTOVTA = isnull( d.CPTOVTA, t.CPTOVTA ),t.CUSUARIO = isnull( d.CUSUARIO, t.CUSUARIO ),t.NUMEROC = isnull( d.NUMEROC, t.NUMEROC ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.FNUMCOMPA = isnull( d.FNUMCOMPA, t.FNUMCOMPA ),t.TIPOCH = isnull( d.TIPOCH, t.TIPOCH ),t.CMONTO = isnull( d.CMONTO, t.CMONTO ),t.CNUM = isnull( d.CNUM, t.CNUM ),t.CENTFINEND = isnull( d.CENTFINEND, t.CENTFINEND ),t.CFECHAEMI = isnull( d.CFECHAEMI, t.CFECHAEMI ),t.CTIPCA = isnull( d.CTIPCA, t.CTIPCA ),t.CAUTORI = isnull( d.CAUTORI, t.CAUTORI ),t.CAUTOALFA = isnull( d.CAUTOALFA, t.CAUTOALFA ),t.COMPA = isnull( d.COMPA, t.COMPA ),t.CCOMPORI = isnull( d.CCOMPORI, t.CCOMPORI ),t.FECHAA = isnull( d.FECHAA, t.FECHAA ),t.CFECHA = isnull( d.CFECHA, t.CFECHA ),t.CFECORI = isnull( d.CFECORI, t.CFECORI ),t.CGIRADOR = isnull( d.CGIRADOR, t.CGIRADOR ),t.CCTAENDOSO = isnull( d.CCTAENDOSO, t.CCTAENDOSO ),t.CTIPC = isnull( d.CTIPC, t.CTIPC ),t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),t.CSERIEA = isnull( d.CSERIEA, t.CSERIEA ),t.CLEYENDOSO = isnull( d.CLEYENDOSO, t.CLEYENDOSO ),t.CTELGIR = isnull( d.CTELGIR, t.CTELGIR ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.CLICAN = isnull( d.CLICAN, t.CLICAN ),t.CVEND = isnull( d.CVEND, t.CVEND ),t.CCOTRIBGIR = isnull( d.CCOTRIBGIR, t.CCOTRIBGIR ),t.CVERSIONA = isnull( d.CVERSIONA, t.CVERSIONA ),t.CPAGUESEA = isnull( d.CPAGUESEA, t.CPAGUESEA ),t.CSERIE = isnull( d.CSERIE, t.CSERIE ),t.CCOTRIBRUT = isnull( d.CCOTRIBRUT, t.CCOTRIBRUT ),t.PROVCAN = isnull( d.PROVCAN, t.PROVCAN ),t.PROVORI = isnull( d.PROVORI, t.PROVORI ),t.CVERSION = isnull( d.CVERSION, t.CVERSION ),t.CBDEDATA = isnull( d.CBDEDATA, t.CBDEDATA ),t.CENTFIN = isnull( d.CENTFIN, t.CENTFIN ),t.CBDORIG = isnull( d.CBDORIG, t.CBDORIG ),t.CMONEDA = isnull( d.CMONEDA, t.CMONEDA ),t.FECHAVENCI = isnull( d.FECHAVENCI, t.FECHAVENCI ),t.DESTDE = isnull( d.DESTDE, t.DESTDE ),t.CSIGNO = isnull( d.CSIGNO, t.CSIGNO )
					from ZooLogic.CHEQUE t inner join deleted d 
							 on t.cCod = d.cCod
							 and  t.ptoventa = d.ptoventa
							 and  t.numeroC = d.numeroC
				-- Fin Updates
				insert into ZooLogic.CHEQUE(Fecimpo,Fmodifw,Faltafw,Fecexpo,Fectrans,Fechaorden,Fletraa,Bdaltafw,Ccodcompa,Vmodifw,Smodifw,Saltafw,Ualtafw,Hmodifw,Umodifw,Horaexpo,Horaimpo,Zadsfw,Esttrans,Valtafw,Bdmodifw,Haltafw,Cletra,Ccodcomp,Cvalor,Ptoventa,Ccod,Cobss,Cfecend,Fptovena,Cnumero,Cptovta,Cusuario,Numeroc,Estado,Fnumcompa,Tipoch,Cmonto,Cnum,Centfinend,Cfechaemi,Ctipca,Cautori,Cautoalfa,Compa,Ccompori,Fechaa,Cfecha,Cfecori,Cgirador,Cctaendoso,Ctipc,Celectro,Cseriea,Cleyendoso,Ctelgir,Cliente,Clican,Cvend,Ccotribgir,Cversiona,Cpaguesea,Cserie,Ccotribrut,Provcan,Provori,Cversion,Cbdedata,Centfin,Cbdorig,Cmoneda,Fechavenci,Destde,Csigno)
					Select isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECHAORDEN,''),isnull( d.FLETRAA,''),isnull( d.BDALTAFW,''),isnull( d.CCODCOMPA,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.ZADSFW,''),isnull( d.ESTTRANS,''),isnull( d.VALTAFW,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.CLETRA,''),isnull( d.CCODCOMP,''),isnull( d.CVALOR,''),isnull( d.PTOVENTA,0),isnull( d.CCOD,''),isnull( d.COBSS,''),isnull( d.CFECEND,''),isnull( d.FPTOVENA,0),isnull( d.CNUMERO,0),isnull( d.CPTOVTA,0),isnull( d.CUSUARIO,''),isnull( d.NUMEROC,0),isnull( d.ESTADO,''),isnull( d.FNUMCOMPA,0),isnull( d.TIPOCH,0),isnull( d.CMONTO,0),isnull( d.CNUM,0),isnull( d.CENTFINEND,''),isnull( d.CFECHAEMI,''),isnull( d.CTIPCA,0),isnull( d.CAUTORI,0),isnull( d.CAUTOALFA,''),isnull( d.COMPA,''),isnull( d.CCOMPORI,''),isnull( d.FECHAA,''),isnull( d.CFECHA,''),isnull( d.CFECORI,''),isnull( d.CGIRADOR,''),isnull( d.CCTAENDOSO,''),isnull( d.CTIPC,0),isnull( d.CELECTRO,0),isnull( d.CSERIEA,''),isnull( d.CLEYENDOSO,''),isnull( d.CTELGIR,''),isnull( d.CLIENTE,''),isnull( d.CLICAN,''),isnull( d.CVEND,''),isnull( d.CCOTRIBGIR,''),isnull( d.CVERSIONA,''),isnull( d.CPAGUESEA,''),isnull( d.CSERIE,''),isnull( d.CCOTRIBRUT,''),isnull( d.PROVCAN,''),isnull( d.PROVORI,''),isnull( d.CVERSION,''),isnull( d.CBDEDATA,''),isnull( d.CENTFIN,''),isnull( d.CBDORIG,''),isnull( d.CMONEDA,''),isnull( d.FECHAVENCI,''),isnull( d.DESTDE,''),isnull( d.CSIGNO,0)
						From deleted d left join ZooLogic.CHEQUE pk 
							 on d.cCod = pk.cCod
						 left join ZooLogic.CHEQUE cc 
							 on  d.ptoventa = cc.ptoventa
							 and  d.numeroC = cc.numeroC
						Where pk.cCod Is Null 
							 and cc.ptoventa Is Null 
							 and cc.numeroC Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: PUNTO DE VENTA ' + cast( d.ptoventa as Varchar(4) ) + ', NÚMERO INTERNO ' + cast( d.numeroC as Varchar(8) ) + '','La clave principal no es la esperada'
					from ZooLogic.CHEQUE t inner join deleted d 
							on   t.ptoventa = d.ptoventa
							 and  t.numeroC = d.numeroC
						left join deleted h 
							 on t.cCod = h.cCod
							 where h.cCod is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: PUNTO DE VENTA ' + cast( d.ptoventa as Varchar(4) ) + ', NÚMERO INTERNO ' + cast( d.numeroC as Varchar(8) ) + '','La clave principal a importar ya existe'
					from ZooLogic.CHEQUE t inner join deleted d 
							 on t.cCod = d.cCod
						left join deleted h 
							on   t.ptoventa = h.ptoventa
							 and   t.numeroC = h.numeroC
							where   h.ptoventa is null 
							 and   h.numeroC is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CHEQUEHIST( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CHEQUE_CHEQUEHIST
ON ZooLogic.TablaTrabajo_CHEQUE_CHEQUEHIST
AFTER DELETE
As
Begin
Update t Set 
t.PROVEEDDES = isnull( d.PROVEEDDES, t.PROVEEDDES ),
t.DESTDESCDE = isnull( d.DESTDESCDE, t.DESTDESCDE ),
t.VENDEDDES = isnull( d.VENDEDDES, t.VENDEDDES ),
t.CLIENTEDES = isnull( d.CLIENTEDES, t.CLIENTEDES ),
t.CTABANCDES = isnull( d.CTABANCDES, t.CTABANCDES ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CVERSION = isnull( d.CVERSION, t.CVERSION ),
t.CSERIE = isnull( d.CSERIE, t.CSERIE ),
t.IDENTIFENT = isnull( d.IDENTIFENT, t.IDENTIFENT ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.CODIGOCOMP = isnull( d.CODIGOCOMP, t.CODIGOCOMP ),
t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),
t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.DESTDESC = isnull( d.DESTDESC, t.DESTDESC ),
t.CTABANC = isnull( d.CTABANC, t.CTABANC ),
t.FECHA = isnull( d.FECHA, t.FECHA ),
t.HORA = isnull( d.HORA, t.HORA ),
t.TIPOCOMP = isnull( d.TIPOCOMP, t.TIPOCOMP ),
t.COMPROB = isnull( d.COMPROB, t.COMPROB ),
t.CONCEPTO = isnull( d.CONCEPTO, t.CONCEPTO ),
t.CONCEPTDES = isnull( d.CONCEPTDES, t.CONCEPTDES ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.CAJADESC = isnull( d.CAJADESC, t.CAJADESC ),
t.BASEORIGEN = isnull( d.BASEORIGEN, t.BASEORIGEN ),
t.ESTADO = isnull( d.ESTADO, t.ESTADO )
from ZooLogic.CHEQUEHIST t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CHEQUEHIST
( 
"PROVEEDDES",
"DESTDESCDE",
"VENDEDDES",
"CLIENTEDES",
"CTABANCDES",
"NROITEM",
"CVERSION",
"CSERIE",
"IDENTIFENT",
"CLIENTE",
"CODIGOCOMP",
"PROVEEDOR",
"VENDEDOR",
"CODIGO",
"DESTDESC",
"CTABANC",
"FECHA",
"HORA",
"TIPOCOMP",
"COMPROB",
"CONCEPTO",
"CONCEPTDES",
"TIPO",
"IDCAJA",
"CAJADESC",
"BASEORIGEN",
"ESTADO"
 )
Select 
d.PROVEEDDES,
d.DESTDESCDE,
d.VENDEDDES,
d.CLIENTEDES,
d.CTABANCDES,
d.NROITEM,
d.CVERSION,
d.CSERIE,
d.IDENTIFENT,
d.CLIENTE,
d.CODIGOCOMP,
d.PROVEEDOR,
d.VENDEDOR,
d.CODIGO,
d.DESTDESC,
d.CTABANC,
d.FECHA,
d.HORA,
d.TIPOCOMP,
d.COMPROB,
d.CONCEPTO,
d.CONCEPTDES,
d.TIPO,
d.IDCAJA,
d.CAJADESC,
d.BASEORIGEN,
d.ESTADO
From deleted d left join ZooLogic.CHEQUEHIST pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CHEQUE') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CHEQUE
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CHEQUE' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaordenamiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaordenamiento, ctod( '  /  /    ' ) ) )
					.Letraafectante = nvl( c_CHEQUE.Letraafectante, [] )
					.Basededatosaltafw = nvl( c_CHEQUE.Basededatosaltafw, [] )
					.Codigocomprobanteafectante = nvl( c_CHEQUE.Codigocomprobanteafectante, [] )
					.Versionmodificacionfw = nvl( c_CHEQUE.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_CHEQUE.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_CHEQUE.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_CHEQUE.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_CHEQUE.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_CHEQUE.Usuariomodificacionfw, [] )
					.Horaexpo = nvl( c_CHEQUE.Horaexpo, [] )
					.Horaimpo = nvl( c_CHEQUE.Horaimpo, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Estadotransferencia = nvl( c_CHEQUE.Estadotransferencia, [] )
					.Versionaltafw = nvl( c_CHEQUE.Versionaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_CHEQUE.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_CHEQUE.Horaaltafw, [] )
					.Letraorigen = nvl( c_CHEQUE.Letraorigen, [] )
					.Codigocomprobanteorigen = nvl( c_CHEQUE.Codigocomprobanteorigen, [] )
					.Valor = nvl( c_CHEQUE.Valor, [] )
					.Puntodeventa = nvl( c_CHEQUE.Puntodeventa, 0 )
					.Codigo = nvl( c_CHEQUE.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Historialdetalle.Limpiar()
					.Historialdetalle.SetearEsNavegacion( .lProcesando )
					.Historialdetalle.Cargar()
					.Fechaendoso = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaendoso, ctod( '  /  /    ' ) ) )
					.Puntodeventaafectante = nvl( c_CHEQUE.Puntodeventaafectante, 0 )
					.Numero = nvl( c_CHEQUE.Numero, 0 )
					.Puntodeventaorigen = nvl( c_CHEQUE.Puntodeventaorigen, 0 )
					.Usuarioorigen = nvl( c_CHEQUE.Usuarioorigen, [] )
					.Numeroc = nvl( c_CHEQUE.Numeroc, 0 )
					.Estado = nvl( c_CHEQUE.Estado, [] )
					.Numeroafectante = nvl( c_CHEQUE.Numeroafectante, 0 )
					.Tipo = nvl( c_CHEQUE.Tipo, 0 )
					.Monto = nvl( c_CHEQUE.Monto, 0 )
					.Numeroorigen = nvl( c_CHEQUE.Numeroorigen, 0 )
					.Entidadfinancieraendoso_PK =  nvl( c_CHEQUE.Entidadfinancieraendoso, [] )
					.Fechaemision = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaemision, ctod( '  /  /    ' ) ) )
					.Tipodecomprobanteafectante = nvl( c_CHEQUE.Tipodecomprobanteafectante, 0 )
					.Autorizacion = nvl( c_CHEQUE.Autorizacion, 0 )
					.Autorizacionalfa = nvl( c_CHEQUE.Autorizacionalfa, [] )
					.Comprobanteafectante = nvl( c_CHEQUE.Comprobanteafectante, [] )
					.Comprobanteorigen = nvl( c_CHEQUE.Comprobanteorigen, [] )
					.Fechaafectante = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaafectante, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fecha, ctod( '  /  /    ' ) ) )
					.Fechaorigen = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechaorigen, ctod( '  /  /    ' ) ) )
					.Nombrelibrador = nvl( c_CHEQUE.Nombrelibrador, [] )
					.Cuentaendoso = nvl( c_CHEQUE.Cuentaendoso, [] )
					.Tipodecomprobanteorigen = nvl( c_CHEQUE.Tipodecomprobanteorigen, 0 )
					.Chequeelectronico = nvl( c_CHEQUE.Chequeelectronico, .F. )
					.Cserieafectante = nvl( c_CHEQUE.Cserieafectante, [] )
					.Leyendaendoso = nvl( c_CHEQUE.Leyendaendoso, [] )
					.Telefonolibrador = nvl( c_CHEQUE.Telefonolibrador, [] )
					.Cliente_PK =  nvl( c_CHEQUE.Cliente, [] )
					.Clienteafectante_PK =  nvl( c_CHEQUE.Clienteafectante, [] )
					.Vendedor_PK =  nvl( c_CHEQUE.Vendedor, [] )
					.Codigotributariolibrador = nvl( c_CHEQUE.Codigotributariolibrador, [] )
					.Cversionafectante = nvl( c_CHEQUE.Cversionafectante, [] )
					.Paguesea = nvl( c_CHEQUE.Paguesea, [] )
					.Serieorigen = nvl( c_CHEQUE.Serieorigen, [] )
					.Codigotributariolibradorrut = nvl( c_CHEQUE.Codigotributariolibradorrut, [] )
					.Proveedorafectante_PK =  nvl( c_CHEQUE.Proveedorafectante, [] )
					.Proveedor_PK =  nvl( c_CHEQUE.Proveedor, [] )
					.Cversionorigen = nvl( c_CHEQUE.Cversionorigen, [] )
					.Cbasededatosafectante = nvl( c_CHEQUE.Cbasededatosafectante, [] )
					.Entidadfinanciera_PK =  nvl( c_CHEQUE.Entidadfinanciera, [] )
					.Bdorigen = nvl( c_CHEQUE.Bdorigen, [] )
					.Moneda_PK =  nvl( c_CHEQUE.Moneda, [] )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUE.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Destinodedescargaencheque_PK =  nvl( c_CHEQUE.Destinodedescargaencheque, [] )
					.Signodemovimientoorigen = nvl( c_CHEQUE.Signodemovimientoorigen, 0 )
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
			lxRetorno = c_CHEQUE.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.HistorialDetalle
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
		return c_CHEQUE.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CHEQUE' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,cCod as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    cCod from (
							select * 
								from ZooLogic.CHEQUE 
								Where   CHEQUE.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CHEQUE", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "cCod"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fechaorden" as "Fechaordenamiento", "Fletraa" as "Letraafectante", "Bdaltafw" as "Basededatosaltafw", "Ccodcompa" as "Codigocomprobanteafectante", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Zadsfw" as "Zadsfw", "Esttrans" as "Estadotransferencia", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Cletra" as "Letraorigen", "Ccodcomp" as "Codigocomprobanteorigen", "Cvalor" as "Valor", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Cobss" as "Observacion", "Cfecend" as "Fechaendoso", "Fptovena" as "Puntodeventaafectante", "Cnumero" as "Numero", "Cptovta" as "Puntodeventaorigen", "Cusuario" as "Usuarioorigen", "Numeroc" as "Numeroc", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cmonto" as "Monto", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Cfechaemi" as "Fechaemision", "Ctipca" as "Tipodecomprobanteafectante", "Cautori" as "Autorizacion", "Cautoalfa" as "Autorizacionalfa", "Compa" as "Comprobanteafectante", "Ccompori" as "Comprobanteorigen", "Fechaa" as "Fechaafectante", "Cfecha" as "Fecha", "Cfecori" as "Fechaorigen", "Cgirador" as "Nombrelibrador", "Cctaendoso" as "Cuentaendoso", "Ctipc" as "Tipodecomprobanteorigen", "Celectro" as "Chequeelectronico", "Cseriea" as "Cserieafectante", "Cleyendoso" as "Leyendaendoso", "Ctelgir" as "Telefonolibrador", "Cliente" as "Cliente", "Clican" as "Clienteafectante", "Cvend" as "Vendedor", "Ccotribgir" as "Codigotributariolibrador", "Cversiona" as "Cversionafectante", "Cpaguesea" as "Paguesea", "Cserie" as "Serieorigen", "Ccotribrut" as "Codigotributariolibradorrut", "Provcan" as "Proveedorafectante", "Provori" as "Proveedor", "Cversion" as "Cversionorigen", "Cbdedata" as "Cbasededatosafectante", "Centfin" as "Entidadfinanciera", "Cbdorig" as "Bdorigen", "Cmoneda" as "Moneda", "Fechavenci" as "Fechavencimiento", "Destde" as "Destinodedescargaencheque", "Csigno" as "Signodemovimientoorigen"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CHEQUE 
								Where   CHEQUE.CCOD != ''
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
	Tabla = 'CHEQUE'
	Filtro = " CHEQUE.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CHEQUE.CCOD != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "CHEQUE.FechaOrden"
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
	<row entidad="CHEQUE                                  " atributo="FECHAIMPO                               " tabla="CHEQUE         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAMODIFICACIONFW                     " tabla="CHEQUE         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAALTAFW                             " tabla="CHEQUE         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAEXPO                               " tabla="CHEQUE         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHATRANSFERENCIA                      " tabla="CHEQUE         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAORDENAMIENTO                       " tabla="CHEQUE         " campo="FECHAORDEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Fecha de ordenamiento                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="LETRAAFECTANTE                          " tabla="CHEQUE         " campo="FLETRAA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra comprobante afectante                                                                                                                                     " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="BASEDEDATOSALTAFW                       " tabla="CHEQUE         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CODIGOCOMPROBANTEAFECTANTE              " tabla="CHEQUE         " campo="CCODCOMPA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo del comprobante afectante                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="VERSIONMODIFICACIONFW                   " tabla="CHEQUE         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="SERIEMODIFICACIONFW                     " tabla="CHEQUE         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="SERIEALTAFW                             " tabla="CHEQUE         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="USUARIOALTAFW                           " tabla="CHEQUE         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="HORAMODIFICACIONFW                      " tabla="CHEQUE         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="USUARIOMODIFICACIONFW                   " tabla="CHEQUE         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="HORAEXPO                                " tabla="CHEQUE         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="HORAIMPO                                " tabla="CHEQUE         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="ZADSFW                                  " tabla="CHEQUE         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="ESTADOTRANSFERENCIA                     " tabla="CHEQUE         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="VERSIONALTAFW                           " tabla="CHEQUE         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CHEQUE         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="HORAALTAFW                              " tabla="CHEQUE         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="DESCRIPCIONTIPOCOMPROBANTEAFECTANTE     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante afectante descripción                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="LETRAORIGEN                             " tabla="CHEQUE         " campo="CLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra comprobante origen                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="DESCRIPCIONTIPOCOMPROBANTEORIGEN        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante origen descripción                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CODIGOCOMPROBANTEORIGEN                 " tabla="CHEQUE         " campo="CCODCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo del comprobante                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="VALOR                                   " tabla="CHEQUE         " campo="CVALOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Valor                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="PUNTODEVENTA                            " tabla="CHEQUE         " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="@ObtenerValorSugeridoPuntodeventa()                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="2" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CODIGO                                  " tabla="CHEQUE         " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="OBSERVACION                             " tabla="CHEQUE         " campo="COBSS     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="HISTORIALDETALLE                        " tabla="CHEQUEHIST     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Historial de interacciones                                                                                                                                      " dominio="DETALLEITEMCHEQUEHISTORIAL    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAENDOSO                             " tabla="CHEQUE         " campo="CFECEND   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="404" etiqueta="Fecha de endoso                                                                                                                                                 " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="PUNTODEVENTAAFECTANTE                   " tabla="CHEQUE         " campo="FPTOVENA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Pto. Venta                                                                                                                                                      " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="NUMERO                                  " tabla="CHEQUE         " campo="CNUMERO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="PUNTODEVENTAORIGEN                      " tabla="CHEQUE         " campo="CPTOVTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto venta comprobante origen                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="USUARIOORIGEN                           " tabla="CHEQUE         " campo="CUSUARIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="0" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="NUMEROC                                 " tabla="CHEQUE         " campo="NUMEROC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número interno                                                                                                                                                  " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="ESTADO                                  " tabla="CHEQUE         " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Estado                                                                                                                                                          " dominio="COMBOSERVICIOCHEQUE           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="NUMEROAFECTANTE                         " tabla="CHEQUE         " campo="FNUMCOMPA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número comprobante afectante                                                                                                                                    " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="TIPO                                    " tabla="CHEQUE         " campo="TIPOCH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPODEVALORES            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="MONTO                                   " tabla="CHEQUE         " campo="CMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="NUMEROORIGEN                            " tabla="CHEQUE         " campo="CNUM      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número comprobante origen                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="ENTIDADFINANCIERAENDOSO                 " tabla="CHEQUE         " campo="CENTFINEND" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Entidad financiera de endoso                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAEMISION                            " tabla="CHEQUE         " campo="CFECHAEMI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="12" etiqueta="Fecha de emisión                                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="TIPODECOMPROBANTEAFECTANTE              " tabla="CHEQUE         " campo="CTIPCA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo comprobante afectante                                                                                                                                      " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="AUTORIZACION                            " tabla="CHEQUE         " campo="CAUTORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número de autorización de cheque                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999-999999               " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="AUTORIZACIONALFA                        " tabla="CHEQUE         " campo="CAUTOALFA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Autorización de cheque                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="COMPROBANTEAFECTANTE                    " tabla="CHEQUE         " campo="COMPA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Identificador del comprobante de cancelación                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="COMPROBANTEORIGEN                       " tabla="CHEQUE         " campo="CCOMPORI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Identificador                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAAFECTANTE                          " tabla="CHEQUE         " campo="FECHAA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de comprobante cancelación                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHA                                   " tabla="CHEQUE         " campo="CFECHA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha() + 1                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="14" etiqueta="Fecha de pago                                                                                                                                                   " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAORIGEN                             " tabla="CHEQUE         " campo="CFECORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de comprobante origen                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="NOMBRELIBRADOR                          " tabla="CHEQUE         " campo="CGIRADOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Librador                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CUENTAENDOSO                            " tabla="CHEQUE         " campo="CCTAENDOSO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Cuenta                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="TIPODECOMPROBANTEORIGEN                 " tabla="CHEQUE         " campo="CTIPC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo comprobante origen                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CHEQUEELECTRONICO                       " tabla="CHEQUE         " campo="CELECTRO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .F.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="22" etiqueta="Cheque electrónico                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CSERIEAFECTANTE                         " tabla="CHEQUE         " campo="CSERIEA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie afectante                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="LEYENDAENDOSO                           " tabla="CHEQUE         " campo="CLEYENDOSO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="55" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Leyenda                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="TELEFONOLIBRADOR                        " tabla="CHEQUE         " campo="CTELGIR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CLIENTE                                 " tabla="CHEQUE         " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente origen                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CLIENTEAFECTANTE                        " tabla="CHEQUE         " campo="CLICAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente del comprobante de cancelación                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="VENDEDOR                                " tabla="CHEQUE         " campo="CVEND     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CODIGOTRIBUTARIOLIBRADOR                " tabla="CHEQUE         " campo="CCOTRIBGIR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="C.U.I.T. del librador                                                                                                                                           " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CVERSIONAFECTANTE                       " tabla="CHEQUE         " campo="CVERSIONA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión afectante                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="PAGUESEA                                " tabla="CHEQUE         " campo="CPAGUESEA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Páguese a                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="SERIEORIGEN                             " tabla="CHEQUE         " campo="CSERIE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="0" etiqueta="Serie origen                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CODIGOTRIBUTARIOLIBRADORRUT             " tabla="CHEQUE         " campo="CCOTRIBRUT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="RUT                                                                                                                                                             " dominio="RUT                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999999-X              " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="PROVEEDORAFECTANTE                      " tabla="CHEQUE         " campo="PROVCAN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Proveedor del comprobante de cancelación                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="PROVEEDOR                               " tabla="CHEQUE         " campo="PROVORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CVERSIONORIGEN                          " tabla="CHEQUE         " campo="CVERSION  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="=_screen.zoo.app.ObtenerVersion()                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Versión origen                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="CBASEDEDATOSAFECTANTE                   " tabla="CHEQUE         " campo="CBDEDATA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos de cancelación                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="ENTIDADFINANCIERA                       " tabla="CHEQUE         " campo="CENTFIN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="18" etiqueta="Entidad financiera del cheque                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="BDORIGEN                                " tabla="CHEQUE         " campo="CBDORIG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="MONEDA                                  " tabla="CHEQUE         " campo="CMONEDA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=goParametros.Felino.Generales.MonedaSistema                                                                                                                                                                                                                  " obligatorio="false" admitebusqueda="20" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="FECHAVENCIMIENTO                        " tabla="CHEQUE         " campo="FECHAVENCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="DESTINODEDESCARGAENCHEQUE               " tabla="CHEQUE         " campo="DESTDE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DESTINODESCARGACHEQUES                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Destino de descarga en cheque                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUE                                  " atributo="SIGNODEMOVIMIENTOORIGEN                 " tabla="CHEQUE         " campo="CSIGNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Signo de Movimiento                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On CHEQUE.CENTFINEND = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="19" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On CHEQUE.CENTFIN = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CHEQUE.CMONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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