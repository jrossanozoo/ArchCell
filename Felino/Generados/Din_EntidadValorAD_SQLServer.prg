
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
	cTagClavePk = '_006PK'
	cTablaPrincipal = 'XVALORES'
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
			local  lxXvaloresFaltafw, lxXvaloresFectrans, lxXvaloresFecexpo, lxXvaloresFmodifw, lxXvaloresFecimpo, lxXvaloresClcuit, lxXvaloresCldir, lxXvaloresClcfi, lxXvaloresTimestamp, lxXvaloresClpun1, lxXvaloresClser, lxXvaloresClvporj, lxXvaloresHmodifw, lxXvaloresEsttrans, lxXvaloresBdmodifw, lxXvaloresHoraexpo, lxXvaloresHaltafw, lxXvaloresHoraimpo, lxXvaloresBdaltafw, lxXvaloresValtafw, lxXvaloresCltlf, lxXvaloresVmodifw, lxXvaloresZadsfw, lxXvaloresUmodifw, lxXvaloresSmodifw, lxXvaloresSaltafw, lxXvaloresUaltafw, lxXvaloresClcod, lxXvaloresClobs, lxXvaloresClcobade, lxXvaloresClnom, lxXvaloresCldto, lxXvaloresCn1, lxXvaloresClser2, lxXvaloresCotizar, lxXvaloresCltcmadre, lxXvaloresPervuelto, lxXvaloresClloc, lxXvaloresClfax, lxXvaloresModoredon, lxXvaloresClsmonet, lxXvaloresCtabanc, lxXvaloresPrestador, lxXvaloresIdcaja, lxXvaloresClgrup, lxXvaloresClvdiaini, lxXvaloresCllist, lxXvaloresClcp, lxXvaloresClvdias, lxXvaloresClvcod, lxXvaloresClclas, lxXvaloresClcan4, lxXvaloresClvisualiz, lxXvaloresOpetar, lxXvaloresPersocomp, lxXvaloresEqepson, lxXvaloresNoarrastra, lxXvaloresEqibm, lxXvaloresTipotarj, lxXvaloresFactelec, lxXvaloresRetiraefec, lxXvaloresPaguesea, lxXvaloresLeyenda, lxXvaloresMntomaxret, lxXvaloresBcoadep, lxXvaloresCcadep, lxXvaloresImprchqcf, lxXvaloresValorretef, lxXvaloresCldescp, lxXvaloresElectro, lxXvaloresRedondeo, lxXvaloresValoracred, lxXvaloresNoaplirc, lxXvaloresArqtot, lxXvaloresBlomoddes, lxXvaloresModifecha
				lxXvaloresFaltafw =  .Fechaaltafw			lxXvaloresFectrans =  .Fechatransferencia			lxXvaloresFecexpo =  .Fechaexpo			lxXvaloresFmodifw =  .Fechamodificacionfw			lxXvaloresFecimpo =  .Fechaimpo			lxXvaloresClcuit =  .Cuit			lxXvaloresCldir =  .Direccion			lxXvaloresClcfi =  .Tipo			lxXvaloresTimestamp = goLibrerias.ObtenerTimestamp()			lxXvaloresClpun1 =  .Descuentosobrebruto			lxXvaloresClser =  .Diaspresentacion1			lxXvaloresClvporj =  .Diasacreditacion			lxXvaloresHmodifw =  .Horamodificacionfw			lxXvaloresEsttrans =  .Estadotransferencia			lxXvaloresBdmodifw =  .Basededatosmodificacionfw			lxXvaloresHoraexpo =  .Horaexpo			lxXvaloresHaltafw =  .Horaaltafw			lxXvaloresHoraimpo =  .Horaimpo			lxXvaloresBdaltafw =  .Basededatosaltafw			lxXvaloresValtafw =  .Versionaltafw			lxXvaloresCltlf =  .Telefono			lxXvaloresVmodifw =  .Versionmodificacionfw			lxXvaloresZadsfw =  .Zadsfw			lxXvaloresUmodifw =  .Usuariomodificacionfw			lxXvaloresSmodifw =  .Seriemodificacionfw			lxXvaloresSaltafw =  .Seriealtafw			lxXvaloresUaltafw =  .Usuarioaltafw			lxXvaloresClcod =  .Codigo			lxXvaloresClobs =  .Observacion			lxXvaloresClcobade =  .Cobroadelantado			lxXvaloresClnom =  .Descripcion			lxXvaloresCldto =  .Descuentoadelantado			lxXvaloresCn1 =  .Habiles			lxXvaloresClser2 =  .Diaspresentacion2			lxXvaloresCotizar =  .Pidecotizacion			lxXvaloresCltcmadre =  .Tarjetamadre			lxXvaloresPervuelto =  .Permitevuelto			lxXvaloresClloc =  .Localidad			lxXvaloresClfax =  .Fax			lxXvaloresModoredon =  .Modoredondeo			lxXvaloresClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvaloresCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvaloresPrestador =  .Prestador			lxXvaloresIdcaja =  .Caja_PK 			lxXvaloresClgrup =  upper( .Grupo_PK ) 			lxXvaloresClvdiaini =  .Diasentrecuotas			lxXvaloresCllist =  .Diaspresentacion3			lxXvaloresClcp =  .Codigopostal			lxXvaloresClvdias =  .Diaspresentacion4			lxXvaloresClvcod =  upper( .SeDepositaEnBanco_PK ) 			lxXvaloresClclas =  upper( .Clasificacion_PK ) 			lxXvaloresClcan4 =  .Generacanje			lxXvaloresClvisualiz =  .Visualizarencaja			lxXvaloresOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvaloresPersocomp =  .Personalizarcomprobante			lxXvaloresEqepson =  .Equivcfepson			lxXvaloresNoarrastra =  .Arrastrasaldo			lxXvaloresEqibm =  .Equivcfibm			lxXvaloresTipotarj =  .Tipotarjeta			lxXvaloresFactelec =  .Facturaelectronica			lxXvaloresRetiraefec =  .Habilitarretiroefectivo			lxXvaloresPaguesea =  .Paguesea			lxXvaloresLeyenda =  .Leyenda			lxXvaloresMntomaxret =  .Montomaximoderetiro			lxXvaloresBcoadep =  upper( .BcoADep_PK ) 			lxXvaloresCcadep =  .Ctacteadep			lxXvaloresImprchqcf =  .Imprimechequecfiscal			lxXvaloresValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvaloresCldescp =  .Descuento			lxXvaloresElectro =  .Chequeelectronico			lxXvaloresRedondeo =  upper( .Redondeo_PK ) 			lxXvaloresValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvaloresNoaplirc =  .Noaplicarenrecibos			lxXvaloresArqtot =  .Arqueoportotales			lxXvaloresBlomoddes =  .Bloqueamodificaciondescripcion			lxXvaloresModifecha =  .Permitemodificarfecha
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxXvaloresClcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.XVALORES ( "Faltafw","Fectrans","Fecexpo","Fmodifw","Fecimpo","Clcuit","Cldir","Clcfi","Timestamp","Clpun1","Clser","Clvporj","Hmodifw","Esttrans","Bdmodifw","Horaexpo","Haltafw","Horaimpo","Bdaltafw","Valtafw","Cltlf","Vmodifw","Zadsfw","Umodifw","Smodifw","Saltafw","Ualtafw","Clcod","Clobs","Clcobade","Clnom","Cldto","Cn1","Clser2","Cotizar","Cltcmadre","Pervuelto","Clloc","Clfax","Modoredon","Clsmonet","Ctabanc","Prestador","Idcaja","Clgrup","Clvdiaini","Cllist","Clcp","Clvdias","Clvcod","Clclas","Clcan4","Clvisualiz","Opetar","Persocomp","Eqepson","Noarrastra","Eqibm","Tipotarj","Factelec","Retiraefec","Paguesea","Leyenda","Mntomaxret","Bcoadep","Ccadep","Imprchqcf","Valorretef","Cldescp","Electro","Redondeo","Valoracred","Noaplirc","Arqtot","Blomoddes","Modifecha" ) values ( <<"'" + this.ConvertirDateSql( lxXvaloresFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCldir ) + "'" >>, <<lxXvaloresClcfi >>, <<lxXvaloresTimestamp >>, <<lxXvaloresClpun1 >>, <<lxXvaloresClser >>, <<lxXvaloresClvporj >>, <<"'" + this.FormatearTextoSql( lxXvaloresHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClobs ) + "'" >>, <<lxXvaloresClcobade >>, <<"'" + this.FormatearTextoSql( lxXvaloresClnom ) + "'" >>, <<lxXvaloresCldto >>, <<lxXvaloresCn1 >>, <<lxXvaloresClser2 >>, <<iif( lxXvaloresCotizar, 1, 0 ) >>, <<iif( lxXvaloresCltcmadre, 1, 0 ) >>, <<iif( lxXvaloresPervuelto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClfax ) + "'" >>, <<lxXvaloresModoredon >>, <<"'" + this.FormatearTextoSql( lxXvaloresClsmonet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCtabanc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresPrestador ) + "'" >>, <<lxXvaloresIdcaja >>, <<"'" + this.FormatearTextoSql( lxXvaloresClgrup ) + "'" >>, <<lxXvaloresClvdiaini >>, <<lxXvaloresCllist >>, <<"'" + this.FormatearTextoSql( lxXvaloresClcp ) + "'" >>, <<lxXvaloresClvdias >>, <<"'" + this.FormatearTextoSql( lxXvaloresClvcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClclas ) + "'" >>, <<lxXvaloresClcan4 >>, <<iif( lxXvaloresClvisualiz, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresOpetar ) + "'" >>, <<iif( lxXvaloresPersocomp, 1, 0 ) >>, <<lxXvaloresEqepson >>, <<iif( lxXvaloresNoarrastra, 1, 0 ) >>, <<lxXvaloresEqibm >>, <<"'" + this.FormatearTextoSql( lxXvaloresTipotarj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresFactelec ) + "'" >>, <<iif( lxXvaloresRetiraefec, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresPaguesea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresLeyenda ) + "'" >>, <<lxXvaloresMntomaxret >>, <<"'" + this.FormatearTextoSql( lxXvaloresBcoadep ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCcadep ) + "'" >>, <<iif( lxXvaloresImprchqcf, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresValorretef ) + "'" >>, <<lxXvaloresCldescp >>, <<iif( lxXvaloresElectro, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresRedondeo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresValoracred ) + "'" >>, <<iif( lxXvaloresNoaplirc, 1, 0 ) >>, <<iif( lxXvaloresArqtot, 1, 0 ) >>, <<iif( lxXvaloresBlomoddes, 1, 0 ) >>, <<iif( lxXvaloresModifecha, 1, 0 ) >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


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
		this.oEntidad.Timestamp = lxXvaloresTimestamp
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
			local  lxXvaloresFaltafw, lxXvaloresFectrans, lxXvaloresFecexpo, lxXvaloresFmodifw, lxXvaloresFecimpo, lxXvaloresClcuit, lxXvaloresCldir, lxXvaloresClcfi, lxXvaloresTimestamp, lxXvaloresClpun1, lxXvaloresClser, lxXvaloresClvporj, lxXvaloresHmodifw, lxXvaloresEsttrans, lxXvaloresBdmodifw, lxXvaloresHoraexpo, lxXvaloresHaltafw, lxXvaloresHoraimpo, lxXvaloresBdaltafw, lxXvaloresValtafw, lxXvaloresCltlf, lxXvaloresVmodifw, lxXvaloresZadsfw, lxXvaloresUmodifw, lxXvaloresSmodifw, lxXvaloresSaltafw, lxXvaloresUaltafw, lxXvaloresClcod, lxXvaloresClobs, lxXvaloresClcobade, lxXvaloresClnom, lxXvaloresCldto, lxXvaloresCn1, lxXvaloresClser2, lxXvaloresCotizar, lxXvaloresCltcmadre, lxXvaloresPervuelto, lxXvaloresClloc, lxXvaloresClfax, lxXvaloresModoredon, lxXvaloresClsmonet, lxXvaloresCtabanc, lxXvaloresPrestador, lxXvaloresIdcaja, lxXvaloresClgrup, lxXvaloresClvdiaini, lxXvaloresCllist, lxXvaloresClcp, lxXvaloresClvdias, lxXvaloresClvcod, lxXvaloresClclas, lxXvaloresClcan4, lxXvaloresClvisualiz, lxXvaloresOpetar, lxXvaloresPersocomp, lxXvaloresEqepson, lxXvaloresNoarrastra, lxXvaloresEqibm, lxXvaloresTipotarj, lxXvaloresFactelec, lxXvaloresRetiraefec, lxXvaloresPaguesea, lxXvaloresLeyenda, lxXvaloresMntomaxret, lxXvaloresBcoadep, lxXvaloresCcadep, lxXvaloresImprchqcf, lxXvaloresValorretef, lxXvaloresCldescp, lxXvaloresElectro, lxXvaloresRedondeo, lxXvaloresValoracred, lxXvaloresNoaplirc, lxXvaloresArqtot, lxXvaloresBlomoddes, lxXvaloresModifecha
				lxXvaloresFaltafw =  .Fechaaltafw			lxXvaloresFectrans =  .Fechatransferencia			lxXvaloresFecexpo =  .Fechaexpo			lxXvaloresFmodifw =  .Fechamodificacionfw			lxXvaloresFecimpo =  .Fechaimpo			lxXvaloresClcuit =  .Cuit			lxXvaloresCldir =  .Direccion			lxXvaloresClcfi =  .Tipo			lxXvaloresTimestamp = goLibrerias.ObtenerTimestamp()			lxXvaloresClpun1 =  .Descuentosobrebruto			lxXvaloresClser =  .Diaspresentacion1			lxXvaloresClvporj =  .Diasacreditacion			lxXvaloresHmodifw =  .Horamodificacionfw			lxXvaloresEsttrans =  .Estadotransferencia			lxXvaloresBdmodifw =  .Basededatosmodificacionfw			lxXvaloresHoraexpo =  .Horaexpo			lxXvaloresHaltafw =  .Horaaltafw			lxXvaloresHoraimpo =  .Horaimpo			lxXvaloresBdaltafw =  .Basededatosaltafw			lxXvaloresValtafw =  .Versionaltafw			lxXvaloresCltlf =  .Telefono			lxXvaloresVmodifw =  .Versionmodificacionfw			lxXvaloresZadsfw =  .Zadsfw			lxXvaloresUmodifw =  .Usuariomodificacionfw			lxXvaloresSmodifw =  .Seriemodificacionfw			lxXvaloresSaltafw =  .Seriealtafw			lxXvaloresUaltafw =  .Usuarioaltafw			lxXvaloresClcod =  .Codigo			lxXvaloresClobs =  .Observacion			lxXvaloresClcobade =  .Cobroadelantado			lxXvaloresClnom =  .Descripcion			lxXvaloresCldto =  .Descuentoadelantado			lxXvaloresCn1 =  .Habiles			lxXvaloresClser2 =  .Diaspresentacion2			lxXvaloresCotizar =  .Pidecotizacion			lxXvaloresCltcmadre =  .Tarjetamadre			lxXvaloresPervuelto =  .Permitevuelto			lxXvaloresClloc =  .Localidad			lxXvaloresClfax =  .Fax			lxXvaloresModoredon =  .Modoredondeo			lxXvaloresClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvaloresCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvaloresPrestador =  .Prestador			lxXvaloresIdcaja =  .Caja_PK 			lxXvaloresClgrup =  upper( .Grupo_PK ) 			lxXvaloresClvdiaini =  .Diasentrecuotas			lxXvaloresCllist =  .Diaspresentacion3			lxXvaloresClcp =  .Codigopostal			lxXvaloresClvdias =  .Diaspresentacion4			lxXvaloresClvcod =  upper( .SeDepositaEnBanco_PK ) 			lxXvaloresClclas =  upper( .Clasificacion_PK ) 			lxXvaloresClcan4 =  .Generacanje			lxXvaloresClvisualiz =  .Visualizarencaja			lxXvaloresOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvaloresPersocomp =  .Personalizarcomprobante			lxXvaloresEqepson =  .Equivcfepson			lxXvaloresNoarrastra =  .Arrastrasaldo			lxXvaloresEqibm =  .Equivcfibm			lxXvaloresTipotarj =  .Tipotarjeta			lxXvaloresFactelec =  .Facturaelectronica			lxXvaloresRetiraefec =  .Habilitarretiroefectivo			lxXvaloresPaguesea =  .Paguesea			lxXvaloresLeyenda =  .Leyenda			lxXvaloresMntomaxret =  .Montomaximoderetiro			lxXvaloresBcoadep =  upper( .BcoADep_PK ) 			lxXvaloresCcadep =  .Ctacteadep			lxXvaloresImprchqcf =  .Imprimechequecfiscal			lxXvaloresValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvaloresCldescp =  .Descuento			lxXvaloresElectro =  .Chequeelectronico			lxXvaloresRedondeo =  upper( .Redondeo_PK ) 			lxXvaloresValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvaloresNoaplirc =  .Noaplicarenrecibos			lxXvaloresArqtot =  .Arqueoportotales			lxXvaloresBlomoddes =  .Bloqueamodificaciondescripcion			lxXvaloresModifecha =  .Permitemodificarfecha
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
				update ZooLogic.XVALORES set "Faltafw" = <<"'" + this.ConvertirDateSql( lxXvaloresFaltafw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxXvaloresFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxXvaloresFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxXvaloresFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxXvaloresFecimpo ) + "'">>,"Clcuit" = <<"'" + this.FormatearTextoSql( lxXvaloresClcuit ) + "'">>,"Cldir" = <<"'" + this.FormatearTextoSql( lxXvaloresCldir ) + "'">>,"Clcfi" = <<lxXvaloresClcfi>>,"Timestamp" = <<lxXvaloresTimestamp>>,"Clpun1" = <<lxXvaloresClpun1>>,"Clser" = <<lxXvaloresClser>>,"Clvporj" = <<lxXvaloresClvporj>>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxXvaloresEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresBdmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxXvaloresHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxXvaloresHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxXvaloresHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxXvaloresBdaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxXvaloresValtafw ) + "'">>,"Cltlf" = <<"'" + this.FormatearTextoSql( lxXvaloresCltlf ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxXvaloresZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxXvaloresSaltafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxXvaloresUaltafw ) + "'">>,"Clcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'">>,"Clobs" = <<"'" + this.FormatearTextoSql( lxXvaloresClobs ) + "'">>,"Clcobade" = <<lxXvaloresClcobade>>,"Clnom" = <<"'" + this.FormatearTextoSql( lxXvaloresClnom ) + "'">>,"Cldto" = <<lxXvaloresCldto>>,"Cn1" = <<lxXvaloresCn1>>,"Clser2" = <<lxXvaloresClser2>>,"Cotizar" = <<iif( lxXvaloresCotizar, 1, 0 )>>,"Cltcmadre" = <<iif( lxXvaloresCltcmadre, 1, 0 )>>,"Pervuelto" = <<iif( lxXvaloresPervuelto, 1, 0 )>>,"Clloc" = <<"'" + this.FormatearTextoSql( lxXvaloresClloc ) + "'">>,"Clfax" = <<"'" + this.FormatearTextoSql( lxXvaloresClfax ) + "'">>,"Modoredon" = <<lxXvaloresModoredon>>,"Clsmonet" = <<"'" + this.FormatearTextoSql( lxXvaloresClsmonet ) + "'">>,"Ctabanc" = <<"'" + this.FormatearTextoSql( lxXvaloresCtabanc ) + "'">>,"Prestador" = <<"'" + this.FormatearTextoSql( lxXvaloresPrestador ) + "'">>,"Idcaja" = <<lxXvaloresIdcaja>>,"Clgrup" = <<"'" + this.FormatearTextoSql( lxXvaloresClgrup ) + "'">>,"Clvdiaini" = <<lxXvaloresClvdiaini>>,"Cllist" = <<lxXvaloresCllist>>,"Clcp" = <<"'" + this.FormatearTextoSql( lxXvaloresClcp ) + "'">>,"Clvdias" = <<lxXvaloresClvdias>>,"Clvcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClvcod ) + "'">>,"Clclas" = <<"'" + this.FormatearTextoSql( lxXvaloresClclas ) + "'">>,"Clcan4" = <<lxXvaloresClcan4>>,"Clvisualiz" = <<iif( lxXvaloresClvisualiz, 1, 0 )>>,"Opetar" = <<"'" + this.FormatearTextoSql( lxXvaloresOpetar ) + "'">>,"Persocomp" = <<iif( lxXvaloresPersocomp, 1, 0 )>>,"Eqepson" = <<lxXvaloresEqepson>>,"Noarrastra" = <<iif( lxXvaloresNoarrastra, 1, 0 )>>,"Eqibm" = <<lxXvaloresEqibm>>,"Tipotarj" = <<"'" + this.FormatearTextoSql( lxXvaloresTipotarj ) + "'">>,"Factelec" = <<"'" + this.FormatearTextoSql( lxXvaloresFactelec ) + "'">>,"Retiraefec" = <<iif( lxXvaloresRetiraefec, 1, 0 )>>,"Paguesea" = <<"'" + this.FormatearTextoSql( lxXvaloresPaguesea ) + "'">>,"Leyenda" = <<"'" + this.FormatearTextoSql( lxXvaloresLeyenda ) + "'">>,"Mntomaxret" = <<lxXvaloresMntomaxret>>,"Bcoadep" = <<"'" + this.FormatearTextoSql( lxXvaloresBcoadep ) + "'">>,"Ccadep" = <<"'" + this.FormatearTextoSql( lxXvaloresCcadep ) + "'">>,"Imprchqcf" = <<iif( lxXvaloresImprchqcf, 1, 0 )>>,"Valorretef" = <<"'" + this.FormatearTextoSql( lxXvaloresValorretef ) + "'">>,"Cldescp" = <<lxXvaloresCldescp>>,"Electro" = <<iif( lxXvaloresElectro, 1, 0 )>>,"Redondeo" = <<"'" + this.FormatearTextoSql( lxXvaloresRedondeo ) + "'">>,"Valoracred" = <<"'" + this.FormatearTextoSql( lxXvaloresValoracred ) + "'">>,"Noaplirc" = <<iif( lxXvaloresNoaplirc, 1, 0 )>>,"Arqtot" = <<iif( lxXvaloresArqtot, 1, 0 )>>,"Blomoddes" = <<iif( lxXvaloresBlomoddes, 1, 0 )>>,"Modifecha" = <<iif( lxXvaloresModifecha, 1, 0 )>> where "Clcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'">> and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEACREDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
		this.oEntidad.Timestamp = lxXvaloresTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CLCOD from ZooLogic.XVALORES where " + this.ConvertirFuncionesSql( " XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''" ) )
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
			Local lxXvaloresClcod
			lxXvaloresClcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVALORES where "Clcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'">> and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )

			if reccount( 'c_VALOR' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxXvaloresClcod as Variant
		llRetorno = .t.
		lxXvaloresClcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.XVALORES where "Clcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'">> and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVALORES where  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '' order by CLCOD
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVALORES where  funciones.padr( CLCOD, 5, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '' order by CLCOD
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVALORES where  funciones.padr( CLCOD, 5, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
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
				select top 1 "Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha" from ZooLogic.XVALORES where  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '' order by CLCOD desc
			endtext
			use in select('c_VALOR')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VALOR', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEACREDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetalleAcreditacionPlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetalleAcreditacionPlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetalleAcreditacionPlanes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Cod" as "Codigo", "Cuotas" as "Cuotas", "Montodesde" as "Montodesde", "Tipomonto" as "Tipodemonto", "Recargo" as "Recargo", "Descuento" as "Descuento", "Canttiempo" as "Cantidaddedias", "Modotiempo" as "Modo" from ZooLogic.TARJEDET where Cod = <<"'" + this.FormatearTextoSql( c_VALOR.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_DetallePlanes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DetallePlanes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_DetallePlanes
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
			lcXml = this.oConexion.EjecutarSql( "select Faltafw,Fectrans,Fecexpo,Fmodifw,Fecimpo,Clcuit,Cldir,Clcfi,Timestamp,Clpun1,Clser,Clvporj,H" + ;
"modifw,Esttrans,Bdmodifw,Horaexpo,Haltafw,Horaimpo,Bdaltafw,Valtafw,Cltlf,Vmodifw,Zadsfw,Umodifw,Smo" + ;
"difw,Saltafw,Ualtafw,Clcod,Clobs,Clcobade,Clnom,Cldto,Cn1,Clser2,Cotizar,Cltcmadre,Pervuelto,Clloc,C" + ;
"lfax,Modoredon,Clsmonet,Ctabanc,Prestador,Idcaja,Clgrup,Clvdiaini,Cllist,Clcp,Clvdias,Clvcod,Clclas," + ;
"Clcan4,Clvisualiz,Opetar,Persocomp,Eqepson,Noarrastra,Eqibm,Tipotarj,Factelec,Retiraefec,Paguesea,Le" + ;
"yenda,Mntomaxret,Bcoadep,Ccadep,Imprchqcf,Valorretef,Cldescp,Electro,Redondeo,Valoracred,Noaplirc,Ar" + ;
"qtot,Blomoddes,Modifecha" + ;
" from ZooLogic.XVALORES where  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '' and " + lcFiltro )
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
			local  lxXvaloresFaltafw, lxXvaloresFectrans, lxXvaloresFecexpo, lxXvaloresFmodifw, lxXvaloresFecimpo, lxXvaloresClcuit, lxXvaloresCldir, lxXvaloresClcfi, lxXvaloresTimestamp, lxXvaloresClpun1, lxXvaloresClser, lxXvaloresClvporj, lxXvaloresHmodifw, lxXvaloresEsttrans, lxXvaloresBdmodifw, lxXvaloresHoraexpo, lxXvaloresHaltafw, lxXvaloresHoraimpo, lxXvaloresBdaltafw, lxXvaloresValtafw, lxXvaloresCltlf, lxXvaloresVmodifw, lxXvaloresZadsfw, lxXvaloresUmodifw, lxXvaloresSmodifw, lxXvaloresSaltafw, lxXvaloresUaltafw, lxXvaloresClcod, lxXvaloresClobs, lxXvaloresClcobade, lxXvaloresClnom, lxXvaloresCldto, lxXvaloresCn1, lxXvaloresClser2, lxXvaloresCotizar, lxXvaloresCltcmadre, lxXvaloresPervuelto, lxXvaloresClloc, lxXvaloresClfax, lxXvaloresModoredon, lxXvaloresClsmonet, lxXvaloresCtabanc, lxXvaloresPrestador, lxXvaloresIdcaja, lxXvaloresClgrup, lxXvaloresClvdiaini, lxXvaloresCllist, lxXvaloresClcp, lxXvaloresClvdias, lxXvaloresClvcod, lxXvaloresClclas, lxXvaloresClcan4, lxXvaloresClvisualiz, lxXvaloresOpetar, lxXvaloresPersocomp, lxXvaloresEqepson, lxXvaloresNoarrastra, lxXvaloresEqibm, lxXvaloresTipotarj, lxXvaloresFactelec, lxXvaloresRetiraefec, lxXvaloresPaguesea, lxXvaloresLeyenda, lxXvaloresMntomaxret, lxXvaloresBcoadep, lxXvaloresCcadep, lxXvaloresImprchqcf, lxXvaloresValorretef, lxXvaloresCldescp, lxXvaloresElectro, lxXvaloresRedondeo, lxXvaloresValoracred, lxXvaloresNoaplirc, lxXvaloresArqtot, lxXvaloresBlomoddes, lxXvaloresModifecha
				lxXvaloresFaltafw = ctod( '  /  /    ' )			lxXvaloresFectrans = ctod( '  /  /    ' )			lxXvaloresFecexpo = ctod( '  /  /    ' )			lxXvaloresFmodifw = ctod( '  /  /    ' )			lxXvaloresFecimpo = ctod( '  /  /    ' )			lxXvaloresClcuit = []			lxXvaloresCldir = []			lxXvaloresClcfi = 0			lxXvaloresTimestamp = goLibrerias.ObtenerTimestamp()			lxXvaloresClpun1 = 0			lxXvaloresClser = 0			lxXvaloresClvporj = 0			lxXvaloresHmodifw = []			lxXvaloresEsttrans = []			lxXvaloresBdmodifw = []			lxXvaloresHoraexpo = []			lxXvaloresHaltafw = []			lxXvaloresHoraimpo = []			lxXvaloresBdaltafw = []			lxXvaloresValtafw = []			lxXvaloresCltlf = []			lxXvaloresVmodifw = []			lxXvaloresZadsfw = []			lxXvaloresUmodifw = []			lxXvaloresSmodifw = []			lxXvaloresSaltafw = []			lxXvaloresUaltafw = []			lxXvaloresClcod = []			lxXvaloresClobs = []			lxXvaloresClcobade = 0			lxXvaloresClnom = []			lxXvaloresCldto = 0			lxXvaloresCn1 = 0			lxXvaloresClser2 = 0			lxXvaloresCotizar = .F.			lxXvaloresCltcmadre = .F.			lxXvaloresPervuelto = .F.			lxXvaloresClloc = []			lxXvaloresClfax = []			lxXvaloresModoredon = 0			lxXvaloresClsmonet = []			lxXvaloresCtabanc = []			lxXvaloresPrestador = []			lxXvaloresIdcaja = 0			lxXvaloresClgrup = []			lxXvaloresClvdiaini = 0			lxXvaloresCllist = 0			lxXvaloresClcp = []			lxXvaloresClvdias = 0			lxXvaloresClvcod = []			lxXvaloresClclas = []			lxXvaloresClcan4 = 0			lxXvaloresClvisualiz = .F.			lxXvaloresOpetar = []			lxXvaloresPersocomp = .F.			lxXvaloresEqepson = 0			lxXvaloresNoarrastra = .F.			lxXvaloresEqibm = 0			lxXvaloresTipotarj = []			lxXvaloresFactelec = []			lxXvaloresRetiraefec = .F.			lxXvaloresPaguesea = []			lxXvaloresLeyenda = []			lxXvaloresMntomaxret = 0			lxXvaloresBcoadep = []			lxXvaloresCcadep = []			lxXvaloresImprchqcf = .F.			lxXvaloresValorretef = []			lxXvaloresCldescp = 0			lxXvaloresElectro = .F.			lxXvaloresRedondeo = []			lxXvaloresValoracred = []			lxXvaloresNoaplirc = .F.			lxXvaloresArqtot = .F.			lxXvaloresBlomoddes = .F.			lxXvaloresModifecha = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEACREDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.TARJEDET where "Cod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.XVALORES where "CLCOD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'XVALORES' + '_' + tcCampo
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
		lcWhere = " Where  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'XVALORES', '', tnTope )
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCUIT AS CUIT'
				Case lcAtributo == 'DIRECCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDIR AS DIRECCION'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCFI AS TIPO'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'DESCUENTOSOBREBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLPUN1 AS DESCUENTOSOBREBRUTO'
				Case lcAtributo == 'DIASPRESENTACION1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSER AS DIASPRESENTACION1'
				Case lcAtributo == 'DIASACREDITACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVPORJ AS DIASACREDITACION'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'TELEFONO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTLF AS TELEFONO'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOD AS CODIGO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLOBS AS OBSERVACION'
				Case lcAtributo == 'COBROADELANTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCOBADE AS COBROADELANTADO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLNOM AS DESCRIPCION'
				Case lcAtributo == 'DESCUENTOADELANTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDTO AS DESCUENTOADELANTADO'
				Case lcAtributo == 'HABILES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CN1 AS HABILES'
				Case lcAtributo == 'DIASPRESENTACION2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSER2 AS DIASPRESENTACION2'
				Case lcAtributo == 'PIDECOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZAR AS PIDECOTIZACION'
				Case lcAtributo == 'TARJETAMADRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLTCMADRE AS TARJETAMADRE'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'LOCALIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLOC AS LOCALIDAD'
				Case lcAtributo == 'FAX'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLFAX AS FAX'
				Case lcAtributo == 'MODOREDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODOREDON AS MODOREDONDEO'
				Case lcAtributo == 'SIMBOLOMONETARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLSMONET AS SIMBOLOMONETARIO'
				Case lcAtributo == 'CUENTABANCARIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTABANC AS CUENTABANCARIA'
				Case lcAtributo == 'PRESTADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRESTADOR AS PRESTADOR'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'GRUPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLGRUP AS GRUPO'
				Case lcAtributo == 'DIASENTRECUOTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVDIAINI AS DIASENTRECUOTAS'
				Case lcAtributo == 'DIASPRESENTACION3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLLIST AS DIASPRESENTACION3'
				Case lcAtributo == 'CODIGOPOSTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCP AS CODIGOPOSTAL'
				Case lcAtributo == 'DIASPRESENTACION4'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVDIAS AS DIASPRESENTACION4'
				Case lcAtributo == 'SEDEPOSITAENBANCO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVCOD AS SEDEPOSITAENBANCO'
				Case lcAtributo == 'CLASIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCLAS AS CLASIFICACION'
				Case lcAtributo == 'GENERACANJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLCAN4 AS GENERACANJE'
				Case lcAtributo == 'VISUALIZARENCAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLVISUALIZ AS VISUALIZARENCAJA'
				Case lcAtributo == 'OPERADORATARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPETAR AS OPERADORATARJETA'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSOCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'EQUIVCFEPSON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQEPSON AS EQUIVCFEPSON'
				Case lcAtributo == 'ARRASTRASALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOARRASTRA AS ARRASTRASALDO'
				Case lcAtributo == 'EQUIVCFIBM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQIBM AS EQUIVCFIBM'
				Case lcAtributo == 'TIPOTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOTARJ AS TIPOTARJETA'
				Case lcAtributo == 'FACTURAELECTRONICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTELEC AS FACTURAELECTRONICA'
				Case lcAtributo == 'HABILITARRETIROEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RETIRAEFEC AS HABILITARRETIROEFECTIVO'
				Case lcAtributo == 'PAGUESEA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGUESEA AS PAGUESEA'
				Case lcAtributo == 'LEYENDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LEYENDA AS LEYENDA'
				Case lcAtributo == 'MONTOMAXIMODERETIRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTOMAXRET AS MONTOMAXIMODERETIRO'
				Case lcAtributo == 'BCOADEP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BCOADEP AS BCOADEP'
				Case lcAtributo == 'CTACTEADEP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCADEP AS CTACTEADEP'
				Case lcAtributo == 'IMPRIMECHEQUECFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPRCHQCF AS IMPRIMECHEQUECFISCAL'
				Case lcAtributo == 'VALORPARARETIRODEEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORRETEF AS VALORPARARETIRODEEFECTIVO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLDESCP AS DESCUENTO'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'REDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDONDEO AS REDONDEO'
				Case lcAtributo == 'VALORDEACREDITACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALORACRED AS VALORDEACREDITACION'
				Case lcAtributo == 'NOAPLICARENRECIBOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOAPLIRC AS NOAPLICARENRECIBOS'
				Case lcAtributo == 'ARQUEOPORTOTALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARQTOT AS ARQUEOPORTOTALES'
				Case lcAtributo == 'BLOQUEAMODIFICACIONDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOMODDES AS BLOQUEAMODIFICACIONDESCRIPCION'
				Case lcAtributo == 'PERMITEMODIFICARFECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODIFECHA AS PERMITEMODIFICARFECHA'
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
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'CLCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCION'
				lcCampo = 'CLDIR'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CLCFI'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOSOBREBRUTO'
				lcCampo = 'CLPUN1'
			Case upper( alltrim( tcAtributo ) ) == 'DIASPRESENTACION1'
				lcCampo = 'CLSER'
			Case upper( alltrim( tcAtributo ) ) == 'DIASACREDITACION'
				lcCampo = 'CLVPORJ'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TELEFONO'
				lcCampo = 'CLTLF'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CLCOD'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'CLOBS'
			Case upper( alltrim( tcAtributo ) ) == 'COBROADELANTADO'
				lcCampo = 'CLCOBADE'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CLNOM'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOADELANTADO'
				lcCampo = 'CLDTO'
			Case upper( alltrim( tcAtributo ) ) == 'HABILES'
				lcCampo = 'CN1'
			Case upper( alltrim( tcAtributo ) ) == 'DIASPRESENTACION2'
				lcCampo = 'CLSER2'
			Case upper( alltrim( tcAtributo ) ) == 'PIDECOTIZACION'
				lcCampo = 'COTIZAR'
			Case upper( alltrim( tcAtributo ) ) == 'TARJETAMADRE'
				lcCampo = 'CLTCMADRE'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'LOCALIDAD'
				lcCampo = 'CLLOC'
			Case upper( alltrim( tcAtributo ) ) == 'FAX'
				lcCampo = 'CLFAX'
			Case upper( alltrim( tcAtributo ) ) == 'MODOREDONDEO'
				lcCampo = 'MODOREDON'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIO'
				lcCampo = 'CLSMONET'
			Case upper( alltrim( tcAtributo ) ) == 'CUENTABANCARIA'
				lcCampo = 'CTABANC'
			Case upper( alltrim( tcAtributo ) ) == 'PRESTADOR'
				lcCampo = 'PRESTADOR'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPO'
				lcCampo = 'CLGRUP'
			Case upper( alltrim( tcAtributo ) ) == 'DIASENTRECUOTAS'
				lcCampo = 'CLVDIAINI'
			Case upper( alltrim( tcAtributo ) ) == 'DIASPRESENTACION3'
				lcCampo = 'CLLIST'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOPOSTAL'
				lcCampo = 'CLCP'
			Case upper( alltrim( tcAtributo ) ) == 'DIASPRESENTACION4'
				lcCampo = 'CLVDIAS'
			Case upper( alltrim( tcAtributo ) ) == 'SEDEPOSITAENBANCO'
				lcCampo = 'CLVCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACION'
				lcCampo = 'CLCLAS'
			Case upper( alltrim( tcAtributo ) ) == 'GENERACANJE'
				lcCampo = 'CLCAN4'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENCAJA'
				lcCampo = 'CLVISUALIZ'
			Case upper( alltrim( tcAtributo ) ) == 'OPERADORATARJETA'
				lcCampo = 'OPETAR'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSOCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVCFEPSON'
				lcCampo = 'EQEPSON'
			Case upper( alltrim( tcAtributo ) ) == 'ARRASTRASALDO'
				lcCampo = 'NOARRASTRA'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVCFIBM'
				lcCampo = 'EQIBM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOTARJETA'
				lcCampo = 'TIPOTARJ'
			Case upper( alltrim( tcAtributo ) ) == 'FACTURAELECTRONICA'
				lcCampo = 'FACTELEC'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITARRETIROEFECTIVO'
				lcCampo = 'RETIRAEFEC'
			Case upper( alltrim( tcAtributo ) ) == 'PAGUESEA'
				lcCampo = 'PAGUESEA'
			Case upper( alltrim( tcAtributo ) ) == 'LEYENDA'
				lcCampo = 'LEYENDA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOMAXIMODERETIRO'
				lcCampo = 'MNTOMAXRET'
			Case upper( alltrim( tcAtributo ) ) == 'BCOADEP'
				lcCampo = 'BCOADEP'
			Case upper( alltrim( tcAtributo ) ) == 'CTACTEADEP'
				lcCampo = 'CCADEP'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMECHEQUECFISCAL'
				lcCampo = 'IMPRCHQCF'
			Case upper( alltrim( tcAtributo ) ) == 'VALORPARARETIRODEEFECTIVO'
				lcCampo = 'VALORRETEF'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'CLDESCP'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'ELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEO'
				lcCampo = 'REDONDEO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDEACREDITACION'
				lcCampo = 'VALORACRED'
			Case upper( alltrim( tcAtributo ) ) == 'NOAPLICARENRECIBOS'
				lcCampo = 'NOAPLIRC'
			Case upper( alltrim( tcAtributo ) ) == 'ARQUEOPORTOTALES'
				lcCampo = 'ARQTOT'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEAMODIFICACIONDESCRIPCION'
				lcCampo = 'BLOMODDES'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEMODIFICARFECHA'
				lcCampo = 'MODIFECHA'
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
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'DETALLEACREDITACIONPLANES'
			lcRetorno = 'TARJEACREDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'DETALLEPLANES'
			lcRetorno = 'TARJEDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxXvaloresFaltafw, lxXvaloresFectrans, lxXvaloresFecexpo, lxXvaloresFmodifw, lxXvaloresFecimpo, lxXvaloresClcuit, lxXvaloresCldir, lxXvaloresClcfi, lxXvaloresTimestamp, lxXvaloresClpun1, lxXvaloresClser, lxXvaloresClvporj, lxXvaloresHmodifw, lxXvaloresEsttrans, lxXvaloresBdmodifw, lxXvaloresHoraexpo, lxXvaloresHaltafw, lxXvaloresHoraimpo, lxXvaloresBdaltafw, lxXvaloresValtafw, lxXvaloresCltlf, lxXvaloresVmodifw, lxXvaloresZadsfw, lxXvaloresUmodifw, lxXvaloresSmodifw, lxXvaloresSaltafw, lxXvaloresUaltafw, lxXvaloresClcod, lxXvaloresClobs, lxXvaloresClcobade, lxXvaloresClnom, lxXvaloresCldto, lxXvaloresCn1, lxXvaloresClser2, lxXvaloresCotizar, lxXvaloresCltcmadre, lxXvaloresPervuelto, lxXvaloresClloc, lxXvaloresClfax, lxXvaloresModoredon, lxXvaloresClsmonet, lxXvaloresCtabanc, lxXvaloresPrestador, lxXvaloresIdcaja, lxXvaloresClgrup, lxXvaloresClvdiaini, lxXvaloresCllist, lxXvaloresClcp, lxXvaloresClvdias, lxXvaloresClvcod, lxXvaloresClclas, lxXvaloresClcan4, lxXvaloresClvisualiz, lxXvaloresOpetar, lxXvaloresPersocomp, lxXvaloresEqepson, lxXvaloresNoarrastra, lxXvaloresEqibm, lxXvaloresTipotarj, lxXvaloresFactelec, lxXvaloresRetiraefec, lxXvaloresPaguesea, lxXvaloresLeyenda, lxXvaloresMntomaxret, lxXvaloresBcoadep, lxXvaloresCcadep, lxXvaloresImprchqcf, lxXvaloresValorretef, lxXvaloresCldescp, lxXvaloresElectro, lxXvaloresRedondeo, lxXvaloresValoracred, lxXvaloresNoaplirc, lxXvaloresArqtot, lxXvaloresBlomoddes, lxXvaloresModifecha
				lxXvaloresFaltafw =  .Fechaaltafw			lxXvaloresFectrans =  .Fechatransferencia			lxXvaloresFecexpo =  .Fechaexpo			lxXvaloresFmodifw =  .Fechamodificacionfw			lxXvaloresFecimpo =  .Fechaimpo			lxXvaloresClcuit =  .Cuit			lxXvaloresCldir =  .Direccion			lxXvaloresClcfi =  .Tipo			lxXvaloresTimestamp = goLibrerias.ObtenerTimestamp()			lxXvaloresClpun1 =  .Descuentosobrebruto			lxXvaloresClser =  .Diaspresentacion1			lxXvaloresClvporj =  .Diasacreditacion			lxXvaloresHmodifw =  .Horamodificacionfw			lxXvaloresEsttrans =  .Estadotransferencia			lxXvaloresBdmodifw =  .Basededatosmodificacionfw			lxXvaloresHoraexpo =  .Horaexpo			lxXvaloresHaltafw =  .Horaaltafw			lxXvaloresHoraimpo =  .Horaimpo			lxXvaloresBdaltafw =  .Basededatosaltafw			lxXvaloresValtafw =  .Versionaltafw			lxXvaloresCltlf =  .Telefono			lxXvaloresVmodifw =  .Versionmodificacionfw			lxXvaloresZadsfw =  .Zadsfw			lxXvaloresUmodifw =  .Usuariomodificacionfw			lxXvaloresSmodifw =  .Seriemodificacionfw			lxXvaloresSaltafw =  .Seriealtafw			lxXvaloresUaltafw =  .Usuarioaltafw			lxXvaloresClcod =  .Codigo			lxXvaloresClobs =  .Observacion			lxXvaloresClcobade =  .Cobroadelantado			lxXvaloresClnom =  .Descripcion			lxXvaloresCldto =  .Descuentoadelantado			lxXvaloresCn1 =  .Habiles			lxXvaloresClser2 =  .Diaspresentacion2			lxXvaloresCotizar =  .Pidecotizacion			lxXvaloresCltcmadre =  .Tarjetamadre			lxXvaloresPervuelto =  .Permitevuelto			lxXvaloresClloc =  .Localidad			lxXvaloresClfax =  .Fax			lxXvaloresModoredon =  .Modoredondeo			lxXvaloresClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvaloresCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvaloresPrestador =  .Prestador			lxXvaloresIdcaja =  .Caja_PK 			lxXvaloresClgrup =  upper( .Grupo_PK ) 			lxXvaloresClvdiaini =  .Diasentrecuotas			lxXvaloresCllist =  .Diaspresentacion3			lxXvaloresClcp =  .Codigopostal			lxXvaloresClvdias =  .Diaspresentacion4			lxXvaloresClvcod =  upper( .SeDepositaEnBanco_PK ) 			lxXvaloresClclas =  upper( .Clasificacion_PK ) 			lxXvaloresClcan4 =  .Generacanje			lxXvaloresClvisualiz =  .Visualizarencaja			lxXvaloresOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvaloresPersocomp =  .Personalizarcomprobante			lxXvaloresEqepson =  .Equivcfepson			lxXvaloresNoarrastra =  .Arrastrasaldo			lxXvaloresEqibm =  .Equivcfibm			lxXvaloresTipotarj =  .Tipotarjeta			lxXvaloresFactelec =  .Facturaelectronica			lxXvaloresRetiraefec =  .Habilitarretiroefectivo			lxXvaloresPaguesea =  .Paguesea			lxXvaloresLeyenda =  .Leyenda			lxXvaloresMntomaxret =  .Montomaximoderetiro			lxXvaloresBcoadep =  upper( .BcoADep_PK ) 			lxXvaloresCcadep =  .Ctacteadep			lxXvaloresImprchqcf =  .Imprimechequecfiscal			lxXvaloresValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvaloresCldescp =  .Descuento			lxXvaloresElectro =  .Chequeelectronico			lxXvaloresRedondeo =  upper( .Redondeo_PK ) 			lxXvaloresValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvaloresNoaplirc =  .Noaplicarenrecibos			lxXvaloresArqtot =  .Arqueoportotales			lxXvaloresBlomoddes =  .Bloqueamodificaciondescripcion			lxXvaloresModifecha =  .Permitemodificarfecha
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.XVALORES ( "Faltafw","Fectrans","Fecexpo","Fmodifw","Fecimpo","Clcuit","Cldir","Clcfi","Timestamp","Clpun1","Clser","Clvporj","Hmodifw","Esttrans","Bdmodifw","Horaexpo","Haltafw","Horaimpo","Bdaltafw","Valtafw","Cltlf","Vmodifw","Zadsfw","Umodifw","Smodifw","Saltafw","Ualtafw","Clcod","Clobs","Clcobade","Clnom","Cldto","Cn1","Clser2","Cotizar","Cltcmadre","Pervuelto","Clloc","Clfax","Modoredon","Clsmonet","Ctabanc","Prestador","Idcaja","Clgrup","Clvdiaini","Cllist","Clcp","Clvdias","Clvcod","Clclas","Clcan4","Clvisualiz","Opetar","Persocomp","Eqepson","Noarrastra","Eqibm","Tipotarj","Factelec","Retiraefec","Paguesea","Leyenda","Mntomaxret","Bcoadep","Ccadep","Imprchqcf","Valorretef","Cldescp","Electro","Redondeo","Valoracred","Noaplirc","Arqtot","Blomoddes","Modifecha" ) values ( <<"'" + this.ConvertirDateSql( lxXvaloresFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxXvaloresFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClcuit ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCldir ) + "'" >>, <<lxXvaloresClcfi >>, <<lxXvaloresTimestamp >>, <<lxXvaloresClpun1 >>, <<lxXvaloresClser >>, <<lxXvaloresClvporj >>, <<"'" + this.FormatearTextoSql( lxXvaloresHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCltlf ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClobs ) + "'" >>, <<lxXvaloresClcobade >>, <<"'" + this.FormatearTextoSql( lxXvaloresClnom ) + "'" >>, <<lxXvaloresCldto >>, <<lxXvaloresCn1 >>, <<lxXvaloresClser2 >>, <<iif( lxXvaloresCotizar, 1, 0 ) >>, <<iif( lxXvaloresCltcmadre, 1, 0 ) >>, <<iif( lxXvaloresPervuelto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresClloc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClfax ) + "'" >>, <<lxXvaloresModoredon >>, <<"'" + this.FormatearTextoSql( lxXvaloresClsmonet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCtabanc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresPrestador ) + "'" >>, <<lxXvaloresIdcaja >>, <<"'" + this.FormatearTextoSql( lxXvaloresClgrup ) + "'" >>, <<lxXvaloresClvdiaini >>, <<lxXvaloresCllist >>, <<"'" + this.FormatearTextoSql( lxXvaloresClcp ) + "'" >>, <<lxXvaloresClvdias >>, <<"'" + this.FormatearTextoSql( lxXvaloresClvcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresClclas ) + "'" >>, <<lxXvaloresClcan4 >>, <<iif( lxXvaloresClvisualiz, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresOpetar ) + "'" >>, <<iif( lxXvaloresPersocomp, 1, 0 ) >>, <<lxXvaloresEqepson >>, <<iif( lxXvaloresNoarrastra, 1, 0 ) >>, <<lxXvaloresEqibm >>, <<"'" + this.FormatearTextoSql( lxXvaloresTipotarj ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresFactelec ) + "'" >>, <<iif( lxXvaloresRetiraefec, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresPaguesea ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresLeyenda ) + "'" >>, <<lxXvaloresMntomaxret >>, <<"'" + this.FormatearTextoSql( lxXvaloresBcoadep ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresCcadep ) + "'" >>, <<iif( lxXvaloresImprchqcf, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresValorretef ) + "'" >>, <<lxXvaloresCldescp >>, <<iif( lxXvaloresElectro, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxXvaloresRedondeo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxXvaloresValoracred ) + "'" >>, <<iif( lxXvaloresNoaplirc, 1, 0 ) >>, <<iif( lxXvaloresArqtot, 1, 0 ) >>, <<iif( lxXvaloresBlomoddes, 1, 0 ) >>, <<iif( lxXvaloresModifecha, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'XVALORES' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

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
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxXvaloresFaltafw, lxXvaloresFectrans, lxXvaloresFecexpo, lxXvaloresFmodifw, lxXvaloresFecimpo, lxXvaloresClcuit, lxXvaloresCldir, lxXvaloresClcfi, lxXvaloresTimestamp, lxXvaloresClpun1, lxXvaloresClser, lxXvaloresClvporj, lxXvaloresHmodifw, lxXvaloresEsttrans, lxXvaloresBdmodifw, lxXvaloresHoraexpo, lxXvaloresHaltafw, lxXvaloresHoraimpo, lxXvaloresBdaltafw, lxXvaloresValtafw, lxXvaloresCltlf, lxXvaloresVmodifw, lxXvaloresZadsfw, lxXvaloresUmodifw, lxXvaloresSmodifw, lxXvaloresSaltafw, lxXvaloresUaltafw, lxXvaloresClcod, lxXvaloresClobs, lxXvaloresClcobade, lxXvaloresClnom, lxXvaloresCldto, lxXvaloresCn1, lxXvaloresClser2, lxXvaloresCotizar, lxXvaloresCltcmadre, lxXvaloresPervuelto, lxXvaloresClloc, lxXvaloresClfax, lxXvaloresModoredon, lxXvaloresClsmonet, lxXvaloresCtabanc, lxXvaloresPrestador, lxXvaloresIdcaja, lxXvaloresClgrup, lxXvaloresClvdiaini, lxXvaloresCllist, lxXvaloresClcp, lxXvaloresClvdias, lxXvaloresClvcod, lxXvaloresClclas, lxXvaloresClcan4, lxXvaloresClvisualiz, lxXvaloresOpetar, lxXvaloresPersocomp, lxXvaloresEqepson, lxXvaloresNoarrastra, lxXvaloresEqibm, lxXvaloresTipotarj, lxXvaloresFactelec, lxXvaloresRetiraefec, lxXvaloresPaguesea, lxXvaloresLeyenda, lxXvaloresMntomaxret, lxXvaloresBcoadep, lxXvaloresCcadep, lxXvaloresImprchqcf, lxXvaloresValorretef, lxXvaloresCldescp, lxXvaloresElectro, lxXvaloresRedondeo, lxXvaloresValoracred, lxXvaloresNoaplirc, lxXvaloresArqtot, lxXvaloresBlomoddes, lxXvaloresModifecha
				lxXvaloresFaltafw =  .Fechaaltafw			lxXvaloresFectrans =  .Fechatransferencia			lxXvaloresFecexpo =  .Fechaexpo			lxXvaloresFmodifw =  .Fechamodificacionfw			lxXvaloresFecimpo =  .Fechaimpo			lxXvaloresClcuit =  .Cuit			lxXvaloresCldir =  .Direccion			lxXvaloresClcfi =  .Tipo			lxXvaloresTimestamp = goLibrerias.ObtenerTimestamp()			lxXvaloresClpun1 =  .Descuentosobrebruto			lxXvaloresClser =  .Diaspresentacion1			lxXvaloresClvporj =  .Diasacreditacion			lxXvaloresHmodifw =  .Horamodificacionfw			lxXvaloresEsttrans =  .Estadotransferencia			lxXvaloresBdmodifw =  .Basededatosmodificacionfw			lxXvaloresHoraexpo =  .Horaexpo			lxXvaloresHaltafw =  .Horaaltafw			lxXvaloresHoraimpo =  .Horaimpo			lxXvaloresBdaltafw =  .Basededatosaltafw			lxXvaloresValtafw =  .Versionaltafw			lxXvaloresCltlf =  .Telefono			lxXvaloresVmodifw =  .Versionmodificacionfw			lxXvaloresZadsfw =  .Zadsfw			lxXvaloresUmodifw =  .Usuariomodificacionfw			lxXvaloresSmodifw =  .Seriemodificacionfw			lxXvaloresSaltafw =  .Seriealtafw			lxXvaloresUaltafw =  .Usuarioaltafw			lxXvaloresClcod =  .Codigo			lxXvaloresClobs =  .Observacion			lxXvaloresClcobade =  .Cobroadelantado			lxXvaloresClnom =  .Descripcion			lxXvaloresCldto =  .Descuentoadelantado			lxXvaloresCn1 =  .Habiles			lxXvaloresClser2 =  .Diaspresentacion2			lxXvaloresCotizar =  .Pidecotizacion			lxXvaloresCltcmadre =  .Tarjetamadre			lxXvaloresPervuelto =  .Permitevuelto			lxXvaloresClloc =  .Localidad			lxXvaloresClfax =  .Fax			lxXvaloresModoredon =  .Modoredondeo			lxXvaloresClsmonet =  upper( .SimboloMonetario_PK ) 			lxXvaloresCtabanc =  upper( .CuentaBancaria_PK ) 			lxXvaloresPrestador =  .Prestador			lxXvaloresIdcaja =  .Caja_PK 			lxXvaloresClgrup =  upper( .Grupo_PK ) 			lxXvaloresClvdiaini =  .Diasentrecuotas			lxXvaloresCllist =  .Diaspresentacion3			lxXvaloresClcp =  .Codigopostal			lxXvaloresClvdias =  .Diaspresentacion4			lxXvaloresClvcod =  upper( .SeDepositaEnBanco_PK ) 			lxXvaloresClclas =  upper( .Clasificacion_PK ) 			lxXvaloresClcan4 =  .Generacanje			lxXvaloresClvisualiz =  .Visualizarencaja			lxXvaloresOpetar =  upper( .OperadoraTarjeta_PK ) 			lxXvaloresPersocomp =  .Personalizarcomprobante			lxXvaloresEqepson =  .Equivcfepson			lxXvaloresNoarrastra =  .Arrastrasaldo			lxXvaloresEqibm =  .Equivcfibm			lxXvaloresTipotarj =  .Tipotarjeta			lxXvaloresFactelec =  .Facturaelectronica			lxXvaloresRetiraefec =  .Habilitarretiroefectivo			lxXvaloresPaguesea =  .Paguesea			lxXvaloresLeyenda =  .Leyenda			lxXvaloresMntomaxret =  .Montomaximoderetiro			lxXvaloresBcoadep =  upper( .BcoADep_PK ) 			lxXvaloresCcadep =  .Ctacteadep			lxXvaloresImprchqcf =  .Imprimechequecfiscal			lxXvaloresValorretef =  upper( .ValorParaRetiroDeEfectivo_PK ) 			lxXvaloresCldescp =  .Descuento			lxXvaloresElectro =  .Chequeelectronico			lxXvaloresRedondeo =  upper( .Redondeo_PK ) 			lxXvaloresValoracred =  upper( .ValorDeAcreditacion_PK ) 			lxXvaloresNoaplirc =  .Noaplicarenrecibos			lxXvaloresArqtot =  .Arqueoportotales			lxXvaloresBlomoddes =  .Bloqueamodificaciondescripcion			lxXvaloresModifecha =  .Permitemodificarfecha
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.XVALORES set "Faltafw" = <<"'" + this.ConvertirDateSql( lxXvaloresFaltafw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxXvaloresFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxXvaloresFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxXvaloresFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxXvaloresFecimpo ) + "'">>, "Clcuit" = <<"'" + this.FormatearTextoSql( lxXvaloresClcuit ) + "'">>, "Cldir" = <<"'" + this.FormatearTextoSql( lxXvaloresCldir ) + "'">>, "Clcfi" = <<lxXvaloresClcfi>>, "Timestamp" = <<lxXvaloresTimestamp>>, "Clpun1" = <<lxXvaloresClpun1>>, "Clser" = <<lxXvaloresClser>>, "Clvporj" = <<lxXvaloresClvporj>>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxXvaloresEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresBdmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxXvaloresHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxXvaloresHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxXvaloresHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxXvaloresBdaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxXvaloresValtafw ) + "'">>, "Cltlf" = <<"'" + this.FormatearTextoSql( lxXvaloresCltlf ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxXvaloresZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxXvaloresSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxXvaloresSaltafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxXvaloresUaltafw ) + "'">>, "Clcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClcod ) + "'">>, "Clobs" = <<"'" + this.FormatearTextoSql( lxXvaloresClobs ) + "'">>, "Clcobade" = <<lxXvaloresClcobade>>, "Clnom" = <<"'" + this.FormatearTextoSql( lxXvaloresClnom ) + "'">>, "Cldto" = <<lxXvaloresCldto>>, "Cn1" = <<lxXvaloresCn1>>, "Clser2" = <<lxXvaloresClser2>>, "Cotizar" = <<iif( lxXvaloresCotizar, 1, 0 )>>, "Cltcmadre" = <<iif( lxXvaloresCltcmadre, 1, 0 )>>, "Pervuelto" = <<iif( lxXvaloresPervuelto, 1, 0 )>>, "Clloc" = <<"'" + this.FormatearTextoSql( lxXvaloresClloc ) + "'">>, "Clfax" = <<"'" + this.FormatearTextoSql( lxXvaloresClfax ) + "'">>, "Modoredon" = <<lxXvaloresModoredon>>, "Clsmonet" = <<"'" + this.FormatearTextoSql( lxXvaloresClsmonet ) + "'">>, "Ctabanc" = <<"'" + this.FormatearTextoSql( lxXvaloresCtabanc ) + "'">>, "Prestador" = <<"'" + this.FormatearTextoSql( lxXvaloresPrestador ) + "'">>, "Idcaja" = <<lxXvaloresIdcaja>>, "Clgrup" = <<"'" + this.FormatearTextoSql( lxXvaloresClgrup ) + "'">>, "Clvdiaini" = <<lxXvaloresClvdiaini>>, "Cllist" = <<lxXvaloresCllist>>, "Clcp" = <<"'" + this.FormatearTextoSql( lxXvaloresClcp ) + "'">>, "Clvdias" = <<lxXvaloresClvdias>>, "Clvcod" = <<"'" + this.FormatearTextoSql( lxXvaloresClvcod ) + "'">>, "Clclas" = <<"'" + this.FormatearTextoSql( lxXvaloresClclas ) + "'">>, "Clcan4" = <<lxXvaloresClcan4>>, "Clvisualiz" = <<iif( lxXvaloresClvisualiz, 1, 0 )>>, "Opetar" = <<"'" + this.FormatearTextoSql( lxXvaloresOpetar ) + "'">>, "Persocomp" = <<iif( lxXvaloresPersocomp, 1, 0 )>>, "Eqepson" = <<lxXvaloresEqepson>>, "Noarrastra" = <<iif( lxXvaloresNoarrastra, 1, 0 )>>, "Eqibm" = <<lxXvaloresEqibm>>, "Tipotarj" = <<"'" + this.FormatearTextoSql( lxXvaloresTipotarj ) + "'">>, "Factelec" = <<"'" + this.FormatearTextoSql( lxXvaloresFactelec ) + "'">>, "Retiraefec" = <<iif( lxXvaloresRetiraefec, 1, 0 )>>, "Paguesea" = <<"'" + this.FormatearTextoSql( lxXvaloresPaguesea ) + "'">>, "Leyenda" = <<"'" + this.FormatearTextoSql( lxXvaloresLeyenda ) + "'">>, "Mntomaxret" = <<lxXvaloresMntomaxret>>, "Bcoadep" = <<"'" + this.FormatearTextoSql( lxXvaloresBcoadep ) + "'">>, "Ccadep" = <<"'" + this.FormatearTextoSql( lxXvaloresCcadep ) + "'">>, "Imprchqcf" = <<iif( lxXvaloresImprchqcf, 1, 0 )>>, "Valorretef" = <<"'" + this.FormatearTextoSql( lxXvaloresValorretef ) + "'">>, "Cldescp" = <<lxXvaloresCldescp>>, "Electro" = <<iif( lxXvaloresElectro, 1, 0 )>>, "Redondeo" = <<"'" + this.FormatearTextoSql( lxXvaloresRedondeo ) + "'">>, "Valoracred" = <<"'" + this.FormatearTextoSql( lxXvaloresValoracred ) + "'">>, "Noaplirc" = <<iif( lxXvaloresNoaplirc, 1, 0 )>>, "Arqtot" = <<iif( lxXvaloresArqtot, 1, 0 )>>, "Blomoddes" = <<iif( lxXvaloresBlomoddes, 1, 0 )>>, "Modifecha" = <<iif( lxXvaloresModifecha, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'XVALORES' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.TARJEACREDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.TARJEDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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

			lcFiltro = ["Clcod" = ] + lcValorClavePrimariaString  + [ and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.XVALORES where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.TARJEACREDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.TARJEDET where "Cod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'XVALORES' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.XVALORES where  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.XVALORES where CLCOD = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxXVALORESCLCLAS as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'VALOR'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.XVALORES Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.XVALORES set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, CLCUIT = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'"+ [, CLDIR = ] + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"+ [, CLCFI = ] + transform( &lcCursor..CLCFI )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CLPUN1 = ] + transform( &lcCursor..CLPUN1 )+ [, CLSER = ] + transform( &lcCursor..CLSER )+ [, CLVPORJ = ] + transform( &lcCursor..CLVPORJ )+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, CLTLF = ] + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'"+ [, CLOBS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'"+ [, CLCOBADE = ] + transform( &lcCursor..CLCOBADE )+ [, CLNOM = ] + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'"+ [, CLDTO = ] + transform( &lcCursor..CLDTO )+ [, CN1 = ] + transform( &lcCursor..CN1 )+ [, CLSER2 = ] + transform( &lcCursor..CLSER2 )+ [, COTIZAR = ] + Transform( iif( &lcCursor..COTIZAR, 1, 0 ))+ [, CLTCMADRE = ] + Transform( iif( &lcCursor..CLTCMADRE, 1, 0 ))+ [, pervuelto = ] + Transform( iif( &lcCursor..pervuelto, 1, 0 ))+ [, CLLOC = ] + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'"+ [, CLFAX = ] + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"+ [, ModoRedon = ] + transform( &lcCursor..ModoRedon )+ [, CLSMONET = ] + "'" + this.FormatearTextoSql( &lcCursor..CLSMONET ) + "'"+ [, CTABANC = ] + "'" + this.FormatearTextoSql( &lcCursor..CTABANC ) + "'"+ [, Prestador = ] + "'" + this.FormatearTextoSql( &lcCursor..Prestador ) + "'"+ [, CLGRUP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLGRUP ) + "'"+ [, CLVDIAINI = ] + transform( &lcCursor..CLVDIAINI )+ [, CLLIST = ] + transform( &lcCursor..CLLIST )+ [, CLCP = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"+ [, CLVDIAS = ] + transform( &lcCursor..CLVDIAS )+ [, CLVCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLVCOD ) + "'"+ [, CLCLAS = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'"+ [, CLCAN4 = ] + transform( &lcCursor..CLCAN4 )+ [, ClVisualiz = ] + Transform( iif( &lcCursor..ClVisualiz, 1, 0 ))+ [, opetar = ] + "'" + this.FormatearTextoSql( &lcCursor..opetar ) + "'"+ [, PersoComp = ] + Transform( iif( &lcCursor..PersoComp, 1, 0 ))+ [, EqEpson = ] + transform( &lcCursor..EqEpson )+ [, noarrastra = ] + Transform( iif( &lcCursor..noarrastra, 1, 0 ))+ [, EqIBM = ] + transform( &lcCursor..EqIBM )+ [, tipotarj = ] + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'"+ [, factelec = ] + "'" + this.FormatearTextoSql( &lcCursor..factelec ) + "'"+ [, RetiraEfec = ] + Transform( iif( &lcCursor..RetiraEfec, 1, 0 ))+ [, Paguesea = ] + "'" + this.FormatearTextoSql( &lcCursor..Paguesea ) + "'"+ [, leyenda = ] + "'" + this.FormatearTextoSql( &lcCursor..leyenda ) + "'"+ [, MntoMaxRet = ] + transform( &lcCursor..MntoMaxRet )+ [, bcoadep = ] + "'" + this.FormatearTextoSql( &lcCursor..bcoadep ) + "'"+ [, ccadep = ] + "'" + this.FormatearTextoSql( &lcCursor..ccadep ) + "'"+ [, ImprChqCF = ] + Transform( iif( &lcCursor..ImprChqCF, 1, 0 ))+ [, ValorRetEf = ] + "'" + this.FormatearTextoSql( &lcCursor..ValorRetEf ) + "'"+ [, CLDESCP = ] + transform( &lcCursor..CLDESCP )+ [, Electro = ] + Transform( iif( &lcCursor..Electro, 1, 0 ))+ [, Redondeo = ] + "'" + this.FormatearTextoSql( &lcCursor..Redondeo ) + "'"+ [, ValorAcred = ] + "'" + this.FormatearTextoSql( &lcCursor..ValorAcred ) + "'"+ [, NoApliRc = ] + Transform( iif( &lcCursor..NoApliRc, 1, 0 ))+ [, ArqTot = ] + Transform( iif( &lcCursor..ArqTot, 1, 0 ))+ [, BloModDes = ] + Transform( iif( &lcCursor..BloModDes, 1, 0 ))+ [, MODIFECHA = ] + Transform( iif( &lcCursor..MODIFECHA, 1, 0 )) + [ Where CLCOD = ] + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FALTAFW, FECTRANS, FECEXPO, FMODIFW, FECIMPO, CLCUIT, CLDIR, CLCFI, TIMESTAMP, CLPUN1, CLSER, CLVPORJ, HMODIFW, ESTTRANS, BDMODIFW, HORAEXPO, HALTAFW, HORAIMPO, BDALTAFW, VALTAFW, CLTLF, VMODIFW, ZADSFW, UMODIFW, SMODIFW, SALTAFW, UALTAFW, CLCOD, CLOBS, CLCOBADE, CLNOM, CLDTO, CN1, CLSER2, COTIZAR, CLTCMADRE, pervuelto, CLLOC, CLFAX, ModoRedon, CLSMONET, CTABANC, Prestador, CLGRUP, CLVDIAINI, CLLIST, CLCP, CLVDIAS, CLVCOD, CLCLAS, CLCAN4, ClVisualiz, opetar, PersoComp, EqEpson, noarrastra, EqIBM, tipotarj, factelec, RetiraEfec, Paguesea, leyenda, MntoMaxRet, bcoadep, ccadep, ImprChqCF, ValorRetEf, CLDESCP, Electro, Redondeo, ValorAcred, NoApliRc, ArqTot, BloModDes, MODIFECHA
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCUIT ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLDIR ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLCFI ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..CLPUN1 ) + ',' + transform( &lcCursor..CLSER ) + ',' + transform( &lcCursor..CLVPORJ ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLTLF ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLOBS ) + "'" + ',' + transform( &lcCursor..CLCOBADE )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLNOM ) + "'" + ',' + transform( &lcCursor..CLDTO ) + ',' + transform( &lcCursor..CN1 ) + ',' + transform( &lcCursor..CLSER2 ) + ',' + Transform( iif( &lcCursor..COTIZAR, 1, 0 )) + ',' + Transform( iif( &lcCursor..CLTCMADRE, 1, 0 )) + ',' + Transform( iif( &lcCursor..pervuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLLOC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLFAX ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..ModoRedon ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLSMONET ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CTABANC ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Prestador ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLGRUP ) + "'" + ',' + transform( &lcCursor..CLVDIAINI ) + ',' + transform( &lcCursor..CLLIST ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCP ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CLVDIAS ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLVCOD ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CLCLAS ) + "'" + ',' + transform( &lcCursor..CLCAN4 ) + ',' + Transform( iif( &lcCursor..ClVisualiz, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..opetar ) + "'" + ',' + Transform( iif( &lcCursor..PersoComp, 1, 0 )) + ',' + transform( &lcCursor..EqEpson )
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..noarrastra, 1, 0 )) + ',' + transform( &lcCursor..EqIBM ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..tipotarj ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..factelec ) + "'" + ',' + Transform( iif( &lcCursor..RetiraEfec, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Paguesea ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..leyenda ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MntoMaxRet ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..bcoadep ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ccadep ) + "'" + ',' + Transform( iif( &lcCursor..ImprChqCF, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValorRetEf ) + "'" + ',' + transform( &lcCursor..CLDESCP ) + ',' + Transform( iif( &lcCursor..Electro, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Redondeo ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ValorAcred ) + "'" + ',' + Transform( iif( &lcCursor..NoApliRc, 1, 0 )) + ',' + Transform( iif( &lcCursor..ArqTot, 1, 0 )) + ',' + Transform( iif( &lcCursor..BloModDes, 1, 0 )) + ',' + Transform( iif( &lcCursor..MODIFECHA, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.XVALORES ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TARJEACREDET Where Cod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.TARJEDET Where Cod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
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
			Case  lcAlias == lcPrefijo + 'ITEMACREDITACIONDEPLAN'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPLANDECUOTA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_XVALORES')

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
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_XVALORES') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_XVALORES
Create Table ZooLogic.TablaTrabajo_XVALORES ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"faltafw" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"clcuit" char( 15 )  null, 
"cldir" char( 70 )  null, 
"clcfi" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"clpun1" numeric( 5, 2 )  null, 
"clser" numeric( 2, 0 )  null, 
"clvporj" numeric( 2, 0 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"cltlf" char( 30 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"clcod" char( 5 )  null, 
"clobs" varchar(max)  null, 
"clcobade" numeric( 1, 0 )  null, 
"clnom" char( 30 )  null, 
"cldto" numeric( 5, 2 )  null, 
"cn1" numeric( 1, 0 )  null, 
"clser2" numeric( 2, 0 )  null, 
"cotizar" bit  null, 
"cltcmadre" bit  null, 
"pervuelto" bit  null, 
"clloc" char( 70 )  null, 
"clfax" char( 60 )  null, 
"modoredon" numeric( 1, 0 )  null, 
"clsmonet" char( 10 )  null, 
"ctabanc" char( 5 )  null, 
"prestador" char( 25 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"clgrup" char( 5 )  null, 
"clvdiaini" numeric( 2, 0 )  null, 
"cllist" numeric( 2, 0 )  null, 
"clcp" char( 8 )  null, 
"clvdias" numeric( 2, 0 )  null, 
"clvcod" char( 5 )  null, 
"clclas" char( 10 )  null, 
"clcan4" numeric( 10, 0 )  null, 
"clvisualiz" bit  null, 
"opetar" char( 15 )  null, 
"persocomp" bit  null, 
"eqepson" numeric( 2, 0 )  null, 
"noarrastra" bit  null, 
"eqibm" numeric( 2, 0 )  null, 
"tipotarj" char( 1 )  null, 
"factelec" char( 30 )  null, 
"retiraefec" bit  null, 
"paguesea" char( 50 )  null, 
"leyenda" char( 50 )  null, 
"mntomaxret" numeric( 15, 2 )  null, 
"bcoadep" char( 5 )  null, 
"ccadep" char( 25 )  null, 
"imprchqcf" bit  null, 
"valorretef" char( 5 )  null, 
"cldescp" numeric( 5, 2 )  null, 
"electro" bit  null, 
"redondeo" char( 10 )  null, 
"valoracred" char( 5 )  null, 
"noaplirc" bit  null, 
"arqtot" bit  null, 
"blomoddes" bit  null, 
"modifecha" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_XVALORES' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_XVALORES' )
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
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('clcuit','clcuit')
			.AgregarMapeo('cldir','cldir')
			.AgregarMapeo('clcfi','clcfi')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('clpun1','clpun1')
			.AgregarMapeo('clser','clser')
			.AgregarMapeo('clvporj','clvporj')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('cltlf','cltlf')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('clcod','clcod')
			.AgregarMapeo('clobs','clobs')
			.AgregarMapeo('clcobade','clcobade')
			.AgregarMapeo('clnom','clnom')
			.AgregarMapeo('cldto','cldto')
			.AgregarMapeo('cn1','cn1')
			.AgregarMapeo('clser2','clser2')
			.AgregarMapeo('cotizar','cotizar')
			.AgregarMapeo('cltcmadre','cltcmadre')
			.AgregarMapeo('pervuelto','pervuelto')
			.AgregarMapeo('clloc','clloc')
			.AgregarMapeo('clfax','clfax')
			.AgregarMapeo('modoredon','modoredon')
			.AgregarMapeo('clsmonet','clsmonet')
			.AgregarMapeo('ctabanc','ctabanc')
			.AgregarMapeo('prestador','prestador')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('clgrup','clgrup')
			.AgregarMapeo('clvdiaini','clvdiaini')
			.AgregarMapeo('cllist','cllist')
			.AgregarMapeo('clcp','clcp')
			.AgregarMapeo('clvdias','clvdias')
			.AgregarMapeo('clvcod','clvcod')
			.AgregarMapeo('clclas','clclas')
			.AgregarMapeo('clcan4','clcan4')
			.AgregarMapeo('clvisualiz','clvisualiz')
			.AgregarMapeo('opetar','opetar')
			.AgregarMapeo('persocomp','persocomp')
			.AgregarMapeo('eqepson','eqepson')
			.AgregarMapeo('noarrastra','noarrastra')
			.AgregarMapeo('eqibm','eqibm')
			.AgregarMapeo('tipotarj','tipotarj')
			.AgregarMapeo('factelec','factelec')
			.AgregarMapeo('retiraefec','retiraefec')
			.AgregarMapeo('paguesea','paguesea')
			.AgregarMapeo('leyenda','leyenda')
			.AgregarMapeo('mntomaxret','mntomaxret')
			.AgregarMapeo('bcoadep','bcoadep')
			.AgregarMapeo('ccadep','ccadep')
			.AgregarMapeo('imprchqcf','imprchqcf')
			.AgregarMapeo('valorretef','valorretef')
			.AgregarMapeo('cldescp','cldescp')
			.AgregarMapeo('electro','electro')
			.AgregarMapeo('redondeo','redondeo')
			.AgregarMapeo('valoracred','valoracred')
			.AgregarMapeo('noaplirc','noaplirc')
			.AgregarMapeo('arqtot','arqtot')
			.AgregarMapeo('blomoddes','blomoddes')
			.AgregarMapeo('modifecha','modifecha')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_XVALORES'
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
				Update t Set t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.CLCUIT = isnull( d.CLCUIT, t.CLCUIT ),t.CLDIR = isnull( d.CLDIR, t.CLDIR ),t.CLCFI = isnull( d.CLCFI, t.CLCFI ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CLPUN1 = isnull( d.CLPUN1, t.CLPUN1 ),t.CLSER = isnull( d.CLSER, t.CLSER ),t.CLVPORJ = isnull( d.CLVPORJ, t.CLVPORJ ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.CLTLF = isnull( d.CLTLF, t.CLTLF ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.CLCOD = isnull( d.CLCOD, t.CLCOD ),t.CLOBS = isnull( d.CLOBS, t.CLOBS ),t.CLCOBADE = isnull( d.CLCOBADE, t.CLCOBADE ),t.CLNOM = isnull( d.CLNOM, t.CLNOM ),t.CLDTO = isnull( d.CLDTO, t.CLDTO ),t.CN1 = isnull( d.CN1, t.CN1 ),t.CLSER2 = isnull( d.CLSER2, t.CLSER2 ),t.COTIZAR = isnull( d.COTIZAR, t.COTIZAR ),t.CLTCMADRE = isnull( d.CLTCMADRE, t.CLTCMADRE ),t.PERVUELTO = isnull( d.PERVUELTO, t.PERVUELTO ),t.CLLOC = isnull( d.CLLOC, t.CLLOC ),t.CLFAX = isnull( d.CLFAX, t.CLFAX ),t.MODOREDON = isnull( d.MODOREDON, t.MODOREDON ),t.CLSMONET = isnull( d.CLSMONET, t.CLSMONET ),t.CTABANC = isnull( d.CTABANC, t.CTABANC ),t.PRESTADOR = isnull( d.PRESTADOR, t.PRESTADOR ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.CLGRUP = isnull( d.CLGRUP, t.CLGRUP ),t.CLVDIAINI = isnull( d.CLVDIAINI, t.CLVDIAINI ),t.CLLIST = isnull( d.CLLIST, t.CLLIST ),t.CLCP = isnull( d.CLCP, t.CLCP ),t.CLVDIAS = isnull( d.CLVDIAS, t.CLVDIAS ),t.CLVCOD = isnull( d.CLVCOD, t.CLVCOD ),t.CLCLAS = isnull( d.CLCLAS, t.CLCLAS ),t.CLCAN4 = isnull( d.CLCAN4, t.CLCAN4 ),t.CLVISUALIZ = isnull( d.CLVISUALIZ, t.CLVISUALIZ ),t.OPETAR = isnull( d.OPETAR, t.OPETAR ),t.PERSOCOMP = isnull( d.PERSOCOMP, t.PERSOCOMP ),t.EQEPSON = isnull( d.EQEPSON, t.EQEPSON ),t.NOARRASTRA = isnull( d.NOARRASTRA, t.NOARRASTRA ),t.EQIBM = isnull( d.EQIBM, t.EQIBM ),t.TIPOTARJ = isnull( d.TIPOTARJ, t.TIPOTARJ ),t.FACTELEC = isnull( d.FACTELEC, t.FACTELEC ),t.RETIRAEFEC = isnull( d.RETIRAEFEC, t.RETIRAEFEC ),t.PAGUESEA = isnull( d.PAGUESEA, t.PAGUESEA ),t.LEYENDA = isnull( d.LEYENDA, t.LEYENDA ),t.MNTOMAXRET = isnull( d.MNTOMAXRET, t.MNTOMAXRET ),t.BCOADEP = isnull( d.BCOADEP, t.BCOADEP ),t.CCADEP = isnull( d.CCADEP, t.CCADEP ),t.IMPRCHQCF = isnull( d.IMPRCHQCF, t.IMPRCHQCF ),t.VALORRETEF = isnull( d.VALORRETEF, t.VALORRETEF ),t.CLDESCP = isnull( d.CLDESCP, t.CLDESCP ),t.ELECTRO = isnull( d.ELECTRO, t.ELECTRO ),t.REDONDEO = isnull( d.REDONDEO, t.REDONDEO ),t.VALORACRED = isnull( d.VALORACRED, t.VALORACRED ),t.NOAPLIRC = isnull( d.NOAPLIRC, t.NOAPLIRC ),t.ARQTOT = isnull( d.ARQTOT, t.ARQTOT ),t.BLOMODDES = isnull( d.BLOMODDES, t.BLOMODDES ),t.MODIFECHA = isnull( d.MODIFECHA, t.MODIFECHA )
					from ZooLogic.XVALORES t inner join deleted d 
							 on t.CLCOD = d.CLCOD
				-- Fin Updates
				insert into ZooLogic.XVALORES(Faltafw,Fectrans,Fecexpo,Fmodifw,Fecimpo,Clcuit,Cldir,Clcfi,Timestamp,Clpun1,Clser,Clvporj,Hmodifw,Esttrans,Bdmodifw,Horaexpo,Haltafw,Horaimpo,Bdaltafw,Valtafw,Cltlf,Vmodifw,Zadsfw,Umodifw,Smodifw,Saltafw,Ualtafw,Clcod,Clobs,Clcobade,Clnom,Cldto,Cn1,Clser2,Cotizar,Cltcmadre,Pervuelto,Clloc,Clfax,Modoredon,Clsmonet,Ctabanc,Prestador,Idcaja,Clgrup,Clvdiaini,Cllist,Clcp,Clvdias,Clvcod,Clclas,Clcan4,Clvisualiz,Opetar,Persocomp,Eqepson,Noarrastra,Eqibm,Tipotarj,Factelec,Retiraefec,Paguesea,Leyenda,Mntomaxret,Bcoadep,Ccadep,Imprchqcf,Valorretef,Cldescp,Electro,Redondeo,Valoracred,Noaplirc,Arqtot,Blomoddes,Modifecha)
					Select CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.CLCUIT,''),isnull( d.CLDIR,''),isnull( d.CLCFI,0),isnull( d.TIMESTAMP,0),isnull( d.CLPUN1,0),isnull( d.CLSER,0),isnull( d.CLVPORJ,0),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.VALTAFW,''),isnull( d.CLTLF,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.UALTAFW,''),isnull( d.CLCOD,''),isnull( d.CLOBS,''),isnull( d.CLCOBADE,0),isnull( d.CLNOM,''),isnull( d.CLDTO,0),isnull( d.CN1,0),isnull( d.CLSER2,0),isnull( d.COTIZAR,0),isnull( d.CLTCMADRE,0),isnull( d.PERVUELTO,0),isnull( d.CLLOC,''),isnull( d.CLFAX,''),isnull( d.MODOREDON,0),isnull( d.CLSMONET,''),isnull( d.CTABANC,''),isnull( d.PRESTADOR,''),isnull( d.IDCAJA,0),isnull( d.CLGRUP,''),isnull( d.CLVDIAINI,0),isnull( d.CLLIST,0),isnull( d.CLCP,''),isnull( d.CLVDIAS,0),isnull( d.CLVCOD,''),isnull( d.CLCLAS,''),isnull( d.CLCAN4,0),isnull( d.CLVISUALIZ,0),isnull( d.OPETAR,''),isnull( d.PERSOCOMP,0),isnull( d.EQEPSON,0),isnull( d.NOARRASTRA,0),isnull( d.EQIBM,0),isnull( d.TIPOTARJ,''),isnull( d.FACTELEC,''),isnull( d.RETIRAEFEC,0),isnull( d.PAGUESEA,''),isnull( d.LEYENDA,''),isnull( d.MNTOMAXRET,0),isnull( d.BCOADEP,''),isnull( d.CCADEP,''),isnull( d.IMPRCHQCF,0),isnull( d.VALORRETEF,''),isnull( d.CLDESCP,0),isnull( d.ELECTRO,0),isnull( d.REDONDEO,''),isnull( d.VALORACRED,''),isnull( d.NOAPLIRC,0),isnull( d.ARQTOT,0),isnull( d.BLOMODDES,0),isnull( d.MODIFECHA,0)
						From deleted d left join ZooLogic.XVALORES pk 
							 on d.CLCOD = pk.CLCOD
						Where pk.CLCOD Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_TARJEACREDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_XVALORES_TARJEACREDET
ON ZooLogic.TablaTrabajo_XVALORES_TARJEACREDET
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
	function ObtenerTriggerDeleteImportacion_TARJEDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_XVALORES_TARJEDET
ON ZooLogic.TablaTrabajo_XVALORES_TARJEDET
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
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_XVALORES') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_XVALORES
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
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_VALOR.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_VALOR.Cuit, [] )
					.Direccion = nvl( c_VALOR.Direccion, [] )
					.Tipo = nvl( c_VALOR.Tipo, 0 )
					.Timestamp = nvl( c_VALOR.Timestamp, 0 )
					.Descuentosobrebruto = nvl( c_VALOR.Descuentosobrebruto, 0 )
					.Diaspresentacion1 = nvl( c_VALOR.Diaspresentacion1, 0 )
					.Diasacreditacion = nvl( c_VALOR.Diasacreditacion, 0 )
					.Horamodificacionfw = nvl( c_VALOR.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_VALOR.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_VALOR.Basededatosmodificacionfw, [] )
					.Horaexpo = nvl( c_VALOR.Horaexpo, [] )
					.Horaaltafw = nvl( c_VALOR.Horaaltafw, [] )
					.Horaimpo = nvl( c_VALOR.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_VALOR.Basededatosaltafw, [] )
					.Versionaltafw = nvl( c_VALOR.Versionaltafw, [] )
					.Telefono = nvl( c_VALOR.Telefono, [] )
					.Versionmodificacionfw = nvl( c_VALOR.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_VALOR.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_VALOR.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_VALOR.Seriealtafw, [] )
					.Usuarioaltafw = nvl( c_VALOR.Usuarioaltafw, [] )
					.Codigo = nvl( c_VALOR.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Cobroadelantado = nvl( c_VALOR.Cobroadelantado, 0 )
					.Descripcion = nvl( c_VALOR.Descripcion, [] )
					.Descuentoadelantado = nvl( c_VALOR.Descuentoadelantado, 0 )
					.Habiles = nvl( c_VALOR.Habiles, 0 )
					.Diaspresentacion2 = nvl( c_VALOR.Diaspresentacion2, 0 )
					.Pidecotizacion = nvl( c_VALOR.Pidecotizacion, .F. )
					.Tarjetamadre = nvl( c_VALOR.Tarjetamadre, .F. )
					.Permitevuelto = nvl( c_VALOR.Permitevuelto, .F. )
					.Localidad = nvl( c_VALOR.Localidad, [] )
					.Fax = nvl( c_VALOR.Fax, [] )
					.Modoredondeo = nvl( c_VALOR.Modoredondeo, 0 )
					.Detalleacreditacionplanes.Limpiar()
					.Detalleacreditacionplanes.SetearEsNavegacion( .lProcesando )
					.Detalleacreditacionplanes.Cargar()
					.Simbolomonetario_PK =  nvl( c_VALOR.Simbolomonetario, [] )
					.Cuentabancaria_PK =  nvl( c_VALOR.Cuentabancaria, [] )
					.Prestador = nvl( c_VALOR.Prestador, [] )
					.Caja_PK =  nvl( c_VALOR.Caja, 0 )
					.Grupo_PK =  nvl( c_VALOR.Grupo, [] )
					.Diasentrecuotas = nvl( c_VALOR.Diasentrecuotas, 0 )
					.Diaspresentacion3 = nvl( c_VALOR.Diaspresentacion3, 0 )
					.Codigopostal = nvl( c_VALOR.Codigopostal, [] )
					.Detalleplanes.Limpiar()
					.Detalleplanes.SetearEsNavegacion( .lProcesando )
					.Detalleplanes.Cargar()
					.Diaspresentacion4 = nvl( c_VALOR.Diaspresentacion4, 0 )
					.Sedepositaenbanco_PK =  nvl( c_VALOR.Sedepositaenbanco, [] )
					.Clasificacion_PK =  nvl( c_VALOR.Clasificacion, [] )
					.Generacanje = nvl( c_VALOR.Generacanje, 0 )
					.Visualizarencaja = nvl( c_VALOR.Visualizarencaja, .F. )
					.Operadoratarjeta_PK =  nvl( c_VALOR.Operadoratarjeta, [] )
					.Personalizarcomprobante = nvl( c_VALOR.Personalizarcomprobante, .F. )
					.Equivcfepson = nvl( c_VALOR.Equivcfepson, 0 )
					.Arrastrasaldo = nvl( c_VALOR.Arrastrasaldo, .F. )
					.Equivcfibm = nvl( c_VALOR.Equivcfibm, 0 )
					.Tipotarjeta = nvl( c_VALOR.Tipotarjeta, [] )
					.Facturaelectronica = nvl( c_VALOR.Facturaelectronica, [] )
					.Habilitarretiroefectivo = nvl( c_VALOR.Habilitarretiroefectivo, .F. )
					.Paguesea = nvl( c_VALOR.Paguesea, [] )
					.Leyenda = nvl( c_VALOR.Leyenda, [] )
					.Montomaximoderetiro = nvl( c_VALOR.Montomaximoderetiro, 0 )
					.Bcoadep_PK =  nvl( c_VALOR.Bcoadep, [] )
					.Ctacteadep = nvl( c_VALOR.Ctacteadep, [] )
					.Imprimechequecfiscal = nvl( c_VALOR.Imprimechequecfiscal, .F. )
					.Valorpararetirodeefectivo_PK =  nvl( c_VALOR.Valorpararetirodeefectivo, [] )
					.Descuento = nvl( c_VALOR.Descuento, 0 )
					.Chequeelectronico = nvl( c_VALOR.Chequeelectronico, .F. )
					.Redondeo_PK =  nvl( c_VALOR.Redondeo, [] )
					.Valordeacreditacion_PK =  nvl( c_VALOR.Valordeacreditacion, [] )
					.Noaplicarenrecibos = nvl( c_VALOR.Noaplicarenrecibos, .F. )
					.Arqueoportotales = nvl( c_VALOR.Arqueoportotales, .F. )
					.Bloqueamodificaciondescripcion = nvl( c_VALOR.Bloqueamodificaciondescripcion, .F. )
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.XVALORES' )
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
								from ZooLogic.XVALORES 
								Where   XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "XVALORES", "", lcCursor, set("Datasession") )
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
			"Faltafw" as "Fechaaltafw", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Clcuit" as "Cuit", "Cldir" as "Direccion", "Clcfi" as "Tipo", "Timestamp" as "Timestamp", "Clpun1" as "Descuentosobrebruto", "Clser" as "Diaspresentacion1", "Clvporj" as "Diasacreditacion", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Cltlf" as "Telefono", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Ualtafw" as "Usuarioaltafw", "Clcod" as "Codigo", "Clobs" as "Observacion", "Clcobade" as "Cobroadelantado", "Clnom" as "Descripcion", "Cldto" as "Descuentoadelantado", "Cn1" as "Habiles", "Clser2" as "Diaspresentacion2", "Cotizar" as "Pidecotizacion", "Cltcmadre" as "Tarjetamadre", "Pervuelto" as "Permitevuelto", "Clloc" as "Localidad", "Clfax" as "Fax", "Modoredon" as "Modoredondeo", "Clsmonet" as "Simbolomonetario", "Ctabanc" as "Cuentabancaria", "Prestador" as "Prestador", "Idcaja" as "Caja", "Clgrup" as "Grupo", "Clvdiaini" as "Diasentrecuotas", "Cllist" as "Diaspresentacion3", "Clcp" as "Codigopostal", "Clvdias" as "Diaspresentacion4", "Clvcod" as "Sedepositaenbanco", "Clclas" as "Clasificacion", "Clcan4" as "Generacanje", "Clvisualiz" as "Visualizarencaja", "Opetar" as "Operadoratarjeta", "Persocomp" as "Personalizarcomprobante", "Eqepson" as "Equivcfepson", "Noarrastra" as "Arrastrasaldo", "Eqibm" as "Equivcfibm", "Tipotarj" as "Tipotarjeta", "Factelec" as "Facturaelectronica", "Retiraefec" as "Habilitarretiroefectivo", "Paguesea" as "Paguesea", "Leyenda" as "Leyenda", "Mntomaxret" as "Montomaximoderetiro", "Bcoadep" as "Bcoadep", "Ccadep" as "Ctacteadep", "Imprchqcf" as "Imprimechequecfiscal", "Valorretef" as "Valorpararetirodeefectivo", "Cldescp" as "Descuento", "Electro" as "Chequeelectronico", "Redondeo" as "Redondeo", "Valoracred" as "Valordeacreditacion", "Noaplirc" as "Noaplicarenrecibos", "Arqtot" as "Arqueoportotales", "Blomoddes" as "Bloqueamodificaciondescripcion", "Modifecha" as "Permitemodificarfecha"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.XVALORES 
								Where   XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''
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
	Tabla = 'XVALORES'
	Filtro = " XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " XVALORES.CLCOD != '' AND XVALORES.CLCOD != ''"
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
	<row entidad="VALOR                                   " atributo="FECHAALTAFW                             " tabla="XVALORES       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHADEALTA                             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHATRANSFERENCIA                      " tabla="XVALORES       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAEXPO                               " tabla="XVALORES       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAMODIFICACIONFW                     " tabla="XVALORES       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAULTIMAMODIFICACION                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FECHAIMPO                               " tabla="XVALORES       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CUIT                                    " tabla="XVALORES       " campo="CLCUIT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Cuit                                                                                                                                                            " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOENDOSABLE                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo Endosable                                                                                                                                                  " dominio="TIPOVALORENDOSABLE            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIRECCION                               " tabla="XVALORES       " campo="CLDIR     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Dirección                                                                                                                                                       " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPO                                    " tabla="XVALORES       " campo="CLCFI     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Tipo                                                                                                                                                            " dominio="COMBOTIPODEVALORES            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIMESTAMP                               " tabla="XVALORES       " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCUENTOSOBREBRUTO                     " tabla="XVALORES       " campo="CLPUN1    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Descuento sobre el bruto presentado                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIASPRESENTACION1                       " tabla="XVALORES       " campo="CLSER     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Día 1                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIASACREDITACION                        " tabla="XVALORES       " campo="CLVPORJ   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Días Acreditación                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAMODIFICACIONFW                      " tabla="XVALORES       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ESTADOTRANSFERENCIA                     " tabla="XVALORES       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="XVALORES       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAEXPO                                " tabla="XVALORES       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAALTAFW                              " tabla="XVALORES       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HORAIMPO                                " tabla="XVALORES       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BASEDEDATOSALTAFW                       " tabla="XVALORES       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VERSIONALTAFW                           " tabla="XVALORES       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TELEFONO                                " tabla="XVALORES       " campo="CLTLF     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Teléfono                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VERSIONMODIFICACIONFW                   " tabla="XVALORES       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ZADSFW                                  " tabla="XVALORES       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="USUARIOMODIFICACIONFW                   " tabla="XVALORES       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SERIEMODIFICACIONFW                     " tabla="XVALORES       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SERIEALTAFW                             " tabla="XVALORES       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="USUARIOALTAFW                           " tabla="XVALORES       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CODIGO                                  " tabla="XVALORES       " campo="CLCOD     " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="OBSERVACION                             " tabla="XVALORES       " campo="CLOBS     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="COBROADELANTADO                         " tabla="XVALORES       " campo="CLCOBADE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cobro Adelantado                                                                                                                                                " dominio="SINONUM                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCRIPCION                             " tabla="XVALORES       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCUENTOADELANTADO                     " tabla="XVALORES       " campo="CLDTO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="% Descuento Adelantado                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HABILES                                 " tabla="XVALORES       " campo="CN1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Tipo                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIASPRESENTACION2                       " tabla="XVALORES       " campo="CLSER2    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Día 2                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PIDECOTIZACION                          " tabla="XVALORES       " campo="COTIZAR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Pedir Cotización                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="5" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TARJETAMADRE                            " tabla="XVALORES       " campo="CLTCMADRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tarjeta Madre                                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PERMITEVUELTO                           " tabla="XVALORES       " campo="PERVUELTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="406" etiqueta="Permite vuelto                                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="LOCALIDAD                               " tabla="XVALORES       " campo="CLLOC     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="70" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Localidad                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FAX                                     " tabla="XVALORES       " campo="CLFAX     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Fax                                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="MODOREDONDEO                            " tabla="XVALORES       " campo="MODOREDON " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="410" etiqueta="Aplica a                                                                                                                                                        " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DETALLEACREDITACIONPLANES               " tabla="TARJEACREDET   " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Datos de acreditación de planes                                                                                                                                 " dominio="DETALLEITEMACREDITACIONDEPLAN " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SIMBOLOMONETARIO                        " tabla="XVALORES       " campo="CLSMONET  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CUENTABANCARIA                          " tabla="XVALORES       " campo="CTABANC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CUENTABANCARIA                          " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="414" etiqueta="Cuenta bancaria                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="7" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PRESTADOR                               " tabla="XVALORES       " campo="PRESTADOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Prestador                                                                                                                                                       " dominio="COMBOPRESTADOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CAJA                                    " tabla="XVALORES       " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Número de Caja                                                                                                                                                  " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="GRUPO                                   " tabla="XVALORES       " campo="CLGRUP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPOVALOR                              " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Sumarizar en grupo                                                                                                                                              " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIASENTRECUOTAS                         " tabla="XVALORES       " campo="CLVDIAINI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="30                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="Días Entre Cuotas                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIASPRESENTACION3                       " tabla="XVALORES       " campo="CLLIST    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Día 3                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CODIGOPOSTAL                            " tabla="XVALORES       " campo="CLCP      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Código Postal                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DETALLEPLANES                           " tabla="TARJEDET       " campo="COD       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Cuotas y recargos                                                                                                                                               " dominio="DETALLEITEMPLANDECUOTA        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOTARJETAPOINT                        " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Tipo tarjetas                                                                                                                                                   " dominio="COMBOTIPOTARJETA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="6" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DIASPRESENTACION4                       " tabla="XVALORES       " campo="CLVDIAS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Día 4                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="SEDEPOSITAENBANCO                       " tabla="XVALORES       " campo="CLVCOD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="BANCO                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Se deposita en el Banco                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CLASIFICACION                           " tabla="XVALORES       " campo="CLCLAS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONCLIENTE                    " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Clasificación                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="GENERACANJE                             " tabla="XVALORES       " campo="CLCAN4    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="0" etiqueta="Genera Canje                                                                                                                                                    " dominio="SINOGENERICO                  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VISUALIZARENCAJA                        " tabla="XVALORES       " campo="CLVISUALIZ" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="430" etiqueta="Visualizar en estado de caja                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="OPERADORATARJETA                        " tabla="XVALORES       " campo="OPETAR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="OPERADORADETARJETA                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Operadora de la tarjeta                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PERSONALIZARCOMPROBANTE                 " tabla="XVALORES       " campo="PERSOCOMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="434" etiqueta="Personalizar Comprobante                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="EQUIVCFEPSON                            " tabla="XVALORES       " campo="EQEPSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Controladores fiscales R.G. 3561/13                                                                                                                             " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ARRASTRASALDO                           " tabla="XVALORES       " campo="NOARRASTRA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Arrastrar saldo al cerrar la caja                                                                                                                               " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="EQUIVCFIBM                              " tabla="XVALORES       " campo="EQIBM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Controlador fiscal IBM                                                                                                                                          " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="TIPOTARJETA                             " tabla="XVALORES       " campo="TIPOTARJ  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Tipo tarjeta                                                                                                                                                    " dominio="COMBOTIPOTARJETA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="FACTURAELECTRONICA                      " tabla="XVALORES       " campo="FACTELEC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Factura electrónica                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="HABILITARRETIROEFECTIVO                 " tabla="XVALORES       " campo="RETIRAEFEC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="446" etiqueta="Habilita retiro de efectivo                                                                                                                                     " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="8" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PAGUESEA                                " tabla="XVALORES       " campo="PAGUESEA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Paguese a                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="LEYENDA                                 " tabla="XVALORES       " campo="LEYENDA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Leyenda                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="MONTOMAXIMODERETIRO                     " tabla="XVALORES       " campo="MNTOMAXRET" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Monto máximo de retiro                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="8" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BCOADEP                                 " tabla="XVALORES       " campo="BCOADEP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ENTIDADFINANCIERA                       " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Banco a depositar                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CTACTEADEP                              " tabla="XVALORES       " campo="CCADEP    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cuenta a depositar                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="11" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="IMPRIMECHEQUECFISCAL                    " tabla="XVALORES       " campo="IMPRCHQCF " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Imprime Cheque C. Fiscal                                                                                                                                        " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VALORPARARETIRODEEFECTIVO               " tabla="XVALORES       " campo="VALORRETEF" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Valor para retiro de efectivo                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; xVal.CLCFI = 1&quot;                                                                                                                                                                                       " grupo="8" subgrupo="2" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="DESCUENTO                               " tabla="XVALORES       " campo="CLDESCP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Porcentaje de descuento en ventas                                                                                                                               " dominio="DESCUENTOVALOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="CHEQUEELECTRONICO                       " tabla="XVALORES       " campo="ELECTRO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Cheque electrónico                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="REDONDEO                                " tabla="XVALORES       " campo="REDONDEO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="REDONDEODEPRECIOS                       " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Código de redondeo                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="VALORDEACREDITACION                     " tabla="XVALORES       " campo="VALORACRED" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Valor de acreditación                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="&quot; xVal.CLCFI = 3&quot;                                                                                                                                                                                       " grupo="8" subgrupo="2" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="NOAPLICARENRECIBOS                      " tabla="XVALORES       " campo="NOAPLIRC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="460" etiqueta="No aplicar en recibos                                                                                                                                           " dominio="DESCUENTOVALOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="ARQUEOPORTOTALES                        " tabla="XVALORES       " campo="ARQTOT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Arqueo por totales                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="BLOQUEAMODIFICACIONDESCRIPCION          " tabla="XVALORES       " campo="BLOMODDES " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="464" etiqueta="Salto de campo en descripción                                                                                                                                   " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VALOR                                   " atributo="PERMITEMODIFICARFECHA                   " tabla="XVALORES       " campo="MODIFECHA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.F.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="466" etiqueta="Permite modificar la fecha                                                                                                                                      " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On XVALORES.CLSMONET = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                               " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CUENTABANCARIA                          " atributo="DESCRIPCION                             " tabla="CTABAN         " campo="CBDES     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Cue.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CTABAN On XVALORES.CTABANC = CTABAN.CBCod And  CTABAN.CBCOD != ''                                                                                                                                                                                  " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CAJAESTADO                              " atributo="DESCRIPCION                             " tabla="CAJAESTA       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Núm.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CAJAESTA On XVALORES.IDCAJA = CAJAESTA.NumCaja And  CAJAESTA.NUMCAJA != 0                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPOVALOR                              " atributo="DESCRIPCION                             " tabla="GRUPOVALOR     " campo="GRUNOM    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Sum.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPOVALOR On XVALORES.CLGRUP = GRUPOVALOR.Codigo And  GRUPOVALOR.CODIGO != ''                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONCLIENTE                    " atributo="DESCRIPCION                             " tabla="CLASIF         " campo="CLADES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIF On XVALORES.CLCLAS = CLASIF.CLACOD And  CLASIF.CLACOD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="OPERADORADETARJETA                      " atributo="DESCRIPCION                             " tabla="OPETAR         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Ope.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join OPETAR On XVALORES.OPETAR = OPETAR.Codigo And  OPETAR.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="REDONDEODEPRECIOS                       " atributo="DESCRIPCION                             " tabla="REDO           " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="457" etiqueta="Detalle Cód.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join REDO On XVALORES.REDONDEO = REDO.codigo And  REDO.CODIGO != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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