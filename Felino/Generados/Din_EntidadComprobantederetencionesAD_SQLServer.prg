
define class Din_EntidadCOMPROBANTEDERETENCIONESAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_COMPROBANTEDERETENCIONES'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( PuntoDeVenta, 4, 0) + str( Numero, 10, 0) + TipoImpuesto]
	cExpresionCCPorCampos = [str( #tabla#.PtoVenta, 4, 0) + str( #tabla#.Numero, 10, 0) + #tabla#.TipoImp]
	cTagClaveCandidata = '_CDRCC'
	cTagClavePk = '_CDRPK'
	cTablaPrincipal = 'COMPRET'
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
			local  lxCompretFecexpo, lxCompretFaltafw, lxCompretFmodifw, lxCompretFecimpo, lxCompretFectrans, lxCompretProv, lxCompretTimestamp, lxCompretAnulado, lxCompretHaltafw, lxCompretZadsfw, lxCompretHoraexpo, lxCompretHmodifw, lxCompretHoraimpo, lxCompretValtafw, lxCompretEsttrans, lxCompretSaltafw, lxCompretUmodifw, lxCompretBdmodifw, lxCompretVmodifw, lxCompretBdaltafw, lxCompretSmodifw, lxCompretUaltafw, lxCompretPtoventa, lxCompretCodigo, lxCompretMonsis, lxCompretTipoimp, lxCompretObs, lxCompretDesprov, lxCompretCrtotal, lxCompretNumero, lxCompretFecha, lxCompretMoneda, lxCompretLetraop, lxCompretImpman, lxCompretPtovenop, lxCompretNumop
				lxCompretFecexpo =  .Fechaexpo			lxCompretFaltafw =  .Fechaaltafw			lxCompretFmodifw =  .Fechamodificacionfw			lxCompretFecimpo =  .Fechaimpo			lxCompretFectrans =  .Fechatransferencia			lxCompretProv =  upper( .Proveedor_PK ) 			lxCompretTimestamp = goLibrerias.ObtenerTimestamp()			lxCompretAnulado =  .Anulado			lxCompretHaltafw =  .Horaaltafw			lxCompretZadsfw =  .Zadsfw			lxCompretHoraexpo =  .Horaexpo			lxCompretHmodifw =  .Horamodificacionfw			lxCompretHoraimpo =  .Horaimpo			lxCompretValtafw =  .Versionaltafw			lxCompretEsttrans =  .Estadotransferencia			lxCompretSaltafw =  .Seriealtafw			lxCompretUmodifw =  .Usuariomodificacionfw			lxCompretBdmodifw =  .Basededatosmodificacionfw			lxCompretVmodifw =  .Versionmodificacionfw			lxCompretBdaltafw =  .Basededatosaltafw			lxCompretSmodifw =  .Seriemodificacionfw			lxCompretUaltafw =  .Usuarioaltafw			lxCompretPtoventa =  .Puntodeventa			lxCompretCodigo =  .Codigo			lxCompretMonsis =  upper( .MonedaSistema_PK ) 			lxCompretTipoimp =  upper( .TipoImpuesto_PK ) 			lxCompretObs =  .Obs			lxCompretDesprov =  .Proveedordescripcion			lxCompretCrtotal =  .Total			lxCompretNumero =  .Numero			lxCompretFecha =  .Fecha			lxCompretMoneda =  upper( .MonedaComprobante_PK ) 			lxCompretLetraop =  .Letraordendepago			lxCompretImpman =  .Impuestosmanuales			lxCompretPtovenop =  .Puntodeventaordendepago			lxCompretNumop =  .Numeroordendepago
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxCompretCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPRET ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fectrans","Prov","Timestamp","Anulado","Haltafw","Zadsfw","Horaexpo","Hmodifw","Horaimpo","Valtafw","Esttrans","Saltafw","Umodifw","Bdmodifw","Vmodifw","Bdaltafw","Smodifw","Ualtafw","Ptoventa","Codigo","Monsis","Tipoimp","Obs","Desprov","Crtotal","Numero","Fecha","Moneda","Letraop","Impman","Ptovenop","Numop" ) values ( <<"'" + this.ConvertirDateSql( lxCompretFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretProv ) + "'" >>, <<lxCompretTimestamp >>, <<iif( lxCompretAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCompretHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretUaltafw ) + "'" >>, <<lxCompretPtoventa >>, <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretTipoimp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretDesprov ) + "'" >>, <<lxCompretCrtotal >>, <<lxCompretNumero >>, <<"'" + this.ConvertirDateSql( lxCompretFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretLetraop ) + "'" >>, <<iif( lxCompretImpman, 1, 0 ) >>, <<lxCompretPtovenop >>, <<lxCompretNumop >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesDetalle
				if this.oEntidad.ComprobantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRCompDet("Numafec","NROITEM","PtoAfec","CodComp","Tipo","LetraAfec","CODIGO","Descrip" ) values ( <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMinimo = loItem.Minimo
					lxEscalaporcentaje = loItem.Escalaporcentaje
					lxEscalasobreexcedente = loItem.Escalasobreexcedente
					lxEscalamontofijo = loItem.Escalamontofijo
					lxMontobase = loItem.Montobase
					lxPorcentajedebase = loItem.Porcentajedebase
					lxAcumuladopagos = loItem.Acumuladopagos
					lxAcumuladoretenciones = loItem.Acumuladoretenciones
					lxMinimonoimp = loItem.Minimonoimp
					lxPorcentajedeconvenio = loItem.Porcentajedeconvenio
					lxCertificadosire = loItem.Certificadosire
					lxNroitem = lnContadorNroItem
					lxEsrg1575ar = loItem.Esrg1575ar
					lxAcumuladocomprobantes = loItem.Acumuladocomprobantes
					lxEsrg2616ar = loItem.Esrg2616ar
					lxMontocomprobanteorigen = loItem.Montocomprobanteorigen
					lxEscala = loItem.Escala
					lxCodseguridadsire = loItem.Codseguridadsire
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivodescripcion = loItem.Regimenimpositivodescripcion
					lxConveniomultilateral = loItem.Conveniomultilateral
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxJurisdiccion = loItem.Jurisdiccion
					lxJurisdicciondescripcion = loItem.Jurisdicciondescripcion
					lxResolucion = loItem.Resolucion
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRImpDet("Minimo","EscPorc","EscExced","EscFijo","MontoBase","PorcBase","AcumPagos","AcumRetenc","MinNoImp","PorConvMul","SIRECERT","NROITEM","esRG1575AR","AcumCompr","esRG2616AR","MontoOrige","Escala","SIRECS","RegimenImp","BaseCalc","RegimDescr","ConvMulti","Codigo","CodImp","Descri","Jurisdicci","JurisDeta","ResolDeta","MinNoImpo","Porcentaje","Monto" ) values ( <<lxMinimo>>, <<lxEscalaporcentaje>>, <<lxEscalasobreexcedente>>, <<lxEscalamontofijo>>, <<lxMontobase>>, <<lxPorcentajedebase>>, <<lxAcumuladopagos>>, <<lxAcumuladoretenciones>>, <<lxMinimonoimp>>, <<lxPorcentajedeconvenio>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxNroitem>>, <<iif( lxEsrg1575ar, 1, 0 )>>, <<lxAcumuladocomprobantes>>, <<iif( lxEsrg2616ar, 1, 0 )>>, <<lxMontocomprobanteorigen>>, <<iif( lxEscala, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxConveniomultilateral ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxCompretTimestamp
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
			local  lxCompretFecexpo, lxCompretFaltafw, lxCompretFmodifw, lxCompretFecimpo, lxCompretFectrans, lxCompretProv, lxCompretTimestamp, lxCompretAnulado, lxCompretHaltafw, lxCompretZadsfw, lxCompretHoraexpo, lxCompretHmodifw, lxCompretHoraimpo, lxCompretValtafw, lxCompretEsttrans, lxCompretSaltafw, lxCompretUmodifw, lxCompretBdmodifw, lxCompretVmodifw, lxCompretBdaltafw, lxCompretSmodifw, lxCompretUaltafw, lxCompretPtoventa, lxCompretCodigo, lxCompretMonsis, lxCompretTipoimp, lxCompretObs, lxCompretDesprov, lxCompretCrtotal, lxCompretNumero, lxCompretFecha, lxCompretMoneda, lxCompretLetraop, lxCompretImpman, lxCompretPtovenop, lxCompretNumop
				lxCompretFecexpo =  .Fechaexpo			lxCompretFaltafw =  .Fechaaltafw			lxCompretFmodifw =  .Fechamodificacionfw			lxCompretFecimpo =  .Fechaimpo			lxCompretFectrans =  .Fechatransferencia			lxCompretProv =  upper( .Proveedor_PK ) 			lxCompretTimestamp = goLibrerias.ObtenerTimestamp()			lxCompretAnulado =  .Anulado			lxCompretHaltafw =  .Horaaltafw			lxCompretZadsfw =  .Zadsfw			lxCompretHoraexpo =  .Horaexpo			lxCompretHmodifw =  .Horamodificacionfw			lxCompretHoraimpo =  .Horaimpo			lxCompretValtafw =  .Versionaltafw			lxCompretEsttrans =  .Estadotransferencia			lxCompretSaltafw =  .Seriealtafw			lxCompretUmodifw =  .Usuariomodificacionfw			lxCompretBdmodifw =  .Basededatosmodificacionfw			lxCompretVmodifw =  .Versionmodificacionfw			lxCompretBdaltafw =  .Basededatosaltafw			lxCompretSmodifw =  .Seriemodificacionfw			lxCompretUaltafw =  .Usuarioaltafw			lxCompretPtoventa =  .Puntodeventa			lxCompretCodigo =  .Codigo			lxCompretMonsis =  upper( .MonedaSistema_PK ) 			lxCompretTipoimp =  upper( .TipoImpuesto_PK ) 			lxCompretObs =  .Obs			lxCompretDesprov =  .Proveedordescripcion			lxCompretCrtotal =  .Total			lxCompretNumero =  .Numero			lxCompretFecha =  .Fecha			lxCompretMoneda =  upper( .MonedaComprobante_PK ) 			lxCompretLetraop =  .Letraordendepago			lxCompretImpman =  .Impuestosmanuales			lxCompretPtovenop =  .Puntodeventaordendepago			lxCompretNumop =  .Numeroordendepago
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
				update ZooLogic.COMPRET set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompretFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxCompretFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompretFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompretFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxCompretFectrans ) + "'">>,"Prov" = <<"'" + this.FormatearTextoSql( lxCompretProv ) + "'">>,"Timestamp" = <<lxCompretTimestamp>>,"Anulado" = <<iif( lxCompretAnulado, 1, 0 )>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxCompretHaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompretZadsfw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompretHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompretHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompretHoraimpo ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxCompretValtafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxCompretEsttrans ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxCompretSaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxCompretUmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompretBdmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompretVmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompretBdaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxCompretSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompretUaltafw ) + "'">>,"Ptoventa" = <<lxCompretPtoventa>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxCompretMonsis ) + "'">>,"Tipoimp" = <<"'" + this.FormatearTextoSql( lxCompretTipoimp ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxCompretObs ) + "'">>,"Desprov" = <<"'" + this.FormatearTextoSql( lxCompretDesprov ) + "'">>,"Crtotal" = <<lxCompretCrtotal>>,"Numero" = <<lxCompretNumero>>,"Fecha" = <<"'" + this.ConvertirDateSql( lxCompretFecha ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxCompretMoneda ) + "'">>,"Letraop" = <<"'" + this.FormatearTextoSql( lxCompretLetraop ) + "'">>,"Impman" = <<iif( lxCompretImpman, 1, 0 )>>,"Ptovenop" = <<lxCompretPtovenop>>,"Numop" = <<lxCompretNumop>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'">> and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CRCompDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CRImpDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesDetalle
				if this.oEntidad.ComprobantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRCompDet("Numafec","NROITEM","PtoAfec","CodComp","Tipo","LetraAfec","CODIGO","Descrip" ) values ( <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMinimo = loItem.Minimo
					lxEscalaporcentaje = loItem.Escalaporcentaje
					lxEscalasobreexcedente = loItem.Escalasobreexcedente
					lxEscalamontofijo = loItem.Escalamontofijo
					lxMontobase = loItem.Montobase
					lxPorcentajedebase = loItem.Porcentajedebase
					lxAcumuladopagos = loItem.Acumuladopagos
					lxAcumuladoretenciones = loItem.Acumuladoretenciones
					lxMinimonoimp = loItem.Minimonoimp
					lxPorcentajedeconvenio = loItem.Porcentajedeconvenio
					lxCertificadosire = loItem.Certificadosire
					lxNroitem = lnContadorNroItem
					lxEsrg1575ar = loItem.Esrg1575ar
					lxAcumuladocomprobantes = loItem.Acumuladocomprobantes
					lxEsrg2616ar = loItem.Esrg2616ar
					lxMontocomprobanteorigen = loItem.Montocomprobanteorigen
					lxEscala = loItem.Escala
					lxCodseguridadsire = loItem.Codseguridadsire
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivodescripcion = loItem.Regimenimpositivodescripcion
					lxConveniomultilateral = loItem.Conveniomultilateral
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxJurisdiccion = loItem.Jurisdiccion
					lxJurisdicciondescripcion = loItem.Jurisdicciondescripcion
					lxResolucion = loItem.Resolucion
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRImpDet("Minimo","EscPorc","EscExced","EscFijo","MontoBase","PorcBase","AcumPagos","AcumRetenc","MinNoImp","PorConvMul","SIRECERT","NROITEM","esRG1575AR","AcumCompr","esRG2616AR","MontoOrige","Escala","SIRECS","RegimenImp","BaseCalc","RegimDescr","ConvMulti","Codigo","CodImp","Descri","Jurisdicci","JurisDeta","ResolDeta","MinNoImpo","Porcentaje","Monto" ) values ( <<lxMinimo>>, <<lxEscalaporcentaje>>, <<lxEscalasobreexcedente>>, <<lxEscalamontofijo>>, <<lxMontobase>>, <<lxPorcentajedebase>>, <<lxAcumuladopagos>>, <<lxAcumuladoretenciones>>, <<lxMinimonoimp>>, <<lxPorcentajedeconvenio>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxNroitem>>, <<iif( lxEsrg1575ar, 1, 0 )>>, <<lxAcumuladocomprobantes>>, <<iif( lxEsrg2616ar, 1, 0 )>>, <<lxMontocomprobanteorigen>>, <<iif( lxEscala, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxConveniomultilateral ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxCompretTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPRET where " + this.ConvertirFuncionesSql( " COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'" ) )
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
			Local lxCompretCodigo
			lxCompretCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago" from ZooLogic.COMPRET where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'">> and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'
			endtext
			use in select('c_COMPROBANTEDERETENCIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONES', set( 'Datasession' ) )

			if reccount( 'c_COMPROBANTEDERETENCIONES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion" from ZooLogic.CRCompDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto" from ZooLogic.CRImpDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCompRetPtoVenta As Variant, lxCompRetNumero As Variant, lxCompRetTipoImp As Variant
			lxCompRetPtoVenta = .PuntoDeVenta
			lxCompRetNumero = .Numero
			lxCompRetTipoImp = .TipoImpuesto_Pk
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago" from ZooLogic.COMPRET where  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' And PtoVenta = <<lxCompRetPtoVenta>> and Numero = <<lxCompRetNumero>> and TipoImp = <<"'" + this.FormatearTextoSql( lxCompRetTipoImp ) + "'">>
			endtext
			use in select('c_COMPROBANTEDERETENCIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONES', set( 'Datasession' ) )
			if reccount( 'c_COMPROBANTEDERETENCIONES' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion" from ZooLogic.CRCompDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto" from ZooLogic.CRImpDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxCompretCodigo as Variant
		llRetorno = .t.
		lxCompretCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPRET where "Codigo" = <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'">> and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0) + .TipoImpuesto_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago" from ZooLogic.COMPRET where  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' order by PtoVenta,Numero,TipoImp
			endtext
			use in select('c_COMPROBANTEDERETENCIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion" from ZooLogic.CRCompDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto" from ZooLogic.CRImpDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0) + .TipoImpuesto_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago" from ZooLogic.COMPRET where  str( PtoVenta, 4, 0) + str( Numero, 10, 0) + funciones.padr( TipoImp, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' order by PtoVenta,Numero,TipoImp
			endtext
			use in select('c_COMPROBANTEDERETENCIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion" from ZooLogic.CRCompDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto" from ZooLogic.CRImpDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0) + .TipoImpuesto_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago" from ZooLogic.COMPRET where  str( PtoVenta, 4, 0) + str( Numero, 10, 0) + funciones.padr( TipoImp, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' order by PtoVenta desc,Numero desc,TipoImp desc
			endtext
			use in select('c_COMPROBANTEDERETENCIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion" from ZooLogic.CRCompDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto" from ZooLogic.CRImpDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
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
				lcOrden =  str( .PuntoDeVenta, 4, 0) + str( .Numero, 10, 0) + .TipoImpuesto_PK
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago" from ZooLogic.COMPRET where  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' order by PtoVenta desc,Numero desc,TipoImp desc
			endtext
			use in select('c_COMPROBANTEDERETENCIONES')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPROBANTEDERETENCIONES', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion" from ZooLogic.CRCompDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ComprobantesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ComprobantesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ComprobantesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto" from ZooLogic.CRImpDet where CODIGO = <<"'" + this.FormatearTextoSql( c_COMPROBANTEDERETENCIONES.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fmodifw,Fecimpo,Fectrans,Prov,Timestamp,Anulado,Haltafw,Zadsfw,Horaexpo,Hmod" + ;
"ifw,Horaimpo,Valtafw,Esttrans,Saltafw,Umodifw,Bdmodifw,Vmodifw,Bdaltafw,Smodifw,Ualtafw,Ptoventa,Cod" + ;
"igo,Monsis,Tipoimp,Obs,Desprov,Crtotal,Numero,Fecha,Moneda,Letraop,Impman,Ptovenop,Numop" + ;
" from ZooLogic.COMPRET where  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB' and " + lcFiltro )
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
			local  lxCompretFecexpo, lxCompretFaltafw, lxCompretFmodifw, lxCompretFecimpo, lxCompretFectrans, lxCompretProv, lxCompretTimestamp, lxCompretAnulado, lxCompretHaltafw, lxCompretZadsfw, lxCompretHoraexpo, lxCompretHmodifw, lxCompretHoraimpo, lxCompretValtafw, lxCompretEsttrans, lxCompretSaltafw, lxCompretUmodifw, lxCompretBdmodifw, lxCompretVmodifw, lxCompretBdaltafw, lxCompretSmodifw, lxCompretUaltafw, lxCompretPtoventa, lxCompretCodigo, lxCompretMonsis, lxCompretTipoimp, lxCompretObs, lxCompretDesprov, lxCompretCrtotal, lxCompretNumero, lxCompretFecha, lxCompretMoneda, lxCompretLetraop, lxCompretImpman, lxCompretPtovenop, lxCompretNumop
				lxCompretFecexpo = ctod( '  /  /    ' )			lxCompretFaltafw = ctod( '  /  /    ' )			lxCompretFmodifw = ctod( '  /  /    ' )			lxCompretFecimpo = ctod( '  /  /    ' )			lxCompretFectrans = ctod( '  /  /    ' )			lxCompretProv = []			lxCompretTimestamp = goLibrerias.ObtenerTimestamp()			lxCompretAnulado = .F.			lxCompretHaltafw = []			lxCompretZadsfw = []			lxCompretHoraexpo = []			lxCompretHmodifw = []			lxCompretHoraimpo = []			lxCompretValtafw = []			lxCompretEsttrans = []			lxCompretSaltafw = []			lxCompretUmodifw = []			lxCompretBdmodifw = []			lxCompretVmodifw = []			lxCompretBdaltafw = []			lxCompretSmodifw = []			lxCompretUaltafw = []			lxCompretPtoventa = 0			lxCompretCodigo = []			lxCompretMonsis = []			lxCompretTipoimp = []			lxCompretObs = []			lxCompretDesprov = []			lxCompretCrtotal = 0			lxCompretNumero = 0			lxCompretFecha = ctod( '  /  /    ' )			lxCompretMoneda = []			lxCompretLetraop = []			lxCompretImpman = .F.			lxCompretPtovenop = 0			lxCompretNumop = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CRCompDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CRImpDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPRET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPRET' + '_' + tcCampo
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
		lcWhere = " Where  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPRET', '', tnTope )
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
	Function ObtenerDatosDetalleComprobantesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CRCOMPDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Numafec" as "Numerodecomprobante", "Nroitem" as "Nroitem", "Ptoafec" as "Puntodeventa", "Codcomp" as "Codigocomprobante", "Tipo" as "Tipodecomprobante", "Letraafec" as "Letra", "Codigo" as "Codigo", "Descrip" as "Descripcion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleComprobantesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CRCompDet', 'ComprobantesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleComprobantesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleComprobantesDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleImpuestosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  CRIMPDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Minimo" as "Minimo", "Escporc" as "Escalaporcentaje", "Escexced" as "Escalasobreexcedente", "Escfijo" as "Escalamontofijo", "Montobase" as "Montobase", "Porcbase" as "Porcentajedebase", "Acumpagos" as "Acumuladopagos", "Acumretenc" as "Acumuladoretenciones", "Minnoimp" as "Minimonoimp", "Porconvmul" as "Porcentajedeconvenio", "Sirecert" as "Certificadosire", "Nroitem" as "Nroitem", "Esrg1575ar" as "Esrg1575ar", "Acumcompr" as "Acumuladocomprobantes", "Esrg2616ar" as "Esrg2616ar", "Montoorige" as "Montocomprobanteorigen", "Escala" as "Escala", "Sirecs" as "Codseguridadsire", "Regimenimp" as "Regimenimpositivo", "Basecalc" as "Basedecalculo", "Regimdescr" as "Regimenimpositivodescripcion", "Convmulti" as "Conveniomultilateral", "Codigo" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Jurisdicci" as "Jurisdiccion", "Jurisdeta" as "Jurisdicciondescripcion", "Resoldeta" as "Resolucion", "Minnoimpo" as "Minimonoimponible", "Porcentaje" as "Porcentaje", "Monto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CRImpDet', 'ImpuestosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleImpuestosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleImpuestosDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROV AS PROVEEDOR'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOIMP AS TIPOIMPUESTO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'PROVEEDORDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPROV AS PROVEEDORDESCRIPCION'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRTOTAL AS TOTAL'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHA AS FECHA'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'LETRAORDENDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAOP AS LETRAORDENDEPAGO'
				Case lcAtributo == 'IMPUESTOSMANUALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPMAN AS IMPUESTOSMANUALES'
				Case lcAtributo == 'PUNTODEVENTAORDENDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENOP AS PUNTODEVENTAORDENDEPAGO'
				Case lcAtributo == 'NUMEROORDENDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMOP AS NUMEROORDENDEPAGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleComprobantesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMAFEC AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOAFEC AS PUNTODEVENTA'
				Case lcAtributo == 'CODIGOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOMP AS CODIGOCOMPROBANTE'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPODECOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRAAFEC AS LETRA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleImpuestosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'MINIMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINIMO AS MINIMO'
				Case lcAtributo == 'ESCALAPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESCPORC AS ESCALAPORCENTAJE'
				Case lcAtributo == 'ESCALASOBREEXCEDENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESCEXCED AS ESCALASOBREEXCEDENTE'
				Case lcAtributo == 'ESCALAMONTOFIJO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESCFIJO AS ESCALAMONTOFIJO'
				Case lcAtributo == 'MONTOBASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOBASE AS MONTOBASE'
				Case lcAtributo == 'PORCENTAJEDEBASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCBASE AS PORCENTAJEDEBASE'
				Case lcAtributo == 'ACUMULADOPAGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACUMPAGOS AS ACUMULADOPAGOS'
				Case lcAtributo == 'ACUMULADORETENCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACUMRETENC AS ACUMULADORETENCIONES'
				Case lcAtributo == 'MINIMONOIMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINNOIMP AS MINIMONOIMP'
				Case lcAtributo == 'PORCENTAJEDECONVENIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCONVMUL AS PORCENTAJEDECONVENIO'
				Case lcAtributo == 'CERTIFICADOSIRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIRECERT AS CERTIFICADOSIRE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'ESRG1575AR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESRG1575AR AS ESRG1575AR'
				Case lcAtributo == 'ACUMULADOCOMPROBANTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACUMCOMPR AS ACUMULADOCOMPROBANTES'
				Case lcAtributo == 'ESRG2616AR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESRG2616AR AS ESRG2616AR'
				Case lcAtributo == 'MONTOCOMPROBANTEORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOORIGE AS MONTOCOMPROBANTEORIGEN'
				Case lcAtributo == 'ESCALA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESCALA AS ESCALA'
				Case lcAtributo == 'CODSEGURIDADSIRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIRECS AS CODSEGURIDADSIRE'
				Case lcAtributo == 'REGIMENIMPOSITIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMENIMP AS REGIMENIMPOSITIVO'
				Case lcAtributo == 'BASEDECALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASECALC AS BASEDECALCULO'
				Case lcAtributo == 'REGIMENIMPOSITIVODESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMDESCR AS REGIMENIMPOSITIVODESCRIPCION'
				Case lcAtributo == 'CONVENIOMULTILATERAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVMULTI AS CONVENIOMULTILATERAL'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIMP AS CODIMP'
				Case lcAtributo == 'CODIMPDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS CODIMPDETALLE'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDICCI AS JURISDICCION'
				Case lcAtributo == 'JURISDICCIONDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDETA AS JURISDICCIONDESCRIPCION'
				Case lcAtributo == 'RESOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESOLDETA AS RESOLUCION'
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINNOIMPO AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTAJE AS PORCENTAJE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'PROV'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORDESCRIPCION'
				lcCampo = 'DESPROV'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'CRTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FECHA'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRAORDENDEPAGO'
				lcCampo = 'LETRAOP'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOSMANUALES'
				lcCampo = 'IMPMAN'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAORDENDEPAGO'
				lcCampo = 'PTOVENOP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROORDENDEPAGO'
				lcCampo = 'NUMOP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleComprobantesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOCOMPROBANTE'
				lcCampo = 'CODCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRAAFEC'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'MINIMO'
				lcCampo = 'MINIMO'
			Case upper( alltrim( tcAtributo ) ) == 'ESCALAPORCENTAJE'
				lcCampo = 'ESCPORC'
			Case upper( alltrim( tcAtributo ) ) == 'ESCALASOBREEXCEDENTE'
				lcCampo = 'ESCEXCED'
			Case upper( alltrim( tcAtributo ) ) == 'ESCALAMONTOFIJO'
				lcCampo = 'ESCFIJO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOBASE'
				lcCampo = 'MONTOBASE'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDEBASE'
				lcCampo = 'PORCBASE'
			Case upper( alltrim( tcAtributo ) ) == 'ACUMULADOPAGOS'
				lcCampo = 'ACUMPAGOS'
			Case upper( alltrim( tcAtributo ) ) == 'ACUMULADORETENCIONES'
				lcCampo = 'ACUMRETENC'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMP'
				lcCampo = 'MINNOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDECONVENIO'
				lcCampo = 'PORCONVMUL'
			Case upper( alltrim( tcAtributo ) ) == 'CERTIFICADOSIRE'
				lcCampo = 'SIRECERT'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'ESRG1575AR'
				lcCampo = 'ESRG1575AR'
			Case upper( alltrim( tcAtributo ) ) == 'ACUMULADOCOMPROBANTES'
				lcCampo = 'ACUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'ESRG2616AR'
				lcCampo = 'ESRG2616AR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCOMPROBANTEORIGEN'
				lcCampo = 'MONTOORIGE'
			Case upper( alltrim( tcAtributo ) ) == 'ESCALA'
				lcCampo = 'ESCALA'
			Case upper( alltrim( tcAtributo ) ) == 'CODSEGURIDADSIRE'
				lcCampo = 'SIRECS'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMENIMPOSITIVO'
				lcCampo = 'REGIMENIMP'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDECALCULO'
				lcCampo = 'BASECALC'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMENIMPOSITIVODESCRIPCION'
				lcCampo = 'REGIMDESCR'
			Case upper( alltrim( tcAtributo ) ) == 'CONVENIOMULTILATERAL'
				lcCampo = 'CONVMULTI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMP'
				lcCampo = 'CODIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMPDETALLE'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURISDICCI'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCIONDESCRIPCION'
				lcCampo = 'JURISDETA'
			Case upper( alltrim( tcAtributo ) ) == 'RESOLUCION'
				lcCampo = 'RESOLDETA'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINNOIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCENTAJE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMPROBANTESDETALLE'
			lcRetorno = 'CRCOMPDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'CRIMPDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxCompretFecexpo, lxCompretFaltafw, lxCompretFmodifw, lxCompretFecimpo, lxCompretFectrans, lxCompretProv, lxCompretTimestamp, lxCompretAnulado, lxCompretHaltafw, lxCompretZadsfw, lxCompretHoraexpo, lxCompretHmodifw, lxCompretHoraimpo, lxCompretValtafw, lxCompretEsttrans, lxCompretSaltafw, lxCompretUmodifw, lxCompretBdmodifw, lxCompretVmodifw, lxCompretBdaltafw, lxCompretSmodifw, lxCompretUaltafw, lxCompretPtoventa, lxCompretCodigo, lxCompretMonsis, lxCompretTipoimp, lxCompretObs, lxCompretDesprov, lxCompretCrtotal, lxCompretNumero, lxCompretFecha, lxCompretMoneda, lxCompretLetraop, lxCompretImpman, lxCompretPtovenop, lxCompretNumop
				lxCompretFecexpo =  .Fechaexpo			lxCompretFaltafw =  .Fechaaltafw			lxCompretFmodifw =  .Fechamodificacionfw			lxCompretFecimpo =  .Fechaimpo			lxCompretFectrans =  .Fechatransferencia			lxCompretProv =  upper( .Proveedor_PK ) 			lxCompretTimestamp = goLibrerias.ObtenerTimestamp()			lxCompretAnulado =  .Anulado			lxCompretHaltafw =  .Horaaltafw			lxCompretZadsfw =  .Zadsfw			lxCompretHoraexpo =  .Horaexpo			lxCompretHmodifw =  .Horamodificacionfw			lxCompretHoraimpo =  .Horaimpo			lxCompretValtafw =  .Versionaltafw			lxCompretEsttrans =  .Estadotransferencia			lxCompretSaltafw =  .Seriealtafw			lxCompretUmodifw =  .Usuariomodificacionfw			lxCompretBdmodifw =  .Basededatosmodificacionfw			lxCompretVmodifw =  .Versionmodificacionfw			lxCompretBdaltafw =  .Basededatosaltafw			lxCompretSmodifw =  .Seriemodificacionfw			lxCompretUaltafw =  .Usuarioaltafw			lxCompretPtoventa =  .Puntodeventa			lxCompretCodigo =  .Codigo			lxCompretMonsis =  upper( .MonedaSistema_PK ) 			lxCompretTipoimp =  upper( .TipoImpuesto_PK ) 			lxCompretObs =  .Obs			lxCompretDesprov =  .Proveedordescripcion			lxCompretCrtotal =  .Total			lxCompretNumero =  .Numero			lxCompretFecha =  .Fecha			lxCompretMoneda =  upper( .MonedaComprobante_PK ) 			lxCompretLetraop =  .Letraordendepago			lxCompretImpman =  .Impuestosmanuales			lxCompretPtovenop =  .Puntodeventaordendepago			lxCompretNumop =  .Numeroordendepago
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPRET ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fectrans","Prov","Timestamp","Anulado","Haltafw","Zadsfw","Horaexpo","Hmodifw","Horaimpo","Valtafw","Esttrans","Saltafw","Umodifw","Bdmodifw","Vmodifw","Bdaltafw","Smodifw","Ualtafw","Ptoventa","Codigo","Monsis","Tipoimp","Obs","Desprov","Crtotal","Numero","Fecha","Moneda","Letraop","Impman","Ptovenop","Numop" ) values ( <<"'" + this.ConvertirDateSql( lxCompretFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxCompretFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretProv ) + "'" >>, <<lxCompretTimestamp >>, <<iif( lxCompretAnulado, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxCompretHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretUaltafw ) + "'" >>, <<lxCompretPtoventa >>, <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretTipoimp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretObs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretDesprov ) + "'" >>, <<lxCompretCrtotal >>, <<lxCompretNumero >>, <<"'" + this.ConvertirDateSql( lxCompretFecha ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxCompretLetraop ) + "'" >>, <<iif( lxCompretImpman, 1, 0 ) >>, <<lxCompretPtovenop >>, <<lxCompretNumop >> )
		endtext
		loColeccion.cTabla = 'COMPRET' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesDetalle
				if this.oEntidad.ComprobantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRCompDet("Numafec","NROITEM","PtoAfec","CodComp","Tipo","LetraAfec","CODIGO","Descrip" ) values ( <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMinimo = loItem.Minimo
					lxEscalaporcentaje = loItem.Escalaporcentaje
					lxEscalasobreexcedente = loItem.Escalasobreexcedente
					lxEscalamontofijo = loItem.Escalamontofijo
					lxMontobase = loItem.Montobase
					lxPorcentajedebase = loItem.Porcentajedebase
					lxAcumuladopagos = loItem.Acumuladopagos
					lxAcumuladoretenciones = loItem.Acumuladoretenciones
					lxMinimonoimp = loItem.Minimonoimp
					lxPorcentajedeconvenio = loItem.Porcentajedeconvenio
					lxCertificadosire = loItem.Certificadosire
					lxNroitem = lnContadorNroItem
					lxEsrg1575ar = loItem.Esrg1575ar
					lxAcumuladocomprobantes = loItem.Acumuladocomprobantes
					lxEsrg2616ar = loItem.Esrg2616ar
					lxMontocomprobanteorigen = loItem.Montocomprobanteorigen
					lxEscala = loItem.Escala
					lxCodseguridadsire = loItem.Codseguridadsire
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivodescripcion = loItem.Regimenimpositivodescripcion
					lxConveniomultilateral = loItem.Conveniomultilateral
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxJurisdiccion = loItem.Jurisdiccion
					lxJurisdicciondescripcion = loItem.Jurisdicciondescripcion
					lxResolucion = loItem.Resolucion
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRImpDet("Minimo","EscPorc","EscExced","EscFijo","MontoBase","PorcBase","AcumPagos","AcumRetenc","MinNoImp","PorConvMul","SIRECERT","NROITEM","esRG1575AR","AcumCompr","esRG2616AR","MontoOrige","Escala","SIRECS","RegimenImp","BaseCalc","RegimDescr","ConvMulti","Codigo","CodImp","Descri","Jurisdicci","JurisDeta","ResolDeta","MinNoImpo","Porcentaje","Monto" ) values ( <<lxMinimo>>, <<lxEscalaporcentaje>>, <<lxEscalasobreexcedente>>, <<lxEscalamontofijo>>, <<lxMontobase>>, <<lxPorcentajedebase>>, <<lxAcumuladopagos>>, <<lxAcumuladoretenciones>>, <<lxMinimonoimp>>, <<lxPorcentajedeconvenio>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxNroitem>>, <<iif( lxEsrg1575ar, 1, 0 )>>, <<lxAcumuladocomprobantes>>, <<iif( lxEsrg2616ar, 1, 0 )>>, <<lxMontocomprobanteorigen>>, <<iif( lxEscala, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxConveniomultilateral ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, <<lxMonto>> ) 
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
			local  lxCompretFecexpo, lxCompretFaltafw, lxCompretFmodifw, lxCompretFecimpo, lxCompretFectrans, lxCompretProv, lxCompretTimestamp, lxCompretAnulado, lxCompretHaltafw, lxCompretZadsfw, lxCompretHoraexpo, lxCompretHmodifw, lxCompretHoraimpo, lxCompretValtafw, lxCompretEsttrans, lxCompretSaltafw, lxCompretUmodifw, lxCompretBdmodifw, lxCompretVmodifw, lxCompretBdaltafw, lxCompretSmodifw, lxCompretUaltafw, lxCompretPtoventa, lxCompretCodigo, lxCompretMonsis, lxCompretTipoimp, lxCompretObs, lxCompretDesprov, lxCompretCrtotal, lxCompretNumero, lxCompretFecha, lxCompretMoneda, lxCompretLetraop, lxCompretImpman, lxCompretPtovenop, lxCompretNumop
				lxCompretFecexpo =  .Fechaexpo			lxCompretFaltafw =  .Fechaaltafw			lxCompretFmodifw =  .Fechamodificacionfw			lxCompretFecimpo =  .Fechaimpo			lxCompretFectrans =  .Fechatransferencia			lxCompretProv =  upper( .Proveedor_PK ) 			lxCompretTimestamp = goLibrerias.ObtenerTimestamp()			lxCompretAnulado =  .Anulado			lxCompretHaltafw =  .Horaaltafw			lxCompretZadsfw =  .Zadsfw			lxCompretHoraexpo =  .Horaexpo			lxCompretHmodifw =  .Horamodificacionfw			lxCompretHoraimpo =  .Horaimpo			lxCompretValtafw =  .Versionaltafw			lxCompretEsttrans =  .Estadotransferencia			lxCompretSaltafw =  .Seriealtafw			lxCompretUmodifw =  .Usuariomodificacionfw			lxCompretBdmodifw =  .Basededatosmodificacionfw			lxCompretVmodifw =  .Versionmodificacionfw			lxCompretBdaltafw =  .Basededatosaltafw			lxCompretSmodifw =  .Seriemodificacionfw			lxCompretUaltafw =  .Usuarioaltafw			lxCompretPtoventa =  .Puntodeventa			lxCompretCodigo =  .Codigo			lxCompretMonsis =  upper( .MonedaSistema_PK ) 			lxCompretTipoimp =  upper( .TipoImpuesto_PK ) 			lxCompretObs =  .Obs			lxCompretDesprov =  .Proveedordescripcion			lxCompretCrtotal =  .Total			lxCompretNumero =  .Numero			lxCompretFecha =  .Fecha			lxCompretMoneda =  upper( .MonedaComprobante_PK ) 			lxCompretLetraop =  .Letraordendepago			lxCompretImpman =  .Impuestosmanuales			lxCompretPtovenop =  .Puntodeventaordendepago			lxCompretNumop =  .Numeroordendepago
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB']
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPRET set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxCompretFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxCompretFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxCompretFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxCompretFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxCompretFectrans ) + "'">>, "Prov" = <<"'" + this.FormatearTextoSql( lxCompretProv ) + "'">>, "Timestamp" = <<lxCompretTimestamp>>, "Anulado" = <<iif( lxCompretAnulado, 1, 0 )>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxCompretHaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxCompretZadsfw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxCompretHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxCompretHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxCompretHoraimpo ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxCompretValtafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxCompretEsttrans ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxCompretSaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxCompretUmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxCompretBdmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxCompretVmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxCompretBdaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxCompretSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxCompretUaltafw ) + "'">>, "Ptoventa" = <<lxCompretPtoventa>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxCompretCodigo ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxCompretMonsis ) + "'">>, "Tipoimp" = <<"'" + this.FormatearTextoSql( lxCompretTipoimp ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxCompretObs ) + "'">>, "Desprov" = <<"'" + this.FormatearTextoSql( lxCompretDesprov ) + "'">>, "Crtotal" = <<lxCompretCrtotal>>, "Numero" = <<lxCompretNumero>>, "Fecha" = <<"'" + this.ConvertirDateSql( lxCompretFecha ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxCompretMoneda ) + "'">>, "Letraop" = <<"'" + this.FormatearTextoSql( lxCompretLetraop ) + "'">>, "Impman" = <<iif( lxCompretImpman, 1, 0 )>>, "Ptovenop" = <<lxCompretPtovenop>>, "Numop" = <<lxCompretNumop>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPRET' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CRCompDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CRImpDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ComprobantesDetalle
				if this.oEntidad.ComprobantesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNroitem = lnContadorNroItem
					lxPuntodeventa = loItem.Puntodeventa
					lxCodigocomprobante = loItem.Codigocomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxDescripcion = loItem.Descripcion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRCompDet("Numafec","NROITEM","PtoAfec","CodComp","Tipo","LetraAfec","CODIGO","Descrip" ) values ( <<lxNumerodecomprobante>>, <<lxNroitem>>, <<lxPuntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigocomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMinimo = loItem.Minimo
					lxEscalaporcentaje = loItem.Escalaporcentaje
					lxEscalasobreexcedente = loItem.Escalasobreexcedente
					lxEscalamontofijo = loItem.Escalamontofijo
					lxMontobase = loItem.Montobase
					lxPorcentajedebase = loItem.Porcentajedebase
					lxAcumuladopagos = loItem.Acumuladopagos
					lxAcumuladoretenciones = loItem.Acumuladoretenciones
					lxMinimonoimp = loItem.Minimonoimp
					lxPorcentajedeconvenio = loItem.Porcentajedeconvenio
					lxCertificadosire = loItem.Certificadosire
					lxNroitem = lnContadorNroItem
					lxEsrg1575ar = loItem.Esrg1575ar
					lxAcumuladocomprobantes = loItem.Acumuladocomprobantes
					lxEsrg2616ar = loItem.Esrg2616ar
					lxMontocomprobanteorigen = loItem.Montocomprobanteorigen
					lxEscala = loItem.Escala
					lxCodseguridadsire = loItem.Codseguridadsire
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivodescripcion = loItem.Regimenimpositivodescripcion
					lxConveniomultilateral = loItem.Conveniomultilateral
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxJurisdiccion = loItem.Jurisdiccion
					lxJurisdicciondescripcion = loItem.Jurisdicciondescripcion
					lxResolucion = loItem.Resolucion
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CRImpDet("Minimo","EscPorc","EscExced","EscFijo","MontoBase","PorcBase","AcumPagos","AcumRetenc","MinNoImp","PorConvMul","SIRECERT","NROITEM","esRG1575AR","AcumCompr","esRG2616AR","MontoOrige","Escala","SIRECS","RegimenImp","BaseCalc","RegimDescr","ConvMulti","Codigo","CodImp","Descri","Jurisdicci","JurisDeta","ResolDeta","MinNoImpo","Porcentaje","Monto" ) values ( <<lxMinimo>>, <<lxEscalaporcentaje>>, <<lxEscalasobreexcedente>>, <<lxEscalamontofijo>>, <<lxMontobase>>, <<lxPorcentajedebase>>, <<lxAcumuladopagos>>, <<lxAcumuladoretenciones>>, <<lxMinimonoimp>>, <<lxPorcentajedeconvenio>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxNroitem>>, <<iif( lxEsrg1575ar, 1, 0 )>>, <<lxAcumuladocomprobantes>>, <<iif( lxEsrg2616ar, 1, 0 )>>, <<lxMontocomprobanteorigen>>, <<iif( lxEscala, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivodescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxConveniomultilateral ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdicciondescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxResolucion ) + "'">>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB']
		loColeccion.Agregar( 'delete from ZooLogic.COMPRET where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CRCompDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CRImpDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'COMPRET' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPRET where  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPRET where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCompRetPtoVenta as variant, lxCompRetTipoImp as variant, lxCompRetNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONES'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPRET Where  PtoVenta = ] + transform( &lcCursor..PtoVenta   ) + [ and Numero = ] + transform( &lcCursor..Numero     ) + [ and TipoImp = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoImp    ) + "'", 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPRET set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, Prov = ] + "'" + this.FormatearTextoSql( &lcCursor..Prov ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, PtoVenta = ] + transform( &lcCursor..PtoVenta )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, TipoImp = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoImp ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, DesProv = ] + "'" + this.FormatearTextoSql( &lcCursor..DesProv ) + "'"+ [, CRTotal = ] + transform( &lcCursor..CRTotal )+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Fecha = ] + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, LetraOP = ] + "'" + this.FormatearTextoSql( &lcCursor..LetraOP ) + "'"+ [, ImpMan = ] + Transform( iif( &lcCursor..ImpMan, 1, 0 ))+ [, PtoVenOP = ] + transform( &lcCursor..PtoVenOP )+ [, NumOP = ] + transform( &lcCursor..NumOP ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPRET Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FMODIFW, FECIMPO, FECTRANS, Prov, TIMESTAMP, Anulado, HALTAFW, ZADSFW, HORAEXPO, HMODIFW, HORAIMPO, VALTAFW, ESTTRANS, SALTAFW, UMODIFW, BDMODIFW, VMODIFW, BDALTAFW, SMODIFW, UALTAFW, PtoVenta, CODIGO, MonSis, TipoImp, Obs, DesProv, CRTotal, Numero, Fecha, Moneda, LetraOP, ImpMan, PtoVenOP, NumOP
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Prov ) + "'" + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + transform( &lcCursor..PtoVenta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoImp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DesProv ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CRTotal ) + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..Fecha ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LetraOP ) + "'" + ',' + Transform( iif( &lcCursor..ImpMan, 1, 0 )) + ',' + transform( &lcCursor..PtoVenOP ) + ',' + transform( &lcCursor..NumOP )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPRET ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONES'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CRCompDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CRImpDet Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCDRCOMPROBANTES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Numafec","NROITEM","PtoAfec","CodComp","Tipo","LetraAfec","CODIGO","Descrip"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CRCompDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Numafec    ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.PtoAfec    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodComp    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Tipo       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.LetraAfec  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descrip    ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCDRIMPUESTOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Minimo","EscPorc","EscExced","EscFijo","MontoBase","PorcBase","AcumPagos","AcumRetenc","MinNoImp","PorConvMul","SIRECERT","NROITEM","esRG1575AR","AcumCompr","esRG2616AR","MontoOrige","Escala","SIRECS","RegimenImp","BaseCalc","RegimDescr","ConvMulti","Codigo","CodImp","Descri","Jurisdicci","JurisDeta","ResolDeta","MinNoImpo","Porcentaje","Monto"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CRImpDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Minimo     ) + ',' + transform( cDetallesExistentes.EscPorc    ) + ',' + transform( cDetallesExistentes.EscExced   ) + ',' + transform( cDetallesExistentes.EscFijo    ) + ',' + transform( cDetallesExistentes.MontoBase  ) + ',' + transform( cDetallesExistentes.PorcBase   ) + ',' + transform( cDetallesExistentes.AcumPagos  ) + ',' + transform( cDetallesExistentes.AcumRetenc ) + ',' + transform( cDetallesExistentes.MinNoImp   ) + ',' + transform( cDetallesExistentes.PorConvMul ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SIRECERT   ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.esRG1575AR, 1, 0 )) + ',' + transform( cDetallesExistentes.AcumCompr  ) + ',' + Transform( iif( cDetallesExistentes.esRG2616AR, 1, 0 )) + ',' + transform( cDetallesExistentes.MontoOrige ) + ',' + Transform( iif( cDetallesExistentes.Escala    , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SIRECS     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RegimenImp ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.BaseCalc   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RegimDescr ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ConvMulti  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Jurisdicci ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JurisDeta  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ResolDeta  ) + "'" + ',' + transform( cDetallesExistentes.MinNoImpo  ) + ',' + transform( cDetallesExistentes.Porcentaje ) + ',' + transform( cDetallesExistentes.Monto      ) + ' )'  )
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
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..PtoVenta   )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..Numero     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDERETENCIONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDERETENCIONES_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'COMPROBANTEDERETENCIONES_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCDRCOMPROBANTES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCDRIMPUESTOS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_CompRet')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'COMPROBANTEDERETENCIONES'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..PtoVenta ) or isnull( &lcCursor..Numero ) or isnull( &lcCursor..TipoImp )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad COMPROBANTEDERETENCIONES. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( PtoVenta, 4, 0) + str( Numero, 10, 0) + TipoImp as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( PtoVenta, 4, 0) + str( Numero, 10, 0) + TipoImp, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONES'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  Fecha     
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CompRet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CompRet
Create Table ZooLogic.TablaTrabajo_CompRet ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"prov" char( 5 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"anulado" bit  null, 
"haltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"esttrans" char( 20 )  null, 
"saltafw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"bdmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"bdaltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"ptoventa" numeric( 4, 0 )  null, 
"codigo" char( 38 )  null, 
"monsis" char( 10 )  null, 
"tipoimp" char( 10 )  null, 
"obs" varchar(max)  null, 
"desprov" char( 60 )  null, 
"crtotal" numeric( 15, 2 )  null, 
"numero" numeric( 10, 0 )  null, 
"fecha" datetime  null, 
"moneda" char( 10 )  null, 
"letraop" char( 1 )  null, 
"impman" bit  null, 
"ptovenop" numeric( 4, 0 )  null, 
"numop" numeric( 10, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_CompRet' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_CompRet' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'COMPROBANTEDERETENCIONES'
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('prov','prov')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('ptoventa','ptoventa')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('tipoimp','tipoimp')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('desprov','desprov')
			.AgregarMapeo('crtotal','crtotal')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('fecha','fecha')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('letraop','letraop')
			.AgregarMapeo('impman','impman')
			.AgregarMapeo('ptovenop','ptovenop')
			.AgregarMapeo('numop','numop')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_CompRet'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.PROV = isnull( d.PROV, t.PROV ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.TIPOIMP = isnull( d.TIPOIMP, t.TIPOIMP ),t.OBS = isnull( d.OBS, t.OBS ),t.DESPROV = isnull( d.DESPROV, t.DESPROV ),t.CRTOTAL = isnull( d.CRTOTAL, t.CRTOTAL ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FECHA = isnull( d.FECHA, t.FECHA ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.LETRAOP = isnull( d.LETRAOP, t.LETRAOP ),t.IMPMAN = isnull( d.IMPMAN, t.IMPMAN ),t.PTOVENOP = isnull( d.PTOVENOP, t.PTOVENOP ),t.NUMOP = isnull( d.NUMOP, t.NUMOP )
					from ZooLogic.COMPRET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.PtoVenta = d.PtoVenta
							 and  t.Numero = d.Numero
							 and  t.TipoImp = d.TipoImp
				-- Fin Updates
				insert into ZooLogic.COMPRET(Fecexpo,Faltafw,Fmodifw,Fecimpo,Fectrans,Prov,Timestamp,Anulado,Haltafw,Zadsfw,Horaexpo,Hmodifw,Horaimpo,Valtafw,Esttrans,Saltafw,Umodifw,Bdmodifw,Vmodifw,Bdaltafw,Smodifw,Ualtafw,Ptoventa,Codigo,Monsis,Tipoimp,Obs,Desprov,Crtotal,Numero,Fecha,Moneda,Letraop,Impman,Ptovenop,Numop)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.PROV,''),isnull( d.TIMESTAMP,0),isnull( d.ANULADO,0),convert( char(8), getdate(), 108 ),isnull( d.ZADSFW,''),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.SALTAFW,''),isnull( d.UMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.VMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.PTOVENTA,0),isnull( d.CODIGO,''),isnull( d.MONSIS,''),isnull( d.TIPOIMP,''),isnull( d.OBS,''),isnull( d.DESPROV,''),isnull( d.CRTOTAL,0),isnull( d.NUMERO,0),isnull( d.FECHA,''),isnull( d.MONEDA,''),isnull( d.LETRAOP,''),isnull( d.IMPMAN,0),isnull( d.PTOVENOP,0),isnull( d.NUMOP,0)
						From deleted d left join ZooLogic.COMPRET pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.COMPRET cc 
							 on  d.PtoVenta = cc.PtoVenta
							 and  d.Numero = cc.Numero
							 and  d.TipoImp = cc.TipoImp
						Where pk.CODIGO Is Null 
							 and cc.PtoVenta Is Null 
							 and cc.Numero Is Null 
							 and cc.TipoImp Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.PtoVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(10) ) + ', TIPO DE IMPUESTO ' + cast( d.TipoImp as Varchar(10) ) + '','La clave principal no es la esperada'
					from ZooLogic.COMPRET t inner join deleted d 
							on   t.PtoVenta = d.PtoVenta
							 and  t.Numero = d.Numero
							 and  t.TipoImp = d.TipoImp
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.PtoVenta as Varchar(4) ) + ', NÚMERO ' + cast( d.Numero as Varchar(10) ) + ', TIPO DE IMPUESTO ' + cast( d.TipoImp as Varchar(10) ) + '','La clave principal a importar ya existe'
					from ZooLogic.COMPRET t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.PtoVenta = h.PtoVenta
							 and   t.Numero = h.Numero
							 and   t.TipoImp = h.TipoImp
							where   h.PtoVenta is null 
							 and   h.Numero is null 
							 and   h.TipoImp is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CRCompDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPRET_CRCompDet
ON ZooLogic.TablaTrabajo_COMPRET_CRCompDet
AFTER DELETE
As
Begin
Update t Set 
t.NUMAFEC = isnull( d.NUMAFEC, t.NUMAFEC ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PTOAFEC = isnull( d.PTOAFEC, t.PTOAFEC ),
t.CODCOMP = isnull( d.CODCOMP, t.CODCOMP ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.LETRAAFEC = isnull( d.LETRAAFEC, t.LETRAAFEC ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP )
from ZooLogic.CRCompDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CRCompDet
( 
"NUMAFEC",
"NROITEM",
"PTOAFEC",
"CODCOMP",
"TIPO",
"LETRAAFEC",
"CODIGO",
"DESCRIP"
 )
Select 
d.NUMAFEC,
d.NROITEM,
d.PTOAFEC,
d.CODCOMP,
d.TIPO,
d.LETRAAFEC,
d.CODIGO,
d.DESCRIP
From deleted d left join ZooLogic.CRCompDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CRImpDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPRET_CRImpDet
ON ZooLogic.TablaTrabajo_COMPRET_CRImpDet
AFTER DELETE
As
Begin
Update t Set 
t.MINIMO = isnull( d.MINIMO, t.MINIMO ),
t.ESCPORC = isnull( d.ESCPORC, t.ESCPORC ),
t.ESCEXCED = isnull( d.ESCEXCED, t.ESCEXCED ),
t.ESCFIJO = isnull( d.ESCFIJO, t.ESCFIJO ),
t.MONTOBASE = isnull( d.MONTOBASE, t.MONTOBASE ),
t.PORCBASE = isnull( d.PORCBASE, t.PORCBASE ),
t.ACUMPAGOS = isnull( d.ACUMPAGOS, t.ACUMPAGOS ),
t.ACUMRETENC = isnull( d.ACUMRETENC, t.ACUMRETENC ),
t.MINNOIMP = isnull( d.MINNOIMP, t.MINNOIMP ),
t.PORCONVMUL = isnull( d.PORCONVMUL, t.PORCONVMUL ),
t.SIRECERT = isnull( d.SIRECERT, t.SIRECERT ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.ESRG1575AR = isnull( d.ESRG1575AR, t.ESRG1575AR ),
t.ACUMCOMPR = isnull( d.ACUMCOMPR, t.ACUMCOMPR ),
t.ESRG2616AR = isnull( d.ESRG2616AR, t.ESRG2616AR ),
t.MONTOORIGE = isnull( d.MONTOORIGE, t.MONTOORIGE ),
t.ESCALA = isnull( d.ESCALA, t.ESCALA ),
t.SIRECS = isnull( d.SIRECS, t.SIRECS ),
t.REGIMENIMP = isnull( d.REGIMENIMP, t.REGIMENIMP ),
t.BASECALC = isnull( d.BASECALC, t.BASECALC ),
t.REGIMDESCR = isnull( d.REGIMDESCR, t.REGIMDESCR ),
t.CONVMULTI = isnull( d.CONVMULTI, t.CONVMULTI ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.JURISDICCI = isnull( d.JURISDICCI, t.JURISDICCI ),
t.JURISDETA = isnull( d.JURISDETA, t.JURISDETA ),
t.RESOLDETA = isnull( d.RESOLDETA, t.RESOLDETA ),
t.MINNOIMPO = isnull( d.MINNOIMPO, t.MINNOIMPO ),
t.PORCENTAJE = isnull( d.PORCENTAJE, t.PORCENTAJE ),
t.MONTO = isnull( d.MONTO, t.MONTO )
from ZooLogic.CRImpDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CRImpDet
( 
"MINIMO",
"ESCPORC",
"ESCEXCED",
"ESCFIJO",
"MONTOBASE",
"PORCBASE",
"ACUMPAGOS",
"ACUMRETENC",
"MINNOIMP",
"PORCONVMUL",
"SIRECERT",
"NROITEM",
"ESRG1575AR",
"ACUMCOMPR",
"ESRG2616AR",
"MONTOORIGE",
"ESCALA",
"SIRECS",
"REGIMENIMP",
"BASECALC",
"REGIMDESCR",
"CONVMULTI",
"CODIGO",
"CODIMP",
"DESCRI",
"JURISDICCI",
"JURISDETA",
"RESOLDETA",
"MINNOIMPO",
"PORCENTAJE",
"MONTO"
 )
Select 
d.MINIMO,
d.ESCPORC,
d.ESCEXCED,
d.ESCFIJO,
d.MONTOBASE,
d.PORCBASE,
d.ACUMPAGOS,
d.ACUMRETENC,
d.MINNOIMP,
d.PORCONVMUL,
d.SIRECERT,
d.NROITEM,
d.ESRG1575AR,
d.ACUMCOMPR,
d.ESRG2616AR,
d.MONTOORIGE,
d.ESCALA,
d.SIRECS,
d.REGIMENIMP,
d.BASECALC,
d.REGIMDESCR,
d.CONVMULTI,
d.CODIGO,
d.CODIMP,
d.DESCRI,
d.JURISDICCI,
d.JURISDETA,
d.RESOLDETA,
d.MINNOIMPO,
d.PORCENTAJE,
d.MONTO
From deleted d left join ZooLogic.CRImpDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_CompRet') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_CompRet
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_COMPROBANTEDERETENCIONES' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONES.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONES.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONES.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONES.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONES.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Proveedor_PK =  nvl( c_COMPROBANTEDERETENCIONES.Proveedor, [] )
					.Timestamp = nvl( c_COMPROBANTEDERETENCIONES.Timestamp, 0 )
					.Anulado = nvl( c_COMPROBANTEDERETENCIONES.Anulado, .F. )
					.Horaaltafw = nvl( c_COMPROBANTEDERETENCIONES.Horaaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaexpo = nvl( c_COMPROBANTEDERETENCIONES.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_COMPROBANTEDERETENCIONES.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_COMPROBANTEDERETENCIONES.Horaimpo, [] )
					.Versionaltafw = nvl( c_COMPROBANTEDERETENCIONES.Versionaltafw, [] )
					.Estadotransferencia = nvl( c_COMPROBANTEDERETENCIONES.Estadotransferencia, [] )
					.Seriealtafw = nvl( c_COMPROBANTEDERETENCIONES.Seriealtafw, [] )
					.Usuariomodificacionfw = nvl( c_COMPROBANTEDERETENCIONES.Usuariomodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_COMPROBANTEDERETENCIONES.Basededatosmodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_COMPROBANTEDERETENCIONES.Versionmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_COMPROBANTEDERETENCIONES.Basededatosaltafw, [] )
					.Seriemodificacionfw = nvl( c_COMPROBANTEDERETENCIONES.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_COMPROBANTEDERETENCIONES.Usuarioaltafw, [] )
					.Puntodeventa = nvl( c_COMPROBANTEDERETENCIONES.Puntodeventa, 0 )
					.Comprobantesdetalle.Limpiar()
					.Comprobantesdetalle.SetearEsNavegacion( .lProcesando )
					.Comprobantesdetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Codigo = nvl( c_COMPROBANTEDERETENCIONES.Codigo, [] )
					.Monedasistema_PK =  nvl( c_COMPROBANTEDERETENCIONES.Monedasistema, [] )
					.Tipoimpuesto_PK =  nvl( c_COMPROBANTEDERETENCIONES.Tipoimpuesto, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Proveedordescripcion = nvl( c_COMPROBANTEDERETENCIONES.Proveedordescripcion, [] )
					.Total = nvl( c_COMPROBANTEDERETENCIONES.Total, 0 )
					.Numero = nvl( c_COMPROBANTEDERETENCIONES.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_COMPROBANTEDERETENCIONES.Fecha, ctod( '  /  /    ' ) ) )
					.Monedacomprobante_PK =  nvl( c_COMPROBANTEDERETENCIONES.Monedacomprobante, [] )
					.Letraordendepago = nvl( c_COMPROBANTEDERETENCIONES.Letraordendepago, [] )
					.Impuestosmanuales = nvl( c_COMPROBANTEDERETENCIONES.Impuestosmanuales, .F. )
					.Puntodeventaordendepago = nvl( c_COMPROBANTEDERETENCIONES.Puntodeventaordendepago, 0 )
					.Numeroordendepago = nvl( c_COMPROBANTEDERETENCIONES.Numeroordendepago, 0 )
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
			lxRetorno = c_COMPROBANTEDERETENCIONES.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.ComprobantesDetalle
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

		loDetalle = this.oEntidad.ImpuestosDetalle
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
		return c_COMPROBANTEDERETENCIONES.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPRET' )
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
								from ZooLogic.COMPRET 
								Where   COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPRET", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Prov" as "Proveedor", "Timestamp" as "Timestamp", "Anulado" as "Anulado", "Haltafw" as "Horaaltafw", "Zadsfw" as "Zadsfw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Valtafw" as "Versionaltafw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Umodifw" as "Usuariomodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Ptoventa" as "Puntodeventa", "Codigo" as "Codigo", "Monsis" as "Monedasistema", "Tipoimp" as "Tipoimpuesto", "Obs" as "Obs", "Desprov" as "Proveedordescripcion", "Crtotal" as "Total", "Numero" as "Numero", "Fecha" as "Fecha", "Moneda" as "Monedacomprobante", "Letraop" as "Letraordendepago", "Impman" as "Impuestosmanuales", "Ptovenop" as "Puntodeventaordendepago", "Numop" as "Numeroordendepago"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPRET 
								Where   COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'
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
	Tabla = 'COMPRET'
	Filtro = " COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPRET.CODIGO != '' AND COMPRET.TIPOIMP= 'IIBB'"
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
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FECHAEXPO                               " tabla="COMPRET        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FECHAALTAFW                             " tabla="COMPRET        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FECHAMODIFICACIONFW                     " tabla="COMPRET        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FECHAIMPO                               " tabla="COMPRET        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FECHATRANSFERENCIA                      " tabla="COMPRET        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="PROVEEDOR                               " tabla="COMPRET        " campo="PROV      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="TIMESTAMP                               " tabla="COMPRET        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="ANULADO                                 " tabla="COMPRET        " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Anulado                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="HORAALTAFW                              " tabla="COMPRET        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="ZADSFW                                  " tabla="COMPRET        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="HORAEXPO                                " tabla="COMPRET        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="HORAMODIFICACIONFW                      " tabla="COMPRET        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="HORAIMPO                                " tabla="COMPRET        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="VERSIONALTAFW                           " tabla="COMPRET        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPRET        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="SERIEALTAFW                             " tabla="COMPRET        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPRET        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPRET        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPRET        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="BASEDEDATOSALTAFW                       " tabla="COMPRET        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="SERIEMODIFICACIONFW                     " tabla="COMPRET        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="USUARIOALTAFW                           " tabla="COMPRET        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="PUNTODEVENTA                            " tabla="COMPRET        " campo="PTOVENTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número                                                                                                                                                          " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="X999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="COMPROBANTESDETALLE                     " tabla="CRCOMPDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCDRCOMPROBANTES    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="IMPUESTOSDETALLE                        " tabla="CRIMPDET       " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCDRIMPUESTOS       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="CODIGO                                  " tabla="COMPRET        " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="MONEDASISTEMA                           " tabla="COMPRET        " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="TIPOIMPUESTO                            " tabla="COMPRET        " campo="TIPOIMP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOIMPUESTO                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="='IIBB'                                                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="0" etiqueta="Tipo de impuesto                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="OBS                                     " tabla="COMPRET        " campo="OBS       " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Obs.                                                                                                                                                            " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="CALCULODETALLADO                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cálculo                                                                                                                                                         " dominio="OBSERVACION18R                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="PROVEEDORDESCRIPCION                    " tabla="COMPRET        " campo="DESPROV   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="                                                                                                                                                                " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Proveedor.Nombre                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="TOTAL                                   " tabla="COMPRET        " campo="CRTOTAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="NUMERO                                  " tabla="COMPRET        " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Número                                                                                                                                                          " dominio="NUMEROINTERNO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X999-9999999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FECHA                                   " tabla="COMPRET        " campo="FECHA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=GOLIBRERIAS.OBTENERFECHA()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="MONEDACOMPROBANTE                       " tabla="COMPRET        " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="LETRAORDENDEPAGO                        " tabla="COMPRET        " campo="LETRAOP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Orden de pago                                                                                                                                                   " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="IMPUESTOSMANUALES                       " tabla="COMPRET        " campo="IMPMAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cálculo manual                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="FORMADECALCULO                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Forma de cálculo                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="PUNTODEVENTAORDENDEPAGO                 " tabla="COMPRET        " campo="PTOVENOP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Orden de pago                                                                                                                                                   " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COMPROBANTEDERETENCIONES                " atributo="NUMEROORDENDEPAGO                       " tabla="COMPRET        " campo="NUMOP     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Orden de pago                                                                                                                                                   " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X 9999-9999999999        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROVEED        " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="3" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROVEED On COMPRET.PROV = PROVEED.CLCOD And  PROVEED.CLCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On COMPRET.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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