
define class Din_EntidadDISENOIMPOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_DISENOIMPO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [clasehook]
	cExpresionCCPorCampos = [#tabla#.clasehook]
	cTagClaveCandidata = '_DIMCC'
	cTagClavePk = '_DIMPK'
	cTablaPrincipal = 'DISIMPO'
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
			local  lxDisimpoFecexpo, lxDisimpoFaltafw, lxDisimpoFecimpo, lxDisimpoFectrans, lxDisimpoFmodifw, lxDisimpoUaltafw, lxDisimpoEsttrans, lxDisimpoBdmodifw, lxDisimpoHaltafw, lxDisimpoSmodifw, lxDisimpoHoraexpo, lxDisimpoHoraimpo, lxDisimpoBdaltafw, lxDisimpoHmodifw, lxDisimpoSaltafw, lxDisimpoZadsfw, lxDisimpoUmodifw, lxDisimpoVmodifw, lxDisimpoValtafw, lxDisimpoTimestamp, lxDisimpoBloqreg, lxDisimpoClasehook, lxDisimpoCarchent, lxDisimpoAccsinaler, lxDisimpoCentidad, lxDisimpoCcod, lxDisimpoCmodo, lxDisimpoCtiparch, lxDisimpoCrutaproc, lxDisimpoCdes, lxDisimpoCanlincort, lxDisimpoAccconaler, lxDisimpoCcomando, lxDisimpoCrutaalert, lxDisimpoParcoma, lxDisimpoAccconerr, lxDisimpoCrutaerr, lxDisimpoCtipreg, lxDisimpoCdelimi, lxDisimpoIgnorini, lxDisimpoIgnorfin, lxDisimpoIgnorblanc, lxDisimpoCbdatos, lxDisimpoCsololin, lxDisimpoClinignor, lxDisimpoDetecdet, lxDisimpoCobs
				lxDisimpoFecexpo =  .Fechaexpo			lxDisimpoFaltafw =  .Fechaaltafw			lxDisimpoFecimpo =  .Fechaimpo			lxDisimpoFectrans =  .Fechatransferencia			lxDisimpoFmodifw =  .Fechamodificacionfw			lxDisimpoUaltafw =  .Usuarioaltafw			lxDisimpoEsttrans =  .Estadotransferencia			lxDisimpoBdmodifw =  .Basededatosmodificacionfw			lxDisimpoHaltafw =  .Horaaltafw			lxDisimpoSmodifw =  .Seriemodificacionfw			lxDisimpoHoraexpo =  .Horaexpo			lxDisimpoHoraimpo =  .Horaimpo			lxDisimpoBdaltafw =  .Basededatosaltafw			lxDisimpoHmodifw =  .Horamodificacionfw			lxDisimpoSaltafw =  .Seriealtafw			lxDisimpoZadsfw =  .Zadsfw			lxDisimpoUmodifw =  .Usuariomodificacionfw			lxDisimpoVmodifw =  .Versionmodificacionfw			lxDisimpoValtafw =  .Versionaltafw			lxDisimpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpoBloqreg =  .Bloquearregistro			lxDisimpoClasehook =  .Clasehook			lxDisimpoCarchent =  .Archivoentrada			lxDisimpoAccsinaler =  .Accionconarchivoentradasinalertas			lxDisimpoCentidad =  .Entidad			lxDisimpoCcod =  .Codigo			lxDisimpoCmodo =  .Modo			lxDisimpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisimpoCrutaproc =  .Rutaprocesados			lxDisimpoCdes =  .Descripcion			lxDisimpoCanlincort =  .Cantidaddelineasdecorte			lxDisimpoAccconaler =  .Accionconarchivoentradaconalertas			lxDisimpoCcomando =  .Comando			lxDisimpoCrutaalert =  .Rutaalertas			lxDisimpoParcoma =  .Parametroscomando			lxDisimpoAccconerr =  .Accionconarchivoerrores			lxDisimpoCrutaerr =  .Rutaerrores			lxDisimpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisimpoCdelimi =  .Delimitadores			lxDisimpoIgnorini =  .Ignorarinicio			lxDisimpoIgnorfin =  .Ignorarfinal			lxDisimpoIgnorblanc =  .Ignorarlineasenblanco			lxDisimpoCbdatos =  .Basededatos			lxDisimpoCsololin =  .Sololineasqueempiezancon			lxDisimpoClinignor =  .Ignorarlineasqueempiezancon			lxDisimpoDetecdet =  .Detecciondetalle			lxDisimpoCobs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxDisimpoCcod = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ORGANIZACION.DISIMPO ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Ualtafw","Esttrans","Bdmodifw","Haltafw","Smodifw","Horaexpo","Horaimpo","Bdaltafw","Hmodifw","Saltafw","Zadsfw","Umodifw","Vmodifw","Valtafw","Timestamp","Bloqreg","Clasehook","Carchent","Accsinaler","Centidad","Ccod","Cmodo","Ctiparch","Crutaproc","Cdes","Canlincort","Accconaler","Ccomando","Crutaalert","Parcoma","Accconerr","Crutaerr","Ctipreg","Cdelimi","Ignorini","Ignorfin","Ignorblanc","Cbdatos","Csololin","Clinignor","Detecdet","Cobs" ) values ( <<"'" + this.ConvertirDateSql( lxDisimpoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoValtafw ) + "'" >>, <<lxDisimpoTimestamp >>, <<iif( lxDisimpoBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpoClasehook ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCarchent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoAccsinaler ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCentidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCmodo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCtiparch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCrutaproc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCdes ) + "'" >>, <<lxDisimpoCanlincort >>, <<"'" + this.FormatearTextoSql( lxDisimpoAccconaler ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCcomando ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCrutaalert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoParcoma ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoAccconerr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCrutaerr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCtipreg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCdelimi ) + "'" >>, <<lxDisimpoIgnorini >>, <<lxDisimpoIgnorfin >>, <<iif( lxDisimpoIgnorblanc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpoCbdatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCsololin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoClinignor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoDetecdet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					lxDetecciondetallevalor = loItem.Detecciondetallevalor
					lxCargaparcial = loItem.Cargaparcial
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoArea("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","nOrden","cDetDetall","lParcial" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxDetecciondetallevalor ) + "'">>, <<iif( lxCargaparcial, 1, 0 )>> ) 
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
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					lxCondicion_PK = loItem.Condicion_PK
					lxSubarea = loItem.Subarea
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoAtri("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato","cCondicion","cSubArea" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSubarea ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDisimpoTimestamp
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
				lcError  = this.oEntidad.ObtenerMensajeClaveCandidataExistente()
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
			local  lxDisimpoFecexpo, lxDisimpoFaltafw, lxDisimpoFecimpo, lxDisimpoFectrans, lxDisimpoFmodifw, lxDisimpoUaltafw, lxDisimpoEsttrans, lxDisimpoBdmodifw, lxDisimpoHaltafw, lxDisimpoSmodifw, lxDisimpoHoraexpo, lxDisimpoHoraimpo, lxDisimpoBdaltafw, lxDisimpoHmodifw, lxDisimpoSaltafw, lxDisimpoZadsfw, lxDisimpoUmodifw, lxDisimpoVmodifw, lxDisimpoValtafw, lxDisimpoTimestamp, lxDisimpoBloqreg, lxDisimpoClasehook, lxDisimpoCarchent, lxDisimpoAccsinaler, lxDisimpoCentidad, lxDisimpoCcod, lxDisimpoCmodo, lxDisimpoCtiparch, lxDisimpoCrutaproc, lxDisimpoCdes, lxDisimpoCanlincort, lxDisimpoAccconaler, lxDisimpoCcomando, lxDisimpoCrutaalert, lxDisimpoParcoma, lxDisimpoAccconerr, lxDisimpoCrutaerr, lxDisimpoCtipreg, lxDisimpoCdelimi, lxDisimpoIgnorini, lxDisimpoIgnorfin, lxDisimpoIgnorblanc, lxDisimpoCbdatos, lxDisimpoCsololin, lxDisimpoClinignor, lxDisimpoDetecdet, lxDisimpoCobs
				lxDisimpoFecexpo =  .Fechaexpo			lxDisimpoFaltafw =  .Fechaaltafw			lxDisimpoFecimpo =  .Fechaimpo			lxDisimpoFectrans =  .Fechatransferencia			lxDisimpoFmodifw =  .Fechamodificacionfw			lxDisimpoUaltafw =  .Usuarioaltafw			lxDisimpoEsttrans =  .Estadotransferencia			lxDisimpoBdmodifw =  .Basededatosmodificacionfw			lxDisimpoHaltafw =  .Horaaltafw			lxDisimpoSmodifw =  .Seriemodificacionfw			lxDisimpoHoraexpo =  .Horaexpo			lxDisimpoHoraimpo =  .Horaimpo			lxDisimpoBdaltafw =  .Basededatosaltafw			lxDisimpoHmodifw =  .Horamodificacionfw			lxDisimpoSaltafw =  .Seriealtafw			lxDisimpoZadsfw =  .Zadsfw			lxDisimpoUmodifw =  .Usuariomodificacionfw			lxDisimpoVmodifw =  .Versionmodificacionfw			lxDisimpoValtafw =  .Versionaltafw			lxDisimpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpoBloqreg =  .Bloquearregistro			lxDisimpoClasehook =  .Clasehook			lxDisimpoCarchent =  .Archivoentrada			lxDisimpoAccsinaler =  .Accionconarchivoentradasinalertas			lxDisimpoCentidad =  .Entidad			lxDisimpoCcod =  .Codigo			lxDisimpoCmodo =  .Modo			lxDisimpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisimpoCrutaproc =  .Rutaprocesados			lxDisimpoCdes =  .Descripcion			lxDisimpoCanlincort =  .Cantidaddelineasdecorte			lxDisimpoAccconaler =  .Accionconarchivoentradaconalertas			lxDisimpoCcomando =  .Comando			lxDisimpoCrutaalert =  .Rutaalertas			lxDisimpoParcoma =  .Parametroscomando			lxDisimpoAccconerr =  .Accionconarchivoerrores			lxDisimpoCrutaerr =  .Rutaerrores			lxDisimpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisimpoCdelimi =  .Delimitadores			lxDisimpoIgnorini =  .Ignorarinicio			lxDisimpoIgnorfin =  .Ignorarfinal			lxDisimpoIgnorblanc =  .Ignorarlineasenblanco			lxDisimpoCbdatos =  .Basededatos			lxDisimpoCsololin =  .Sololineasqueempiezancon			lxDisimpoClinignor =  .Ignorarlineasqueempiezancon			lxDisimpoDetecdet =  .Detecciondetalle			lxDisimpoCobs =  .Obs
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
				update ORGANIZACION.DISIMPO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDisimpoFecexpo ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxDisimpoFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxDisimpoFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxDisimpoFectrans ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxDisimpoFmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxDisimpoUaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxDisimpoEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoBdmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxDisimpoHaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoSmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxDisimpoHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxDisimpoHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDisimpoBdaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxDisimpoSaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxDisimpoZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoUmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoVmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxDisimpoValtafw ) + "'">>,"Timestamp" = <<lxDisimpoTimestamp>>,"Bloqreg" = <<iif( lxDisimpoBloqreg, 1, 0 )>>,"Clasehook" = <<"'" + this.FormatearTextoSql( lxDisimpoClasehook ) + "'">>,"Carchent" = <<"'" + this.FormatearTextoSql( lxDisimpoCarchent ) + "'">>,"Accsinaler" = <<"'" + this.FormatearTextoSql( lxDisimpoAccsinaler ) + "'">>,"Centidad" = <<"'" + this.FormatearTextoSql( lxDisimpoCentidad ) + "'">>,"Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'">>,"Cmodo" = <<"'" + this.FormatearTextoSql( lxDisimpoCmodo ) + "'">>,"Ctiparch" = <<"'" + this.FormatearTextoSql( lxDisimpoCtiparch ) + "'">>,"Crutaproc" = <<"'" + this.FormatearTextoSql( lxDisimpoCrutaproc ) + "'">>,"Cdes" = <<"'" + this.FormatearTextoSql( lxDisimpoCdes ) + "'">>,"Canlincort" = <<lxDisimpoCanlincort>>,"Accconaler" = <<"'" + this.FormatearTextoSql( lxDisimpoAccconaler ) + "'">>,"Ccomando" = <<"'" + this.FormatearTextoSql( lxDisimpoCcomando ) + "'">>,"Crutaalert" = <<"'" + this.FormatearTextoSql( lxDisimpoCrutaalert ) + "'">>,"Parcoma" = <<"'" + this.FormatearTextoSql( lxDisimpoParcoma ) + "'">>,"Accconerr" = <<"'" + this.FormatearTextoSql( lxDisimpoAccconerr ) + "'">>,"Crutaerr" = <<"'" + this.FormatearTextoSql( lxDisimpoCrutaerr ) + "'">>,"Ctipreg" = <<"'" + this.FormatearTextoSql( lxDisimpoCtipreg ) + "'">>,"Cdelimi" = <<"'" + this.FormatearTextoSql( lxDisimpoCdelimi ) + "'">>,"Ignorini" = <<lxDisimpoIgnorini>>,"Ignorfin" = <<lxDisimpoIgnorfin>>,"Ignorblanc" = <<iif( lxDisimpoIgnorblanc, 1, 0 )>>,"Cbdatos" = <<"'" + this.FormatearTextoSql( lxDisimpoCbdatos ) + "'">>,"Csololin" = <<"'" + this.FormatearTextoSql( lxDisimpoCsololin ) + "'">>,"Clinignor" = <<"'" + this.FormatearTextoSql( lxDisimpoClinignor ) + "'">>,"Detecdet" = <<"'" + this.FormatearTextoSql( lxDisimpoDetecdet ) + "'">>,"Cobs" = <<"'" + this.FormatearTextoSql( lxDisimpoCobs ) + "'">> where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'">> and  DISIMPO.CCOD != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisImpoArea where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisImpoAtri where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					lxDetecciondetallevalor = loItem.Detecciondetallevalor
					lxCargaparcial = loItem.Cargaparcial
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoArea("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","nOrden","cDetDetall","lParcial" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxDetecciondetallevalor ) + "'">>, <<iif( lxCargaparcial, 1, 0 )>> ) 
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
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					lxCondicion_PK = loItem.Condicion_PK
					lxSubarea = loItem.Subarea
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoAtri("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato","cCondicion","cSubArea" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSubarea ) + "'">> ) 
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
		this.oEntidad.Timestamp = lxDisimpoTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 cCod from ORGANIZACION.DISIMPO where " + this.ConvertirFuncionesSql( " DISIMPO.CCOD != ''" ) )
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
			Local lxDisimpoCcod
			lxDisimpoCcod = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs" from ORGANIZACION.DISIMPO where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'">> and  DISIMPO.CCOD != ''
			endtext
			use in select('c_DISENOIMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPO', set( 'Datasession' ) )

			if reccount( 'c_DISENOIMPO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial" from ORGANIZACION.DisImpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea" from ORGANIZACION.DisImpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Atributos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Atributos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Atributos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxDisImpoclasehook As Variant
			lxDisImpoclasehook = .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs" from ORGANIZACION.DISIMPO where  DISIMPO.CCOD != '' And clasehook = <<"'" + this.FormatearTextoSql( lxDisImpoclasehook ) + "'">>
			endtext
			use in select('c_DISENOIMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPO', set( 'Datasession' ) )
			if reccount( 'c_DISENOIMPO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial" from ORGANIZACION.DisImpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea" from ORGANIZACION.DisImpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by NroItem
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
		local llRetorno as boolean,lxDisimpoCcod as Variant
		llRetorno = .t.
		lxDisimpoCcod = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ORGANIZACION.DISIMPO where "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'">> and  DISIMPO.CCOD != ''
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs" from ORGANIZACION.DISIMPO where  DISIMPO.CCOD != '' order by clasehook
			endtext
			use in select('c_DISENOIMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial" from ORGANIZACION.DisImpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea" from ORGANIZACION.DisImpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs" from ORGANIZACION.DISIMPO where  funciones.padr( clasehook, 100, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISIMPO.CCOD != '' order by clasehook
			endtext
			use in select('c_DISENOIMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial" from ORGANIZACION.DisImpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea" from ORGANIZACION.DisImpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs" from ORGANIZACION.DISIMPO where  funciones.padr( clasehook, 100, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  DISIMPO.CCOD != '' order by clasehook desc
			endtext
			use in select('c_DISENOIMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial" from ORGANIZACION.DisImpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea" from ORGANIZACION.DisImpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by NroItem
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
				lcOrden =  .clasehook
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs" from ORGANIZACION.DISIMPO where  DISIMPO.CCOD != '' order by clasehook desc
			endtext
			use in select('c_DISENOIMPO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_DISENOIMPO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial" from ORGANIZACION.DisImpoArea where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by Orden
			endtext
			use in select('c_Areas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Areas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Areas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea" from ORGANIZACION.DisImpoAtri where iCod = <<"'" + this.FormatearTextoSql( c_DISENOIMPO.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Ualtafw,Esttrans,Bdmodifw,Haltafw,Smodifw,Horaexpo," + ;
"Horaimpo,Bdaltafw,Hmodifw,Saltafw,Zadsfw,Umodifw,Vmodifw,Valtafw,Timestamp,Bloqreg,Clasehook,Carchen" + ;
"t,Accsinaler,Centidad,Ccod,Cmodo,Ctiparch,Crutaproc,Cdes,Canlincort,Accconaler,Ccomando,Crutaalert,P" + ;
"arcoma,Accconerr,Crutaerr,Ctipreg,Cdelimi,Ignorini,Ignorfin,Ignorblanc,Cbdatos,Csololin,Clinignor,De" + ;
"tecdet,Cobs" + ;
" from ORGANIZACION.DISIMPO where  DISIMPO.CCOD != '' and " + lcFiltro )
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
			local  lxDisimpoFecexpo, lxDisimpoFaltafw, lxDisimpoFecimpo, lxDisimpoFectrans, lxDisimpoFmodifw, lxDisimpoUaltafw, lxDisimpoEsttrans, lxDisimpoBdmodifw, lxDisimpoHaltafw, lxDisimpoSmodifw, lxDisimpoHoraexpo, lxDisimpoHoraimpo, lxDisimpoBdaltafw, lxDisimpoHmodifw, lxDisimpoSaltafw, lxDisimpoZadsfw, lxDisimpoUmodifw, lxDisimpoVmodifw, lxDisimpoValtafw, lxDisimpoTimestamp, lxDisimpoBloqreg, lxDisimpoClasehook, lxDisimpoCarchent, lxDisimpoAccsinaler, lxDisimpoCentidad, lxDisimpoCcod, lxDisimpoCmodo, lxDisimpoCtiparch, lxDisimpoCrutaproc, lxDisimpoCdes, lxDisimpoCanlincort, lxDisimpoAccconaler, lxDisimpoCcomando, lxDisimpoCrutaalert, lxDisimpoParcoma, lxDisimpoAccconerr, lxDisimpoCrutaerr, lxDisimpoCtipreg, lxDisimpoCdelimi, lxDisimpoIgnorini, lxDisimpoIgnorfin, lxDisimpoIgnorblanc, lxDisimpoCbdatos, lxDisimpoCsololin, lxDisimpoClinignor, lxDisimpoDetecdet, lxDisimpoCobs
				lxDisimpoFecexpo = ctod( '  /  /    ' )			lxDisimpoFaltafw = ctod( '  /  /    ' )			lxDisimpoFecimpo = ctod( '  /  /    ' )			lxDisimpoFectrans = ctod( '  /  /    ' )			lxDisimpoFmodifw = ctod( '  /  /    ' )			lxDisimpoUaltafw = []			lxDisimpoEsttrans = []			lxDisimpoBdmodifw = []			lxDisimpoHaltafw = []			lxDisimpoSmodifw = []			lxDisimpoHoraexpo = []			lxDisimpoHoraimpo = []			lxDisimpoBdaltafw = []			lxDisimpoHmodifw = []			lxDisimpoSaltafw = []			lxDisimpoZadsfw = []			lxDisimpoUmodifw = []			lxDisimpoVmodifw = []			lxDisimpoValtafw = []			lxDisimpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpoBloqreg = .F.			lxDisimpoClasehook = []			lxDisimpoCarchent = []			lxDisimpoAccsinaler = []			lxDisimpoCentidad = []			lxDisimpoCcod = []			lxDisimpoCmodo = []			lxDisimpoCtiparch = []			lxDisimpoCrutaproc = []			lxDisimpoCdes = []			lxDisimpoCanlincort = 0			lxDisimpoAccconaler = []			lxDisimpoCcomando = []			lxDisimpoCrutaalert = []			lxDisimpoParcoma = []			lxDisimpoAccconerr = []			lxDisimpoCrutaerr = []			lxDisimpoCtipreg = []			lxDisimpoCdelimi = []			lxDisimpoIgnorini = 0			lxDisimpoIgnorfin = 0			lxDisimpoIgnorblanc = .F.			lxDisimpoCbdatos = []			lxDisimpoCsololin = []			lxDisimpoClinignor = []			lxDisimpoDetecdet = []			lxDisimpoCobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisImpoArea where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ORGANIZACION.DisImpoAtri where "iCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ORGANIZACION.DISIMPO where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'DISIMPO' + '_' + tcCampo
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
		lcWhere = " Where  DISIMPO.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DISIMPO', '', tnTope )
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
		lcWhere = " Where  DISIMPOAREA.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Norden" as "Orden", "Cdetdetall" as "Detecciondetallevalor", "Lparcial" as "Cargaparcial"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAreas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisImpoArea', 'Areas', tnTope )
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
	Function ObtenerDatosDetalleAtributos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  DISIMPOATRI.ICOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Bloqreg" as "Bloquearregistro", "Icod" as "Codigo", "Carea" as "Area", "Ctipo" as "Tipo", "Ctipdet" as "Tipodetalle", "Catributo" as "Atributo", "Norden" as "Orden", "Nlong" as "Ancho", "Cconv" as "Conversion", "Cformato" as "Formato", "Ccondicion" as "Condicion", "Csubarea" as "Subarea"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleAtributos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'DisImpoAtri', 'Atributos', tnTope )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'BLOQUEARREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BLOQREG AS BLOQUEARREGISTRO'
				Case lcAtributo == 'CLASEHOOK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASEHOOK AS CLASEHOOK'
				Case lcAtributo == 'ARCHIVOENTRADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CARCHENT AS ARCHIVOENTRADA'
				Case lcAtributo == 'ACCIONCONARCHIVOENTRADASINALERTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCSINALER AS ACCIONCONARCHIVOENTRADASINALERTAS'
				Case lcAtributo == 'ENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CENTIDAD AS ENTIDAD'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'MODO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CMODO AS MODO'
				Case lcAtributo == 'TIPOARCHIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPARCH AS TIPOARCHIVO'
				Case lcAtributo == 'RUTAPROCESADOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTAPROC AS RUTAPROCESADOS'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDES AS DESCRIPCION'
				Case lcAtributo == 'CANTIDADDELINEASDECORTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANLINCORT AS CANTIDADDELINEASDECORTE'
				Case lcAtributo == 'ACCIONCONARCHIVOENTRADACONALERTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCCONALER AS ACCIONCONARCHIVOENTRADACONALERTAS'
				Case lcAtributo == 'COMANDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOMANDO AS COMANDO'
				Case lcAtributo == 'RUTAALERTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTAALERT AS RUTAALERTAS'
				Case lcAtributo == 'PARAMETROSCOMANDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PARCOMA AS PARAMETROSCOMANDO'
				Case lcAtributo == 'ACCIONCONARCHIVOERRORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACCCONERR AS ACCIONCONARCHIVOERRORES'
				Case lcAtributo == 'RUTAERRORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CRUTAERR AS RUTAERRORES'
				Case lcAtributo == 'TIPOREGISTRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPREG AS TIPOREGISTRO'
				Case lcAtributo == 'DELIMITADORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDELIMI AS DELIMITADORES'
				Case lcAtributo == 'IGNORARINICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IGNORINI AS IGNORARINICIO'
				Case lcAtributo == 'IGNORARFINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IGNORFIN AS IGNORARFINAL'
				Case lcAtributo == 'IGNORARLINEASENBLANCO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IGNORBLANC AS IGNORARLINEASENBLANCO'
				Case lcAtributo == 'BASEDEDATOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBDATOS AS BASEDEDATOS'
				Case lcAtributo == 'SOLOLINEASQUEEMPIEZANCON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSOLOLIN AS SOLOLINEASQUEEMPIEZANCON'
				Case lcAtributo == 'IGNORARLINEASQUEEMPIEZANCON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLINIGNOR AS IGNORARLINEASQUEEMPIEZANCON'
				Case lcAtributo == 'DETECCIONDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DETECDET AS DETECCIONDETALLE'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COBS AS OBS'
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
				Case lcAtributo == 'TIPODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPDET AS TIPODETALLE'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORDEN AS ORDEN'
				Case lcAtributo == 'DETECCIONDETALLEVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CDETDETALL AS DETECCIONDETALLEVALOR'
				Case lcAtributo == 'CARGAPARCIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LPARCIAL AS CARGAPARCIAL'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTIPDET AS TIPODETALLE'
				Case lcAtributo == 'ATRIBUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATRIBUTO AS ATRIBUTO'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NORDEN AS ORDEN'
				Case lcAtributo == 'ANCHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NLONG AS ANCHO'
				Case lcAtributo == 'CONVERSION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONV AS CONVERSION'
				Case lcAtributo == 'FORMATO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CFORMATO AS FORMATO'
				Case lcAtributo == 'CONDICION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCONDICION AS CONDICION'
				Case lcAtributo == 'SUBAREA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CSUBAREA AS SUBAREA'
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
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'BLOQUEARREGISTRO'
				lcCampo = 'BLOQREG'
			Case upper( alltrim( tcAtributo ) ) == 'CLASEHOOK'
				lcCampo = 'CLASEHOOK'
			Case upper( alltrim( tcAtributo ) ) == 'ARCHIVOENTRADA'
				lcCampo = 'CARCHENT'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONCONARCHIVOENTRADASINALERTAS'
				lcCampo = 'ACCSINALER'
			Case upper( alltrim( tcAtributo ) ) == 'ENTIDAD'
				lcCampo = 'CENTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'MODO'
				lcCampo = 'CMODO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOARCHIVO'
				lcCampo = 'CTIPARCH'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAPROCESADOS'
				lcCampo = 'CRUTAPROC'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'CDES'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDADDELINEASDECORTE'
				lcCampo = 'CANLINCORT'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONCONARCHIVOENTRADACONALERTAS'
				lcCampo = 'ACCCONALER'
			Case upper( alltrim( tcAtributo ) ) == 'COMANDO'
				lcCampo = 'CCOMANDO'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAALERTAS'
				lcCampo = 'CRUTAALERT'
			Case upper( alltrim( tcAtributo ) ) == 'PARAMETROSCOMANDO'
				lcCampo = 'PARCOMA'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONCONARCHIVOERRORES'
				lcCampo = 'ACCCONERR'
			Case upper( alltrim( tcAtributo ) ) == 'RUTAERRORES'
				lcCampo = 'CRUTAERR'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOREGISTRO'
				lcCampo = 'CTIPREG'
			Case upper( alltrim( tcAtributo ) ) == 'DELIMITADORES'
				lcCampo = 'CDELIMI'
			Case upper( alltrim( tcAtributo ) ) == 'IGNORARINICIO'
				lcCampo = 'IGNORINI'
			Case upper( alltrim( tcAtributo ) ) == 'IGNORARFINAL'
				lcCampo = 'IGNORFIN'
			Case upper( alltrim( tcAtributo ) ) == 'IGNORARLINEASENBLANCO'
				lcCampo = 'IGNORBLANC'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOS'
				lcCampo = 'CBDATOS'
			Case upper( alltrim( tcAtributo ) ) == 'SOLOLINEASQUEEMPIEZANCON'
				lcCampo = 'CSOLOLIN'
			Case upper( alltrim( tcAtributo ) ) == 'IGNORARLINEASQUEEMPIEZANCON'
				lcCampo = 'CLINIGNOR'
			Case upper( alltrim( tcAtributo ) ) == 'DETECCIONDETALLE'
				lcCampo = 'DETECDET'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'COBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'TIPODETALLE'
				lcCampo = 'CTIPDET'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'NORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'DETECCIONDETALLEVALOR'
				lcCampo = 'CDETDETALL'
			Case upper( alltrim( tcAtributo ) ) == 'CARGAPARCIAL'
				lcCampo = 'LPARCIAL'
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
				lcCampo = 'CTIPDET'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTO'
				lcCampo = 'CATRIBUTO'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'NORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'ANCHO'
				lcCampo = 'NLONG'
			Case upper( alltrim( tcAtributo ) ) == 'CONVERSION'
				lcCampo = 'CCONV'
			Case upper( alltrim( tcAtributo ) ) == 'FORMATO'
				lcCampo = 'CFORMATO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICION'
				lcCampo = 'CCONDICION'
			Case upper( alltrim( tcAtributo ) ) == 'SUBAREA'
				lcCampo = 'CSUBAREA'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'AREAS'
			lcRetorno = 'DISIMPOAREA'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ATRIBUTOS'
			lcRetorno = 'DISIMPOATRI'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxDisimpoFecexpo, lxDisimpoFaltafw, lxDisimpoFecimpo, lxDisimpoFectrans, lxDisimpoFmodifw, lxDisimpoUaltafw, lxDisimpoEsttrans, lxDisimpoBdmodifw, lxDisimpoHaltafw, lxDisimpoSmodifw, lxDisimpoHoraexpo, lxDisimpoHoraimpo, lxDisimpoBdaltafw, lxDisimpoHmodifw, lxDisimpoSaltafw, lxDisimpoZadsfw, lxDisimpoUmodifw, lxDisimpoVmodifw, lxDisimpoValtafw, lxDisimpoTimestamp, lxDisimpoBloqreg, lxDisimpoClasehook, lxDisimpoCarchent, lxDisimpoAccsinaler, lxDisimpoCentidad, lxDisimpoCcod, lxDisimpoCmodo, lxDisimpoCtiparch, lxDisimpoCrutaproc, lxDisimpoCdes, lxDisimpoCanlincort, lxDisimpoAccconaler, lxDisimpoCcomando, lxDisimpoCrutaalert, lxDisimpoParcoma, lxDisimpoAccconerr, lxDisimpoCrutaerr, lxDisimpoCtipreg, lxDisimpoCdelimi, lxDisimpoIgnorini, lxDisimpoIgnorfin, lxDisimpoIgnorblanc, lxDisimpoCbdatos, lxDisimpoCsololin, lxDisimpoClinignor, lxDisimpoDetecdet, lxDisimpoCobs
				lxDisimpoFecexpo =  .Fechaexpo			lxDisimpoFaltafw =  .Fechaaltafw			lxDisimpoFecimpo =  .Fechaimpo			lxDisimpoFectrans =  .Fechatransferencia			lxDisimpoFmodifw =  .Fechamodificacionfw			lxDisimpoUaltafw =  .Usuarioaltafw			lxDisimpoEsttrans =  .Estadotransferencia			lxDisimpoBdmodifw =  .Basededatosmodificacionfw			lxDisimpoHaltafw =  .Horaaltafw			lxDisimpoSmodifw =  .Seriemodificacionfw			lxDisimpoHoraexpo =  .Horaexpo			lxDisimpoHoraimpo =  .Horaimpo			lxDisimpoBdaltafw =  .Basededatosaltafw			lxDisimpoHmodifw =  .Horamodificacionfw			lxDisimpoSaltafw =  .Seriealtafw			lxDisimpoZadsfw =  .Zadsfw			lxDisimpoUmodifw =  .Usuariomodificacionfw			lxDisimpoVmodifw =  .Versionmodificacionfw			lxDisimpoValtafw =  .Versionaltafw			lxDisimpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpoBloqreg =  .Bloquearregistro			lxDisimpoClasehook =  .Clasehook			lxDisimpoCarchent =  .Archivoentrada			lxDisimpoAccsinaler =  .Accionconarchivoentradasinalertas			lxDisimpoCentidad =  .Entidad			lxDisimpoCcod =  .Codigo			lxDisimpoCmodo =  .Modo			lxDisimpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisimpoCrutaproc =  .Rutaprocesados			lxDisimpoCdes =  .Descripcion			lxDisimpoCanlincort =  .Cantidaddelineasdecorte			lxDisimpoAccconaler =  .Accionconarchivoentradaconalertas			lxDisimpoCcomando =  .Comando			lxDisimpoCrutaalert =  .Rutaalertas			lxDisimpoParcoma =  .Parametroscomando			lxDisimpoAccconerr =  .Accionconarchivoerrores			lxDisimpoCrutaerr =  .Rutaerrores			lxDisimpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisimpoCdelimi =  .Delimitadores			lxDisimpoIgnorini =  .Ignorarinicio			lxDisimpoIgnorfin =  .Ignorarfinal			lxDisimpoIgnorblanc =  .Ignorarlineasenblanco			lxDisimpoCbdatos =  .Basededatos			lxDisimpoCsololin =  .Sololineasqueempiezancon			lxDisimpoClinignor =  .Ignorarlineasqueempiezancon			lxDisimpoDetecdet =  .Detecciondetalle			lxDisimpoCobs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ORGANIZACION.DISIMPO ( "Fecexpo","Faltafw","Fecimpo","Fectrans","Fmodifw","Ualtafw","Esttrans","Bdmodifw","Haltafw","Smodifw","Horaexpo","Horaimpo","Bdaltafw","Hmodifw","Saltafw","Zadsfw","Umodifw","Vmodifw","Valtafw","Timestamp","Bloqreg","Clasehook","Carchent","Accsinaler","Centidad","Ccod","Cmodo","Ctiparch","Crutaproc","Cdes","Canlincort","Accconaler","Ccomando","Crutaalert","Parcoma","Accconerr","Crutaerr","Ctipreg","Cdelimi","Ignorini","Ignorfin","Ignorblanc","Cbdatos","Csololin","Clinignor","Detecdet","Cobs" ) values ( <<"'" + this.ConvertirDateSql( lxDisimpoFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxDisimpoFmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoValtafw ) + "'" >>, <<lxDisimpoTimestamp >>, <<iif( lxDisimpoBloqreg, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpoClasehook ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCarchent ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoAccsinaler ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCentidad ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCmodo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCtiparch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCrutaproc ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCdes ) + "'" >>, <<lxDisimpoCanlincort >>, <<"'" + this.FormatearTextoSql( lxDisimpoAccconaler ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCcomando ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCrutaalert ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoParcoma ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoAccconerr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCrutaerr ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCtipreg ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCdelimi ) + "'" >>, <<lxDisimpoIgnorini >>, <<lxDisimpoIgnorfin >>, <<iif( lxDisimpoIgnorblanc, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxDisimpoCbdatos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCsololin ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoClinignor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoDetecdet ) + "'" >>, <<"'" + this.FormatearTextoSql( lxDisimpoCobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'DISIMPO' 
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
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					lxDetecciondetallevalor = loItem.Detecciondetallevalor
					lxCargaparcial = loItem.Cargaparcial
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoArea("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","nOrden","cDetDetall","lParcial" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxDetecciondetallevalor ) + "'">>, <<iif( lxCargaparcial, 1, 0 )>> ) 
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
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					lxCondicion_PK = loItem.Condicion_PK
					lxSubarea = loItem.Subarea
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoAtri("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato","cCondicion","cSubArea" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSubarea ) + "'">> ) 
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
			local  lxDisimpoFecexpo, lxDisimpoFaltafw, lxDisimpoFecimpo, lxDisimpoFectrans, lxDisimpoFmodifw, lxDisimpoUaltafw, lxDisimpoEsttrans, lxDisimpoBdmodifw, lxDisimpoHaltafw, lxDisimpoSmodifw, lxDisimpoHoraexpo, lxDisimpoHoraimpo, lxDisimpoBdaltafw, lxDisimpoHmodifw, lxDisimpoSaltafw, lxDisimpoZadsfw, lxDisimpoUmodifw, lxDisimpoVmodifw, lxDisimpoValtafw, lxDisimpoTimestamp, lxDisimpoBloqreg, lxDisimpoClasehook, lxDisimpoCarchent, lxDisimpoAccsinaler, lxDisimpoCentidad, lxDisimpoCcod, lxDisimpoCmodo, lxDisimpoCtiparch, lxDisimpoCrutaproc, lxDisimpoCdes, lxDisimpoCanlincort, lxDisimpoAccconaler, lxDisimpoCcomando, lxDisimpoCrutaalert, lxDisimpoParcoma, lxDisimpoAccconerr, lxDisimpoCrutaerr, lxDisimpoCtipreg, lxDisimpoCdelimi, lxDisimpoIgnorini, lxDisimpoIgnorfin, lxDisimpoIgnorblanc, lxDisimpoCbdatos, lxDisimpoCsololin, lxDisimpoClinignor, lxDisimpoDetecdet, lxDisimpoCobs
				lxDisimpoFecexpo =  .Fechaexpo			lxDisimpoFaltafw =  .Fechaaltafw			lxDisimpoFecimpo =  .Fechaimpo			lxDisimpoFectrans =  .Fechatransferencia			lxDisimpoFmodifw =  .Fechamodificacionfw			lxDisimpoUaltafw =  .Usuarioaltafw			lxDisimpoEsttrans =  .Estadotransferencia			lxDisimpoBdmodifw =  .Basededatosmodificacionfw			lxDisimpoHaltafw =  .Horaaltafw			lxDisimpoSmodifw =  .Seriemodificacionfw			lxDisimpoHoraexpo =  .Horaexpo			lxDisimpoHoraimpo =  .Horaimpo			lxDisimpoBdaltafw =  .Basededatosaltafw			lxDisimpoHmodifw =  .Horamodificacionfw			lxDisimpoSaltafw =  .Seriealtafw			lxDisimpoZadsfw =  .Zadsfw			lxDisimpoUmodifw =  .Usuariomodificacionfw			lxDisimpoVmodifw =  .Versionmodificacionfw			lxDisimpoValtafw =  .Versionaltafw			lxDisimpoTimestamp = goLibrerias.ObtenerTimestamp()			lxDisimpoBloqreg =  .Bloquearregistro			lxDisimpoClasehook =  .Clasehook			lxDisimpoCarchent =  .Archivoentrada			lxDisimpoAccsinaler =  .Accionconarchivoentradasinalertas			lxDisimpoCentidad =  .Entidad			lxDisimpoCcod =  .Codigo			lxDisimpoCmodo =  .Modo			lxDisimpoCtiparch =  upper( .TipoArchivo_PK ) 			lxDisimpoCrutaproc =  .Rutaprocesados			lxDisimpoCdes =  .Descripcion			lxDisimpoCanlincort =  .Cantidaddelineasdecorte			lxDisimpoAccconaler =  .Accionconarchivoentradaconalertas			lxDisimpoCcomando =  .Comando			lxDisimpoCrutaalert =  .Rutaalertas			lxDisimpoParcoma =  .Parametroscomando			lxDisimpoAccconerr =  .Accionconarchivoerrores			lxDisimpoCrutaerr =  .Rutaerrores			lxDisimpoCtipreg =  upper( .TipoRegistro_PK ) 			lxDisimpoCdelimi =  .Delimitadores			lxDisimpoIgnorini =  .Ignorarinicio			lxDisimpoIgnorfin =  .Ignorarfinal			lxDisimpoIgnorblanc =  .Ignorarlineasenblanco			lxDisimpoCbdatos =  .Basededatos			lxDisimpoCsololin =  .Sololineasqueempiezancon			lxDisimpoClinignor =  .Ignorarlineasqueempiezancon			lxDisimpoDetecdet =  .Detecciondetalle			lxDisimpoCobs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISIMPO.CCOD != '']
			text to lcSentencia noshow textmerge
				update ORGANIZACION.DISIMPO set "Fecexpo" = <<"'" + this.ConvertirDateSql( lxDisimpoFecexpo ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxDisimpoFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxDisimpoFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxDisimpoFectrans ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxDisimpoFmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxDisimpoUaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxDisimpoEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoBdmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxDisimpoHaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoSmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxDisimpoHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxDisimpoHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxDisimpoBdaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxDisimpoSaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxDisimpoZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoUmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxDisimpoVmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxDisimpoValtafw ) + "'">>, "Timestamp" = <<lxDisimpoTimestamp>>, "Bloqreg" = <<iif( lxDisimpoBloqreg, 1, 0 )>>, "Clasehook" = <<"'" + this.FormatearTextoSql( lxDisimpoClasehook ) + "'">>, "Carchent" = <<"'" + this.FormatearTextoSql( lxDisimpoCarchent ) + "'">>, "Accsinaler" = <<"'" + this.FormatearTextoSql( lxDisimpoAccsinaler ) + "'">>, "Centidad" = <<"'" + this.FormatearTextoSql( lxDisimpoCentidad ) + "'">>, "Ccod" = <<"'" + this.FormatearTextoSql( lxDisimpoCcod ) + "'">>, "Cmodo" = <<"'" + this.FormatearTextoSql( lxDisimpoCmodo ) + "'">>, "Ctiparch" = <<"'" + this.FormatearTextoSql( lxDisimpoCtiparch ) + "'">>, "Crutaproc" = <<"'" + this.FormatearTextoSql( lxDisimpoCrutaproc ) + "'">>, "Cdes" = <<"'" + this.FormatearTextoSql( lxDisimpoCdes ) + "'">>, "Canlincort" = <<lxDisimpoCanlincort>>, "Accconaler" = <<"'" + this.FormatearTextoSql( lxDisimpoAccconaler ) + "'">>, "Ccomando" = <<"'" + this.FormatearTextoSql( lxDisimpoCcomando ) + "'">>, "Crutaalert" = <<"'" + this.FormatearTextoSql( lxDisimpoCrutaalert ) + "'">>, "Parcoma" = <<"'" + this.FormatearTextoSql( lxDisimpoParcoma ) + "'">>, "Accconerr" = <<"'" + this.FormatearTextoSql( lxDisimpoAccconerr ) + "'">>, "Crutaerr" = <<"'" + this.FormatearTextoSql( lxDisimpoCrutaerr ) + "'">>, "Ctipreg" = <<"'" + this.FormatearTextoSql( lxDisimpoCtipreg ) + "'">>, "Cdelimi" = <<"'" + this.FormatearTextoSql( lxDisimpoCdelimi ) + "'">>, "Ignorini" = <<lxDisimpoIgnorini>>, "Ignorfin" = <<lxDisimpoIgnorfin>>, "Ignorblanc" = <<iif( lxDisimpoIgnorblanc, 1, 0 )>>, "Cbdatos" = <<"'" + this.FormatearTextoSql( lxDisimpoCbdatos ) + "'">>, "Csololin" = <<"'" + this.FormatearTextoSql( lxDisimpoCsololin ) + "'">>, "Clinignor" = <<"'" + this.FormatearTextoSql( lxDisimpoClinignor ) + "'">>, "Detecdet" = <<"'" + this.FormatearTextoSql( lxDisimpoDetecdet ) + "'">>, "Cobs" = <<"'" + this.FormatearTextoSql( lxDisimpoCobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'DISIMPO' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ORGANIZACION.DisImpoArea where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DisImpoAtri where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Areas
				if this.oEntidad.Areas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxBloquearregistro = this.oEntidad.BLOQUEARREGISTRO
					lxArea = loItem.Area
					lxTipo_PK = loItem.Tipo_PK
					lxTipodetalle = loItem.Tipodetalle
					lxOrden = loItem.Orden
					lxDetecciondetallevalor = loItem.Detecciondetallevalor
					lxCargaparcial = loItem.Cargaparcial
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoArea("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","nOrden","cDetDetall","lParcial" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxDetecciondetallevalor ) + "'">>, <<iif( lxCargaparcial, 1, 0 )>> ) 
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
					lxAtributo = loItem.Atributo
					lxOrden = loItem.Orden
					lxAncho = loItem.Ancho
					lxConversion_PK = loItem.Conversion_PK
					lxFormato_PK = loItem.Formato_PK
					lxCondicion_PK = loItem.Condicion_PK
					lxSubarea = loItem.Subarea
					Text to lcCadena noshow textmerge
						Insert into ORGANIZACION.DisImpoAtri("NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato","cCondicion","cSubArea" ) values ( <<lxNroitem>>, <<iif( lxBloquearregistro, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArea ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributo ) + "'">>, <<lxOrden>>, <<lxAncho>>, <<"'" + this.FormatearTextoSql( lxConversion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxFormato_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondicion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSubarea ) + "'">> ) 
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

			lcFiltro = ["Ccod" = ] + lcValorClavePrimariaString  + [ and  DISIMPO.CCOD != '']
		loColeccion.Agregar( 'delete from ORGANIZACION.DISIMPO where ' + lcFiltro )
			loColeccion.Agregar([delete from ORGANIZACION.DisImpoArea where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ORGANIZACION.DisImpoAtri where "iCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'DISIMPO' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ORGANIZACION.DISIMPO where  DISIMPO.CCOD != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ORGANIZACION.DISIMPO where cCod = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  DISIMPO.CCOD != ''" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxDisImpoclasehook as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPO'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ORGANIZACION.DISIMPO Where  clasehook = ] + "'" + this.FormatearTextoSql( &lcCursor..clasehook  ) + "'", 'curSeek', this.datasessionid )
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
						this.oConexion.EjecutarSql( [UPDATE ORGANIZACION.DISIMPO set  FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, BLOQREG = ] + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))+ [, clasehook = ] + "'" + this.FormatearTextoSql( &lcCursor..clasehook ) + "'"+ [, cArchEnt = ] + "'" + this.FormatearTextoSql( &lcCursor..cArchEnt ) + "'"+ [, AccSinAler = ] + "'" + this.FormatearTextoSql( &lcCursor..AccSinAler ) + "'"+ [, cEntidad = ] + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'"+ [, cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'"+ [, cModo = ] + "'" + this.FormatearTextoSql( &lcCursor..cModo ) + "'"+ [, cTipArch = ] + "'" + this.FormatearTextoSql( &lcCursor..cTipArch ) + "'"+ [, cRutaProc = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaProc ) + "'"+ [, cDes = ] + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'"+ [, CanLinCort = ] + transform( &lcCursor..CanLinCort )+ [, AccConAler = ] + "'" + this.FormatearTextoSql( &lcCursor..AccConAler ) + "'"+ [, cComando = ] + "'" + this.FormatearTextoSql( &lcCursor..cComando ) + "'"+ [, cRutaAlert = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaAlert ) + "'"+ [, ParComa = ] + "'" + this.FormatearTextoSql( &lcCursor..ParComa ) + "'"+ [, AccConErr = ] + "'" + this.FormatearTextoSql( &lcCursor..AccConErr ) + "'"+ [, cRutaErr = ] + "'" + this.FormatearTextoSql( &lcCursor..cRutaErr ) + "'"+ [, cTipReg = ] + "'" + this.FormatearTextoSql( &lcCursor..cTipReg ) + "'"+ [, cDelimi = ] + "'" + this.FormatearTextoSql( &lcCursor..cDelimi ) + "'"+ [, IgnorIni = ] + transform( &lcCursor..IgnorIni )+ [, IgnorFin = ] + transform( &lcCursor..IgnorFin )+ [, IgnorBlanc = ] + Transform( iif( &lcCursor..IgnorBlanc, 1, 0 ))+ [, cBdatos = ] + "'" + this.FormatearTextoSql( &lcCursor..cBdatos ) + "'"+ [, cSoloLin = ] + "'" + this.FormatearTextoSql( &lcCursor..cSoloLin ) + "'"+ [, cLinIgnor = ] + "'" + this.FormatearTextoSql( &lcCursor..cLinIgnor ) + "'"+ [, DetecDet = ] + "'" + this.FormatearTextoSql( &lcCursor..DetecDet ) + "'"+ [, cObs = ] + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'" + [ Where cCod = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ORGANIZACION.DISIMPO Where cCod = ] + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECEXPO, FALTAFW, FECIMPO, FECTRANS, FMODIFW, UALTAFW, ESTTRANS, BDMODIFW, HALTAFW, SMODIFW, HORAEXPO, HORAIMPO, BDALTAFW, HMODIFW, SALTAFW, ZADSFW, UMODIFW, VMODIFW, VALTAFW, TIMESTAMP, BLOQREG, clasehook, cArchEnt, AccSinAler, cEntidad, cCod, cModo, cTipArch, cRutaProc, cDes, CanLinCort, AccConAler, cComando, cRutaAlert, ParComa, AccConErr, cRutaErr, cTipReg, cDelimi, IgnorIni, IgnorFin, IgnorBlanc, cBdatos, cSoloLin, cLinIgnor, DetecDet, cObs
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + Transform( iif( &lcCursor..BLOQREG, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..clasehook ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cArchEnt ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..AccSinAler ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cEntidad ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cCod ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cModo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cTipArch ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutaProc ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDes ) + "'" + ',' + transform( &lcCursor..CanLinCort ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..AccConAler ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cComando ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutaAlert ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ParComa ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..AccConErr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cRutaErr ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cTipReg ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cDelimi ) + "'" + ',' + transform( &lcCursor..IgnorIni ) + ',' + transform( &lcCursor..IgnorFin ) + ',' + Transform( iif( &lcCursor..IgnorBlanc, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..cBdatos ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..cSoloLin ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cLinIgnor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DetecDet ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..cObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DISIMPO ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPO'
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
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DisImpoArea Where iCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ORGANIZACION.DisImpoAtri Where iCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMAREASIMPO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","nOrden","cDetDetall","lParcial"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DisImpoArea ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cArea      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipo      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipDet    ) + "'" + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cDetDetall ) + "'" + ',' + Transform( iif( cDetallesExistentes.lParcial  , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMATRIBUTOSIMPO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where iCod in ( select cCod from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","BLOQREG","iCod","cArea","cTipo","cTipDet","cAtributo","nOrden","nLong","cConv","cFormato","cCondicion","cSubArea"
		endText
		this.oConexion.EjecutarSql( [Insert into ORGANIZACION.DisImpoAtri ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + Transform( iif( cDetallesExistentes.BLOQREG   , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cArea      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipo      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTipDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cAtributo  ) + "'" + ',' + transform( cDetallesExistentes.nOrden     ) + ',' + transform( cDetallesExistentes.nLong      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cConv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cFormato   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCondicion ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cSubArea   ) + "'" + ' )'  )
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
		lcRetorno = lcRetorno + ' - Clase hook: ' + transform( &tcCursor..clasehook  )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'DISENOIMPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOIMPO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'DISENOIMPO_COBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMAREASIMPO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMATRIBUTOSIMPO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ORGANIZACION.TablaTrabajo_DisImpo')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'DISENOIMPO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..cCod
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..clasehook )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad DISENOIMPO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,cCod as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( cCod, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,clasehook as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( clasehook, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_DisImpo') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_DisImpo
Create Table ORGANIZACION.TablaTrabajo_DisImpo ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecexpo" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fmodifw" datetime  null, 
"ualtafw" char( 100 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"valtafw" char( 13 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"bloqreg" bit  null, 
"clasehook" char( 100 )  null, 
"carchent" char( 254 )  null, 
"accsinaler" char( 20 )  null, 
"centidad" char( 40 )  null, 
"ccod" char( 40 )  null, 
"cmodo" char( 16 )  null, 
"ctiparch" char( 3 )  null, 
"crutaproc" char( 254 )  null, 
"cdes" char( 100 )  null, 
"canlincort" numeric( 3, 0 )  null, 
"accconaler" char( 20 )  null, 
"ccomando" char( 254 )  null, 
"crutaalert" char( 254 )  null, 
"parcoma" char( 254 )  null, 
"accconerr" char( 20 )  null, 
"crutaerr" char( 254 )  null, 
"ctipreg" char( 3 )  null, 
"cdelimi" char( 40 )  null, 
"ignorini" numeric( 2, 0 )  null, 
"ignorfin" numeric( 2, 0 )  null, 
"ignorblanc" bit  null, 
"cbdatos" char( 8 )  null, 
"csololin" char( 20 )  null, 
"clinignor" char( 20 )  null, 
"detecdet" char( 25 )  null, 
"cobs" varchar(max)  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_DisImpo' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_DisImpo' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'DISENOIMPO'
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
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('bloqreg','bloqreg')
			.AgregarMapeo('clasehook','clasehook')
			.AgregarMapeo('carchent','carchent')
			.AgregarMapeo('accsinaler','accsinaler')
			.AgregarMapeo('centidad','centidad')
			.AgregarMapeo('ccod','ccod')
			.AgregarMapeo('cmodo','cmodo')
			.AgregarMapeo('ctiparch','ctiparch')
			.AgregarMapeo('crutaproc','crutaproc')
			.AgregarMapeo('cdes','cdes')
			.AgregarMapeo('canlincort','canlincort')
			.AgregarMapeo('accconaler','accconaler')
			.AgregarMapeo('ccomando','ccomando')
			.AgregarMapeo('crutaalert','crutaalert')
			.AgregarMapeo('parcoma','parcoma')
			.AgregarMapeo('accconerr','accconerr')
			.AgregarMapeo('crutaerr','crutaerr')
			.AgregarMapeo('ctipreg','ctipreg')
			.AgregarMapeo('cdelimi','cdelimi')
			.AgregarMapeo('ignorini','ignorini')
			.AgregarMapeo('ignorfin','ignorfin')
			.AgregarMapeo('ignorblanc','ignorblanc')
			.AgregarMapeo('cbdatos','cbdatos')
			.AgregarMapeo('csololin','csololin')
			.AgregarMapeo('clinignor','clinignor')
			.AgregarMapeo('detecdet','detecdet')
			.AgregarMapeo('cobs','cobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ORGANIZACION.TablaTrabajo_DisImpo'
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
				Update t Set t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),t.CLASEHOOK = isnull( d.CLASEHOOK, t.CLASEHOOK ),t.CARCHENT = isnull( d.CARCHENT, t.CARCHENT ),t.ACCSINALER = isnull( d.ACCSINALER, t.ACCSINALER ),t.CENTIDAD = isnull( d.CENTIDAD, t.CENTIDAD ),t.CCOD = isnull( d.CCOD, t.CCOD ),t.CMODO = isnull( d.CMODO, t.CMODO ),t.CTIPARCH = isnull( d.CTIPARCH, t.CTIPARCH ),t.CRUTAPROC = isnull( d.CRUTAPROC, t.CRUTAPROC ),t.CDES = isnull( d.CDES, t.CDES ),t.CANLINCORT = isnull( d.CANLINCORT, t.CANLINCORT ),t.ACCCONALER = isnull( d.ACCCONALER, t.ACCCONALER ),t.CCOMANDO = isnull( d.CCOMANDO, t.CCOMANDO ),t.CRUTAALERT = isnull( d.CRUTAALERT, t.CRUTAALERT ),t.PARCOMA = isnull( d.PARCOMA, t.PARCOMA ),t.ACCCONERR = isnull( d.ACCCONERR, t.ACCCONERR ),t.CRUTAERR = isnull( d.CRUTAERR, t.CRUTAERR ),t.CTIPREG = isnull( d.CTIPREG, t.CTIPREG ),t.CDELIMI = isnull( d.CDELIMI, t.CDELIMI ),t.IGNORINI = isnull( d.IGNORINI, t.IGNORINI ),t.IGNORFIN = isnull( d.IGNORFIN, t.IGNORFIN ),t.IGNORBLANC = isnull( d.IGNORBLANC, t.IGNORBLANC ),t.CBDATOS = isnull( d.CBDATOS, t.CBDATOS ),t.CSOLOLIN = isnull( d.CSOLOLIN, t.CSOLOLIN ),t.CLINIGNOR = isnull( d.CLINIGNOR, t.CLINIGNOR ),t.DETECDET = isnull( d.DETECDET, t.DETECDET ),t.COBS = isnull( d.COBS, t.COBS )
					from ORGANIZACION.DISIMPO t inner join deleted d 
							 on t.cCod = d.cCod
							 and  t.clasehook = d.clasehook
				-- Fin Updates
				insert into ORGANIZACION.DISIMPO(Fecexpo,Faltafw,Fecimpo,Fectrans,Fmodifw,Ualtafw,Esttrans,Bdmodifw,Haltafw,Smodifw,Horaexpo,Horaimpo,Bdaltafw,Hmodifw,Saltafw,Zadsfw,Umodifw,Vmodifw,Valtafw,Timestamp,Bloqreg,Clasehook,Carchent,Accsinaler,Centidad,Ccod,Cmodo,Ctiparch,Crutaproc,Cdes,Canlincort,Accconaler,Ccomando,Crutaalert,Parcoma,Accconerr,Crutaerr,Ctipreg,Cdelimi,Ignorini,Ignorfin,Ignorblanc,Cbdatos,Csololin,Clinignor,Detecdet,Cobs)
					Select isnull( d.FECEXPO,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FMODIFW,''),isnull( d.UALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.SMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VMODIFW,''),isnull( d.VALTAFW,''),isnull( d.TIMESTAMP,0),isnull( d.BLOQREG,0),isnull( d.CLASEHOOK,''),isnull( d.CARCHENT,''),isnull( d.ACCSINALER,''),isnull( d.CENTIDAD,''),isnull( d.CCOD,''),isnull( d.CMODO,''),isnull( d.CTIPARCH,''),isnull( d.CRUTAPROC,''),isnull( d.CDES,''),isnull( d.CANLINCORT,0),isnull( d.ACCCONALER,''),isnull( d.CCOMANDO,''),isnull( d.CRUTAALERT,''),isnull( d.PARCOMA,''),isnull( d.ACCCONERR,''),isnull( d.CRUTAERR,''),isnull( d.CTIPREG,''),isnull( d.CDELIMI,''),isnull( d.IGNORINI,0),isnull( d.IGNORFIN,0),isnull( d.IGNORBLANC,0),isnull( d.CBDATOS,''),isnull( d.CSOLOLIN,''),isnull( d.CLINIGNOR,''),isnull( d.DETECDET,''),isnull( d.COBS,'')
						From deleted d left join ORGANIZACION.DISIMPO pk 
							 on d.cCod = pk.cCod
						 left join ORGANIZACION.DISIMPO cc 
							 on  d.clasehook = cc.clasehook
						Where pk.cCod Is Null 
							 and cc.clasehook Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CLASE HOOK ' + cast( d.clasehook as Varchar(100) ) + '','La clave principal no es la esperada'
					from ORGANIZACION.DISIMPO t inner join deleted d 
							on   t.clasehook = d.clasehook
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: CLASE HOOK ' + cast( d.clasehook as Varchar(100) ) + '','La clave principal a importar ya existe'
					from ORGANIZACION.DISIMPO t inner join deleted d 
							 on t.cCod = d.cCod
						left join deleted h 
							on   t.clasehook = h.clasehook
							where   h.clasehook is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisImpoArea( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_DISIMPO_DisImpoArea
ON ORGANIZACION.TablaTrabajo_DISIMPO_DisImpoArea
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CAREA = isnull( d.CAREA, t.CAREA ),
t.CTIPO = isnull( d.CTIPO, t.CTIPO ),
t.CTIPDET = isnull( d.CTIPDET, t.CTIPDET ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.CDETDETALL = isnull( d.CDETDETALL, t.CDETDETALL ),
t.LPARCIAL = isnull( d.LPARCIAL, t.LPARCIAL )
from ORGANIZACION.DisImpoArea t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DisImpoArea
( 
"NROITEM",
"BLOQREG",
"ICOD",
"CAREA",
"CTIPO",
"CTIPDET",
"NORDEN",
"CDETDETALL",
"LPARCIAL"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.CAREA,
d.CTIPO,
d.CTIPDET,
d.NORDEN,
d.CDETDETALL,
d.LPARCIAL
From deleted d left join ORGANIZACION.DisImpoArea pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_DisImpoAtri( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ORGANIZACION.DELETE_TablaTrabajo_DISIMPO_DisImpoAtri
ON ORGANIZACION.TablaTrabajo_DISIMPO_DisImpoAtri
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.BLOQREG = isnull( d.BLOQREG, t.BLOQREG ),
t.ICOD = isnull( d.ICOD, t.ICOD ),
t.CAREA = isnull( d.CAREA, t.CAREA ),
t.CTIPO = isnull( d.CTIPO, t.CTIPO ),
t.CTIPDET = isnull( d.CTIPDET, t.CTIPDET ),
t.CATRIBUTO = isnull( d.CATRIBUTO, t.CATRIBUTO ),
t.NORDEN = isnull( d.NORDEN, t.NORDEN ),
t.NLONG = isnull( d.NLONG, t.NLONG ),
t.CCONV = isnull( d.CCONV, t.CCONV ),
t.CFORMATO = isnull( d.CFORMATO, t.CFORMATO ),
t.CCONDICION = isnull( d.CCONDICION, t.CCONDICION ),
t.CSUBAREA = isnull( d.CSUBAREA, t.CSUBAREA )
from ORGANIZACION.DisImpoAtri t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ORGANIZACION.DisImpoAtri
( 
"NROITEM",
"BLOQREG",
"ICOD",
"CAREA",
"CTIPO",
"CTIPDET",
"CATRIBUTO",
"NORDEN",
"NLONG",
"CCONV",
"CFORMATO",
"CCONDICION",
"CSUBAREA"
 )
Select 
d.NROITEM,
d.BLOQREG,
d.ICOD,
d.CAREA,
d.CTIPO,
d.CTIPDET,
d.CATRIBUTO,
d.NORDEN,
d.NLONG,
d.CCONV,
d.CFORMATO,
d.CCONDICION,
d.CSUBAREA
From deleted d left join ORGANIZACION.DisImpoAtri pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ORGANIZACION.TablaTrabajo_DisImpo') AND type in ('U')) DROP TABLE ORGANIZACION.TablaTrabajo_DisImpo
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_DISENOIMPO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_DISENOIMPO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Usuarioaltafw = nvl( c_DISENOIMPO.Usuarioaltafw, [] )
					.Estadotransferencia = nvl( c_DISENOIMPO.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_DISENOIMPO.Basededatosmodificacionfw, [] )
					.Horaaltafw = nvl( c_DISENOIMPO.Horaaltafw, [] )
					.Seriemodificacionfw = nvl( c_DISENOIMPO.Seriemodificacionfw, [] )
					.Horaexpo = nvl( c_DISENOIMPO.Horaexpo, [] )
					.Horaimpo = nvl( c_DISENOIMPO.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_DISENOIMPO.Basededatosaltafw, [] )
					.Horamodificacionfw = nvl( c_DISENOIMPO.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_DISENOIMPO.Seriealtafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_DISENOIMPO.Usuariomodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_DISENOIMPO.Versionmodificacionfw, [] )
					.Versionaltafw = nvl( c_DISENOIMPO.Versionaltafw, [] )
					.Timestamp = nvl( c_DISENOIMPO.Timestamp, 0 )
					.Bloquearregistro = nvl( c_DISENOIMPO.Bloquearregistro, .F. )
					.Clasehook = nvl( c_DISENOIMPO.Clasehook, [] )
					.Archivoentrada = nvl( c_DISENOIMPO.Archivoentrada, [] )
					.Accionconarchivoentradasinalertas = nvl( c_DISENOIMPO.Accionconarchivoentradasinalertas, [] )
					.Entidad = nvl( c_DISENOIMPO.Entidad, [] )
					.Codigo = nvl( c_DISENOIMPO.Codigo, [] )
					.Modo = nvl( c_DISENOIMPO.Modo, [] )
					.Tipoarchivo_PK =  nvl( c_DISENOIMPO.Tipoarchivo, [] )
					.Rutaprocesados = nvl( c_DISENOIMPO.Rutaprocesados, [] )
					.Descripcion = nvl( c_DISENOIMPO.Descripcion, [] )
					.Cantidaddelineasdecorte = nvl( c_DISENOIMPO.Cantidaddelineasdecorte, 0 )
					.Accionconarchivoentradaconalertas = nvl( c_DISENOIMPO.Accionconarchivoentradaconalertas, [] )
					.Comando = nvl( c_DISENOIMPO.Comando, [] )
					.Rutaalertas = nvl( c_DISENOIMPO.Rutaalertas, [] )
					.Parametroscomando = nvl( c_DISENOIMPO.Parametroscomando, [] )
					.Accionconarchivoerrores = nvl( c_DISENOIMPO.Accionconarchivoerrores, [] )
					.Rutaerrores = nvl( c_DISENOIMPO.Rutaerrores, [] )
					.Tiporegistro_PK =  nvl( c_DISENOIMPO.Tiporegistro, [] )
					.Delimitadores = nvl( c_DISENOIMPO.Delimitadores, [] )
					.Ignorarinicio = nvl( c_DISENOIMPO.Ignorarinicio, 0 )
					.Ignorarfinal = nvl( c_DISENOIMPO.Ignorarfinal, 0 )
					.Ignorarlineasenblanco = nvl( c_DISENOIMPO.Ignorarlineasenblanco, .F. )
					.Basededatos = nvl( c_DISENOIMPO.Basededatos, [] )
					.Sololineasqueempiezancon = nvl( c_DISENOIMPO.Sololineasqueempiezancon, [] )
					.Ignorarlineasqueempiezancon = nvl( c_DISENOIMPO.Ignorarlineasqueempiezancon, [] )
					.Detecciondetalle = nvl( c_DISENOIMPO.Detecciondetalle, [] )
					.Areas.Limpiar()
					.Areas.SetearEsNavegacion( .lProcesando )
					.Areas.Cargar()
					.Atributos.Limpiar()
					.Atributos.SetearEsNavegacion( .lProcesando )
					.Atributos.Cargar()
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
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
			lxRetorno = c_DISENOIMPO.CODIGO
		endif
		return lxRetorno
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
		return c_DISENOIMPO.&lcAtributo
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
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID('<<lcNombreBD>>') AND OBJECT_ID=OBJECT_ID( '<<lcNombreBD>>.ORGANIZACION.DISIMPO' )
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
								from ORGANIZACION.DISIMPO 
								Where   DISIMPO.CCOD != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "DISIMPO", "", lcCursor, set("Datasession") )
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
			"Fecexpo" as "Fechaexpo", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fmodifw" as "Fechamodificacionfw", "Ualtafw" as "Usuarioaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Haltafw" as "Horaaltafw", "Smodifw" as "Seriemodificacionfw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Valtafw" as "Versionaltafw", "Timestamp" as "Timestamp", "Bloqreg" as "Bloquearregistro", "Clasehook" as "Clasehook", "Carchent" as "Archivoentrada", "Accsinaler" as "Accionconarchivoentradasinalertas", "Centidad" as "Entidad", "Ccod" as "Codigo", "Cmodo" as "Modo", "Ctiparch" as "Tipoarchivo", "Crutaproc" as "Rutaprocesados", "Cdes" as "Descripcion", "Canlincort" as "Cantidaddelineasdecorte", "Accconaler" as "Accionconarchivoentradaconalertas", "Ccomando" as "Comando", "Crutaalert" as "Rutaalertas", "Parcoma" as "Parametroscomando", "Accconerr" as "Accionconarchivoerrores", "Crutaerr" as "Rutaerrores", "Ctipreg" as "Tiporegistro", "Cdelimi" as "Delimitadores", "Ignorini" as "Ignorarinicio", "Ignorfin" as "Ignorarfinal", "Ignorblanc" as "Ignorarlineasenblanco", "Cbdatos" as "Basededatos", "Csololin" as "Sololineasqueempiezancon", "Clinignor" as "Ignorarlineasqueempiezancon", "Detecdet" as "Detecciondetalle", "Cobs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ORGANIZACION.DISIMPO 
								Where   DISIMPO.CCOD != ''
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
	Tabla = 'DISIMPO'
	Filtro = " DISIMPO.CCOD != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " DISIMPO.CCOD != ''"
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
	<row entidad="DISENOIMPO                              " atributo="FECHAEXPO                               " tabla="DISIMPO        " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="FECHAALTAFW                             " tabla="DISIMPO        " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="FECHAIMPO                               " tabla="DISIMPO        " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="FECHATRANSFERENCIA                      " tabla="DISIMPO        " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="FECHAMODIFICACIONFW                     " tabla="DISIMPO        " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="USUARIOALTAFW                           " tabla="DISIMPO        " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ESTADOTRANSFERENCIA                     " tabla="DISIMPO        " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="DISIMPO        " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="HORAALTAFW                              " tabla="DISIMPO        " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="SERIEMODIFICACIONFW                     " tabla="DISIMPO        " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="HORAEXPO                                " tabla="DISIMPO        " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="HORAIMPO                                " tabla="DISIMPO        " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="BASEDEDATOSALTAFW                       " tabla="DISIMPO        " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="HORAMODIFICACIONFW                      " tabla="DISIMPO        " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="SERIEALTAFW                             " tabla="DISIMPO        " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ZADSFW                                  " tabla="DISIMPO        " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="USUARIOMODIFICACIONFW                   " tabla="DISIMPO        " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="VERSIONMODIFICACIONFW                   " tabla="DISIMPO        " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="VERSIONALTAFW                           " tabla="DISIMPO        " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="TIMESTAMP                               " tabla="DISIMPO        " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="BLOQUEARREGISTRO                        " tabla="DISIMPO        " campo="BLOQREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="CLASEHOOK                               " tabla="DISIMPO        " campo="CLASEHOOK " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Clase hook                                                                                                                                                      " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ARCHIVOENTRADA                          " tabla="DISIMPO        " campo="CARCHENT  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Archivo entrada                                                                                                                                                 " dominio="ARCHIVO                       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ACCIONCONARCHIVOENTRADASINALERTAS       " tabla="DISIMPO        " campo="ACCSINALER" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="= &quot;NADA&quot;                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="402" etiqueta="Sin alertas                                                                                                                                                     " dominio="COMBOACCIONSINALERTAS         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ENTIDAD                                 " tabla="DISIMPO        " campo="CENTIDAD  " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Entidad                                                                                                                                                         " dominio="COMBOENTIDADESIMPO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="CODIGO                                  " tabla="DISIMPO        " campo="CCOD      " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="MODO                                    " tabla="DISIMPO        " campo="CMODO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="404" etiqueta="Modo                                                                                                                                                            " dominio="COMBOMODOIMPO                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="TIPOARCHIVO                             " tabla="DISIMPO        " campo="CTIPARCH  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOARCHIVOIMPORTACION                  " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="406" etiqueta="Tipo archivo importación                                                                                                                                        " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="RUTAPROCESADOS                          " tabla="DISIMPO        " campo="CRUTAPROC " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Ruta sin alertas                                                                                                                                                " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="DESCRIPCION                             " tabla="DISIMPO        " campo="CDES      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="CANTIDADDELINEASDECORTE                 " tabla="DISIMPO        " campo="CANLINCORT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Líneas de corte                                                                                                                                                 " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99                       " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ACCIONCONARCHIVOENTRADACONALERTAS       " tabla="DISIMPO        " campo="ACCCONALER" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="= &quot;NADA&quot;                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="412" etiqueta="Con alertas                                                                                                                                                     " dominio="COMBOACCIONCONALERTAS         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="COMANDO                                 " tabla="DISIMPO        " campo="CCOMANDO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Archivo aplicación                                                                                                                                              " dominio="ARCHIVOPORPARAMETRO           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="RUTAALERTAS                             " tabla="DISIMPO        " campo="CRUTAALERT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Ruta alertas                                                                                                                                                    " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="PARAMETROSCOMANDO                       " tabla="DISIMPO        " campo="PARCOMA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Parámetros                                                                                                                                                      " dominio="EXPRESIONSIMPLE               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ACCIONCONARCHIVOERRORES                 " tabla="DISIMPO        " campo="ACCCONERR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="= &quot;NADA&quot;                                                                                                                                                                                                                                                      " obligatorio="false" admitebusqueda="420" etiqueta="Con errores                                                                                                                                                     " dominio="COMBOACCIONCONARCHIVOERRORES  " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="RUTAERRORES                             " tabla="DISIMPO        " campo="CRUTAERR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Ruta errores                                                                                                                                                    " dominio="DIRECTORIO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="7" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="TIPOREGISTRO                            " tabla="DISIMPO        " campo="CTIPREG   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPOREGISTROEXPORTACION                 " tipodato="C         " longitud="3" decimales="0" valorsugerido="=&quot;LFI&quot;                                                                                                                                                                                                                                                        " obligatorio="true" admitebusqueda="424" etiqueta="Tipo registro importación                                                                                                                                       " dominio="COMBOTABLA                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="DELIMITADORES                           " tabla="DISIMPO        " campo="CDELIMI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Delimitadores                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="IGNORARINICIO                           " tabla="DISIMPO        " campo="IGNORINI  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Iniciales                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="IGNORARFINAL                            " tabla="DISIMPO        " campo="IGNORFIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Finales                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="IGNORARLINEASENBLANCO                   " tabla="DISIMPO        " campo="IGNORBLANC" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="= .T.                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="432" etiqueta="En blanco                                                                                                                                                       " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="BASEDEDATOS                             " tabla="DISIMPO        " campo="CBDATOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Destino                                                                                                                                                         " dominio="COMBOSUC                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="6" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="SOLOLINEASQUEEMPIEZANCON                " tabla="DISIMPO        " campo="CSOLOLIN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Procesa líneas que comiencen con                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="8" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="IGNORARLINEASQUEEMPIEZANCON             " tabla="DISIMPO        " campo="CLINIGNOR " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Ignora líneas que comiencen con                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="5" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="DETECCIONDETALLE                        " tabla="DISIMPO        " campo="DETECDET  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="25" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Detección detalle                                                                                                                                               " dominio="COMBOIMPOMETODODETALLE        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="AREAS                                   " tabla="DISIMPOAREA    " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Área                                                                                                                                                            " dominio="DETALLEITEMAREASIMPO          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="7" orden="15" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="ATRIBUTOS                               " tabla="DISIMPOATRI    " campo="ICOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Atributos                                                                                                                                                       " dominio="DETALLEITEMATRIBUTOSIMPO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="8" orden="16" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISENOIMPO                              " atributo="OBS                                     " tabla="DISIMPO        " campo="COBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOARCHIVOIMPORTACION                  " atributo="DESCRIPCION                             " tabla="TIPARCIMP      " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPARCIMP On DISIMPO.CTIPARCH = TIPARCIMP.cCod And  TIPARCIMP.CCOD != ''                                                                                                                                                                           " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPOREGISTROEXPORTACION                 " atributo="DESCRIPCION                             " tabla="TIPREGEXP      " campo="CDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="425" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPREGEXP On DISIMPO.CTIPREG = TIPREGEXP.cCod And  TIPREGEXP.CCOD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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