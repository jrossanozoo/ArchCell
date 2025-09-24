
define class Din_EntidadDISENOIMPRESIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DISENOIMPRESION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_IMPPK'
	cTablaPrincipal = 'DISIMP'
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

		with this.oEntidad
			local  lxDisimpFecexpo, lxDisimpFaltafw, lxDisimpFmodifw, lxDisimpFecimpo, lxDisimpFectrans, lxDisimpTimestamp, lxDisimpBloqreg, lxDisimpBdmodifw, lxDisimpEsttrans, lxDisimpVmodifw, lxDisimpZadsfw, lxDisimpBdaltafw, lxDisimpValtafw, lxDisimpHoraexpo, lxDisimpSaltafw, lxDisimpHmodifw, lxDisimpSmodifw, lxDisimpHoraimpo, lxDisimpUmodifw, lxDisimpUaltafw, lxDisimpHaltafw, lxDisimpLconfirma, lxDisimpCobs, lxDisimpNlimite, lxDisimpCentidad, lxDisimpNcantcol, lxDisimpLhabimpre, lxDisimpLhabpdf, lxDisimpNmarsup, lxDisimpCcod, lxDisimpNadvierte, lxDisimpNsegundos, lxDisimpLpdfauto, lxDisimpImpauto, lxDisimpNmarizq, lxDisimpCestilo, lxDisimpCdes, lxDisimpCseries, lxDisimpNconfpdf, lxDisimpNsugiere, lxDisimpNmarinf, lxDisimpCrutapdf, lxDisimpNoptsal, lxDisimpNmarder, lxDisimpNcantcop, lxDisimpCcondici, lxDisimpCpuerto, lxDisimpLdefault
				lxDisimpFecexpo =  .Fechaexpo			lxDisimpFaltafw =  .Fechaaltafw			lxDisimpFmodifw =  .Fechamodificacionfw			lxDisimpFecimpo =  .Fechaimpo			lxDisimpFectrans =  .Fechatransferencia			lxDisimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpBloqreg =  .Bloquearregistro			lxDisimpBdmodifw =  .Basededatosmodificacionfw			lxDisimpEsttrans =  .Estadotransferencia			lxDisimpVmodifw =  .Versionmodificacionfw			lxDisimpZadsfw =  .Zadsfw			lxDisimpBdaltafw =  .Basededatosaltafw			lxDisimpValtafw =  .Versionaltafw			lxDisimpHoraexpo =  .Horaexpo			lxDisimpSaltafw =  .Seriealtafw			lxDisimpHmodifw =  .Horamodificacionfw			lxDisimpSmodifw =  .Seriemodificacionfw			lxDisimpHoraimpo =  .Horaimpo			lxDisimpUmodifw =  .Usuariomodificacionfw			lxDisimpUaltafw =  .Usuarioaltafw			lxDisimpHaltafw =  .Horaaltafw			lxDisimpLconfirma =  .Solicitarconfirmacion			lxDisimpCobs =  .Observacion			lxDisimpNlimite =  .Aplicalimite			lxDisimpCentidad =  .Entidad			lxDisimpNcantcol =  .Columnas			lxDisimpLhabimpre =  .Habilitasalidaaimpresora			lxDisimpLhabpdf =  .Habilitasalidaapdf			lxDisimpNmarsup =  .Margensup			lxDisimpCcod =  .Codigo			lxDisimpNadvierte =  .Advierte			lxDisimpNsegundos =  .Segundos			lxDisimpLpdfauto =  .Pdfautomatico			lxDisimpImpauto =  .Impresionautomatica			lxDisimpNmarizq =  .Margenizq			lxDisimpCestilo =  upper( .Estilo_PK ) 			lxDisimpCdes =  .Descripcion			lxDisimpCseries =  .Series			lxDisimpNconfpdf =  .Confirmapdf			lxDisimpNsugiere =  .Sugiere			lxDisimpNmarinf =  .Margeninf			lxDisimpCrutapdf =  .Rutapdf			lxDisimpNoptsal =  .Opciondesalida			lxDisimpNmarder =  .Margender			lxDisimpNcantcop =  .Cantidadcopias			lxDisimpCcondici =  .Condicion			lxDisimpCpuerto =  .Puerto			lxDisimpLdefault =  .Defaultimpresion
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDisimpCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.DISIMP ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fectrans","Timestamp","Bloqreg","Bdmodifw","Esttrans","Vmodifw","Zadsfw","Bdaltafw","Valtafw","Horaexpo","Saltafw","Hmodifw","Smodifw","Horaimpo","Umodifw","Ualtafw","Haltafw","Lconfirma","Cobs","Nlimite","Centidad","Ncantcol","Lhabimpre","Lhabpdf","Nmarsup","Ccod","Nadvierte","Nsegundos","Lpdfauto","Impauto","Nmarizq","Cestilo","Cdes","Cseries","Nconfpdf","Nsugiere","Nmarinf","Crutapdf","Noptsal","Nmarder","Ncantcop","Ccondici","Cpuerto","Ldefault" ) values ( <<"'" + this.ConvertirDateSql( lxDisimpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFectrans ) + "'" >>, <<lxDisimpTimestamp >>, <<iif( lxDisimpBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHaltafw ) + "'" >>, <<iif( lxDisimpLconfirma, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpCobs ) + "'" >>, <<lxDisimpNlimite >>, <<"'" + this.FormatearTextoSql( lxDisimpCentidad ) + "'" >>, <<lxDisimpNcantcol >>, <<iif( lxDisimpLhabimpre, 1, 0 ) >>, <<iif( lxDisimpLhabpdf, 1, 0 ) >>, <<lxDisimpNmarsup >>, <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'" >>, <<lxDisimpNadvierte >>, <<lxDisimpNsegundos >>, <<iif( lxDisimpLpdfauto, 1, 0 ) >>, <<iif( lxDisimpImpauto, 1, 0 ) >>, <<lxDisimpNmarizq >>, <<"'" + this.FormatearTextoSql( lxDisimpCestilo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpCdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpCseries ) + "'" >>, <<lxDisimpNconfpdf >>, <<lxDisimpNsugiere >>, <<lxDisimpNmarinf >>, <<"'" + this.FormatearTextoSql( lxDisimpCrutapdf ) + "'" >>, <<lxDisimpNoptsal >>, <<lxDisimpNmarder >>, <<lxDisimpNcantcop >>, <<"'" + this.FormatearTextoSql( lxDisimpCcondici ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpCpuerto ) + "'" >>, <<iif( lxDisimpLdefault, 1, 0 ) >> )
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
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxX = loItem.X
					lxY = loItem.Y
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					lxEstilo_PK = loItem.Estilo_PK
					lxEsdet = loItem.Esdet
					lxCondicion = loItem.Condicion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAreas("NROITEM","BLOQREG","iCod","cArea","cTipo","cPosX","cPosY","cAncho","cAlto","cEstilo","cDetalle","cCondicion" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<lxX>>, <<lxY>>, <<lxAncho>>, <<lxAlto>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<iif( lxEsdet, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEnt("NROITEM","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxContenido = loItem.Contenido
					lxY = loItem.Y
					lxX = loItem.X
					lxOrientacion = loItem.Orientacion
					lxAncho = loItem.Ancho
					lxEstilo_PK = loItem.Estilo_PK
					lxMascara = loItem.Mascara
					lxCondicion = loItem.Condicion
					lxFuncionagrupar = loItem.Funcionagrupar
					lxPrioridadordenamiento = loItem.Prioridadordenamiento
					lxTipoordenamiento = loItem.Tipoordenamiento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAtributos("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipoDesc","cContenido","cPosY","cPosX","norientaci","cAncho","cEstilo","cMascara","cCondicion","FAgrupar","npriordena","ntipordena" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxContenido ) + "'">>, <<lxY>>, <<lxX>>, <<lxOrientacion>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMascara ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">>, <<lxFuncionagrupar>>, <<lxPrioridadordenamiento>>, <<lxTipoordenamiento>> ) 
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
		this.oEntidad.Timestamp = lxDisimpTimestamp
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
			this.GenerarSentenciasComponentes()
			local  lxDisimpFecexpo, lxDisimpFaltafw, lxDisimpFmodifw, lxDisimpFecimpo, lxDisimpFectrans, lxDisimpTimestamp, lxDisimpBloqreg, lxDisimpBdmodifw, lxDisimpEsttrans, lxDisimpVmodifw, lxDisimpZadsfw, lxDisimpBdaltafw, lxDisimpValtafw, lxDisimpHoraexpo, lxDisimpSaltafw, lxDisimpHmodifw, lxDisimpSmodifw, lxDisimpHoraimpo, lxDisimpUmodifw, lxDisimpUaltafw, lxDisimpHaltafw, lxDisimpLconfirma, lxDisimpCobs, lxDisimpNlimite, lxDisimpCentidad, lxDisimpNcantcol, lxDisimpLhabimpre, lxDisimpLhabpdf, lxDisimpNmarsup, lxDisimpCcod, lxDisimpNadvierte, lxDisimpNsegundos, lxDisimpLpdfauto, lxDisimpImpauto, lxDisimpNmarizq, lxDisimpCestilo, lxDisimpCdes, lxDisimpCseries, lxDisimpNconfpdf, lxDisimpNsugiere, lxDisimpNmarinf, lxDisimpCrutapdf, lxDisimpNoptsal, lxDisimpNmarder, lxDisimpNcantcop, lxDisimpCcondici, lxDisimpCpuerto, lxDisimpLdefault
				lxDisimpFecexpo =  .Fechaexpo			lxDisimpFaltafw =  .Fechaaltafw			lxDisimpFmodifw =  .Fechamodificacionfw			lxDisimpFecimpo =  .Fechaimpo			lxDisimpFectrans =  .Fechatransferencia			lxDisimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpBloqreg =  .Bloquearregistro			lxDisimpBdmodifw =  .Basededatosmodificacionfw			lxDisimpEsttrans =  .Estadotransferencia			lxDisimpVmodifw =  .Versionmodificacionfw			lxDisimpZadsfw =  .Zadsfw			lxDisimpBdaltafw =  .Basededatosaltafw			lxDisimpValtafw =  .Versionaltafw			lxDisimpHoraexpo =  .Horaexpo			lxDisimpSaltafw =  .Seriealtafw			lxDisimpHmodifw =  .Horamodificacionfw			lxDisimpSmodifw =  .Seriemodificacionfw			lxDisimpHoraimpo =  .Horaimpo			lxDisimpUmodifw =  .Usuariomodificacionfw			lxDisimpUaltafw =  .Usuarioaltafw			lxDisimpHaltafw =  .Horaaltafw			lxDisimpLconfirma =  .Solicitarconfirmacion			lxDisimpCobs =  .Observacion			lxDisimpNlimite =  .Aplicalimite			lxDisimpCentidad =  .Entidad			lxDisimpNcantcol =  .Columnas			lxDisimpLhabimpre =  .Habilitasalidaaimpresora			lxDisimpLhabpdf =  .Habilitasalidaapdf			lxDisimpNmarsup =  .Margensup			lxDisimpCcod =  .Codigo			lxDisimpNadvierte =  .Advierte			lxDisimpNsegundos =  .Segundos			lxDisimpLpdfauto =  .Pdfautomatico			lxDisimpImpauto =  .Impresionautomatica			lxDisimpNmarizq =  .Margenizq			lxDisimpCestilo =  upper( .Estilo_PK ) 			lxDisimpCdes =  .Descripcion			lxDisimpCseries =  .Series			lxDisimpNconfpdf =  .Confirmapdf			lxDisimpNsugiere =  .Sugiere			lxDisimpNmarinf =  .Margeninf			lxDisimpCrutapdf =  .Rutapdf			lxDisimpNoptsal =  .Opciondesalida			lxDisimpNmarder =  .Margender			lxDisimpNcantcop =  .Cantidadcopias			lxDisimpCcondici =  .Condicion			lxDisimpCpuerto =  .Puerto			lxDisimpLdefault =  .Defaultimpresion
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
				update ZooLogic.DISIMP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDisimpFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDisimpFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxDisimpFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDisimpFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDisimpFectrans ) + "'">>,"Timestamp" = <<lxDisimpTimestamp>>,"Bloqreg" = <<iif( lxDisimpBloqreg, 1, 0 )>>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDisimpEsttrans ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDisimpZadsfw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDisimpBdaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDisimpValtafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDisimpHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDisimpSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDisimpSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDisimpHoraimpo ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDisimpUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDisimpUaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDisimpHaltafw ) + "'">>,"Lconfirma" = <<iif( lxDisimpLconfirma, 1, 0 )>>,"Cobs" = <<"'" + this.FormatearTextoSql( lxDisimpCobs ) + "'">>,"Nlimite" = <<lxDisimpNlimite>>,"Centidad" = <<"'" + this.FormatearTextoSql( lxDisimpCentidad ) + "'">>,"Ncantcol" = <<lxDisimpNcantcol>>,"Lhabimpre" = <<iif( lxDisimpLhabimpre, 1, 0 )>>,"Lhabpdf" = <<iif( lxDisimpLhabpdf, 1, 0 )>>,"Nmarsup" = <<lxDisimpNmarsup>>,"Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'">>,"Nadvierte" = <<lxDisimpNadvierte>>,"Nsegundos" = <<lxDisimpNsegundos>>,"Lpdfauto" = <<iif( lxDisimpLpdfauto, 1, 0 )>>,"Impauto" = <<iif( lxDisimpImpauto, 1, 0 )>>,"Nmarizq" = <<lxDisimpNmarizq>>,"Cestilo" = <<"'" + this.FormatearTextoSql( lxDisimpCestilo ) + "'">>,"Cdes" = <<"'" + this.FormatearTextoSql( lxDisimpCdes ) + "'">>,"Cseries" = <<"'" + this.FormatearTextoSql( lxDisimpCseries ) + "'">>,"Nconfpdf" = <<lxDisimpNconfpdf>>,"Nsugiere" = <<lxDisimpNsugiere>>,"Nmarinf" = <<lxDisimpNmarinf>>,"Crutapdf" = <<"'" + this.FormatearTextoSql( lxDisimpCrutapdf ) + "'">>,"Noptsal" = <<lxDisimpNoptsal>>,"Nmarder" = <<lxDisimpNmarder>>,"Ncantcop" = <<lxDisimpNcantcop>>,"Ccondici" = <<"'" + this.FormatearTextoSql( lxDisimpCcondici ) + "'">>,"Cpuerto" = <<"'" + this.FormatearTextoSql( lxDisimpCpuerto ) + "'">>,"Ldefault" = <<iif( lxDisimpLdefault, 1, 0 )>> where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'">> and  DISIMP.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisAreas where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisEnt where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisAtributos where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxX = loItem.X
					lxY = loItem.Y
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					lxEstilo_PK = loItem.Estilo_PK
					lxEsdet = loItem.Esdet
					lxCondicion = loItem.Condicion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAreas("NROITEM","BLOQREG","iCod","cArea","cTipo","cPosX","cPosY","cAncho","cAlto","cEstilo","cDetalle","cCondicion" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<lxX>>, <<lxY>>, <<lxAncho>>, <<lxAlto>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<iif( lxEsdet, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEnt("NROITEM","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxContenido = loItem.Contenido
					lxY = loItem.Y
					lxX = loItem.X
					lxOrientacion = loItem.Orientacion
					lxAncho = loItem.Ancho
					lxEstilo_PK = loItem.Estilo_PK
					lxMascara = loItem.Mascara
					lxCondicion = loItem.Condicion
					lxFuncionagrupar = loItem.Funcionagrupar
					lxPrioridadordenamiento = loItem.Prioridadordenamiento
					lxTipoordenamiento = loItem.Tipoordenamiento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAtributos("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipoDesc","cContenido","cPosY","cPosX","norientaci","cAncho","cEstilo","cMascara","cCondicion","FAgrupar","npriordena","ntipordena" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxContenido ) + "'">>, <<lxY>>, <<lxX>>, <<lxOrientacion>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMascara ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">>, <<lxFuncionagrupar>>, <<lxPrioridadordenamiento>>, <<lxTipoordenamiento>> ) 
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
		this.oEntidad.Timestamp = lxDisimpTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ZooLogic.DISIMP where " + this.ConvertirFuncionesSql( " DISIMP.CCOD != ''" ) )
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
			Local lxDisimpCcod
			lxDisimpCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion" from ZooLogic.DISIMP where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'">> and  DISIMP.CCOD != ''
			endtext
			use in select('c_DISENOIMPRESION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPRESION', set( 'Datasession' ) )

			if reccount( 'c_DISENOIMPRESION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Cposx" as "X", "Cposy" as "Y", "Cancho" as "Ancho", "Calto" as "Alto", "Cestilo" as "Estilo", "Cdetalle" as "Esdet", "Ccondicion" as "Condicion" from ZooLogic.DisAreas where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by y,x
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipodesc" as "Tipodetalle", "Ccontenido" as "Contenido", "Cposy" as "Y", "Cposx" as "X", "Norientaci" as "Orientacion", "Cancho" as "Ancho", "Cestilo" as "Estilo", "Cmascara" as "Mascara", "Ccondicion" as "Condicion", "Fagrupar" as "Funcionagrupar", "Npriordena" as "Prioridadordenamiento", "Ntipordena" as "Tipoordenamiento" from ZooLogic.DisAtributos where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxDisimpCcod as Variant
		llRetorno = .t.
		lxDisimpCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.DISIMP where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'">> and  DISIMP.CCOD != ''
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
				lcOrden =  .Descripcion + .Entidad + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion" from ZooLogic.DISIMP where  DISIMP.CCOD != '' order by cDes,cEntidad,cCod
			endtext
			use in select('c_DISENOIMPRESION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPRESION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Cposx" as "X", "Cposy" as "Y", "Cancho" as "Ancho", "Calto" as "Alto", "Cestilo" as "Estilo", "Cdetalle" as "Esdet", "Ccondicion" as "Condicion" from ZooLogic.DisAreas where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by y,x
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipodesc" as "Tipodetalle", "Ccontenido" as "Contenido", "Cposy" as "Y", "Cposx" as "X", "Norientaci" as "Orientacion", "Cancho" as "Ancho", "Cestilo" as "Estilo", "Cmascara" as "Mascara", "Ccondicion" as "Condicion", "Fagrupar" as "Funcionagrupar", "Npriordena" as "Prioridadordenamiento", "Ntipordena" as "Tipoordenamiento" from ZooLogic.DisAtributos where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
				lcOrden =  .Descripcion + .Entidad + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion" from ZooLogic.DISIMP where  funciones.padr( cDes, 100, ' ' ) + funciones.padr( cEntidad, 40, ' ' ) + funciones.padr( cCod, 40, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISIMP.CCOD != '' order by cDes,cEntidad,cCod
			endtext
			use in select('c_DISENOIMPRESION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPRESION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Cposx" as "X", "Cposy" as "Y", "Cancho" as "Ancho", "Calto" as "Alto", "Cestilo" as "Estilo", "Cdetalle" as "Esdet", "Ccondicion" as "Condicion" from ZooLogic.DisAreas where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by y,x
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipodesc" as "Tipodetalle", "Ccontenido" as "Contenido", "Cposy" as "Y", "Cposx" as "X", "Norientaci" as "Orientacion", "Cancho" as "Ancho", "Cestilo" as "Estilo", "Cmascara" as "Mascara", "Ccondicion" as "Condicion", "Fagrupar" as "Funcionagrupar", "Npriordena" as "Prioridadordenamiento", "Ntipordena" as "Tipoordenamiento" from ZooLogic.DisAtributos where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
				lcOrden =  .Descripcion + .Entidad + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion" from ZooLogic.DISIMP where  funciones.padr( cDes, 100, ' ' ) + funciones.padr( cEntidad, 40, ' ' ) + funciones.padr( cCod, 40, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISIMP.CCOD != '' order by cDes desc,cEntidad desc,cCod desc
			endtext
			use in select('c_DISENOIMPRESION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPRESION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Cposx" as "X", "Cposy" as "Y", "Cancho" as "Ancho", "Calto" as "Alto", "Cestilo" as "Estilo", "Cdetalle" as "Esdet", "Ccondicion" as "Condicion" from ZooLogic.DisAreas where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by y,x
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipodesc" as "Tipodetalle", "Ccontenido" as "Contenido", "Cposy" as "Y", "Cposx" as "X", "Norientaci" as "Orientacion", "Cancho" as "Ancho", "Cestilo" as "Estilo", "Cmascara" as "Mascara", "Ccondicion" as "Condicion", "Fagrupar" as "Funcionagrupar", "Npriordena" as "Prioridadordenamiento", "Ntipordena" as "Tipoordenamiento" from ZooLogic.DisAtributos where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
				lcOrden =  .Descripcion + .Entidad + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion" from ZooLogic.DISIMP where  DISIMP.CCOD != '' order by cDes desc,cEntidad desc,cCod desc
			endtext
			use in select('c_DISENOIMPRESION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPRESION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Cposx" as "X", "Cposy" as "Y", "Cancho" as "Ancho", "Calto" as "Alto", "Cestilo" as "Estilo", "Cdetalle" as "Esdet", "Ccondicion" as "Condicion" from ZooLogic.DisAreas where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by y,x
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad" from ZooLogic.DisEnt where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Entidades')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Entidades', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Entidades
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipodesc" as "Tipodetalle", "Ccontenido" as "Contenido", "Cposy" as "Y", "Cposx" as "X", "Norientaci" as "Orientacion", "Cancho" as "Ancho", "Cestilo" as "Estilo", "Cmascara" as "Mascara", "Ccondicion" as "Condicion", "Fagrupar" as "Funcionagrupar", "Npriordena" as "Prioridadordenamiento", "Ntipordena" as "Tipoordenamiento" from ZooLogic.DisAtributos where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPRESION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fmodifw,Fecimpo,Fectrans,Timestamp,Bloqreg,Bdmodifw,Esttrans,Vmodifw,Zadsfw," + ;
"Bdaltafw,Valtafw,Horaexpo,Saltafw,Hmodifw,Smodifw,Horaimpo,Umodifw,Ualtafw,Haltafw,Lconfirma,Cobs,Nl" + ;
"imite,Centidad,Ncantcol,Lhabimpre,Lhabpdf,Nmarsup,Ccod,Nadvierte,Nsegundos,Lpdfauto,Impauto,Nmarizq," + ;
"Cestilo,Cdes,Cseries,Nconfpdf,Nsugiere,Nmarinf,Crutapdf,Noptsal,Nmarder,Ncantcop,Ccondici,Cpuerto,Ld" + ;
"efault" + ;
" from ZooLogic.DISIMP where  DISIMP.CCOD != '' and " + lcFiltro )
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
			local  lxDisimpFecexpo, lxDisimpFaltafw, lxDisimpFmodifw, lxDisimpFecimpo, lxDisimpFectrans, lxDisimpTimestamp, lxDisimpBloqreg, lxDisimpBdmodifw, lxDisimpEsttrans, lxDisimpVmodifw, lxDisimpZadsfw, lxDisimpBdaltafw, lxDisimpValtafw, lxDisimpHoraexpo, lxDisimpSaltafw, lxDisimpHmodifw, lxDisimpSmodifw, lxDisimpHoraimpo, lxDisimpUmodifw, lxDisimpUaltafw, lxDisimpHaltafw, lxDisimpLconfirma, lxDisimpCobs, lxDisimpNlimite, lxDisimpCentidad, lxDisimpNcantcol, lxDisimpLhabimpre, lxDisimpLhabpdf, lxDisimpNmarsup, lxDisimpCcod, lxDisimpNadvierte, lxDisimpNsegundos, lxDisimpLpdfauto, lxDisimpImpauto, lxDisimpNmarizq, lxDisimpCestilo, lxDisimpCdes, lxDisimpCseries, lxDisimpNconfpdf, lxDisimpNsugiere, lxDisimpNmarinf, lxDisimpCrutapdf, lxDisimpNoptsal, lxDisimpNmarder, lxDisimpNcantcop, lxDisimpCcondici, lxDisimpCpuerto, lxDisimpLdefault
				lxDisimpFecexpo = ctod( '  /  /    ' )			lxDisimpFaltafw = ctod( '  /  /    ' )			lxDisimpFmodifw = ctod( '  /  /    ' )			lxDisimpFecimpo = ctod( '  /  /    ' )			lxDisimpFectrans = ctod( '  /  /    ' )			lxDisimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpBloqreg = .F.			lxDisimpBdmodifw = []			lxDisimpEsttrans = []			lxDisimpVmodifw = []			lxDisimpZadsfw = []			lxDisimpBdaltafw = []			lxDisimpValtafw = []			lxDisimpHoraexpo = []			lxDisimpSaltafw = []			lxDisimpHmodifw = []			lxDisimpSmodifw = []			lxDisimpHoraimpo = []			lxDisimpUmodifw = []			lxDisimpUaltafw = []			lxDisimpHaltafw = []			lxDisimpLconfirma = .F.			lxDisimpCobs = []			lxDisimpNlimite = 0			lxDisimpCentidad = []			lxDisimpNcantcol = 0			lxDisimpLhabimpre = .F.			lxDisimpLhabpdf = .F.			lxDisimpNmarsup = 0			lxDisimpCcod = []			lxDisimpNadvierte = 0			lxDisimpNsegundos = 0			lxDisimpLpdfauto = .F.			lxDisimpImpauto = .F.			lxDisimpNmarizq = 0			lxDisimpCestilo = []			lxDisimpCdes = []			lxDisimpCseries = []			lxDisimpNconfpdf = 0			lxDisimpNsugiere = 0			lxDisimpNmarinf = 0			lxDisimpCrutapdf = []			lxDisimpNoptsal = 0			lxDisimpNmarder = 0			lxDisimpNcantcop = 0			lxDisimpCcondici = []			lxDisimpCpuerto = []			lxDisimpLdefault = .F.
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisAreas where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisEnt where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.DisAtributos where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.DISIMP where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
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
			lcTabla = 'DISIMP' + '_' + tcCampo
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
		lcWhere = " Where  DISIMP.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DISIMP', '', tnTope )
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
	Function ObtenerDatosDetalleAreas( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISAREAS.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Cposx" as "X", "Cposy" as "Y", "Cancho" as "Ancho", "Calto" as "Alto", "Cestilo" as "Estilo", "Cdetalle" as "Esdet", "Ccondicion" as "Condicion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAreas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisAreas', 'Areas', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAreas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAreas( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleEntidades( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISENT.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Ient" as "Entidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleEntidades( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisEnt', 'Entidades', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleEntidades( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleEntidades( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleAtributos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISATRIBUTOS.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipodesc" as "Tipodetalle", "Ccontenido" as "Contenido", "Cposy" as "Y", "Cposx" as "X", "Norientaci" as "Orientacion", "Cancho" as "Ancho", "Cestilo" as "Estilo", "Cmascara" as "Mascara", "Ccondicion" as "Condicion", "Fagrupar" as "Funcionagrupar", "Npriordena" as "Prioridadordenamiento", "Ntipordena" as "Tipoordenamiento"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAtributos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisAtributos', 'Atributos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleAtributos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleAtributos( lcAtributo )
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
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SOLICITARCONFIRMACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LCONFIRMA AS SOLICITARCONFIRMACION'
				Case lcAtributo == 'OBSERVACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBSERVACION'
				Case lcAtributo == 'APLICALIMITE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NLIMITE AS APLICALIMITE'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTIDAD AS ENTIDAD'
				Case lcAtributo == 'COLUMNAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCANTCOL AS COLUMNAS'
				Case lcAtributo == 'HABILITASALIDAAIMPRESORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LHABIMPRE AS HABILITASALIDAAIMPRESORA'
				Case lcAtributo == 'HABILITASALIDAAPDF'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LHABPDF AS HABILITASALIDAAPDF'
				Case lcAtributo == 'MARGENSUP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMARSUP AS MARGENSUP'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'ADVIERTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NADVIERTE AS ADVIERTE'
				Case lcAtributo == 'SEGUNDOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NSEGUNDOS AS SEGUNDOS'
				Case lcAtributo == 'PDFAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPDFAUTO AS PDFAUTOMATICO'
				Case lcAtributo == 'IMPRESIONAUTOMATICA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPAUTO AS IMPRESIONAUTOMATICA'
				Case lcAtributo == 'MARGENIZQ'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMARIZQ AS MARGENIZQ'
				Case lcAtributo == 'ESTILO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CESTILO AS ESTILO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDES AS DESCRIPCION'
				Case lcAtributo == 'SERIES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSERIES AS SERIES'
				Case lcAtributo == 'CONFIRMAPDF'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCONFPDF AS CONFIRMAPDF'
				Case lcAtributo == 'SUGIERE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NSUGIERE AS SUGIERE'
				Case lcAtributo == 'MARGENINF'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMARINF AS MARGENINF'
				Case lcAtributo == 'RUTAPDF'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTAPDF AS RUTAPDF'
				Case lcAtributo == 'OPCIONDESALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOPTSAL AS OPCIONDESALIDA'
				Case lcAtributo == 'MARGENDER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NMARDER AS MARGENDER'
				Case lcAtributo == 'CANTIDADCOPIAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCANTCOP AS CANTIDADCOPIAS'
				Case lcAtributo == 'CONDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONDICI AS CONDICION'
				Case lcAtributo == 'PUERTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPUERTO AS PUERTO'
				Case lcAtributo == 'DEFAULTIMPRESION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LDEFAULT AS DEFAULTIMPRESION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAreas( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOD AS CODIGO'
				Case lcAtributo == 'AREA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAREA AS AREA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPO AS TIPO'
				Case lcAtributo == 'X'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPOSX AS X'
				Case lcAtributo == 'Y'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPOSY AS Y'
				Case lcAtributo == 'ANCHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANCHO AS ANCHO'
				Case lcAtributo == 'ALTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CALTO AS ALTO'
				Case lcAtributo == 'ESTILO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CESTILO AS ESTILO'
				Case lcAtributo == 'ESDET'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDETALLE AS ESDET'
				Case lcAtributo == 'CONDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONDICION AS CONDICION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleEntidades( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOD AS CODIGO'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IENT AS ENTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleAtributos( tcCampos As String ) As String
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOD AS CODIGO'
				Case lcAtributo == 'AREA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAREA AS AREA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPO AS TIPO'
				Case lcAtributo == 'TIPODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPODESC AS TIPODETALLE'
				Case lcAtributo == 'CONTENIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONTENIDO AS CONTENIDO'
				Case lcAtributo == 'Y'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPOSY AS Y'
				Case lcAtributo == 'X'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPOSX AS X'
				Case lcAtributo == 'ORIENTACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORIENTACI AS ORIENTACION'
				Case lcAtributo == 'ANCHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANCHO AS ANCHO'
				Case lcAtributo == 'ESTILO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CESTILO AS ESTILO'
				Case lcAtributo == 'MASCARA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMASCARA AS MASCARA'
				Case lcAtributo == 'CONDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONDICION AS CONDICION'
				Case lcAtributo == 'FUNCIONAGRUPAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAGRUPAR AS FUNCIONAGRUPAR'
				Case lcAtributo == 'PRIORIDADORDENAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NPRIORDENA AS PRIORIDADORDENAMIENTO'
				Case lcAtributo == 'TIPOORDENAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NTIPORDENA AS TIPOORDENAMIENTO'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SOLICITARCONFIRMACION'
				lcCampo = 'LCONFIRMA'
			Case upper( alltrim( tcAtributo ) ) == 'OBSERVACION'
				lcCampo = 'COBS'
			Case upper( alltrim( tcAtributo ) ) == 'APLICALIMITE'
				lcCampo = 'NLIMITE'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'CENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'COLUMNAS'
				lcCampo = 'NCANTCOL'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITASALIDAAIMPRESORA'
				lcCampo = 'LHABIMPRE'
			Case upper( alltrim( tcAtributo ) ) == 'HABILITASALIDAAPDF'
				lcCampo = 'LHABPDF'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENSUP'
				lcCampo = 'NMARSUP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'ADVIERTE'
				lcCampo = 'NADVIERTE'
			Case upper( alltrim( tcAtributo ) ) == 'SEGUNDOS'
				lcCampo = 'NSEGUNDOS'
			Case upper( alltrim( tcAtributo ) ) == 'PDFAUTOMATICO'
				lcCampo = 'LPDFAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'IMPRESIONAUTOMATICA'
				lcCampo = 'IMPAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENIZQ'
				lcCampo = 'NMARIZQ'
			Case upper( alltrim( tcAtributo ) ) == 'ESTILO'
				lcCampo = 'CESTILO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDES'
			Case upper( alltrim( tcAtributo ) ) == 'SERIES'
				lcCampo = 'CSERIES'
			Case upper( alltrim( tcAtributo ) ) == 'CONFIRMAPDF'
				lcCampo = 'NCONFPDF'
			Case upper( alltrim( tcAtributo ) ) == 'SUGIERE'
				lcCampo = 'NSUGIERE'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENINF'
				lcCampo = 'NMARINF'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAPDF'
				lcCampo = 'CRUTAPDF'
			Case upper( alltrim( tcAtributo ) ) == 'OPCIONDESALIDA'
				lcCampo = 'NOPTSAL'
			Case upper( alltrim( tcAtributo ) ) == 'MARGENDER'
				lcCampo = 'NMARDER'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADCOPIAS'
				lcCampo = 'NCANTCOP'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICION'
				lcCampo = 'CCONDICI'
			Case upper( alltrim( tcAtributo ) ) == 'PUERTO'
				lcCampo = 'CPUERTO'
			Case upper( alltrim( tcAtributo ) ) == 'DEFAULTIMPRESION'
				lcCampo = 'LDEFAULT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAreas( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ICOD'
			Case upper( alltrim( tcAtributo ) ) == 'AREA'
				lcCampo = 'CAREA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'X'
				lcCampo = 'CPOSX'
			Case upper( alltrim( tcAtributo ) ) == 'Y'
				lcCampo = 'CPOSY'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHO'
				lcCampo = 'CANCHO'
			Case upper( alltrim( tcAtributo ) ) == 'ALTO'
				lcCampo = 'CALTO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTILO'
				lcCampo = 'CESTILO'
			Case upper( alltrim( tcAtributo ) ) == 'ESDET'
				lcCampo = 'CDETALLE'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICION'
				lcCampo = 'CCONDICION'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleEntidades( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ICOD'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'IENT'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleAtributos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'ICOD'
			Case upper( alltrim( tcAtributo ) ) == 'AREA'
				lcCampo = 'CAREA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'CTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODETALLE'
				lcCampo = 'CTIPODESC'
			Case upper( alltrim( tcAtributo ) ) == 'CONTENIDO'
				lcCampo = 'CCONTENIDO'
			Case upper( alltrim( tcAtributo ) ) == 'Y'
				lcCampo = 'CPOSY'
			Case upper( alltrim( tcAtributo ) ) == 'X'
				lcCampo = 'CPOSX'
			Case upper( alltrim( tcAtributo ) ) == 'ORIENTACION'
				lcCampo = 'NORIENTACI'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHO'
				lcCampo = 'CANCHO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTILO'
				lcCampo = 'CESTILO'
			Case upper( alltrim( tcAtributo ) ) == 'MASCARA'
				lcCampo = 'CMASCARA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICION'
				lcCampo = 'CCONDICION'
			Case upper( alltrim( tcAtributo ) ) == 'FUNCIONAGRUPAR'
				lcCampo = 'FAGRUPAR'
			Case upper( alltrim( tcAtributo ) ) == 'PRIORIDADORDENAMIENTO'
				lcCampo = 'NPRIORDENA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOORDENAMIENTO'
				lcCampo = 'NTIPORDENA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AREAS'
			lcRetorno = 'DISAREAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ENTIDADES'
			lcRetorno = 'DISENT'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ATRIBUTOS'
			lcRetorno = 'DISATRIBUTOS'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDisimpFecexpo, lxDisimpFaltafw, lxDisimpFmodifw, lxDisimpFecimpo, lxDisimpFectrans, lxDisimpTimestamp, lxDisimpBloqreg, lxDisimpBdmodifw, lxDisimpEsttrans, lxDisimpVmodifw, lxDisimpZadsfw, lxDisimpBdaltafw, lxDisimpValtafw, lxDisimpHoraexpo, lxDisimpSaltafw, lxDisimpHmodifw, lxDisimpSmodifw, lxDisimpHoraimpo, lxDisimpUmodifw, lxDisimpUaltafw, lxDisimpHaltafw, lxDisimpLconfirma, lxDisimpCobs, lxDisimpNlimite, lxDisimpCentidad, lxDisimpNcantcol, lxDisimpLhabimpre, lxDisimpLhabpdf, lxDisimpNmarsup, lxDisimpCcod, lxDisimpNadvierte, lxDisimpNsegundos, lxDisimpLpdfauto, lxDisimpImpauto, lxDisimpNmarizq, lxDisimpCestilo, lxDisimpCdes, lxDisimpCseries, lxDisimpNconfpdf, lxDisimpNsugiere, lxDisimpNmarinf, lxDisimpCrutapdf, lxDisimpNoptsal, lxDisimpNmarder, lxDisimpNcantcop, lxDisimpCcondici, lxDisimpCpuerto, lxDisimpLdefault
				lxDisimpFecexpo =  .Fechaexpo			lxDisimpFaltafw =  .Fechaaltafw			lxDisimpFmodifw =  .Fechamodificacionfw			lxDisimpFecimpo =  .Fechaimpo			lxDisimpFectrans =  .Fechatransferencia			lxDisimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpBloqreg =  .Bloquearregistro			lxDisimpBdmodifw =  .Basededatosmodificacionfw			lxDisimpEsttrans =  .Estadotransferencia			lxDisimpVmodifw =  .Versionmodificacionfw			lxDisimpZadsfw =  .Zadsfw			lxDisimpBdaltafw =  .Basededatosaltafw			lxDisimpValtafw =  .Versionaltafw			lxDisimpHoraexpo =  .Horaexpo			lxDisimpSaltafw =  .Seriealtafw			lxDisimpHmodifw =  .Horamodificacionfw			lxDisimpSmodifw =  .Seriemodificacionfw			lxDisimpHoraimpo =  .Horaimpo			lxDisimpUmodifw =  .Usuariomodificacionfw			lxDisimpUaltafw =  .Usuarioaltafw			lxDisimpHaltafw =  .Horaaltafw			lxDisimpLconfirma =  .Solicitarconfirmacion			lxDisimpCobs =  .Observacion			lxDisimpNlimite =  .Aplicalimite			lxDisimpCentidad =  .Entidad			lxDisimpNcantcol =  .Columnas			lxDisimpLhabimpre =  .Habilitasalidaaimpresora			lxDisimpLhabpdf =  .Habilitasalidaapdf			lxDisimpNmarsup =  .Margensup			lxDisimpCcod =  .Codigo			lxDisimpNadvierte =  .Advierte			lxDisimpNsegundos =  .Segundos			lxDisimpLpdfauto =  .Pdfautomatico			lxDisimpImpauto =  .Impresionautomatica			lxDisimpNmarizq =  .Margenizq			lxDisimpCestilo =  upper( .Estilo_PK ) 			lxDisimpCdes =  .Descripcion			lxDisimpCseries =  .Series			lxDisimpNconfpdf =  .Confirmapdf			lxDisimpNsugiere =  .Sugiere			lxDisimpNmarinf =  .Margeninf			lxDisimpCrutapdf =  .Rutapdf			lxDisimpNoptsal =  .Opciondesalida			lxDisimpNmarder =  .Margender			lxDisimpNcantcop =  .Cantidadcopias			lxDisimpCcondici =  .Condicion			lxDisimpCpuerto =  .Puerto			lxDisimpLdefault =  .Defaultimpresion
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.DISIMP ( "Fecexpo","Faltafw","Fmodifw","Fecimpo","Fectrans","Timestamp","Bloqreg","Bdmodifw","Esttrans","Vmodifw","Zadsfw","Bdaltafw","Valtafw","Horaexpo","Saltafw","Hmodifw","Smodifw","Horaimpo","Umodifw","Ualtafw","Haltafw","Lconfirma","Cobs","Nlimite","Centidad","Ncantcol","Lhabimpre","Lhabpdf","Nmarsup","Ccod","Nadvierte","Nsegundos","Lpdfauto","Impauto","Nmarizq","Cestilo","Cdes","Cseries","Nconfpdf","Nsugiere","Nmarinf","Crutapdf","Noptsal","Nmarder","Ncantcop","Ccondici","Cpuerto","Ldefault" ) values ( <<"'" + this.ConvertirDateSql( lxDisimpFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpFectrans ) + "'" >>, <<lxDisimpTimestamp >>, <<iif( lxDisimpBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpHaltafw ) + "'" >>, <<iif( lxDisimpLconfirma, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpCobs ) + "'" >>, <<lxDisimpNlimite >>, <<"'" + this.FormatearTextoSql( lxDisimpCentidad ) + "'" >>, <<lxDisimpNcantcol >>, <<iif( lxDisimpLhabimpre, 1, 0 ) >>, <<iif( lxDisimpLhabpdf, 1, 0 ) >>, <<lxDisimpNmarsup >>, <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'" >>, <<lxDisimpNadvierte >>, <<lxDisimpNsegundos >>, <<iif( lxDisimpLpdfauto, 1, 0 ) >>, <<iif( lxDisimpImpauto, 1, 0 ) >>, <<lxDisimpNmarizq >>, <<"'" + this.FormatearTextoSql( lxDisimpCestilo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpCdes ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpCseries ) + "'" >>, <<lxDisimpNconfpdf >>, <<lxDisimpNsugiere >>, <<lxDisimpNmarinf >>, <<"'" + this.FormatearTextoSql( lxDisimpCrutapdf ) + "'" >>, <<lxDisimpNoptsal >>, <<lxDisimpNmarder >>, <<lxDisimpNcantcop >>, <<"'" + this.FormatearTextoSql( lxDisimpCcondici ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpCpuerto ) + "'" >>, <<iif( lxDisimpLdefault, 1, 0 ) >> )
		endtext
		loColeccion.cTabla = 'DISIMP' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxX = loItem.X
					lxY = loItem.Y
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					lxEstilo_PK = loItem.Estilo_PK
					lxEsdet = loItem.Esdet
					lxCondicion = loItem.Condicion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAreas("NROITEM","BLOQREG","iCod","cArea","cTipo","cPosX","cPosY","cAncho","cAlto","cEstilo","cDetalle","cCondicion" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<lxX>>, <<lxY>>, <<lxAncho>>, <<lxAlto>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<iif( lxEsdet, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEnt("NROITEM","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxContenido = loItem.Contenido
					lxY = loItem.Y
					lxX = loItem.X
					lxOrientacion = loItem.Orientacion
					lxAncho = loItem.Ancho
					lxEstilo_PK = loItem.Estilo_PK
					lxMascara = loItem.Mascara
					lxCondicion = loItem.Condicion
					lxFuncionagrupar = loItem.Funcionagrupar
					lxPrioridadordenamiento = loItem.Prioridadordenamiento
					lxTipoordenamiento = loItem.Tipoordenamiento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAtributos("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipoDesc","cContenido","cPosY","cPosX","norientaci","cAncho","cEstilo","cMascara","cCondicion","FAgrupar","npriordena","ntipordena" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxContenido ) + "'">>, <<lxY>>, <<lxX>>, <<lxOrientacion>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMascara ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">>, <<lxFuncionagrupar>>, <<lxPrioridadordenamiento>>, <<lxTipoordenamiento>> ) 
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
			local  lxDisimpFecexpo, lxDisimpFaltafw, lxDisimpFmodifw, lxDisimpFecimpo, lxDisimpFectrans, lxDisimpTimestamp, lxDisimpBloqreg, lxDisimpBdmodifw, lxDisimpEsttrans, lxDisimpVmodifw, lxDisimpZadsfw, lxDisimpBdaltafw, lxDisimpValtafw, lxDisimpHoraexpo, lxDisimpSaltafw, lxDisimpHmodifw, lxDisimpSmodifw, lxDisimpHoraimpo, lxDisimpUmodifw, lxDisimpUaltafw, lxDisimpHaltafw, lxDisimpLconfirma, lxDisimpCobs, lxDisimpNlimite, lxDisimpCentidad, lxDisimpNcantcol, lxDisimpLhabimpre, lxDisimpLhabpdf, lxDisimpNmarsup, lxDisimpCcod, lxDisimpNadvierte, lxDisimpNsegundos, lxDisimpLpdfauto, lxDisimpImpauto, lxDisimpNmarizq, lxDisimpCestilo, lxDisimpCdes, lxDisimpCseries, lxDisimpNconfpdf, lxDisimpNsugiere, lxDisimpNmarinf, lxDisimpCrutapdf, lxDisimpNoptsal, lxDisimpNmarder, lxDisimpNcantcop, lxDisimpCcondici, lxDisimpCpuerto, lxDisimpLdefault
				lxDisimpFecexpo =  .Fechaexpo			lxDisimpFaltafw =  .Fechaaltafw			lxDisimpFmodifw =  .Fechamodificacionfw			lxDisimpFecimpo =  .Fechaimpo			lxDisimpFectrans =  .Fechatransferencia			lxDisimpTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpBloqreg =  .Bloquearregistro			lxDisimpBdmodifw =  .Basededatosmodificacionfw			lxDisimpEsttrans =  .Estadotransferencia			lxDisimpVmodifw =  .Versionmodificacionfw			lxDisimpZadsfw =  .Zadsfw			lxDisimpBdaltafw =  .Basededatosaltafw			lxDisimpValtafw =  .Versionaltafw			lxDisimpHoraexpo =  .Horaexpo			lxDisimpSaltafw =  .Seriealtafw			lxDisimpHmodifw =  .Horamodificacionfw			lxDisimpSmodifw =  .Seriemodificacionfw			lxDisimpHoraimpo =  .Horaimpo			lxDisimpUmodifw =  .Usuariomodificacionfw			lxDisimpUaltafw =  .Usuarioaltafw			lxDisimpHaltafw =  .Horaaltafw			lxDisimpLconfirma =  .Solicitarconfirmacion			lxDisimpCobs =  .Observacion			lxDisimpNlimite =  .Aplicalimite			lxDisimpCentidad =  .Entidad			lxDisimpNcantcol =  .Columnas			lxDisimpLhabimpre =  .Habilitasalidaaimpresora			lxDisimpLhabpdf =  .Habilitasalidaapdf			lxDisimpNmarsup =  .Margensup			lxDisimpCcod =  .Codigo			lxDisimpNadvierte =  .Advierte			lxDisimpNsegundos =  .Segundos			lxDisimpLpdfauto =  .Pdfautomatico			lxDisimpImpauto =  .Impresionautomatica			lxDisimpNmarizq =  .Margenizq			lxDisimpCestilo =  upper( .Estilo_PK ) 			lxDisimpCdes =  .Descripcion			lxDisimpCseries =  .Series			lxDisimpNconfpdf =  .Confirmapdf			lxDisimpNsugiere =  .Sugiere			lxDisimpNmarinf =  .Margeninf			lxDisimpCrutapdf =  .Rutapdf			lxDisimpNoptsal =  .Opciondesalida			lxDisimpNmarder =  .Margender			lxDisimpNcantcop =  .Cantidadcopias			lxDisimpCcondici =  .Condicion			lxDisimpCpuerto =  .Puerto			lxDisimpLdefault =  .Defaultimpresion
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISIMP.CCOD != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.DISIMP set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDisimpFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDisimpFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDisimpFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDisimpFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDisimpFectrans ) + "'">>, "Timestamp" = <<lxDisimpTimestamp>>, "Bloqreg" = <<iif( lxDisimpBloqreg, 1, 0 )>>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDisimpEsttrans ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDisimpZadsfw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDisimpBdaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDisimpValtafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDisimpHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDisimpSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDisimpSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDisimpHoraimpo ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDisimpUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDisimpUaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDisimpHaltafw ) + "'">>, "Lconfirma" = <<iif( lxDisimpLconfirma, 1, 0 )>>, "Cobs" = <<"'" + this.FormatearTextoSql( lxDisimpCobs ) + "'">>, "Nlimite" = <<lxDisimpNlimite>>, "Centidad" = <<"'" + this.FormatearTextoSql( lxDisimpCentidad ) + "'">>, "Ncantcol" = <<lxDisimpNcantcol>>, "Lhabimpre" = <<iif( lxDisimpLhabimpre, 1, 0 )>>, "Lhabpdf" = <<iif( lxDisimpLhabpdf, 1, 0 )>>, "Nmarsup" = <<lxDisimpNmarsup>>, "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpCcod ) + "'">>, "Nadvierte" = <<lxDisimpNadvierte>>, "Nsegundos" = <<lxDisimpNsegundos>>, "Lpdfauto" = <<iif( lxDisimpLpdfauto, 1, 0 )>>, "Impauto" = <<iif( lxDisimpImpauto, 1, 0 )>>, "Nmarizq" = <<lxDisimpNmarizq>>, "Cestilo" = <<"'" + this.FormatearTextoSql( lxDisimpCestilo ) + "'">>, "Cdes" = <<"'" + this.FormatearTextoSql( lxDisimpCdes ) + "'">>, "Cseries" = <<"'" + this.FormatearTextoSql( lxDisimpCseries ) + "'">>, "Nconfpdf" = <<lxDisimpNconfpdf>>, "Nsugiere" = <<lxDisimpNsugiere>>, "Nmarinf" = <<lxDisimpNmarinf>>, "Crutapdf" = <<"'" + this.FormatearTextoSql( lxDisimpCrutapdf ) + "'">>, "Noptsal" = <<lxDisimpNoptsal>>, "Nmarder" = <<lxDisimpNmarder>>, "Ncantcop" = <<lxDisimpNcantcop>>, "Ccondici" = <<"'" + this.FormatearTextoSql( lxDisimpCcondici ) + "'">>, "Cpuerto" = <<"'" + this.FormatearTextoSql( lxDisimpCpuerto ) + "'">>, "Ldefault" = <<iif( lxDisimpLdefault, 1, 0 )>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DISIMP' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.DisAreas where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DisEnt where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DisAtributos where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxX = loItem.X
					lxY = loItem.Y
					lxAncho = loItem.Ancho
					lxAlto = loItem.Alto
					lxEstilo_PK = loItem.Estilo_PK
					lxEsdet = loItem.Esdet
					lxCondicion = loItem.Condicion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAreas("NROITEM","BLOQREG","iCod","cArea","cTipo","cPosX","cPosY","cAncho","cAlto","cEstilo","cDetalle","cCondicion" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<lxX>>, <<lxY>>, <<lxAncho>>, <<lxAlto>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<iif( lxEsdet, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Entidades
				if this.oEntidad.Entidades.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxEntidad = loItem.Entidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisEnt("NROITEM","BLOQREG","iCod","iEnt" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEntidad ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Atributos
				if this.oEntidad.Atributos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxContenido = loItem.Contenido
					lxY = loItem.Y
					lxX = loItem.X
					lxOrientacion = loItem.Orientacion
					lxAncho = loItem.Ancho
					lxEstilo_PK = loItem.Estilo_PK
					lxMascara = loItem.Mascara
					lxCondicion = loItem.Condicion
					lxFuncionagrupar = loItem.Funcionagrupar
					lxPrioridadordenamiento = loItem.Prioridadordenamiento
					lxTipoordenamiento = loItem.Tipoordenamiento
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.DisAtributos("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipoDesc","cContenido","cPosY","cPosX","norientaci","cAncho","cEstilo","cMascara","cCondicion","FAgrupar","npriordena","ntipordena" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxContenido ) + "'">>, <<lxY>>, <<lxX>>, <<lxOrientacion>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxEstilo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMascara ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion ) + "'">>, <<lxFuncionagrupar>>, <<lxPrioridadordenamiento>>, <<lxTipoordenamiento>> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISIMP.CCOD != '']
		loColeccion.Agregar( 'delete from ZooLogic.DISIMP where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.DisAreas where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DisEnt where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.DisAtributos where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DISIMP' 
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
		
			.oCompDisenoimpresion.lNuevo = .EsNuevo()
			.oCompDisenoimpresion.lEdicion = .EsEdicion()
			.oCompDisenoimpresion.lEliminar = .lEliminar
			.oCompDisenoimpresion.lAnular = .lAnular
			loColSentencias = .oCompDisenoimpresion.grabar()
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
			lcRetorno = [update ZooLogic.DISIMP set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where cCod = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  DISIMP.CCOD != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.DISIMP where  DISIMP.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.DISIMP where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DISIMP.CCOD != ''" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPRESION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.DISIMP Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() 
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					if !Evaluate( lcCursor + ".BloqReg" )
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.DISIMP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, lConfirma = ] + Transform( iif( &lcCursor..lConfirma, 1, 0 ))+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, nLimite = ] + transform( &lcCursor..nLimite )+ [, cEntidad = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'"+ [, nCantCol = ] + transform( &lcCursor..nCantCol )+ [, lHabImpre = ] + Transform( iif( &lcCursor..lHabImpre, 1, 0 ))+ [, lHabPdf = ] + Transform( iif( &lcCursor..lHabPdf, 1, 0 ))+ [, nMarSup = ] + transform( &lcCursor..nMarSup )+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, nAdvierte = ] + transform( &lcCursor..nAdvierte )+ [, nSegundos = ] + transform( &lcCursor..nSegundos )+ [, lPdfAuto = ] + Transform( iif( &lcCursor..lPdfAuto, 1, 0 ))+ [, impauto = ] + Transform( iif( &lcCursor..impauto, 1, 0 ))+ [, nMarIzq = ] + transform( &lcCursor..nMarIzq )+ [, cEstilo = ] + "'" + this.FormatearTextoSql( &lcCursor..cEstilo ) + "'"+ [, cDes = ] + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"+ [, cSeries = ] + "'" + this.FormatearTextoSql( &lcCursor..cSeries ) + "'"+ [, nConfPdf = ] + transform( &lcCursor..nConfPdf )+ [, nSugiere = ] + transform( &lcCursor..nSugiere )+ [, nMarInf = ] + transform( &lcCursor..nMarInf )+ [, cRutaPdf = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaPdf ) + "'"+ [, nOptSal = ] + transform( &lcCursor..nOptSal )+ [, nMarDer = ] + transform( &lcCursor..nMarDer )+ [, nCantCop = ] + transform( &lcCursor..nCantCop )+ [, cCondici = ] + "'" + this.FormatearTextoSql( &lcCursor..cCondici ) + "'"+ [, cPuerto = ] + "'" + this.FormatearTextoSql( &lcCursor..cPuerto ) + "'"+ [, lDefault = ] + Transform( iif( &lcCursor..lDefault, 1, 0 )) + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
						lcMensajeExtra = ""
					else
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.DISIMP set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, lConfirma = ] + Transform( iif( &lcCursor..lConfirma, 1, 0 ))+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"+ [, nLimite = ] + transform( &lcCursor..nLimite )+ [, nCantCol = ] + transform( &lcCursor..nCantCol )+ [, lHabImpre = ] + Transform( iif( &lcCursor..lHabImpre, 1, 0 ))+ [, lHabPdf = ] + Transform( iif( &lcCursor..lHabPdf, 1, 0 ))+ [, nMarSup = ] + transform( &lcCursor..nMarSup )+ [, nAdvierte = ] + transform( &lcCursor..nAdvierte )+ [, nSegundos = ] + transform( &lcCursor..nSegundos )+ [, lPdfAuto = ] + Transform( iif( &lcCursor..lPdfAuto, 1, 0 ))+ [, impauto = ] + Transform( iif( &lcCursor..impauto, 1, 0 ))+ [, nMarIzq = ] + transform( &lcCursor..nMarIzq )+ [, cDes = ] + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"+ [, cSeries = ] + "'" + this.FormatearTextoSql( &lcCursor..cSeries ) + "'"+ [, nConfPdf = ] + transform( &lcCursor..nConfPdf )+ [, nSugiere = ] + transform( &lcCursor..nSugiere )+ [, nMarInf = ] + transform( &lcCursor..nMarInf )+ [, cRutaPdf = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaPdf ) + "'"+ [, nOptSal = ] + transform( &lcCursor..nOptSal )+ [, nMarDer = ] + transform( &lcCursor..nMarDer )+ [, nCantCop = ] + transform( &lcCursor..nCantCop )+ [, cPuerto = ] + "'" + this.FormatearTextoSql( &lcCursor..cPuerto ) + "'"+ [, lDefault = ] + Transform( iif( &lcCursor..lDefault, 1, 0 )) + [ Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" )
						lcMensajeExtra = " - edición parcial"
					endif
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECEXPO, FALTAFW, FMODIFW, FECIMPO, FECTRANS, TIMESTAMP, BLOQREG, BDMODIFW, ESTTRANS, VMODIFW, ZADSFW, BDALTAFW, VALTAFW, HORAEXPO, SALTAFW, HMODIFW, SMODIFW, HORAIMPO, UMODIFW, UALTAFW, HALTAFW, lConfirma, cObs, nLimite, cEntidad, nCantCol, lHabImpre, lHabPdf, nMarSup, cCod, nAdvierte, nSegundos, lPdfAuto, impauto, nMarIzq, cEstilo, cDes, cSeries, nConfPdf, nSugiere, nMarInf, cRutaPdf, nOptSal, nMarDer, nCantCop, cCondici, cPuerto, lDefault
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..lConfirma, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + ',' + transform( &lcCursor..nLimite ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'" + ',' + transform( &lcCursor..nCantCol ) + ',' + Transform( iif( &lcCursor..lHabImpre, 1, 0 )) + ',' + Transform( iif( &lcCursor..lHabPdf, 1, 0 )) + ',' + transform( &lcCursor..nMarSup )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + transform( &lcCursor..nAdvierte ) + ',' + transform( &lcCursor..nSegundos ) + ',' + Transform( iif( &lcCursor..lPdfAuto, 1, 0 )) + ',' + Transform( iif( &lcCursor..impauto, 1, 0 )) + ',' + transform( &lcCursor..nMarIzq ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEstilo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cSeries ) + "'" + ',' + transform( &lcCursor..nConfPdf ) + ',' + transform( &lcCursor..nSugiere ) + ',' + transform( &lcCursor..nMarInf ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutaPdf ) + "'" + ',' + transform( &lcCursor..nOptSal ) + ',' + transform( &lcCursor..nMarDer ) + ',' + transform( &lcCursor..nCantCop ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCondici ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cPuerto ) + "'" + ',' + Transform( iif( &lcCursor..lDefault, 1, 0 ))
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.DISIMP ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPRESION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DisAreas Where iCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DisEnt Where iCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.DisAtributos Where iCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAREASIMPRESION'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","cArea","cTipo","cPosX","cPosY","cAncho","cAlto","cEstilo","cDetalle","cCondicion"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DisAreas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cArea      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipo      ) + "'" + ',' + transform( cDetallesExistentes.cPosX      ) + ',' + transform( cDetallesExistentes.cPosY      ) + ',' + transform( cDetallesExistentes.cAncho     ) + ',' + transform( cDetallesExistentes.cAlto      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cEstilo    ) + "'" + ',' + Transform( iif( cDetallesExistentes.cDetalle  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCondicion ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMENTIDADES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","iEnt"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DisEnt ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iEnt       ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMATRIBUTOSIMPRESION'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","cArea","cTipo","cTipoDesc","cContenido","cPosY","cPosX","norientaci","cAncho","cEstilo","cMascara","cCondicion","FAgrupar","npriordena","ntipordena"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.DisAtributos ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cArea      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipo      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipoDesc  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cContenido ) + "'" + ',' + transform( cDetallesExistentes.cPosY      ) + ',' + transform( cDetallesExistentes.cPosX      ) + ',' + transform( cDetallesExistentes.norientaci ) + ',' + transform( cDetallesExistentes.cAncho     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cEstilo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cMascara   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCondicion ) + "'" + ',' + transform( cDetallesExistentes.FAgrupar   ) + ',' + transform( cDetallesExistentes.npriordena ) + ',' + transform( cDetallesExistentes.ntipordena ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( cCod C (40) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Nombre: ' + transform( &tcCursor..cCod       )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DISENOIMPRESION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOIMPRESION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOIMPRESION_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAREASIMPRESION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMENTIDADES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMATRIBUTOSIMPRESION'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_DisImp')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DISENOIMPRESION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DISENOIMPRESION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPRESION'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPRESION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DisImp') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DisImp
Create Table ZooLogic.TablaTrabajo_DisImp ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"bdaltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"haltafw" char( 8 )  null, 
"lconfirma" bit  null, 
"cobs" varchar(max)  null, 
"nlimite" numeric( 1, 0 )  null, 
"centidad" char( 40 )  null, 
"ncantcol" numeric( 2, 0 )  null, 
"lhabimpre" bit  null, 
"lhabpdf" bit  null, 
"nmarsup" numeric( 7, 2 )  null, 
"ccod" char( 40 )  null, 
"nadvierte" numeric( 1, 0 )  null, 
"nsegundos" numeric( 5, 2 )  null, 
"lpdfauto" bit  null, 
"impauto" bit  null, 
"nmarizq" numeric( 7, 2 )  null, 
"cestilo" char( 10 )  null, 
"cdes" char( 100 )  null, 
"cseries" char( 100 )  null, 
"nconfpdf" numeric( 1, 0 )  null, 
"nsugiere" numeric( 1, 0 )  null, 
"nmarinf" numeric( 7, 2 )  null, 
"crutapdf" char( 254 )  null, 
"noptsal" numeric( 1, 0 )  null, 
"nmarder" numeric( 7, 2 )  null, 
"ncantcop" numeric( 3, 0 )  null, 
"ccondici" char( 254 )  null, 
"cpuerto" char( 10 )  null, 
"ldefault" bit  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DisImp' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DisImp' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPRESION'
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
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('lconfirma','lconfirma')
			.AgregarMapeo('cobs','cobs')
			.AgregarMapeo('nlimite','nlimite')
			.AgregarMapeo('centidad','centidad')
			.AgregarMapeo('ncantcol','ncantcol')
			.AgregarMapeo('lhabimpre','lhabimpre')
			.AgregarMapeo('lhabpdf','lhabpdf')
			.AgregarMapeo('nmarsup','nmarsup')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('nadvierte','nadvierte')
			.AgregarMapeo('nsegundos','nsegundos')
			.AgregarMapeo('lpdfauto','lpdfauto')
			.AgregarMapeo('impauto','impauto')
			.AgregarMapeo('nmarizq','nmarizq')
			.AgregarMapeo('cestilo','cestilo')
			.AgregarMapeo('cdes','cdes')
			.AgregarMapeo('cseries','cseries')
			.AgregarMapeo('nconfpdf','nconfpdf')
			.AgregarMapeo('nsugiere','nsugiere')
			.AgregarMapeo('nmarinf','nmarinf')
			.AgregarMapeo('crutapdf','crutapdf')
			.AgregarMapeo('noptsal','noptsal')
			.AgregarMapeo('nmarder','nmarder')
			.AgregarMapeo('ncantcop','ncantcop')
			.AgregarMapeo('ccondici','ccondici')
			.AgregarMapeo('cpuerto','cpuerto')
			.AgregarMapeo('ldefault','ldefault')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_DisImp'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.LCONFIRMA = isnull( d.LCONFIRMA, t.LCONFIRMA ),t.COBS = isnull( d.COBS, t.COBS ),t.NLIMITE = isnull( d.NLIMITE, t.NLIMITE ),t.CENTIDAD = isnull( d.CENTIDAD, t.CENTIDAD ),t.NCANTCOL = isnull( d.NCANTCOL, t.NCANTCOL ),t.LHABIMPRE = isnull( d.LHABIMPRE, t.LHABIMPRE ),t.LHABPDF = isnull( d.LHABPDF, t.LHABPDF ),t.NMARSUP = isnull( d.NMARSUP, t.NMARSUP ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.NADVIERTE = isnull( d.NADVIERTE, t.NADVIERTE ),t.NSEGUNDOS = isnull( d.NSEGUNDOS, t.NSEGUNDOS ),t.LPDFAUTO = isnull( d.LPDFAUTO, t.LPDFAUTO ),t.IMPAUTO = isnull( d.IMPAUTO, t.IMPAUTO ),t.NMARIZQ = isnull( d.NMARIZQ, t.NMARIZQ ),t.CESTILO = isnull( d.CESTILO, t.CESTILO ),t.CDES = isnull( d.CDES, t.CDES ),t.CSERIES = isnull( d.CSERIES, t.CSERIES ),t.NCONFPDF = isnull( d.NCONFPDF, t.NCONFPDF ),t.NSUGIERE = isnull( d.NSUGIERE, t.NSUGIERE ),t.NMARINF = isnull( d.NMARINF, t.NMARINF ),t.CRUTAPDF = isnull( d.CRUTAPDF, t.CRUTAPDF ),t.NOPTSAL = isnull( d.NOPTSAL, t.NOPTSAL ),t.NMARDER = isnull( d.NMARDER, t.NMARDER ),t.NCANTCOP = isnull( d.NCANTCOP, t.NCANTCOP ),t.CCONDICI = isnull( d.CCONDICI, t.CCONDICI ),t.CPUERTO = isnull( d.CPUERTO, t.CPUERTO ),t.LDEFAULT = isnull( d.LDEFAULT, t.LDEFAULT )
					from ZooLogic.DISIMP t inner join deleted d 
							 on t.cCod = d.cCod
				-- Fin Updates
				insert into ZooLogic.DISIMP(Fecexpo,Faltafw,Fmodifw,Fecimpo,Fectrans,Timestamp,Bloqreg,Bdmodifw,Esttrans,Vmodifw,Zadsfw,Bdaltafw,Valtafw,Horaexpo,Saltafw,Hmodifw,Smodifw,Horaimpo,Umodifw,Ualtafw,Haltafw,Lconfirma,Cobs,Nlimite,Centidad,Ncantcol,Lhabimpre,Lhabpdf,Nmarsup,Ccod,Nadvierte,Nsegundos,Lpdfauto,Impauto,Nmarizq,Cestilo,Cdes,Cseries,Nconfpdf,Nsugiere,Nmarinf,Crutapdf,Noptsal,Nmarder,Ncantcop,Ccondici,Cpuerto,Ldefault)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.BDALTAFW,''),isnull( d.VALTAFW,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),convert( char(8), getdate(), 108 ),isnull( d.LCONFIRMA,0),isnull( d.COBS,''),isnull( d.NLIMITE,0),isnull( d.CENTIDAD,''),isnull( d.NCANTCOL,0),isnull( d.LHABIMPRE,0),isnull( d.LHABPDF,0),isnull( d.NMARSUP,0),isnull( d.CCOD,''),isnull( d.NADVIERTE,0),isnull( d.NSEGUNDOS,0),isnull( d.LPDFAUTO,0),isnull( d.IMPAUTO,0),isnull( d.NMARIZQ,0),isnull( d.CESTILO,''),isnull( d.CDES,''),isnull( d.CSERIES,''),isnull( d.NCONFPDF,0),isnull( d.NSUGIERE,0),isnull( d.NMARINF,0),isnull( d.CRUTAPDF,''),isnull( d.NOPTSAL,0),isnull( d.NMARDER,0),isnull( d.NCANTCOP,0),isnull( d.CCONDICI,''),isnull( d.CPUERTO,''),isnull( d.LDEFAULT,0)
						From deleted d left join ZooLogic.DISIMP pk 
							 on d.cCod = pk.cCod
						Where pk.cCod Is Null 
				-- Fin Inserts
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisAreas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DISIMP_DisAreas
ON ZooLogic.TablaTrabajo_DISIMP_DisAreas
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CAREA = isnull( d.CAREA, t.CAREA ),
t.CTIPO = isnull( d.CTIPO, t.CTIPO ),
t.CPOSX = isnull( d.CPOSX, t.CPOSX ),
t.CPOSY = isnull( d.CPOSY, t.CPOSY ),
t.CANCHO = isnull( d.CANCHO, t.CANCHO ),
t.CALTO = isnull( d.CALTO, t.CALTO ),
t.CESTILO = isnull( d.CESTILO, t.CESTILO ),
t.CDETALLE = isnull( d.CDETALLE, t.CDETALLE ),
t.CCONDICION = isnull( d.CCONDICION, t.CCONDICION )
from ZooLogic.DisAreas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DisAreas
( 
"NROITEM",
"BLOQREG",
"ICOD",
"CAREA",
"CTIPO",
"CPOSX",
"CPOSY",
"CANCHO",
"CALTO",
"CESTILO",
"CDETALLE",
"CCONDICION"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.CAREA,
d.CTIPO,
d.CPOSX,
d.CPOSY,
d.CANCHO,
d.CALTO,
d.CESTILO,
d.CDETALLE,
d.CCONDICION
From deleted d left join ZooLogic.DisAreas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisEnt( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DISIMP_DisEnt
ON ZooLogic.TablaTrabajo_DISIMP_DisEnt
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.IENT = isnull( d.IENT, t.IENT )
from ZooLogic.DisEnt t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DisEnt
( 
"NROITEM",
"BLOQREG",
"ICOD",
"IENT"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.IENT
From deleted d left join ZooLogic.DisEnt pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisAtributos( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_DISIMP_DisAtributos
ON ZooLogic.TablaTrabajo_DISIMP_DisAtributos
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CAREA = isnull( d.CAREA, t.CAREA ),
t.CTIPO = isnull( d.CTIPO, t.CTIPO ),
t.CTIPODESC = isnull( d.CTIPODESC, t.CTIPODESC ),
t.CCONTENIDO = isnull( d.CCONTENIDO, t.CCONTENIDO ),
t.CPOSY = isnull( d.CPOSY, t.CPOSY ),
t.CPOSX = isnull( d.CPOSX, t.CPOSX ),
t.NORIENTACI = isnull( d.NORIENTACI, t.NORIENTACI ),
t.CANCHO = isnull( d.CANCHO, t.CANCHO ),
t.CESTILO = isnull( d.CESTILO, t.CESTILO ),
t.CMASCARA = isnull( d.CMASCARA, t.CMASCARA ),
t.CCONDICION = isnull( d.CCONDICION, t.CCONDICION ),
t.FAGRUPAR = isnull( d.FAGRUPAR, t.FAGRUPAR ),
t.NPRIORDENA = isnull( d.NPRIORDENA, t.NPRIORDENA ),
t.NTIPORDENA = isnull( d.NTIPORDENA, t.NTIPORDENA )
from ZooLogic.DisAtributos t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.DisAtributos
( 
"NROITEM",
"BLOQREG",
"ICOD",
"CAREA",
"CTIPO",
"CTIPODESC",
"CCONTENIDO",
"CPOSY",
"CPOSX",
"NORIENTACI",
"CANCHO",
"CESTILO",
"CMASCARA",
"CCONDICION",
"FAGRUPAR",
"NPRIORDENA",
"NTIPORDENA"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.CAREA,
d.CTIPO,
d.CTIPODESC,
d.CCONTENIDO,
d.CPOSY,
d.CPOSX,
d.NORIENTACI,
d.CANCHO,
d.CESTILO,
d.CMASCARA,
d.CCONDICION,
d.FAGRUPAR,
d.NPRIORDENA,
d.NTIPORDENA
From deleted d left join ZooLogic.DisAtributos pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_DisImp') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_DisImp
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DISENOIMPRESION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPRESION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPRESION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPRESION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPRESION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPRESION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Areas.Limpiar()
					.Areas.SetearEsNavegacion( .lProcesando )
					.Areas.Cargar()
					.Timestamp = nvl( c_DISENOIMPRESION.Timestamp, 0 )
					.Bloquearregistro = nvl( c_DISENOIMPRESION.Bloquearregistro, .F. )
					.Basededatosmodificacionfw = nvl( c_DISENOIMPRESION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_DISENOIMPRESION.Estadotransferencia, [] )
					.Versionmodificacionfw = nvl( c_DISENOIMPRESION.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Basededatosaltafw = nvl( c_DISENOIMPRESION.Basededatosaltafw, [] )
					.Versionaltafw = nvl( c_DISENOIMPRESION.Versionaltafw, [] )
					.Horaexpo = nvl( c_DISENOIMPRESION.Horaexpo, [] )
					.Seriealtafw = nvl( c_DISENOIMPRESION.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_DISENOIMPRESION.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_DISENOIMPRESION.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_DISENOIMPRESION.Horaimpo, [] )
					.Usuariomodificacionfw = nvl( c_DISENOIMPRESION.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_DISENOIMPRESION.Usuarioaltafw, [] )
					.Horaaltafw = nvl( c_DISENOIMPRESION.Horaaltafw, [] )
					.Solicitarconfirmacion = nvl( c_DISENOIMPRESION.Solicitarconfirmacion, .F. )
					lcValor = This.ObtenerMemo( 'c_Observacion')
					.Observacion = lcValor 
					.Aplicalimite = nvl( c_DISENOIMPRESION.Aplicalimite, 0 )
					.Entidad = nvl( c_DISENOIMPRESION.Entidad, [] )
					.Columnas = nvl( c_DISENOIMPRESION.Columnas, 0 )
					.Habilitasalidaaimpresora = nvl( c_DISENOIMPRESION.Habilitasalidaaimpresora, .F. )
					.Habilitasalidaapdf = nvl( c_DISENOIMPRESION.Habilitasalidaapdf, .F. )
					.Margensup = nvl( c_DISENOIMPRESION.Margensup, 0 )
					.Entidades.Limpiar()
					.Entidades.SetearEsNavegacion( .lProcesando )
					.Entidades.Cargar()
					.Codigo = nvl( c_DISENOIMPRESION.Codigo, [] )
					.Advierte = nvl( c_DISENOIMPRESION.Advierte, 0 )
					.Atributos.Limpiar()
					.Atributos.SetearEsNavegacion( .lProcesando )
					.Atributos.Cargar()
					.Segundos = nvl( c_DISENOIMPRESION.Segundos, 0 )
					.Pdfautomatico = nvl( c_DISENOIMPRESION.Pdfautomatico, .F. )
					.Impresionautomatica = nvl( c_DISENOIMPRESION.Impresionautomatica, .F. )
					.Margenizq = nvl( c_DISENOIMPRESION.Margenizq, 0 )
					.Estilo_PK =  nvl( c_DISENOIMPRESION.Estilo, [] )
					.Descripcion = nvl( c_DISENOIMPRESION.Descripcion, [] )
					.Series = nvl( c_DISENOIMPRESION.Series, [] )
					.Confirmapdf = nvl( c_DISENOIMPRESION.Confirmapdf, 0 )
					.Sugiere = nvl( c_DISENOIMPRESION.Sugiere, 0 )
					.Margeninf = nvl( c_DISENOIMPRESION.Margeninf, 0 )
					.Rutapdf = nvl( c_DISENOIMPRESION.Rutapdf, [] )
					.Opciondesalida = nvl( c_DISENOIMPRESION.Opciondesalida, 0 )
					.Margender = nvl( c_DISENOIMPRESION.Margender, 0 )
					.Cantidadcopias = nvl( c_DISENOIMPRESION.Cantidadcopias, 0 )
					.Condicion = nvl( c_DISENOIMPRESION.Condicion, [] )
					.Puerto = nvl( c_DISENOIMPRESION.Puerto, [] )
					.Defaultimpresion = nvl( c_DISENOIMPRESION.Defaultimpresion, .F. )
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
		
		loDetalle = this.oEntidad.Areas
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

		loDetalle = this.oEntidad.Entidades
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

		loDetalle = this.oEntidad.Atributos
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
		return c_DISENOIMPRESION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.DISIMP' )
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
								from ZooLogic.DISIMP 
								Where   DISIMP.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DISIMP", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Haltafw" as "Horaaltafw", "Lconfirma" as "Solicitarconfirmacion", "Cobs" as "Observacion", "Nlimite" as "Aplicalimite", "Centidad" as "Entidad", "Ncantcol" as "Columnas", "Lhabimpre" as "Habilitasalidaaimpresora", "Lhabpdf" as "Habilitasalidaapdf", "Nmarsup" as "Margensup", "Ccod" as "Codigo", "Nadvierte" as "Advierte", "Nsegundos" as "Segundos", "Lpdfauto" as "Pdfautomatico", "Impauto" as "Impresionautomatica", "Nmarizq" as "Margenizq", "Cestilo" as "Estilo", "Cdes" as "Descripcion", "Cseries" as "Series", "Nconfpdf" as "Confirmapdf", "Nsugiere" as "Sugiere", "Nmarinf" as "Margeninf", "Crutapdf" as "Rutapdf", "Noptsal" as "Opciondesalida", "Nmarder" as "Margender", "Ncantcop" as "Cantidadcopias", "Ccondici" as "Condicion", "Cpuerto" as "Puerto", "Ldefault" as "Defaultimpresion"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.DISIMP 
								Where   DISIMP.CCOD != ''
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
	Tabla = 'DISIMP'
	Filtro = " DISIMP.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DISIMP.CCOD != ''"
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
	<row entidad="DISENOIMPRESION                         " atributo="FECHAEXPO                               " tabla="DISIMP         " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="FECHAALTAFW                             " tabla="DISIMP         " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="FECHAMODIFICACIONFW                     " tabla="DISIMP         " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="FECHAIMPO                               " tabla="DISIMP         " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="FECHATRANSFERENCIA                      " tabla="DISIMP         " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="AREAS                                   " tabla="DISAREAS       " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Áreas                                                                                                                                                           " dominio="DETALLEITEMAREASIMPRESION     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="TIMESTAMP                               " tabla="DISIMP         " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="BLOQUEARREGISTRO                        " tabla="DISIMP         " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DISIMP         " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ESTADOTRANSFERENCIA                     " tabla="DISIMP         " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="VERSIONMODIFICACIONFW                   " tabla="DISIMP         " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ZADSFW                                  " tabla="DISIMP         " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="BASEDEDATOSALTAFW                       " tabla="DISIMP         " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="VERSIONALTAFW                           " tabla="DISIMP         " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="HORAEXPO                                " tabla="DISIMP         " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="SERIEALTAFW                             " tabla="DISIMP         " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="HORAMODIFICACIONFW                      " tabla="DISIMP         " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="SERIEMODIFICACIONFW                     " tabla="DISIMP         " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="HORAIMPO                                " tabla="DISIMP         " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="USUARIOMODIFICACIONFW                   " tabla="DISIMP         " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="USUARIOALTAFW                           " tabla="DISIMP         " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="HORAALTAFW                              " tabla="DISIMP         " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="SOLICITARCONFIRMACION                   " tabla="DISIMP         " campo="LCONFIRMA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Confirma impresión                                                                                                                                              " dominio="OPCIONESCONFIRMACION          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="OBSERVACION                             " tabla="DISIMP         " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Observación                                                                                                                                                     " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="APLICALIMITE                            " tabla="DISIMP         " campo="NLIMITE   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="404" etiqueta="Limitar carga de ítems                                                                                                                                          " dominio="SINONUM                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ENTIDAD                                 " tabla="DISIMP         " campo="CENTIDAD  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Comprobante                                                                                                                                                     " dominio="COMBOENTIDADES                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="COLUMNAS                                " tabla="DISIMP         " campo="NCANTCOL  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="406" etiqueta="Cant. columnas                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="51" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="HABILITASALIDAAIMPRESORA                " tabla="DISIMP         " campo="LHABIMPRE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="408" etiqueta="Habilitar                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="HABILITASALIDAAPDF                      " tabla="DISIMP         " campo="LHABPDF   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="=.T.                                                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="410" etiqueta="Habilitar                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="MARGENSUP                               " tabla="DISIMP         " campo="NMARSUP   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Superior                                                                                                                                                        " dominio="TWIPSAMM                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ENTIDADES                               " tabla="DISENT         " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Entidades                                                                                                                                                       " dominio="DETALLEITEMENTIDADES          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="CODIGO                                  " tabla="DISIMP         " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Nombre                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ADVIERTE                                " tabla="DISIMP         " campo="NADVIERTE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="0                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="416" etiqueta="Advertir                                                                                                                                                        " dominio="SINONUM                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ATRIBUTOS                               " tabla="DISATRIBUTOS   " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Atributos                                                                                                                                                       " dominio="DETALLEITEMATRIBUTOSIMPRESION " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="6" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="SEGUNDOS                                " tabla="DISIMP         " campo="NSEGUNDOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="2" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="420" etiqueta="Cant. segundos                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="51" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="PDFAUTOMATICO                           " tabla="DISIMP         " campo="LPDFAUTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Generar PDF al guardar                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="IMPRESIONAUTOMATICA                     " tabla="DISIMP         " campo="IMPAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Imprimir al guardar                                                                                                                                             " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="MARGENIZQ                               " tabla="DISIMP         " campo="NMARIZQ   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Izquierdo                                                                                                                                                       " dominio="TWIPSAMM                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="ESTILO                                  " tabla="DISIMP         " campo="CESTILO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ESTILOIMPRESION                         " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Estilo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="DESCRIPCION                             " tabla="DISIMP         " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="SERIES                                  " tabla="DISIMP         " campo="CSERIES   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Disponible en serie                                                                                                                                             " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="CONFIRMAPDF                             " tabla="DISIMP         " campo="NCONFPDF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Confirma generación de PDF                                                                                                                                      " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="SUGIERE                                 " tabla="DISIMP         " campo="NSUGIERE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Confirma impresión                                                                                                                                              " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="MARGENINF                               " tabla="DISIMP         " campo="NMARINF   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Inferior                                                                                                                                                        " dominio="TWIPSAMM                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="RUTAPDF                                 " tabla="DISIMP         " campo="CRUTAPDF  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Ruta                                                                                                                                                            " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="OPCIONDESALIDA                          " tabla="DISIMP         " campo="NOPTSAL   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Opciones de impresora                                                                                                                                           " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="MARGENDER                               " tabla="DISIMP         " campo="NMARDER   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Derecho                                                                                                                                                         " dominio="TWIPSAMM                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="999999                   " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="9" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="CANTIDADCOPIAS                          " tabla="DISIMP         " campo="NCANTCOP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="false" admitebusqueda="8" etiqueta="Número de copias                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="CONDICION                               " tabla="DISIMP         " campo="CCONDICI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Condición                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="PUERTO                                  " tabla="DISIMP         " campo="CPUERTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Puerto                                                                                                                                                          " dominio="COMBOPUERTOSCONDEFAULT        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPRESION                         " atributo="DEFAULTIMPRESION                        " tabla="DISIMP         " campo="LDEFAULT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Diseño sugerido                                                                                                                                                 " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ESTILOIMPRESION                         " atributo="DESCRIPCION                             " tabla="ESTIMP         " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Est.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ESTIMP On DISIMP.CESTILO = ESTIMP.cCod And  ESTIMP.CCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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