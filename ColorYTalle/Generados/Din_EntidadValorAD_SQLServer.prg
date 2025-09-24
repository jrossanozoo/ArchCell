
define class Din_EntidadVALORAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_VALOR'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_VALPK'
	cTablaPrincipal = 'XVAL'
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
			local  lxXvalFecimpo, lxXvalFectrans, lxXvalFmodifw, lxXvalFecexpo, lxXvalFaltafw, lxXvalHoraimpo, lxXvalHoraexpo, lxXvalBdaltafw, lxXvalHaltafw, lxXvalHmodifw, lxXvalEsttrans, lxXvalBdmodifw, lxXvalSaltafw, lxXvalZadsfw, lxXvalVmodifw, lxXvalUmodifw, lxXvalValtafw, lxXvalUaltafw, lxXvalSmodifw, lxXvalTipagrupub, lxXvalTimestamp, lxXvalClcod, lxXvalClnom, lxXvalModoredon, lxXvalCtabanc, lxXvalPrestador, lxXvalClcfi, lxXvalRedondeo, lxXvalClsmonet, lxXvalClclas, lxXvalClvisualiz, lxXvalOpetar, lxXvalRetiraefec, lxXvalEqepson, lxXvalClgrup, lxXvalClobs, lxXvalVallince, lxXvalClrecargo, lxXvalPervuelto, lxXvalEqibm, lxXvalTipotarj, lxXvalIdcaja, lxXvalFactelec, lxXvalPaguesea, lxXvalPersocomp, lxXvalLeyenda, lxXvalNoarrastra, lxXvalMntomaxret, lxXvalBcoadep, lxXvalCcadep, lxXvalImprchqcf, lxXvalCldescp, lxXvalElectro, lxXvalNoaplirc, lxXvalArqtot, lxXvalValorretef, lxXvalBlomoddes, lxXvalValoracred, lxXvalModifecha
				lxXvalFecimpo =  .Fechaimpo			lxXvalFectrans =  .Fechatransferencia			lxXvalFmodifw =  .Fechamodificacionfw			lxXvalFecexpo =  .Fechaexpo			lxXvalFaltafw =  .Fechaaltafw			lxXvalHoraimpo =  .Horaimpo			lxXvalHoraexpo =  .Horaexpo			lxXvalBdaltafw =  .Basededatosaltafw			lxXvalHaltafw =  .Horaaltafw			lxXvalHmodifw =  .Horamodificacionfw			lxXvalEsttrans =  .Estadotransferencia			lxXvalBdmodifw =  .Basededatosmodificacionfw			lxXvalSaltafw =  .Seriealtafw			lxXvalZadsfw =  .Zadsfw			lxXvalVmodifw =  .Versionmodificacionfw			lxXvalUmodifw =  .Usuariomodificacionfw			lxXvalValtafw =  .Versionaltafw			lxXvalUaltafw =  .Usuarioaltafw			lxXvalSmodifw =  .Seriemodificacionfw			lxXvalTipagrupub =  .Tipoagrupamientopublicaciones			lxXvalTimestamp = goLibrerias.ObtenerTimestamp()			lxXvalClcod =  .Codigo			lxXvalClnom =  .Descripcion			lxXvalModoredon =  .Modoredondeo			lxXvalCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvalPrestador =  .Prestador			lxXvalClcfi =  .Tipo			lxXvalRedondeo =  upper( .Redondeo_PK ) 			lxXvalClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvalClclas =  upper( .Clasificacion_PK ) 			lxXvalClvisualiz =  .Visualizarencaja			lxXvalOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvalRetiraefec =  .Habilitarretiroefectivo			lxXvalEqepson =  .Equivcfepson			lxXvalClgrup =  upper( .Grupo_PK ) 			lxXvalClobs =  .Observacion			lxXvalVallince =  .Valoreslince			lxXvalClrecargo =  .Recargo			lxXvalPervuelto =  .Permitevuelto			lxXvalEqibm =  .Equivcfibm			lxXvalTipotarj =  .Tipotarjeta			lxXvalIdcaja =  .Caja_PK 			lxXvalFactelec =  .Facturaelectronica			lxXvalPaguesea =  .Paguesea			lxXvalPersocomp =  .Personalizarcomprobante			lxXvalLeyenda =  .Leyenda			lxXvalNoarrastra =  .Arrastrasaldo			lxXvalMntomaxret =  .Montomaximoderetiro			lxXvalBcoadep =  upper( .BcoADep_PK ) 			lxXvalCcadep =  .Ctacteadep			lxXvalImprchqcf =  .Imprimechequecfiscal			lxXvalCldescp =  .Descuento			lxXvalElectro =  .Chequeelectronico			lxXvalNoaplirc =  .Noaplicarenrecibos			lxXvalArqtot =  .Arqueoportotales			lxXvalValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvalBlomoddes =  .Bloqueamodificaciondescripcion			lxXvalValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvalModifecha =  .Permitemodificarfecha
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxXvalClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.XVAL ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Horaimpo","Horaexpo","Bdaltafw","Haltafw","Hmodifw","Esttrans","Bdmodifw","Saltafw","Zadsfw","Vmodifw","Umodifw","Valtafw","Ualtafw","Smodifw","Tipagrupub","Timestamp","Clcod","Clnom","Modoredon","Ctabanc","Prestador","Clcfi","Redondeo","Clsmonet","Clclas","Clvisualiz","Opetar","Retiraefec","Eqepson","Clgrup","Clobs","Vallince","Clrecargo","Pervuelto","Eqibm","Tipotarj","Idcaja","Factelec","Paguesea","Persocomp","Leyenda","Noarrastra","Mntomaxret","Bcoadep","Ccadep","Imprchqcf","Cldescp","Electro","Noaplirc","Arqtot","Valorretef","Blomoddes","Valoracred","Modifecha" ) values ( <<"'" + this.ConvertirDateSql( lxXvalFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalSmodifw ) + "'" >>, <<lxXvalTipagrupub >>, <<lxXvalTimestamp >>, <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClnom ) + "'" >>, <<lxXvalModoredon >>, <<"'" + this.FormatearTextoSql( lxXvalCtabanc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalPrestador ) + "'" >>, <<lxXvalClcfi >>, <<"'" + this.FormatearTextoSql( lxXvalRedondeo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClsmonet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClclas ) + "'" >>, <<iif( lxXvalClvisualiz, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalOpetar ) + "'" >>, <<iif( lxXvalRetiraefec, 1, 0 ) >>, <<lxXvalEqepson >>, <<"'" + this.FormatearTextoSql( lxXvalClgrup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalVallince ) + "'" >>, <<lxXvalClrecargo >>, <<iif( lxXvalPervuelto, 1, 0 ) >>, <<lxXvalEqibm >>, <<"'" + this.FormatearTextoSql( lxXvalTipotarj ) + "'" >>, <<lxXvalIdcaja >>, <<"'" + this.FormatearTextoSql( lxXvalFactelec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalPaguesea ) + "'" >>, <<iif( lxXvalPersocomp, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalLeyenda ) + "'" >>, <<iif( lxXvalNoarrastra, 1, 0 ) >>, <<lxXvalMntomaxret >>, <<"'" + this.FormatearTextoSql( lxXvalBcoadep ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalCcadep ) + "'" >>, <<iif( lxXvalImprchqcf, 1, 0 ) >>, <<lxXvalCldescp >>, <<iif( lxXvalElectro, 1, 0 ) >>, <<iif( lxXvalNoaplirc, 1, 0 ) >>, <<iif( lxXvalArqtot, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalValorretef ) + "'" >>, <<iif( lxXvalBlomoddes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalValoracred ) + "'" >>, <<iif( lxXvalModifecha, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePlanes
				if this.oEntidad.DetallePlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxMontodesde = loItem.Montodesde
					lxTipodemonto = loItem.Tipodemonto
					lxRecargo = loItem.Recargo
					lxDescuento = loItem.Descuento
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEDET("NROITEM","Cod","cuotas","MontoDesde","TipoMonto","recargo","descuento","canttiempo","modotiempo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxCuotas>>, <<lxMontodesde>>, <<"'" + this.FormatearTextoSql( lxTipodemonto ) + "'">>, <<lxRecargo>>, <<lxDescuento>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleAcreditacionPlanes
				if this.oEntidad.DetalleAcreditacionPlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEACREDET("NROITEM","Cod","cuotas","canttiempo","modotiempo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxCuotas>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubVAL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxXvalTimestamp
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
			local  lxXvalFecimpo, lxXvalFectrans, lxXvalFmodifw, lxXvalFecexpo, lxXvalFaltafw, lxXvalHoraimpo, lxXvalHoraexpo, lxXvalBdaltafw, lxXvalHaltafw, lxXvalHmodifw, lxXvalEsttrans, lxXvalBdmodifw, lxXvalSaltafw, lxXvalZadsfw, lxXvalVmodifw, lxXvalUmodifw, lxXvalValtafw, lxXvalUaltafw, lxXvalSmodifw, lxXvalTipagrupub, lxXvalTimestamp, lxXvalClcod, lxXvalClnom, lxXvalModoredon, lxXvalCtabanc, lxXvalPrestador, lxXvalClcfi, lxXvalRedondeo, lxXvalClsmonet, lxXvalClclas, lxXvalClvisualiz, lxXvalOpetar, lxXvalRetiraefec, lxXvalEqepson, lxXvalClgrup, lxXvalClobs, lxXvalVallince, lxXvalClrecargo, lxXvalPervuelto, lxXvalEqibm, lxXvalTipotarj, lxXvalIdcaja, lxXvalFactelec, lxXvalPaguesea, lxXvalPersocomp, lxXvalLeyenda, lxXvalNoarrastra, lxXvalMntomaxret, lxXvalBcoadep, lxXvalCcadep, lxXvalImprchqcf, lxXvalCldescp, lxXvalElectro, lxXvalNoaplirc, lxXvalArqtot, lxXvalValorretef, lxXvalBlomoddes, lxXvalValoracred, lxXvalModifecha
				lxXvalFecimpo =  .Fechaimpo			lxXvalFectrans =  .Fechatransferencia			lxXvalFmodifw =  .Fechamodificacionfw			lxXvalFecexpo =  .Fechaexpo			lxXvalFaltafw =  .Fechaaltafw			lxXvalHoraimpo =  .Horaimpo			lxXvalHoraexpo =  .Horaexpo			lxXvalBdaltafw =  .Basededatosaltafw			lxXvalHaltafw =  .Horaaltafw			lxXvalHmodifw =  .Horamodificacionfw			lxXvalEsttrans =  .Estadotransferencia			lxXvalBdmodifw =  .Basededatosmodificacionfw			lxXvalSaltafw =  .Seriealtafw			lxXvalZadsfw =  .Zadsfw			lxXvalVmodifw =  .Versionmodificacionfw			lxXvalUmodifw =  .Usuariomodificacionfw			lxXvalValtafw =  .Versionaltafw			lxXvalUaltafw =  .Usuarioaltafw			lxXvalSmodifw =  .Seriemodificacionfw			lxXvalTipagrupub =  .Tipoagrupamientopublicaciones			lxXvalTimestamp = goLibrerias.ObtenerTimestamp()			lxXvalClcod =  .Codigo			lxXvalClnom =  .Descripcion			lxXvalModoredon =  .Modoredondeo			lxXvalCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvalPrestador =  .Prestador			lxXvalClcfi =  .Tipo			lxXvalRedondeo =  upper( .Redondeo_PK ) 			lxXvalClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvalClclas =  upper( .Clasificacion_PK ) 			lxXvalClvisualiz =  .Visualizarencaja			lxXvalOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvalRetiraefec =  .Habilitarretiroefectivo			lxXvalEqepson =  .Equivcfepson			lxXvalClgrup =  upper( .Grupo_PK ) 			lxXvalClobs =  .Observacion			lxXvalVallince =  .Valoreslince			lxXvalClrecargo =  .Recargo			lxXvalPervuelto =  .Permitevuelto			lxXvalEqibm =  .Equivcfibm			lxXvalTipotarj =  .Tipotarjeta			lxXvalIdcaja =  .Caja_PK 			lxXvalFactelec =  .Facturaelectronica			lxXvalPaguesea =  .Paguesea			lxXvalPersocomp =  .Personalizarcomprobante			lxXvalLeyenda =  .Leyenda			lxXvalNoarrastra =  .Arrastrasaldo			lxXvalMntomaxret =  .Montomaximoderetiro			lxXvalBcoadep =  upper( .BcoADep_PK ) 			lxXvalCcadep =  .Ctacteadep			lxXvalImprchqcf =  .Imprimechequecfiscal			lxXvalCldescp =  .Descuento			lxXvalElectro =  .Chequeelectronico			lxXvalNoaplirc =  .Noaplicarenrecibos			lxXvalArqtot =  .Arqueoportotales			lxXvalValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvalBlomoddes =  .Bloqueamodificaciondescripcion			lxXvalValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvalModifecha =  .Permitemodificarfecha
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
				update ZooLogic.XVAL set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxXvalFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxXvalFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxXvalFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxXvalFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxXvalFaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxXvalHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxXvalHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxXvalBdaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxXvalHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxXvalHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxXvalEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxXvalBdmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxXvalSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxXvalZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxXvalVmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxXvalUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxXvalValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxXvalUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxXvalSmodifw ) + "'">>,"Tipagrupub" = <<lxXvalTipagrupub>>,"Timestamp" = <<lxXvalTimestamp>>,"Clcod" = <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'">>,"Clnom" = <<"'" + this.FormatearTextoSql( lxXvalClnom ) + "'">>,"Modoredon" = <<lxXvalModoredon>>,"Ctabanc" = <<"'" + this.FormatearTextoSql( lxXvalCtabanc ) + "'">>,"Prestador" = <<"'" + this.FormatearTextoSql( lxXvalPrestador ) + "'">>,"Clcfi" = <<lxXvalClcfi>>,"Redondeo" = <<"'" + this.FormatearTextoSql( lxXvalRedondeo ) + "'">>,"Clsmonet" = <<"'" + this.FormatearTextoSql( lxXvalClsmonet ) + "'">>,"Clclas" = <<"'" + this.FormatearTextoSql( lxXvalClclas ) + "'">>,"Clvisualiz" = <<iif( lxXvalClvisualiz, 1, 0 )>>,"Opetar" = <<"'" + this.FormatearTextoSql( lxXvalOpetar ) + "'">>,"Retiraefec" = <<iif( lxXvalRetiraefec, 1, 0 )>>,"Eqepson" = <<lxXvalEqepson>>,"Clgrup" = <<"'" + this.FormatearTextoSql( lxXvalClgrup ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxXvalClobs ) + "'">>,"Vallince" = <<"'" + this.FormatearTextoSql( lxXvalVallince ) + "'">>,"Clrecargo" = <<lxXvalClrecargo>>,"Pervuelto" = <<iif( lxXvalPervuelto, 1, 0 )>>,"Eqibm" = <<lxXvalEqibm>>,"Tipotarj" = <<"'" + this.FormatearTextoSql( lxXvalTipotarj ) + "'">>,"Idcaja" = <<lxXvalIdcaja>>,"Factelec" = <<"'" + this.FormatearTextoSql( lxXvalFactelec ) + "'">>,"Paguesea" = <<"'" + this.FormatearTextoSql( lxXvalPaguesea ) + "'">>,"Persocomp" = <<iif( lxXvalPersocomp, 1, 0 )>>,"Leyenda" = <<"'" + this.FormatearTextoSql( lxXvalLeyenda ) + "'">>,"Noarrastra" = <<iif( lxXvalNoarrastra, 1, 0 )>>,"Mntomaxret" = <<lxXvalMntomaxret>>,"Bcoadep" = <<"'" + this.FormatearTextoSql( lxXvalBcoadep ) + "'">>,"Ccadep" = <<"'" + this.FormatearTextoSql( lxXvalCcadep ) + "'">>,"Imprchqcf" = <<iif( lxXvalImprchqcf, 1, 0 )>>,"Cldescp" = <<lxXvalCldescp>>,"Electro" = <<iif( lxXvalElectro, 1, 0 )>>,"Noaplirc" = <<iif( lxXvalNoaplirc, 1, 0 )>>,"Arqtot" = <<iif( lxXvalArqtot, 1, 0 )>>,"Valorretef" = <<"'" + this.FormatearTextoSql( lxXvalValorretef ) + "'">>,"Blomoddes" = <<iif( lxXvalBlomoddes, 1, 0 )>>,"Valoracred" = <<"'" + this.FormatearTextoSql( lxXvalValoracred ) + "'">>,"Modifecha" = <<iif( lxXvalModifecha, 1, 0 )>> where "Clcod" = <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'">> and  XVAL.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEACREDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubVAL where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePlanes
				if this.oEntidad.DetallePlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxMontodesde = loItem.Montodesde
					lxTipodemonto = loItem.Tipodemonto
					lxRecargo = loItem.Recargo
					lxDescuento = loItem.Descuento
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEDET("NROITEM","Cod","cuotas","MontoDesde","TipoMonto","recargo","descuento","canttiempo","modotiempo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxCuotas>>, <<lxMontodesde>>, <<"'" + this.FormatearTextoSql( lxTipodemonto ) + "'">>, <<lxRecargo>>, <<lxDescuento>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleAcreditacionPlanes
				if this.oEntidad.DetalleAcreditacionPlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEACREDET("NROITEM","Cod","cuotas","canttiempo","modotiempo" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxCuotas>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubVAL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxXvalTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.XVAL where " + this.ConvertirFuncionesSql( " XVAL.CLCOD != ''" ) )
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
			Local lxXvalClcod
			lxXvalClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVAL where "Clcod" = <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'">> and  XVAL.CLCOD != ''
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )

			if reccount( 'c_VALOR' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVAL where Codigo = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxXvalClcod as Variant
		llRetorno = .t.
		lxXvalClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.XVAL where "Clcod" = <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'">> and  XVAL.CLCOD != ''
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVAL where  XVAL.CLCOD != '' order by CLCOD
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVAL where Codigo = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVAL where  funciones.padr( CLCOD, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  XVAL.CLCOD != '' order by CLCOD
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVAL where Codigo = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVAL where  funciones.padr( CLCOD, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  XVAL.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVAL where Codigo = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVAL where  XVAL.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle" from ZooLogic.AgruPubVAL where Codigo = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_AgruPubliDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_AgruPubliDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_AgruPubliDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Horaimpo,Horaexpo,Bdaltafw,Haltafw,Hmodifw,Esttrans" + ;
",Bdmodifw,Saltafw,Zadsfw,Vmodifw,Umodifw,Valtafw,Ualtafw,Smodifw,Tipagrupub,Timestamp,Clcod,Clnom,Mo" + ;
"doredon,Ctabanc,Prestador,Clcfi,Redondeo,Clsmonet,Clclas,Clvisualiz,Opetar,Retiraefec,Eqepson,Clgrup" + ;
",Clobs,Vallince,Clrecargo,Pervuelto,Eqibm,Tipotarj,Idcaja,Factelec,Paguesea,Persocomp,Leyenda,Noarra" + ;
"stra,Mntomaxret,Bcoadep,Ccadep,Imprchqcf,Cldescp,Electro,Noaplirc,Arqtot,Valorretef,Blomoddes,Valora" + ;
"cred,Modifecha" + ;
" from ZooLogic.XVAL where  XVAL.CLCOD != '' and " + lcFiltro )
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
			local  lxXvalFecimpo, lxXvalFectrans, lxXvalFmodifw, lxXvalFecexpo, lxXvalFaltafw, lxXvalHoraimpo, lxXvalHoraexpo, lxXvalBdaltafw, lxXvalHaltafw, lxXvalHmodifw, lxXvalEsttrans, lxXvalBdmodifw, lxXvalSaltafw, lxXvalZadsfw, lxXvalVmodifw, lxXvalUmodifw, lxXvalValtafw, lxXvalUaltafw, lxXvalSmodifw, lxXvalTipagrupub, lxXvalTimestamp, lxXvalClcod, lxXvalClnom, lxXvalModoredon, lxXvalCtabanc, lxXvalPrestador, lxXvalClcfi, lxXvalRedondeo, lxXvalClsmonet, lxXvalClclas, lxXvalClvisualiz, lxXvalOpetar, lxXvalRetiraefec, lxXvalEqepson, lxXvalClgrup, lxXvalClobs, lxXvalVallince, lxXvalClrecargo, lxXvalPervuelto, lxXvalEqibm, lxXvalTipotarj, lxXvalIdcaja, lxXvalFactelec, lxXvalPaguesea, lxXvalPersocomp, lxXvalLeyenda, lxXvalNoarrastra, lxXvalMntomaxret, lxXvalBcoadep, lxXvalCcadep, lxXvalImprchqcf, lxXvalCldescp, lxXvalElectro, lxXvalNoaplirc, lxXvalArqtot, lxXvalValorretef, lxXvalBlomoddes, lxXvalValoracred, lxXvalModifecha
				lxXvalFecimpo = ctod( '  /  /    ' )			lxXvalFectrans = ctod( '  /  /    ' )			lxXvalFmodifw = ctod( '  /  /    ' )			lxXvalFecexpo = ctod( '  /  /    ' )			lxXvalFaltafw = ctod( '  /  /    ' )			lxXvalHoraimpo = []			lxXvalHoraexpo = []			lxXvalBdaltafw = []			lxXvalHaltafw = []			lxXvalHmodifw = []			lxXvalEsttrans = []			lxXvalBdmodifw = []			lxXvalSaltafw = []			lxXvalZadsfw = []			lxXvalVmodifw = []			lxXvalUmodifw = []			lxXvalValtafw = []			lxXvalUaltafw = []			lxXvalSmodifw = []			lxXvalTipagrupub = 0			lxXvalTimestamp = goLibrerias.ObtenerTimestamp()			lxXvalClcod = []			lxXvalClnom = []			lxXvalModoredon = 0			lxXvalCtabanc = []			lxXvalPrestador = []			lxXvalClcfi = 0			lxXvalRedondeo = []			lxXvalClsmonet = []			lxXvalClclas = []			lxXvalClvisualiz = .F.			lxXvalOpetar = []			lxXvalRetiraefec = .F.			lxXvalEqepson = 0			lxXvalClgrup = []			lxXvalClobs = []			lxXvalVallince = []			lxXvalClrecargo = 0			lxXvalPervuelto = .F.			lxXvalEqibm = 0			lxXvalTipotarj = []			lxXvalIdcaja = 0			lxXvalFactelec = []			lxXvalPaguesea = []			lxXvalPersocomp = .F.			lxXvalLeyenda = []			lxXvalNoarrastra = .F.			lxXvalMntomaxret = 0			lxXvalBcoadep = []			lxXvalCcadep = []			lxXvalImprchqcf = .F.			lxXvalCldescp = 0			lxXvalElectro = .F.			lxXvalNoaplirc = .F.			lxXvalArqtot = .F.			lxXvalValorretef = []			lxXvalBlomoddes = .F.			lxXvalValoracred = []			lxXvalModifecha = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEACREDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.AgruPubVAL where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.XVAL where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'XVAL' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CLCOD = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CLCOD, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  XVAL.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'XVAL', '', tnTope )
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
	Function ObtenerDatosDetalleDetallePlanes( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TARJEDET.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetallePlanes( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TARJEDET', 'DetallePlanes', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetallePlanes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetallePlanes( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleDetalleAcreditacionPlanes( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  TARJEACREDET.COD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleDetalleAcreditacionPlanes( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TARJEACREDET', 'DetalleAcreditacionPlanes', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleDetalleAcreditacionPlanes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleDetalleAcreditacionPlanes( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAgruPubliDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  AGRUPUBVAL.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Agrup" as "Agrupamiento", "Agrupdes" as "Agrupamientodetalle"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAgruPubliDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'AgruPubVAL', 'AgruPubliDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAgruPubliDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'TIPOAGRUPAMIENTOPUBLICACIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPAGRUPUB AS TIPOAGRUPAMIENTOPUBLICACIONES'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS DESCRIPCION'
				Case lcAtributo == 'MODOREDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODOREDON AS MODOREDONDEO'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANC AS CUENTABANCARIA'
				Case lcAtributo == 'PRESTADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRESTADOR AS PRESTADOR'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS TIPO'
				Case lcAtributo == 'REDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDONDEO AS REDONDEO'
				Case lcAtributo == 'SIMBOLOMONETARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSMONET AS SIMBOLOMONETARIO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLAS AS CLASIFICACION'
				Case lcAtributo == 'VISUALIZARENCAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVISUALIZ AS VISUALIZARENCAJA'
				Case lcAtributo == 'OPERADORATARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPETAR AS OPERADORATARJETA'
				Case lcAtributo == 'HABILITARRETIROEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RETIRAEFEC AS HABILITARRETIROEFECTIVO'
				Case lcAtributo == 'EQUIVCFEPSON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQEPSON AS EQUIVCFEPSON'
				Case lcAtributo == 'GRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLGRUP AS GRUPO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'VALORESLINCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALLINCE AS VALORESLINCE'
				Case lcAtributo == 'RECARGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLRECARGO AS RECARGO'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'EQUIVCFIBM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQIBM AS EQUIVCFIBM'
				Case lcAtributo == 'TIPOTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOTARJ AS TIPOTARJETA'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'FACTURAELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTELEC AS FACTURAELECTRONICA'
				Case lcAtributo == 'PAGUESEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGUESEA AS PAGUESEA'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSOCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'LEYENDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LEYENDA AS LEYENDA'
				Case lcAtributo == 'ARRASTRASALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOARRASTRA AS ARRASTRASALDO'
				Case lcAtributo == 'MONTOMAXIMODERETIRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTOMAXRET AS MONTOMAXIMODERETIRO'
				Case lcAtributo == 'BCOADEP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BCOADEP AS BCOADEP'
				Case lcAtributo == 'CTACTEADEP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCADEP AS CTACTEADEP'
				Case lcAtributo == 'IMPRIMECHEQUECFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPRCHQCF AS IMPRIMECHEQUECFISCAL'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDESCP AS DESCUENTO'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'NOAPLICARENRECIBOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOAPLIRC AS NOAPLICARENRECIBOS'
				Case lcAtributo == 'ARQUEOPORTOTALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARQTOT AS ARQUEOPORTOTALES'
				Case lcAtributo == 'VALORPARARETIRODEEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORRETEF AS VALORPARARETIRODEEFECTIVO'
				Case lcAtributo == 'BLOQUEAMODIFICACIONDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOMODDES AS BLOQUEAMODIFICACIONDESCRIPCION'
				Case lcAtributo == 'VALORDEACREDITACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORACRED AS VALORDEACREDITACION'
				Case lcAtributo == 'PERMITEMODIFICARFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODIFECHA AS PERMITEMODIFICARFECHA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetallePlanes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'CUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUOTAS AS CUOTAS'
				Case lcAtributo == 'MONTODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTODESDE AS MONTODESDE'
				Case lcAtributo == 'TIPODEMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOMONTO AS TIPODEMONTO'
				Case lcAtributo == 'RECARGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECARGO AS RECARGO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCUENTO AS DESCUENTO'
				Case lcAtributo == 'CANTIDADDEDIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTTIEMPO AS CANTIDADDEDIAS'
				Case lcAtributo == 'MODO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODOTIEMPO AS MODO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleDetalleAcreditacionPlanes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COD AS CODIGO'
				Case lcAtributo == 'CUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUOTAS AS CUOTAS'
				Case lcAtributo == 'CANTIDADDEDIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTTIEMPO AS CANTIDADDEDIAS'
				Case lcAtributo == 'MODO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODOTIEMPO AS MODO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAgruPubliDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'AGRUPAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUP AS AGRUPAMIENTO'
				Case lcAtributo == 'AGRUPAMIENTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AGRUPDES AS AGRUPAMIENTODETALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOAGRUPAMIENTOPUBLICACIONES'
				lcCampo = 'TIPAGRUPUB'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'MODOREDONDEO'
				lcCampo = 'MODOREDON'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CTABANC'
			Case upper( alltrim( tcAtributo ) ) == 'PRESTADOR'
				lcCampo = 'PRESTADOR'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEO'
				lcCampo = 'REDONDEO'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIO'
				lcCampo = 'CLSMONET'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLCLAS'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENCAJA'
				lcCampo = 'CLVISUALIZ'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORATARJETA'
				lcCampo = 'OPETAR'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITARRETIROEFECTIVO'
				lcCampo = 'RETIRAEFEC'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVCFEPSON'
				lcCampo = 'EQEPSON'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPO'
				lcCampo = 'CLGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'VALORESLINCE'
				lcCampo = 'VALLINCE'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGO'
				lcCampo = 'CLRECARGO'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVCFIBM'
				lcCampo = 'EQIBM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOTARJETA'
				lcCampo = 'TIPOTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAELECTRONICA'
				lcCampo = 'FACTELEC'
			Case upper( alltrim( tcAtributo ) ) == 'PAGUESEA'
				lcCampo = 'PAGUESEA'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LEYENDA'
				lcCampo = 'LEYENDA'
			Case upper( alltrim( tcAtributo ) ) == 'ARRASTRASALDO'
				lcCampo = 'NOARRASTRA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOMAXIMODERETIRO'
				lcCampo = 'MNTOMAXRET'
			Case upper( alltrim( tcAtributo ) ) == 'BCOADEP'
				lcCampo = 'BCOADEP'
			Case upper( alltrim( tcAtributo ) ) == 'CTACTEADEP'
				lcCampo = 'CCADEP'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMECHEQUECFISCAL'
				lcCampo = 'IMPRCHQCF'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'CLDESCP'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'ELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'NOAPLICARENRECIBOS'
				lcCampo = 'NOAPLIRC'
			Case upper( alltrim( tcAtributo ) ) == 'ARQUEOPORTOTALES'
				lcCampo = 'ARQTOT'
			Case upper( alltrim( tcAtributo ) ) == 'VALORPARARETIRODEEFECTIVO'
				lcCampo = 'VALORRETEF'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEAMODIFICACIONDESCRIPCION'
				lcCampo = 'BLOMODDES'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDEACREDITACION'
				lcCampo = 'VALORACRED'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEMODIFICARFECHA'
				lcCampo = 'MODIFECHA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetallePlanes( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'CUOTAS'
				lcCampo = 'CUOTAS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESDE'
				lcCampo = 'MONTODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEMONTO'
				lcCampo = 'TIPOMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGO'
				lcCampo = 'RECARGO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'DESCUENTO'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADDEDIAS'
				lcCampo = 'CANTTIEMPO'
			Case upper( alltrim( tcAtributo ) ) == 'MODO'
				lcCampo = 'MODOTIEMPO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleDetalleAcreditacionPlanes( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'COD'
			Case upper( alltrim( tcAtributo ) ) == 'CUOTAS'
				lcCampo = 'CUOTAS'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADDEDIAS'
				lcCampo = 'CANTTIEMPO'
			Case upper( alltrim( tcAtributo ) ) == 'MODO'
				lcCampo = 'MODOTIEMPO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAgruPubliDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTO'
				lcCampo = 'AGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'AGRUPAMIENTODETALLE'
				lcCampo = 'AGRUPDES'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEPLANES'
			lcRetorno = 'TARJEDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLEACREDITACIONPLANES'
			lcRetorno = 'TARJEACREDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'AGRUPUBLIDETALLE'
			lcRetorno = 'AGRUPUBVAL'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxXvalFecimpo, lxXvalFectrans, lxXvalFmodifw, lxXvalFecexpo, lxXvalFaltafw, lxXvalHoraimpo, lxXvalHoraexpo, lxXvalBdaltafw, lxXvalHaltafw, lxXvalHmodifw, lxXvalEsttrans, lxXvalBdmodifw, lxXvalSaltafw, lxXvalZadsfw, lxXvalVmodifw, lxXvalUmodifw, lxXvalValtafw, lxXvalUaltafw, lxXvalSmodifw, lxXvalTipagrupub, lxXvalTimestamp, lxXvalClcod, lxXvalClnom, lxXvalModoredon, lxXvalCtabanc, lxXvalPrestador, lxXvalClcfi, lxXvalRedondeo, lxXvalClsmonet, lxXvalClclas, lxXvalClvisualiz, lxXvalOpetar, lxXvalRetiraefec, lxXvalEqepson, lxXvalClgrup, lxXvalClobs, lxXvalVallince, lxXvalClrecargo, lxXvalPervuelto, lxXvalEqibm, lxXvalTipotarj, lxXvalIdcaja, lxXvalFactelec, lxXvalPaguesea, lxXvalPersocomp, lxXvalLeyenda, lxXvalNoarrastra, lxXvalMntomaxret, lxXvalBcoadep, lxXvalCcadep, lxXvalImprchqcf, lxXvalCldescp, lxXvalElectro, lxXvalNoaplirc, lxXvalArqtot, lxXvalValorretef, lxXvalBlomoddes, lxXvalValoracred, lxXvalModifecha
				lxXvalFecimpo =  .Fechaimpo			lxXvalFectrans =  .Fechatransferencia			lxXvalFmodifw =  .Fechamodificacionfw			lxXvalFecexpo =  .Fechaexpo			lxXvalFaltafw =  .Fechaaltafw			lxXvalHoraimpo =  .Horaimpo			lxXvalHoraexpo =  .Horaexpo			lxXvalBdaltafw =  .Basededatosaltafw			lxXvalHaltafw =  .Horaaltafw			lxXvalHmodifw =  .Horamodificacionfw			lxXvalEsttrans =  .Estadotransferencia			lxXvalBdmodifw =  .Basededatosmodificacionfw			lxXvalSaltafw =  .Seriealtafw			lxXvalZadsfw =  .Zadsfw			lxXvalVmodifw =  .Versionmodificacionfw			lxXvalUmodifw =  .Usuariomodificacionfw			lxXvalValtafw =  .Versionaltafw			lxXvalUaltafw =  .Usuarioaltafw			lxXvalSmodifw =  .Seriemodificacionfw			lxXvalTipagrupub =  .Tipoagrupamientopublicaciones			lxXvalTimestamp = goLibrerias.ObtenerTimestamp()			lxXvalClcod =  .Codigo			lxXvalClnom =  .Descripcion			lxXvalModoredon =  .Modoredondeo			lxXvalCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvalPrestador =  .Prestador			lxXvalClcfi =  .Tipo			lxXvalRedondeo =  upper( .Redondeo_PK ) 			lxXvalClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvalClclas =  upper( .Clasificacion_PK ) 			lxXvalClvisualiz =  .Visualizarencaja			lxXvalOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvalRetiraefec =  .Habilitarretiroefectivo			lxXvalEqepson =  .Equivcfepson			lxXvalClgrup =  upper( .Grupo_PK ) 			lxXvalClobs =  .Observacion			lxXvalVallince =  .Valoreslince			lxXvalClrecargo =  .Recargo			lxXvalPervuelto =  .Permitevuelto			lxXvalEqibm =  .Equivcfibm			lxXvalTipotarj =  .Tipotarjeta			lxXvalIdcaja =  .Caja_PK 			lxXvalFactelec =  .Facturaelectronica			lxXvalPaguesea =  .Paguesea			lxXvalPersocomp =  .Personalizarcomprobante			lxXvalLeyenda =  .Leyenda			lxXvalNoarrastra =  .Arrastrasaldo			lxXvalMntomaxret =  .Montomaximoderetiro			lxXvalBcoadep =  upper( .BcoADep_PK ) 			lxXvalCcadep =  .Ctacteadep			lxXvalImprchqcf =  .Imprimechequecfiscal			lxXvalCldescp =  .Descuento			lxXvalElectro =  .Chequeelectronico			lxXvalNoaplirc =  .Noaplicarenrecibos			lxXvalArqtot =  .Arqueoportotales			lxXvalValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvalBlomoddes =  .Bloqueamodificaciondescripcion			lxXvalValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvalModifecha =  .Permitemodificarfecha
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.XVAL ( "Fecimpo","Fectrans","Fmodifw","Fecexpo","Faltafw","Horaimpo","Horaexpo","Bdaltafw","Haltafw","Hmodifw","Esttrans","Bdmodifw","Saltafw","Zadsfw","Vmodifw","Umodifw","Valtafw","Ualtafw","Smodifw","Tipagrupub","Timestamp","Clcod","Clnom","Modoredon","Ctabanc","Prestador","Clcfi","Redondeo","Clsmonet","Clclas","Clvisualiz","Opetar","Retiraefec","Eqepson","Clgrup","Clobs","Vallince","Clrecargo","Pervuelto","Eqibm","Tipotarj","Idcaja","Factelec","Paguesea","Persocomp","Leyenda","Noarrastra","Mntomaxret","Bcoadep","Ccadep","Imprchqcf","Cldescp","Electro","Noaplirc","Arqtot","Valorretef","Blomoddes","Valoracred","Modifecha" ) values ( <<"'" + this.ConvertirDateSql( lxXvalFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvalFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalSmodifw ) + "'" >>, <<lxXvalTipagrupub >>, <<lxXvalTimestamp >>, <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClnom ) + "'" >>, <<lxXvalModoredon >>, <<"'" + this.FormatearTextoSql( lxXvalCtabanc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalPrestador ) + "'" >>, <<lxXvalClcfi >>, <<"'" + this.FormatearTextoSql( lxXvalRedondeo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClsmonet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClclas ) + "'" >>, <<iif( lxXvalClvisualiz, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalOpetar ) + "'" >>, <<iif( lxXvalRetiraefec, 1, 0 ) >>, <<lxXvalEqepson >>, <<"'" + this.FormatearTextoSql( lxXvalClgrup ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalClobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalVallince ) + "'" >>, <<lxXvalClrecargo >>, <<iif( lxXvalPervuelto, 1, 0 ) >>, <<lxXvalEqibm >>, <<"'" + this.FormatearTextoSql( lxXvalTipotarj ) + "'" >>, <<lxXvalIdcaja >>, <<"'" + this.FormatearTextoSql( lxXvalFactelec ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalPaguesea ) + "'" >>, <<iif( lxXvalPersocomp, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalLeyenda ) + "'" >>, <<iif( lxXvalNoarrastra, 1, 0 ) >>, <<lxXvalMntomaxret >>, <<"'" + this.FormatearTextoSql( lxXvalBcoadep ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvalCcadep ) + "'" >>, <<iif( lxXvalImprchqcf, 1, 0 ) >>, <<lxXvalCldescp >>, <<iif( lxXvalElectro, 1, 0 ) >>, <<iif( lxXvalNoaplirc, 1, 0 ) >>, <<iif( lxXvalArqtot, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalValorretef ) + "'" >>, <<iif( lxXvalBlomoddes, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvalValoracred ) + "'" >>, <<iif( lxXvalModifecha, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'XVAL' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePlanes
				if this.oEntidad.DetallePlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxMontodesde = loItem.Montodesde
					lxTipodemonto = loItem.Tipodemonto
					lxRecargo = loItem.Recargo
					lxDescuento = loItem.Descuento
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEDET("NROITEM","Cod","cuotas","MontoDesde","TipoMonto","recargo","descuento","canttiempo","modotiempo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxCuotas>>, <<lxMontodesde>>, <<"'" + this.FormatearTextoSql( lxTipodemonto ) + "'">>, <<lxRecargo>>, <<lxDescuento>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleAcreditacionPlanes
				if this.oEntidad.DetalleAcreditacionPlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEACREDET("NROITEM","Cod","cuotas","canttiempo","modotiempo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxCuotas>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubVAL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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
			local  lxXvalFecimpo, lxXvalFectrans, lxXvalFmodifw, lxXvalFecexpo, lxXvalFaltafw, lxXvalHoraimpo, lxXvalHoraexpo, lxXvalBdaltafw, lxXvalHaltafw, lxXvalHmodifw, lxXvalEsttrans, lxXvalBdmodifw, lxXvalSaltafw, lxXvalZadsfw, lxXvalVmodifw, lxXvalUmodifw, lxXvalValtafw, lxXvalUaltafw, lxXvalSmodifw, lxXvalTipagrupub, lxXvalTimestamp, lxXvalClcod, lxXvalClnom, lxXvalModoredon, lxXvalCtabanc, lxXvalPrestador, lxXvalClcfi, lxXvalRedondeo, lxXvalClsmonet, lxXvalClclas, lxXvalClvisualiz, lxXvalOpetar, lxXvalRetiraefec, lxXvalEqepson, lxXvalClgrup, lxXvalClobs, lxXvalVallince, lxXvalClrecargo, lxXvalPervuelto, lxXvalEqibm, lxXvalTipotarj, lxXvalIdcaja, lxXvalFactelec, lxXvalPaguesea, lxXvalPersocomp, lxXvalLeyenda, lxXvalNoarrastra, lxXvalMntomaxret, lxXvalBcoadep, lxXvalCcadep, lxXvalImprchqcf, lxXvalCldescp, lxXvalElectro, lxXvalNoaplirc, lxXvalArqtot, lxXvalValorretef, lxXvalBlomoddes, lxXvalValoracred, lxXvalModifecha
				lxXvalFecimpo =  .Fechaimpo			lxXvalFectrans =  .Fechatransferencia			lxXvalFmodifw =  .Fechamodificacionfw			lxXvalFecexpo =  .Fechaexpo			lxXvalFaltafw =  .Fechaaltafw			lxXvalHoraimpo =  .Horaimpo			lxXvalHoraexpo =  .Horaexpo			lxXvalBdaltafw =  .Basededatosaltafw			lxXvalHaltafw =  .Horaaltafw			lxXvalHmodifw =  .Horamodificacionfw			lxXvalEsttrans =  .Estadotransferencia			lxXvalBdmodifw =  .Basededatosmodificacionfw			lxXvalSaltafw =  .Seriealtafw			lxXvalZadsfw =  .Zadsfw			lxXvalVmodifw =  .Versionmodificacionfw			lxXvalUmodifw =  .Usuariomodificacionfw			lxXvalValtafw =  .Versionaltafw			lxXvalUaltafw =  .Usuarioaltafw			lxXvalSmodifw =  .Seriemodificacionfw			lxXvalTipagrupub =  .Tipoagrupamientopublicaciones			lxXvalTimestamp = goLibrerias.ObtenerTimestamp()			lxXvalClcod =  .Codigo			lxXvalClnom =  .Descripcion			lxXvalModoredon =  .Modoredondeo			lxXvalCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvalPrestador =  .Prestador			lxXvalClcfi =  .Tipo			lxXvalRedondeo =  upper( .Redondeo_PK ) 			lxXvalClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvalClclas =  upper( .Clasificacion_PK ) 			lxXvalClvisualiz =  .Visualizarencaja			lxXvalOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvalRetiraefec =  .Habilitarretiroefectivo			lxXvalEqepson =  .Equivcfepson			lxXvalClgrup =  upper( .Grupo_PK ) 			lxXvalClobs =  .Observacion			lxXvalVallince =  .Valoreslince			lxXvalClrecargo =  .Recargo			lxXvalPervuelto =  .Permitevuelto			lxXvalEqibm =  .Equivcfibm			lxXvalTipotarj =  .Tipotarjeta			lxXvalIdcaja =  .Caja_PK 			lxXvalFactelec =  .Facturaelectronica			lxXvalPaguesea =  .Paguesea			lxXvalPersocomp =  .Personalizarcomprobante			lxXvalLeyenda =  .Leyenda			lxXvalNoarrastra =  .Arrastrasaldo			lxXvalMntomaxret =  .Montomaximoderetiro			lxXvalBcoadep =  upper( .BcoADep_PK ) 			lxXvalCcadep =  .Ctacteadep			lxXvalImprchqcf =  .Imprimechequecfiscal			lxXvalCldescp =  .Descuento			lxXvalElectro =  .Chequeelectronico			lxXvalNoaplirc =  .Noaplicarenrecibos			lxXvalArqtot =  .Arqueoportotales			lxXvalValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvalBlomoddes =  .Bloqueamodificaciondescripcion			lxXvalValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvalModifecha =  .Permitemodificarfecha
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  XVAL.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.XVAL set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxXvalFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxXvalFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxXvalFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxXvalFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxXvalFaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxXvalHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxXvalHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxXvalBdaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxXvalHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxXvalHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxXvalEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxXvalBdmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxXvalSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxXvalZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxXvalVmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxXvalUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxXvalValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxXvalUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxXvalSmodifw ) + "'">>, "Tipagrupub" = <<lxXvalTipagrupub>>, "Timestamp" = <<lxXvalTimestamp>>, "Clcod" = <<"'" + this.FormatearTextoSql( lxXvalClcod ) + "'">>, "Clnom" = <<"'" + this.FormatearTextoSql( lxXvalClnom ) + "'">>, "Modoredon" = <<lxXvalModoredon>>, "Ctabanc" = <<"'" + this.FormatearTextoSql( lxXvalCtabanc ) + "'">>, "Prestador" = <<"'" + this.FormatearTextoSql( lxXvalPrestador ) + "'">>, "Clcfi" = <<lxXvalClcfi>>, "Redondeo" = <<"'" + this.FormatearTextoSql( lxXvalRedondeo ) + "'">>, "Clsmonet" = <<"'" + this.FormatearTextoSql( lxXvalClsmonet ) + "'">>, "Clclas" = <<"'" + this.FormatearTextoSql( lxXvalClclas ) + "'">>, "Clvisualiz" = <<iif( lxXvalClvisualiz, 1, 0 )>>, "Opetar" = <<"'" + this.FormatearTextoSql( lxXvalOpetar ) + "'">>, "Retiraefec" = <<iif( lxXvalRetiraefec, 1, 0 )>>, "Eqepson" = <<lxXvalEqepson>>, "Clgrup" = <<"'" + this.FormatearTextoSql( lxXvalClgrup ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxXvalClobs ) + "'">>, "Vallince" = <<"'" + this.FormatearTextoSql( lxXvalVallince ) + "'">>, "Clrecargo" = <<lxXvalClrecargo>>, "Pervuelto" = <<iif( lxXvalPervuelto, 1, 0 )>>, "Eqibm" = <<lxXvalEqibm>>, "Tipotarj" = <<"'" + this.FormatearTextoSql( lxXvalTipotarj ) + "'">>, "Idcaja" = <<lxXvalIdcaja>>, "Factelec" = <<"'" + this.FormatearTextoSql( lxXvalFactelec ) + "'">>, "Paguesea" = <<"'" + this.FormatearTextoSql( lxXvalPaguesea ) + "'">>, "Persocomp" = <<iif( lxXvalPersocomp, 1, 0 )>>, "Leyenda" = <<"'" + this.FormatearTextoSql( lxXvalLeyenda ) + "'">>, "Noarrastra" = <<iif( lxXvalNoarrastra, 1, 0 )>>, "Mntomaxret" = <<lxXvalMntomaxret>>, "Bcoadep" = <<"'" + this.FormatearTextoSql( lxXvalBcoadep ) + "'">>, "Ccadep" = <<"'" + this.FormatearTextoSql( lxXvalCcadep ) + "'">>, "Imprchqcf" = <<iif( lxXvalImprchqcf, 1, 0 )>>, "Cldescp" = <<lxXvalCldescp>>, "Electro" = <<iif( lxXvalElectro, 1, 0 )>>, "Noaplirc" = <<iif( lxXvalNoaplirc, 1, 0 )>>, "Arqtot" = <<iif( lxXvalArqtot, 1, 0 )>>, "Valorretef" = <<"'" + this.FormatearTextoSql( lxXvalValorretef ) + "'">>, "Blomoddes" = <<iif( lxXvalBlomoddes, 1, 0 )>>, "Valoracred" = <<"'" + this.FormatearTextoSql( lxXvalValoracred ) + "'">>, "Modifecha" = <<iif( lxXvalModifecha, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'XVAL' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.TARJEDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.TARJEACREDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubVAL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetallePlanes
				if this.oEntidad.DetallePlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxMontodesde = loItem.Montodesde
					lxTipodemonto = loItem.Tipodemonto
					lxRecargo = loItem.Recargo
					lxDescuento = loItem.Descuento
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEDET("NROITEM","Cod","cuotas","MontoDesde","TipoMonto","recargo","descuento","canttiempo","modotiempo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxCuotas>>, <<lxMontodesde>>, <<"'" + this.FormatearTextoSql( lxTipodemonto ) + "'">>, <<lxRecargo>>, <<lxDescuento>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.DetalleAcreditacionPlanes
				if this.oEntidad.DetalleAcreditacionPlanes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxCuotas = loItem.Cuotas
					lxCantidaddedias = loItem.Cantidaddedias
					lxModo = loItem.Modo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.TARJEACREDET("NROITEM","Cod","cuotas","canttiempo","modotiempo" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxCuotas>>, <<lxCantidaddedias>>, <<"'" + this.FormatearTextoSql( lxModo ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.AgruPubliDetalle
				if this.oEntidad.AgruPubliDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxAgrupamiento_PK = loItem.Agrupamiento_PK
					lxAgrupamientodetalle = loItem.Agrupamientodetalle
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.AgruPubVAL("NROITEM","Codigo","Agrup","AgrupDes" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxAgrupamiento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAgrupamientodetalle ) + "'">> ) 
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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  XVAL.CLCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.XVAL where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.TARJEDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.TARJEACREDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.AgruPubVAL where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'XVAL' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.XVAL where  XVAL.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.XVAL where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  XVAL.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxXVALCLCLAS as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.XVAL Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					if this.oentidad.lActualizarSoloEquivalenciasDeLince
						local lcCadena as String, lnPos as integer
						lnPos = recno(lcCursor)
						afields( laEst, lcCursor )
						lcCadena = [Replace in &lcCursor ]
						if empty( this.oEntidad.CamposEquivalenciaLince )
							this.oEntidad.CamposEquivalenciaLince = this.oEntidad.ObtenerCamposSegunEquivalencia(@laEst)
						endif 
						lcCadena = lcCadena + this.oEntidad.CamposEquivalenciaLince
						lcCadena = lcCadena + [ for CLCOD= curseek.CLCOD]
						&lcCadena.
						select( lcCursor )
						go lnPos
					endif
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.XVAL set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, tipagrupub = ] + transform( &lcCursor..tipagrupub )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, ModoRedon = ] + transform( &lcCursor..ModoRedon )+ [, CTABANC = ] + "'" + this.FormatearTextoSql( &lcCursor..CTABANC ) + "'"+ [, Prestador = ] + "'" + this.FormatearTextoSql( &lcCursor..Prestador ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, Redondeo = ] + "'" + this.FormatearTextoSql( &lcCursor..Redondeo ) + "'"+ [, CLSMONET = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSMONET ) + "'"+ [, CLCLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'"+ [, ClVisualiz = ] + Transform( iif( &lcCursor..ClVisualiz, 1, 0 ))+ [, opetar = ] + "'" + this.FormatearTextoSql( &lcCursor..opetar ) + "'"+ [, RetiraEfec = ] + Transform( iif( &lcCursor..RetiraEfec, 1, 0 ))+ [, EqEpson = ] + transform( &lcCursor..EqEpson )+ [, CLGRUP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLGRUP ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, vallince = ] + "'" + this.FormatearTextoSql( &lcCursor..vallince ) + "'"+ [, clrecargo = ] + transform( &lcCursor..clrecargo )+ [, pervuelto = ] + Transform( iif( &lcCursor..pervuelto, 1, 0 ))+ [, EqIBM = ] + transform( &lcCursor..EqIBM )+ [, tipotarj = ] + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'"+ [, factelec = ] + "'" + this.FormatearTextoSql( &lcCursor..factelec ) + "'"+ [, Paguesea = ] + "'" + this.FormatearTextoSql( &lcCursor..Paguesea ) + "'"+ [, PersoComp = ] + Transform( iif( &lcCursor..PersoComp, 1, 0 ))+ [, leyenda = ] + "'" + this.FormatearTextoSql( &lcCursor..leyenda ) + "'"+ [, noarrastra = ] + Transform( iif( &lcCursor..noarrastra, 1, 0 ))+ [, MntoMaxRet = ] + transform( &lcCursor..MntoMaxRet )+ [, bcoadep = ] + "'" + this.FormatearTextoSql( &lcCursor..bcoadep ) + "'"+ [, ccadep = ] + "'" + this.FormatearTextoSql( &lcCursor..ccadep ) + "'"+ [, ImprChqCF = ] + Transform( iif( &lcCursor..ImprChqCF, 1, 0 ))+ [, CLDESCP = ] + transform( &lcCursor..CLDESCP )+ [, Electro = ] + Transform( iif( &lcCursor..Electro, 1, 0 ))+ [, NoApliRc = ] + Transform( iif( &lcCursor..NoApliRc, 1, 0 ))+ [, ArqTot = ] + Transform( iif( &lcCursor..ArqTot, 1, 0 ))+ [, ValorRetEf = ] + "'" + this.FormatearTextoSql( &lcCursor..ValorRetEf ) + "'"+ [, BloModDes = ] + Transform( iif( &lcCursor..BloModDes, 1, 0 ))+ [, ValorAcred = ] + "'" + this.FormatearTextoSql( &lcCursor..ValorAcred ) + "'"+ [, MODIFECHA = ] + Transform( iif( &lcCursor..MODIFECHA, 1, 0 )) + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECIMPO, FECTRANS, FMODIFW, FECEXPO, FALTAFW, HORAIMPO, HORAEXPO, BDALTAFW, HALTAFW, HMODIFW, ESTTRANS, BDMODIFW, SALTAFW, ZADSFW, VMODIFW, UMODIFW, VALTAFW, UALTAFW, SMODIFW, tipagrupub, TIMESTAMP, CLCOD, CLNOM, ModoRedon, CTABANC, Prestador, CLCFI, Redondeo, CLSMONET, CLCLAS, ClVisualiz, opetar, RetiraEfec, EqEpson, CLGRUP, CLOBS, vallince, clrecargo, pervuelto, EqIBM, tipotarj, factelec, Paguesea, PersoComp, leyenda, noarrastra, MntoMaxRet, bcoadep, ccadep, ImprChqCF, CLDESCP, Electro, NoApliRc, ArqTot, ValorRetEf, BloModDes, ValorAcred, MODIFECHA
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + transform( &lcCursor..tipagrupub ) + ',' + transform( &lcCursor..TIMESTAMP )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + transform( &lcCursor..ModoRedon ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CTABANC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Prestador ) + "'" + ',' + transform( &lcCursor..CLCFI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Redondeo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSMONET ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'" + ',' + Transform( iif( &lcCursor..ClVisualiz, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..opetar ) + "'" + ',' + Transform( iif( &lcCursor..RetiraEfec, 1, 0 )) + ',' + transform( &lcCursor..EqEpson ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLGRUP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..vallince ) + "'" + ',' + transform( &lcCursor..clrecargo ) + ',' + Transform( iif( &lcCursor..pervuelto, 1, 0 )) + ',' + transform( &lcCursor..EqIBM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..factelec ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Paguesea ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..PersoComp, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..leyenda ) + "'" + ',' + Transform( iif( &lcCursor..noarrastra, 1, 0 )) + ',' + transform( &lcCursor..MntoMaxRet ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..bcoadep ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ccadep ) + "'" + ',' + Transform( iif( &lcCursor..ImprChqCF, 1, 0 )) + ',' + transform( &lcCursor..CLDESCP )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Electro, 1, 0 )) + ',' + Transform( iif( &lcCursor..NoApliRc, 1, 0 )) + ',' + Transform( iif( &lcCursor..ArqTot, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValorRetEf ) + "'" + ',' + Transform( iif( &lcCursor..BloModDes, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValorAcred ) + "'" + ',' + Transform( iif( &lcCursor..MODIFECHA, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.XVAL ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALOR'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CLCOD','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CLCOD')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TARJEDET Where Cod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TARJEACREDET Where Cod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.AgruPubVAL Where Codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPLANDECUOTA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cod in ( select CLCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Cod","cuotas","MontoDesde","TipoMonto","recargo","descuento","canttiempo","modotiempo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.TARJEDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ',' + transform( cDetallesExistentes.cuotas     ) + ',' + transform( cDetallesExistentes.MontoDesde ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoMonto  ) + "'" + ',' + transform( cDetallesExistentes.recargo    ) + ',' + transform( cDetallesExistentes.descuento  ) + ',' + transform( cDetallesExistentes.canttiempo ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.modotiempo ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMACREDITACIONDEPLAN'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Cod in ( select CLCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Cod","cuotas","canttiempo","modotiempo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.TARJEACREDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cod        ) + "'" + ',' + transform( cDetallesExistentes.cuotas     ) + ',' + transform( cDetallesExistentes.canttiempo ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.modotiempo ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAGRUPAPUBLICVAL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CLCOD from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","Agrup","AgrupDes"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.AgruPubVAL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Agrup      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AgrupDes   ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CLCOD C (5) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Código: ' + transform( &tcCursor..CLCOD      )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'VALOR'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VALOR_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'VALOR_CLOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPLANDECUOTA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMACREDITACIONDEPLAN'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAGRUPAPUBLICVAL'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_XVAL')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'VALOR'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CLCOD
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad VALOR. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CLCOD as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CLCOD, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_XVAL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_XVAL
Create Table ZooLogic.TablaTrabajo_XVAL ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"tipagrupub" numeric( 1, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"clcod" char( 5 )  null, 
"clnom" char( 40 )  null, 
"modoredon" numeric( 1, 0 )  null, 
"ctabanc" char( 5 )  null, 
"prestador" char( 25 )  null, 
"clcfi" numeric( 2, 0 )  null, 
"redondeo" char( 10 )  null, 
"clsmonet" char( 10 )  null, 
"clclas" char( 10 )  null, 
"clvisualiz" bit  null, 
"opetar" char( 15 )  null, 
"retiraefec" bit  null, 
"eqepson" numeric( 2, 0 )  null, 
"clgrup" char( 5 )  null, 
"clobs" varchar(max)  null, 
"vallince" char( 254 )  null, 
"clrecargo" numeric( 6, 2 )  null, 
"pervuelto" bit  null, 
"eqibm" numeric( 2, 0 )  null, 
"tipotarj" char( 1 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"factelec" char( 30 )  null, 
"paguesea" char( 50 )  null, 
"persocomp" bit  null, 
"leyenda" char( 50 )  null, 
"noarrastra" bit  null, 
"mntomaxret" numeric( 15, 2 )  null, 
"bcoadep" char( 5 )  null, 
"ccadep" char( 25 )  null, 
"imprchqcf" bit  null, 
"cldescp" numeric( 5, 2 )  null, 
"electro" bit  null, 
"noaplirc" bit  null, 
"arqtot" bit  null, 
"valorretef" char( 5 )  null, 
"blomoddes" bit  null, 
"valoracred" char( 5 )  null, 
"modifecha" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_XVAL' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_XVAL' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'VALOR'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('tipagrupub','tipagrupub')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('modoredon','modoredon')
			.AgregarMapeo('ctabanc','ctabanc')
			.AgregarMapeo('prestador','prestador')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('redondeo','redondeo')
			.AgregarMapeo('clsmonet','clsmonet')
			.AgregarMapeo('clclas','clclas')
			.AgregarMapeo('clvisualiz','clvisualiz')
			.AgregarMapeo('opetar','opetar')
			.AgregarMapeo('retiraefec','retiraefec')
			.AgregarMapeo('eqepson','eqepson')
			.AgregarMapeo('clgrup','clgrup')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('vallince','vallince')
			.AgregarMapeo('clrecargo','clrecargo')
			.AgregarMapeo('pervuelto','pervuelto')
			.AgregarMapeo('eqibm','eqibm')
			.AgregarMapeo('tipotarj','tipotarj')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('factelec','factelec')
			.AgregarMapeo('paguesea','paguesea')
			.AgregarMapeo('persocomp','persocomp')
			.AgregarMapeo('leyenda','leyenda')
			.AgregarMapeo('noarrastra','noarrastra')
			.AgregarMapeo('mntomaxret','mntomaxret')
			.AgregarMapeo('bcoadep','bcoadep')
			.AgregarMapeo('ccadep','ccadep')
			.AgregarMapeo('imprchqcf','imprchqcf')
			.AgregarMapeo('cldescp','cldescp')
			.AgregarMapeo('electro','electro')
			.AgregarMapeo('noaplirc','noaplirc')
			.AgregarMapeo('arqtot','arqtot')
			.AgregarMapeo('valorretef','valorretef')
			.AgregarMapeo('blomoddes','blomoddes')
			.AgregarMapeo('valoracred','valoracred')
			.AgregarMapeo('modifecha','modifecha')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_XVAL'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.TIPAGRUPUB = isnull( d.TIPAGRUPUB, t.TIPAGRUPUB ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.MODOREDON = isnull( d.MODOREDON, t.MODOREDON ),t.CTABANC = isnull( d.CTABANC, t.CTABANC ),t.PRESTADOR = isnull( d.PRESTADOR, t.PRESTADOR ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.REDONDEO = isnull( d.REDONDEO, t.REDONDEO ),t.CLSMONET = isnull( d.CLSMONET, t.CLSMONET ),t.CLCLAS = isnull( d.CLCLAS, t.CLCLAS ),t.CLVISUALIZ = isnull( d.CLVISUALIZ, t.CLVISUALIZ ),t.OPETAR = isnull( d.OPETAR, t.OPETAR ),t.RETIRAEFEC = isnull( d.RETIRAEFEC, t.RETIRAEFEC ),t.EQEPSON = isnull( d.EQEPSON, t.EQEPSON ),t.CLGRUP = isnull( d.CLGRUP, t.CLGRUP ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.VALLINCE = isnull( d.VALLINCE, t.VALLINCE ),t.CLRECARGO = isnull( d.CLRECARGO, t.CLRECARGO ),t.PERVUELTO = isnull( d.PERVUELTO, t.PERVUELTO ),t.EQIBM = isnull( d.EQIBM, t.EQIBM ),t.TIPOTARJ = isnull( d.TIPOTARJ, t.TIPOTARJ ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FACTELEC = isnull( d.FACTELEC, t.FACTELEC ),t.PAGUESEA = isnull( d.PAGUESEA, t.PAGUESEA ),t.PERSOCOMP = isnull( d.PERSOCOMP, t.PERSOCOMP ),t.LEYENDA = isnull( d.LEYENDA, t.LEYENDA ),t.NOARRASTRA = isnull( d.NOARRASTRA, t.NOARRASTRA ),t.MNTOMAXRET = isnull( d.MNTOMAXRET, t.MNTOMAXRET ),t.BCOADEP = isnull( d.BCOADEP, t.BCOADEP ),t.CCADEP = isnull( d.CCADEP, t.CCADEP ),t.IMPRCHQCF = isnull( d.IMPRCHQCF, t.IMPRCHQCF ),t.CLDESCP = isnull( d.CLDESCP, t.CLDESCP ),t.ELECTRO = isnull( d.ELECTRO, t.ELECTRO ),t.NOAPLIRC = isnull( d.NOAPLIRC, t.NOAPLIRC ),t.ARQTOT = isnull( d.ARQTOT, t.ARQTOT ),t.VALORRETEF = isnull( d.VALORRETEF, t.VALORRETEF ),t.BLOMODDES = isnull( d.BLOMODDES, t.BLOMODDES ),t.VALORACRED = isnull( d.VALORACRED, t.VALORACRED ),t.MODIFECHA = isnull( d.MODIFECHA, t.MODIFECHA )
					from ZooLogic.XVAL t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.XVAL(Fecimpo,Fectrans,Fmodifw,Fecexpo,Faltafw,Horaimpo,Horaexpo,Bdaltafw,Haltafw,Hmodifw,Esttrans,Bdmodifw,Saltafw,Zadsfw,Vmodifw,Umodifw,Valtafw,Ualtafw,Smodifw,Tipagrupub,Timestamp,Clcod,Clnom,Modoredon,Ctabanc,Prestador,Clcfi,Redondeo,Clsmonet,Clclas,Clvisualiz,Opetar,Retiraefec,Eqepson,Clgrup,Clobs,Vallince,Clrecargo,Pervuelto,Eqibm,Tipotarj,Idcaja,Factelec,Paguesea,Persocomp,Leyenda,Noarrastra,Mntomaxret,Bcoadep,Ccadep,Imprchqcf,Cldescp,Electro,Noaplirc,Arqtot,Valorretef,Blomoddes,Valoracred,Modifecha)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.TIPAGRUPUB,0),isnull( d.TIMESTAMP,0),isnull( d.CLCOD,''),isnull( d.CLNOM,''),isnull( d.MODOREDON,0),isnull( d.CTABANC,''),isnull( d.PRESTADOR,''),isnull( d.CLCFI,0),isnull( d.REDONDEO,''),isnull( d.CLSMONET,''),isnull( d.CLCLAS,''),isnull( d.CLVISUALIZ,0),isnull( d.OPETAR,''),isnull( d.RETIRAEFEC,0),isnull( d.EQEPSON,0),isnull( d.CLGRUP,''),isnull( d.CLOBS,''),isnull( d.VALLINCE,''),isnull( d.CLRECARGO,0),isnull( d.PERVUELTO,0),isnull( d.EQIBM,0),isnull( d.TIPOTARJ,''),isnull( d.IDCAJA,0),isnull( d.FACTELEC,''),isnull( d.PAGUESEA,''),isnull( d.PERSOCOMP,0),isnull( d.LEYENDA,''),isnull( d.NOARRASTRA,0),isnull( d.MNTOMAXRET,0),isnull( d.BCOADEP,''),isnull( d.CCADEP,''),isnull( d.IMPRCHQCF,0),isnull( d.CLDESCP,0),isnull( d.ELECTRO,0),isnull( d.NOAPLIRC,0),isnull( d.ARQTOT,0),isnull( d.VALORRETEF,''),isnull( d.BLOMODDES,0),isnull( d.VALORACRED,''),isnull( d.MODIFECHA,0)
						From deleted d left join ZooLogic.XVAL pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_TARJEDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_XVAL_TARJEDET
ON ZooLogic.TablaTrabajo_XVAL_TARJEDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COD = isnull( d.COD, t.COD ),
t.CUOTAS = isnull( d.CUOTAS, t.CUOTAS ),
t.MONTODESDE = isnull( d.MONTODESDE, t.MONTODESDE ),
t.TIPOMONTO = isnull( d.TIPOMONTO, t.TIPOMONTO ),
t.RECARGO = isnull( d.RECARGO, t.RECARGO ),
t.DESCUENTO = isnull( d.DESCUENTO, t.DESCUENTO ),
t.CANTTIEMPO = isnull( d.CANTTIEMPO, t.CANTTIEMPO ),
t.MODOTIEMPO = isnull( d.MODOTIEMPO, t.MODOTIEMPO )
from ZooLogic.TARJEDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.TARJEDET
( 
"NROITEM",
"COD",
"CUOTAS",
"MONTODESDE",
"TIPOMONTO",
"RECARGO",
"DESCUENTO",
"CANTTIEMPO",
"MODOTIEMPO"
 )
Select 
d.NROITEM,
d.COD,
d.CUOTAS,
d.MONTODESDE,
d.TIPOMONTO,
d.RECARGO,
d.DESCUENTO,
d.CANTTIEMPO,
d.MODOTIEMPO
From deleted d left join ZooLogic.TARJEDET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_TARJEACREDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_XVAL_TARJEACREDET
ON ZooLogic.TablaTrabajo_XVAL_TARJEACREDET
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COD = isnull( d.COD, t.COD ),
t.CUOTAS = isnull( d.CUOTAS, t.CUOTAS ),
t.CANTTIEMPO = isnull( d.CANTTIEMPO, t.CANTTIEMPO ),
t.MODOTIEMPO = isnull( d.MODOTIEMPO, t.MODOTIEMPO )
from ZooLogic.TARJEACREDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.TARJEACREDET
( 
"NROITEM",
"COD",
"CUOTAS",
"CANTTIEMPO",
"MODOTIEMPO"
 )
Select 
d.NROITEM,
d.COD,
d.CUOTAS,
d.CANTTIEMPO,
d.MODOTIEMPO
From deleted d left join ZooLogic.TARJEACREDET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_AgruPubVAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_XVAL_AgruPubVAL
ON ZooLogic.TablaTrabajo_XVAL_AgruPubVAL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AGRUP = isnull( d.AGRUP, t.AGRUP ),
t.AGRUPDES = isnull( d.AGRUPDES, t.AGRUPDES )
from ZooLogic.AgruPubVAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.AgruPubVAL
( 
"NROITEM",
"CODIGO",
"AGRUP",
"AGRUPDES"
 )
Select 
d.NROITEM,
d.CODIGO,
d.AGRUP,
d.AGRUPDES
From deleted d left join ZooLogic.AgruPubVAL pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_XVAL') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_XVAL
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_VALOR' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaimpo = nvl( c_VALOR.Horaimpo, [] )
					.Horaexpo = nvl( c_VALOR.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_VALOR.Basededatosaltafw, [] )
					.Horaaltafw = nvl( c_VALOR.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_VALOR.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_VALOR.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_VALOR.Basededatosmodificacionfw, [] )
					.Seriealtafw = nvl( c_VALOR.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_VALOR.Versionmodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_VALOR.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_VALOR.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_VALOR.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_VALOR.Seriemodificacionfw, [] )
					.Tipoagrupamientopublicaciones = nvl( c_VALOR.Tipoagrupamientopublicaciones, 0 )
					.Timestamp = nvl( c_VALOR.Timestamp, 0 )
					.Codigo = nvl( c_VALOR.Codigo, [] )
					.Descripcion = nvl( c_VALOR.Descripcion, [] )
					.Modoredondeo = nvl( c_VALOR.Modoredondeo, 0 )
					.Detalleplanes.Limpiar()
					.Detalleplanes.SetearEsNavegacion( .lProcesando )
					.Detalleplanes.Cargar()
					.Detalleacreditacionplanes.Limpiar()
					.Detalleacreditacionplanes.SetearEsNavegacion( .lProcesando )
					.Detalleacreditacionplanes.Cargar()
					.Cuentabancaria_PK =  nvl( c_VALOR.Cuentabancaria, [] )
					.Prestador = nvl( c_VALOR.Prestador, [] )
					if !.lEsSubEntidad
					.Agrupublidetalle.Limpiar()
					.Agrupublidetalle.SetearEsNavegacion( .lProcesando )
					.Agrupublidetalle.Cargar()
					endif
					.Tipo = nvl( c_VALOR.Tipo, 0 )
					.Redondeo_PK =  nvl( c_VALOR.Redondeo, [] )
					.Simbolomonetario_PK =  nvl( c_VALOR.Simbolomonetario, [] )
					.Clasificacion_PK =  nvl( c_VALOR.Clasificacion, [] )
					.Visualizarencaja = nvl( c_VALOR.Visualizarencaja, .F. )
					.Operadoratarjeta_PK =  nvl( c_VALOR.Operadoratarjeta, [] )
					.Habilitarretiroefectivo = nvl( c_VALOR.Habilitarretiroefectivo, .F. )
					.Equivcfepson = nvl( c_VALOR.Equivcfepson, 0 )
					.Grupo_PK =  nvl( c_VALOR.Grupo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Valoreslince = nvl( c_VALOR.Valoreslince, [] )
					.Recargo = nvl( c_VALOR.Recargo, 0 )
					.Permitevuelto = nvl( c_VALOR.Permitevuelto, .F. )
					.Equivcfibm = nvl( c_VALOR.Equivcfibm, 0 )
					.Tipotarjeta = nvl( c_VALOR.Tipotarjeta, [] )
					.Caja_PK =  nvl( c_VALOR.Caja, 0 )
					.Facturaelectronica = nvl( c_VALOR.Facturaelectronica, [] )
					.Paguesea = nvl( c_VALOR.Paguesea, [] )
					.Personalizarcomprobante = nvl( c_VALOR.Personalizarcomprobante, .F. )
					.Leyenda = nvl( c_VALOR.Leyenda, [] )
					.Arrastrasaldo = nvl( c_VALOR.Arrastrasaldo, .F. )
					.Montomaximoderetiro = nvl( c_VALOR.Montomaximoderetiro, 0 )
					.Bcoadep_PK =  nvl( c_VALOR.Bcoadep, [] )
					.Ctacteadep = nvl( c_VALOR.Ctacteadep, [] )
					.Imprimechequecfiscal = nvl( c_VALOR.Imprimechequecfiscal, .F. )
					.Descuento = nvl( c_VALOR.Descuento, 0 )
					.Chequeelectronico = nvl( c_VALOR.Chequeelectronico, .F. )
					.Noaplicarenrecibos = nvl( c_VALOR.Noaplicarenrecibos, .F. )
					.Arqueoportotales = nvl( c_VALOR.Arqueoportotales, .F. )
					.Valorpararetirodeefectivo_PK =  nvl( c_VALOR.Valorpararetirodeefectivo, [] )
					.Bloqueamodificaciondescripcion = nvl( c_VALOR.Bloqueamodificaciondescripcion, .F. )
					.Valordeacreditacion_PK =  nvl( c_VALOR.Valordeacreditacion, [] )
					.Permitemodificarfecha = nvl( c_VALOR.Permitemodificarfecha, .F. )
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
		
		loDetalle = this.oEntidad.DetallePlanes
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

		loDetalle = this.oEntidad.DetalleAcreditacionPlanes
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

		loDetalle = this.oEntidad.AgruPubliDetalle
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
		return c_VALOR.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.XVAL' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CLCOD as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CLCOD from (
							select * 
								from ZooLogic.XVAL 
								Where   XVAL.CLCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "XVAL", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CLCOD"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Tipagrupub" as "Tipoagrupamientopublicaciones", "Timestamp" as "Timestamp", "Clcod" as "Codigo", "Clnom" as "Descripcion", "Modoredon" as "Modoredondeo", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Clcfi" as "Tipo", "Redondeo" as "Redondeo", "Clsmonet" as "Simbolomonetario", "Clclas" as "Clasificacion", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Retiraefec" as "Habilitarretiroefectivo", "Eqepson" as "Equivcfepson", "Clgrup" as "Grupo", "Clobs" as "Observacion", "Vallince" as "Valoreslince", "Clrecargo" as "Recargo", "Pervuelto" as "Permitevuelto", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Idcaja" as "Caja", "Factelec" as "Facturaelectronica", "Paguesea" as "Paguesea", "Persocomp" as "Personalizarcomprobante", "Leyenda" as "Leyenda", "Noarrastra" as "Arrastrasaldo", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Valorretef" as "Valorpararetirodeefectivo", "Blomoddes" as "Bloqueamodificaciondescripcion", "Valoracred" as "Valordeacreditacion", "Modifecha" as "Permitemodificarfecha"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.XVAL 
								Where   XVAL.CLCOD != ''
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
	Tabla = 'XVAL'
	Filtro = " XVAL.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " XVAL.CLCOD != ''"
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
	<row entidad="VALOR                                   " atributo="FECHAIMPO                               " tabla="XVAL           " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHATRANSFERENCIA                      " tabla="XVAL           " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAMODIFICACIONFW                     " tabla="XVAL           " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAEXPO                               " tabla="XVAL           " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAALTAFW                             " tabla="XVAL           " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOENDOSABLE                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo endosable                                                                                                                                                  " dominio="TIPOVALORENDOSABLE            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAIMPO                                " tabla="XVAL           " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAEXPO                                " tabla="XVAL           " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BASEDEDATOSALTAFW                       " tabla="XVAL           " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAALTAFW                              " tabla="XVAL           " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAMODIFICACIONFW                      " tabla="XVAL           " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ESTADOTRANSFERENCIA                     " tabla="XVAL           " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="XVAL           " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SERIEALTAFW                             " tabla="XVAL           " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ZADSFW                                  " tabla="XVAL           " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VERSIONMODIFICACIONFW                   " tabla="XVAL           " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="USUARIOMODIFICACIONFW                   " tabla="XVAL           " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VERSIONALTAFW                           " tabla="XVAL           " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="USUARIOALTAFW                           " tabla="XVAL           " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SERIEMODIFICACIONFW                     " tabla="XVAL           " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOAGRUPAMIENTOPUBLICACIONES           " tabla="XVAL           " campo="TIPAGRUPUB" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIMESTAMP                               " tabla="XVAL           " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CODIGO                                  " tabla="XVAL           " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVAL           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="MODOREDONDEO                            " tabla="XVAL           " campo="MODOREDON " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="400" etiqueta="Aplica a                                                                                                                                                        " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DETALLEPLANES                           " tabla="TARJEDET       " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Planes detalle                                                                                                                                                  " dominio="DETALLEITEMPLANDECUOTA        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DETALLEACREDITACIONPLANES               " tabla="TARJEACREDET   " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Planes detalle acreditación                                                                                                                                     " dominio="DETALLEITEMACREDITACIONDEPLAN " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CUENTABANCARIA                          " tabla="XVAL           " campo="CTABANC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Cuenta bancaria                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PRESTADOR                               " tabla="XVAL           " campo="PRESTADOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Prestador                                                                                                                                                       " dominio="COMBOPRESTADOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="AGRUPUBLIDETALLE                        " tabla="AGRUPUBVAL     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Agrupamientos                                                                                                                                                   " dominio="DETALLEITEMAGRUPAPUBLICVAL    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPO                                    " tabla="XVAL           " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPODEVALORES            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOTARJETAPOINT                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo tarjetas                                                                                                                                                   " dominio="COMBOTIPOTARJETA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="REDONDEO                                " tabla="XVAL           " campo="REDONDEO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REDONDEODEPRECIOS                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Código de redondeo                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SIMBOLOMONETARIO                        " tabla="XVAL           " campo="CLSMONET  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CLASIFICACION                           " tabla="XVAL           " campo="CLCLAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VISUALIZARENCAJA                        " tabla="XVAL           " campo="CLVISUALIZ" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="410" etiqueta="Visualizar en estado de caja                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="OPERADORATARJETA                        " tabla="XVAL           " campo="OPETAR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="OPERADORADETARJETA                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Operadora de la tarjeta                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HABILITARRETIROEFECTIVO                 " tabla="XVAL           " campo="RETIRAEFEC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="414" etiqueta="Habilita retiro de efectivo                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="7" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="EQUIVCFEPSON                            " tabla="XVAL           " campo="EQEPSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Controladores fiscales R.G. 3561/13                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="GRUPO                                   " tabla="XVAL           " campo="CLGRUP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPOVALOR                              " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Totalizar en grupo                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="OBSERVACION                             " tabla="XVAL           " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VALORESLINCE                            " tabla="XVAL           " campo="VALLINCE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Valores Lince                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="RECARGO                                 " tabla="XVAL           " campo="CLRECARGO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PERMITEVUELTO                           " tabla="XVAL           " campo="PERVUELTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="420" etiqueta="Permite vuelto                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="EQUIVCFIBM                              " tabla="XVAL           " campo="EQIBM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Controlador fiscal IBM                                                                                                                                          " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOTARJETA                             " tabla="XVAL           " campo="TIPOTARJ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Tipo tarjeta                                                                                                                                                    " dominio="COMBOTIPOTARJETA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CAJA                                    " tabla="XVAL           " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Caja destino                                                                                                                                                    " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FACTURAELECTRONICA                      " tabla="XVAL           " campo="FACTELEC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Factura electrónica                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PAGUESEA                                " tabla="XVAL           " campo="PAGUESEA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Páguese a                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PERSONALIZARCOMPROBANTE                 " tabla="XVAL           " campo="PERSOCOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="428" etiqueta="Personalizar comprobante                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="LEYENDA                                 " tabla="XVAL           " campo="LEYENDA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Leyenda                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ARRASTRASALDO                           " tabla="XVAL           " campo="NOARRASTRA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="430" etiqueta="Arrastrar saldo al cerrar la caja                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="MONTOMAXIMODERETIRO                     " tabla="XVAL           " campo="MNTOMAXRET" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Monto máximo de retiro                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="7" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BCOADEP                                 " tabla="XVAL           " campo="BCOADEP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cta.Cte.a depositar                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CTACTEADEP                              " tabla="XVAL           " campo="CCADEP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cuenta a depositar                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="IMPRIMECHEQUECFISCAL                    " tabla="XVAL           " campo="IMPRCHQCF " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Imprime cheque C. fiscal                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCUENTO                               " tabla="XVAL           " campo="CLDESCP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Porcentaje de descuento en ventas                                                                                                                               " dominio="DESCUENTOVALOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CHEQUEELECTRONICO                       " tabla="XVAL           " campo="ELECTRO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Cheque electrónico                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="NOAPLICARENRECIBOS                      " tabla="XVAL           " campo="NOAPLIRC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="438" etiqueta="No aplicar en recibos                                                                                                                                           " dominio="DESCUENTOVALOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ARQUEOPORTOTALES                        " tabla="XVAL           " campo="ARQTOT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Arqueo por totales                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VALORPARARETIRODEEFECTIVO               " tabla="XVAL           " campo="VALORRETEF" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Valor para retiro de efectivo                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; xVal.CLCFI = 1 &quot;                                                                                                                                                                                      " grupo="7" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BLOQUEAMODIFICACIONDESCRIPCION          " tabla="XVAL           " campo="BLOMODDES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="444" etiqueta="Salto de campo en descripción                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VALORDEACREDITACION                     " tabla="XVAL           " campo="VALORACRED" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Valor de acreditación                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; xVal.CLCFI = 1 or xVal.CLCFI = 13 &quot;                                                                                                                                                                   " grupo="7" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PERMITEMODIFICARFECHA                   " tabla="XVAL           " campo="MODIFECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="448" etiqueta="Permite modificar la fecha                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On XVAL.CTABANC = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DESCRIPCION                             " tabla="REDO           " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="409" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REDO On XVAL.REDONDEO = REDO.codigo And  REDO.CODIGO != ''                                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On XVAL.CLSMONET = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERADORADETARJETA                      " atributo="DESCRIPCION                             " tabla="OPETAR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Ope.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPETAR On XVAL.OPETAR = OPETAR.Codigo And  OPETAR.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="DESCRIPCION                             " tabla="GRUPOVALOR     " campo="GRUNOM    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Tot.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPOVALOR On XVAL.CLGRUP = GRUPOVALOR.Codigo And  GRUPOVALOR.CODIGO != ''                                                                                                                                                                         " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Caj.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On XVAL.IDCAJA = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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