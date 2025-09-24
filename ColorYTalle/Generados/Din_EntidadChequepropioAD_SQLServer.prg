
define class Din_EntidadCHEQUEPROPIOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_CHEQUEPROPIO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( PuntoDeVenta, 4, 0) + str( NumeroC, 8, 0)]
	cExpresionCCPorCampos = [str( #tabla#.ptoventa, 4, 0) + str( #tabla#.numeroC, 8, 0)]
	cTagClaveCandidata = '_CPCC'
	cTagClavePk = '_CPPK'
	cTablaPrincipal = 'CHQPROP'
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
			local  lxChqpropFaltafw, lxChqpropFechaorden, lxChqpropFecexpo, lxChqpropFecimpo, lxChqpropFectrans, lxChqpropFmodifw, lxChqpropFletraa, lxChqpropUmodifw, lxChqpropUaltafw, lxChqpropSmodifw, lxChqpropHmodifw, lxChqpropSaltafw, lxChqpropBdmodifw, lxChqpropCvalor, lxChqpropEsttrans, lxChqpropBdaltafw, lxChqpropHaltafw, lxChqpropHoraexpo, lxChqpropHoraimpo, lxChqpropCcodcompa, lxChqpropZadsfw, lxChqpropCcodcomp, lxChqpropCletra, lxChqpropVmodifw, lxChqpropValtafw, lxChqpropAnulado, lxChqpropPtoventa, lxChqpropCcod, lxChqpropChequera, lxChqpropCobss, lxChqpropFptovena, lxChqpropCusuario, lxChqpropCptovta, lxChqpropNumeroc, lxChqpropCentfin, lxChqpropEstado, lxChqpropFnumcompa, lxChqpropTipoch, lxChqpropCnumero, lxChqpropCnum, lxChqpropCentfinend, lxChqpropCtipca, lxChqpropCcompori, lxChqpropCompa, lxChqpropCctaendoso, lxChqpropCelectro, lxChqpropFechaa, lxChqpropCfecori, lxChqpropCpaguesea, lxChqpropCmonto, lxChqpropCseriea, lxChqpropClafec, lxChqpropCliente, lxChqpropCvend, lxChqpropCfechaemi, lxChqpropCversiona, lxChqpropCserie, lxChqpropCtipc, lxChqpropPrvafec, lxChqpropCfecend, lxChqpropCfecha, lxChqpropCautoalfa, lxChqpropCbdedata, lxChqpropCversion, lxChqpropCautori, lxChqpropCbdorig, lxChqpropCleyendoso, lxChqpropFechavenci, lxChqpropCmoneda, lxChqpropPrvorig, lxChqpropCsigno
				lxChqpropFaltafw =  .Fechaaltafw			lxChqpropFechaorden =  .Fechaordenamiento			lxChqpropFecexpo =  .Fechaexpo			lxChqpropFecimpo =  .Fechaimpo			lxChqpropFectrans =  .Fechatransferencia			lxChqpropFmodifw =  .Fechamodificacionfw			lxChqpropFletraa =  .Letraafectante			lxChqpropUmodifw =  .Usuariomodificacionfw			lxChqpropUaltafw =  .Usuarioaltafw			lxChqpropSmodifw =  .Seriemodificacionfw			lxChqpropHmodifw =  .Horamodificacionfw			lxChqpropSaltafw =  .Seriealtafw			lxChqpropBdmodifw =  .Basededatosmodificacionfw			lxChqpropCvalor =  .Valor			lxChqpropEsttrans =  .Estadotransferencia			lxChqpropBdaltafw =  .Basededatosaltafw			lxChqpropHaltafw =  .Horaaltafw			lxChqpropHoraexpo =  .Horaexpo			lxChqpropHoraimpo =  .Horaimpo			lxChqpropCcodcompa =  .Codigocomprobanteafectante			lxChqpropZadsfw =  .Zadsfw			lxChqpropCcodcomp =  .Codigocomprobanteorigen			lxChqpropCletra =  .Letraorigen			lxChqpropVmodifw =  .Versionmodificacionfw			lxChqpropValtafw =  .Versionaltafw			lxChqpropAnulado =  .Anulado			lxChqpropPtoventa =  .Puntodeventa			lxChqpropCcod =  .Codigo			lxChqpropChequera =  upper( .Chequera_PK ) 			lxChqpropCobss =  .Observacion			lxChqpropFptovena =  .Puntodeventaafectante			lxChqpropCusuario =  .Usuarioorigen			lxChqpropCptovta =  .Puntodeventaorigen			lxChqpropNumeroc =  .Numeroc			lxChqpropCentfin =  upper( .EntidadFinanciera_PK ) 			lxChqpropEstado =  .Estado			lxChqpropFnumcompa =  .Numeroafectante			lxChqpropTipoch =  .Tipo			lxChqpropCnumero =  .Numero			lxChqpropCnum =  .Numeroorigen			lxChqpropCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChqpropCtipca =  .Tipodecomprobanteafectante			lxChqpropCcompori =  .Comprobanteorigen			lxChqpropCompa =  .Comprobanteafectante			lxChqpropCctaendoso =  .Cuentaendoso			lxChqpropCelectro =  .Chequeelectronico			lxChqpropFechaa =  .Fechaafectante			lxChqpropCfecori =  .Fechaorigen			lxChqpropCpaguesea =  .Paguesea			lxChqpropCmonto =  .Monto			lxChqpropCseriea =  .Cserieafectante			lxChqpropClafec =  upper( .ClienteAfectante_PK ) 			lxChqpropCliente =  upper( .Cliente_PK ) 			lxChqpropCvend =  upper( .Vendedor_PK ) 			lxChqpropCfechaemi =  .Fechaemision			lxChqpropCversiona =  .Cversionafectante			lxChqpropCserie =  .Serieorigen			lxChqpropCtipc =  .Tipodecomprobanteorigen			lxChqpropPrvafec =  upper( .ProveedorAfectante_PK ) 			lxChqpropCfecend =  .Fechaendoso			lxChqpropCfecha =  .Fecha			lxChqpropCautoalfa =  .Autorizacionalfa			lxChqpropCbdedata =  .Cbasededatosafectante			lxChqpropCversion =  .Cversionorigen			lxChqpropCautori =  .Autorizacion			lxChqpropCbdorig =  .Bdorigen			lxChqpropCleyendoso =  .Leyendaendoso			lxChqpropFechavenci =  .Fechavencimiento			lxChqpropCmoneda =  upper( .Moneda_PK ) 			lxChqpropPrvorig =  upper( .Proveedor_PK ) 			lxChqpropCsigno =  .Signodemovimientoorigen
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxChqpropCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.CHQPROP ( "Faltafw","Fechaorden","Fecexpo","Fecimpo","Fectrans","Fmodifw","Fletraa","Umodifw","Ualtafw","Smodifw","Hmodifw","Saltafw","Bdmodifw","Cvalor","Esttrans","Bdaltafw","Haltafw","Horaexpo","Horaimpo","Ccodcompa","Zadsfw","Ccodcomp","Cletra","Vmodifw","Valtafw","Anulado","Ptoventa","Ccod","Chequera","Cobss","Fptovena","Cusuario","Cptovta","Numeroc","Centfin","Estado","Fnumcompa","Tipoch","Cnumero","Cnum","Centfinend","Ctipca","Ccompori","Compa","Cctaendoso","Celectro","Fechaa","Cfecori","Cpaguesea","Cmonto","Cseriea","Clafec","Cliente","Cvend","Cfechaemi","Cversiona","Cserie","Ctipc","Prvafec","Cfecend","Cfecha","Cautoalfa","Cbdedata","Cversion","Cautori","Cbdorig","Cleyendoso","Fechavenci","Cmoneda","Prvorig","Csigno" ) values ( <<"'" + this.ConvertirDateSql( lxChqpropFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFechaorden ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropFletraa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCvalor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCcodcompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCcodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropValtafw ) + "'" >>, <<iif( lxChqpropAnulado, 1, 0 ) >>, <<lxChqpropPtoventa >>, <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropChequera ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCobss ) + "'" >>, <<lxChqpropFptovena >>, <<"'" + this.FormatearTextoSql( lxChqpropCusuario ) + "'" >>, <<lxChqpropCptovta >>, <<lxChqpropNumeroc >>, <<"'" + this.FormatearTextoSql( lxChqpropCentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropEstado ) + "'" >>, <<lxChqpropFnumcompa >>, <<lxChqpropTipoch >>, <<lxChqpropCnumero >>, <<lxChqpropCnum >>, <<"'" + this.FormatearTextoSql( lxChqpropCentfinend ) + "'" >>, <<lxChqpropCtipca >>, <<"'" + this.FormatearTextoSql( lxChqpropCcompori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCctaendoso ) + "'" >>, <<iif( lxChqpropCelectro, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxChqpropFechaa ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfecori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCpaguesea ) + "'" >>, <<lxChqpropCmonto >>, <<"'" + this.FormatearTextoSql( lxChqpropCseriea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropClafec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCvend ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfechaemi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCversiona ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCserie ) + "'" >>, <<lxChqpropCtipc >>, <<"'" + this.FormatearTextoSql( lxChqpropPrvafec ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfecend ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCautoalfa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCbdedata ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCversion ) + "'" >>, <<lxChqpropCautori >>, <<"'" + this.FormatearTextoSql( lxChqpropCbdorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCleyendoso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFechavenci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCmoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropPrvorig ) + "'" >>, <<lxChqpropCsigno >> )
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
					
					lxProveedor = loItem.Proveedor
					lxSerie = loItem.Serie
					lxVendedor = loItem.Vendedor
					lxCliente = loItem.Cliente
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxVersion = loItem.Version
					lxNroitem = lnContadorNroItem
					lxClientedescripcion = loItem.Clientedescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
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
						Insert into ZooLogic.CHPROPHIST("Proveedor","cSerie","Vendedor","Cliente","IdentifEnt","CodigoComp","cVersion","NROITEM","ClienteDes","VendedDes","ProveedDes","CtaBancDes","CtaBanc","Codigo","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxChqpropFaltafw, lxChqpropFechaorden, lxChqpropFecexpo, lxChqpropFecimpo, lxChqpropFectrans, lxChqpropFmodifw, lxChqpropFletraa, lxChqpropUmodifw, lxChqpropUaltafw, lxChqpropSmodifw, lxChqpropHmodifw, lxChqpropSaltafw, lxChqpropBdmodifw, lxChqpropCvalor, lxChqpropEsttrans, lxChqpropBdaltafw, lxChqpropHaltafw, lxChqpropHoraexpo, lxChqpropHoraimpo, lxChqpropCcodcompa, lxChqpropZadsfw, lxChqpropCcodcomp, lxChqpropCletra, lxChqpropVmodifw, lxChqpropValtafw, lxChqpropAnulado, lxChqpropPtoventa, lxChqpropCcod, lxChqpropChequera, lxChqpropCobss, lxChqpropFptovena, lxChqpropCusuario, lxChqpropCptovta, lxChqpropNumeroc, lxChqpropCentfin, lxChqpropEstado, lxChqpropFnumcompa, lxChqpropTipoch, lxChqpropCnumero, lxChqpropCnum, lxChqpropCentfinend, lxChqpropCtipca, lxChqpropCcompori, lxChqpropCompa, lxChqpropCctaendoso, lxChqpropCelectro, lxChqpropFechaa, lxChqpropCfecori, lxChqpropCpaguesea, lxChqpropCmonto, lxChqpropCseriea, lxChqpropClafec, lxChqpropCliente, lxChqpropCvend, lxChqpropCfechaemi, lxChqpropCversiona, lxChqpropCserie, lxChqpropCtipc, lxChqpropPrvafec, lxChqpropCfecend, lxChqpropCfecha, lxChqpropCautoalfa, lxChqpropCbdedata, lxChqpropCversion, lxChqpropCautori, lxChqpropCbdorig, lxChqpropCleyendoso, lxChqpropFechavenci, lxChqpropCmoneda, lxChqpropPrvorig, lxChqpropCsigno
				lxChqpropFaltafw =  .Fechaaltafw			lxChqpropFechaorden =  .Fechaordenamiento			lxChqpropFecexpo =  .Fechaexpo			lxChqpropFecimpo =  .Fechaimpo			lxChqpropFectrans =  .Fechatransferencia			lxChqpropFmodifw =  .Fechamodificacionfw			lxChqpropFletraa =  .Letraafectante			lxChqpropUmodifw =  .Usuariomodificacionfw			lxChqpropUaltafw =  .Usuarioaltafw			lxChqpropSmodifw =  .Seriemodificacionfw			lxChqpropHmodifw =  .Horamodificacionfw			lxChqpropSaltafw =  .Seriealtafw			lxChqpropBdmodifw =  .Basededatosmodificacionfw			lxChqpropCvalor =  .Valor			lxChqpropEsttrans =  .Estadotransferencia			lxChqpropBdaltafw =  .Basededatosaltafw			lxChqpropHaltafw =  .Horaaltafw			lxChqpropHoraexpo =  .Horaexpo			lxChqpropHoraimpo =  .Horaimpo			lxChqpropCcodcompa =  .Codigocomprobanteafectante			lxChqpropZadsfw =  .Zadsfw			lxChqpropCcodcomp =  .Codigocomprobanteorigen			lxChqpropCletra =  .Letraorigen			lxChqpropVmodifw =  .Versionmodificacionfw			lxChqpropValtafw =  .Versionaltafw			lxChqpropAnulado =  .Anulado			lxChqpropPtoventa =  .Puntodeventa			lxChqpropCcod =  .Codigo			lxChqpropChequera =  upper( .Chequera_PK ) 			lxChqpropCobss =  .Observacion			lxChqpropFptovena =  .Puntodeventaafectante			lxChqpropCusuario =  .Usuarioorigen			lxChqpropCptovta =  .Puntodeventaorigen			lxChqpropNumeroc =  .Numeroc			lxChqpropCentfin =  upper( .EntidadFinanciera_PK ) 			lxChqpropEstado =  .Estado			lxChqpropFnumcompa =  .Numeroafectante			lxChqpropTipoch =  .Tipo			lxChqpropCnumero =  .Numero			lxChqpropCnum =  .Numeroorigen			lxChqpropCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChqpropCtipca =  .Tipodecomprobanteafectante			lxChqpropCcompori =  .Comprobanteorigen			lxChqpropCompa =  .Comprobanteafectante			lxChqpropCctaendoso =  .Cuentaendoso			lxChqpropCelectro =  .Chequeelectronico			lxChqpropFechaa =  .Fechaafectante			lxChqpropCfecori =  .Fechaorigen			lxChqpropCpaguesea =  .Paguesea			lxChqpropCmonto =  .Monto			lxChqpropCseriea =  .Cserieafectante			lxChqpropClafec =  upper( .ClienteAfectante_PK ) 			lxChqpropCliente =  upper( .Cliente_PK ) 			lxChqpropCvend =  upper( .Vendedor_PK ) 			lxChqpropCfechaemi =  .Fechaemision			lxChqpropCversiona =  .Cversionafectante			lxChqpropCserie =  .Serieorigen			lxChqpropCtipc =  .Tipodecomprobanteorigen			lxChqpropPrvafec =  upper( .ProveedorAfectante_PK ) 			lxChqpropCfecend =  .Fechaendoso			lxChqpropCfecha =  .Fecha			lxChqpropCautoalfa =  .Autorizacionalfa			lxChqpropCbdedata =  .Cbasededatosafectante			lxChqpropCversion =  .Cversionorigen			lxChqpropCautori =  .Autorizacion			lxChqpropCbdorig =  .Bdorigen			lxChqpropCleyendoso =  .Leyendaendoso			lxChqpropFechavenci =  .Fechavencimiento			lxChqpropCmoneda =  upper( .Moneda_PK ) 			lxChqpropPrvorig =  upper( .Proveedor_PK ) 			lxChqpropCsigno =  .Signodemovimientoorigen
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.CHQPROP set "Faltafw" = <<"'" + this.ConvertirDateSql( lxChqpropFaltafw ) + "'">>,"Fechaorden" = <<"'" + this.ConvertirDateSql( lxChqpropFechaorden ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxChqpropFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxChqpropFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxChqpropFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxChqpropFmodifw ) + "'">>,"Fletraa" = <<"'" + this.FormatearTextoSql( lxChqpropFletraa ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxChqpropUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxChqpropUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxChqpropSmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxChqpropHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxChqpropSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxChqpropBdmodifw ) + "'">>,"Cvalor" = <<"'" + this.FormatearTextoSql( lxChqpropCvalor ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxChqpropEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxChqpropBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxChqpropHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxChqpropHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxChqpropHoraimpo ) + "'">>,"Ccodcompa" = <<"'" + this.FormatearTextoSql( lxChqpropCcodcompa ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxChqpropZadsfw ) + "'">>,"Ccodcomp" = <<"'" + this.FormatearTextoSql( lxChqpropCcodcomp ) + "'">>,"Cletra" = <<"'" + this.FormatearTextoSql( lxChqpropCletra ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxChqpropVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxChqpropValtafw ) + "'">>,"Anulado" = <<iif( lxChqpropAnulado, 1, 0 )>>,"Ptoventa" = <<lxChqpropPtoventa>>,"Ccod" = <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'">>,"Chequera" = <<"'" + this.FormatearTextoSql( lxChqpropChequera ) + "'">>,"Cobss" = <<"'" + this.FormatearTextoSql( lxChqpropCobss ) + "'">>,"Fptovena" = <<lxChqpropFptovena>>,"Cusuario" = <<"'" + this.FormatearTextoSql( lxChqpropCusuario ) + "'">>,"Cptovta" = <<lxChqpropCptovta>>,"Numeroc" = <<lxChqpropNumeroc>>,"Centfin" = <<"'" + this.FormatearTextoSql( lxChqpropCentfin ) + "'">>,"Estado" = <<"'" + this.FormatearTextoSql( lxChqpropEstado ) + "'">>,"Fnumcompa" = <<lxChqpropFnumcompa>>,"Tipoch" = <<lxChqpropTipoch>>,"Cnumero" = <<lxChqpropCnumero>>,"Cnum" = <<lxChqpropCnum>>,"Centfinend" = <<"'" + this.FormatearTextoSql( lxChqpropCentfinend ) + "'">>,"Ctipca" = <<lxChqpropCtipca>>,"Ccompori" = <<"'" + this.FormatearTextoSql( lxChqpropCcompori ) + "'">>,"Compa" = <<"'" + this.FormatearTextoSql( lxChqpropCompa ) + "'">>,"Cctaendoso" = <<"'" + this.FormatearTextoSql( lxChqpropCctaendoso ) + "'">>,"Celectro" = <<iif( lxChqpropCelectro, 1, 0 )>>,"Fechaa" = <<"'" + this.ConvertirDateSql( lxChqpropFechaa ) + "'">>,"Cfecori" = <<"'" + this.ConvertirDateSql( lxChqpropCfecori ) + "'">>,"Cpaguesea" = <<"'" + this.FormatearTextoSql( lxChqpropCpaguesea ) + "'">>,"Cmonto" = <<lxChqpropCmonto>>,"Cseriea" = <<"'" + this.FormatearTextoSql( lxChqpropCseriea ) + "'">>,"Clafec" = <<"'" + this.FormatearTextoSql( lxChqpropClafec ) + "'">>,"Cliente" = <<"'" + this.FormatearTextoSql( lxChqpropCliente ) + "'">>,"Cvend" = <<"'" + this.FormatearTextoSql( lxChqpropCvend ) + "'">>,"Cfechaemi" = <<"'" + this.ConvertirDateSql( lxChqpropCfechaemi ) + "'">>,"Cversiona" = <<"'" + this.FormatearTextoSql( lxChqpropCversiona ) + "'">>,"Cserie" = <<"'" + this.FormatearTextoSql( lxChqpropCserie ) + "'">>,"Ctipc" = <<lxChqpropCtipc>>,"Prvafec" = <<"'" + this.FormatearTextoSql( lxChqpropPrvafec ) + "'">>,"Cfecend" = <<"'" + this.ConvertirDateSql( lxChqpropCfecend ) + "'">>,"Cfecha" = <<"'" + this.ConvertirDateSql( lxChqpropCfecha ) + "'">>,"Cautoalfa" = <<"'" + this.FormatearTextoSql( lxChqpropCautoalfa ) + "'">>,"Cbdedata" = <<"'" + this.FormatearTextoSql( lxChqpropCbdedata ) + "'">>,"Cversion" = <<"'" + this.FormatearTextoSql( lxChqpropCversion ) + "'">>,"Cautori" = <<lxChqpropCautori>>,"Cbdorig" = <<"'" + this.FormatearTextoSql( lxChqpropCbdorig ) + "'">>,"Cleyendoso" = <<"'" + this.FormatearTextoSql( lxChqpropCleyendoso ) + "'">>,"Fechavenci" = <<"'" + this.ConvertirDateSql( lxChqpropFechavenci ) + "'">>,"Cmoneda" = <<"'" + this.FormatearTextoSql( lxChqpropCmoneda ) + "'">>,"Prvorig" = <<"'" + this.FormatearTextoSql( lxChqpropPrvorig ) + "'">>,"Csigno" = <<lxChqpropCsigno>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'">> and  CHQPROP.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CHPROPHIST where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedor = loItem.Proveedor
					lxSerie = loItem.Serie
					lxVendedor = loItem.Vendedor
					lxCliente = loItem.Cliente
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxVersion = loItem.Version
					lxNroitem = lnContadorNroItem
					lxClientedescripcion = loItem.Clientedescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
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
						Insert into ZooLogic.CHPROPHIST("Proveedor","cSerie","Vendedor","Cliente","IdentifEnt","CodigoComp","cVersion","NROITEM","ClienteDes","VendedDes","ProveedDes","CtaBancDes","CtaBanc","Codigo","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ZooLogic.CHQPROP where " + this.ConvertirFuncionesSql( " CHQPROP.CCOD != ''" ) )
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
			Local lxChqpropCcod
			lxChqpropCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHQPROP where "Ccod" = <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'">> and  CHQPROP.CCOD != ''
			endtext
			use in select('c_CHEQUEPROPIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUEPROPIO', set( 'Datasession' ) )

			if reccount( 'c_CHEQUEPROPIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHPROPHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUEPROPIO.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
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
			Local lxCHQPROPptoventa As Variant, lxCHQPROPnumeroC As Variant
			lxCHQPROPptoventa = .PuntoDeVenta
			lxCHQPROPnumeroC = .NumeroC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHQPROP where  CHQPROP.CCOD != '' And ptoventa = <<lxCHQPROPptoventa>> and numeroC = <<lxCHQPROPnumeroC>>
			endtext
			use in select('c_CHEQUEPROPIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUEPROPIO', set( 'Datasession' ) )
			if reccount( 'c_CHEQUEPROPIO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHPROPHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUEPROPIO.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
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
		local llRetorno as boolean,lxChqpropCcod as Variant
		llRetorno = .t.
		lxChqpropCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.CHQPROP where "Ccod" = <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'">> and  CHQPROP.CCOD != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHQPROP where  CHQPROP.CCOD != '' order by ptoventa,numeroC
			endtext
			use in select('c_CHEQUEPROPIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUEPROPIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHPROPHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUEPROPIO.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHQPROP where  str( ptoventa, 4, 0) + str( numeroC, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CHQPROP.CCOD != '' order by ptoventa,numeroC
			endtext
			use in select('c_CHEQUEPROPIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUEPROPIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHPROPHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUEPROPIO.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHQPROP where  str( ptoventa, 4, 0) + str( numeroC, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  CHQPROP.CCOD != '' order by ptoventa desc,numeroC desc
			endtext
			use in select('c_CHEQUEPROPIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUEPROPIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHPROPHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUEPROPIO.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen" from ZooLogic.CHQPROP where  CHQPROP.CCOD != '' order by ptoventa desc,numeroC desc
			endtext
			use in select('c_CHEQUEPROPIO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CHEQUEPROPIO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado" from ZooLogic.CHPROPHIST where CODIGO = <<"'" + this.FormatearTextoSql( c_CHEQUEPROPIO.CODIGO ) + "'">> Order by Fecha DESC,Hora DESC
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fechaorden,Fecexpo,Fecimpo,Fectrans,Fmodifw,Fletraa,Umodifw,Ualtafw,Smodifw,Hmodifw," + ;
"Saltafw,Bdmodifw,Cvalor,Esttrans,Bdaltafw,Haltafw,Horaexpo,Horaimpo,Ccodcompa,Zadsfw,Ccodcomp,Cletra" + ;
",Vmodifw,Valtafw,Anulado,Ptoventa,Ccod,Chequera,Cobss,Fptovena,Cusuario,Cptovta,Numeroc,Centfin,Esta" + ;
"do,Fnumcompa,Tipoch,Cnumero,Cnum,Centfinend,Ctipca,Ccompori,Compa,Cctaendoso,Celectro,Fechaa,Cfecori" + ;
",Cpaguesea,Cmonto,Cseriea,Clafec,Cliente,Cvend,Cfechaemi,Cversiona,Cserie,Ctipc,Prvafec,Cfecend,Cfec" + ;
"ha,Cautoalfa,Cbdedata,Cversion,Cautori,Cbdorig,Cleyendoso,Fechavenci,Cmoneda,Prvorig,Csigno" + ;
" from ZooLogic.CHQPROP where  CHQPROP.CCOD != '' and " + lcFiltro )
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
			local  lxChqpropFaltafw, lxChqpropFechaorden, lxChqpropFecexpo, lxChqpropFecimpo, lxChqpropFectrans, lxChqpropFmodifw, lxChqpropFletraa, lxChqpropUmodifw, lxChqpropUaltafw, lxChqpropSmodifw, lxChqpropHmodifw, lxChqpropSaltafw, lxChqpropBdmodifw, lxChqpropCvalor, lxChqpropEsttrans, lxChqpropBdaltafw, lxChqpropHaltafw, lxChqpropHoraexpo, lxChqpropHoraimpo, lxChqpropCcodcompa, lxChqpropZadsfw, lxChqpropCcodcomp, lxChqpropCletra, lxChqpropVmodifw, lxChqpropValtafw, lxChqpropAnulado, lxChqpropPtoventa, lxChqpropCcod, lxChqpropChequera, lxChqpropCobss, lxChqpropFptovena, lxChqpropCusuario, lxChqpropCptovta, lxChqpropNumeroc, lxChqpropCentfin, lxChqpropEstado, lxChqpropFnumcompa, lxChqpropTipoch, lxChqpropCnumero, lxChqpropCnum, lxChqpropCentfinend, lxChqpropCtipca, lxChqpropCcompori, lxChqpropCompa, lxChqpropCctaendoso, lxChqpropCelectro, lxChqpropFechaa, lxChqpropCfecori, lxChqpropCpaguesea, lxChqpropCmonto, lxChqpropCseriea, lxChqpropClafec, lxChqpropCliente, lxChqpropCvend, lxChqpropCfechaemi, lxChqpropCversiona, lxChqpropCserie, lxChqpropCtipc, lxChqpropPrvafec, lxChqpropCfecend, lxChqpropCfecha, lxChqpropCautoalfa, lxChqpropCbdedata, lxChqpropCversion, lxChqpropCautori, lxChqpropCbdorig, lxChqpropCleyendoso, lxChqpropFechavenci, lxChqpropCmoneda, lxChqpropPrvorig, lxChqpropCsigno
				lxChqpropFaltafw = ctod( '  /  /    ' )			lxChqpropFechaorden = ctod( '  /  /    ' )			lxChqpropFecexpo = ctod( '  /  /    ' )			lxChqpropFecimpo = ctod( '  /  /    ' )			lxChqpropFectrans = ctod( '  /  /    ' )			lxChqpropFmodifw = ctod( '  /  /    ' )			lxChqpropFletraa = []			lxChqpropUmodifw = []			lxChqpropUaltafw = []			lxChqpropSmodifw = []			lxChqpropHmodifw = []			lxChqpropSaltafw = []			lxChqpropBdmodifw = []			lxChqpropCvalor = []			lxChqpropEsttrans = []			lxChqpropBdaltafw = []			lxChqpropHaltafw = []			lxChqpropHoraexpo = []			lxChqpropHoraimpo = []			lxChqpropCcodcompa = []			lxChqpropZadsfw = []			lxChqpropCcodcomp = []			lxChqpropCletra = []			lxChqpropVmodifw = []			lxChqpropValtafw = []			lxChqpropAnulado = .F.			lxChqpropPtoventa = 0			lxChqpropCcod = []			lxChqpropChequera = []			lxChqpropCobss = []			lxChqpropFptovena = 0			lxChqpropCusuario = []			lxChqpropCptovta = 0			lxChqpropNumeroc = 0			lxChqpropCentfin = []			lxChqpropEstado = []			lxChqpropFnumcompa = 0			lxChqpropTipoch = 0			lxChqpropCnumero = 0			lxChqpropCnum = 0			lxChqpropCentfinend = []			lxChqpropCtipca = 0			lxChqpropCcompori = []			lxChqpropCompa = []			lxChqpropCctaendoso = []			lxChqpropCelectro = .F.			lxChqpropFechaa = ctod( '  /  /    ' )			lxChqpropCfecori = ctod( '  /  /    ' )			lxChqpropCpaguesea = []			lxChqpropCmonto = 0			lxChqpropCseriea = []			lxChqpropClafec = []			lxChqpropCliente = []			lxChqpropCvend = []			lxChqpropCfechaemi = ctod( '  /  /    ' )			lxChqpropCversiona = []			lxChqpropCserie = []			lxChqpropCtipc = 0			lxChqpropPrvafec = []			lxChqpropCfecend = ctod( '  /  /    ' )			lxChqpropCfecha = ctod( '  /  /    ' )			lxChqpropCautoalfa = []			lxChqpropCbdedata = []			lxChqpropCversion = []			lxChqpropCautori = 0			lxChqpropCbdorig = []			lxChqpropCleyendoso = []			lxChqpropFechavenci = ctod( '  /  /    ' )			lxChqpropCmoneda = []			lxChqpropPrvorig = []			lxChqpropCsigno = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CHPROPHIST where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.CHQPROP where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'CHQPROP' + '_' + tcCampo
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
		lcWhere = " Where  CHQPROP.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CHQPROP', '', tnTope )
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
		lcWhere = " Where  CHPROPHIST.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Proveedor" as "Proveedor", "Cserie" as "Serie", "Vendedor" as "Vendedor", "Cliente" as "Cliente", "Identifent" as "Identificadorentidadcomprobante", "Codigocomp" as "Codigocomprobante", "Cversion" as "Version", "Nroitem" as "Nroitem", "Clientedes" as "Clientedescripcion", "Vendeddes" as "Vendedordescripcion", "Proveeddes" as "Proveedordescripcion", "Ctabancdes" as "Cuentabancariadescripcion", "Ctabanc" as "Cuentabancaria", "Codigo" as "Codigo", "Fecha" as "Fecha", "Hora" as "Hora", "Tipocomp" as "Tipodecomprobante", "Comprob" as "Comprobante", "Concepto" as "Concepto", "Conceptdes" as "Conceptodetalle", "Tipo" as "Tipo", "Idcaja" as "Cajaestado", "Cajadesc" as "Cajaestadodetalle", "Baseorigen" as "Basedeorigen", "Estado" as "Estado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleHistorialDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CHPROPHIST', 'HistorialDetalle', tnTope )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAORDENAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAORDEN AS FECHAORDENAMIENTO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'LETRAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRAA AS LETRAAFECTANTE'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVALOR AS VALOR'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'CODIGOCOMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMPA AS CODIGOCOMPROBANTEAFECTANTE'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'CODIGOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCODCOMP AS CODIGOCOMPROBANTEORIGEN'
				Case lcAtributo == 'LETRAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLETRA AS LETRAORIGEN'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'CHEQUERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHEQUERA AS CHEQUERA'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBSS AS OBSERVACION'
				Case lcAtributo == 'PUNTODEVENTAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENA AS PUNTODEVENTAAFECTANTE'
				Case lcAtributo == 'USUARIOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUSUARIO AS USUARIOORIGEN'
				Case lcAtributo == 'PUNTODEVENTAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPTOVTA AS PUNTODEVENTAORIGEN'
				Case lcAtributo == 'NUMEROC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMEROC AS NUMEROC'
				Case lcAtributo == 'ENTIDADFINANCIERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTFIN AS ENTIDADFINANCIERA'
				Case lcAtributo == 'ESTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTADO AS ESTADO'
				Case lcAtributo == 'NUMEROAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMPA AS NUMEROAFECTANTE'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCH AS TIPO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUMERO AS NUMERO'
				Case lcAtributo == 'NUMEROORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CNUM AS NUMEROORIGEN'
				Case lcAtributo == 'ENTIDADFINANCIERAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTFINEND AS ENTIDADFINANCIERAENDOSO'
				Case lcAtributo == 'TIPODECOMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPCA AS TIPODECOMPROBANTEAFECTANTE'
				Case lcAtributo == 'COMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOMPORI AS COMPROBANTEORIGEN'
				Case lcAtributo == 'COMPROBANTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPA AS COMPROBANTEAFECTANTE'
				Case lcAtributo == 'CUENTAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCTAENDOSO AS CUENTAENDOSO'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'FECHAAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAA AS FECHAAFECTANTE'
				Case lcAtributo == 'FECHAORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECORI AS FECHAORIGEN'
				Case lcAtributo == 'PAGUESEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPAGUESEA AS PAGUESEA'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONTO AS MONTO'
				Case lcAtributo == 'CSERIEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIEA AS CSERIEAFECTANTE'
				Case lcAtributo == 'CLIENTEAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLAFEC AS CLIENTEAFECTANTE'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVEND AS VENDEDOR'
				Case lcAtributo == 'FECHAEMISION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHAEMI AS FECHAEMISION'
				Case lcAtributo == 'CVERSIONAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSIONA AS CVERSIONAFECTANTE'
				Case lcAtributo == 'SERIEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIE AS SERIEORIGEN'
				Case lcAtributo == 'TIPODECOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPC AS TIPODECOMPROBANTEORIGEN'
				Case lcAtributo == 'PROVEEDORAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRVAFEC AS PROVEEDORAFECTANTE'
				Case lcAtributo == 'FECHAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECEND AS FECHAENDOSO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFECHA AS FECHA'
				Case lcAtributo == 'AUTORIZACIONALFA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAUTOALFA AS AUTORIZACIONALFA'
				Case lcAtributo == 'CBASEDEDATOSAFECTANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDEDATA AS CBASEDEDATOSAFECTANTE'
				Case lcAtributo == 'CVERSIONORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSION AS CVERSIONORIGEN'
				Case lcAtributo == 'AUTORIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAUTORI AS AUTORIZACION'
				Case lcAtributo == 'BDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDORIG AS BDORIGEN'
				Case lcAtributo == 'LEYENDAENDOSO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLEYENDOSO AS LEYENDAENDOSO'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAVENCI AS FECHAVENCIMIENTO'
				Case lcAtributo == 'MONEDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMONEDA AS MONEDA'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRVORIG AS PROVEEDOR'
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
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDOR AS PROVEEDOR'
				Case lcAtributo == 'SERIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIE AS SERIE'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDOR AS VENDEDOR'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTE AS CLIENTE'
				Case lcAtributo == 'IDENTIFICADORENTIDADCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFENT AS IDENTIFICADORENTIDADCOMPROBANTE'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGOCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'VERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CVERSION AS VERSION'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLIENTEDES AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'VENDEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VENDEDDES AS VENDEDORDESCRIPCION'
				Case lcAtributo == 'PROVEEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVEEDDES AS PROVEEDORDESCRIPCION'
				Case lcAtributo == 'CUENTABANCARIADESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANCDES AS CUENTABANCARIADESCRIPCION'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANC AS CUENTABANCARIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORDENAMIENTO'
				lcCampo = 'FECHAORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAAFECTANTE'
				lcCampo = 'FLETRAA'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'CVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEAFECTANTE'
				lcCampo = 'CCODCOMPA'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTEORIGEN'
				lcCampo = 'CCODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAORIGEN'
				lcCampo = 'CLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUERA'
				lcCampo = 'CHEQUERA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBSS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAAFECTANTE'
				lcCampo = 'FPTOVENA'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOORIGEN'
				lcCampo = 'CUSUARIO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAORIGEN'
				lcCampo = 'CPTOVTA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROC'
				lcCampo = 'NUMEROC'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERA'
				lcCampo = 'CENTFIN'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADO'
				lcCampo = 'ESTADO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROAFECTANTE'
				lcCampo = 'FNUMCOMPA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPOCH'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'CNUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORIGEN'
				lcCampo = 'CNUM'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDADFINANCIERAENDOSO'
				lcCampo = 'CENTFINEND'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEAFECTANTE'
				lcCampo = 'CTIPCA'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEORIGEN'
				lcCampo = 'CCOMPORI'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEAFECTANTE'
				lcCampo = 'COMPA'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTAENDOSO'
				lcCampo = 'CCTAENDOSO'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAAFECTANTE'
				lcCampo = 'FECHAA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAORIGEN'
				lcCampo = 'CFECORI'
			Case upper( alltrim( tcAtributo ) ) == 'PAGUESEA'
				lcCampo = 'CPAGUESEA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'CMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'CSERIEAFECTANTE'
				lcCampo = 'CSERIEA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEAFECTANTE'
				lcCampo = 'CLAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'CVEND'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEMISION'
				lcCampo = 'CFECHAEMI'
			Case upper( alltrim( tcAtributo ) ) == 'CVERSIONAFECTANTE'
				lcCampo = 'CVERSIONA'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEORIGEN'
				lcCampo = 'CSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTEORIGEN'
				lcCampo = 'CTIPC'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORAFECTANTE'
				lcCampo = 'PRVAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAENDOSO'
				lcCampo = 'CFECEND'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'CFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONALFA'
				lcCampo = 'CAUTOALFA'
			Case upper( alltrim( tcAtributo ) ) == 'CBASEDEDATOSAFECTANTE'
				lcCampo = 'CBDEDATA'
			Case upper( alltrim( tcAtributo ) ) == 'CVERSIONORIGEN'
				lcCampo = 'CVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACION'
				lcCampo = 'CAUTORI'
			Case upper( alltrim( tcAtributo ) ) == 'BDORIGEN'
				lcCampo = 'CBDORIG'
			Case upper( alltrim( tcAtributo ) ) == 'LEYENDAENDOSO'
				lcCampo = 'CLEYENDOSO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FECHAVENCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDA'
				lcCampo = 'CMONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PRVORIG'
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
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROVEEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'SERIE'
				lcCampo = 'CSERIE'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'VENDEDOR'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'CLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADORENTIDADCOMPROBANTE'
				lcCampo = 'IDENTIFENT'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODIGOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'VERSION'
				lcCampo = 'CVERSION'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'CLIENTEDES'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDORDESCRIPCION'
				lcCampo = 'VENDEDDES'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORDESCRIPCION'
				lcCampo = 'PROVEEDDES'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIADESCRIPCION'
				lcCampo = 'CTABANCDES'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CTABANC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
			lcRetorno = 'CHPROPHIST'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxChqpropFaltafw, lxChqpropFechaorden, lxChqpropFecexpo, lxChqpropFecimpo, lxChqpropFectrans, lxChqpropFmodifw, lxChqpropFletraa, lxChqpropUmodifw, lxChqpropUaltafw, lxChqpropSmodifw, lxChqpropHmodifw, lxChqpropSaltafw, lxChqpropBdmodifw, lxChqpropCvalor, lxChqpropEsttrans, lxChqpropBdaltafw, lxChqpropHaltafw, lxChqpropHoraexpo, lxChqpropHoraimpo, lxChqpropCcodcompa, lxChqpropZadsfw, lxChqpropCcodcomp, lxChqpropCletra, lxChqpropVmodifw, lxChqpropValtafw, lxChqpropAnulado, lxChqpropPtoventa, lxChqpropCcod, lxChqpropChequera, lxChqpropCobss, lxChqpropFptovena, lxChqpropCusuario, lxChqpropCptovta, lxChqpropNumeroc, lxChqpropCentfin, lxChqpropEstado, lxChqpropFnumcompa, lxChqpropTipoch, lxChqpropCnumero, lxChqpropCnum, lxChqpropCentfinend, lxChqpropCtipca, lxChqpropCcompori, lxChqpropCompa, lxChqpropCctaendoso, lxChqpropCelectro, lxChqpropFechaa, lxChqpropCfecori, lxChqpropCpaguesea, lxChqpropCmonto, lxChqpropCseriea, lxChqpropClafec, lxChqpropCliente, lxChqpropCvend, lxChqpropCfechaemi, lxChqpropCversiona, lxChqpropCserie, lxChqpropCtipc, lxChqpropPrvafec, lxChqpropCfecend, lxChqpropCfecha, lxChqpropCautoalfa, lxChqpropCbdedata, lxChqpropCversion, lxChqpropCautori, lxChqpropCbdorig, lxChqpropCleyendoso, lxChqpropFechavenci, lxChqpropCmoneda, lxChqpropPrvorig, lxChqpropCsigno
				lxChqpropFaltafw =  .Fechaaltafw			lxChqpropFechaorden =  .Fechaordenamiento			lxChqpropFecexpo =  .Fechaexpo			lxChqpropFecimpo =  .Fechaimpo			lxChqpropFectrans =  .Fechatransferencia			lxChqpropFmodifw =  .Fechamodificacionfw			lxChqpropFletraa =  .Letraafectante			lxChqpropUmodifw =  .Usuariomodificacionfw			lxChqpropUaltafw =  .Usuarioaltafw			lxChqpropSmodifw =  .Seriemodificacionfw			lxChqpropHmodifw =  .Horamodificacionfw			lxChqpropSaltafw =  .Seriealtafw			lxChqpropBdmodifw =  .Basededatosmodificacionfw			lxChqpropCvalor =  .Valor			lxChqpropEsttrans =  .Estadotransferencia			lxChqpropBdaltafw =  .Basededatosaltafw			lxChqpropHaltafw =  .Horaaltafw			lxChqpropHoraexpo =  .Horaexpo			lxChqpropHoraimpo =  .Horaimpo			lxChqpropCcodcompa =  .Codigocomprobanteafectante			lxChqpropZadsfw =  .Zadsfw			lxChqpropCcodcomp =  .Codigocomprobanteorigen			lxChqpropCletra =  .Letraorigen			lxChqpropVmodifw =  .Versionmodificacionfw			lxChqpropValtafw =  .Versionaltafw			lxChqpropAnulado =  .Anulado			lxChqpropPtoventa =  .Puntodeventa			lxChqpropCcod =  .Codigo			lxChqpropChequera =  upper( .Chequera_PK ) 			lxChqpropCobss =  .Observacion			lxChqpropFptovena =  .Puntodeventaafectante			lxChqpropCusuario =  .Usuarioorigen			lxChqpropCptovta =  .Puntodeventaorigen			lxChqpropNumeroc =  .Numeroc			lxChqpropCentfin =  upper( .EntidadFinanciera_PK ) 			lxChqpropEstado =  .Estado			lxChqpropFnumcompa =  .Numeroafectante			lxChqpropTipoch =  .Tipo			lxChqpropCnumero =  .Numero			lxChqpropCnum =  .Numeroorigen			lxChqpropCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChqpropCtipca =  .Tipodecomprobanteafectante			lxChqpropCcompori =  .Comprobanteorigen			lxChqpropCompa =  .Comprobanteafectante			lxChqpropCctaendoso =  .Cuentaendoso			lxChqpropCelectro =  .Chequeelectronico			lxChqpropFechaa =  .Fechaafectante			lxChqpropCfecori =  .Fechaorigen			lxChqpropCpaguesea =  .Paguesea			lxChqpropCmonto =  .Monto			lxChqpropCseriea =  .Cserieafectante			lxChqpropClafec =  upper( .ClienteAfectante_PK ) 			lxChqpropCliente =  upper( .Cliente_PK ) 			lxChqpropCvend =  upper( .Vendedor_PK ) 			lxChqpropCfechaemi =  .Fechaemision			lxChqpropCversiona =  .Cversionafectante			lxChqpropCserie =  .Serieorigen			lxChqpropCtipc =  .Tipodecomprobanteorigen			lxChqpropPrvafec =  upper( .ProveedorAfectante_PK ) 			lxChqpropCfecend =  .Fechaendoso			lxChqpropCfecha =  .Fecha			lxChqpropCautoalfa =  .Autorizacionalfa			lxChqpropCbdedata =  .Cbasededatosafectante			lxChqpropCversion =  .Cversionorigen			lxChqpropCautori =  .Autorizacion			lxChqpropCbdorig =  .Bdorigen			lxChqpropCleyendoso =  .Leyendaendoso			lxChqpropFechavenci =  .Fechavencimiento			lxChqpropCmoneda =  upper( .Moneda_PK ) 			lxChqpropPrvorig =  upper( .Proveedor_PK ) 			lxChqpropCsigno =  .Signodemovimientoorigen
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.CHQPROP ( "Faltafw","Fechaorden","Fecexpo","Fecimpo","Fectrans","Fmodifw","Fletraa","Umodifw","Ualtafw","Smodifw","Hmodifw","Saltafw","Bdmodifw","Cvalor","Esttrans","Bdaltafw","Haltafw","Horaexpo","Horaimpo","Ccodcompa","Zadsfw","Ccodcomp","Cletra","Vmodifw","Valtafw","Anulado","Ptoventa","Ccod","Chequera","Cobss","Fptovena","Cusuario","Cptovta","Numeroc","Centfin","Estado","Fnumcompa","Tipoch","Cnumero","Cnum","Centfinend","Ctipca","Ccompori","Compa","Cctaendoso","Celectro","Fechaa","Cfecori","Cpaguesea","Cmonto","Cseriea","Clafec","Cliente","Cvend","Cfechaemi","Cversiona","Cserie","Ctipc","Prvafec","Cfecend","Cfecha","Cautoalfa","Cbdedata","Cversion","Cautori","Cbdorig","Cleyendoso","Fechavenci","Cmoneda","Prvorig","Csigno" ) values ( <<"'" + this.ConvertirDateSql( lxChqpropFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFechaorden ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropFletraa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCvalor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCcodcompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCcodcomp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropValtafw ) + "'" >>, <<iif( lxChqpropAnulado, 1, 0 ) >>, <<lxChqpropPtoventa >>, <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropChequera ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCobss ) + "'" >>, <<lxChqpropFptovena >>, <<"'" + this.FormatearTextoSql( lxChqpropCusuario ) + "'" >>, <<lxChqpropCptovta >>, <<lxChqpropNumeroc >>, <<"'" + this.FormatearTextoSql( lxChqpropCentfin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropEstado ) + "'" >>, <<lxChqpropFnumcompa >>, <<lxChqpropTipoch >>, <<lxChqpropCnumero >>, <<lxChqpropCnum >>, <<"'" + this.FormatearTextoSql( lxChqpropCentfinend ) + "'" >>, <<lxChqpropCtipca >>, <<"'" + this.FormatearTextoSql( lxChqpropCcompori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCompa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCctaendoso ) + "'" >>, <<iif( lxChqpropCelectro, 1, 0 ) >>, <<"'" + this.ConvertirDateSql( lxChqpropFechaa ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfecori ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCpaguesea ) + "'" >>, <<lxChqpropCmonto >>, <<"'" + this.FormatearTextoSql( lxChqpropCseriea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropClafec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCvend ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfechaemi ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCversiona ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCserie ) + "'" >>, <<lxChqpropCtipc >>, <<"'" + this.FormatearTextoSql( lxChqpropPrvafec ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfecend ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropCfecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCautoalfa ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCbdedata ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCversion ) + "'" >>, <<lxChqpropCautori >>, <<"'" + this.FormatearTextoSql( lxChqpropCbdorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCleyendoso ) + "'" >>, <<"'" + this.ConvertirDateSql( lxChqpropFechavenci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropCmoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxChqpropPrvorig ) + "'" >>, <<lxChqpropCsigno >> )
		endtext
		loColeccion.cTabla = 'CHQPROP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedor = loItem.Proveedor
					lxSerie = loItem.Serie
					lxVendedor = loItem.Vendedor
					lxCliente = loItem.Cliente
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxVersion = loItem.Version
					lxNroitem = lnContadorNroItem
					lxClientedescripcion = loItem.Clientedescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
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
						Insert into ZooLogic.CHPROPHIST("Proveedor","cSerie","Vendedor","Cliente","IdentifEnt","CodigoComp","cVersion","NROITEM","ClienteDes","VendedDes","ProveedDes","CtaBancDes","CtaBanc","Codigo","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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
			local  lxChqpropFaltafw, lxChqpropFechaorden, lxChqpropFecexpo, lxChqpropFecimpo, lxChqpropFectrans, lxChqpropFmodifw, lxChqpropFletraa, lxChqpropUmodifw, lxChqpropUaltafw, lxChqpropSmodifw, lxChqpropHmodifw, lxChqpropSaltafw, lxChqpropBdmodifw, lxChqpropCvalor, lxChqpropEsttrans, lxChqpropBdaltafw, lxChqpropHaltafw, lxChqpropHoraexpo, lxChqpropHoraimpo, lxChqpropCcodcompa, lxChqpropZadsfw, lxChqpropCcodcomp, lxChqpropCletra, lxChqpropVmodifw, lxChqpropValtafw, lxChqpropAnulado, lxChqpropPtoventa, lxChqpropCcod, lxChqpropChequera, lxChqpropCobss, lxChqpropFptovena, lxChqpropCusuario, lxChqpropCptovta, lxChqpropNumeroc, lxChqpropCentfin, lxChqpropEstado, lxChqpropFnumcompa, lxChqpropTipoch, lxChqpropCnumero, lxChqpropCnum, lxChqpropCentfinend, lxChqpropCtipca, lxChqpropCcompori, lxChqpropCompa, lxChqpropCctaendoso, lxChqpropCelectro, lxChqpropFechaa, lxChqpropCfecori, lxChqpropCpaguesea, lxChqpropCmonto, lxChqpropCseriea, lxChqpropClafec, lxChqpropCliente, lxChqpropCvend, lxChqpropCfechaemi, lxChqpropCversiona, lxChqpropCserie, lxChqpropCtipc, lxChqpropPrvafec, lxChqpropCfecend, lxChqpropCfecha, lxChqpropCautoalfa, lxChqpropCbdedata, lxChqpropCversion, lxChqpropCautori, lxChqpropCbdorig, lxChqpropCleyendoso, lxChqpropFechavenci, lxChqpropCmoneda, lxChqpropPrvorig, lxChqpropCsigno
				lxChqpropFaltafw =  .Fechaaltafw			lxChqpropFechaorden =  .Fechaordenamiento			lxChqpropFecexpo =  .Fechaexpo			lxChqpropFecimpo =  .Fechaimpo			lxChqpropFectrans =  .Fechatransferencia			lxChqpropFmodifw =  .Fechamodificacionfw			lxChqpropFletraa =  .Letraafectante			lxChqpropUmodifw =  .Usuariomodificacionfw			lxChqpropUaltafw =  .Usuarioaltafw			lxChqpropSmodifw =  .Seriemodificacionfw			lxChqpropHmodifw =  .Horamodificacionfw			lxChqpropSaltafw =  .Seriealtafw			lxChqpropBdmodifw =  .Basededatosmodificacionfw			lxChqpropCvalor =  .Valor			lxChqpropEsttrans =  .Estadotransferencia			lxChqpropBdaltafw =  .Basededatosaltafw			lxChqpropHaltafw =  .Horaaltafw			lxChqpropHoraexpo =  .Horaexpo			lxChqpropHoraimpo =  .Horaimpo			lxChqpropCcodcompa =  .Codigocomprobanteafectante			lxChqpropZadsfw =  .Zadsfw			lxChqpropCcodcomp =  .Codigocomprobanteorigen			lxChqpropCletra =  .Letraorigen			lxChqpropVmodifw =  .Versionmodificacionfw			lxChqpropValtafw =  .Versionaltafw			lxChqpropAnulado =  .Anulado			lxChqpropPtoventa =  .Puntodeventa			lxChqpropCcod =  .Codigo			lxChqpropChequera =  upper( .Chequera_PK ) 			lxChqpropCobss =  .Observacion			lxChqpropFptovena =  .Puntodeventaafectante			lxChqpropCusuario =  .Usuarioorigen			lxChqpropCptovta =  .Puntodeventaorigen			lxChqpropNumeroc =  .Numeroc			lxChqpropCentfin =  upper( .EntidadFinanciera_PK ) 			lxChqpropEstado =  .Estado			lxChqpropFnumcompa =  .Numeroafectante			lxChqpropTipoch =  .Tipo			lxChqpropCnumero =  .Numero			lxChqpropCnum =  .Numeroorigen			lxChqpropCentfinend =  upper( .EntidadFinancieraEndoso_PK ) 			lxChqpropCtipca =  .Tipodecomprobanteafectante			lxChqpropCcompori =  .Comprobanteorigen			lxChqpropCompa =  .Comprobanteafectante			lxChqpropCctaendoso =  .Cuentaendoso			lxChqpropCelectro =  .Chequeelectronico			lxChqpropFechaa =  .Fechaafectante			lxChqpropCfecori =  .Fechaorigen			lxChqpropCpaguesea =  .Paguesea			lxChqpropCmonto =  .Monto			lxChqpropCseriea =  .Cserieafectante			lxChqpropClafec =  upper( .ClienteAfectante_PK ) 			lxChqpropCliente =  upper( .Cliente_PK ) 			lxChqpropCvend =  upper( .Vendedor_PK ) 			lxChqpropCfechaemi =  .Fechaemision			lxChqpropCversiona =  .Cversionafectante			lxChqpropCserie =  .Serieorigen			lxChqpropCtipc =  .Tipodecomprobanteorigen			lxChqpropPrvafec =  upper( .ProveedorAfectante_PK ) 			lxChqpropCfecend =  .Fechaendoso			lxChqpropCfecha =  .Fecha			lxChqpropCautoalfa =  .Autorizacionalfa			lxChqpropCbdedata =  .Cbasededatosafectante			lxChqpropCversion =  .Cversionorigen			lxChqpropCautori =  .Autorizacion			lxChqpropCbdorig =  .Bdorigen			lxChqpropCleyendoso =  .Leyendaendoso			lxChqpropFechavenci =  .Fechavencimiento			lxChqpropCmoneda =  upper( .Moneda_PK ) 			lxChqpropPrvorig =  upper( .Proveedor_PK ) 			lxChqpropCsigno =  .Signodemovimientoorigen
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  CHQPROP.CCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.CHQPROP set "Faltafw" = <<"'" + this.ConvertirDateSql( lxChqpropFaltafw ) + "'">>, "Fechaorden" = <<"'" + this.ConvertirDateSql( lxChqpropFechaorden ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxChqpropFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxChqpropFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxChqpropFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxChqpropFmodifw ) + "'">>, "Fletraa" = <<"'" + this.FormatearTextoSql( lxChqpropFletraa ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxChqpropUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxChqpropUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxChqpropSmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxChqpropHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxChqpropSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxChqpropBdmodifw ) + "'">>, "Cvalor" = <<"'" + this.FormatearTextoSql( lxChqpropCvalor ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxChqpropEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxChqpropBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxChqpropHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxChqpropHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxChqpropHoraimpo ) + "'">>, "Ccodcompa" = <<"'" + this.FormatearTextoSql( lxChqpropCcodcompa ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxChqpropZadsfw ) + "'">>, "Ccodcomp" = <<"'" + this.FormatearTextoSql( lxChqpropCcodcomp ) + "'">>, "Cletra" = <<"'" + this.FormatearTextoSql( lxChqpropCletra ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxChqpropVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxChqpropValtafw ) + "'">>, "Anulado" = <<iif( lxChqpropAnulado, 1, 0 )>>, "Ptoventa" = <<lxChqpropPtoventa>>, "Ccod" = <<"'" + this.FormatearTextoSql( lxChqpropCcod ) + "'">>, "Chequera" = <<"'" + this.FormatearTextoSql( lxChqpropChequera ) + "'">>, "Cobss" = <<"'" + this.FormatearTextoSql( lxChqpropCobss ) + "'">>, "Fptovena" = <<lxChqpropFptovena>>, "Cusuario" = <<"'" + this.FormatearTextoSql( lxChqpropCusuario ) + "'">>, "Cptovta" = <<lxChqpropCptovta>>, "Numeroc" = <<lxChqpropNumeroc>>, "Centfin" = <<"'" + this.FormatearTextoSql( lxChqpropCentfin ) + "'">>, "Estado" = <<"'" + this.FormatearTextoSql( lxChqpropEstado ) + "'">>, "Fnumcompa" = <<lxChqpropFnumcompa>>, "Tipoch" = <<lxChqpropTipoch>>, "Cnumero" = <<lxChqpropCnumero>>, "Cnum" = <<lxChqpropCnum>>, "Centfinend" = <<"'" + this.FormatearTextoSql( lxChqpropCentfinend ) + "'">>, "Ctipca" = <<lxChqpropCtipca>>, "Ccompori" = <<"'" + this.FormatearTextoSql( lxChqpropCcompori ) + "'">>, "Compa" = <<"'" + this.FormatearTextoSql( lxChqpropCompa ) + "'">>, "Cctaendoso" = <<"'" + this.FormatearTextoSql( lxChqpropCctaendoso ) + "'">>, "Celectro" = <<iif( lxChqpropCelectro, 1, 0 )>>, "Fechaa" = <<"'" + this.ConvertirDateSql( lxChqpropFechaa ) + "'">>, "Cfecori" = <<"'" + this.ConvertirDateSql( lxChqpropCfecori ) + "'">>, "Cpaguesea" = <<"'" + this.FormatearTextoSql( lxChqpropCpaguesea ) + "'">>, "Cmonto" = <<lxChqpropCmonto>>, "Cseriea" = <<"'" + this.FormatearTextoSql( lxChqpropCseriea ) + "'">>, "Clafec" = <<"'" + this.FormatearTextoSql( lxChqpropClafec ) + "'">>, "Cliente" = <<"'" + this.FormatearTextoSql( lxChqpropCliente ) + "'">>, "Cvend" = <<"'" + this.FormatearTextoSql( lxChqpropCvend ) + "'">>, "Cfechaemi" = <<"'" + this.ConvertirDateSql( lxChqpropCfechaemi ) + "'">>, "Cversiona" = <<"'" + this.FormatearTextoSql( lxChqpropCversiona ) + "'">>, "Cserie" = <<"'" + this.FormatearTextoSql( lxChqpropCserie ) + "'">>, "Ctipc" = <<lxChqpropCtipc>>, "Prvafec" = <<"'" + this.FormatearTextoSql( lxChqpropPrvafec ) + "'">>, "Cfecend" = <<"'" + this.ConvertirDateSql( lxChqpropCfecend ) + "'">>, "Cfecha" = <<"'" + this.ConvertirDateSql( lxChqpropCfecha ) + "'">>, "Cautoalfa" = <<"'" + this.FormatearTextoSql( lxChqpropCautoalfa ) + "'">>, "Cbdedata" = <<"'" + this.FormatearTextoSql( lxChqpropCbdedata ) + "'">>, "Cversion" = <<"'" + this.FormatearTextoSql( lxChqpropCversion ) + "'">>, "Cautori" = <<lxChqpropCautori>>, "Cbdorig" = <<"'" + this.FormatearTextoSql( lxChqpropCbdorig ) + "'">>, "Cleyendoso" = <<"'" + this.FormatearTextoSql( lxChqpropCleyendoso ) + "'">>, "Fechavenci" = <<"'" + this.ConvertirDateSql( lxChqpropFechavenci ) + "'">>, "Cmoneda" = <<"'" + this.FormatearTextoSql( lxChqpropCmoneda ) + "'">>, "Prvorig" = <<"'" + this.FormatearTextoSql( lxChqpropPrvorig ) + "'">>, "Csigno" = <<lxChqpropCsigno>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'CHQPROP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CHPROPHIST where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.HistorialDetalle
				if this.oEntidad.HistorialDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxProveedor = loItem.Proveedor
					lxSerie = loItem.Serie
					lxVendedor = loItem.Vendedor
					lxCliente = loItem.Cliente
					lxIdentificadorentidadcomprobante = loItem.Identificadorentidadcomprobante
					lxCodigocomprobante = loItem.Codigocomprobante
					lxVersion = loItem.Version
					lxNroitem = lnContadorNroItem
					lxClientedescripcion = loItem.Clientedescripcion
					lxVendedordescripcion = loItem.Vendedordescripcion
					lxProveedordescripcion = loItem.Proveedordescripcion
					lxCuentabancariadescripcion = loItem.Cuentabancariadescripcion
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
						Insert into ZooLogic.CHPROPHIST("Proveedor","cSerie","Vendedor","Cliente","IdentifEnt","CodigoComp","cVersion","NROITEM","ClienteDes","VendedDes","ProveedDes","CtaBancDes","CtaBanc","Codigo","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado" ) values ( <<"'" + this.FormatearTextoSql( lxProveedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxSerie ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxCliente ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificadorentidadcomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxVersion ) + "'">>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxClientedescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxProveedordescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancariadescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxCuentabancaria_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxHora ) + "'">>, <<lxTipodecomprobante>>, <<"'" + this.FormatearTextoSql( lxComprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxConcepto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxConceptodetalle ) + "'">>, <<lxTipo>>, <<lxCajaestado>>, <<"'" + this.FormatearTextoSql( lxCajaestadodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedeorigen ) + "'">>, <<"'" + this.FormatearTextoSql( lxEstado ) + "'">> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  CHQPROP.CCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.CHQPROP where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CHPROPHIST where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'CHQPROP' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.CHQPROP where  CHQPROP.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.CHQPROP where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  CHQPROP.CCOD != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCHQPROPptoventa as variant, lxCHQPROPnumeroC as variant, lxCHQPROPEstado as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUEPROPIO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.CHQPROP Where  ptoventa = ] + transform( &lcCursor..ptoventa   ) + [ and numeroC = ] + transform( &lcCursor..numeroC    ), 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.CHQPROP set  FechaOrden = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaOrden ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FLETRAA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRAA ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, cValor = ] + "'" + this.FormatearTextoSql( &lcCursor..cValor ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, cCodCompA = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodCompA ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, cCodComp = ] + "'" + this.FormatearTextoSql( &lcCursor..cCodComp ) + "'"+ [, cLetra = ] + "'" + this.FormatearTextoSql( &lcCursor..cLetra ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, ptoventa = ] + transform( &lcCursor..ptoventa )+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, Chequera = ] + "'" + this.FormatearTextoSql( &lcCursor..Chequera ) + "'"+ [, cObss = ] + "'" + this.FormatearTextoSql( &lcCursor..cObss ) + "'"+ [, FPTOVENA = ] + transform( &lcCursor..FPTOVENA )+ [, cUsuario = ] + "'" + this.FormatearTextoSql( &lcCursor..cUsuario ) + "'"+ [, cptovta = ] + transform( &lcCursor..cptovta )+ [, numeroC = ] + transform( &lcCursor..numeroC )+ [, cEntFin = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntFin ) + "'"+ [, Estado = ] + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"+ [, FNUMCOMPA = ] + transform( &lcCursor..FNUMCOMPA )+ [, TipoCH = ] + transform( &lcCursor..TipoCH )+ [, cNumero = ] + transform( &lcCursor..cNumero )+ [, cnum = ] + transform( &lcCursor..cnum )+ [, cEntFinEnd = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntFinEnd ) + "'"+ [, cTipCA = ] + transform( &lcCursor..cTipCA )+ [, cCompOri = ] + "'" + this.FormatearTextoSql( &lcCursor..cCompOri ) + "'"+ [, CompA = ] + "'" + this.FormatearTextoSql( &lcCursor..CompA ) + "'"+ [, cCtaEndoso = ] + "'" + this.FormatearTextoSql( &lcCursor..cCtaEndoso ) + "'"+ [, CElectro = ] + Transform( iif( &lcCursor..CElectro, 1, 0 ))+ [, FechaA = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaA ) + "'"+ [, cFecOri = ] + "'" + this.ConvertirDateSql( &lcCursor..cFecOri ) + "'"+ [, cPagueseA = ] + "'" + this.FormatearTextoSql( &lcCursor..cPagueseA ) + "'"+ [, cMonto = ] + transform( &lcCursor..cMonto )+ [, CSERIEA = ] + "'" + this.FormatearTextoSql( &lcCursor..CSERIEA ) + "'"+ [, clAfec = ] + "'" + this.FormatearTextoSql( &lcCursor..clAfec ) + "'"+ [, Cliente = ] + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'"+ [, cVend = ] + "'" + this.FormatearTextoSql( &lcCursor..cVend ) + "'"+ [, cFechaEmi = ] + "'" + this.ConvertirDateSql( &lcCursor..cFechaEmi ) + "'"+ [, CVERSIONA = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSIONA ) + "'"+ [, cSerie = ] + "'" + this.FormatearTextoSql( &lcCursor..cSerie ) + "'"+ [, cTipC = ] + transform( &lcCursor..cTipC )+ [, prvAfec = ] + "'" + this.FormatearTextoSql( &lcCursor..prvAfec ) + "'"+ [, cFecEnd = ] + "'" + this.ConvertirDateSql( &lcCursor..cFecEnd ) + "'"+ [, cFecha = ] + "'" + this.ConvertirDateSql( &lcCursor..cFecha ) + "'"+ [, cAutoalfa = ] + "'" + this.FormatearTextoSql( &lcCursor..cAutoalfa ) + "'"+ [, cBDeDatA = ] + "'" + this.FormatearTextoSql( &lcCursor..cBDeDatA ) + "'"+ [, CVERSION = ] + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'"+ [, cAutori = ] + transform( &lcCursor..cAutori )+ [, cBdorig = ] + "'" + this.FormatearTextoSql( &lcCursor..cBdorig ) + "'"+ [, cLeyEndoso = ] + "'" + this.FormatearTextoSql( &lcCursor..cLeyEndoso ) + "'"+ [, FechaVenci = ] + "'" + this.ConvertirDateSql( &lcCursor..FechaVenci ) + "'"+ [, cMoneda = ] + "'" + this.FormatearTextoSql( &lcCursor..cMoneda ) + "'"+ [, prvOrig = ] + "'" + this.FormatearTextoSql( &lcCursor..prvOrig ) + "'"+ [, cSigno = ] + transform( &lcCursor..cSigno ) + [ Where cCod = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.CHQPROP Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FALTAFW, FechaOrden, FECEXPO, FECIMPO, FECTRANS, FMODIFW, FLETRAA, UMODIFW, UALTAFW, SMODIFW, HMODIFW, SALTAFW, BDMODIFW, cValor, ESTTRANS, BDALTAFW, HALTAFW, HORAEXPO, HORAIMPO, cCodCompA, ZADSFW, cCodComp, cLetra, VMODIFW, VALTAFW, Anulado, ptoventa, cCod, Chequera, cObss, FPTOVENA, cUsuario, cptovta, numeroC, cEntFin, Estado, FNUMCOMPA, TipoCH, cNumero, cnum, cEntFinEnd, cTipCA, cCompOri, CompA, cCtaEndoso, CElectro, FechaA, cFecOri, cPagueseA, cMonto, CSERIEA, clAfec, Cliente, cVend, cFechaEmi, CVERSIONA, cSerie, cTipC, prvAfec, cFecEnd, cFecha, cAutoalfa, cBDeDatA, CVERSION, cAutori, cBdorig, cLeyEndoso, FechaVenci, cMoneda, prvOrig, cSigno
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaOrden ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRAA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cValor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodCompA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCodComp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cLetra ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + transform( &lcCursor..ptoventa ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Chequera ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObss ) + "'" + ',' + transform( &lcCursor..FPTOVENA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cUsuario ) + "'" + ',' + transform( &lcCursor..cptovta ) + ',' + transform( &lcCursor..numeroC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntFin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Estado ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FNUMCOMPA ) + ',' + transform( &lcCursor..TipoCH ) + ',' + transform( &lcCursor..cNumero ) + ',' + transform( &lcCursor..cnum ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntFinEnd ) + "'" + ',' + transform( &lcCursor..cTipCA ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCompOri ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CompA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCtaEndoso ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..CElectro, 1, 0 )) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFecOri ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cPagueseA ) + "'" + ',' + transform( &lcCursor..cMonto ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CSERIEA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..clAfec ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Cliente ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cVend ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFechaEmi ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSIONA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cSerie ) + "'" + ',' + transform( &lcCursor..cTipC ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..prvAfec ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFecEnd ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..cFecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cAutoalfa ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBDeDatA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CVERSION ) + "'" + ',' + transform( &lcCursor..cAutori ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBdorig ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cLeyEndoso ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FechaVenci ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cMoneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..prvOrig ) + "'" + ',' + transform( &lcCursor..cSigno )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.CHQPROP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUEPROPIO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CHPROPHIST Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCHEQUEPROPIOHIST'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Proveedor","cSerie","Vendedor","Cliente","IdentifEnt","CodigoComp","cVersion","NROITEM","ClienteDes","VendedDes","ProveedDes","CtaBancDes","CtaBanc","Codigo","Fecha","Hora","TipoComp","Comprob","Concepto","ConceptDes","Tipo","idCaja","CajaDesc","BaseOrigen","Estado"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CHPROPHIST ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.Proveedor  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cSerie     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Vendedor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cliente    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdentifEnt ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodigoComp ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cVersion   ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ClienteDes ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.VendedDes  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ProveedDes ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CtaBancDes ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CtaBanc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.Fecha      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Hora       ) + "'" + ',' + transform( cDetallesExistentes.TipoComp   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Comprob    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Concepto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ConceptDes ) + "'" + ',' + transform( cDetallesExistentes.Tipo       ) + ',' + transform( cDetallesExistentes.idCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CajaDesc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BaseOrigen ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Estado     ) + "'" + ' )'  )
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
			Case  lcAlias == lcPrefijo + 'CHEQUEPROPIO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CHEQUEPROPIO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'CHEQUEPROPIO_COBSS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCHEQUEPROPIOHIST'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CHQPROP')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'CHEQUEPROPIO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..ptoventa ) or isnull( &lcCursor..numeroC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad CHEQUEPROPIO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUEPROPIO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUEPROPIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FechaOrden
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FechaA    
		* Validar ANTERIORES A 1/1/1753  cFecOri   
		* Validar ANTERIORES A 1/1/1753  cFechaEmi 
		* Validar ANTERIORES A 1/1/1753  cFecEnd   
		* Validar ANTERIORES A 1/1/1753  cFecha    
		* Validar ANTERIORES A 1/1/1753  FechaVenci
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CHQPROP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CHQPROP
Create Table ZooLogic.TablaTrabajo_CHQPROP ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fechaorden" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fletraa" char( 1 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"cvalor" char( 5 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"ccodcompa" char( 38 )  null, 
"zadsfw" varchar(max)  null, 
"ccodcomp" char( 38 )  null, 
"cletra" char( 1 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"anulado" bit  null, 
"ptoventa" numeric( 4, 0 )  null, 
"ccod" char( 38 )  null, 
"chequera" char( 10 )  null, 
"cobss" varchar(max)  null, 
"fptovena" numeric( 4, 0 )  null, 
"cusuario" char( 100 )  null, 
"cptovta" numeric( 4, 0 )  null, 
"numeroc" numeric( 8, 0 )  null, 
"centfin" char( 5 )  null, 
"estado" char( 5 )  null, 
"fnumcompa" numeric( 8, 0 )  null, 
"tipoch" numeric( 2, 0 )  null, 
"cnumero" numeric( 10, 0 )  null, 
"cnum" numeric( 8, 0 )  null, 
"centfinend" char( 5 )  null, 
"ctipca" numeric( 2, 0 )  null, 
"ccompori" char( 20 )  null, 
"compa" char( 20 )  null, 
"cctaendoso" char( 25 )  null, 
"celectro" bit  null, 
"fechaa" datetime  null, 
"cfecori" datetime  null, 
"cpaguesea" char( 50 )  null, 
"cmonto" numeric( 15, 2 )  null, 
"cseriea" char( 10 )  null, 
"clafec" char( 10 )  null, 
"cliente" char( 10 )  null, 
"cvend" char( 10 )  null, 
"cfechaemi" datetime  null, 
"cversiona" char( 13 )  null, 
"cserie" char( 10 )  null, 
"ctipc" numeric( 2, 0 )  null, 
"prvafec" char( 10 )  null, 
"cfecend" datetime  null, 
"cfecha" datetime  null, 
"cautoalfa" char( 8 )  null, 
"cbdedata" char( 8 )  null, 
"cversion" char( 13 )  null, 
"cautori" numeric( 9, 0 )  null, 
"cbdorig" char( 8 )  null, 
"cleyendoso" char( 55 )  null, 
"fechavenci" datetime  null, 
"cmoneda" char( 10 )  null, 
"prvorig" char( 10 )  null, 
"csigno" numeric( 2, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CHQPROP' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CHQPROP' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'CHEQUEPROPIO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fechaorden','fechaorden')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fletraa','fletraa')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('cvalor','cvalor')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ccodcompa','ccodcompa')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('ccodcomp','ccodcomp')
			.AgregarMapeo('cletra','cletra')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('chequera','chequera')
			.AgregarMapeo('cobss','cobss')
			.AgregarMapeo('fptovena','fptovena')
			.AgregarMapeo('cusuario','cusuario')
			.AgregarMapeo('cptovta','cptovta')
			.AgregarMapeo('numeroc','numeroc')
			.AgregarMapeo('centfin','centfin')
			.AgregarMapeo('estado','estado')
			.AgregarMapeo('fnumcompa','fnumcompa')
			.AgregarMapeo('tipoch','tipoch')
			.AgregarMapeo('cnumero','cnumero')
			.AgregarMapeo('cnum','cnum')
			.AgregarMapeo('centfinend','centfinend')
			.AgregarMapeo('ctipca','ctipca')
			.AgregarMapeo('ccompori','ccompori')
			.AgregarMapeo('compa','compa')
			.AgregarMapeo('cctaendoso','cctaendoso')
			.AgregarMapeo('celectro','celectro')
			.AgregarMapeo('fechaa','fechaa')
			.AgregarMapeo('cfecori','cfecori')
			.AgregarMapeo('cpaguesea','cpaguesea')
			.AgregarMapeo('cmonto','cmonto')
			.AgregarMapeo('cseriea','cseriea')
			.AgregarMapeo('clafec','clafec')
			.AgregarMapeo('cliente','cliente')
			.AgregarMapeo('cvend','cvend')
			.AgregarMapeo('cfechaemi','cfechaemi')
			.AgregarMapeo('cversiona','cversiona')
			.AgregarMapeo('cserie','cserie')
			.AgregarMapeo('ctipc','ctipc')
			.AgregarMapeo('prvafec','prvafec')
			.AgregarMapeo('cfecend','cfecend')
			.AgregarMapeo('cfecha','cfecha')
			.AgregarMapeo('cautoalfa','cautoalfa')
			.AgregarMapeo('cbdedata','cbdedata')
			.AgregarMapeo('cversion','cversion')
			.AgregarMapeo('cautori','cautori')
			.AgregarMapeo('cbdorig','cbdorig')
			.AgregarMapeo('cleyendoso','cleyendoso')
			.AgregarMapeo('fechavenci','fechavenci')
			.AgregarMapeo('cmoneda','cmoneda')
			.AgregarMapeo('prvorig','prvorig')
			.AgregarMapeo('csigno','csigno')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CHQPROP'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECHAORDEN = isnull( d.FECHAORDEN, t.FECHAORDEN ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FLETRAA = isnull( d.FLETRAA, t.FLETRAA ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.CVALOR = isnull( d.CVALOR, t.CVALOR ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.CCODCOMPA = isnull( d.CCODCOMPA, t.CCODCOMPA ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.CCODCOMP = isnull( d.CCODCOMP, t.CCODCOMP ),t.CLETRA = isnull( d.CLETRA, t.CLETRA ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.CHEQUERA = isnull( d.CHEQUERA, t.CHEQUERA ),t.COBSS = isnull( d.COBSS, t.COBSS ),t.FPTOVENA = isnull( d.FPTOVENA, t.FPTOVENA ),t.CUSUARIO = isnull( d.CUSUARIO, t.CUSUARIO ),t.CPTOVTA = isnull( d.CPTOVTA, t.CPTOVTA ),t.NUMEROC = isnull( d.NUMEROC, t.NUMEROC ),t.CENTFIN = isnull( d.CENTFIN, t.CENTFIN ),t.ESTADO = isnull( d.ESTADO, t.ESTADO ),t.FNUMCOMPA = isnull( d.FNUMCOMPA, t.FNUMCOMPA ),t.TIPOCH = isnull( d.TIPOCH, t.TIPOCH ),t.CNUMERO = isnull( d.CNUMERO, t.CNUMERO ),t.CNUM = isnull( d.CNUM, t.CNUM ),t.CENTFINEND = isnull( d.CENTFINEND, t.CENTFINEND ),t.CTIPCA = isnull( d.CTIPCA, t.CTIPCA ),t.CCOMPORI = isnull( d.CCOMPORI, t.CCOMPORI ),t.COMPA = isnull( d.COMPA, t.COMPA ),t.CCTAENDOSO = isnull( d.CCTAENDOSO, t.CCTAENDOSO ),t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),t.FECHAA = isnull( d.FECHAA, t.FECHAA ),t.CFECORI = isnull( d.CFECORI, t.CFECORI ),t.CPAGUESEA = isnull( d.CPAGUESEA, t.CPAGUESEA ),t.CMONTO = isnull( d.CMONTO, t.CMONTO ),t.CSERIEA = isnull( d.CSERIEA, t.CSERIEA ),t.CLAFEC = isnull( d.CLAFEC, t.CLAFEC ),t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),t.CVEND = isnull( d.CVEND, t.CVEND ),t.CFECHAEMI = isnull( d.CFECHAEMI, t.CFECHAEMI ),t.CVERSIONA = isnull( d.CVERSIONA, t.CVERSIONA ),t.CSERIE = isnull( d.CSERIE, t.CSERIE ),t.CTIPC = isnull( d.CTIPC, t.CTIPC ),t.PRVAFEC = isnull( d.PRVAFEC, t.PRVAFEC ),t.CFECEND = isnull( d.CFECEND, t.CFECEND ),t.CFECHA = isnull( d.CFECHA, t.CFECHA ),t.CAUTOALFA = isnull( d.CAUTOALFA, t.CAUTOALFA ),t.CBDEDATA = isnull( d.CBDEDATA, t.CBDEDATA ),t.CVERSION = isnull( d.CVERSION, t.CVERSION ),t.CAUTORI = isnull( d.CAUTORI, t.CAUTORI ),t.CBDORIG = isnull( d.CBDORIG, t.CBDORIG ),t.CLEYENDOSO = isnull( d.CLEYENDOSO, t.CLEYENDOSO ),t.FECHAVENCI = isnull( d.FECHAVENCI, t.FECHAVENCI ),t.CMONEDA = isnull( d.CMONEDA, t.CMONEDA ),t.PRVORIG = isnull( d.PRVORIG, t.PRVORIG ),t.CSIGNO = isnull( d.CSIGNO, t.CSIGNO )
					from ZooLogic.CHQPROP t inner join deleted d 
							 on t.cCod = d.cCod
							 and  t.ptoventa = d.ptoventa
							 and  t.numeroC = d.numeroC
				-- Fin Updates
				insert into ZooLogic.CHQPROP(Faltafw,Fechaorden,Fecexpo,Fecimpo,Fectrans,Fmodifw,Fletraa,Umodifw,Ualtafw,Smodifw,Hmodifw,Saltafw,Bdmodifw,Cvalor,Esttrans,Bdaltafw,Haltafw,Horaexpo,Horaimpo,Ccodcompa,Zadsfw,Ccodcomp,Cletra,Vmodifw,Valtafw,Anulado,Ptoventa,Ccod,Chequera,Cobss,Fptovena,Cusuario,Cptovta,Numeroc,Centfin,Estado,Fnumcompa,Tipoch,Cnumero,Cnum,Centfinend,Ctipca,Ccompori,Compa,Cctaendoso,Celectro,Fechaa,Cfecori,Cpaguesea,Cmonto,Cseriea,Clafec,Cliente,Cvend,Cfechaemi,Cversiona,Cserie,Ctipc,Prvafec,Cfecend,Cfecha,Cautoalfa,Cbdedata,Cversion,Cautori,Cbdorig,Cleyendoso,Fechavenci,Cmoneda,Prvorig,Csigno)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECHAORDEN,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FLETRAA,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.CVALOR,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.CCODCOMPA,''),isnull( d.ZADSFW,''),isnull( d.CCODCOMP,''),isnull( d.CLETRA,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ANULADO,0),isnull( d.PTOVENTA,0),isnull( d.CCOD,''),isnull( d.CHEQUERA,''),isnull( d.COBSS,''),isnull( d.FPTOVENA,0),isnull( d.CUSUARIO,''),isnull( d.CPTOVTA,0),isnull( d.NUMEROC,0),isnull( d.CENTFIN,''),isnull( d.ESTADO,''),isnull( d.FNUMCOMPA,0),isnull( d.TIPOCH,0),isnull( d.CNUMERO,0),isnull( d.CNUM,0),isnull( d.CENTFINEND,''),isnull( d.CTIPCA,0),isnull( d.CCOMPORI,''),isnull( d.COMPA,''),isnull( d.CCTAENDOSO,''),isnull( d.CELECTRO,0),isnull( d.FECHAA,''),isnull( d.CFECORI,''),isnull( d.CPAGUESEA,''),isnull( d.CMONTO,0),isnull( d.CSERIEA,''),isnull( d.CLAFEC,''),isnull( d.CLIENTE,''),isnull( d.CVEND,''),isnull( d.CFECHAEMI,''),isnull( d.CVERSIONA,''),isnull( d.CSERIE,''),isnull( d.CTIPC,0),isnull( d.PRVAFEC,''),isnull( d.CFECEND,''),isnull( d.CFECHA,''),isnull( d.CAUTOALFA,''),isnull( d.CBDEDATA,''),isnull( d.CVERSION,''),isnull( d.CAUTORI,0),isnull( d.CBDORIG,''),isnull( d.CLEYENDOSO,''),isnull( d.FECHAVENCI,''),isnull( d.CMONEDA,''),isnull( d.PRVORIG,''),isnull( d.CSIGNO,0)
						From deleted d left join ZooLogic.CHQPROP pk 
							 on d.cCod = pk.cCod
						 left join ZooLogic.CHQPROP cc 
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
					from ZooLogic.CHQPROP t inner join deleted d 
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
					from ZooLogic.CHQPROP t inner join deleted d 
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
	function ObtenerTriggerDeleteImportacion_CHPROPHIST( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_CHQPROP_CHPROPHIST
ON ZooLogic.TablaTrabajo_CHQPROP_CHPROPHIST
AFTER DELETE
As
Begin
Update t Set 
t.PROVEEDOR = isnull( d.PROVEEDOR, t.PROVEEDOR ),
t.CSERIE = isnull( d.CSERIE, t.CSERIE ),
t.VENDEDOR = isnull( d.VENDEDOR, t.VENDEDOR ),
t.CLIENTE = isnull( d.CLIENTE, t.CLIENTE ),
t.IDENTIFENT = isnull( d.IDENTIFENT, t.IDENTIFENT ),
t.CODIGOCOMP = isnull( d.CODIGOCOMP, t.CODIGOCOMP ),
t.CVERSION = isnull( d.CVERSION, t.CVERSION ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CLIENTEDES = isnull( d.CLIENTEDES, t.CLIENTEDES ),
t.VENDEDDES = isnull( d.VENDEDDES, t.VENDEDDES ),
t.PROVEEDDES = isnull( d.PROVEEDDES, t.PROVEEDDES ),
t.CTABANCDES = isnull( d.CTABANCDES, t.CTABANCDES ),
t.CTABANC = isnull( d.CTABANC, t.CTABANC ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
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
from ZooLogic.CHPROPHIST t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CHPROPHIST
( 
"PROVEEDOR",
"CSERIE",
"VENDEDOR",
"CLIENTE",
"IDENTIFENT",
"CODIGOCOMP",
"CVERSION",
"NROITEM",
"CLIENTEDES",
"VENDEDDES",
"PROVEEDDES",
"CTABANCDES",
"CTABANC",
"CODIGO",
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
d.PROVEEDOR,
d.CSERIE,
d.VENDEDOR,
d.CLIENTE,
d.IDENTIFENT,
d.CODIGOCOMP,
d.CVERSION,
d.NROITEM,
d.CLIENTEDES,
d.VENDEDDES,
d.PROVEEDDES,
d.CTABANCDES,
d.CTABANC,
d.CODIGO,
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
From deleted d left join ZooLogic.CHPROPHIST pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CHQPROP') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CHQPROP
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_CHEQUEPROPIO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaordenamiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaordenamiento, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Letraafectante = nvl( c_CHEQUEPROPIO.Letraafectante, [] )
					.Usuariomodificacionfw = nvl( c_CHEQUEPROPIO.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_CHEQUEPROPIO.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_CHEQUEPROPIO.Seriemodificacionfw, [] )
					.Horamodificacionfw = nvl( c_CHEQUEPROPIO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_CHEQUEPROPIO.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_CHEQUEPROPIO.Basededatosmodificacionfw, [] )
					.Valor = nvl( c_CHEQUEPROPIO.Valor, [] )
					.Estadotransferencia = nvl( c_CHEQUEPROPIO.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_CHEQUEPROPIO.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_CHEQUEPROPIO.Horaaltafw, [] )
					.Horaexpo = nvl( c_CHEQUEPROPIO.Horaexpo, [] )
					.Horaimpo = nvl( c_CHEQUEPROPIO.Horaimpo, [] )
					.Codigocomprobanteafectante = nvl( c_CHEQUEPROPIO.Codigocomprobanteafectante, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Codigocomprobanteorigen = nvl( c_CHEQUEPROPIO.Codigocomprobanteorigen, [] )
					.Letraorigen = nvl( c_CHEQUEPROPIO.Letraorigen, [] )
					.Versionmodificacionfw = nvl( c_CHEQUEPROPIO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_CHEQUEPROPIO.Versionaltafw, [] )
					.Anulado = nvl( c_CHEQUEPROPIO.Anulado, .F. )
					.Puntodeventa = nvl( c_CHEQUEPROPIO.Puntodeventa, 0 )
					.Codigo = nvl( c_CHEQUEPROPIO.Codigo, [] )
					.Chequera_PK =  nvl( c_CHEQUEPROPIO.Chequera, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Historialdetalle.Limpiar()
					.Historialdetalle.SetearEsNavegacion( .lProcesando )
					.Historialdetalle.Cargar()
					.Puntodeventaafectante = nvl( c_CHEQUEPROPIO.Puntodeventaafectante, 0 )
					.Usuarioorigen = nvl( c_CHEQUEPROPIO.Usuarioorigen, [] )
					.Puntodeventaorigen = nvl( c_CHEQUEPROPIO.Puntodeventaorigen, 0 )
					.Numeroc = nvl( c_CHEQUEPROPIO.Numeroc, 0 )
					.Entidadfinanciera_PK =  nvl( c_CHEQUEPROPIO.Entidadfinanciera, [] )
					.Estado = nvl( c_CHEQUEPROPIO.Estado, [] )
					.Numeroafectante = nvl( c_CHEQUEPROPIO.Numeroafectante, 0 )
					.Tipo = nvl( c_CHEQUEPROPIO.Tipo, 0 )
					.Numero = nvl( c_CHEQUEPROPIO.Numero, 0 )
					.Numeroorigen = nvl( c_CHEQUEPROPIO.Numeroorigen, 0 )
					.Entidadfinancieraendoso_PK =  nvl( c_CHEQUEPROPIO.Entidadfinancieraendoso, [] )
					.Tipodecomprobanteafectante = nvl( c_CHEQUEPROPIO.Tipodecomprobanteafectante, 0 )
					.Comprobanteorigen = nvl( c_CHEQUEPROPIO.Comprobanteorigen, [] )
					.Comprobanteafectante = nvl( c_CHEQUEPROPIO.Comprobanteafectante, [] )
					.Cuentaendoso = nvl( c_CHEQUEPROPIO.Cuentaendoso, [] )
					.Chequeelectronico = nvl( c_CHEQUEPROPIO.Chequeelectronico, .F. )
					.Fechaafectante = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaafectante, ctod( '  /  /    ' ) ) )
					.Fechaorigen = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaorigen, ctod( '  /  /    ' ) ) )
					.Paguesea = nvl( c_CHEQUEPROPIO.Paguesea, [] )
					.Monto = nvl( c_CHEQUEPROPIO.Monto, 0 )
					.Cserieafectante = nvl( c_CHEQUEPROPIO.Cserieafectante, [] )
					.Clienteafectante_PK =  nvl( c_CHEQUEPROPIO.Clienteafectante, [] )
					.Cliente_PK =  nvl( c_CHEQUEPROPIO.Cliente, [] )
					.Vendedor_PK =  nvl( c_CHEQUEPROPIO.Vendedor, [] )
					.Fechaemision = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaemision, ctod( '  /  /    ' ) ) )
					.Cversionafectante = nvl( c_CHEQUEPROPIO.Cversionafectante, [] )
					.Serieorigen = nvl( c_CHEQUEPROPIO.Serieorigen, [] )
					.Tipodecomprobanteorigen = nvl( c_CHEQUEPROPIO.Tipodecomprobanteorigen, 0 )
					.Proveedorafectante_PK =  nvl( c_CHEQUEPROPIO.Proveedorafectante, [] )
					.Fechaendoso = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechaendoso, ctod( '  /  /    ' ) ) )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fecha, ctod( '  /  /    ' ) ) )
					.Autorizacionalfa = nvl( c_CHEQUEPROPIO.Autorizacionalfa, [] )
					.Cbasededatosafectante = nvl( c_CHEQUEPROPIO.Cbasededatosafectante, [] )
					.Cversionorigen = nvl( c_CHEQUEPROPIO.Cversionorigen, [] )
					.Autorizacion = nvl( c_CHEQUEPROPIO.Autorizacion, 0 )
					.Bdorigen = nvl( c_CHEQUEPROPIO.Bdorigen, [] )
					.Leyendaendoso = nvl( c_CHEQUEPROPIO.Leyendaendoso, [] )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_CHEQUEPROPIO.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Moneda_PK =  nvl( c_CHEQUEPROPIO.Moneda, [] )
					.Proveedor_PK =  nvl( c_CHEQUEPROPIO.Proveedor, [] )
					.Signodemovimientoorigen = nvl( c_CHEQUEPROPIO.Signodemovimientoorigen, 0 )
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
			lxRetorno = c_CHEQUEPROPIO.CODIGO
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
		return c_CHEQUEPROPIO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.CHQPROP' )
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
								from ZooLogic.CHQPROP 
								Where   CHQPROP.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "CHQPROP", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fechaorden" as "Fechaordenamiento", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fletraa" as "Letraafectante", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Cvalor" as "Valor", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Ccodcompa" as "Codigocomprobanteafectante", "Zadsfw" as "Zadsfw", "Ccodcomp" as "Codigocomprobanteorigen", "Cletra" as "Letraorigen", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Anulado" as "Anulado", "Ptoventa" as "Puntodeventa", "Ccod" as "Codigo", "Chequera" as "Chequera", "Cobss" as "Observacion", "Fptovena" as "Puntodeventaafectante", "Cusuario" as "Usuarioorigen", "Cptovta" as "Puntodeventaorigen", "Numeroc" as "Numeroc", "Centfin" as "Entidadfinanciera", "Estado" as "Estado", "Fnumcompa" as "Numeroafectante", "Tipoch" as "Tipo", "Cnumero" as "Numero", "Cnum" as "Numeroorigen", "Centfinend" as "Entidadfinancieraendoso", "Ctipca" as "Tipodecomprobanteafectante", "Ccompori" as "Comprobanteorigen", "Compa" as "Comprobanteafectante", "Cctaendoso" as "Cuentaendoso", "Celectro" as "Chequeelectronico", "Fechaa" as "Fechaafectante", "Cfecori" as "Fechaorigen", "Cpaguesea" as "Paguesea", "Cmonto" as "Monto", "Cseriea" as "Cserieafectante", "Clafec" as "Clienteafectante", "Cliente" as "Cliente", "Cvend" as "Vendedor", "Cfechaemi" as "Fechaemision", "Cversiona" as "Cversionafectante", "Cserie" as "Serieorigen", "Ctipc" as "Tipodecomprobanteorigen", "Prvafec" as "Proveedorafectante", "Cfecend" as "Fechaendoso", "Cfecha" as "Fecha", "Cautoalfa" as "Autorizacionalfa", "Cbdedata" as "Cbasededatosafectante", "Cversion" as "Cversionorigen", "Cautori" as "Autorizacion", "Cbdorig" as "Bdorigen", "Cleyendoso" as "Leyendaendoso", "Fechavenci" as "Fechavencimiento", "Cmoneda" as "Moneda", "Prvorig" as "Proveedor", "Csigno" as "Signodemovimientoorigen"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.CHQPROP 
								Where   CHQPROP.CCOD != ''
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
	Tabla = 'CHQPROP'
	Filtro = " CHQPROP.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " CHQPROP.CCOD != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "CHQPROP.FechaOrden"
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
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAALTAFW                             " tabla="CHQPROP        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAORDENAMIENTO                       " tabla="CHQPROP        " campo="FECHAORDEN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="38" etiqueta="Fecha de ordenamiento                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAEXPO                               " tabla="CHQPROP        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAIMPO                               " tabla="CHQPROP        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHATRANSFERENCIA                      " tabla="CHQPROP        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAMODIFICACIONFW                     " tabla="CHQPROP        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="LETRAAFECTANTE                          " tabla="CHQPROP        " campo="FLETRAA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra comprobante afectante                                                                                                                                     " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="USUARIOMODIFICACIONFW                   " tabla="CHQPROP        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="USUARIOALTAFW                           " tabla="CHQPROP        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="SERIEMODIFICACIONFW                     " tabla="CHQPROP        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="HORAMODIFICACIONFW                      " tabla="CHQPROP        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="SERIEALTAFW                             " tabla="CHQPROP        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="CHQPROP        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="VALOR                                   " tabla="CHQPROP        " campo="CVALOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Valor                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="ESTADOTRANSFERENCIA                     " tabla="CHQPROP        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="BASEDEDATOSALTAFW                       " tabla="CHQPROP        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="HORAALTAFW                              " tabla="CHQPROP        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="HORAEXPO                                " tabla="CHQPROP        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="HORAIMPO                                " tabla="CHQPROP        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CODIGOCOMPROBANTEAFECTANTE              " tabla="CHQPROP        " campo="CCODCOMPA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo del comprobante afectante                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="DESCRIPCIONTIPOCOMPROBANTEAFECTANTE     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante afectante descripción                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="ZADSFW                                  " tabla="CHQPROP        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CODIGOCOMPROBANTEORIGEN                 " tabla="CHQPROP        " campo="CCODCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo del comprobante                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="LETRAORIGEN                             " tabla="CHQPROP        " campo="CLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Letra comprobante origen                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="VERSIONMODIFICACIONFW                   " tabla="CHQPROP        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="VERSIONALTAFW                           " tabla="CHQPROP        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="DESCRIPCIONTIPOCOMPROBANTEORIGEN        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="80" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante origen descripción                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="ANULADO                                 " tabla="CHQPROP        " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="PUNTODEVENTA                            " tabla="CHQPROP        " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="@ObtenerValorSugeridoPuntodeventa()                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="2" etiqueta="Punto de venta                                                                                                                                                  " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CODIGO                                  " tabla="CHQPROP        " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CHEQUERA                                " tabla="CHQPROP        " campo="CHEQUERA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CHEQUERA                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="20" etiqueta="Chequera                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="OBSERVACION                             " tabla="CHQPROP        " campo="COBSS     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="12" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="HISTORIALDETALLE                        " tabla="CHPROPHIST     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Historial de interacciones                                                                                                                                      " dominio="DETALLEITEMCHEQUEPROPIOHIST   " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="11" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="PUNTODEVENTAAFECTANTE                   " tabla="CHQPROP        " campo="FPTOVENA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta afectante                                                                                                                                        " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="USUARIOORIGEN                           " tabla="CHQPROP        " campo="CUSUARIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="=goServicios.Seguridad.cUsuarioLogueado                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="0" etiqueta="Usuario                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="PUNTODEVENTAORIGEN                      " tabla="CHQPROP        " campo="CPTOVTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Punto de venta origen                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="NUMEROC                                 " tabla="CHQPROP        " campo="NUMEROC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Número interno                                                                                                                                                  " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X999-99999999            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="ENTIDADFINANCIERA                       " tabla="CHQPROP        " campo="CENTFIN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Entidad financiera del cheque                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="Chequera.CuentaBancaria.SucursalBancaria.EntidadFinanciera                                                                                                                                                                                                    " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="ESTADO                                  " tabla="CHQPROP        " campo="ESTADO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Último estado                                                                                                                                                   " dominio="COMBOSERVICIOCHEQUE           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="NUMEROAFECTANTE                         " tabla="CHQPROP        " campo="FNUMCOMPA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Numero comprobante afectante                                                                                                                                    " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="TIPO                                    " tabla="CHQPROP        " campo="TIPOCH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPODEVALORES            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="NUMERO                                  " tabla="CHQPROP        " campo="CNUMERO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Número cheque                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="NUMEROORIGEN                            " tabla="CHQPROP        " campo="CNUM      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Numero comprobante origen                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="ENTIDADFINANCIERAENDOSO                 " tabla="CHQPROP        " campo="CENTFINEND" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Entidad financiera de endoso                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="TIPODECOMPROBANTEAFECTANTE              " tabla="CHQPROP        " campo="CTIPCA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo comprobante afectante                                                                                                                                      " dominio="COMPROBANTEEDICION            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="COMPROBANTEORIGEN                       " tabla="CHQPROP        " campo="CCOMPORI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Identificador                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="COMPROBANTEAFECTANTE                    " tabla="CHQPROP        " campo="COMPA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id comprobante afectante                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CUENTAENDOSO                            " tabla="CHQPROP        " campo="CCTAENDOSO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cuenta                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CHEQUEELECTRONICO                       " tabla="CHQPROP        " campo="CELECTRO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Cheque electrónico                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="Chequera.chequeraelectronica                                                                                                                                                                                                                                  " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAAFECTANTE                          " tabla="CHQPROP        " campo="FECHAA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha afectante                                                                                                                                                 " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAORIGEN                             " tabla="CHQPROP        " campo="CFECORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="0" etiqueta="Fecha origen                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="PAGUESEA                                " tabla="CHQPROP        " campo="CPAGUESEA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Paguese a                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="MONTO                                   " tabla="CHQPROP        " campo="CMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Monto                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CSERIEAFECTANTE                         " tabla="CHQPROP        " campo="CSERIEA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie afectante                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CLIENTEAFECTANTE                        " tabla="CHQPROP        " campo="CLAFEC    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cliente afectante                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CLIENTE                                 " tabla="CHQPROP        " campo="CLIENTE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="VENDEDOR                                " tabla="CHQPROP        " campo="CVEND     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAEMISION                            " tabla="CHQPROP        " campo="CFECHAEMI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="true" admitebusqueda="10" etiqueta="Fecha de emisión                                                                                                                                                " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CVERSIONAFECTANTE                       " tabla="CHQPROP        " campo="CVERSIONA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión afectante                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="SERIEORIGEN                             " tabla="CHQPROP        " campo="CSERIE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="=_screen.zoo.app.cSerie                                                                                                                                                                                                                                       " obligatorio="true" admitebusqueda="20" etiqueta="Serie origen                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="TIPODECOMPROBANTEORIGEN                 " tabla="CHQPROP        " campo="CTIPC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo comprobante origen                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="PROVEEDORAFECTANTE                      " tabla="CHQPROP        " campo="PRVAFEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Proveedor afectante                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAENDOSO                             " tabla="CHQPROP        " campo="CFECEND   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="0" etiqueta="Fecha endoso                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHA                                   " tabla="CHQPROP        " campo="CFECHA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha() + 1                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="8" etiqueta="Fecha de pago                                                                                                                                                   " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="AUTORIZACIONALFA                        " tabla="CHQPROP        " campo="CAUTOALFA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Autorización de cheque                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CBASEDEDATOSAFECTANTE                   " tabla="CHQPROP        " campo="CBDEDATA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="CVERSIONORIGEN                          " tabla="CHQPROP        " campo="CVERSION  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="=_screen.zoo.app.ObtenerVersion()                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="22" etiqueta="Versión origen                                                                                                                                                  " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="AUTORIZACION                            " tabla="CHQPROP        " campo="CAUTORI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Número de autorización de cheque                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999-999999               " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="BDORIGEN                                " tabla="CHQPROP        " campo="CBDORIG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=_screen.zoo.app.cSucursalActiva                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="18" etiqueta="Base de datos origen                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="10" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="LEYENDAENDOSO                           " tabla="CHQPROP        " campo="CLEYENDOSO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="55" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Leyenda                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="FECHAVENCIMIENTO                        " tabla="CHQPROP        " campo="FECHAVENCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="MONEDA                                  " tabla="CHQPROP        " campo="CMONEDA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="PROVEEDOR                               " tabla="CHQPROP        " campo="PRVORIG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUEPROPIO                            " atributo="SIGNODEMOVIMIENTOORIGEN                 " tabla="CHQPROP        " campo="CSIGNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Signo de Movimiento                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CHEQUERA                                " atributo="DESCRIPCION                             " tabla="CHEQUERA       " campo="CQDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Che.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CHEQUERA On CHQPROP.CHEQUERA = CHEQUERA.CqCod And  CHEQUERA.CQCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ENTIDADFINANCIERA                       " atributo="DESCRIPCION                             " tabla="ENTFIN         " campo="EFDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Ent.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ENTFIN On CHQPROP.CENTFIN = ENTFIN.EfCod And  ENTFIN.EFCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="15" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On CHQPROP.CLIENTE = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On CHQPROP.CMONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On CHQPROP.PRVORIG = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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