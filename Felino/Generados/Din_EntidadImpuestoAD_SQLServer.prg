
define class Din_EntidadIMPUESTOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_IMPUESTO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IMSPK'
	cTablaPrincipal = 'IMPUESTO'
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
			local  lxImpuestoFecimpo, lxImpuestoFaltafw, lxImpuestoFecexpo, lxImpuestoFectrans, lxImpuestoFmodifw, lxImpuestoTimestamp, lxImpuestoBloqreg, lxImpuestoHaltafw, lxImpuestoHoraimpo, lxImpuestoHoraexpo, lxImpuestoSaltafw, lxImpuestoHmodifw, lxImpuestoUmodifw, lxImpuestoValtafw, lxImpuestoZadsfw, lxImpuestoUaltafw, lxImpuestoVmodifw, lxImpuestoSmodifw, lxImpuestoBdmodifw, lxImpuestoEsttrans, lxImpuestoBdaltafw, lxImpuestoCodigo, lxImpuestoObs, lxImpuestoAplicaart, lxImpuestoBasecalc, lxImpuestoCompmreg, lxImpuestoMonoreg, lxImpuestoCompmporc, lxImpuestoMonoporc, lxImpuestoPorcbase, lxImpuestoDescrip, lxImpuestoMonomeses, lxImpuestoPagocta, lxImpuestoAplicacion, lxImpuestoCompmbase, lxImpuestoCompmmin, lxImpuestoPorcen5329, lxImpuestoMaxserv, lxImpuestoTipo, lxImpuestoMaxbienes, lxImpuestoJurisdicci, lxImpuestoResolu, lxImpuestoRegimenimp, lxImpuestoEscala, lxImpuestoMinimo, lxImpuestoMenalicni, lxImpuestoMonto, lxImpuestoPorcentaje, lxImpuestoConvenio, lxImpuestoConvlocal, lxImpuestoConvmulti, lxImpuestoConvnoinsc, lxImpuestoConmulext, lxImpuestoTuccfcero, lxImpuestoTucredalic, lxImpuestoTucalicni, lxImpuestoRegimen
				lxImpuestoFecimpo =  .Fechaimpo			lxImpuestoFaltafw =  .Fechaaltafw			lxImpuestoFecexpo =  .Fechaexpo			lxImpuestoFectrans =  .Fechatransferencia			lxImpuestoFmodifw =  .Fechamodificacionfw			lxImpuestoTimestamp = goLibrerias.ObtenerTimestamp()			lxImpuestoBloqreg =  .Bloquearregistro			lxImpuestoHaltafw =  .Horaaltafw			lxImpuestoHoraimpo =  .Horaimpo			lxImpuestoHoraexpo =  .Horaexpo			lxImpuestoSaltafw =  .Seriealtafw			lxImpuestoHmodifw =  .Horamodificacionfw			lxImpuestoUmodifw =  .Usuariomodificacionfw			lxImpuestoValtafw =  .Versionaltafw			lxImpuestoZadsfw =  .Zadsfw			lxImpuestoUaltafw =  .Usuarioaltafw			lxImpuestoVmodifw =  .Versionmodificacionfw			lxImpuestoSmodifw =  .Seriemodificacionfw			lxImpuestoBdmodifw =  .Basededatosmodificacionfw			lxImpuestoEsttrans =  .Estadotransferencia			lxImpuestoBdaltafw =  .Basededatosaltafw			lxImpuestoCodigo =  .Codigo			lxImpuestoObs =  .Observacion			lxImpuestoAplicaart =  .Rg5329aplicaporarticulo			lxImpuestoBasecalc =  .Basedecalculo			lxImpuestoCompmreg =  upper( .RG1575Regimen_PK ) 			lxImpuestoMonoreg =  upper( .RG2616Regimen_PK ) 			lxImpuestoCompmporc =  .Rg1575porcentaje			lxImpuestoMonoporc =  .Rg2616porcentaje			lxImpuestoPorcbase =  .Porcentajebase			lxImpuestoDescrip =  .Descripcion			lxImpuestoMonomeses =  .Rg2616meses			lxImpuestoPagocta =  .Pagoparcial			lxImpuestoAplicacion =  .Aplicacion			lxImpuestoCompmbase =  .Rg1575basedecalculo			lxImpuestoCompmmin =  .Rg1575montominimoretencion			lxImpuestoPorcen5329 =  .Rg5329porcentaje			lxImpuestoMaxserv =  .Rg2616montomaximoservicios			lxImpuestoTipo =  upper( .Tipo_PK ) 			lxImpuestoMaxbienes =  .Rg2616montomaximobienes			lxImpuestoJurisdicci =  upper( .Jurisdiccion_PK ) 			lxImpuestoResolu =  .Resolucion			lxImpuestoRegimenimp =  upper( .RegimenImpositivo_PK ) 			lxImpuestoEscala =  .Escala			lxImpuestoMinimo =  .Minimo			lxImpuestoMenalicni =  .Iibbmenalicuotanoinscriptos			lxImpuestoMonto =  .Monto			lxImpuestoPorcentaje =  .Porcentaje			lxImpuestoConvenio =  .Segunconvenio			lxImpuestoConvlocal =  .Conveniolocal			lxImpuestoConvmulti =  .Conveniomultilateral			lxImpuestoConvnoinsc =  .Convenionoinscripto			lxImpuestoConmulext =  .Conveniomultilextranajuris			lxImpuestoTuccfcero =  .Iibbtuccoeficientecero			lxImpuestoTucredalic =  .Iibbtucreduccionalicuota			lxImpuestoTucalicni =  .Iibbtucalicuotanoinscriptos			lxImpuestoRegimen =  .Regimen
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxImpuestoCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.IMPUESTO ( "Fecimpo","Faltafw","Fecexpo","Fectrans","Fmodifw","Timestamp","Bloqreg","Haltafw","Horaimpo","Horaexpo","Saltafw","Hmodifw","Umodifw","Valtafw","Zadsfw","Ualtafw","Vmodifw","Smodifw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Obs","Aplicaart","Basecalc","Compmreg","Monoreg","Compmporc","Monoporc","Porcbase","Descrip","Monomeses","Pagocta","Aplicacion","Compmbase","Compmmin","Porcen5329","Maxserv","Tipo","Maxbienes","Jurisdicci","Resolu","Regimenimp","Escala","Minimo","Menalicni","Monto","Porcentaje","Convenio","Convlocal","Convmulti","Convnoinsc","Conmulext","Tuccfcero","Tucredalic","Tucalicni","Regimen" ) values ( <<"'" + this.ConvertirDateSql( lxImpuestoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFmodifw ) + "'" >>, <<lxImpuestoTimestamp >>, <<iif( lxImpuestoBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpuestoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoObs ) + "'" >>, <<iif( lxImpuestoAplicaart, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpuestoBasecalc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoCompmreg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoMonoreg ) + "'" >>, <<lxImpuestoCompmporc >>, <<lxImpuestoMonoporc >>, <<lxImpuestoPorcbase >>, <<"'" + this.FormatearTextoSql( lxImpuestoDescrip ) + "'" >>, <<lxImpuestoMonomeses >>, <<lxImpuestoPagocta >>, <<"'" + this.FormatearTextoSql( lxImpuestoAplicacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoCompmbase ) + "'" >>, <<lxImpuestoCompmmin >>, <<lxImpuestoPorcen5329 >>, <<lxImpuestoMaxserv >>, <<"'" + this.FormatearTextoSql( lxImpuestoTipo ) + "'" >>, <<lxImpuestoMaxbienes >>, <<"'" + this.FormatearTextoSql( lxImpuestoJurisdicci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoResolu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoRegimenimp ) + "'" >>, <<iif( lxImpuestoEscala, 1, 0 ) >>, <<lxImpuestoMinimo >>, <<lxImpuestoMenalicni >>, <<lxImpuestoMonto >>, <<lxImpuestoPorcentaje >>, <<iif( lxImpuestoConvenio, 1, 0 ) >>, <<lxImpuestoConvlocal >>, <<lxImpuestoConvmulti >>, <<lxImpuestoConvnoinsc >>, <<lxImpuestoConmulext >>, <<lxImpuestoTuccfcero >>, <<lxImpuestoTucredalic >>, <<lxImpuestoTucalicni >>, <<"'" + this.FormatearTextoSql( lxImpuestoRegimen ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EscalaDetalle
				if this.oEntidad.EscalaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxPorcentaje = loItem.Porcentaje
					lxSobreexcedente = loItem.Sobreexcedente
					lxMontofijo = loItem.Montofijo
					lxMayora = loItem.Mayora
					lxHasta = loItem.Hasta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.EscalaImp("NROITEM","BLOQREG","codigo","porcentaje","excedente","montofijo","mayora","hasta" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxPorcentaje>>, <<lxSobreexcedente>>, <<lxMontofijo>>, <<lxMayora>>, <<lxHasta>> ) 
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
		this.oEntidad.Timestamp = lxImpuestoTimestamp
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
			local  lxImpuestoFecimpo, lxImpuestoFaltafw, lxImpuestoFecexpo, lxImpuestoFectrans, lxImpuestoFmodifw, lxImpuestoTimestamp, lxImpuestoBloqreg, lxImpuestoHaltafw, lxImpuestoHoraimpo, lxImpuestoHoraexpo, lxImpuestoSaltafw, lxImpuestoHmodifw, lxImpuestoUmodifw, lxImpuestoValtafw, lxImpuestoZadsfw, lxImpuestoUaltafw, lxImpuestoVmodifw, lxImpuestoSmodifw, lxImpuestoBdmodifw, lxImpuestoEsttrans, lxImpuestoBdaltafw, lxImpuestoCodigo, lxImpuestoObs, lxImpuestoAplicaart, lxImpuestoBasecalc, lxImpuestoCompmreg, lxImpuestoMonoreg, lxImpuestoCompmporc, lxImpuestoMonoporc, lxImpuestoPorcbase, lxImpuestoDescrip, lxImpuestoMonomeses, lxImpuestoPagocta, lxImpuestoAplicacion, lxImpuestoCompmbase, lxImpuestoCompmmin, lxImpuestoPorcen5329, lxImpuestoMaxserv, lxImpuestoTipo, lxImpuestoMaxbienes, lxImpuestoJurisdicci, lxImpuestoResolu, lxImpuestoRegimenimp, lxImpuestoEscala, lxImpuestoMinimo, lxImpuestoMenalicni, lxImpuestoMonto, lxImpuestoPorcentaje, lxImpuestoConvenio, lxImpuestoConvlocal, lxImpuestoConvmulti, lxImpuestoConvnoinsc, lxImpuestoConmulext, lxImpuestoTuccfcero, lxImpuestoTucredalic, lxImpuestoTucalicni, lxImpuestoRegimen
				lxImpuestoFecimpo =  .Fechaimpo			lxImpuestoFaltafw =  .Fechaaltafw			lxImpuestoFecexpo =  .Fechaexpo			lxImpuestoFectrans =  .Fechatransferencia			lxImpuestoFmodifw =  .Fechamodificacionfw			lxImpuestoTimestamp = goLibrerias.ObtenerTimestamp()			lxImpuestoBloqreg =  .Bloquearregistro			lxImpuestoHaltafw =  .Horaaltafw			lxImpuestoHoraimpo =  .Horaimpo			lxImpuestoHoraexpo =  .Horaexpo			lxImpuestoSaltafw =  .Seriealtafw			lxImpuestoHmodifw =  .Horamodificacionfw			lxImpuestoUmodifw =  .Usuariomodificacionfw			lxImpuestoValtafw =  .Versionaltafw			lxImpuestoZadsfw =  .Zadsfw			lxImpuestoUaltafw =  .Usuarioaltafw			lxImpuestoVmodifw =  .Versionmodificacionfw			lxImpuestoSmodifw =  .Seriemodificacionfw			lxImpuestoBdmodifw =  .Basededatosmodificacionfw			lxImpuestoEsttrans =  .Estadotransferencia			lxImpuestoBdaltafw =  .Basededatosaltafw			lxImpuestoCodigo =  .Codigo			lxImpuestoObs =  .Observacion			lxImpuestoAplicaart =  .Rg5329aplicaporarticulo			lxImpuestoBasecalc =  .Basedecalculo			lxImpuestoCompmreg =  upper( .RG1575Regimen_PK ) 			lxImpuestoMonoreg =  upper( .RG2616Regimen_PK ) 			lxImpuestoCompmporc =  .Rg1575porcentaje			lxImpuestoMonoporc =  .Rg2616porcentaje			lxImpuestoPorcbase =  .Porcentajebase			lxImpuestoDescrip =  .Descripcion			lxImpuestoMonomeses =  .Rg2616meses			lxImpuestoPagocta =  .Pagoparcial			lxImpuestoAplicacion =  .Aplicacion			lxImpuestoCompmbase =  .Rg1575basedecalculo			lxImpuestoCompmmin =  .Rg1575montominimoretencion			lxImpuestoPorcen5329 =  .Rg5329porcentaje			lxImpuestoMaxserv =  .Rg2616montomaximoservicios			lxImpuestoTipo =  upper( .Tipo_PK ) 			lxImpuestoMaxbienes =  .Rg2616montomaximobienes			lxImpuestoJurisdicci =  upper( .Jurisdiccion_PK ) 			lxImpuestoResolu =  .Resolucion			lxImpuestoRegimenimp =  upper( .RegimenImpositivo_PK ) 			lxImpuestoEscala =  .Escala			lxImpuestoMinimo =  .Minimo			lxImpuestoMenalicni =  .Iibbmenalicuotanoinscriptos			lxImpuestoMonto =  .Monto			lxImpuestoPorcentaje =  .Porcentaje			lxImpuestoConvenio =  .Segunconvenio			lxImpuestoConvlocal =  .Conveniolocal			lxImpuestoConvmulti =  .Conveniomultilateral			lxImpuestoConvnoinsc =  .Convenionoinscripto			lxImpuestoConmulext =  .Conveniomultilextranajuris			lxImpuestoTuccfcero =  .Iibbtuccoeficientecero			lxImpuestoTucredalic =  .Iibbtucreduccionalicuota			lxImpuestoTucalicni =  .Iibbtucalicuotanoinscriptos			lxImpuestoRegimen =  .Regimen
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
				update ZooLogic.IMPUESTO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpuestoFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxImpuestoFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpuestoFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxImpuestoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpuestoFmodifw ) + "'">>,"Timestamp" = <<lxImpuestoTimestamp>>,"Bloqreg" = <<iif( lxImpuestoBloqreg, 1, 0 )>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxImpuestoHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpuestoHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpuestoHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxImpuestoSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoHmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxImpuestoValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpuestoZadsfw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpuestoUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoVmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoSmodifw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxImpuestoEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpuestoBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxImpuestoObs ) + "'">>,"Aplicaart" = <<iif( lxImpuestoAplicaart, 1, 0 )>>,"Basecalc" = <<"'" + this.FormatearTextoSql( lxImpuestoBasecalc ) + "'">>,"Compmreg" = <<"'" + this.FormatearTextoSql( lxImpuestoCompmreg ) + "'">>,"Monoreg" = <<"'" + this.FormatearTextoSql( lxImpuestoMonoreg ) + "'">>,"Compmporc" = <<lxImpuestoCompmporc>>,"Monoporc" = <<lxImpuestoMonoporc>>,"Porcbase" = <<lxImpuestoPorcbase>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxImpuestoDescrip ) + "'">>,"Monomeses" = <<lxImpuestoMonomeses>>,"Pagocta" = <<lxImpuestoPagocta>>,"Aplicacion" = <<"'" + this.FormatearTextoSql( lxImpuestoAplicacion ) + "'">>,"Compmbase" = <<"'" + this.FormatearTextoSql( lxImpuestoCompmbase ) + "'">>,"Compmmin" = <<lxImpuestoCompmmin>>,"Porcen5329" = <<lxImpuestoPorcen5329>>,"Maxserv" = <<lxImpuestoMaxserv>>,"Tipo" = <<"'" + this.FormatearTextoSql( lxImpuestoTipo ) + "'">>,"Maxbienes" = <<lxImpuestoMaxbienes>>,"Jurisdicci" = <<"'" + this.FormatearTextoSql( lxImpuestoJurisdicci ) + "'">>,"Resolu" = <<"'" + this.FormatearTextoSql( lxImpuestoResolu ) + "'">>,"Regimenimp" = <<"'" + this.FormatearTextoSql( lxImpuestoRegimenimp ) + "'">>,"Escala" = <<iif( lxImpuestoEscala, 1, 0 )>>,"Minimo" = <<lxImpuestoMinimo>>,"Menalicni" = <<lxImpuestoMenalicni>>,"Monto" = <<lxImpuestoMonto>>,"Porcentaje" = <<lxImpuestoPorcentaje>>,"Convenio" = <<iif( lxImpuestoConvenio, 1, 0 )>>,"Convlocal" = <<lxImpuestoConvlocal>>,"Convmulti" = <<lxImpuestoConvmulti>>,"Convnoinsc" = <<lxImpuestoConvnoinsc>>,"Conmulext" = <<lxImpuestoConmulext>>,"Tuccfcero" = <<lxImpuestoTuccfcero>>,"Tucredalic" = <<lxImpuestoTucredalic>>,"Tucalicni" = <<lxImpuestoTucalicni>>,"Regimen" = <<"'" + this.FormatearTextoSql( lxImpuestoRegimen ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'">> and  IMPUESTO.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.EscalaImp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EscalaDetalle
				if this.oEntidad.EscalaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxPorcentaje = loItem.Porcentaje
					lxSobreexcedente = loItem.Sobreexcedente
					lxMontofijo = loItem.Montofijo
					lxMayora = loItem.Mayora
					lxHasta = loItem.Hasta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.EscalaImp("NROITEM","BLOQREG","codigo","porcentaje","excedente","montofijo","mayora","hasta" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxPorcentaje>>, <<lxSobreexcedente>>, <<lxMontofijo>>, <<lxMayora>>, <<lxHasta>> ) 
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
		this.oEntidad.Timestamp = lxImpuestoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 codigo from ZooLogic.IMPUESTO where " + this.ConvertirFuncionesSql( " IMPUESTO.CODIGO != ''" ) )
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
			Local lxImpuestoCodigo
			lxImpuestoCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen" from ZooLogic.IMPUESTO where "Codigo" = <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'">> and  IMPUESTO.CODIGO != ''
			endtext
			use in select('c_IMPUESTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPUESTO', set( 'Datasession' ) )

			if reccount( 'c_IMPUESTO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Porcentaje" as "Porcentaje", "Excedente" as "Sobreexcedente", "Montofijo" as "Montofijo", "Mayora" as "Mayora", "Hasta" as "Hasta" from ZooLogic.EscalaImp where Codigo = <<"'" + this.FormatearTextoSql( c_IMPUESTO.CODIGO ) + "'">> Order by mayora
			endtext
			use in select('c_EscalaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EscalaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EscalaDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxImpuestoCodigo as Variant
		llRetorno = .t.
		lxImpuestoCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.IMPUESTO where "Codigo" = <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'">> and  IMPUESTO.CODIGO != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen" from ZooLogic.IMPUESTO where  IMPUESTO.CODIGO != '' order by codigo
			endtext
			use in select('c_IMPUESTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPUESTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Porcentaje" as "Porcentaje", "Excedente" as "Sobreexcedente", "Montofijo" as "Montofijo", "Mayora" as "Mayora", "Hasta" as "Hasta" from ZooLogic.EscalaImp where Codigo = <<"'" + this.FormatearTextoSql( c_IMPUESTO.CODIGO ) + "'">> Order by mayora
			endtext
			use in select('c_EscalaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EscalaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EscalaDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen" from ZooLogic.IMPUESTO where  funciones.padr( codigo, 10, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPUESTO.CODIGO != '' order by codigo
			endtext
			use in select('c_IMPUESTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPUESTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Porcentaje" as "Porcentaje", "Excedente" as "Sobreexcedente", "Montofijo" as "Montofijo", "Mayora" as "Mayora", "Hasta" as "Hasta" from ZooLogic.EscalaImp where Codigo = <<"'" + this.FormatearTextoSql( c_IMPUESTO.CODIGO ) + "'">> Order by mayora
			endtext
			use in select('c_EscalaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EscalaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EscalaDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen" from ZooLogic.IMPUESTO where  funciones.padr( codigo, 10, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  IMPUESTO.CODIGO != '' order by codigo desc
			endtext
			use in select('c_IMPUESTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPUESTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Porcentaje" as "Porcentaje", "Excedente" as "Sobreexcedente", "Montofijo" as "Montofijo", "Mayora" as "Mayora", "Hasta" as "Hasta" from ZooLogic.EscalaImp where Codigo = <<"'" + this.FormatearTextoSql( c_IMPUESTO.CODIGO ) + "'">> Order by mayora
			endtext
			use in select('c_EscalaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EscalaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EscalaDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen" from ZooLogic.IMPUESTO where  IMPUESTO.CODIGO != '' order by codigo desc
			endtext
			use in select('c_IMPUESTO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_IMPUESTO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Porcentaje" as "Porcentaje", "Excedente" as "Sobreexcedente", "Montofijo" as "Montofijo", "Mayora" as "Mayora", "Hasta" as "Hasta" from ZooLogic.EscalaImp where Codigo = <<"'" + this.FormatearTextoSql( c_IMPUESTO.CODIGO ) + "'">> Order by mayora
			endtext
			use in select('c_EscalaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_EscalaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_EscalaDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Faltafw,Fecexpo,Fectrans,Fmodifw,Timestamp,Bloqreg,Haltafw,Horaimpo,Horaexpo,Saltafw" + ;
",Hmodifw,Umodifw,Valtafw,Zadsfw,Ualtafw,Vmodifw,Smodifw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Obs,Aplica" + ;
"art,Basecalc,Compmreg,Monoreg,Compmporc,Monoporc,Porcbase,Descrip,Monomeses,Pagocta,Aplicacion,Compm" + ;
"base,Compmmin,Porcen5329,Maxserv,Tipo,Maxbienes,Jurisdicci,Resolu,Regimenimp,Escala,Minimo,Menalicni" + ;
",Monto,Porcentaje,Convenio,Convlocal,Convmulti,Convnoinsc,Conmulext,Tuccfcero,Tucredalic,Tucalicni,R" + ;
"egimen" + ;
" from ZooLogic.IMPUESTO where  IMPUESTO.CODIGO != '' and " + lcFiltro )
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
			local  lxImpuestoFecimpo, lxImpuestoFaltafw, lxImpuestoFecexpo, lxImpuestoFectrans, lxImpuestoFmodifw, lxImpuestoTimestamp, lxImpuestoBloqreg, lxImpuestoHaltafw, lxImpuestoHoraimpo, lxImpuestoHoraexpo, lxImpuestoSaltafw, lxImpuestoHmodifw, lxImpuestoUmodifw, lxImpuestoValtafw, lxImpuestoZadsfw, lxImpuestoUaltafw, lxImpuestoVmodifw, lxImpuestoSmodifw, lxImpuestoBdmodifw, lxImpuestoEsttrans, lxImpuestoBdaltafw, lxImpuestoCodigo, lxImpuestoObs, lxImpuestoAplicaart, lxImpuestoBasecalc, lxImpuestoCompmreg, lxImpuestoMonoreg, lxImpuestoCompmporc, lxImpuestoMonoporc, lxImpuestoPorcbase, lxImpuestoDescrip, lxImpuestoMonomeses, lxImpuestoPagocta, lxImpuestoAplicacion, lxImpuestoCompmbase, lxImpuestoCompmmin, lxImpuestoPorcen5329, lxImpuestoMaxserv, lxImpuestoTipo, lxImpuestoMaxbienes, lxImpuestoJurisdicci, lxImpuestoResolu, lxImpuestoRegimenimp, lxImpuestoEscala, lxImpuestoMinimo, lxImpuestoMenalicni, lxImpuestoMonto, lxImpuestoPorcentaje, lxImpuestoConvenio, lxImpuestoConvlocal, lxImpuestoConvmulti, lxImpuestoConvnoinsc, lxImpuestoConmulext, lxImpuestoTuccfcero, lxImpuestoTucredalic, lxImpuestoTucalicni, lxImpuestoRegimen
				lxImpuestoFecimpo = ctod( '  /  /    ' )			lxImpuestoFaltafw = ctod( '  /  /    ' )			lxImpuestoFecexpo = ctod( '  /  /    ' )			lxImpuestoFectrans = ctod( '  /  /    ' )			lxImpuestoFmodifw = ctod( '  /  /    ' )			lxImpuestoTimestamp = goLibrerias.ObtenerTimestamp()			lxImpuestoBloqreg = .F.			lxImpuestoHaltafw = []			lxImpuestoHoraimpo = []			lxImpuestoHoraexpo = []			lxImpuestoSaltafw = []			lxImpuestoHmodifw = []			lxImpuestoUmodifw = []			lxImpuestoValtafw = []			lxImpuestoZadsfw = []			lxImpuestoUaltafw = []			lxImpuestoVmodifw = []			lxImpuestoSmodifw = []			lxImpuestoBdmodifw = []			lxImpuestoEsttrans = []			lxImpuestoBdaltafw = []			lxImpuestoCodigo = []			lxImpuestoObs = []			lxImpuestoAplicaart = .F.			lxImpuestoBasecalc = []			lxImpuestoCompmreg = []			lxImpuestoMonoreg = []			lxImpuestoCompmporc = 0			lxImpuestoMonoporc = 0			lxImpuestoPorcbase = 0			lxImpuestoDescrip = []			lxImpuestoMonomeses = 0			lxImpuestoPagocta = 0			lxImpuestoAplicacion = []			lxImpuestoCompmbase = []			lxImpuestoCompmmin = 0			lxImpuestoPorcen5329 = 0			lxImpuestoMaxserv = 0			lxImpuestoTipo = []			lxImpuestoMaxbienes = 0			lxImpuestoJurisdicci = []			lxImpuestoResolu = []			lxImpuestoRegimenimp = []			lxImpuestoEscala = .F.			lxImpuestoMinimo = 0			lxImpuestoMenalicni = 0			lxImpuestoMonto = 0			lxImpuestoPorcentaje = 0			lxImpuestoConvenio = .F.			lxImpuestoConvlocal = 0			lxImpuestoConvmulti = 0			lxImpuestoConvnoinsc = 0			lxImpuestoConmulext = 0			lxImpuestoTuccfcero = 0			lxImpuestoTucredalic = 0			lxImpuestoTucalicni = 0			lxImpuestoRegimen = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.EscalaImp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.IMPUESTO where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'IMPUESTO' + '_' + tcCampo
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
		lcWhere = " Where  IMPUESTO.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPUESTO', '', tnTope )
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
	Function ObtenerDatosDetalleEscalaDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ESCALAIMP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Porcentaje" as "Porcentaje", "Excedente" as "Sobreexcedente", "Montofijo" as "Montofijo", "Mayora" as "Mayora", "Hasta" as "Hasta"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleEscalaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'EscalaImp', 'EscalaDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleEscalaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleEscalaDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'RG5329APLICAPORARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICAART AS RG5329APLICAPORARTICULO'
				Case lcAtributo == 'BASEDECALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASECALC AS BASEDECALCULO'
				Case lcAtributo == 'RG1575REGIMEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPMREG AS RG1575REGIMEN'
				Case lcAtributo == 'RG2616REGIMEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONOREG AS RG2616REGIMEN'
				Case lcAtributo == 'RG1575PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPMPORC AS RG1575PORCENTAJE'
				Case lcAtributo == 'RG2616PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONOPORC AS RG2616PORCENTAJE'
				Case lcAtributo == 'PORCENTAJEBASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCBASE AS PORCENTAJEBASE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'RG2616MESES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONOMESES AS RG2616MESES'
				Case lcAtributo == 'PAGOPARCIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGOCTA AS PAGOPARCIAL'
				Case lcAtributo == 'APLICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APLICACION AS APLICACION'
				Case lcAtributo == 'RG1575BASEDECALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPMBASE AS RG1575BASEDECALCULO'
				Case lcAtributo == 'RG1575MONTOMINIMORETENCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMPMMIN AS RG1575MONTOMINIMORETENCION'
				Case lcAtributo == 'RG5329PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN5329 AS RG5329PORCENTAJE'
				Case lcAtributo == 'RG2616MONTOMAXIMOSERVICIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAXSERV AS RG2616MONTOMAXIMOSERVICIOS'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'RG2616MONTOMAXIMOBIENES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAXBIENES AS RG2616MONTOMAXIMOBIENES'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURISDICCI AS JURISDICCION'
				Case lcAtributo == 'RESOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESOLU AS RESOLUCION'
				Case lcAtributo == 'REGIMENIMPOSITIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMENIMP AS REGIMENIMPOSITIVO'
				Case lcAtributo == 'ESCALA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESCALA AS ESCALA'
				Case lcAtributo == 'MINIMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINIMO AS MINIMO'
				Case lcAtributo == 'IIBBMENALICUOTANOINSCRIPTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MENALICNI AS IIBBMENALICUOTANOINSCRIPTOS'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTAJE AS PORCENTAJE'
				Case lcAtributo == 'SEGUNCONVENIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVENIO AS SEGUNCONVENIO'
				Case lcAtributo == 'CONVENIOLOCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVLOCAL AS CONVENIOLOCAL'
				Case lcAtributo == 'CONVENIOMULTILATERAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVMULTI AS CONVENIOMULTILATERAL'
				Case lcAtributo == 'CONVENIONOINSCRIPTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONVNOINSC AS CONVENIONOINSCRIPTO'
				Case lcAtributo == 'CONVENIOMULTILEXTRANAJURIS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONMULEXT AS CONVENIOMULTILEXTRANAJURIS'
				Case lcAtributo == 'IIBBTUCCOEFICIENTECERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TUCCFCERO AS IIBBTUCCOEFICIENTECERO'
				Case lcAtributo == 'IIBBTUCREDUCCIONALICUOTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TUCREDALIC AS IIBBTUCREDUCCIONALICUOTA'
				Case lcAtributo == 'IIBBTUCALICUOTANOINSCRIPTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TUCALICNI AS IIBBTUCALICUOTANOINSCRIPTOS'
				Case lcAtributo == 'REGIMEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMEN AS REGIMEN'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleEscalaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCENTAJE AS PORCENTAJE'
				Case lcAtributo == 'SOBREEXCEDENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXCEDENTE AS SOBREEXCEDENTE'
				Case lcAtributo == 'MONTOFIJO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOFIJO AS MONTOFIJO'
				Case lcAtributo == 'MAYORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MAYORA AS MAYORA'
				Case lcAtributo == 'HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTA AS HASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'RG5329APLICAPORARTICULO'
				lcCampo = 'APLICAART'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDECALCULO'
				lcCampo = 'BASECALC'
			Case upper( alltrim( tcAtributo ) ) == 'RG1575REGIMEN'
				lcCampo = 'COMPMREG'
			Case upper( alltrim( tcAtributo ) ) == 'RG2616REGIMEN'
				lcCampo = 'MONOREG'
			Case upper( alltrim( tcAtributo ) ) == 'RG1575PORCENTAJE'
				lcCampo = 'COMPMPORC'
			Case upper( alltrim( tcAtributo ) ) == 'RG2616PORCENTAJE'
				lcCampo = 'MONOPORC'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEBASE'
				lcCampo = 'PORCBASE'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'RG2616MESES'
				lcCampo = 'MONOMESES'
			Case upper( alltrim( tcAtributo ) ) == 'PAGOPARCIAL'
				lcCampo = 'PAGOCTA'
			Case upper( alltrim( tcAtributo ) ) == 'APLICACION'
				lcCampo = 'APLICACION'
			Case upper( alltrim( tcAtributo ) ) == 'RG1575BASEDECALCULO'
				lcCampo = 'COMPMBASE'
			Case upper( alltrim( tcAtributo ) ) == 'RG1575MONTOMINIMORETENCION'
				lcCampo = 'COMPMMIN'
			Case upper( alltrim( tcAtributo ) ) == 'RG5329PORCENTAJE'
				lcCampo = 'PORCEN5329'
			Case upper( alltrim( tcAtributo ) ) == 'RG2616MONTOMAXIMOSERVICIOS'
				lcCampo = 'MAXSERV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'RG2616MONTOMAXIMOBIENES'
				lcCampo = 'MAXBIENES'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURISDICCI'
			Case upper( alltrim( tcAtributo ) ) == 'RESOLUCION'
				lcCampo = 'RESOLU'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMENIMPOSITIVO'
				lcCampo = 'REGIMENIMP'
			Case upper( alltrim( tcAtributo ) ) == 'ESCALA'
				lcCampo = 'ESCALA'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMO'
				lcCampo = 'MINIMO'
			Case upper( alltrim( tcAtributo ) ) == 'IIBBMENALICUOTANOINSCRIPTOS'
				lcCampo = 'MENALICNI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCENTAJE'
			Case upper( alltrim( tcAtributo ) ) == 'SEGUNCONVENIO'
				lcCampo = 'CONVENIO'
			Case upper( alltrim( tcAtributo ) ) == 'CONVENIOLOCAL'
				lcCampo = 'CONVLOCAL'
			Case upper( alltrim( tcAtributo ) ) == 'CONVENIOMULTILATERAL'
				lcCampo = 'CONVMULTI'
			Case upper( alltrim( tcAtributo ) ) == 'CONVENIONOINSCRIPTO'
				lcCampo = 'CONVNOINSC'
			Case upper( alltrim( tcAtributo ) ) == 'CONVENIOMULTILEXTRANAJURIS'
				lcCampo = 'CONMULEXT'
			Case upper( alltrim( tcAtributo ) ) == 'IIBBTUCCOEFICIENTECERO'
				lcCampo = 'TUCCFCERO'
			Case upper( alltrim( tcAtributo ) ) == 'IIBBTUCREDUCCIONALICUOTA'
				lcCampo = 'TUCREDALIC'
			Case upper( alltrim( tcAtributo ) ) == 'IIBBTUCALICUOTANOINSCRIPTOS'
				lcCampo = 'TUCALICNI'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMEN'
				lcCampo = 'REGIMEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleEscalaDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCENTAJE'
			Case upper( alltrim( tcAtributo ) ) == 'SOBREEXCEDENTE'
				lcCampo = 'EXCEDENTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOFIJO'
				lcCampo = 'MONTOFIJO'
			Case upper( alltrim( tcAtributo ) ) == 'MAYORA'
				lcCampo = 'MAYORA'
			Case upper( alltrim( tcAtributo ) ) == 'HASTA'
				lcCampo = 'HASTA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ESCALADETALLE'
			lcRetorno = 'ESCALAIMP'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxImpuestoFecimpo, lxImpuestoFaltafw, lxImpuestoFecexpo, lxImpuestoFectrans, lxImpuestoFmodifw, lxImpuestoTimestamp, lxImpuestoBloqreg, lxImpuestoHaltafw, lxImpuestoHoraimpo, lxImpuestoHoraexpo, lxImpuestoSaltafw, lxImpuestoHmodifw, lxImpuestoUmodifw, lxImpuestoValtafw, lxImpuestoZadsfw, lxImpuestoUaltafw, lxImpuestoVmodifw, lxImpuestoSmodifw, lxImpuestoBdmodifw, lxImpuestoEsttrans, lxImpuestoBdaltafw, lxImpuestoCodigo, lxImpuestoObs, lxImpuestoAplicaart, lxImpuestoBasecalc, lxImpuestoCompmreg, lxImpuestoMonoreg, lxImpuestoCompmporc, lxImpuestoMonoporc, lxImpuestoPorcbase, lxImpuestoDescrip, lxImpuestoMonomeses, lxImpuestoPagocta, lxImpuestoAplicacion, lxImpuestoCompmbase, lxImpuestoCompmmin, lxImpuestoPorcen5329, lxImpuestoMaxserv, lxImpuestoTipo, lxImpuestoMaxbienes, lxImpuestoJurisdicci, lxImpuestoResolu, lxImpuestoRegimenimp, lxImpuestoEscala, lxImpuestoMinimo, lxImpuestoMenalicni, lxImpuestoMonto, lxImpuestoPorcentaje, lxImpuestoConvenio, lxImpuestoConvlocal, lxImpuestoConvmulti, lxImpuestoConvnoinsc, lxImpuestoConmulext, lxImpuestoTuccfcero, lxImpuestoTucredalic, lxImpuestoTucalicni, lxImpuestoRegimen
				lxImpuestoFecimpo =  .Fechaimpo			lxImpuestoFaltafw =  .Fechaaltafw			lxImpuestoFecexpo =  .Fechaexpo			lxImpuestoFectrans =  .Fechatransferencia			lxImpuestoFmodifw =  .Fechamodificacionfw			lxImpuestoTimestamp = goLibrerias.ObtenerTimestamp()			lxImpuestoBloqreg =  .Bloquearregistro			lxImpuestoHaltafw =  .Horaaltafw			lxImpuestoHoraimpo =  .Horaimpo			lxImpuestoHoraexpo =  .Horaexpo			lxImpuestoSaltafw =  .Seriealtafw			lxImpuestoHmodifw =  .Horamodificacionfw			lxImpuestoUmodifw =  .Usuariomodificacionfw			lxImpuestoValtafw =  .Versionaltafw			lxImpuestoZadsfw =  .Zadsfw			lxImpuestoUaltafw =  .Usuarioaltafw			lxImpuestoVmodifw =  .Versionmodificacionfw			lxImpuestoSmodifw =  .Seriemodificacionfw			lxImpuestoBdmodifw =  .Basededatosmodificacionfw			lxImpuestoEsttrans =  .Estadotransferencia			lxImpuestoBdaltafw =  .Basededatosaltafw			lxImpuestoCodigo =  .Codigo			lxImpuestoObs =  .Observacion			lxImpuestoAplicaart =  .Rg5329aplicaporarticulo			lxImpuestoBasecalc =  .Basedecalculo			lxImpuestoCompmreg =  upper( .RG1575Regimen_PK ) 			lxImpuestoMonoreg =  upper( .RG2616Regimen_PK ) 			lxImpuestoCompmporc =  .Rg1575porcentaje			lxImpuestoMonoporc =  .Rg2616porcentaje			lxImpuestoPorcbase =  .Porcentajebase			lxImpuestoDescrip =  .Descripcion			lxImpuestoMonomeses =  .Rg2616meses			lxImpuestoPagocta =  .Pagoparcial			lxImpuestoAplicacion =  .Aplicacion			lxImpuestoCompmbase =  .Rg1575basedecalculo			lxImpuestoCompmmin =  .Rg1575montominimoretencion			lxImpuestoPorcen5329 =  .Rg5329porcentaje			lxImpuestoMaxserv =  .Rg2616montomaximoservicios			lxImpuestoTipo =  upper( .Tipo_PK ) 			lxImpuestoMaxbienes =  .Rg2616montomaximobienes			lxImpuestoJurisdicci =  upper( .Jurisdiccion_PK ) 			lxImpuestoResolu =  .Resolucion			lxImpuestoRegimenimp =  upper( .RegimenImpositivo_PK ) 			lxImpuestoEscala =  .Escala			lxImpuestoMinimo =  .Minimo			lxImpuestoMenalicni =  .Iibbmenalicuotanoinscriptos			lxImpuestoMonto =  .Monto			lxImpuestoPorcentaje =  .Porcentaje			lxImpuestoConvenio =  .Segunconvenio			lxImpuestoConvlocal =  .Conveniolocal			lxImpuestoConvmulti =  .Conveniomultilateral			lxImpuestoConvnoinsc =  .Convenionoinscripto			lxImpuestoConmulext =  .Conveniomultilextranajuris			lxImpuestoTuccfcero =  .Iibbtuccoeficientecero			lxImpuestoTucredalic =  .Iibbtucreduccionalicuota			lxImpuestoTucalicni =  .Iibbtucalicuotanoinscriptos			lxImpuestoRegimen =  .Regimen
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.IMPUESTO ( "Fecimpo","Faltafw","Fecexpo","Fectrans","Fmodifw","Timestamp","Bloqreg","Haltafw","Horaimpo","Horaexpo","Saltafw","Hmodifw","Umodifw","Valtafw","Zadsfw","Ualtafw","Vmodifw","Smodifw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Obs","Aplicaart","Basecalc","Compmreg","Monoreg","Compmporc","Monoporc","Porcbase","Descrip","Monomeses","Pagocta","Aplicacion","Compmbase","Compmmin","Porcen5329","Maxserv","Tipo","Maxbienes","Jurisdicci","Resolu","Regimenimp","Escala","Minimo","Menalicni","Monto","Porcentaje","Convenio","Convlocal","Convmulti","Convnoinsc","Conmulext","Tuccfcero","Tucredalic","Tucalicni","Regimen" ) values ( <<"'" + this.ConvertirDateSql( lxImpuestoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxImpuestoFmodifw ) + "'" >>, <<lxImpuestoTimestamp >>, <<iif( lxImpuestoBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpuestoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoObs ) + "'" >>, <<iif( lxImpuestoAplicaart, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxImpuestoBasecalc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoCompmreg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoMonoreg ) + "'" >>, <<lxImpuestoCompmporc >>, <<lxImpuestoMonoporc >>, <<lxImpuestoPorcbase >>, <<"'" + this.FormatearTextoSql( lxImpuestoDescrip ) + "'" >>, <<lxImpuestoMonomeses >>, <<lxImpuestoPagocta >>, <<"'" + this.FormatearTextoSql( lxImpuestoAplicacion ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoCompmbase ) + "'" >>, <<lxImpuestoCompmmin >>, <<lxImpuestoPorcen5329 >>, <<lxImpuestoMaxserv >>, <<"'" + this.FormatearTextoSql( lxImpuestoTipo ) + "'" >>, <<lxImpuestoMaxbienes >>, <<"'" + this.FormatearTextoSql( lxImpuestoJurisdicci ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoResolu ) + "'" >>, <<"'" + this.FormatearTextoSql( lxImpuestoRegimenimp ) + "'" >>, <<iif( lxImpuestoEscala, 1, 0 ) >>, <<lxImpuestoMinimo >>, <<lxImpuestoMenalicni >>, <<lxImpuestoMonto >>, <<lxImpuestoPorcentaje >>, <<iif( lxImpuestoConvenio, 1, 0 ) >>, <<lxImpuestoConvlocal >>, <<lxImpuestoConvmulti >>, <<lxImpuestoConvnoinsc >>, <<lxImpuestoConmulext >>, <<lxImpuestoTuccfcero >>, <<lxImpuestoTucredalic >>, <<lxImpuestoTucalicni >>, <<"'" + this.FormatearTextoSql( lxImpuestoRegimen ) + "'" >> )
		endtext
		loColeccion.cTabla = 'IMPUESTO' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EscalaDetalle
				if this.oEntidad.EscalaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxPorcentaje = loItem.Porcentaje
					lxSobreexcedente = loItem.Sobreexcedente
					lxMontofijo = loItem.Montofijo
					lxMayora = loItem.Mayora
					lxHasta = loItem.Hasta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.EscalaImp("NROITEM","BLOQREG","codigo","porcentaje","excedente","montofijo","mayora","hasta" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<lxPorcentaje>>, <<lxSobreexcedente>>, <<lxMontofijo>>, <<lxMayora>>, <<lxHasta>> ) 
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
			local  lxImpuestoFecimpo, lxImpuestoFaltafw, lxImpuestoFecexpo, lxImpuestoFectrans, lxImpuestoFmodifw, lxImpuestoTimestamp, lxImpuestoBloqreg, lxImpuestoHaltafw, lxImpuestoHoraimpo, lxImpuestoHoraexpo, lxImpuestoSaltafw, lxImpuestoHmodifw, lxImpuestoUmodifw, lxImpuestoValtafw, lxImpuestoZadsfw, lxImpuestoUaltafw, lxImpuestoVmodifw, lxImpuestoSmodifw, lxImpuestoBdmodifw, lxImpuestoEsttrans, lxImpuestoBdaltafw, lxImpuestoCodigo, lxImpuestoObs, lxImpuestoAplicaart, lxImpuestoBasecalc, lxImpuestoCompmreg, lxImpuestoMonoreg, lxImpuestoCompmporc, lxImpuestoMonoporc, lxImpuestoPorcbase, lxImpuestoDescrip, lxImpuestoMonomeses, lxImpuestoPagocta, lxImpuestoAplicacion, lxImpuestoCompmbase, lxImpuestoCompmmin, lxImpuestoPorcen5329, lxImpuestoMaxserv, lxImpuestoTipo, lxImpuestoMaxbienes, lxImpuestoJurisdicci, lxImpuestoResolu, lxImpuestoRegimenimp, lxImpuestoEscala, lxImpuestoMinimo, lxImpuestoMenalicni, lxImpuestoMonto, lxImpuestoPorcentaje, lxImpuestoConvenio, lxImpuestoConvlocal, lxImpuestoConvmulti, lxImpuestoConvnoinsc, lxImpuestoConmulext, lxImpuestoTuccfcero, lxImpuestoTucredalic, lxImpuestoTucalicni, lxImpuestoRegimen
				lxImpuestoFecimpo =  .Fechaimpo			lxImpuestoFaltafw =  .Fechaaltafw			lxImpuestoFecexpo =  .Fechaexpo			lxImpuestoFectrans =  .Fechatransferencia			lxImpuestoFmodifw =  .Fechamodificacionfw			lxImpuestoTimestamp = goLibrerias.ObtenerTimestamp()			lxImpuestoBloqreg =  .Bloquearregistro			lxImpuestoHaltafw =  .Horaaltafw			lxImpuestoHoraimpo =  .Horaimpo			lxImpuestoHoraexpo =  .Horaexpo			lxImpuestoSaltafw =  .Seriealtafw			lxImpuestoHmodifw =  .Horamodificacionfw			lxImpuestoUmodifw =  .Usuariomodificacionfw			lxImpuestoValtafw =  .Versionaltafw			lxImpuestoZadsfw =  .Zadsfw			lxImpuestoUaltafw =  .Usuarioaltafw			lxImpuestoVmodifw =  .Versionmodificacionfw			lxImpuestoSmodifw =  .Seriemodificacionfw			lxImpuestoBdmodifw =  .Basededatosmodificacionfw			lxImpuestoEsttrans =  .Estadotransferencia			lxImpuestoBdaltafw =  .Basededatosaltafw			lxImpuestoCodigo =  .Codigo			lxImpuestoObs =  .Observacion			lxImpuestoAplicaart =  .Rg5329aplicaporarticulo			lxImpuestoBasecalc =  .Basedecalculo			lxImpuestoCompmreg =  upper( .RG1575Regimen_PK ) 			lxImpuestoMonoreg =  upper( .RG2616Regimen_PK ) 			lxImpuestoCompmporc =  .Rg1575porcentaje			lxImpuestoMonoporc =  .Rg2616porcentaje			lxImpuestoPorcbase =  .Porcentajebase			lxImpuestoDescrip =  .Descripcion			lxImpuestoMonomeses =  .Rg2616meses			lxImpuestoPagocta =  .Pagoparcial			lxImpuestoAplicacion =  .Aplicacion			lxImpuestoCompmbase =  .Rg1575basedecalculo			lxImpuestoCompmmin =  .Rg1575montominimoretencion			lxImpuestoPorcen5329 =  .Rg5329porcentaje			lxImpuestoMaxserv =  .Rg2616montomaximoservicios			lxImpuestoTipo =  upper( .Tipo_PK ) 			lxImpuestoMaxbienes =  .Rg2616montomaximobienes			lxImpuestoJurisdicci =  upper( .Jurisdiccion_PK ) 			lxImpuestoResolu =  .Resolucion			lxImpuestoRegimenimp =  upper( .RegimenImpositivo_PK ) 			lxImpuestoEscala =  .Escala			lxImpuestoMinimo =  .Minimo			lxImpuestoMenalicni =  .Iibbmenalicuotanoinscriptos			lxImpuestoMonto =  .Monto			lxImpuestoPorcentaje =  .Porcentaje			lxImpuestoConvenio =  .Segunconvenio			lxImpuestoConvlocal =  .Conveniolocal			lxImpuestoConvmulti =  .Conveniomultilateral			lxImpuestoConvnoinsc =  .Convenionoinscripto			lxImpuestoConmulext =  .Conveniomultilextranajuris			lxImpuestoTuccfcero =  .Iibbtuccoeficientecero			lxImpuestoTucredalic =  .Iibbtucreduccionalicuota			lxImpuestoTucalicni =  .Iibbtucalicuotanoinscriptos			lxImpuestoRegimen =  .Regimen
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  IMPUESTO.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.IMPUESTO set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxImpuestoFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxImpuestoFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxImpuestoFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxImpuestoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxImpuestoFmodifw ) + "'">>, "Timestamp" = <<lxImpuestoTimestamp>>, "Bloqreg" = <<iif( lxImpuestoBloqreg, 1, 0 )>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxImpuestoHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxImpuestoHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxImpuestoHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxImpuestoSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoHmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxImpuestoValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxImpuestoZadsfw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxImpuestoUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoVmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoSmodifw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxImpuestoBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxImpuestoEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxImpuestoBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxImpuestoCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxImpuestoObs ) + "'">>, "Aplicaart" = <<iif( lxImpuestoAplicaart, 1, 0 )>>, "Basecalc" = <<"'" + this.FormatearTextoSql( lxImpuestoBasecalc ) + "'">>, "Compmreg" = <<"'" + this.FormatearTextoSql( lxImpuestoCompmreg ) + "'">>, "Monoreg" = <<"'" + this.FormatearTextoSql( lxImpuestoMonoreg ) + "'">>, "Compmporc" = <<lxImpuestoCompmporc>>, "Monoporc" = <<lxImpuestoMonoporc>>, "Porcbase" = <<lxImpuestoPorcbase>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxImpuestoDescrip ) + "'">>, "Monomeses" = <<lxImpuestoMonomeses>>, "Pagocta" = <<lxImpuestoPagocta>>, "Aplicacion" = <<"'" + this.FormatearTextoSql( lxImpuestoAplicacion ) + "'">>, "Compmbase" = <<"'" + this.FormatearTextoSql( lxImpuestoCompmbase ) + "'">>, "Compmmin" = <<lxImpuestoCompmmin>>, "Porcen5329" = <<lxImpuestoPorcen5329>>, "Maxserv" = <<lxImpuestoMaxserv>>, "Tipo" = <<"'" + this.FormatearTextoSql( lxImpuestoTipo ) + "'">>, "Maxbienes" = <<lxImpuestoMaxbienes>>, "Jurisdicci" = <<"'" + this.FormatearTextoSql( lxImpuestoJurisdicci ) + "'">>, "Resolu" = <<"'" + this.FormatearTextoSql( lxImpuestoResolu ) + "'">>, "Regimenimp" = <<"'" + this.FormatearTextoSql( lxImpuestoRegimenimp ) + "'">>, "Escala" = <<iif( lxImpuestoEscala, 1, 0 )>>, "Minimo" = <<lxImpuestoMinimo>>, "Menalicni" = <<lxImpuestoMenalicni>>, "Monto" = <<lxImpuestoMonto>>, "Porcentaje" = <<lxImpuestoPorcentaje>>, "Convenio" = <<iif( lxImpuestoConvenio, 1, 0 )>>, "Convlocal" = <<lxImpuestoConvlocal>>, "Convmulti" = <<lxImpuestoConvmulti>>, "Convnoinsc" = <<lxImpuestoConvnoinsc>>, "Conmulext" = <<lxImpuestoConmulext>>, "Tuccfcero" = <<lxImpuestoTuccfcero>>, "Tucredalic" = <<lxImpuestoTucredalic>>, "Tucalicni" = <<lxImpuestoTucalicni>>, "Regimen" = <<"'" + this.FormatearTextoSql( lxImpuestoRegimen ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'IMPUESTO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.EscalaImp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.EscalaDetalle
				if this.oEntidad.EscalaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxPorcentaje = loItem.Porcentaje
					lxSobreexcedente = loItem.Sobreexcedente
					lxMontofijo = loItem.Montofijo
					lxMayora = loItem.Mayora
					lxHasta = loItem.Hasta
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.EscalaImp("NROITEM","BLOQREG","codigo","porcentaje","excedente","montofijo","mayora","hasta" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<lxPorcentaje>>, <<lxSobreexcedente>>, <<lxMontofijo>>, <<lxMayora>>, <<lxHasta>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  IMPUESTO.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.IMPUESTO where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.EscalaImp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'IMPUESTO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.IMPUESTO where  IMPUESTO.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.IMPUESTO where codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  IMPUESTO.CODIGO != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPUESTO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.IMPUESTO Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.IMPUESTO set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, AplicaArt = ] + Transform( iif( &lcCursor..AplicaArt, 1, 0 ))+ [, basecalc = ] + "'" + this.FormatearTextoSql( &lcCursor..basecalc ) + "'"+ [, compmreg = ] + "'" + this.FormatearTextoSql( &lcCursor..compmreg ) + "'"+ [, monoreg = ] + "'" + this.FormatearTextoSql( &lcCursor..monoreg ) + "'"+ [, compmporc = ] + transform( &lcCursor..compmporc )+ [, monoporc = ] + transform( &lcCursor..monoporc )+ [, porcbase = ] + transform( &lcCursor..porcbase )+ [, descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'"+ [, monomeses = ] + transform( &lcCursor..monomeses )+ [, pagocta = ] + transform( &lcCursor..pagocta )+ [, aplicacion = ] + "'" + this.FormatearTextoSql( &lcCursor..aplicacion ) + "'"+ [, compmbase = ] + "'" + this.FormatearTextoSql( &lcCursor..compmbase ) + "'"+ [, CompMMin = ] + transform( &lcCursor..CompMMin )+ [, Porcen5329 = ] + transform( &lcCursor..Porcen5329 )+ [, maxserv = ] + transform( &lcCursor..maxserv )+ [, tipo = ] + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'"+ [, maxbienes = ] + transform( &lcCursor..maxbienes )+ [, Jurisdicci = ] + "'" + this.FormatearTextoSql( &lcCursor..Jurisdicci ) + "'"+ [, Resolu = ] + "'" + this.FormatearTextoSql( &lcCursor..Resolu ) + "'"+ [, RegimenImp = ] + "'" + this.FormatearTextoSql( &lcCursor..RegimenImp ) + "'"+ [, escala = ] + Transform( iif( &lcCursor..escala, 1, 0 ))+ [, minimo = ] + transform( &lcCursor..minimo )+ [, MenAlicNI = ] + transform( &lcCursor..MenAlicNI )+ [, monto = ] + transform( &lcCursor..monto )+ [, porcentaje = ] + transform( &lcCursor..porcentaje )+ [, Convenio = ] + Transform( iif( &lcCursor..Convenio, 1, 0 ))+ [, ConvLocal = ] + transform( &lcCursor..ConvLocal )+ [, ConvMulti = ] + transform( &lcCursor..ConvMulti )+ [, ConvNoInsc = ] + transform( &lcCursor..ConvNoInsc )+ [, ConMulExt = ] + transform( &lcCursor..ConMulExt )+ [, TucCfCero = ] + transform( &lcCursor..TucCfCero )+ [, TucRedAlic = ] + transform( &lcCursor..TucRedAlic )+ [, TucAlicNI = ] + transform( &lcCursor..TucAlicNI )+ [, regimen = ] + "'" + this.FormatearTextoSql( &lcCursor..regimen ) + "'" + [ Where codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FALTAFW, FECEXPO, FECTRANS, FMODIFW, TIMESTAMP, BLOQREG, HALTAFW, HORAIMPO, HORAEXPO, SALTAFW, HMODIFW, UMODIFW, VALTAFW, ZADSFW, UALTAFW, VMODIFW, SMODIFW, BDMODIFW, ESTTRANS, BDALTAFW, codigo, Obs, AplicaArt, basecalc, compmreg, monoreg, compmporc, monoporc, porcbase, descrip, monomeses, pagocta, aplicacion, compmbase, CompMMin, Porcen5329, maxserv, tipo, maxbienes, Jurisdicci, Resolu, RegimenImp, escala, minimo, MenAlicNI, monto, porcentaje, Convenio, ConvLocal, ConvMulti, ConvNoInsc, ConMulExt, TucCfCero, TucRedAlic, TucAlicNI, regimen
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + Transform( iif( &lcCursor..AplicaArt, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..basecalc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..compmreg ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..monoreg ) + "'" + ',' + transform( &lcCursor..compmporc )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..monoporc ) + ',' + transform( &lcCursor..porcbase ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'" + ',' + transform( &lcCursor..monomeses ) + ',' + transform( &lcCursor..pagocta ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..aplicacion ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..compmbase ) + "'" + ',' + transform( &lcCursor..CompMMin )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Porcen5329 ) + ',' + transform( &lcCursor..maxserv ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipo ) + "'" + ',' + transform( &lcCursor..maxbienes ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Jurisdicci ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Resolu ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..RegimenImp ) + "'" + ',' + Transform( iif( &lcCursor..escala, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..minimo ) + ',' + transform( &lcCursor..MenAlicNI ) + ',' + transform( &lcCursor..monto ) + ',' + transform( &lcCursor..porcentaje ) + ',' + Transform( iif( &lcCursor..Convenio, 1, 0 )) + ',' + transform( &lcCursor..ConvLocal ) + ',' + transform( &lcCursor..ConvMulti ) + ',' + transform( &lcCursor..ConvNoInsc ) + ',' + transform( &lcCursor..ConMulExt ) + ',' + transform( &lcCursor..TucCfCero )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TucRedAlic ) + ',' + transform( &lcCursor..TucAlicNI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..regimen ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPUESTO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPUESTO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.EscalaImp Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMESCALA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","codigo","porcentaje","excedente","montofijo","mayora","hasta"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.EscalaImp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + transform( cDetallesExistentes.porcentaje ) + ',' + transform( cDetallesExistentes.excedente  ) + ',' + transform( cDetallesExistentes.montofijo  ) + ',' + transform( cDetallesExistentes.mayora     ) + ',' + transform( cDetallesExistentes.hasta      ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( codigo C (10) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..codigo     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'IMPUESTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPUESTO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'IMPUESTO_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMESCALA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_Impuesto')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'IMPUESTO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..codigo
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad IMPUESTO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPUESTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPUESTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Impuesto') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Impuesto
Create Table ZooLogic.TablaTrabajo_Impuesto ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"smodifw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 10 )  null, 
"obs" varchar(max)  null, 
"aplicaart" bit  null, 
"basecalc" char( 10 )  null, 
"compmreg" char( 5 )  null, 
"monoreg" char( 5 )  null, 
"compmporc" numeric( 6, 2 )  null, 
"monoporc" numeric( 6, 2 )  null, 
"porcbase" numeric( 6, 2 )  null, 
"descrip" char( 50 )  null, 
"monomeses" numeric( 3, 0 )  null, 
"pagocta" numeric( 1, 0 )  null, 
"aplicacion" char( 10 )  null, 
"compmbase" char( 10 )  null, 
"compmmin" numeric( 15, 2 )  null, 
"porcen5329" numeric( 6, 2 )  null, 
"maxserv" numeric( 12, 2 )  null, 
"tipo" char( 10 )  null, 
"maxbienes" numeric( 12, 2 )  null, 
"jurisdicci" char( 8 )  null, 
"resolu" char( 60 )  null, 
"regimenimp" char( 5 )  null, 
"escala" bit  null, 
"minimo" numeric( 12, 2 )  null, 
"menalicni" numeric( 6, 2 )  null, 
"monto" numeric( 12, 2 )  null, 
"porcentaje" numeric( 6, 2 )  null, 
"convenio" bit  null, 
"convlocal" numeric( 6, 2 )  null, 
"convmulti" numeric( 6, 2 )  null, 
"convnoinsc" numeric( 6, 2 )  null, 
"conmulext" numeric( 6, 2 )  null, 
"tuccfcero" numeric( 7, 3 )  null, 
"tucredalic" numeric( 7, 3 )  null, 
"tucalicni" numeric( 7, 3 )  null, 
"regimen" char( 50 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_Impuesto' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_Impuesto' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'IMPUESTO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('aplicaart','aplicaart')
			.AgregarMapeo('basecalc','basecalc')
			.AgregarMapeo('compmreg','compmreg')
			.AgregarMapeo('monoreg','monoreg')
			.AgregarMapeo('compmporc','compmporc')
			.AgregarMapeo('monoporc','monoporc')
			.AgregarMapeo('porcbase','porcbase')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('monomeses','monomeses')
			.AgregarMapeo('pagocta','pagocta')
			.AgregarMapeo('aplicacion','aplicacion')
			.AgregarMapeo('compmbase','compmbase')
			.AgregarMapeo('compmmin','compmmin')
			.AgregarMapeo('porcen5329','porcen5329')
			.AgregarMapeo('maxserv','maxserv')
			.AgregarMapeo('tipo','tipo')
			.AgregarMapeo('maxbienes','maxbienes')
			.AgregarMapeo('jurisdicci','jurisdicci')
			.AgregarMapeo('resolu','resolu')
			.AgregarMapeo('regimenimp','regimenimp')
			.AgregarMapeo('escala','escala')
			.AgregarMapeo('minimo','minimo')
			.AgregarMapeo('menalicni','menalicni')
			.AgregarMapeo('monto','monto')
			.AgregarMapeo('porcentaje','porcentaje')
			.AgregarMapeo('convenio','convenio')
			.AgregarMapeo('convlocal','convlocal')
			.AgregarMapeo('convmulti','convmulti')
			.AgregarMapeo('convnoinsc','convnoinsc')
			.AgregarMapeo('conmulext','conmulext')
			.AgregarMapeo('tuccfcero','tuccfcero')
			.AgregarMapeo('tucredalic','tucredalic')
			.AgregarMapeo('tucalicni','tucalicni')
			.AgregarMapeo('regimen','regimen')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_Impuesto'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.APLICAART = isnull( d.APLICAART, t.APLICAART ),t.BASECALC = isnull( d.BASECALC, t.BASECALC ),t.COMPMREG = isnull( d.COMPMREG, t.COMPMREG ),t.MONOREG = isnull( d.MONOREG, t.MONOREG ),t.COMPMPORC = isnull( d.COMPMPORC, t.COMPMPORC ),t.MONOPORC = isnull( d.MONOPORC, t.MONOPORC ),t.PORCBASE = isnull( d.PORCBASE, t.PORCBASE ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.MONOMESES = isnull( d.MONOMESES, t.MONOMESES ),t.PAGOCTA = isnull( d.PAGOCTA, t.PAGOCTA ),t.APLICACION = isnull( d.APLICACION, t.APLICACION ),t.COMPMBASE = isnull( d.COMPMBASE, t.COMPMBASE ),t.COMPMMIN = isnull( d.COMPMMIN, t.COMPMMIN ),t.PORCEN5329 = isnull( d.PORCEN5329, t.PORCEN5329 ),t.MAXSERV = isnull( d.MAXSERV, t.MAXSERV ),t.TIPO = isnull( d.TIPO, t.TIPO ),t.MAXBIENES = isnull( d.MAXBIENES, t.MAXBIENES ),t.JURISDICCI = isnull( d.JURISDICCI, t.JURISDICCI ),t.RESOLU = isnull( d.RESOLU, t.RESOLU ),t.REGIMENIMP = isnull( d.REGIMENIMP, t.REGIMENIMP ),t.ESCALA = isnull( d.ESCALA, t.ESCALA ),t.MINIMO = isnull( d.MINIMO, t.MINIMO ),t.MENALICNI = isnull( d.MENALICNI, t.MENALICNI ),t.MONTO = isnull( d.MONTO, t.MONTO ),t.PORCENTAJE = isnull( d.PORCENTAJE, t.PORCENTAJE ),t.CONVENIO = isnull( d.CONVENIO, t.CONVENIO ),t.CONVLOCAL = isnull( d.CONVLOCAL, t.CONVLOCAL ),t.CONVMULTI = isnull( d.CONVMULTI, t.CONVMULTI ),t.CONVNOINSC = isnull( d.CONVNOINSC, t.CONVNOINSC ),t.CONMULEXT = isnull( d.CONMULEXT, t.CONMULEXT ),t.TUCCFCERO = isnull( d.TUCCFCERO, t.TUCCFCERO ),t.TUCREDALIC = isnull( d.TUCREDALIC, t.TUCREDALIC ),t.TUCALICNI = isnull( d.TUCALICNI, t.TUCALICNI ),t.REGIMEN = isnull( d.REGIMEN, t.REGIMEN )
					from ZooLogic.IMPUESTO t inner join deleted d 
							 on t.codigo = d.codigo
				-- Fin Updates
				insert into ZooLogic.IMPUESTO(Fecimpo,Faltafw,Fecexpo,Fectrans,Fmodifw,Timestamp,Bloqreg,Haltafw,Horaimpo,Horaexpo,Saltafw,Hmodifw,Umodifw,Valtafw,Zadsfw,Ualtafw,Vmodifw,Smodifw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Obs,Aplicaart,Basecalc,Compmreg,Monoreg,Compmporc,Monoporc,Porcbase,Descrip,Monomeses,Pagocta,Aplicacion,Compmbase,Compmmin,Porcen5329,Maxserv,Tipo,Maxbienes,Jurisdicci,Resolu,Regimenimp,Escala,Minimo,Menalicni,Monto,Porcentaje,Convenio,Convlocal,Convmulti,Convnoinsc,Conmulext,Tuccfcero,Tucredalic,Tucalicni,Regimen)
					Select isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.SMODIFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.APLICAART,0),isnull( d.BASECALC,''),isnull( d.COMPMREG,''),isnull( d.MONOREG,''),isnull( d.COMPMPORC,0),isnull( d.MONOPORC,0),isnull( d.PORCBASE,0),isnull( d.DESCRIP,''),isnull( d.MONOMESES,0),isnull( d.PAGOCTA,0),isnull( d.APLICACION,''),isnull( d.COMPMBASE,''),isnull( d.COMPMMIN,0),isnull( d.PORCEN5329,0),isnull( d.MAXSERV,0),isnull( d.TIPO,''),isnull( d.MAXBIENES,0),isnull( d.JURISDICCI,''),isnull( d.RESOLU,''),isnull( d.REGIMENIMP,''),isnull( d.ESCALA,0),isnull( d.MINIMO,0),isnull( d.MENALICNI,0),isnull( d.MONTO,0),isnull( d.PORCENTAJE,0),isnull( d.CONVENIO,0),isnull( d.CONVLOCAL,0),isnull( d.CONVMULTI,0),isnull( d.CONVNOINSC,0),isnull( d.CONMULEXT,0),isnull( d.TUCCFCERO,0),isnull( d.TUCREDALIC,0),isnull( d.TUCALICNI,0),isnull( d.REGIMEN,'')
						From deleted d left join ZooLogic.IMPUESTO pk 
							 on d.codigo = pk.codigo
						Where pk.codigo Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_EscalaImp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_IMPUESTO_EscalaImp
ON ZooLogic.TablaTrabajo_IMPUESTO_EscalaImp
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PORCENTAJE = isnull( d.PORCENTAJE, t.PORCENTAJE ),
t.EXCEDENTE = isnull( d.EXCEDENTE, t.EXCEDENTE ),
t.MONTOFIJO = isnull( d.MONTOFIJO, t.MONTOFIJO ),
t.MAYORA = isnull( d.MAYORA, t.MAYORA ),
t.HASTA = isnull( d.HASTA, t.HASTA )
from ZooLogic.EscalaImp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.EscalaImp
( 
"NROITEM",
"BLOQREG",
"CODIGO",
"PORCENTAJE",
"EXCEDENTE",
"MONTOFIJO",
"MAYORA",
"HASTA"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODIGO,
d.PORCENTAJE,
d.EXCEDENTE,
d.MONTOFIJO,
d.MAYORA,
d.HASTA
From deleted d left join ZooLogic.EscalaImp pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_Impuesto') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_Impuesto
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_IMPUESTO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPUESTO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPUESTO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPUESTO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPUESTO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_IMPUESTO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Timestamp = nvl( c_IMPUESTO.Timestamp, 0 )
					.Bloquearregistro = nvl( c_IMPUESTO.Bloquearregistro, .F. )
					.Horaaltafw = nvl( c_IMPUESTO.Horaaltafw, [] )
					.Horaimpo = nvl( c_IMPUESTO.Horaimpo, [] )
					.Horaexpo = nvl( c_IMPUESTO.Horaexpo, [] )
					.Seriealtafw = nvl( c_IMPUESTO.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_IMPUESTO.Horamodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_IMPUESTO.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_IMPUESTO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuarioaltafw = nvl( c_IMPUESTO.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_IMPUESTO.Versionmodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_IMPUESTO.Seriemodificacionfw, [] )
					.Basededatosmodificacionfw = nvl( c_IMPUESTO.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_IMPUESTO.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_IMPUESTO.Basededatosaltafw, [] )
					.Codigo = nvl( c_IMPUESTO.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Escaladetalle.Limpiar()
					.Escaladetalle.SetearEsNavegacion( .lProcesando )
					.Escaladetalle.Cargar()
					.Rg5329aplicaporarticulo = nvl( c_IMPUESTO.Rg5329aplicaporarticulo, .F. )
					.Basedecalculo = nvl( c_IMPUESTO.Basedecalculo, [] )
					.Rg1575regimen_PK =  nvl( c_IMPUESTO.Rg1575regimen, [] )
					.Rg2616regimen_PK =  nvl( c_IMPUESTO.Rg2616regimen, [] )
					.Rg1575porcentaje = nvl( c_IMPUESTO.Rg1575porcentaje, 0 )
					.Rg2616porcentaje = nvl( c_IMPUESTO.Rg2616porcentaje, 0 )
					.Porcentajebase = nvl( c_IMPUESTO.Porcentajebase, 0 )
					.Descripcion = nvl( c_IMPUESTO.Descripcion, [] )
					.Rg2616meses = nvl( c_IMPUESTO.Rg2616meses, 0 )
					.Pagoparcial = nvl( c_IMPUESTO.Pagoparcial, 0 )
					.Aplicacion = nvl( c_IMPUESTO.Aplicacion, [] )
					.Rg1575basedecalculo = nvl( c_IMPUESTO.Rg1575basedecalculo, [] )
					.Rg1575montominimoretencion = nvl( c_IMPUESTO.Rg1575montominimoretencion, 0 )
					.Rg5329porcentaje = nvl( c_IMPUESTO.Rg5329porcentaje, 0 )
					.Rg2616montomaximoservicios = nvl( c_IMPUESTO.Rg2616montomaximoservicios, 0 )
					.Tipo_PK =  nvl( c_IMPUESTO.Tipo, [] )
					.Rg2616montomaximobienes = nvl( c_IMPUESTO.Rg2616montomaximobienes, 0 )
					.Jurisdiccion_PK =  nvl( c_IMPUESTO.Jurisdiccion, [] )
					.Resolucion = nvl( c_IMPUESTO.Resolucion, [] )
					.Regimenimpositivo_PK =  nvl( c_IMPUESTO.Regimenimpositivo, [] )
					.Escala = nvl( c_IMPUESTO.Escala, .F. )
					.Minimo = nvl( c_IMPUESTO.Minimo, 0 )
					.Iibbmenalicuotanoinscriptos = nvl( c_IMPUESTO.Iibbmenalicuotanoinscriptos, 0 )
					.Monto = nvl( c_IMPUESTO.Monto, 0 )
					.Porcentaje = nvl( c_IMPUESTO.Porcentaje, 0 )
					.Segunconvenio = nvl( c_IMPUESTO.Segunconvenio, .F. )
					.Conveniolocal = nvl( c_IMPUESTO.Conveniolocal, 0 )
					.Conveniomultilateral = nvl( c_IMPUESTO.Conveniomultilateral, 0 )
					.Convenionoinscripto = nvl( c_IMPUESTO.Convenionoinscripto, 0 )
					.Conveniomultilextranajuris = nvl( c_IMPUESTO.Conveniomultilextranajuris, 0 )
					.Iibbtuccoeficientecero = nvl( c_IMPUESTO.Iibbtuccoeficientecero, 0 )
					.Iibbtucreduccionalicuota = nvl( c_IMPUESTO.Iibbtucreduccionalicuota, 0 )
					.Iibbtucalicuotanoinscriptos = nvl( c_IMPUESTO.Iibbtucalicuotanoinscriptos, 0 )
					.Regimen = nvl( c_IMPUESTO.Regimen, [] )
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
		
		loDetalle = this.oEntidad.EscalaDetalle
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
		return c_IMPUESTO.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.IMPUESTO' )
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
								from ZooLogic.IMPUESTO 
								Where   IMPUESTO.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "IMPUESTO", "", lcCursor, set("Datasession") )
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
			"Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Smodifw" as "Seriemodificacionfw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Observacion", "Aplicaart" as "Rg5329aplicaporarticulo", "Basecalc" as "Basedecalculo", "Compmreg" as "Rg1575regimen", "Monoreg" as "Rg2616regimen", "Compmporc" as "Rg1575porcentaje", "Monoporc" as "Rg2616porcentaje", "Porcbase" as "Porcentajebase", "Descrip" as "Descripcion", "Monomeses" as "Rg2616meses", "Pagocta" as "Pagoparcial", "Aplicacion" as "Aplicacion", "Compmbase" as "Rg1575basedecalculo", "Compmmin" as "Rg1575montominimoretencion", "Porcen5329" as "Rg5329porcentaje", "Maxserv" as "Rg2616montomaximoservicios", "Tipo" as "Tipo", "Maxbienes" as "Rg2616montomaximobienes", "Jurisdicci" as "Jurisdiccion", "Resolu" as "Resolucion", "Regimenimp" as "Regimenimpositivo", "Escala" as "Escala", "Minimo" as "Minimo", "Menalicni" as "Iibbmenalicuotanoinscriptos", "Monto" as "Monto", "Porcentaje" as "Porcentaje", "Convenio" as "Segunconvenio", "Convlocal" as "Conveniolocal", "Convmulti" as "Conveniomultilateral", "Convnoinsc" as "Convenionoinscripto", "Conmulext" as "Conveniomultilextranajuris", "Tuccfcero" as "Iibbtuccoeficientecero", "Tucredalic" as "Iibbtucreduccionalicuota", "Tucalicni" as "Iibbtucalicuotanoinscriptos", "Regimen" as "Regimen"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.IMPUESTO 
								Where   IMPUESTO.CODIGO != ''
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
	Tabla = 'IMPUESTO'
	Filtro = " IMPUESTO.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " IMPUESTO.CODIGO != ''"
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
	<row entidad="IMPUESTO                                " atributo="FECHAIMPO                               " tabla="IMPUESTO       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="FECHAALTAFW                             " tabla="IMPUESTO       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="FECHAEXPO                               " tabla="IMPUESTO       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="FECHATRANSFERENCIA                      " tabla="IMPUESTO       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="FECHAMODIFICACIONFW                     " tabla="IMPUESTO       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="TIMESTAMP                               " tabla="IMPUESTO       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="BLOQUEARREGISTRO                        " tabla="IMPUESTO       " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="HORAALTAFW                              " tabla="IMPUESTO       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="HORAIMPO                                " tabla="IMPUESTO       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="HORAEXPO                                " tabla="IMPUESTO       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="SERIEALTAFW                             " tabla="IMPUESTO       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="HORAMODIFICACIONFW                      " tabla="IMPUESTO       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="USUARIOMODIFICACIONFW                   " tabla="IMPUESTO       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="VERSIONALTAFW                           " tabla="IMPUESTO       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="ZADSFW                                  " tabla="IMPUESTO       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="USUARIOALTAFW                           " tabla="IMPUESTO       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="VERSIONMODIFICACIONFW                   " tabla="IMPUESTO       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="SERIEMODIFICACIONFW                     " tabla="IMPUESTO       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="IMPUESTO       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="ESTADOTRANSFERENCIA                     " tabla="IMPUESTO       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="BASEDEDATOSALTAFW                       " tabla="IMPUESTO       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="CODIGO                                  " tabla="IMPUESTO       " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="OBSERVACION                             " tabla="IMPUESTO       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="ESCALADETALLE                           " tabla="ESCALAIMP      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Escalas aplicables                                                                                                                                              " dominio="DETALLEITEMESCALA             " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG5329APLICAPORARTICULO                 " tabla="IMPUESTO       " campo="APLICAART " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Aplica impuesto por artículo                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="BASEDECALCULO                           " tabla="IMPUESTO       " campo="BASECALC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="TOT                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="406" etiqueta="Base de cálculo                                                                                                                                                 " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG1575REGIMEN                           " tabla="IMPUESTO       " campo="COMPMREG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REGIMENIMPOSITIVO                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Régimen                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG2616REGIMEN                           " tabla="IMPUESTO       " campo="MONOREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REGIMENIMPOSITIVO                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Régimen                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG1575PORCENTAJE                        " tabla="IMPUESTO       " campo="COMPMPORC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Porcentaje                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG2616PORCENTAJE                        " tabla="IMPUESTO       " campo="MONOPORC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Porcentaje                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="PORCENTAJEBASE                          " tabla="IMPUESTO       " campo="PORCBASE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Porcentaje sobre base                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="DESCRIPCION                             " tabla="IMPUESTO       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG2616MESES                             " tabla="IMPUESTO       " campo="MONOMESES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Cantidad de meses                                                                                                                                               " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="PAGOPARCIAL                             " tabla="IMPUESTO       " campo="PAGOCTA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Pagos parciales                                                                                                                                                 " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="APLICACION                              " tabla="IMPUESTO       " campo="APLICACION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="PRC                                                                                                                                                                                                                                                           " obligatorio="true" admitebusqueda="422" etiqueta="Aplicación                                                                                                                                                      " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG1575BASEDECALCULO                     " tabla="IMPUESTO       " campo="COMPMBASE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Base de cálculo                                                                                                                                                 " dominio="COMBOXMLIMPUESTO              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG1575MONTOMINIMORETENCION              " tabla="IMPUESTO       " campo="COMPMMIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Mínimo no imponible                                                                                                                                             " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG5329PORCENTAJE                        " tabla="IMPUESTO       " campo="PORCEN5329" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Porcentaje alícuota reducida                                                                                                                                    " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="8" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG2616MONTOMAXIMOSERVICIOS              " tabla="IMPUESTO       " campo="MAXSERV   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Monto máximo por servicios                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="TIPO                                    " tabla="IMPUESTO       " campo="TIPO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOIMPUESTO                            " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="432" etiqueta="Tipo de impuesto                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RG2616MONTOMAXIMOBIENES                 " tabla="IMPUESTO       " campo="MAXBIENES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Monto máximo por venta                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="JURISDICCION                            " tabla="IMPUESTO       " campo="JURISDICCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="JURISDICCION                            " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Jurisdicción                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="RESOLUCION                              " tabla="IMPUESTO       " campo="RESOLU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Resolución                                                                                                                                                      " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="REGIMENIMPOSITIVO                       " tabla="IMPUESTO       " campo="REGIMENIMP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REGIMENIMPOSITIVO                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Régimen                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="ESCALA                                  " tabla="IMPUESTO       " campo="ESCALA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Según escala                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="MINIMO                                  " tabla="IMPUESTO       " campo="MINIMO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Mínimo de impuesto                                                                                                                                              " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="IIBBMENALICUOTANOINSCRIPTOS             " tabla="IMPUESTO       " campo="MENALICNI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Régimen RG ATM Nro. 5 2023                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="9" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="MONTO                                   " tabla="IMPUESTO       " campo="MONTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Mínimo no imponible                                                                                                                                             " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="PORCENTAJE                              " tabla="IMPUESTO       " campo="PORCENTAJE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Porcentaje                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="SEGUNCONVENIO                           " tabla="IMPUESTO       " campo="CONVENIO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Según convenio                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="CONVENIOLOCAL                           " tabla="IMPUESTO       " campo="CONVLOCAL " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Contribuyente local                                                                                                                                             " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="CONVENIOMULTILATERAL                    " tabla="IMPUESTO       " campo="CONVMULTI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Convenio multilateral                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="CONVENIONOINSCRIPTO                     " tabla="IMPUESTO       " campo="CONVNOINSC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Contribuyente no inscripto                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="CONVENIOMULTILEXTRANAJURIS              " tabla="IMPUESTO       " campo="CONMULEXT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Convenio multilateral con sede en extraña jurisdicción                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="IIBBTUCCOEFICIENTECERO                  " tabla="IMPUESTO       " campo="TUCCFCERO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="3" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Coeficiente igual a cero                                                                                                                                        " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="IIBBTUCREDUCCIONALICUOTA                " tabla="IMPUESTO       " campo="TUCREDALIC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="3" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Reducción de alícuota                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="IIBBTUCALICUOTANOINSCRIPTOS             " tabla="IMPUESTO       " campo="TUCALICNI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="3" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Alícuota no inscriptos                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="IMPUESTO                                " atributo="REGIMEN                                 " tabla="IMPUESTO       " campo="REGIMEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Régimen                                                                                                                                                         " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="99" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGIMENIMPOSITIVO                       " atributo="DESCRIPCION                             " tabla="REGIMP         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Rég.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REGIMP On IMPUESTO.COMPMREG = REGIMP.Codigo And  REGIMP.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGIMENIMPOSITIVO                       " atributo="DESCRIPCION                             " tabla="REGIMP         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Rég.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REGIMP On IMPUESTO.MONOREG = REGIMP.Codigo And  REGIMP.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOIMPUESTO                            " atributo="DESCRIPCION                             " tabla="TIPOIMP        " campo="DECRIP    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOIMP On IMPUESTO.TIPO = TIPOIMP.Codigo And  TIPOIMP.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="JURISDICCION                            " atributo="DESCRIPCION                             " tabla="JURISDIC       " campo="DESCRI    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Jur.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join JURISDIC On IMPUESTO.JURISDICCI = JURISDIC.codigo And  JURISDIC.CODIGO != ''                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REGIMENIMPOSITIVO                       " atributo="DESCRIPCION                             " tabla="REGIMP         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Rég.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REGIMP On IMPUESTO.REGIMENIMP = REGIMP.Codigo And  REGIMP.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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