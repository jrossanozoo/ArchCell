
define class Din_EntidadLISTADOSPERSONALIZADOSAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_LISTADOSPERSONALIZADOS'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_LPZPK'
	cTablaPrincipal = 'LTDSPERS'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
				.cUbicacionDB = 'ORGANIZACION'
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ORGANIZACION'
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
			local  lxLtdspersFecexpo, lxLtdspersFectrans, lxLtdspersFecimpo, lxLtdspersFaltafw, lxLtdspersFmodifw, lxLtdspersHoraexpo, lxLtdspersHaltafw, lxLtdspersBdaltafw, lxLtdspersEsttrans, lxLtdspersBdmodifw, lxLtdspersHoraimpo, lxLtdspersUmodifw, lxLtdspersValtafw, lxLtdspersVmodifw, lxLtdspersZadsfw, lxLtdspersSmodifw, lxLtdspersUaltafw, lxLtdspersSaltafw, lxLtdspersHmodifw, lxLtdspersAnulado, lxLtdspersBloqreg, lxLtdspersColsubrecp, lxLtdspersRepecabgru, lxLtdspersColgrupocp, lxLtdspersPagsimple, lxLtdspersMantgruni, lxLtdspersEncreporte, lxLtdspersTranspag, lxLtdspersEncpagina, lxLtdspersFechaimpre, lxLtdspersInfcorrida, lxLtdspersResumenrep, lxLtdspersEncdetalle, lxLtdspersHoraimpre, lxLtdspersInfocontex, lxLtdspersCcod, lxLtdspersMpara, lxLtdspersClistado, lxLtdspersEsdefault, lxLtdspersCestilo, lxLtdspersIdentifica, lxLtdspersMasunto, lxLtdspersMder, lxLtdspersMizq, lxLtdspersMpie, lxLtdspersMcab, lxLtdspersOrien, lxLtdspersMcc, lxLtdspersDescrip, lxLtdspersOrdpor, lxLtdspersTipord, lxLtdspersTitulo, lxLtdspersImagen, lxLtdspersMcco, lxLtdspersDbdato, lxLtdspersDstnotip, lxLtdspersDstnorut, lxLtdspersMensaje, lxLtdspersDbdatod, lxLtdspersDstnoarc, lxLtdspersDstnofh, lxLtdspersSubtdetall, lxLtdspersObs, lxLtdspersDdetalle, lxLtdspersColorsombr
				lxLtdspersFecexpo =  .Fechaexpo			lxLtdspersFectrans =  .Fechatransferencia			lxLtdspersFecimpo =  .Fechaimpo			lxLtdspersFaltafw =  .Fechaaltafw			lxLtdspersFmodifw =  .Fechamodificacionfw			lxLtdspersHoraexpo =  .Horaexpo			lxLtdspersHaltafw =  .Horaaltafw			lxLtdspersBdaltafw =  .Basededatosaltafw			lxLtdspersEsttrans =  .Estadotransferencia			lxLtdspersBdmodifw =  .Basededatosmodificacionfw			lxLtdspersHoraimpo =  .Horaimpo			lxLtdspersUmodifw =  .Usuariomodificacionfw			lxLtdspersValtafw =  .Versionaltafw			lxLtdspersVmodifw =  .Versionmodificacionfw			lxLtdspersZadsfw =  .Zadsfw			lxLtdspersSmodifw =  .Seriemodificacionfw			lxLtdspersUaltafw =  .Usuarioaltafw			lxLtdspersSaltafw =  .Seriealtafw			lxLtdspersHmodifw =  .Horamodificacionfw			lxLtdspersAnulado =  .Anulado			lxLtdspersBloqreg =  .Bloquearregistro			lxLtdspersColsubrecp =  .Titulosdecolumnasdesubreporteencp			lxLtdspersRepecabgru =  .Repetircabecerasdegrupos			lxLtdspersColgrupocp =  .Titulosdecolumnasdegrupoencp			lxLtdspersPagsimple =  .Numeraciondepaginasimple			lxLtdspersMantgruni =  .Mantenergruposunidos			lxLtdspersEncreporte =  .Imprimeencabezadodereporte			lxLtdspersTranspag =  .Usatransporteentrepaginas			lxLtdspersEncpagina =  .Imprimeencabezadodepagina			lxLtdspersFechaimpre =  .Imprimefechadeimpresion			lxLtdspersInfcorrida =  .Imprimeinformaciondecorrida			lxLtdspersResumenrep =  .Imprimeresumendereporte			lxLtdspersEncdetalle =  .Imprimeencabezadodedetalle			lxLtdspersHoraimpre =  .Imprimehoradeimpresion			lxLtdspersInfocontex =  .Imprimeinformaciondecontexto			lxLtdspersCcod =  .Codigo			lxLtdspersMpara =  .Mailpara			lxLtdspersClistado =  .Clistado			lxLtdspersEsdefault =  .Esdefault			lxLtdspersCestilo =  upper( .Estilo_PK ) 			lxLtdspersIdentifica =  .Identificadorordenamiento			lxLtdspersMasunto =  .Mailasunto			lxLtdspersMder =  .Margenderecho			lxLtdspersMizq =  .Margenizquierdo			lxLtdspersMpie =  .Margenpie			lxLtdspersMcab =  .Margencabecera			lxLtdspersOrien =  .Orientacion			lxLtdspersMcc =  .Mailconcopia			lxLtdspersDescrip =  .Descripcion			lxLtdspersOrdpor =  .Ordenadopor			lxLtdspersTipord =  .Tipoordenamiento			lxLtdspersTitulo =  .Titulolistado			lxLtdspersImagen =  .Imagenlistado			lxLtdspersMcco =  .Mailconcopiaoculta			lxLtdspersDbdato =  .Basededatos			lxLtdspersDstnotip =  .Destinotipo			lxLtdspersDstnorut =  .Destinoruta			lxLtdspersMensaje =  .Mailmensaje			lxLtdspersDbdatod =  .Basededatosdetallada			lxLtdspersDstnoarc =  .Destinoarchivo			lxLtdspersDstnofh =  .Destinofechahora			lxLtdspersSubtdetall =  .Subtotaldetallado			lxLtdspersObs =  .Observacion			lxLtdspersDdetalle =  .Diferenciardetalle			lxLtdspersColorsombr =  .Colorparaelsombreado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxLtdspersCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.LTDSPERS ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Horaexpo","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Horaimpo","Umodifw","Valtafw","Vmodifw","Zadsfw","Smodifw","Ualtafw","Saltafw","Hmodifw","Anulado","Bloqreg","Colsubrecp","Repecabgru","Colgrupocp","Pagsimple","Mantgruni","Encreporte","Transpag","Encpagina","Fechaimpre","Infcorrida","Resumenrep","Encdetalle","Horaimpre","Infocontex","Ccod","Mpara","Clistado","Esdefault","Cestilo","Identifica","Masunto","Mder","Mizq","Mpie","Mcab","Orien","Mcc","Descrip","Ordpor","Tipord","Titulo","Imagen","Mcco","Dbdato","Dstnotip","Dstnorut","Mensaje","Dbdatod","Dstnoarc","Dstnofh","Subtdetall","Obs","Ddetalle","Colorsombr" ) values ( <<"'" + this.ConvertirDateSql( lxLtdspersFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHmodifw ) + "'" >>, <<iif( lxLtdspersAnulado, 1, 0 ) >>, <<iif( lxLtdspersBloqreg, 1, 0 ) >>, <<iif( lxLtdspersColsubrecp, 1, 0 ) >>, <<iif( lxLtdspersRepecabgru, 1, 0 ) >>, <<iif( lxLtdspersColgrupocp, 1, 0 ) >>, <<iif( lxLtdspersPagsimple, 1, 0 ) >>, <<iif( lxLtdspersMantgruni, 1, 0 ) >>, <<iif( lxLtdspersEncreporte, 1, 0 ) >>, <<iif( lxLtdspersTranspag, 1, 0 ) >>, <<iif( lxLtdspersEncpagina, 1, 0 ) >>, <<iif( lxLtdspersFechaimpre, 1, 0 ) >>, <<iif( lxLtdspersInfcorrida, 1, 0 ) >>, <<iif( lxLtdspersResumenrep, 1, 0 ) >>, <<iif( lxLtdspersEncdetalle, 1, 0 ) >>, <<iif( lxLtdspersHoraimpre, 1, 0 ) >>, <<iif( lxLtdspersInfocontex, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMpara ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersClistado ) + "'" >>, <<iif( lxLtdspersEsdefault, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersCestilo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersIdentifica ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMasunto ) + "'" >>, <<lxLtdspersMder >>, <<lxLtdspersMizq >>, <<lxLtdspersMpie >>, <<lxLtdspersMcab >>, <<lxLtdspersOrien >>, <<"'" + this.FormatearTextoSql( lxLtdspersMcc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersDescrip ) + "'" >>, <<lxLtdspersOrdpor >>, <<lxLtdspersTipord >>, <<"'" + this.FormatearTextoSql( lxLtdspersTitulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersImagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMcco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersDbdato ) + "'" >>, <<lxLtdspersDstnotip >>, <<"'" + this.FormatearTextoSql( lxLtdspersDstnorut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMensaje ) + "'" >>, <<iif( lxLtdspersDbdatod, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersDstnoarc ) + "'" >>, <<iif( lxLtdspersDstnofh, 1, 0 ) >>, <<iif( lxLtdspersSubtdetall, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersObs ) + "'" >>, <<iif( lxLtdspersDdetalle, 1, 0 ) >>, <<lxLtdspersColorsombr >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FiltrosDetalle
				if this.oEntidad.FiltrosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxValordesde = loItem.Valordesde
					lxSololecturadesde = loItem.Sololecturadesde
					lxValorhasta = loItem.Valorhasta
					lxSololecturahasta = loItem.Sololecturahasta
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxCriteriodeinicializacion = loItem.Criteriodeinicializacion
					lxDiashaciaatras = loItem.Diashaciaatras
					lxValornumericoinicial_desde = loItem.Valornumericoinicial_desde
					lxValornumericoinicial_hasta = loItem.Valornumericoinicial_hasta
					lxValorcaracterinicial_desde = loItem.Valorcaracterinicial_desde
					lxValorcaracterinicial_hasta = loItem.Valorcaracterinicial_hasta
					lxValorbooleanoinicial = loItem.Valorbooleanoinicial
					lxValorsinoinicial = loItem.Valorsinoinicial
					lxSololectura = loItem.Sololectura
					lxNoinformar = loItem.Noinformar
					lxNomostrar = loItem.Nomostrar
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETFILTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","desde","SLD","hasta","SLH","nOrden","activado","CriteInit","DiasAtras","VNIDesde","VNIHasta","VCIDesde","VCIHasta","VIBooleano","VISiNoBool","SLectura","NoInformar","NoMostrar" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxValordesde ) + "'">>, <<iif( lxSololecturadesde, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorhasta ) + "'">>, <<iif( lxSololecturahasta, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxCriteriodeinicializacion>>, <<lxDiashaciaatras>>, <<lxValornumericoinicial_desde>>, <<lxValornumericoinicial_hasta>>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_desde ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_hasta ) + "'">>, <<lxValorbooleanoinicial>>, <<lxValorsinoinicial>>, <<iif( lxSololectura, 1, 0 )>>, <<iif( lxNoinformar, 1, 0 )>>, <<iif( lxNomostrar, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CamposDetalle
				if this.oEntidad.CamposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxEtiquetareporte = loItem.Etiquetareporte
					lxLongitudreporte = loItem.Longitudreporte
					lxDecimalesreporte = loItem.Decimalesreporte
					lxMostrarceros = loItem.Mostrarceros
					lxGrupovisual = loItem.Grupovisual
					lxExpresion = loItem.Expresion
					lxExpresionnueva_PK = loItem.Expresionnueva_PK
					lxTipocalculo = loItem.Tipocalculo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxLineavertical = loItem.Lineavertical
					lxPuedecrecer = loItem.Puedecrecer
					lxOcultarepetido = loItem.Ocultarepetido
					lxTamañooriginalimagen = loItem.Tamañooriginalimagen
					lxAnchoimagen = loItem.Anchoimagen
					lxAltoimagen = loItem.Altoimagen
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","Etiqueta","Longitud","Decimales","Mceros","GrupoV","Expresion","ExpresionN","Calculo","nOrden","activado","LVertical","PCrecer","ORepetido","MImagen","WImagen","HImagen" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxEtiquetareporte ) + "'">>, <<lxLongitudreporte>>, <<lxDecimalesreporte>>, <<lxMostrarceros>>, <<lxGrupovisual>>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresionnueva_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocalculo ) + "'">>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<iif( lxLineavertical, 1, 0 )>>, <<iif( lxPuedecrecer, 1, 0 )>>, <<iif( lxOcultarepetido, 1, 0 )>>, <<iif( lxTamañooriginalimagen, 1, 0 )>>, <<lxAnchoimagen>>, <<lxAltoimagen>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SubtotalDetalle
				if this.oEntidad.SubtotalDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxLnuevapaginaantes = loItem.Lnuevapaginaantes
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxNsubtotal = loItem.Nsubtotal
					lxFormula = loItem.Formula
					lxAnchoformula = loItem.Anchoformula
					lxEtiquetaformula = loItem.Etiquetaformula
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMSUBPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","lpagenew","nOrden","activado","nSubtotal","Formula","Ancho","EtiqF" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<iif( lxLnuevapaginaantes, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxNsubtotal>>, <<"'" + this.FormatearTextoSql( lxFormula ) + "'">>, <<lxAnchoformula>>, <<"'" + this.FormatearTextoSql( lxEtiquetaformula ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenamientosDetalle
				if this.oEntidad.OrdenamientosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxSentido = loItem.Sentido
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMORDPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","nOrden","activado","Sentido" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxSentido>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SalidasDetalle
				if this.oEntidad.SalidasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxTipo = loItem.Tipo
					lxExtendido = loItem.Extendido
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETSALIDASLPER("NROITEM","BLOQREG","codigo","tipo","Extendido","activado" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<iif( lxExtendido, 1, 0 )>>, <<iif( lxActivado, 1, 0 )>> ) 
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
			local  lxLtdspersFecexpo, lxLtdspersFectrans, lxLtdspersFecimpo, lxLtdspersFaltafw, lxLtdspersFmodifw, lxLtdspersHoraexpo, lxLtdspersHaltafw, lxLtdspersBdaltafw, lxLtdspersEsttrans, lxLtdspersBdmodifw, lxLtdspersHoraimpo, lxLtdspersUmodifw, lxLtdspersValtafw, lxLtdspersVmodifw, lxLtdspersZadsfw, lxLtdspersSmodifw, lxLtdspersUaltafw, lxLtdspersSaltafw, lxLtdspersHmodifw, lxLtdspersAnulado, lxLtdspersBloqreg, lxLtdspersColsubrecp, lxLtdspersRepecabgru, lxLtdspersColgrupocp, lxLtdspersPagsimple, lxLtdspersMantgruni, lxLtdspersEncreporte, lxLtdspersTranspag, lxLtdspersEncpagina, lxLtdspersFechaimpre, lxLtdspersInfcorrida, lxLtdspersResumenrep, lxLtdspersEncdetalle, lxLtdspersHoraimpre, lxLtdspersInfocontex, lxLtdspersCcod, lxLtdspersMpara, lxLtdspersClistado, lxLtdspersEsdefault, lxLtdspersCestilo, lxLtdspersIdentifica, lxLtdspersMasunto, lxLtdspersMder, lxLtdspersMizq, lxLtdspersMpie, lxLtdspersMcab, lxLtdspersOrien, lxLtdspersMcc, lxLtdspersDescrip, lxLtdspersOrdpor, lxLtdspersTipord, lxLtdspersTitulo, lxLtdspersImagen, lxLtdspersMcco, lxLtdspersDbdato, lxLtdspersDstnotip, lxLtdspersDstnorut, lxLtdspersMensaje, lxLtdspersDbdatod, lxLtdspersDstnoarc, lxLtdspersDstnofh, lxLtdspersSubtdetall, lxLtdspersObs, lxLtdspersDdetalle, lxLtdspersColorsombr
				lxLtdspersFecexpo =  .Fechaexpo			lxLtdspersFectrans =  .Fechatransferencia			lxLtdspersFecimpo =  .Fechaimpo			lxLtdspersFaltafw =  .Fechaaltafw			lxLtdspersFmodifw =  .Fechamodificacionfw			lxLtdspersHoraexpo =  .Horaexpo			lxLtdspersHaltafw =  .Horaaltafw			lxLtdspersBdaltafw =  .Basededatosaltafw			lxLtdspersEsttrans =  .Estadotransferencia			lxLtdspersBdmodifw =  .Basededatosmodificacionfw			lxLtdspersHoraimpo =  .Horaimpo			lxLtdspersUmodifw =  .Usuariomodificacionfw			lxLtdspersValtafw =  .Versionaltafw			lxLtdspersVmodifw =  .Versionmodificacionfw			lxLtdspersZadsfw =  .Zadsfw			lxLtdspersSmodifw =  .Seriemodificacionfw			lxLtdspersUaltafw =  .Usuarioaltafw			lxLtdspersSaltafw =  .Seriealtafw			lxLtdspersHmodifw =  .Horamodificacionfw			lxLtdspersAnulado =  .Anulado			lxLtdspersBloqreg =  .Bloquearregistro			lxLtdspersColsubrecp =  .Titulosdecolumnasdesubreporteencp			lxLtdspersRepecabgru =  .Repetircabecerasdegrupos			lxLtdspersColgrupocp =  .Titulosdecolumnasdegrupoencp			lxLtdspersPagsimple =  .Numeraciondepaginasimple			lxLtdspersMantgruni =  .Mantenergruposunidos			lxLtdspersEncreporte =  .Imprimeencabezadodereporte			lxLtdspersTranspag =  .Usatransporteentrepaginas			lxLtdspersEncpagina =  .Imprimeencabezadodepagina			lxLtdspersFechaimpre =  .Imprimefechadeimpresion			lxLtdspersInfcorrida =  .Imprimeinformaciondecorrida			lxLtdspersResumenrep =  .Imprimeresumendereporte			lxLtdspersEncdetalle =  .Imprimeencabezadodedetalle			lxLtdspersHoraimpre =  .Imprimehoradeimpresion			lxLtdspersInfocontex =  .Imprimeinformaciondecontexto			lxLtdspersCcod =  .Codigo			lxLtdspersMpara =  .Mailpara			lxLtdspersClistado =  .Clistado			lxLtdspersEsdefault =  .Esdefault			lxLtdspersCestilo =  upper( .Estilo_PK ) 			lxLtdspersIdentifica =  .Identificadorordenamiento			lxLtdspersMasunto =  .Mailasunto			lxLtdspersMder =  .Margenderecho			lxLtdspersMizq =  .Margenizquierdo			lxLtdspersMpie =  .Margenpie			lxLtdspersMcab =  .Margencabecera			lxLtdspersOrien =  .Orientacion			lxLtdspersMcc =  .Mailconcopia			lxLtdspersDescrip =  .Descripcion			lxLtdspersOrdpor =  .Ordenadopor			lxLtdspersTipord =  .Tipoordenamiento			lxLtdspersTitulo =  .Titulolistado			lxLtdspersImagen =  .Imagenlistado			lxLtdspersMcco =  .Mailconcopiaoculta			lxLtdspersDbdato =  .Basededatos			lxLtdspersDstnotip =  .Destinotipo			lxLtdspersDstnorut =  .Destinoruta			lxLtdspersMensaje =  .Mailmensaje			lxLtdspersDbdatod =  .Basededatosdetallada			lxLtdspersDstnoarc =  .Destinoarchivo			lxLtdspersDstnofh =  .Destinofechahora			lxLtdspersSubtdetall =  .Subtotaldetallado			lxLtdspersObs =  .Observacion			lxLtdspersDdetalle =  .Diferenciardetalle			lxLtdspersColorsombr =  .Colorparaelsombreado
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ORGANIZACION.LTDSPERS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLtdspersFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxLtdspersFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxLtdspersFecimpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxLtdspersFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxLtdspersFmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxLtdspersHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxLtdspersHaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLtdspersBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxLtdspersEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersBdmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxLtdspersHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxLtdspersValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxLtdspersZadsfw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxLtdspersUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxLtdspersSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersHmodifw ) + "'">>,"Anulado" = <<iif( lxLtdspersAnulado, 1, 0 )>>,"Bloqreg" = <<iif( lxLtdspersBloqreg, 1, 0 )>>,"Colsubrecp" = <<iif( lxLtdspersColsubrecp, 1, 0 )>>,"Repecabgru" = <<iif( lxLtdspersRepecabgru, 1, 0 )>>,"Colgrupocp" = <<iif( lxLtdspersColgrupocp, 1, 0 )>>,"Pagsimple" = <<iif( lxLtdspersPagsimple, 1, 0 )>>,"Mantgruni" = <<iif( lxLtdspersMantgruni, 1, 0 )>>,"Encreporte" = <<iif( lxLtdspersEncreporte, 1, 0 )>>,"Transpag" = <<iif( lxLtdspersTranspag, 1, 0 )>>,"Encpagina" = <<iif( lxLtdspersEncpagina, 1, 0 )>>,"Fechaimpre" = <<iif( lxLtdspersFechaimpre, 1, 0 )>>,"Infcorrida" = <<iif( lxLtdspersInfcorrida, 1, 0 )>>,"Resumenrep" = <<iif( lxLtdspersResumenrep, 1, 0 )>>,"Encdetalle" = <<iif( lxLtdspersEncdetalle, 1, 0 )>>,"Horaimpre" = <<iif( lxLtdspersHoraimpre, 1, 0 )>>,"Infocontex" = <<iif( lxLtdspersInfocontex, 1, 0 )>>,"Ccod" = <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'">>,"Mpara" = <<"'" + this.FormatearTextoSql( lxLtdspersMpara ) + "'">>,"Clistado" = <<"'" + this.FormatearTextoSql( lxLtdspersClistado ) + "'">>,"Esdefault" = <<iif( lxLtdspersEsdefault, 1, 0 )>>,"Cestilo" = <<"'" + this.FormatearTextoSql( lxLtdspersCestilo ) + "'">>,"Identifica" = <<"'" + this.FormatearTextoSql( lxLtdspersIdentifica ) + "'">>,"Masunto" = <<"'" + this.FormatearTextoSql( lxLtdspersMasunto ) + "'">>,"Mder" = <<lxLtdspersMder>>,"Mizq" = <<lxLtdspersMizq>>,"Mpie" = <<lxLtdspersMpie>>,"Mcab" = <<lxLtdspersMcab>>,"Orien" = <<lxLtdspersOrien>>,"Mcc" = <<"'" + this.FormatearTextoSql( lxLtdspersMcc ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxLtdspersDescrip ) + "'">>,"Ordpor" = <<lxLtdspersOrdpor>>,"Tipord" = <<lxLtdspersTipord>>,"Titulo" = <<"'" + this.FormatearTextoSql( lxLtdspersTitulo ) + "'">>,"Imagen" = <<"'" + this.FormatearTextoSql( lxLtdspersImagen ) + "'">>,"Mcco" = <<"'" + this.FormatearTextoSql( lxLtdspersMcco ) + "'">>,"Dbdato" = <<"'" + this.FormatearTextoSql( lxLtdspersDbdato ) + "'">>,"Dstnotip" = <<lxLtdspersDstnotip>>,"Dstnorut" = <<"'" + this.FormatearTextoSql( lxLtdspersDstnorut ) + "'">>,"Mensaje" = <<"'" + this.FormatearTextoSql( lxLtdspersMensaje ) + "'">>,"Dbdatod" = <<iif( lxLtdspersDbdatod, 1, 0 )>>,"Dstnoarc" = <<"'" + this.FormatearTextoSql( lxLtdspersDstnoarc ) + "'">>,"Dstnofh" = <<iif( lxLtdspersDstnofh, 1, 0 )>>,"Subtdetall" = <<iif( lxLtdspersSubtdetall, 1, 0 )>>,"Obs" = <<"'" + this.FormatearTextoSql( lxLtdspersObs ) + "'">>,"Ddetalle" = <<iif( lxLtdspersDdetalle, 1, 0 )>>,"Colorsombr" = <<lxLtdspersColorsombr>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'">> and  LTDSPERS.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETFILTROPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETCAMTROPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETCAMSUBPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETCAMORDPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETSALIDASLPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FiltrosDetalle
				if this.oEntidad.FiltrosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxValordesde = loItem.Valordesde
					lxSololecturadesde = loItem.Sololecturadesde
					lxValorhasta = loItem.Valorhasta
					lxSololecturahasta = loItem.Sololecturahasta
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxCriteriodeinicializacion = loItem.Criteriodeinicializacion
					lxDiashaciaatras = loItem.Diashaciaatras
					lxValornumericoinicial_desde = loItem.Valornumericoinicial_desde
					lxValornumericoinicial_hasta = loItem.Valornumericoinicial_hasta
					lxValorcaracterinicial_desde = loItem.Valorcaracterinicial_desde
					lxValorcaracterinicial_hasta = loItem.Valorcaracterinicial_hasta
					lxValorbooleanoinicial = loItem.Valorbooleanoinicial
					lxValorsinoinicial = loItem.Valorsinoinicial
					lxSololectura = loItem.Sololectura
					lxNoinformar = loItem.Noinformar
					lxNomostrar = loItem.Nomostrar
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETFILTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","desde","SLD","hasta","SLH","nOrden","activado","CriteInit","DiasAtras","VNIDesde","VNIHasta","VCIDesde","VCIHasta","VIBooleano","VISiNoBool","SLectura","NoInformar","NoMostrar" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxValordesde ) + "'">>, <<iif( lxSololecturadesde, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorhasta ) + "'">>, <<iif( lxSololecturahasta, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxCriteriodeinicializacion>>, <<lxDiashaciaatras>>, <<lxValornumericoinicial_desde>>, <<lxValornumericoinicial_hasta>>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_desde ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_hasta ) + "'">>, <<lxValorbooleanoinicial>>, <<lxValorsinoinicial>>, <<iif( lxSololectura, 1, 0 )>>, <<iif( lxNoinformar, 1, 0 )>>, <<iif( lxNomostrar, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CamposDetalle
				if this.oEntidad.CamposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxEtiquetareporte = loItem.Etiquetareporte
					lxLongitudreporte = loItem.Longitudreporte
					lxDecimalesreporte = loItem.Decimalesreporte
					lxMostrarceros = loItem.Mostrarceros
					lxGrupovisual = loItem.Grupovisual
					lxExpresion = loItem.Expresion
					lxExpresionnueva_PK = loItem.Expresionnueva_PK
					lxTipocalculo = loItem.Tipocalculo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxLineavertical = loItem.Lineavertical
					lxPuedecrecer = loItem.Puedecrecer
					lxOcultarepetido = loItem.Ocultarepetido
					lxTamañooriginalimagen = loItem.Tamañooriginalimagen
					lxAnchoimagen = loItem.Anchoimagen
					lxAltoimagen = loItem.Altoimagen
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","Etiqueta","Longitud","Decimales","Mceros","GrupoV","Expresion","ExpresionN","Calculo","nOrden","activado","LVertical","PCrecer","ORepetido","MImagen","WImagen","HImagen" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxEtiquetareporte ) + "'">>, <<lxLongitudreporte>>, <<lxDecimalesreporte>>, <<lxMostrarceros>>, <<lxGrupovisual>>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresionnueva_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocalculo ) + "'">>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<iif( lxLineavertical, 1, 0 )>>, <<iif( lxPuedecrecer, 1, 0 )>>, <<iif( lxOcultarepetido, 1, 0 )>>, <<iif( lxTamañooriginalimagen, 1, 0 )>>, <<lxAnchoimagen>>, <<lxAltoimagen>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SubtotalDetalle
				if this.oEntidad.SubtotalDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxLnuevapaginaantes = loItem.Lnuevapaginaantes
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxNsubtotal = loItem.Nsubtotal
					lxFormula = loItem.Formula
					lxAnchoformula = loItem.Anchoformula
					lxEtiquetaformula = loItem.Etiquetaformula
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMSUBPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","lpagenew","nOrden","activado","nSubtotal","Formula","Ancho","EtiqF" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<iif( lxLnuevapaginaantes, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxNsubtotal>>, <<"'" + this.FormatearTextoSql( lxFormula ) + "'">>, <<lxAnchoformula>>, <<"'" + this.FormatearTextoSql( lxEtiquetaformula ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenamientosDetalle
				if this.oEntidad.OrdenamientosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxSentido = loItem.Sentido
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMORDPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","nOrden","activado","Sentido" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxSentido>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SalidasDetalle
				if this.oEntidad.SalidasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxTipo = loItem.Tipo
					lxExtendido = loItem.Extendido
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETSALIDASLPER("NROITEM","BLOQREG","codigo","tipo","Extendido","activado" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<iif( lxExtendido, 1, 0 )>>, <<iif( lxActivado, 1, 0 )>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ORGANIZACION.LTDSPERS where " + this.ConvertirFuncionesSql( " LTDSPERS.CCOD != ''" ) )
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
			Local lxLtdspersCcod
			lxLtdspersCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ORGANIZACION.LTDSPERS where "Ccod" = <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'">> and  LTDSPERS.CCOD != ''
			endtext
			use in select('c_LISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADOSPERSONALIZADOS', set( 'Datasession' ) )

			if reccount( 'c_LISTADOSPERSONALIZADOS' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Desde" as "Valordesde", "Sld" as "Sololecturadesde", "Hasta" as "Valorhasta", "Slh" as "Sololecturahasta", "Norden" as "Norden", "Activado" as "Activado", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar" from ORGANIZACION.DETFILTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FiltrosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FiltrosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FiltrosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Etiqueta" as "Etiquetareporte", "Longitud" as "Longitudreporte", "Decimales" as "Decimalesreporte", "Mceros" as "Mostrarceros", "Grupov" as "Grupovisual", "Expresion" as "Expresion", "Expresionn" as "Expresionnueva", "Calculo" as "Tipocalculo", "Norden" as "Norden", "Activado" as "Activado", "Lvertical" as "Lineavertical", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Mimagen" as "Tamañooriginalimagen", "Wimagen" as "Anchoimagen", "Himagen" as "Altoimagen" from ORGANIZACION.DETCAMTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by nOrden
			endtext
			use in select('c_CamposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CamposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CamposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Lpagenew" as "Lnuevapaginaantes", "Norden" as "Norden", "Activado" as "Activado", "Nsubtotal" as "Nsubtotal", "Formula" as "Formula", "Ancho" as "Anchoformula", "Etiqf" as "Etiquetaformula" from ORGANIZACION.DETCAMSUBPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SubtotalDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SubtotalDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SubtotalDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Norden" as "Norden", "Activado" as "Activado", "Sentido" as "Sentido" from ORGANIZACION.DETCAMORDPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenamientosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenamientosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenamientosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Tipo" as "Tipo", "Extendido" as "Extendido", "Activado" as "Activado" from ORGANIZACION.DETSALIDASLPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SalidasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SalidasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SalidasDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxLtdspersCcod as Variant
		llRetorno = .t.
		lxLtdspersCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.LTDSPERS where "Ccod" = <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'">> and  LTDSPERS.CCOD != ''
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
				lcOrden =  .cListado + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ORGANIZACION.LTDSPERS where  LTDSPERS.CCOD != '' order by cListado,cCod
			endtext
			use in select('c_LISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Desde" as "Valordesde", "Sld" as "Sololecturadesde", "Hasta" as "Valorhasta", "Slh" as "Sololecturahasta", "Norden" as "Norden", "Activado" as "Activado", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar" from ORGANIZACION.DETFILTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FiltrosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FiltrosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FiltrosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Etiqueta" as "Etiquetareporte", "Longitud" as "Longitudreporte", "Decimales" as "Decimalesreporte", "Mceros" as "Mostrarceros", "Grupov" as "Grupovisual", "Expresion" as "Expresion", "Expresionn" as "Expresionnueva", "Calculo" as "Tipocalculo", "Norden" as "Norden", "Activado" as "Activado", "Lvertical" as "Lineavertical", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Mimagen" as "Tamañooriginalimagen", "Wimagen" as "Anchoimagen", "Himagen" as "Altoimagen" from ORGANIZACION.DETCAMTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by nOrden
			endtext
			use in select('c_CamposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CamposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CamposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Lpagenew" as "Lnuevapaginaantes", "Norden" as "Norden", "Activado" as "Activado", "Nsubtotal" as "Nsubtotal", "Formula" as "Formula", "Ancho" as "Anchoformula", "Etiqf" as "Etiquetaformula" from ORGANIZACION.DETCAMSUBPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SubtotalDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SubtotalDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SubtotalDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Norden" as "Norden", "Activado" as "Activado", "Sentido" as "Sentido" from ORGANIZACION.DETCAMORDPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenamientosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenamientosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenamientosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Tipo" as "Tipo", "Extendido" as "Extendido", "Activado" as "Activado" from ORGANIZACION.DETSALIDASLPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SalidasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SalidasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SalidasDetalle
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
				lcOrden =  .cListado + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ORGANIZACION.LTDSPERS where  funciones.padr( cListado, 60, ' ' ) + funciones.padr( cCod, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LTDSPERS.CCOD != '' order by cListado,cCod
			endtext
			use in select('c_LISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Desde" as "Valordesde", "Sld" as "Sololecturadesde", "Hasta" as "Valorhasta", "Slh" as "Sololecturahasta", "Norden" as "Norden", "Activado" as "Activado", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar" from ORGANIZACION.DETFILTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FiltrosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FiltrosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FiltrosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Etiqueta" as "Etiquetareporte", "Longitud" as "Longitudreporte", "Decimales" as "Decimalesreporte", "Mceros" as "Mostrarceros", "Grupov" as "Grupovisual", "Expresion" as "Expresion", "Expresionn" as "Expresionnueva", "Calculo" as "Tipocalculo", "Norden" as "Norden", "Activado" as "Activado", "Lvertical" as "Lineavertical", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Mimagen" as "Tamañooriginalimagen", "Wimagen" as "Anchoimagen", "Himagen" as "Altoimagen" from ORGANIZACION.DETCAMTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by nOrden
			endtext
			use in select('c_CamposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CamposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CamposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Lpagenew" as "Lnuevapaginaantes", "Norden" as "Norden", "Activado" as "Activado", "Nsubtotal" as "Nsubtotal", "Formula" as "Formula", "Ancho" as "Anchoformula", "Etiqf" as "Etiquetaformula" from ORGANIZACION.DETCAMSUBPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SubtotalDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SubtotalDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SubtotalDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Norden" as "Norden", "Activado" as "Activado", "Sentido" as "Sentido" from ORGANIZACION.DETCAMORDPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenamientosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenamientosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenamientosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Tipo" as "Tipo", "Extendido" as "Extendido", "Activado" as "Activado" from ORGANIZACION.DETSALIDASLPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SalidasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SalidasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SalidasDetalle
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
				lcOrden =  .cListado + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ORGANIZACION.LTDSPERS where  funciones.padr( cListado, 60, ' ' ) + funciones.padr( cCod, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  LTDSPERS.CCOD != '' order by cListado desc,cCod desc
			endtext
			use in select('c_LISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Desde" as "Valordesde", "Sld" as "Sololecturadesde", "Hasta" as "Valorhasta", "Slh" as "Sololecturahasta", "Norden" as "Norden", "Activado" as "Activado", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar" from ORGANIZACION.DETFILTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FiltrosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FiltrosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FiltrosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Etiqueta" as "Etiquetareporte", "Longitud" as "Longitudreporte", "Decimales" as "Decimalesreporte", "Mceros" as "Mostrarceros", "Grupov" as "Grupovisual", "Expresion" as "Expresion", "Expresionn" as "Expresionnueva", "Calculo" as "Tipocalculo", "Norden" as "Norden", "Activado" as "Activado", "Lvertical" as "Lineavertical", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Mimagen" as "Tamañooriginalimagen", "Wimagen" as "Anchoimagen", "Himagen" as "Altoimagen" from ORGANIZACION.DETCAMTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by nOrden
			endtext
			use in select('c_CamposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CamposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CamposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Lpagenew" as "Lnuevapaginaantes", "Norden" as "Norden", "Activado" as "Activado", "Nsubtotal" as "Nsubtotal", "Formula" as "Formula", "Ancho" as "Anchoformula", "Etiqf" as "Etiquetaformula" from ORGANIZACION.DETCAMSUBPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SubtotalDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SubtotalDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SubtotalDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Norden" as "Norden", "Activado" as "Activado", "Sentido" as "Sentido" from ORGANIZACION.DETCAMORDPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenamientosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenamientosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenamientosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Tipo" as "Tipo", "Extendido" as "Extendido", "Activado" as "Activado" from ORGANIZACION.DETSALIDASLPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SalidasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SalidasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SalidasDetalle
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
				lcOrden =  .cListado + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado" from ORGANIZACION.LTDSPERS where  LTDSPERS.CCOD != '' order by cListado desc,cCod desc
			endtext
			use in select('c_LISTADOSPERSONALIZADOS')
			this.oConexion.EjecutarSql( lcSentencia, 'c_LISTADOSPERSONALIZADOS', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Desde" as "Valordesde", "Sld" as "Sololecturadesde", "Hasta" as "Valorhasta", "Slh" as "Sololecturahasta", "Norden" as "Norden", "Activado" as "Activado", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar" from ORGANIZACION.DETFILTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FiltrosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FiltrosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FiltrosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Etiqueta" as "Etiquetareporte", "Longitud" as "Longitudreporte", "Decimales" as "Decimalesreporte", "Mceros" as "Mostrarceros", "Grupov" as "Grupovisual", "Expresion" as "Expresion", "Expresionn" as "Expresionnueva", "Calculo" as "Tipocalculo", "Norden" as "Norden", "Activado" as "Activado", "Lvertical" as "Lineavertical", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Mimagen" as "Tamañooriginalimagen", "Wimagen" as "Anchoimagen", "Himagen" as "Altoimagen" from ORGANIZACION.DETCAMTROPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by nOrden
			endtext
			use in select('c_CamposDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_CamposDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_CamposDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Lpagenew" as "Lnuevapaginaantes", "Norden" as "Norden", "Activado" as "Activado", "Nsubtotal" as "Nsubtotal", "Formula" as "Formula", "Ancho" as "Anchoformula", "Etiqf" as "Etiquetaformula" from ORGANIZACION.DETCAMSUBPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SubtotalDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SubtotalDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SubtotalDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Norden" as "Norden", "Activado" as "Activado", "Sentido" as "Sentido" from ORGANIZACION.DETCAMORDPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenamientosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenamientosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenamientosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Tipo" as "Tipo", "Extendido" as "Extendido", "Activado" as "Activado" from ORGANIZACION.DETSALIDASLPER where codigo = <<"'" + this.FormatearTextoSql( c_LISTADOSPERSONALIZADOS.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_SalidasDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_SalidasDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_SalidasDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Horaexpo,Haltafw,Bdaltafw,Esttrans,Bdmodifw,Horaimp" + ;
"o,Umodifw,Valtafw,Vmodifw,Zadsfw,Smodifw,Ualtafw,Saltafw,Hmodifw,Anulado,Bloqreg,Colsubrecp,Repecabg" + ;
"ru,Colgrupocp,Pagsimple,Mantgruni,Encreporte,Transpag,Encpagina,Fechaimpre,Infcorrida,Resumenrep,Enc" + ;
"detalle,Horaimpre,Infocontex,Ccod,Mpara,Clistado,Esdefault,Cestilo,Identifica,Masunto,Mder,Mizq,Mpie" + ;
",Mcab,Orien,Mcc,Descrip,Ordpor,Tipord,Titulo,Imagen,Mcco,Dbdato,Dstnotip,Dstnorut,Mensaje,Dbdatod,Ds" + ;
"tnoarc,Dstnofh,Subtdetall,Obs,Ddetalle,Colorsombr" + ;
" from ORGANIZACION.LTDSPERS where  LTDSPERS.CCOD != '' and " + lcFiltro )
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
			local  lxLtdspersFecexpo, lxLtdspersFectrans, lxLtdspersFecimpo, lxLtdspersFaltafw, lxLtdspersFmodifw, lxLtdspersHoraexpo, lxLtdspersHaltafw, lxLtdspersBdaltafw, lxLtdspersEsttrans, lxLtdspersBdmodifw, lxLtdspersHoraimpo, lxLtdspersUmodifw, lxLtdspersValtafw, lxLtdspersVmodifw, lxLtdspersZadsfw, lxLtdspersSmodifw, lxLtdspersUaltafw, lxLtdspersSaltafw, lxLtdspersHmodifw, lxLtdspersAnulado, lxLtdspersBloqreg, lxLtdspersColsubrecp, lxLtdspersRepecabgru, lxLtdspersColgrupocp, lxLtdspersPagsimple, lxLtdspersMantgruni, lxLtdspersEncreporte, lxLtdspersTranspag, lxLtdspersEncpagina, lxLtdspersFechaimpre, lxLtdspersInfcorrida, lxLtdspersResumenrep, lxLtdspersEncdetalle, lxLtdspersHoraimpre, lxLtdspersInfocontex, lxLtdspersCcod, lxLtdspersMpara, lxLtdspersClistado, lxLtdspersEsdefault, lxLtdspersCestilo, lxLtdspersIdentifica, lxLtdspersMasunto, lxLtdspersMder, lxLtdspersMizq, lxLtdspersMpie, lxLtdspersMcab, lxLtdspersOrien, lxLtdspersMcc, lxLtdspersDescrip, lxLtdspersOrdpor, lxLtdspersTipord, lxLtdspersTitulo, lxLtdspersImagen, lxLtdspersMcco, lxLtdspersDbdato, lxLtdspersDstnotip, lxLtdspersDstnorut, lxLtdspersMensaje, lxLtdspersDbdatod, lxLtdspersDstnoarc, lxLtdspersDstnofh, lxLtdspersSubtdetall, lxLtdspersObs, lxLtdspersDdetalle, lxLtdspersColorsombr
				lxLtdspersFecexpo = ctod( '  /  /    ' )			lxLtdspersFectrans = ctod( '  /  /    ' )			lxLtdspersFecimpo = ctod( '  /  /    ' )			lxLtdspersFaltafw = ctod( '  /  /    ' )			lxLtdspersFmodifw = ctod( '  /  /    ' )			lxLtdspersHoraexpo = []			lxLtdspersHaltafw = []			lxLtdspersBdaltafw = []			lxLtdspersEsttrans = []			lxLtdspersBdmodifw = []			lxLtdspersHoraimpo = []			lxLtdspersUmodifw = []			lxLtdspersValtafw = []			lxLtdspersVmodifw = []			lxLtdspersZadsfw = []			lxLtdspersSmodifw = []			lxLtdspersUaltafw = []			lxLtdspersSaltafw = []			lxLtdspersHmodifw = []			lxLtdspersAnulado = .F.			lxLtdspersBloqreg = .F.			lxLtdspersColsubrecp = .F.			lxLtdspersRepecabgru = .F.			lxLtdspersColgrupocp = .F.			lxLtdspersPagsimple = .F.			lxLtdspersMantgruni = .F.			lxLtdspersEncreporte = .F.			lxLtdspersTranspag = .F.			lxLtdspersEncpagina = .F.			lxLtdspersFechaimpre = .F.			lxLtdspersInfcorrida = .F.			lxLtdspersResumenrep = .F.			lxLtdspersEncdetalle = .F.			lxLtdspersHoraimpre = .F.			lxLtdspersInfocontex = .F.			lxLtdspersCcod = []			lxLtdspersMpara = []			lxLtdspersClistado = []			lxLtdspersEsdefault = .F.			lxLtdspersCestilo = []			lxLtdspersIdentifica = []			lxLtdspersMasunto = []			lxLtdspersMder = 0			lxLtdspersMizq = 0			lxLtdspersMpie = 0			lxLtdspersMcab = 0			lxLtdspersOrien = 0			lxLtdspersMcc = []			lxLtdspersDescrip = []			lxLtdspersOrdpor = 0			lxLtdspersTipord = 0			lxLtdspersTitulo = []			lxLtdspersImagen = []			lxLtdspersMcco = []			lxLtdspersDbdato = []			lxLtdspersDstnotip = 0			lxLtdspersDstnorut = []			lxLtdspersMensaje = []			lxLtdspersDbdatod = .F.			lxLtdspersDstnoarc = []			lxLtdspersDstnofh = .F.			lxLtdspersSubtdetall = .F.			lxLtdspersObs = []			lxLtdspersDdetalle = .F.			lxLtdspersColorsombr = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETFILTROPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETCAMTROPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETCAMSUBPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETCAMORDPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DETSALIDASLPER where "codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.LTDSPERS where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'LTDSPERS' + '_' + tcCampo
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
		lcWhere = " Where  LTDSPERS.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'LTDSPERS', '', tnTope )
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
	Function ObtenerDatosDetalleFiltrosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETFILTROPER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Desde" as "Valordesde", "Sld" as "Sololecturadesde", "Hasta" as "Valorhasta", "Slh" as "Sololecturahasta", "Norden" as "Norden", "Activado" as "Activado", "Criteinit" as "Criteriodeinicializacion", "Diasatras" as "Diashaciaatras", "Vnidesde" as "Valornumericoinicial_desde", "Vnihasta" as "Valornumericoinicial_hasta", "Vcidesde" as "Valorcaracterinicial_desde", "Vcihasta" as "Valorcaracterinicial_hasta", "Vibooleano" as "Valorbooleanoinicial", "Visinobool" as "Valorsinoinicial", "Slectura" as "Sololectura", "Noinformar" as "Noinformar", "Nomostrar" as "Nomostrar"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFiltrosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETFILTROPER', 'FiltrosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleFiltrosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleFiltrosDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleCamposDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCAMTROPER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Etiqueta" as "Etiquetareporte", "Longitud" as "Longitudreporte", "Decimales" as "Decimalesreporte", "Mceros" as "Mostrarceros", "Grupov" as "Grupovisual", "Expresion" as "Expresion", "Expresionn" as "Expresionnueva", "Calculo" as "Tipocalculo", "Norden" as "Norden", "Activado" as "Activado", "Lvertical" as "Lineavertical", "Pcrecer" as "Puedecrecer", "Orepetido" as "Ocultarepetido", "Mimagen" as "Tamañooriginalimagen", "Wimagen" as "Anchoimagen", "Himagen" as "Altoimagen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCamposDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETCAMTROPER', 'CamposDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCamposDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCamposDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleSubtotalDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCAMSUBPER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Lpagenew" as "Lnuevapaginaantes", "Norden" as "Norden", "Activado" as "Activado", "Nsubtotal" as "Nsubtotal", "Formula" as "Formula", "Ancho" as "Anchoformula", "Etiqf" as "Etiquetaformula"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleSubtotalDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETCAMSUBPER', 'SubtotalDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleSubtotalDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleSubtotalDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleOrdenamientosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETCAMORDPER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Identifica" as "Identificador", "Idcampo" as "Idcampo", "Norden" as "Norden", "Activado" as "Activado", "Sentido" as "Sentido"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenamientosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETCAMORDPER', 'OrdenamientosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenamientosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenamientosDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleSalidasDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DETSALIDASLPER.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Codigo" as "Codigo", "Tipo" as "Tipo", "Extendido" as "Extendido", "Activado" as "Activado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleSalidasDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DETSALIDASLPER', 'SalidasDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleSalidasDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleSalidasDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'TITULOSDECOLUMNASDESUBREPORTEENCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLSUBRECP AS TITULOSDECOLUMNASDESUBREPORTEENCP'
				Case lcAtributo == 'REPETIRCABECERASDEGRUPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REPECABGRU AS REPETIRCABECERASDEGRUPOS'
				Case lcAtributo == 'TITULOSDECOLUMNASDEGRUPOENCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLGRUPOCP AS TITULOSDECOLUMNASDEGRUPOENCP'
				Case lcAtributo == 'NUMERACIONDEPAGINASIMPLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PAGSIMPLE AS NUMERACIONDEPAGINASIMPLE'
				Case lcAtributo == 'MANTENERGRUPOSUNIDOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MANTGRUNI AS MANTENERGRUPOSUNIDOS'
				Case lcAtributo == 'IMPRIMEENCABEZADODEREPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENCREPORTE AS IMPRIMEENCABEZADODEREPORTE'
				Case lcAtributo == 'USATRANSPORTEENTREPAGINAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRANSPAG AS USATRANSPORTEENTREPAGINAS'
				Case lcAtributo == 'IMPRIMEENCABEZADODEPAGINA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENCPAGINA AS IMPRIMEENCABEZADODEPAGINA'
				Case lcAtributo == 'IMPRIMEFECHADEIMPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAIMPRE AS IMPRIMEFECHADEIMPRESION'
				Case lcAtributo == 'IMPRIMEINFORMACIONDECORRIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INFCORRIDA AS IMPRIMEINFORMACIONDECORRIDA'
				Case lcAtributo == 'IMPRIMERESUMENDEREPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RESUMENREP AS IMPRIMERESUMENDEREPORTE'
				Case lcAtributo == 'IMPRIMEENCABEZADODEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENCDETALLE AS IMPRIMEENCABEZADODEDETALLE'
				Case lcAtributo == 'IMPRIMEHORADEIMPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPRE AS IMPRIMEHORADEIMPRESION'
				Case lcAtributo == 'IMPRIMEINFORMACIONDECONTEXTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INFOCONTEX AS IMPRIMEINFORMACIONDECONTEXTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'MAILPARA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MPARA AS MAILPARA'
				Case lcAtributo == 'CLISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLISTADO AS CLISTADO'
				Case lcAtributo == 'ESDEFAULT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESDEFAULT AS ESDEFAULT'
				Case lcAtributo == 'ESTILO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CESTILO AS ESTILO'
				Case lcAtributo == 'IDENTIFICADORORDENAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFICA AS IDENTIFICADORORDENAMIENTO'
				Case lcAtributo == 'MAILASUNTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MASUNTO AS MAILASUNTO'
				Case lcAtributo == 'MARGENDERECHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDER AS MARGENDERECHO'
				Case lcAtributo == 'MARGENIZQUIERDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MIZQ AS MARGENIZQUIERDO'
				Case lcAtributo == 'MARGENPIE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MPIE AS MARGENPIE'
				Case lcAtributo == 'MARGENCABECERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCAB AS MARGENCABECERA'
				Case lcAtributo == 'ORIENTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIEN AS ORIENTACION'
				Case lcAtributo == 'MAILCONCOPIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCC AS MAILCONCOPIA'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'ORDENADOPOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDPOR AS ORDENADOPOR'
				Case lcAtributo == 'TIPOORDENAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPORD AS TIPOORDENAMIENTO'
				Case lcAtributo == 'TITULOLISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TITULO AS TITULOLISTADO'
				Case lcAtributo == 'IMAGENLISTADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMAGEN AS IMAGENLISTADO'
				Case lcAtributo == 'MAILCONCOPIAOCULTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCCO AS MAILCONCOPIAOCULTA'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DBDATO AS BASEDEDATOS'
				Case lcAtributo == 'DESTINOTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DSTNOTIP AS DESTINOTIPO'
				Case lcAtributo == 'DESTINORUTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DSTNORUT AS DESTINORUTA'
				Case lcAtributo == 'MAILMENSAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MENSAJE AS MAILMENSAJE'
				Case lcAtributo == 'BASEDEDATOSDETALLADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DBDATOD AS BASEDEDATOSDETALLADA'
				Case lcAtributo == 'DESTINOARCHIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DSTNOARC AS DESTINOARCHIVO'
				Case lcAtributo == 'DESTINOFECHAHORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DSTNOFH AS DESTINOFECHAHORA'
				Case lcAtributo == 'SUBTOTALDETALLADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTDETALL AS SUBTOTALDETALLADO'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBSERVACION'
				Case lcAtributo == 'DIFERENCIARDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DDETALLE AS DIFERENCIARDETALLE'
				Case lcAtributo == 'COLORPARAELSOMBREADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLORSOMBR AS COLORPARAELSOMBREADO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleFiltrosDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFICA AS IDENTIFICADOR'
				Case lcAtributo == 'IDCAMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAMPO AS IDCAMPO'
				Case lcAtributo == 'VALORDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESDE AS VALORDESDE'
				Case lcAtributo == 'SOLOLECTURADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SLD AS SOLOLECTURADESDE'
				Case lcAtributo == 'VALORHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HASTA AS VALORHASTA'
				Case lcAtributo == 'SOLOLECTURAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SLH AS SOLOLECTURAHASTA'
				Case lcAtributo == 'NORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORDEN AS NORDEN'
				Case lcAtributo == 'ACTIVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVADO AS ACTIVADO'
				Case lcAtributo == 'CRITERIODEINICIALIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRITEINIT AS CRITERIODEINICIALIZACION'
				Case lcAtributo == 'DIASHACIAATRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIASATRAS AS DIASHACIAATRAS'
				Case lcAtributo == 'VALORNUMERICOINICIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VNIDESDE AS VALORNUMERICOINICIAL_DESDE'
				Case lcAtributo == 'VALORNUMERICOINICIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VNIHASTA AS VALORNUMERICOINICIAL_HASTA'
				Case lcAtributo == 'VALORCARACTERINICIAL_DESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VCIDESDE AS VALORCARACTERINICIAL_DESDE'
				Case lcAtributo == 'VALORCARACTERINICIAL_HASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VCIHASTA AS VALORCARACTERINICIAL_HASTA'
				Case lcAtributo == 'VALORBOOLEANOINICIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VIBOOLEANO AS VALORBOOLEANOINICIAL'
				Case lcAtributo == 'VALORSINOINICIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISINOBOOL AS VALORSINOINICIAL'
				Case lcAtributo == 'SOLOLECTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SLECTURA AS SOLOLECTURA'
				Case lcAtributo == 'NOINFORMAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOINFORMAR AS NOINFORMAR'
				Case lcAtributo == 'NOMOSTRAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMOSTRAR AS NOMOSTRAR'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCamposDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFICA AS IDENTIFICADOR'
				Case lcAtributo == 'IDCAMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAMPO AS IDCAMPO'
				Case lcAtributo == 'ETIQUETAREPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ETIQUETA AS ETIQUETAREPORTE'
				Case lcAtributo == 'LONGITUDREPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LONGITUD AS LONGITUDREPORTE'
				Case lcAtributo == 'DECIMALESREPORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DECIMALES AS DECIMALESREPORTE'
				Case lcAtributo == 'MOSTRARCEROS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MCEROS AS MOSTRARCEROS'
				Case lcAtributo == 'GRUPOVISUAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUPOV AS GRUPOVISUAL'
				Case lcAtributo == 'EXPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPRESION AS EXPRESION'
				Case lcAtributo == 'EXPRESIONNUEVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXPRESIONN AS EXPRESIONNUEVA'
				Case lcAtributo == 'TIPOCALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CALCULO AS TIPOCALCULO'
				Case lcAtributo == 'NORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORDEN AS NORDEN'
				Case lcAtributo == 'ACTIVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVADO AS ACTIVADO'
				Case lcAtributo == 'LINEAVERTICAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LVERTICAL AS LINEAVERTICAL'
				Case lcAtributo == 'PUEDECRECER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PCRECER AS PUEDECRECER'
				Case lcAtributo == 'OCULTAREPETIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OREPETIDO AS OCULTAREPETIDO'
				Case lcAtributo == 'TAMAÑOORIGINALIMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MIMAGEN AS TAMAÑOORIGINALIMAGEN'
				Case lcAtributo == 'ANCHOIMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'WIMAGEN AS ANCHOIMAGEN'
				Case lcAtributo == 'ALTOIMAGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HIMAGEN AS ALTOIMAGEN'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleSubtotalDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFICA AS IDENTIFICADOR'
				Case lcAtributo == 'IDCAMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAMPO AS IDCAMPO'
				Case lcAtributo == 'LNUEVAPAGINAANTES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPAGENEW AS LNUEVAPAGINAANTES'
				Case lcAtributo == 'NORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORDEN AS NORDEN'
				Case lcAtributo == 'ACTIVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVADO AS ACTIVADO'
				Case lcAtributo == 'NSUBTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NSUBTOTAL AS NSUBTOTAL'
				Case lcAtributo == 'FORMULA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FORMULA AS FORMULA'
				Case lcAtributo == 'ANCHOFORMULA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANCHO AS ANCHOFORMULA'
				Case lcAtributo == 'ETIQUETAFORMULA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ETIQF AS ETIQUETAFORMULA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenamientosDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'IDENTIFICADOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDENTIFICA AS IDENTIFICADOR'
				Case lcAtributo == 'IDCAMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAMPO AS IDCAMPO'
				Case lcAtributo == 'NORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORDEN AS NORDEN'
				Case lcAtributo == 'ACTIVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVADO AS ACTIVADO'
				Case lcAtributo == 'SENTIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENTIDO AS SENTIDO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleSalidasDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS TIPO'
				Case lcAtributo == 'EXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EXTENDIDO AS EXTENDIDO'
				Case lcAtributo == 'ACTIVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACTIVADO AS ACTIVADO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'TITULOSDECOLUMNASDESUBREPORTEENCP'
				lcCampo = 'COLSUBRECP'
			Case upper( alltrim( tcAtributo ) ) == 'REPETIRCABECERASDEGRUPOS'
				lcCampo = 'REPECABGRU'
			Case upper( alltrim( tcAtributo ) ) == 'TITULOSDECOLUMNASDEGRUPOENCP'
				lcCampo = 'COLGRUPOCP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERACIONDEPAGINASIMPLE'
				lcCampo = 'PAGSIMPLE'
			Case upper( alltrim( tcAtributo ) ) == 'MANTENERGRUPOSUNIDOS'
				lcCampo = 'MANTGRUNI'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEENCABEZADODEREPORTE'
				lcCampo = 'ENCREPORTE'
			Case upper( alltrim( tcAtributo ) ) == 'USATRANSPORTEENTREPAGINAS'
				lcCampo = 'TRANSPAG'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEENCABEZADODEPAGINA'
				lcCampo = 'ENCPAGINA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEFECHADEIMPRESION'
				lcCampo = 'FECHAIMPRE'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEINFORMACIONDECORRIDA'
				lcCampo = 'INFCORRIDA'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMERESUMENDEREPORTE'
				lcCampo = 'RESUMENREP'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEENCABEZADODEDETALLE'
				lcCampo = 'ENCDETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEHORADEIMPRESION'
				lcCampo = 'HORAIMPRE'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRIMEINFORMACIONDECONTEXTO'
				lcCampo = 'INFOCONTEX'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'MAILPARA'
				lcCampo = 'MPARA'
			Case upper( alltrim( tcAtributo ) ) == 'CLISTADO'
				lcCampo = 'CLISTADO'
			Case upper( alltrim( tcAtributo ) ) == 'ESDEFAULT'
				lcCampo = 'ESDEFAULT'
			Case upper( alltrim( tcAtributo ) ) == 'ESTILO'
				lcCampo = 'CESTILO'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADORORDENAMIENTO'
				lcCampo = 'IDENTIFICA'
			Case upper( alltrim( tcAtributo ) ) == 'MAILASUNTO'
				lcCampo = 'MASUNTO'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENDERECHO'
				lcCampo = 'MDER'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENIZQUIERDO'
				lcCampo = 'MIZQ'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENPIE'
				lcCampo = 'MPIE'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENCABECERA'
				lcCampo = 'MCAB'
			Case upper( alltrim( tcAtributo ) ) == 'ORIENTACION'
				lcCampo = 'ORIEN'
			Case upper( alltrim( tcAtributo ) ) == 'MAILCONCOPIA'
				lcCampo = 'MCC'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENADOPOR'
				lcCampo = 'ORDPOR'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOORDENAMIENTO'
				lcCampo = 'TIPORD'
			Case upper( alltrim( tcAtributo ) ) == 'TITULOLISTADO'
				lcCampo = 'TITULO'
			Case upper( alltrim( tcAtributo ) ) == 'IMAGENLISTADO'
				lcCampo = 'IMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'MAILCONCOPIAOCULTA'
				lcCampo = 'MCCO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'DBDATO'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINOTIPO'
				lcCampo = 'DSTNOTIP'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINORUTA'
				lcCampo = 'DSTNORUT'
			Case upper( alltrim( tcAtributo ) ) == 'MAILMENSAJE'
				lcCampo = 'MENSAJE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSDETALLADA'
				lcCampo = 'DBDATOD'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINOARCHIVO'
				lcCampo = 'DSTNOARC'
			Case upper( alltrim( tcAtributo ) ) == 'DESTINOFECHAHORA'
				lcCampo = 'DSTNOFH'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALDETALLADO'
				lcCampo = 'SUBTDETALL'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'DIFERENCIARDETALLE'
				lcCampo = 'DDETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'COLORPARAELSOMBREADO'
				lcCampo = 'COLORSOMBR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleFiltrosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'IDENTIFICA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCAMPO'
				lcCampo = 'IDCAMPO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDESDE'
				lcCampo = 'DESDE'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOLECTURADESDE'
				lcCampo = 'SLD'
			Case upper( alltrim( tcAtributo ) ) == 'VALORHASTA'
				lcCampo = 'HASTA'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOLECTURAHASTA'
				lcCampo = 'SLH'
			Case upper( alltrim( tcAtributo ) ) == 'NORDEN'
				lcCampo = 'NORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVADO'
				lcCampo = 'ACTIVADO'
			Case upper( alltrim( tcAtributo ) ) == 'CRITERIODEINICIALIZACION'
				lcCampo = 'CRITEINIT'
			Case upper( alltrim( tcAtributo ) ) == 'DIASHACIAATRAS'
				lcCampo = 'DIASATRAS'
			Case upper( alltrim( tcAtributo ) ) == 'VALORNUMERICOINICIAL_DESDE'
				lcCampo = 'VNIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VALORNUMERICOINICIAL_HASTA'
				lcCampo = 'VNIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALORCARACTERINICIAL_DESDE'
				lcCampo = 'VCIDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'VALORCARACTERINICIAL_HASTA'
				lcCampo = 'VCIHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'VALORBOOLEANOINICIAL'
				lcCampo = 'VIBOOLEANO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORSINOINICIAL'
				lcCampo = 'VISINOBOOL'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOLECTURA'
				lcCampo = 'SLECTURA'
			Case upper( alltrim( tcAtributo ) ) == 'NOINFORMAR'
				lcCampo = 'NOINFORMAR'
			Case upper( alltrim( tcAtributo ) ) == 'NOMOSTRAR'
				lcCampo = 'NOMOSTRAR'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCamposDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'IDENTIFICA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCAMPO'
				lcCampo = 'IDCAMPO'
			Case upper( alltrim( tcAtributo ) ) == 'ETIQUETAREPORTE'
				lcCampo = 'ETIQUETA'
			Case upper( alltrim( tcAtributo ) ) == 'LONGITUDREPORTE'
				lcCampo = 'LONGITUD'
			Case upper( alltrim( tcAtributo ) ) == 'DECIMALESREPORTE'
				lcCampo = 'DECIMALES'
			Case upper( alltrim( tcAtributo ) ) == 'MOSTRARCEROS'
				lcCampo = 'MCEROS'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPOVISUAL'
				lcCampo = 'GRUPOV'
			Case upper( alltrim( tcAtributo ) ) == 'EXPRESION'
				lcCampo = 'EXPRESION'
			Case upper( alltrim( tcAtributo ) ) == 'EXPRESIONNUEVA'
				lcCampo = 'EXPRESIONN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCALCULO'
				lcCampo = 'CALCULO'
			Case upper( alltrim( tcAtributo ) ) == 'NORDEN'
				lcCampo = 'NORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVADO'
				lcCampo = 'ACTIVADO'
			Case upper( alltrim( tcAtributo ) ) == 'LINEAVERTICAL'
				lcCampo = 'LVERTICAL'
			Case upper( alltrim( tcAtributo ) ) == 'PUEDECRECER'
				lcCampo = 'PCRECER'
			Case upper( alltrim( tcAtributo ) ) == 'OCULTAREPETIDO'
				lcCampo = 'OREPETIDO'
			Case upper( alltrim( tcAtributo ) ) == 'TAMAÑOORIGINALIMAGEN'
				lcCampo = 'MIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHOIMAGEN'
				lcCampo = 'WIMAGEN'
			Case upper( alltrim( tcAtributo ) ) == 'ALTOIMAGEN'
				lcCampo = 'HIMAGEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleSubtotalDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'IDENTIFICA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCAMPO'
				lcCampo = 'IDCAMPO'
			Case upper( alltrim( tcAtributo ) ) == 'LNUEVAPAGINAANTES'
				lcCampo = 'LPAGENEW'
			Case upper( alltrim( tcAtributo ) ) == 'NORDEN'
				lcCampo = 'NORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVADO'
				lcCampo = 'ACTIVADO'
			Case upper( alltrim( tcAtributo ) ) == 'NSUBTOTAL'
				lcCampo = 'NSUBTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'FORMULA'
				lcCampo = 'FORMULA'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHOFORMULA'
				lcCampo = 'ANCHO'
			Case upper( alltrim( tcAtributo ) ) == 'ETIQUETAFORMULA'
				lcCampo = 'ETIQF'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenamientosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'IDENTIFICADOR'
				lcCampo = 'IDENTIFICA'
			Case upper( alltrim( tcAtributo ) ) == 'IDCAMPO'
				lcCampo = 'IDCAMPO'
			Case upper( alltrim( tcAtributo ) ) == 'NORDEN'
				lcCampo = 'NORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVADO'
				lcCampo = 'ACTIVADO'
			Case upper( alltrim( tcAtributo ) ) == 'SENTIDO'
				lcCampo = 'SENTIDO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleSalidasDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'EXTENDIDO'
				lcCampo = 'EXTENDIDO'
			Case upper( alltrim( tcAtributo ) ) == 'ACTIVADO'
				lcCampo = 'ACTIVADO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'FILTROSDETALLE'
			lcRetorno = 'DETFILTROPER'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'CAMPOSDETALLE'
			lcRetorno = 'DETCAMTROPER'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'SUBTOTALDETALLE'
			lcRetorno = 'DETCAMSUBPER'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENAMIENTOSDETALLE'
			lcRetorno = 'DETCAMORDPER'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'SALIDASDETALLE'
			lcRetorno = 'DETSALIDASLPER'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxLtdspersFecexpo, lxLtdspersFectrans, lxLtdspersFecimpo, lxLtdspersFaltafw, lxLtdspersFmodifw, lxLtdspersHoraexpo, lxLtdspersHaltafw, lxLtdspersBdaltafw, lxLtdspersEsttrans, lxLtdspersBdmodifw, lxLtdspersHoraimpo, lxLtdspersUmodifw, lxLtdspersValtafw, lxLtdspersVmodifw, lxLtdspersZadsfw, lxLtdspersSmodifw, lxLtdspersUaltafw, lxLtdspersSaltafw, lxLtdspersHmodifw, lxLtdspersAnulado, lxLtdspersBloqreg, lxLtdspersColsubrecp, lxLtdspersRepecabgru, lxLtdspersColgrupocp, lxLtdspersPagsimple, lxLtdspersMantgruni, lxLtdspersEncreporte, lxLtdspersTranspag, lxLtdspersEncpagina, lxLtdspersFechaimpre, lxLtdspersInfcorrida, lxLtdspersResumenrep, lxLtdspersEncdetalle, lxLtdspersHoraimpre, lxLtdspersInfocontex, lxLtdspersCcod, lxLtdspersMpara, lxLtdspersClistado, lxLtdspersEsdefault, lxLtdspersCestilo, lxLtdspersIdentifica, lxLtdspersMasunto, lxLtdspersMder, lxLtdspersMizq, lxLtdspersMpie, lxLtdspersMcab, lxLtdspersOrien, lxLtdspersMcc, lxLtdspersDescrip, lxLtdspersOrdpor, lxLtdspersTipord, lxLtdspersTitulo, lxLtdspersImagen, lxLtdspersMcco, lxLtdspersDbdato, lxLtdspersDstnotip, lxLtdspersDstnorut, lxLtdspersMensaje, lxLtdspersDbdatod, lxLtdspersDstnoarc, lxLtdspersDstnofh, lxLtdspersSubtdetall, lxLtdspersObs, lxLtdspersDdetalle, lxLtdspersColorsombr
				lxLtdspersFecexpo =  .Fechaexpo			lxLtdspersFectrans =  .Fechatransferencia			lxLtdspersFecimpo =  .Fechaimpo			lxLtdspersFaltafw =  .Fechaaltafw			lxLtdspersFmodifw =  .Fechamodificacionfw			lxLtdspersHoraexpo =  .Horaexpo			lxLtdspersHaltafw =  .Horaaltafw			lxLtdspersBdaltafw =  .Basededatosaltafw			lxLtdspersEsttrans =  .Estadotransferencia			lxLtdspersBdmodifw =  .Basededatosmodificacionfw			lxLtdspersHoraimpo =  .Horaimpo			lxLtdspersUmodifw =  .Usuariomodificacionfw			lxLtdspersValtafw =  .Versionaltafw			lxLtdspersVmodifw =  .Versionmodificacionfw			lxLtdspersZadsfw =  .Zadsfw			lxLtdspersSmodifw =  .Seriemodificacionfw			lxLtdspersUaltafw =  .Usuarioaltafw			lxLtdspersSaltafw =  .Seriealtafw			lxLtdspersHmodifw =  .Horamodificacionfw			lxLtdspersAnulado =  .Anulado			lxLtdspersBloqreg =  .Bloquearregistro			lxLtdspersColsubrecp =  .Titulosdecolumnasdesubreporteencp			lxLtdspersRepecabgru =  .Repetircabecerasdegrupos			lxLtdspersColgrupocp =  .Titulosdecolumnasdegrupoencp			lxLtdspersPagsimple =  .Numeraciondepaginasimple			lxLtdspersMantgruni =  .Mantenergruposunidos			lxLtdspersEncreporte =  .Imprimeencabezadodereporte			lxLtdspersTranspag =  .Usatransporteentrepaginas			lxLtdspersEncpagina =  .Imprimeencabezadodepagina			lxLtdspersFechaimpre =  .Imprimefechadeimpresion			lxLtdspersInfcorrida =  .Imprimeinformaciondecorrida			lxLtdspersResumenrep =  .Imprimeresumendereporte			lxLtdspersEncdetalle =  .Imprimeencabezadodedetalle			lxLtdspersHoraimpre =  .Imprimehoradeimpresion			lxLtdspersInfocontex =  .Imprimeinformaciondecontexto			lxLtdspersCcod =  .Codigo			lxLtdspersMpara =  .Mailpara			lxLtdspersClistado =  .Clistado			lxLtdspersEsdefault =  .Esdefault			lxLtdspersCestilo =  upper( .Estilo_PK ) 			lxLtdspersIdentifica =  .Identificadorordenamiento			lxLtdspersMasunto =  .Mailasunto			lxLtdspersMder =  .Margenderecho			lxLtdspersMizq =  .Margenizquierdo			lxLtdspersMpie =  .Margenpie			lxLtdspersMcab =  .Margencabecera			lxLtdspersOrien =  .Orientacion			lxLtdspersMcc =  .Mailconcopia			lxLtdspersDescrip =  .Descripcion			lxLtdspersOrdpor =  .Ordenadopor			lxLtdspersTipord =  .Tipoordenamiento			lxLtdspersTitulo =  .Titulolistado			lxLtdspersImagen =  .Imagenlistado			lxLtdspersMcco =  .Mailconcopiaoculta			lxLtdspersDbdato =  .Basededatos			lxLtdspersDstnotip =  .Destinotipo			lxLtdspersDstnorut =  .Destinoruta			lxLtdspersMensaje =  .Mailmensaje			lxLtdspersDbdatod =  .Basededatosdetallada			lxLtdspersDstnoarc =  .Destinoarchivo			lxLtdspersDstnofh =  .Destinofechahora			lxLtdspersSubtdetall =  .Subtotaldetallado			lxLtdspersObs =  .Observacion			lxLtdspersDdetalle =  .Diferenciardetalle			lxLtdspersColorsombr =  .Colorparaelsombreado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.LTDSPERS ( "Fecexpo","Fectrans","Fecimpo","Faltafw","Fmodifw","Horaexpo","Haltafw","Bdaltafw","Esttrans","Bdmodifw","Horaimpo","Umodifw","Valtafw","Vmodifw","Zadsfw","Smodifw","Ualtafw","Saltafw","Hmodifw","Anulado","Bloqreg","Colsubrecp","Repecabgru","Colgrupocp","Pagsimple","Mantgruni","Encreporte","Transpag","Encpagina","Fechaimpre","Infcorrida","Resumenrep","Encdetalle","Horaimpre","Infocontex","Ccod","Mpara","Clistado","Esdefault","Cestilo","Identifica","Masunto","Mder","Mizq","Mpie","Mcab","Orien","Mcc","Descrip","Ordpor","Tipord","Titulo","Imagen","Mcco","Dbdato","Dstnotip","Dstnorut","Mensaje","Dbdatod","Dstnoarc","Dstnofh","Subtdetall","Obs","Ddetalle","Colorsombr" ) values ( <<"'" + this.ConvertirDateSql( lxLtdspersFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxLtdspersFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersHmodifw ) + "'" >>, <<iif( lxLtdspersAnulado, 1, 0 ) >>, <<iif( lxLtdspersBloqreg, 1, 0 ) >>, <<iif( lxLtdspersColsubrecp, 1, 0 ) >>, <<iif( lxLtdspersRepecabgru, 1, 0 ) >>, <<iif( lxLtdspersColgrupocp, 1, 0 ) >>, <<iif( lxLtdspersPagsimple, 1, 0 ) >>, <<iif( lxLtdspersMantgruni, 1, 0 ) >>, <<iif( lxLtdspersEncreporte, 1, 0 ) >>, <<iif( lxLtdspersTranspag, 1, 0 ) >>, <<iif( lxLtdspersEncpagina, 1, 0 ) >>, <<iif( lxLtdspersFechaimpre, 1, 0 ) >>, <<iif( lxLtdspersInfcorrida, 1, 0 ) >>, <<iif( lxLtdspersResumenrep, 1, 0 ) >>, <<iif( lxLtdspersEncdetalle, 1, 0 ) >>, <<iif( lxLtdspersHoraimpre, 1, 0 ) >>, <<iif( lxLtdspersInfocontex, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMpara ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersClistado ) + "'" >>, <<iif( lxLtdspersEsdefault, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersCestilo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersIdentifica ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMasunto ) + "'" >>, <<lxLtdspersMder >>, <<lxLtdspersMizq >>, <<lxLtdspersMpie >>, <<lxLtdspersMcab >>, <<lxLtdspersOrien >>, <<"'" + this.FormatearTextoSql( lxLtdspersMcc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersDescrip ) + "'" >>, <<lxLtdspersOrdpor >>, <<lxLtdspersTipord >>, <<"'" + this.FormatearTextoSql( lxLtdspersTitulo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersImagen ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMcco ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersDbdato ) + "'" >>, <<lxLtdspersDstnotip >>, <<"'" + this.FormatearTextoSql( lxLtdspersDstnorut ) + "'" >>, <<"'" + this.FormatearTextoSql( lxLtdspersMensaje ) + "'" >>, <<iif( lxLtdspersDbdatod, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersDstnoarc ) + "'" >>, <<iif( lxLtdspersDstnofh, 1, 0 ) >>, <<iif( lxLtdspersSubtdetall, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxLtdspersObs ) + "'" >>, <<iif( lxLtdspersDdetalle, 1, 0 ) >>, <<lxLtdspersColorsombr >> )
		endtext
		loColeccion.cTabla = 'LTDSPERS' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FiltrosDetalle
				if this.oEntidad.FiltrosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxValordesde = loItem.Valordesde
					lxSololecturadesde = loItem.Sololecturadesde
					lxValorhasta = loItem.Valorhasta
					lxSololecturahasta = loItem.Sololecturahasta
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxCriteriodeinicializacion = loItem.Criteriodeinicializacion
					lxDiashaciaatras = loItem.Diashaciaatras
					lxValornumericoinicial_desde = loItem.Valornumericoinicial_desde
					lxValornumericoinicial_hasta = loItem.Valornumericoinicial_hasta
					lxValorcaracterinicial_desde = loItem.Valorcaracterinicial_desde
					lxValorcaracterinicial_hasta = loItem.Valorcaracterinicial_hasta
					lxValorbooleanoinicial = loItem.Valorbooleanoinicial
					lxValorsinoinicial = loItem.Valorsinoinicial
					lxSololectura = loItem.Sololectura
					lxNoinformar = loItem.Noinformar
					lxNomostrar = loItem.Nomostrar
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETFILTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","desde","SLD","hasta","SLH","nOrden","activado","CriteInit","DiasAtras","VNIDesde","VNIHasta","VCIDesde","VCIHasta","VIBooleano","VISiNoBool","SLectura","NoInformar","NoMostrar" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxValordesde ) + "'">>, <<iif( lxSololecturadesde, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorhasta ) + "'">>, <<iif( lxSololecturahasta, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxCriteriodeinicializacion>>, <<lxDiashaciaatras>>, <<lxValornumericoinicial_desde>>, <<lxValornumericoinicial_hasta>>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_desde ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_hasta ) + "'">>, <<lxValorbooleanoinicial>>, <<lxValorsinoinicial>>, <<iif( lxSololectura, 1, 0 )>>, <<iif( lxNoinformar, 1, 0 )>>, <<iif( lxNomostrar, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CamposDetalle
				if this.oEntidad.CamposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxEtiquetareporte = loItem.Etiquetareporte
					lxLongitudreporte = loItem.Longitudreporte
					lxDecimalesreporte = loItem.Decimalesreporte
					lxMostrarceros = loItem.Mostrarceros
					lxGrupovisual = loItem.Grupovisual
					lxExpresion = loItem.Expresion
					lxExpresionnueva_PK = loItem.Expresionnueva_PK
					lxTipocalculo = loItem.Tipocalculo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxLineavertical = loItem.Lineavertical
					lxPuedecrecer = loItem.Puedecrecer
					lxOcultarepetido = loItem.Ocultarepetido
					lxTamañooriginalimagen = loItem.Tamañooriginalimagen
					lxAnchoimagen = loItem.Anchoimagen
					lxAltoimagen = loItem.Altoimagen
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","Etiqueta","Longitud","Decimales","Mceros","GrupoV","Expresion","ExpresionN","Calculo","nOrden","activado","LVertical","PCrecer","ORepetido","MImagen","WImagen","HImagen" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxEtiquetareporte ) + "'">>, <<lxLongitudreporte>>, <<lxDecimalesreporte>>, <<lxMostrarceros>>, <<lxGrupovisual>>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresionnueva_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocalculo ) + "'">>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<iif( lxLineavertical, 1, 0 )>>, <<iif( lxPuedecrecer, 1, 0 )>>, <<iif( lxOcultarepetido, 1, 0 )>>, <<iif( lxTamañooriginalimagen, 1, 0 )>>, <<lxAnchoimagen>>, <<lxAltoimagen>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SubtotalDetalle
				if this.oEntidad.SubtotalDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxLnuevapaginaantes = loItem.Lnuevapaginaantes
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxNsubtotal = loItem.Nsubtotal
					lxFormula = loItem.Formula
					lxAnchoformula = loItem.Anchoformula
					lxEtiquetaformula = loItem.Etiquetaformula
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMSUBPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","lpagenew","nOrden","activado","nSubtotal","Formula","Ancho","EtiqF" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<iif( lxLnuevapaginaantes, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxNsubtotal>>, <<"'" + this.FormatearTextoSql( lxFormula ) + "'">>, <<lxAnchoformula>>, <<"'" + this.FormatearTextoSql( lxEtiquetaformula ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenamientosDetalle
				if this.oEntidad.OrdenamientosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxSentido = loItem.Sentido
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMORDPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","nOrden","activado","Sentido" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxSentido>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SalidasDetalle
				if this.oEntidad.SalidasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxTipo = loItem.Tipo
					lxExtendido = loItem.Extendido
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETSALIDASLPER("NROITEM","BLOQREG","codigo","tipo","Extendido","activado" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<iif( lxExtendido, 1, 0 )>>, <<iif( lxActivado, 1, 0 )>> ) 
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
			local  lxLtdspersFecexpo, lxLtdspersFectrans, lxLtdspersFecimpo, lxLtdspersFaltafw, lxLtdspersFmodifw, lxLtdspersHoraexpo, lxLtdspersHaltafw, lxLtdspersBdaltafw, lxLtdspersEsttrans, lxLtdspersBdmodifw, lxLtdspersHoraimpo, lxLtdspersUmodifw, lxLtdspersValtafw, lxLtdspersVmodifw, lxLtdspersZadsfw, lxLtdspersSmodifw, lxLtdspersUaltafw, lxLtdspersSaltafw, lxLtdspersHmodifw, lxLtdspersAnulado, lxLtdspersBloqreg, lxLtdspersColsubrecp, lxLtdspersRepecabgru, lxLtdspersColgrupocp, lxLtdspersPagsimple, lxLtdspersMantgruni, lxLtdspersEncreporte, lxLtdspersTranspag, lxLtdspersEncpagina, lxLtdspersFechaimpre, lxLtdspersInfcorrida, lxLtdspersResumenrep, lxLtdspersEncdetalle, lxLtdspersHoraimpre, lxLtdspersInfocontex, lxLtdspersCcod, lxLtdspersMpara, lxLtdspersClistado, lxLtdspersEsdefault, lxLtdspersCestilo, lxLtdspersIdentifica, lxLtdspersMasunto, lxLtdspersMder, lxLtdspersMizq, lxLtdspersMpie, lxLtdspersMcab, lxLtdspersOrien, lxLtdspersMcc, lxLtdspersDescrip, lxLtdspersOrdpor, lxLtdspersTipord, lxLtdspersTitulo, lxLtdspersImagen, lxLtdspersMcco, lxLtdspersDbdato, lxLtdspersDstnotip, lxLtdspersDstnorut, lxLtdspersMensaje, lxLtdspersDbdatod, lxLtdspersDstnoarc, lxLtdspersDstnofh, lxLtdspersSubtdetall, lxLtdspersObs, lxLtdspersDdetalle, lxLtdspersColorsombr
				lxLtdspersFecexpo =  .Fechaexpo			lxLtdspersFectrans =  .Fechatransferencia			lxLtdspersFecimpo =  .Fechaimpo			lxLtdspersFaltafw =  .Fechaaltafw			lxLtdspersFmodifw =  .Fechamodificacionfw			lxLtdspersHoraexpo =  .Horaexpo			lxLtdspersHaltafw =  .Horaaltafw			lxLtdspersBdaltafw =  .Basededatosaltafw			lxLtdspersEsttrans =  .Estadotransferencia			lxLtdspersBdmodifw =  .Basededatosmodificacionfw			lxLtdspersHoraimpo =  .Horaimpo			lxLtdspersUmodifw =  .Usuariomodificacionfw			lxLtdspersValtafw =  .Versionaltafw			lxLtdspersVmodifw =  .Versionmodificacionfw			lxLtdspersZadsfw =  .Zadsfw			lxLtdspersSmodifw =  .Seriemodificacionfw			lxLtdspersUaltafw =  .Usuarioaltafw			lxLtdspersSaltafw =  .Seriealtafw			lxLtdspersHmodifw =  .Horamodificacionfw			lxLtdspersAnulado =  .Anulado			lxLtdspersBloqreg =  .Bloquearregistro			lxLtdspersColsubrecp =  .Titulosdecolumnasdesubreporteencp			lxLtdspersRepecabgru =  .Repetircabecerasdegrupos			lxLtdspersColgrupocp =  .Titulosdecolumnasdegrupoencp			lxLtdspersPagsimple =  .Numeraciondepaginasimple			lxLtdspersMantgruni =  .Mantenergruposunidos			lxLtdspersEncreporte =  .Imprimeencabezadodereporte			lxLtdspersTranspag =  .Usatransporteentrepaginas			lxLtdspersEncpagina =  .Imprimeencabezadodepagina			lxLtdspersFechaimpre =  .Imprimefechadeimpresion			lxLtdspersInfcorrida =  .Imprimeinformaciondecorrida			lxLtdspersResumenrep =  .Imprimeresumendereporte			lxLtdspersEncdetalle =  .Imprimeencabezadodedetalle			lxLtdspersHoraimpre =  .Imprimehoradeimpresion			lxLtdspersInfocontex =  .Imprimeinformaciondecontexto			lxLtdspersCcod =  .Codigo			lxLtdspersMpara =  .Mailpara			lxLtdspersClistado =  .Clistado			lxLtdspersEsdefault =  .Esdefault			lxLtdspersCestilo =  upper( .Estilo_PK ) 			lxLtdspersIdentifica =  .Identificadorordenamiento			lxLtdspersMasunto =  .Mailasunto			lxLtdspersMder =  .Margenderecho			lxLtdspersMizq =  .Margenizquierdo			lxLtdspersMpie =  .Margenpie			lxLtdspersMcab =  .Margencabecera			lxLtdspersOrien =  .Orientacion			lxLtdspersMcc =  .Mailconcopia			lxLtdspersDescrip =  .Descripcion			lxLtdspersOrdpor =  .Ordenadopor			lxLtdspersTipord =  .Tipoordenamiento			lxLtdspersTitulo =  .Titulolistado			lxLtdspersImagen =  .Imagenlistado			lxLtdspersMcco =  .Mailconcopiaoculta			lxLtdspersDbdato =  .Basededatos			lxLtdspersDstnotip =  .Destinotipo			lxLtdspersDstnorut =  .Destinoruta			lxLtdspersMensaje =  .Mailmensaje			lxLtdspersDbdatod =  .Basededatosdetallada			lxLtdspersDstnoarc =  .Destinoarchivo			lxLtdspersDstnofh =  .Destinofechahora			lxLtdspersSubtdetall =  .Subtotaldetallado			lxLtdspersObs =  .Observacion			lxLtdspersDdetalle =  .Diferenciardetalle			lxLtdspersColorsombr =  .Colorparaelsombreado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  LTDSPERS.CCOD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.LTDSPERS set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxLtdspersFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxLtdspersFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxLtdspersFecimpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxLtdspersFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxLtdspersFmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxLtdspersHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxLtdspersHaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxLtdspersBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxLtdspersEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersBdmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxLtdspersHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxLtdspersValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxLtdspersZadsfw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxLtdspersUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxLtdspersSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxLtdspersHmodifw ) + "'">>, "Anulado" = <<iif( lxLtdspersAnulado, 1, 0 )>>, "Bloqreg" = <<iif( lxLtdspersBloqreg, 1, 0 )>>, "Colsubrecp" = <<iif( lxLtdspersColsubrecp, 1, 0 )>>, "Repecabgru" = <<iif( lxLtdspersRepecabgru, 1, 0 )>>, "Colgrupocp" = <<iif( lxLtdspersColgrupocp, 1, 0 )>>, "Pagsimple" = <<iif( lxLtdspersPagsimple, 1, 0 )>>, "Mantgruni" = <<iif( lxLtdspersMantgruni, 1, 0 )>>, "Encreporte" = <<iif( lxLtdspersEncreporte, 1, 0 )>>, "Transpag" = <<iif( lxLtdspersTranspag, 1, 0 )>>, "Encpagina" = <<iif( lxLtdspersEncpagina, 1, 0 )>>, "Fechaimpre" = <<iif( lxLtdspersFechaimpre, 1, 0 )>>, "Infcorrida" = <<iif( lxLtdspersInfcorrida, 1, 0 )>>, "Resumenrep" = <<iif( lxLtdspersResumenrep, 1, 0 )>>, "Encdetalle" = <<iif( lxLtdspersEncdetalle, 1, 0 )>>, "Horaimpre" = <<iif( lxLtdspersHoraimpre, 1, 0 )>>, "Infocontex" = <<iif( lxLtdspersInfocontex, 1, 0 )>>, "Ccod" = <<"'" + this.FormatearTextoSql( lxLtdspersCcod ) + "'">>, "Mpara" = <<"'" + this.FormatearTextoSql( lxLtdspersMpara ) + "'">>, "Clistado" = <<"'" + this.FormatearTextoSql( lxLtdspersClistado ) + "'">>, "Esdefault" = <<iif( lxLtdspersEsdefault, 1, 0 )>>, "Cestilo" = <<"'" + this.FormatearTextoSql( lxLtdspersCestilo ) + "'">>, "Identifica" = <<"'" + this.FormatearTextoSql( lxLtdspersIdentifica ) + "'">>, "Masunto" = <<"'" + this.FormatearTextoSql( lxLtdspersMasunto ) + "'">>, "Mder" = <<lxLtdspersMder>>, "Mizq" = <<lxLtdspersMizq>>, "Mpie" = <<lxLtdspersMpie>>, "Mcab" = <<lxLtdspersMcab>>, "Orien" = <<lxLtdspersOrien>>, "Mcc" = <<"'" + this.FormatearTextoSql( lxLtdspersMcc ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxLtdspersDescrip ) + "'">>, "Ordpor" = <<lxLtdspersOrdpor>>, "Tipord" = <<lxLtdspersTipord>>, "Titulo" = <<"'" + this.FormatearTextoSql( lxLtdspersTitulo ) + "'">>, "Imagen" = <<"'" + this.FormatearTextoSql( lxLtdspersImagen ) + "'">>, "Mcco" = <<"'" + this.FormatearTextoSql( lxLtdspersMcco ) + "'">>, "Dbdato" = <<"'" + this.FormatearTextoSql( lxLtdspersDbdato ) + "'">>, "Dstnotip" = <<lxLtdspersDstnotip>>, "Dstnorut" = <<"'" + this.FormatearTextoSql( lxLtdspersDstnorut ) + "'">>, "Mensaje" = <<"'" + this.FormatearTextoSql( lxLtdspersMensaje ) + "'">>, "Dbdatod" = <<iif( lxLtdspersDbdatod, 1, 0 )>>, "Dstnoarc" = <<"'" + this.FormatearTextoSql( lxLtdspersDstnoarc ) + "'">>, "Dstnofh" = <<iif( lxLtdspersDstnofh, 1, 0 )>>, "Subtdetall" = <<iif( lxLtdspersSubtdetall, 1, 0 )>>, "Obs" = <<"'" + this.FormatearTextoSql( lxLtdspersObs ) + "'">>, "Ddetalle" = <<iif( lxLtdspersDdetalle, 1, 0 )>>, "Colorsombr" = <<lxLtdspersColorsombr>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'LTDSPERS' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.DETFILTROPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETCAMTROPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETCAMSUBPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETCAMORDPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETSALIDASLPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FiltrosDetalle
				if this.oEntidad.FiltrosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxValordesde = loItem.Valordesde
					lxSololecturadesde = loItem.Sololecturadesde
					lxValorhasta = loItem.Valorhasta
					lxSololecturahasta = loItem.Sololecturahasta
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxCriteriodeinicializacion = loItem.Criteriodeinicializacion
					lxDiashaciaatras = loItem.Diashaciaatras
					lxValornumericoinicial_desde = loItem.Valornumericoinicial_desde
					lxValornumericoinicial_hasta = loItem.Valornumericoinicial_hasta
					lxValorcaracterinicial_desde = loItem.Valorcaracterinicial_desde
					lxValorcaracterinicial_hasta = loItem.Valorcaracterinicial_hasta
					lxValorbooleanoinicial = loItem.Valorbooleanoinicial
					lxValorsinoinicial = loItem.Valorsinoinicial
					lxSololectura = loItem.Sololectura
					lxNoinformar = loItem.Noinformar
					lxNomostrar = loItem.Nomostrar
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETFILTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","desde","SLD","hasta","SLH","nOrden","activado","CriteInit","DiasAtras","VNIDesde","VNIHasta","VCIDesde","VCIHasta","VIBooleano","VISiNoBool","SLectura","NoInformar","NoMostrar" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxValordesde ) + "'">>, <<iif( lxSololecturadesde, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorhasta ) + "'">>, <<iif( lxSololecturahasta, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxCriteriodeinicializacion>>, <<lxDiashaciaatras>>, <<lxValornumericoinicial_desde>>, <<lxValornumericoinicial_hasta>>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_desde ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorcaracterinicial_hasta ) + "'">>, <<lxValorbooleanoinicial>>, <<lxValorsinoinicial>>, <<iif( lxSololectura, 1, 0 )>>, <<iif( lxNoinformar, 1, 0 )>>, <<iif( lxNomostrar, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.CamposDetalle
				if this.oEntidad.CamposDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxEtiquetareporte = loItem.Etiquetareporte
					lxLongitudreporte = loItem.Longitudreporte
					lxDecimalesreporte = loItem.Decimalesreporte
					lxMostrarceros = loItem.Mostrarceros
					lxGrupovisual = loItem.Grupovisual
					lxExpresion = loItem.Expresion
					lxExpresionnueva_PK = loItem.Expresionnueva_PK
					lxTipocalculo = loItem.Tipocalculo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxLineavertical = loItem.Lineavertical
					lxPuedecrecer = loItem.Puedecrecer
					lxOcultarepetido = loItem.Ocultarepetido
					lxTamañooriginalimagen = loItem.Tamañooriginalimagen
					lxAnchoimagen = loItem.Anchoimagen
					lxAltoimagen = loItem.Altoimagen
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMTROPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","Etiqueta","Longitud","Decimales","Mceros","GrupoV","Expresion","ExpresionN","Calculo","nOrden","activado","LVertical","PCrecer","ORepetido","MImagen","WImagen","HImagen" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<"'" + this.FormatearTextoSql( lxEtiquetareporte ) + "'">>, <<lxLongitudreporte>>, <<lxDecimalesreporte>>, <<lxMostrarceros>>, <<lxGrupovisual>>, <<"'" + this.FormatearTextoSql( lxExpresion ) + "'">>, <<"'" + this.FormatearTextoSql( lxExpresionnueva_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocalculo ) + "'">>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<iif( lxLineavertical, 1, 0 )>>, <<iif( lxPuedecrecer, 1, 0 )>>, <<iif( lxOcultarepetido, 1, 0 )>>, <<iif( lxTamañooriginalimagen, 1, 0 )>>, <<lxAnchoimagen>>, <<lxAltoimagen>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SubtotalDetalle
				if this.oEntidad.SubtotalDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxLnuevapaginaantes = loItem.Lnuevapaginaantes
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxNsubtotal = loItem.Nsubtotal
					lxFormula = loItem.Formula
					lxAnchoformula = loItem.Anchoformula
					lxEtiquetaformula = loItem.Etiquetaformula
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMSUBPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","lpagenew","nOrden","activado","nSubtotal","Formula","Ancho","EtiqF" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<iif( lxLnuevapaginaantes, 1, 0 )>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxNsubtotal>>, <<"'" + this.FormatearTextoSql( lxFormula ) + "'">>, <<lxAnchoformula>>, <<"'" + this.FormatearTextoSql( lxEtiquetaformula ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenamientosDetalle
				if this.oEntidad.OrdenamientosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxIdentificador = loItem.Identificador
					lxIdcampo = loItem.Idcampo
					lxNorden = loItem.Norden
					lxActivado = loItem.Activado
					lxSentido = loItem.Sentido
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETCAMORDPER("NROITEM","BLOQREG","codigo","Identifica","idCampo","nOrden","activado","Sentido" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxIdentificador ) + "'">>, <<lxIdcampo>>, <<lxNorden>>, <<iif( lxActivado, 1, 0 )>>, <<lxSentido>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.SalidasDetalle
				if this.oEntidad.SalidasDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxTipo = loItem.Tipo
					lxExtendido = loItem.Extendido
					lxActivado = loItem.Activado
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DETSALIDASLPER("NROITEM","BLOQREG","codigo","tipo","Extendido","activado" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<iif( lxExtendido, 1, 0 )>>, <<iif( lxActivado, 1, 0 )>> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  LTDSPERS.CCOD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.LTDSPERS where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.DETFILTROPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETCAMTROPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETCAMSUBPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETCAMORDPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DETSALIDASLPER where "codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'LTDSPERS' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.LTDSPERS where  LTDSPERS.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.LTDSPERS where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  LTDSPERS.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADOSPERSONALIZADOS'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.LTDSPERS Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.LTDSPERS set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, colsubreCP = ] + Transform( iif( &lcCursor..colsubreCP, 1, 0 ))+ [, repecabgru = ] + Transform( iif( &lcCursor..repecabgru, 1, 0 ))+ [, colgrupoCP = ] + Transform( iif( &lcCursor..colgrupoCP, 1, 0 ))+ [, pagsimple = ] + Transform( iif( &lcCursor..pagsimple, 1, 0 ))+ [, mantgruni = ] + Transform( iif( &lcCursor..mantgruni, 1, 0 ))+ [, encreporte = ] + Transform( iif( &lcCursor..encreporte, 1, 0 ))+ [, transpag = ] + Transform( iif( &lcCursor..transpag, 1, 0 ))+ [, encpagina = ] + Transform( iif( &lcCursor..encpagina, 1, 0 ))+ [, fechaimpre = ] + Transform( iif( &lcCursor..fechaimpre, 1, 0 ))+ [, infcorrida = ] + Transform( iif( &lcCursor..infcorrida, 1, 0 ))+ [, resumenrep = ] + Transform( iif( &lcCursor..resumenrep, 1, 0 ))+ [, encdetalle = ] + Transform( iif( &lcCursor..encdetalle, 1, 0 ))+ [, horaimpre = ] + Transform( iif( &lcCursor..horaimpre, 1, 0 ))+ [, infocontex = ] + Transform( iif( &lcCursor..infocontex, 1, 0 ))+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, Mpara = ] + "'" + this.FormatearTextoSql( &lcCursor..Mpara ) + "'"+ [, cListado = ] + "'" + this.FormatearTextoSql( &lcCursor..cListado ) + "'"+ [, EsDefault = ] + Transform( iif( &lcCursor..EsDefault, 1, 0 ))+ [, cEstilo = ] + "'" + this.FormatearTextoSql( &lcCursor..cEstilo ) + "'"+ [, Identifica = ] + "'" + this.FormatearTextoSql( &lcCursor..Identifica ) + "'"+ [, Masunto = ] + "'" + this.FormatearTextoSql( &lcCursor..Masunto ) + "'"+ [, Mder = ] + transform( &lcCursor..Mder )+ [, mizq = ] + transform( &lcCursor..mizq )+ [, mpie = ] + transform( &lcCursor..mpie )+ [, mcab = ] + transform( &lcCursor..mcab )+ [, Orien = ] + transform( &lcCursor..Orien )+ [, Mcc = ] + "'" + this.FormatearTextoSql( &lcCursor..Mcc ) + "'"+ [, descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'"+ [, OrdPor = ] + transform( &lcCursor..OrdPor )+ [, TipOrd = ] + transform( &lcCursor..TipOrd )+ [, titulo = ] + "'" + this.FormatearTextoSql( &lcCursor..titulo ) + "'"+ [, Imagen = ] + "'" + this.FormatearTextoSql( &lcCursor..Imagen ) + "'"+ [, Mcco = ] + "'" + this.FormatearTextoSql( &lcCursor..Mcco ) + "'"+ [, dbDato = ] + "'" + this.FormatearTextoSql( &lcCursor..dbDato ) + "'"+ [, dstnotip = ] + transform( &lcCursor..dstnotip )+ [, dstnorut = ] + "'" + this.FormatearTextoSql( &lcCursor..dstnorut ) + "'"+ [, Mensaje = ] + "'" + this.FormatearTextoSql( &lcCursor..Mensaje ) + "'"+ [, dbDatoD = ] + Transform( iif( &lcCursor..dbDatoD, 1, 0 ))+ [, dstnoarc = ] + "'" + this.FormatearTextoSql( &lcCursor..dstnoarc ) + "'"+ [, dstnofh = ] + Transform( iif( &lcCursor..dstnofh, 1, 0 ))+ [, subtDetall = ] + Transform( iif( &lcCursor..subtDetall, 1, 0 ))+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, DDetalle = ] + Transform( iif( &lcCursor..DDetalle, 1, 0 ))+ [, ColorSombr = ] + transform( &lcCursor..ColorSombr ) + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FECTRANS, FECIMPO, FALTAFW, FMODIFW, HORAEXPO, HALTAFW, BDALTAFW, ESTTRANS, BDMODIFW, HORAIMPO, UMODIFW, VALTAFW, VMODIFW, ZADSFW, SMODIFW, UALTAFW, SALTAFW, HMODIFW, Anulado, BLOQREG, colsubreCP, repecabgru, colgrupoCP, pagsimple, mantgruni, encreporte, transpag, encpagina, fechaimpre, infcorrida, resumenrep, encdetalle, horaimpre, infocontex, cCod, Mpara, cListado, EsDefault, cEstilo, Identifica, Masunto, Mder, mizq, mpie, mcab, Orien, Mcc, descrip, OrdPor, TipOrd, titulo, Imagen, Mcco, dbDato, dstnotip, dstnorut, Mensaje, dbDatoD, dstnoarc, dstnofh, subtDetall, Obs, DDetalle, ColorSombr
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..colsubreCP, 1, 0 )) + ',' + Transform( iif( &lcCursor..repecabgru, 1, 0 )) + ',' + Transform( iif( &lcCursor..colgrupoCP, 1, 0 )) + ',' + Transform( iif( &lcCursor..pagsimple, 1, 0 )) + ',' + Transform( iif( &lcCursor..mantgruni, 1, 0 )) + ',' + Transform( iif( &lcCursor..encreporte, 1, 0 )) + ',' + Transform( iif( &lcCursor..transpag, 1, 0 )) + ',' + Transform( iif( &lcCursor..encpagina, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..fechaimpre, 1, 0 )) + ',' + Transform( iif( &lcCursor..infcorrida, 1, 0 )) + ',' + Transform( iif( &lcCursor..resumenrep, 1, 0 )) + ',' + Transform( iif( &lcCursor..encdetalle, 1, 0 )) + ',' + Transform( iif( &lcCursor..horaimpre, 1, 0 )) + ',' + Transform( iif( &lcCursor..infocontex, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Mpara ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cListado ) + "'" + ',' + Transform( iif( &lcCursor..EsDefault, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEstilo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Identifica ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Masunto ) + "'" + ',' + transform( &lcCursor..Mder ) + ',' + transform( &lcCursor..mizq ) + ',' + transform( &lcCursor..mpie )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..mcab ) + ',' + transform( &lcCursor..Orien ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Mcc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..descrip ) + "'" + ',' + transform( &lcCursor..OrdPor ) + ',' + transform( &lcCursor..TipOrd ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..titulo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Imagen ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Mcco ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..dbDato ) + "'" + ',' + transform( &lcCursor..dstnotip ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..dstnorut ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Mensaje ) + "'" + ',' + Transform( iif( &lcCursor..dbDatoD, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..dstnoarc ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..dstnofh, 1, 0 )) + ',' + Transform( iif( &lcCursor..subtDetall, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + Transform( iif( &lcCursor..DDetalle, 1, 0 )) + ',' + transform( &lcCursor..ColorSombr )
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ORGANIZACION.LTDSPERS ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADOSPERSONALIZADOS'
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
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DETFILTROPER Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DETCAMTROPER Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DETCAMSUBPER Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DETCAMORDPER Where codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DETSALIDASLPER Where codigo] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMFILTROPERSONALIZADO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","codigo","Identifica","idCampo","desde","SLD","hasta","SLH","nOrden","activado","CriteInit","DiasAtras","VNIDesde","VNIHasta","VCIDesde","VCIHasta","VIBooleano","VISiNoBool","SLectura","NoInformar","NoMostrar"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DETFILTROPER ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Identifica ) + "'" + ',' + transform( cDetallesExistentes.idCampo    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.desde      ) + "'" + ',' + Transform( iif( cDetallesExistentes.SLD       , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.hasta      ) + "'" + ',' + Transform( iif( cDetallesExistentes.SLH       , 1, 0 )) + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + Transform( iif( cDetallesExistentes.activado  , 1, 0 )) + ',' + transform( cDetallesExistentes.CriteInit  ) + ',' + transform( cDetallesExistentes.DiasAtras  ) + ',' + transform( cDetallesExistentes.VNIDesde   ) + ',' + transform( cDetallesExistentes.VNIHasta   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.VCIDesde   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.VCIHasta   ) + "'" + ',' + transform( cDetallesExistentes.VIBooleano ) + ',' + transform( cDetallesExistentes.VISiNoBool ) + ',' + Transform( iif( cDetallesExistentes.SLectura  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.NoInformar, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.NoMostrar , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCAMPOPERSONALIZADO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","codigo","Identifica","idCampo","Etiqueta","Longitud","Decimales","Mceros","GrupoV","Expresion","ExpresionN","Calculo","nOrden","activado","LVertical","PCrecer","ORepetido","MImagen","WImagen","HImagen"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DETCAMTROPER ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Identifica ) + "'" + ',' + transform( cDetallesExistentes.idCampo    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Etiqueta   ) + "'" + ',' + transform( cDetallesExistentes.Longitud   ) + ',' + transform( cDetallesExistentes.Decimales  ) + ',' + transform( cDetallesExistentes.Mceros     ) + ',' + transform( cDetallesExistentes.GrupoV     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Expresion  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ExpresionN ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Calculo    ) + "'" + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + Transform( iif( cDetallesExistentes.activado  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.LVertical , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PCrecer   , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ORepetido , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.MImagen   , 1, 0 )) + ',' + transform( cDetallesExistentes.WImagen    ) + ',' + transform( cDetallesExistentes.HImagen    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCAMPOSUBTOTAL'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","codigo","Identifica","idCampo","lpagenew","nOrden","activado","nSubtotal","Formula","Ancho","EtiqF"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DETCAMSUBPER ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Identifica ) + "'" + ',' + transform( cDetallesExistentes.idCampo    ) + ',' + Transform( iif( cDetallesExistentes.lpagenew  , 1, 0 )) + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + Transform( iif( cDetallesExistentes.activado  , 1, 0 )) + ',' + transform( cDetallesExistentes.nSubtotal  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Formula    ) + "'" + ',' + transform( cDetallesExistentes.Ancho      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.EtiqF      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCAMPOORDENAMIENTO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","codigo","Identifica","idCampo","nOrden","activado","Sentido"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DETCAMORDPER ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Identifica ) + "'" + ',' + transform( cDetallesExistentes.idCampo    ) + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + Transform( iif( cDetallesExistentes.activado  , 1, 0 )) + ',' + transform( cDetallesExistentes.Sentido    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMFORMATOSALIDA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where codigo in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","codigo","tipo","Extendido","activado"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DETSALIDASLPER ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.tipo       ) + "'" + ',' + Transform( iif( cDetallesExistentes.Extendido , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.activado  , 1, 0 )) + ' )'  )
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
		lcRetorno = lcRetorno + ' - Nro Interno: ' + transform( &tcCursor..cCod       )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'LISTADOSPERSONALIZADOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LISTADOSPERSONALIZADOS_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'LISTADOSPERSONALIZADOS_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMFILTROPERSONALIZADO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCAMPOPERSONALIZADO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCAMPOSUBTOTAL'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCAMPOORDENAMIENTO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMFORMATOSALIDA'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_LTDSPERS')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'LISTADOSPERSONALIZADOS'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad LISTADOSPERSONALIZADOS. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADOSPERSONALIZADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADOSPERSONALIZADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_LTDSPERS') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_LTDSPERS
Create Table ORGANIZACION.TablaTrabajo_LTDSPERS ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"anulado" bit  null, 
"bloqreg" bit  null, 
"colsubrecp" bit  null, 
"repecabgru" bit  null, 
"colgrupocp" bit  null, 
"pagsimple" bit  null, 
"mantgruni" bit  null, 
"encreporte" bit  null, 
"transpag" bit  null, 
"encpagina" bit  null, 
"fechaimpre" bit  null, 
"infcorrida" bit  null, 
"resumenrep" bit  null, 
"encdetalle" bit  null, 
"horaimpre" bit  null, 
"infocontex" bit  null, 
"ccod" char( 38 )  null, 
"mpara" char( 250 )  null, 
"clistado" char( 60 )  null, 
"esdefault" bit  null, 
"cestilo" char( 10 )  null, 
"identifica" char( 200 )  null, 
"masunto" char( 250 )  null, 
"mder" numeric( 3, 0 )  null, 
"mizq" numeric( 3, 0 )  null, 
"mpie" numeric( 3, 0 )  null, 
"mcab" numeric( 3, 0 )  null, 
"orien" numeric( 1, 0 )  null, 
"mcc" char( 250 )  null, 
"descrip" char( 250 )  null, 
"ordpor" numeric( 12, 0 )  null, 
"tipord" numeric( 1, 0 )  null, 
"titulo" char( 250 )  null, 
"imagen" char( 250 )  null, 
"mcco" char( 250 )  null, 
"dbdato" char( 40 )  null, 
"dstnotip" numeric( 3, 0 )  null, 
"dstnorut" char( 250 )  null, 
"mensaje" char( 250 )  null, 
"dbdatod" bit  null, 
"dstnoarc" char( 250 )  null, 
"dstnofh" bit  null, 
"subtdetall" bit  null, 
"obs" varchar(max)  null, 
"ddetalle" bit  null, 
"colorsombr" numeric( 9, 0 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_LTDSPERS' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_LTDSPERS' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'LISTADOSPERSONALIZADOS'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('colsubrecp','colsubrecp')
			.AgregarMapeo('repecabgru','repecabgru')
			.AgregarMapeo('colgrupocp','colgrupocp')
			.AgregarMapeo('pagsimple','pagsimple')
			.AgregarMapeo('mantgruni','mantgruni')
			.AgregarMapeo('encreporte','encreporte')
			.AgregarMapeo('transpag','transpag')
			.AgregarMapeo('encpagina','encpagina')
			.AgregarMapeo('fechaimpre','fechaimpre')
			.AgregarMapeo('infcorrida','infcorrida')
			.AgregarMapeo('resumenrep','resumenrep')
			.AgregarMapeo('encdetalle','encdetalle')
			.AgregarMapeo('horaimpre','horaimpre')
			.AgregarMapeo('infocontex','infocontex')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('mpara','mpara')
			.AgregarMapeo('clistado','clistado')
			.AgregarMapeo('esdefault','esdefault')
			.AgregarMapeo('cestilo','cestilo')
			.AgregarMapeo('identifica','identifica')
			.AgregarMapeo('masunto','masunto')
			.AgregarMapeo('mder','mder')
			.AgregarMapeo('mizq','mizq')
			.AgregarMapeo('mpie','mpie')
			.AgregarMapeo('mcab','mcab')
			.AgregarMapeo('orien','orien')
			.AgregarMapeo('mcc','mcc')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('ordpor','ordpor')
			.AgregarMapeo('tipord','tipord')
			.AgregarMapeo('titulo','titulo')
			.AgregarMapeo('imagen','imagen')
			.AgregarMapeo('mcco','mcco')
			.AgregarMapeo('dbdato','dbdato')
			.AgregarMapeo('dstnotip','dstnotip')
			.AgregarMapeo('dstnorut','dstnorut')
			.AgregarMapeo('mensaje','mensaje')
			.AgregarMapeo('dbdatod','dbdatod')
			.AgregarMapeo('dstnoarc','dstnoarc')
			.AgregarMapeo('dstnofh','dstnofh')
			.AgregarMapeo('subtdetall','subtdetall')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('ddetalle','ddetalle')
			.AgregarMapeo('colorsombr','colorsombr')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_LTDSPERS'
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
			CREATE TRIGGER ORGANIZACION.DELETE_<<lcTabla>>
				ON ORGANIZACION.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.COLSUBRECP = isnull( d.COLSUBRECP, t.COLSUBRECP ),t.REPECABGRU = isnull( d.REPECABGRU, t.REPECABGRU ),t.COLGRUPOCP = isnull( d.COLGRUPOCP, t.COLGRUPOCP ),t.PAGSIMPLE = isnull( d.PAGSIMPLE, t.PAGSIMPLE ),t.MANTGRUNI = isnull( d.MANTGRUNI, t.MANTGRUNI ),t.ENCREPORTE = isnull( d.ENCREPORTE, t.ENCREPORTE ),t.TRANSPAG = isnull( d.TRANSPAG, t.TRANSPAG ),t.ENCPAGINA = isnull( d.ENCPAGINA, t.ENCPAGINA ),t.FECHAIMPRE = isnull( d.FECHAIMPRE, t.FECHAIMPRE ),t.INFCORRIDA = isnull( d.INFCORRIDA, t.INFCORRIDA ),t.RESUMENREP = isnull( d.RESUMENREP, t.RESUMENREP ),t.ENCDETALLE = isnull( d.ENCDETALLE, t.ENCDETALLE ),t.HORAIMPRE = isnull( d.HORAIMPRE, t.HORAIMPRE ),t.INFOCONTEX = isnull( d.INFOCONTEX, t.INFOCONTEX ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.MPARA = isnull( d.MPARA, t.MPARA ),t.CLISTADO = isnull( d.CLISTADO, t.CLISTADO ),t.ESDEFAULT = isnull( d.ESDEFAULT, t.ESDEFAULT ),t.CESTILO = isnull( d.CESTILO, t.CESTILO ),t.IDENTIFICA = isnull( d.IDENTIFICA, t.IDENTIFICA ),t.MASUNTO = isnull( d.MASUNTO, t.MASUNTO ),t.MDER = isnull( d.MDER, t.MDER ),t.MIZQ = isnull( d.MIZQ, t.MIZQ ),t.MPIE = isnull( d.MPIE, t.MPIE ),t.MCAB = isnull( d.MCAB, t.MCAB ),t.ORIEN = isnull( d.ORIEN, t.ORIEN ),t.MCC = isnull( d.MCC, t.MCC ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.ORDPOR = isnull( d.ORDPOR, t.ORDPOR ),t.TIPORD = isnull( d.TIPORD, t.TIPORD ),t.TITULO = isnull( d.TITULO, t.TITULO ),t.IMAGEN = isnull( d.IMAGEN, t.IMAGEN ),t.MCCO = isnull( d.MCCO, t.MCCO ),t.DBDATO = isnull( d.DBDATO, t.DBDATO ),t.DSTNOTIP = isnull( d.DSTNOTIP, t.DSTNOTIP ),t.DSTNORUT = isnull( d.DSTNORUT, t.DSTNORUT ),t.MENSAJE = isnull( d.MENSAJE, t.MENSAJE ),t.DBDATOD = isnull( d.DBDATOD, t.DBDATOD ),t.DSTNOARC = isnull( d.DSTNOARC, t.DSTNOARC ),t.DSTNOFH = isnull( d.DSTNOFH, t.DSTNOFH ),t.SUBTDETALL = isnull( d.SUBTDETALL, t.SUBTDETALL ),t.OBS = isnull( d.OBS, t.OBS ),t.DDETALLE = isnull( d.DDETALLE, t.DDETALLE ),t.COLORSOMBR = isnull( d.COLORSOMBR, t.COLORSOMBR )
					from ORGANIZACION.LTDSPERS t inner join deleted d 
							 on t.cCod = d.cCod
				-- Fin Updates
				insert into ORGANIZACION.LTDSPERS(Fecexpo,Fectrans,Fecimpo,Faltafw,Fmodifw,Horaexpo,Haltafw,Bdaltafw,Esttrans,Bdmodifw,Horaimpo,Umodifw,Valtafw,Vmodifw,Zadsfw,Smodifw,Ualtafw,Saltafw,Hmodifw,Anulado,Bloqreg,Colsubrecp,Repecabgru,Colgrupocp,Pagsimple,Mantgruni,Encreporte,Transpag,Encpagina,Fechaimpre,Infcorrida,Resumenrep,Encdetalle,Horaimpre,Infocontex,Ccod,Mpara,Clistado,Esdefault,Cestilo,Identifica,Masunto,Mder,Mizq,Mpie,Mcab,Orien,Mcc,Descrip,Ordpor,Tipord,Titulo,Imagen,Mcco,Dbdato,Dstnotip,Dstnorut,Mensaje,Dbdatod,Dstnoarc,Dstnofh,Subtdetall,Obs,Ddetalle,Colorsombr)
					Select isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ANULADO,0),isnull( d.BLOQREG,0),isnull( d.COLSUBRECP,0),isnull( d.REPECABGRU,0),isnull( d.COLGRUPOCP,0),isnull( d.PAGSIMPLE,0),isnull( d.MANTGRUNI,0),isnull( d.ENCREPORTE,0),isnull( d.TRANSPAG,0),isnull( d.ENCPAGINA,0),isnull( d.FECHAIMPRE,0),isnull( d.INFCORRIDA,0),isnull( d.RESUMENREP,0),isnull( d.ENCDETALLE,0),isnull( d.HORAIMPRE,0),isnull( d.INFOCONTEX,0),isnull( d.CCOD,''),isnull( d.MPARA,''),isnull( d.CLISTADO,''),isnull( d.ESDEFAULT,0),isnull( d.CESTILO,''),isnull( d.IDENTIFICA,''),isnull( d.MASUNTO,''),isnull( d.MDER,0),isnull( d.MIZQ,0),isnull( d.MPIE,0),isnull( d.MCAB,0),isnull( d.ORIEN,0),isnull( d.MCC,''),isnull( d.DESCRIP,''),isnull( d.ORDPOR,0),isnull( d.TIPORD,0),isnull( d.TITULO,''),isnull( d.IMAGEN,''),isnull( d.MCCO,''),isnull( d.DBDATO,''),isnull( d.DSTNOTIP,0),isnull( d.DSTNORUT,''),isnull( d.MENSAJE,''),isnull( d.DBDATOD,0),isnull( d.DSTNOARC,''),isnull( d.DSTNOFH,0),isnull( d.SUBTDETALL,0),isnull( d.OBS,''),isnull( d.DDETALLE,0),isnull( d.COLORSOMBR,0)
						From deleted d left join ORGANIZACION.LTDSPERS pk 
							 on d.cCod = pk.cCod
						Where pk.cCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETFILTROPER( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_LTDSPERS_DETFILTROPER
ON ORGANIZACION.TablaTrabajo_LTDSPERS_DETFILTROPER
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IDENTIFICA = isnull( d.IDENTIFICA, t.IDENTIFICA ),
t.IDCAMPO = isnull( d.IDCAMPO, t.IDCAMPO ),
t.DESDE = isnull( d.DESDE, t.DESDE ),
t.SLD = isnull( d.SLD, t.SLD ),
t.HASTA = isnull( d.HASTA, t.HASTA ),
t.SLH = isnull( d.SLH, t.SLH ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.ACTIVADO = isnull( d.ACTIVADO, t.ACTIVADO ),
t.CRITEINIT = isnull( d.CRITEINIT, t.CRITEINIT ),
t.DIASATRAS = isnull( d.DIASATRAS, t.DIASATRAS ),
t.VNIDESDE = isnull( d.VNIDESDE, t.VNIDESDE ),
t.VNIHASTA = isnull( d.VNIHASTA, t.VNIHASTA ),
t.VCIDESDE = isnull( d.VCIDESDE, t.VCIDESDE ),
t.VCIHASTA = isnull( d.VCIHASTA, t.VCIHASTA ),
t.VIBOOLEANO = isnull( d.VIBOOLEANO, t.VIBOOLEANO ),
t.VISINOBOOL = isnull( d.VISINOBOOL, t.VISINOBOOL ),
t.SLECTURA = isnull( d.SLECTURA, t.SLECTURA ),
t.NOINFORMAR = isnull( d.NOINFORMAR, t.NOINFORMAR ),
t.NOMOSTRAR = isnull( d.NOMOSTRAR, t.NOMOSTRAR )
from ORGANIZACION.DETFILTROPER t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DETFILTROPER
( 
"NROITEM",
"BLOQREG",
"CODIGO",
"IDENTIFICA",
"IDCAMPO",
"DESDE",
"SLD",
"HASTA",
"SLH",
"NORDEN",
"ACTIVADO",
"CRITEINIT",
"DIASATRAS",
"VNIDESDE",
"VNIHASTA",
"VCIDESDE",
"VCIHASTA",
"VIBOOLEANO",
"VISINOBOOL",
"SLECTURA",
"NOINFORMAR",
"NOMOSTRAR"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODIGO,
d.IDENTIFICA,
d.IDCAMPO,
d.DESDE,
d.SLD,
d.HASTA,
d.SLH,
d.NORDEN,
d.ACTIVADO,
d.CRITEINIT,
d.DIASATRAS,
d.VNIDESDE,
d.VNIHASTA,
d.VCIDESDE,
d.VCIHASTA,
d.VIBOOLEANO,
d.VISINOBOOL,
d.SLECTURA,
d.NOINFORMAR,
d.NOMOSTRAR
From deleted d left join ORGANIZACION.DETFILTROPER pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETCAMTROPER( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_LTDSPERS_DETCAMTROPER
ON ORGANIZACION.TablaTrabajo_LTDSPERS_DETCAMTROPER
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IDENTIFICA = isnull( d.IDENTIFICA, t.IDENTIFICA ),
t.IDCAMPO = isnull( d.IDCAMPO, t.IDCAMPO ),
t.ETIQUETA = isnull( d.ETIQUETA, t.ETIQUETA ),
t.LONGITUD = isnull( d.LONGITUD, t.LONGITUD ),
t.DECIMALES = isnull( d.DECIMALES, t.DECIMALES ),
t.MCEROS = isnull( d.MCEROS, t.MCEROS ),
t.GRUPOV = isnull( d.GRUPOV, t.GRUPOV ),
t.EXPRESION = isnull( d.EXPRESION, t.EXPRESION ),
t.EXPRESIONN = isnull( d.EXPRESIONN, t.EXPRESIONN ),
t.CALCULO = isnull( d.CALCULO, t.CALCULO ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.ACTIVADO = isnull( d.ACTIVADO, t.ACTIVADO ),
t.LVERTICAL = isnull( d.LVERTICAL, t.LVERTICAL ),
t.PCRECER = isnull( d.PCRECER, t.PCRECER ),
t.OREPETIDO = isnull( d.OREPETIDO, t.OREPETIDO ),
t.MIMAGEN = isnull( d.MIMAGEN, t.MIMAGEN ),
t.WIMAGEN = isnull( d.WIMAGEN, t.WIMAGEN ),
t.HIMAGEN = isnull( d.HIMAGEN, t.HIMAGEN )
from ORGANIZACION.DETCAMTROPER t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DETCAMTROPER
( 
"NROITEM",
"BLOQREG",
"CODIGO",
"IDENTIFICA",
"IDCAMPO",
"ETIQUETA",
"LONGITUD",
"DECIMALES",
"MCEROS",
"GRUPOV",
"EXPRESION",
"EXPRESIONN",
"CALCULO",
"NORDEN",
"ACTIVADO",
"LVERTICAL",
"PCRECER",
"OREPETIDO",
"MIMAGEN",
"WIMAGEN",
"HIMAGEN"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODIGO,
d.IDENTIFICA,
d.IDCAMPO,
d.ETIQUETA,
d.LONGITUD,
d.DECIMALES,
d.MCEROS,
d.GRUPOV,
d.EXPRESION,
d.EXPRESIONN,
d.CALCULO,
d.NORDEN,
d.ACTIVADO,
d.LVERTICAL,
d.PCRECER,
d.OREPETIDO,
d.MIMAGEN,
d.WIMAGEN,
d.HIMAGEN
From deleted d left join ORGANIZACION.DETCAMTROPER pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETCAMSUBPER( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_LTDSPERS_DETCAMSUBPER
ON ORGANIZACION.TablaTrabajo_LTDSPERS_DETCAMSUBPER
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IDENTIFICA = isnull( d.IDENTIFICA, t.IDENTIFICA ),
t.IDCAMPO = isnull( d.IDCAMPO, t.IDCAMPO ),
t.LPAGENEW = isnull( d.LPAGENEW, t.LPAGENEW ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.ACTIVADO = isnull( d.ACTIVADO, t.ACTIVADO ),
t.NSUBTOTAL = isnull( d.NSUBTOTAL, t.NSUBTOTAL ),
t.FORMULA = isnull( d.FORMULA, t.FORMULA ),
t.ANCHO = isnull( d.ANCHO, t.ANCHO ),
t.ETIQF = isnull( d.ETIQF, t.ETIQF )
from ORGANIZACION.DETCAMSUBPER t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DETCAMSUBPER
( 
"NROITEM",
"BLOQREG",
"CODIGO",
"IDENTIFICA",
"IDCAMPO",
"LPAGENEW",
"NORDEN",
"ACTIVADO",
"NSUBTOTAL",
"FORMULA",
"ANCHO",
"ETIQF"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODIGO,
d.IDENTIFICA,
d.IDCAMPO,
d.LPAGENEW,
d.NORDEN,
d.ACTIVADO,
d.NSUBTOTAL,
d.FORMULA,
d.ANCHO,
d.ETIQF
From deleted d left join ORGANIZACION.DETCAMSUBPER pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETCAMORDPER( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_LTDSPERS_DETCAMORDPER
ON ORGANIZACION.TablaTrabajo_LTDSPERS_DETCAMORDPER
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.IDENTIFICA = isnull( d.IDENTIFICA, t.IDENTIFICA ),
t.IDCAMPO = isnull( d.IDCAMPO, t.IDCAMPO ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.ACTIVADO = isnull( d.ACTIVADO, t.ACTIVADO ),
t.SENTIDO = isnull( d.SENTIDO, t.SENTIDO )
from ORGANIZACION.DETCAMORDPER t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DETCAMORDPER
( 
"NROITEM",
"BLOQREG",
"CODIGO",
"IDENTIFICA",
"IDCAMPO",
"NORDEN",
"ACTIVADO",
"SENTIDO"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODIGO,
d.IDENTIFICA,
d.IDCAMPO,
d.NORDEN,
d.ACTIVADO,
d.SENTIDO
From deleted d left join ORGANIZACION.DETCAMORDPER pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DETSALIDASLPER( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_LTDSPERS_DETSALIDASLPER
ON ORGANIZACION.TablaTrabajo_LTDSPERS_DETSALIDASLPER
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.EXTENDIDO = isnull( d.EXTENDIDO, t.EXTENDIDO ),
t.ACTIVADO = isnull( d.ACTIVADO, t.ACTIVADO )
from ORGANIZACION.DETSALIDASLPER t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DETSALIDASLPER
( 
"NROITEM",
"BLOQREG",
"CODIGO",
"TIPO",
"EXTENDIDO",
"ACTIVADO"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.CODIGO,
d.TIPO,
d.EXTENDIDO,
d.ACTIVADO
From deleted d left join ORGANIZACION.DETSALIDASLPER pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_LTDSPERS') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_LTDSPERS
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_LISTADOSPERSONALIZADOS' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADOSPERSONALIZADOS.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADOSPERSONALIZADOS.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADOSPERSONALIZADOS.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADOSPERSONALIZADOS.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_LISTADOSPERSONALIZADOS.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Horaexpo = nvl( c_LISTADOSPERSONALIZADOS.Horaexpo, [] )
					.Horaaltafw = nvl( c_LISTADOSPERSONALIZADOS.Horaaltafw, [] )
					.Basededatosaltafw = nvl( c_LISTADOSPERSONALIZADOS.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_LISTADOSPERSONALIZADOS.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_LISTADOSPERSONALIZADOS.Basededatosmodificacionfw, [] )
					.Horaimpo = nvl( c_LISTADOSPERSONALIZADOS.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_LISTADOSPERSONALIZADOS.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_LISTADOSPERSONALIZADOS.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_LISTADOSPERSONALIZADOS.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Seriemodificacionfw = nvl( c_LISTADOSPERSONALIZADOS.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_LISTADOSPERSONALIZADOS.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_LISTADOSPERSONALIZADOS.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_LISTADOSPERSONALIZADOS.Horamodificacionfw, [] )
					.Anulado = nvl( c_LISTADOSPERSONALIZADOS.Anulado, .F. )
					.Bloquearregistro = nvl( c_LISTADOSPERSONALIZADOS.Bloquearregistro, .F. )
					.Titulosdecolumnasdesubreporteencp = nvl( c_LISTADOSPERSONALIZADOS.Titulosdecolumnasdesubreporteencp, .F. )
					.Repetircabecerasdegrupos = nvl( c_LISTADOSPERSONALIZADOS.Repetircabecerasdegrupos, .F. )
					.Titulosdecolumnasdegrupoencp = nvl( c_LISTADOSPERSONALIZADOS.Titulosdecolumnasdegrupoencp, .F. )
					.Numeraciondepaginasimple = nvl( c_LISTADOSPERSONALIZADOS.Numeraciondepaginasimple, .F. )
					.Mantenergruposunidos = nvl( c_LISTADOSPERSONALIZADOS.Mantenergruposunidos, .F. )
					.Imprimeencabezadodereporte = nvl( c_LISTADOSPERSONALIZADOS.Imprimeencabezadodereporte, .F. )
					.Usatransporteentrepaginas = nvl( c_LISTADOSPERSONALIZADOS.Usatransporteentrepaginas, .F. )
					.Imprimeencabezadodepagina = nvl( c_LISTADOSPERSONALIZADOS.Imprimeencabezadodepagina, .F. )
					.Imprimefechadeimpresion = nvl( c_LISTADOSPERSONALIZADOS.Imprimefechadeimpresion, .F. )
					.Imprimeinformaciondecorrida = nvl( c_LISTADOSPERSONALIZADOS.Imprimeinformaciondecorrida, .F. )
					.Imprimeresumendereporte = nvl( c_LISTADOSPERSONALIZADOS.Imprimeresumendereporte, .F. )
					.Imprimeencabezadodedetalle = nvl( c_LISTADOSPERSONALIZADOS.Imprimeencabezadodedetalle, .F. )
					.Imprimehoradeimpresion = nvl( c_LISTADOSPERSONALIZADOS.Imprimehoradeimpresion, .F. )
					.Imprimeinformaciondecontexto = nvl( c_LISTADOSPERSONALIZADOS.Imprimeinformaciondecontexto, .F. )
					.Codigo = nvl( c_LISTADOSPERSONALIZADOS.Codigo, [] )
					.Mailpara = nvl( c_LISTADOSPERSONALIZADOS.Mailpara, [] )
					.Clistado = nvl( c_LISTADOSPERSONALIZADOS.Clistado, [] )
					.Filtrosdetalle.Limpiar()
					.Filtrosdetalle.SetearEsNavegacion( .lProcesando )
					.Filtrosdetalle.Cargar()
					.Esdefault = nvl( c_LISTADOSPERSONALIZADOS.Esdefault, .F. )
					.Camposdetalle.Limpiar()
					.Camposdetalle.SetearEsNavegacion( .lProcesando )
					.Camposdetalle.Cargar()
					.Subtotaldetalle.Limpiar()
					.Subtotaldetalle.SetearEsNavegacion( .lProcesando )
					.Subtotaldetalle.Cargar()
					.Estilo_PK =  nvl( c_LISTADOSPERSONALIZADOS.Estilo, [] )
					.Ordenamientosdetalle.Limpiar()
					.Ordenamientosdetalle.SetearEsNavegacion( .lProcesando )
					.Ordenamientosdetalle.Cargar()
					.Identificadorordenamiento = nvl( c_LISTADOSPERSONALIZADOS.Identificadorordenamiento, [] )
					.Mailasunto = nvl( c_LISTADOSPERSONALIZADOS.Mailasunto, [] )
					.Margenderecho = nvl( c_LISTADOSPERSONALIZADOS.Margenderecho, 0 )
					.Salidasdetalle.Limpiar()
					.Salidasdetalle.SetearEsNavegacion( .lProcesando )
					.Salidasdetalle.Cargar()
					.Margenizquierdo = nvl( c_LISTADOSPERSONALIZADOS.Margenizquierdo, 0 )
					.Margenpie = nvl( c_LISTADOSPERSONALIZADOS.Margenpie, 0 )
					.Margencabecera = nvl( c_LISTADOSPERSONALIZADOS.Margencabecera, 0 )
					.Orientacion = nvl( c_LISTADOSPERSONALIZADOS.Orientacion, 0 )
					.Mailconcopia = nvl( c_LISTADOSPERSONALIZADOS.Mailconcopia, [] )
					.Descripcion = nvl( c_LISTADOSPERSONALIZADOS.Descripcion, [] )
					.Ordenadopor = nvl( c_LISTADOSPERSONALIZADOS.Ordenadopor, 0 )
					.Tipoordenamiento = nvl( c_LISTADOSPERSONALIZADOS.Tipoordenamiento, 0 )
					.Titulolistado = nvl( c_LISTADOSPERSONALIZADOS.Titulolistado, [] )
					.Imagenlistado = nvl( c_LISTADOSPERSONALIZADOS.Imagenlistado, [] )
					.Mailconcopiaoculta = nvl( c_LISTADOSPERSONALIZADOS.Mailconcopiaoculta, [] )
					.Basededatos = nvl( c_LISTADOSPERSONALIZADOS.Basededatos, [] )
					.Destinotipo = nvl( c_LISTADOSPERSONALIZADOS.Destinotipo, 0 )
					.Destinoruta = nvl( c_LISTADOSPERSONALIZADOS.Destinoruta, [] )
					.Mailmensaje = nvl( c_LISTADOSPERSONALIZADOS.Mailmensaje, [] )
					.Basededatosdetallada = nvl( c_LISTADOSPERSONALIZADOS.Basededatosdetallada, .F. )
					.Destinoarchivo = nvl( c_LISTADOSPERSONALIZADOS.Destinoarchivo, [] )
					.Destinofechahora = nvl( c_LISTADOSPERSONALIZADOS.Destinofechahora, .F. )
					.Subtotaldetallado = nvl( c_LISTADOSPERSONALIZADOS.Subtotaldetallado, .F. )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Diferenciardetalle = nvl( c_LISTADOSPERSONALIZADOS.Diferenciardetalle, .F. )
					.Colorparaelsombreado = nvl( c_LISTADOSPERSONALIZADOS.Colorparaelsombreado, 0 )
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
		
		loDetalle = this.oEntidad.FiltrosDetalle
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

		loDetalle = this.oEntidad.CamposDetalle
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

		loDetalle = this.oEntidad.SubtotalDetalle
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

		loDetalle = this.oEntidad.OrdenamientosDetalle
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

		loDetalle = this.oEntidad.SalidasDetalle
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
		return c_LISTADOSPERSONALIZADOS.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		local lcNombreBD as String 
		lcNombreBD = ''
		lcNombreBD = this.oConexion.ObtenerNombreBD( 'ZOOLOGICMASTER' )
		lcNombreBD = goLibrerias.EscapeCaracteresSqlServer( lcNombreBD )

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.LTDSPERS' )
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
								from ORGANIZACION.LTDSPERS 
								Where   LTDSPERS.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "LTDSPERS", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Anulado" as "Anulado", "Bloqreg" as "Bloquearregistro", "Colsubrecp" as "Titulosdecolumnasdesubreporteencp", "Repecabgru" as "Repetircabecerasdegrupos", "Colgrupocp" as "Titulosdecolumnasdegrupoencp", "Pagsimple" as "Numeraciondepaginasimple", "Mantgruni" as "Mantenergruposunidos", "Encreporte" as "Imprimeencabezadodereporte", "Transpag" as "Usatransporteentrepaginas", "Encpagina" as "Imprimeencabezadodepagina", "Fechaimpre" as "Imprimefechadeimpresion", "Infcorrida" as "Imprimeinformaciondecorrida", "Resumenrep" as "Imprimeresumendereporte", "Encdetalle" as "Imprimeencabezadodedetalle", "Horaimpre" as "Imprimehoradeimpresion", "Infocontex" as "Imprimeinformaciondecontexto", "Ccod" as "Codigo", "Mpara" as "Mailpara", "Clistado" as "Clistado", "Esdefault" as "Esdefault", "Cestilo" as "Estilo", "Identifica" as "Identificadorordenamiento", "Masunto" as "Mailasunto", "Mder" as "Margenderecho", "Mizq" as "Margenizquierdo", "Mpie" as "Margenpie", "Mcab" as "Margencabecera", "Orien" as "Orientacion", "Mcc" as "Mailconcopia", "Descrip" as "Descripcion", "Ordpor" as "Ordenadopor", "Tipord" as "Tipoordenamiento", "Titulo" as "Titulolistado", "Imagen" as "Imagenlistado", "Mcco" as "Mailconcopiaoculta", "Dbdato" as "Basededatos", "Dstnotip" as "Destinotipo", "Dstnorut" as "Destinoruta", "Mensaje" as "Mailmensaje", "Dbdatod" as "Basededatosdetallada", "Dstnoarc" as "Destinoarchivo", "Dstnofh" as "Destinofechahora", "Subtdetall" as "Subtotaldetallado", "Obs" as "Observacion", "Ddetalle" as "Diferenciardetalle", "Colorsombr" as "Colorparaelsombreado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.LTDSPERS 
								Where   LTDSPERS.CCOD != ''
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
	Tabla = 'LTDSPERS'
	Filtro = " LTDSPERS.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " LTDSPERS.CCOD != ''"
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
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="FECHAEXPO                               " tabla="LTDSPERS       " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="FECHATRANSFERENCIA                      " tabla="LTDSPERS       " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="FECHAIMPO                               " tabla="LTDSPERS       " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="FECHAALTAFW                             " tabla="LTDSPERS       " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="FECHAMODIFICACIONFW                     " tabla="LTDSPERS       " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="HORAEXPO                                " tabla="LTDSPERS       " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="HORAALTAFW                              " tabla="LTDSPERS       " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="BASEDEDATOSALTAFW                       " tabla="LTDSPERS       " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ESTADOTRANSFERENCIA                     " tabla="LTDSPERS       " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="LTDSPERS       " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="HORAIMPO                                " tabla="LTDSPERS       " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="USUARIOMODIFICACIONFW                   " tabla="LTDSPERS       " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="VERSIONALTAFW                           " tabla="LTDSPERS       " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="VERSIONMODIFICACIONFW                   " tabla="LTDSPERS       " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ZADSFW                                  " tabla="LTDSPERS       " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="SERIEMODIFICACIONFW                     " tabla="LTDSPERS       " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="USUARIOALTAFW                           " tabla="LTDSPERS       " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="SERIEALTAFW                             " tabla="LTDSPERS       " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="HORAMODIFICACIONFW                      " tabla="LTDSPERS       " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ANULADO                                 " tabla="LTDSPERS       " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="BLOQUEARREGISTRO                        " tabla="LTDSPERS       " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="TITULOSDECOLUMNASDESUBREPORTEENCP       " tabla="LTDSPERS       " campo="COLSUBRECP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="REPETIRCABECERASDEGRUPOS                " tabla="LTDSPERS       " campo="REPECABGRU" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="TITULOSDECOLUMNASDEGRUPOENCP            " tabla="LTDSPERS       " campo="COLGRUPOCP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="NUMERACIONDEPAGINASIMPLE                " tabla="LTDSPERS       " campo="PAGSIMPLE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MANTENERGRUPOSUNIDOS                    " tabla="LTDSPERS       " campo="MANTGRUNI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEENCABEZADODEREPORTE              " tabla="LTDSPERS       " campo="ENCREPORTE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="USATRANSPORTEENTREPAGINAS               " tabla="LTDSPERS       " campo="TRANSPAG  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEENCABEZADODEPAGINA               " tabla="LTDSPERS       " campo="ENCPAGINA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEFECHADEIMPRESION                 " tabla="LTDSPERS       " campo="FECHAIMPRE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEINFORMACIONDECORRIDA             " tabla="LTDSPERS       " campo="INFCORRIDA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMERESUMENDEREPORTE                 " tabla="LTDSPERS       " campo="RESUMENREP" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEENCABEZADODEDETALLE              " tabla="LTDSPERS       " campo="ENCDETALLE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEHORADEIMPRESION                  " tabla="LTDSPERS       " campo="HORAIMPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMPRIMEINFORMACIONDECONTEXTO            " tabla="LTDSPERS       " campo="INFOCONTEX" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="CODIGO                                  " tabla="LTDSPERS       " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="40" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MAILPARA                                " tabla="LTDSPERS       " campo="MPARA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="20" etiqueta="Para                                                                                                                                                            " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="CLISTADO                                " tabla="LTDSPERS       " campo="CLISTADO  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Listado                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="FILTROSDETALLE                          " tabla="DETFILTROPER   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Filtros                                                                                                                                                         " dominio="DETALLEITEMFILTROPERSONALIZADO" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ESDEFAULT                               " tabla="LTDSPERS       " campo="ESDEFAULT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Default                                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="CAMPOSDETALLE                           " tabla="DETCAMTROPER   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Campos                                                                                                                                                          " dominio="DETALLEITEMCAMPOPERSONALIZADO " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="SUBTOTALDETALLE                         " tabla="DETCAMSUBPER   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Subtotales                                                                                                                                                      " dominio="DETALLEITEMCAMPOSUBTOTAL      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ESTILO                                  " tabla="LTDSPERS       " campo="CESTILO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ESTILOIMPRESION                         " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Estilo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ORDENAMIENTOSDETALLE                    " tabla="DETCAMORDPER   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Ordenamientos                                                                                                                                                   " dominio="DETALLEITEMCAMPOORDENAMIENTO  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IDENTIFICADORORDENAMIENTO               " tabla="LTDSPERS       " campo="IDENTIFICA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Identificador ordenamiento                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MAILASUNTO                              " tabla="LTDSPERS       " campo="MASUNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Asunto                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MARGENDERECHO                           " tabla="LTDSPERS       " campo="MDER      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Margen derecho                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="SALIDASDETALLE                          " tabla="DETSALIDASLPER " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Formatos de salida                                                                                                                                              " dominio="DETALLEITEMFORMATOSALIDA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MARGENIZQUIERDO                         " tabla="LTDSPERS       " campo="MIZQ      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Margen izquierdo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MARGENPIE                               " tabla="LTDSPERS       " campo="MPIE      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Margen pie                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MARGENCABECERA                          " tabla="LTDSPERS       " campo="MCAB      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Margen cabecera                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ORIENTACION                             " tabla="LTDSPERS       " campo="ORIEN     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Orientación                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MAILCONCOPIA                            " tabla="LTDSPERS       " campo="MCC       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="24" etiqueta="Con copia                                                                                                                                                       " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="DESCRIPCION                             " tabla="LTDSPERS       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="ORDENADOPOR                             " tabla="LTDSPERS       " campo="ORDPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Ordena por                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="TIPOORDENAMIENTO                        " tabla="LTDSPERS       " campo="TIPORD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Tipo ordenamiento                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="TITULOLISTADO                           " tabla="LTDSPERS       " campo="TITULO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Título                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="IMAGENLISTADO                           " tabla="LTDSPERS       " campo="IMAGEN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Imagen                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MAILCONCOPIAOCULTA                      " tabla="LTDSPERS       " campo="MCCO      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="28" etiqueta="Con copia oculta                                                                                                                                                " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="BASEDEDATOS                             " tabla="LTDSPERS       " campo="DBDATO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Base de datos                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="DESTINOTIPO                             " tabla="LTDSPERS       " campo="DSTNOTIP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Tipo de destino                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="15" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="DESTINORUTA                             " tabla="LTDSPERS       " campo="DSTNORUT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Destino ruta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="MAILMENSAJE                             " tabla="LTDSPERS       " campo="MENSAJE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="32" etiqueta="Mensaje                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="BASEDEDATOSDETALLADA                    " tabla="LTDSPERS       " campo="DBDATOD   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Base de datos detallada                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="DESTINOARCHIVO                          " tabla="LTDSPERS       " campo="DSTNOARC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Destino archivo                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="DESTINOFECHAHORA                        " tabla="LTDSPERS       " campo="DSTNOFH   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Destino fecha hora                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="22" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="SUBTOTALDETALLADO                       " tabla="LTDSPERS       " campo="SUBTDETALL" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Subtotal detallado                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="OBSERVACION                             " tabla="LTDSPERS       " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="DIFERENCIARDETALLE                      " tabla="LTDSPERS       " campo="DDETALLE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Diferenciar líneas del detalle                                                                                                                                  " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="660" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADOSPERSONALIZADOS                  " atributo="COLORPARAELSOMBREADO                    " tabla="LTDSPERS       " campo="COLORSOMBR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="9" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Color para el sombreado                                                                                                                                         " dominio="COLOR                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="670" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTILOIMPRESION                         " atributo="DESCRIPCION                             " tabla="ESTIMP         " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Est.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ESTIMP On LTDSPERS.CESTILO = ESTIMP.cCod And  ESTIMP.CCOD != ''                                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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